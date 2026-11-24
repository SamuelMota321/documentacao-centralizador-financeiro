# Sprint 4 — execução local de testes em 23/11/2026

## Escopo e ambiente

Verificação executada nos quatro repositórios locais. Revisões: backend `9fc5a1f`, web `7cf4602`, mobile `3fec9a7` e documentação `c705d9b`. O backend tinha alterações locais não commitadas de HU-009 e HU-012; a documentação tinha o handoff HU-009 não commitado. Web e mobile estavam sem alterações rastreadas antes e depois dos testes. Não houve commit nem alteração de código de produto nesta execução.

Node `v22.23.5`, npm `10.9.9` e PostgreSQL 17 em dois contêineres temporários acessíveis somente em localhost. Os testes usaram fixtures sintéticas. Não houve consulta ao Pluggy Sandbox, QStash, R2, banco compartilhado ou ambiente publicado. Os contêineres foram removidos após a verificação.

## Resultados

| Área | Comando/verificação | Resultado |
|---|---|---|
| Backend | `npm run test:unit` | 39 arquivos, 180 testes aprovados. |
| Backend | `npm test`, com `DATABASE_URL`, `TEST_DATABASE_URL` e `DIRECT_DATABASE_URL` apontando ao PostgreSQL descartável | 51 de 55 arquivos aprovados; 255 testes aprovados, 3 falharam e 2 suítes tiveram erro adicional na limpeza final (`afterAll`). Detalhes abaixo. |
| Backend Sprint 4 | `npx vitest run` nos specs de sincronização, leitura de investimentos, adapter Pluggy, patrimônio, integração de investimentos/patrimônio, E2E de patrimônio e contrato OpenAPI | 8 arquivos, 36 testes aprovados. |
| Backend | `npm run prisma:validate`, `npm run typecheck`, `npm run lint`, `npm run build`, `npm run openapi:generate` | Aprovados. O teste de contrato OpenAPI também passou na suíte focada. |
| Banco | `npm run db:migrate:deploy`; `npm run db:verify-migrations` | 19 migrations aplicadas e histórico, ownership, RLS e papéis verificados no banco descartável. |
| Banco | `scripts/database/verify-rls.sql` via `psql` dentro do contêiner, como `cfi_test` | Aprovado. O script npm `db:verify-rls` não foi usado porque `psql` não está instalado no host; foi executado o mesmo SQL diretamente no contêiner. |
| Banco | `scripts/database/verify-pluggy-sync.sql` em segundo banco limpo, como `cfi_test` | Aprovado; transação de fixtures sintéticas terminou com `ROLLBACK`. |
| Web | `npm test`, `npm run lint`, `npm run typecheck`, `npm run build` | 50 arquivos e 754 testes aprovados; lint, tipos e build aprovados. A primeira tentativa de build falhou pela restrição de rede ao Google Fonts; a repetição com acesso de rede passou. |
| Mobile | `npm test`, `npm run typecheck`, `EXPO_NO_TELEMETRY=1 EXPO_OFFLINE=1 npx expo export --platform android` | 31 arquivos e 481 testes aprovados; tipos e export Android aprovados. A primeira tentativa de export falhou ao tentar criar `~/.expo` no sandbox; a repetição sem telemetria e offline passou. |
| Formatação | `npm run format:check` no backend | Falhou em 16 arquivos já existentes, principalmente `agents.md`, ingestão OFX e categoria/transações. O check dirigido de `src/modules/investments`, `src/modules/patrimony`, sincronização e testes novos passou. |
| Diff | `git diff --check` no backend e na documentação | Aprovado. |

## Falhas da suíte backend completa

| Caso | Observação reproduzida | Encaminhamento |
|---|---|---|
| Arquivamento de conta com regra ativa, em `test/integration/prisma-accounts.repository.integration.spec.ts` e `test/e2e/account-maintenance.e2e.spec.ts` | A função em `prisma/migrations/202609260001_s2_category_rule_guards/migration.sql` usa `RAISE EXCEPTION '...'` junto de `USING MESSAGE = '...'`, gerando erro PostgreSQL `42601` (`RAISE option already specified: MESSAGE`). A API devolve 500 em vez de 409. | Dev 1: corrigir em mudança própria de contas/migration e repetir os dois testes; não foi alterado neste ciclo de verificação. |
| Upload OFX acima do limite, em `test/e2e/ingestion.e2e.spec.ts` | A exceção `PayloadTooLargeException` foi registrada e a API devolveu 500 em vez de 413. O filtro de ingestão mapeia `MulterError`, mas não essa exceção. | Dev 1: corrigir o tratamento HTTP e repetir o teste; fora do escopo HU-009/HU-012. |
| Limpeza final de `test/integration/ofx-ingestion.integration.spec.ts` e `test/e2e/ingestion.e2e.spec.ts` | Após executar os testes, as suítes tentam `DELETE FROM audit_records` como `cfi_test`; o papel tem apenas `SELECT, INSERT` nessa tabela e recebe `permission denied`. | Dev 3/Dev 1: ajustar a limpeza das fixtures sem ampliar permissões de produção ou enfraquecer RLS; repetir as suítes. |

Essas falhas não devem ser rotuladas como aprovação da suíte completa, nem atribuídas automaticamente às alterações locais de investimentos e patrimônio. Os testes focados dessas entregas passaram no mesmo ambiente.

## Limites e próximos passos

- HU-011 ainda não tem implementação para testar. As telas HU-009/HU-011/HU-012 em web e mobile e o fluxo completo de sincronização nos dois clientes ainda não foram exercidos; testes unitários e builds não comprovam essas experiências.
- A disponibilidade concreta dos campos de investimento requer um novo Item Pluggy Sandbox com consentimento autorizado. A execução diária, retries e estados em QStash real também não foram verificados nesta rodada.
- Não houve teste manual em navegador/dispositivo, smoke de ambiente publicado nem aceite independente de Dev 3. A etapa de consolidação deve distinguir backend local verificado de Sprint 4 integralmente aceita.
- Antes da próxima execução completa, corrigir ou classificar as três causas de falha acima e preservar o estado exato dos repositórios. Não aplicar migrations ou testes a bancos compartilhados sem autorização específica.

## Revalidação após correções locais — 23/11/2026

Esta seção registra uma execução posterior no mesmo dia; os resultados iniciais acima permanecem como histórico. Não houve commit nem uso de serviços externos.

- Foi adicionada `202611230001_fix_account_archive_guard_message`, uma nova migration que substitui a função de arquivamento sem duplicar a opção `MESSAGE` e preserva o identificador de conflito usado pelo repositório. A migration histórica aplicada não foi editada.
- O filtro HTTP de ingestão passou a responder `413` também para `PayloadTooLargeException`. As duas suítes OFX deixaram de tentar excluir registros de auditoria com `cfi_test`; suas fixtures ficam no banco descartável até o descarte do contêiner.
- `npm run db:migrate:deploy` aplicou as **20 migrations** em PostgreSQL 17 limpo. `npm run db:verify-migrations`, `scripts/database/verify-pluggy-sync.sql` em banco limpo e `scripts/database/verify-rls.sql` passaram. O SQL de RLS foi executado via `psql` no contêiner, pois o binário não está instalado no host.
- `npm test` passou integralmente: **55 arquivos, 258 testes**. Uma segunda execução no mesmo banco também passou com **55 arquivos, 258 testes**, verificando que as fixtures OFX remanescentes não interferiram nessa repetição.
- `npm run prisma:validate`, `npm run typecheck`, `npm run lint`, `npm run build` e `git diff --check` passaram.
- O `npm run format:check` da rodada inicial continua como pendência separada de 16 arquivos com formatação anterior. Nenhuma formatação ampla foi aplicada, para preservar o escopo das correções funcionais.
- Depois da revisão final do diff, `npm run lint`, `npm run test:unit` (39 arquivos, 180 testes) e `git diff --check` passaram novamente. A tentativa de formatação ampla foi revertida por gerar alterações extensas sem relação funcional, inclusive em `agents.md`.

O risco residual da limpeza OFX é o acúmulo de fixtures se `TEST_DATABASE_URL` apontar para um banco persistente. Esta execução usou e descartou um banco exclusivo para testes; em ambiente persistente, preparar limpeza isolada sem dar permissão `DELETE` à aplicação ou ao papel `cfi_test`.
