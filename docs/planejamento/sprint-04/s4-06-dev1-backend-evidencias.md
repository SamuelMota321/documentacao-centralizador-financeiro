# S4-06 — rastreabilidade e evidências do backend (Developer 1)

Data: 25/11/2026. Responsável: Developer 1. Destinatários: Developers 2 e 3. Escopo: apenas backend das HU-008, HU-009, HU-011 e HU-012. Esta entrega não constitui o aceite de Developer 3 nem a definição de pronto da Sprint 4.

## Base verificada e fronteira de responsabilidade

- Backend: `main` em `b5826a3` antes desta contribuição. Documentação: `main` em `3ce74f3`. Ambos estavam limpos e iguais ao `origin/main` consultado em 25/11. As alterações de diagnóstico e este documento foram preparados a partir dessas revisões.
- O plano da Sprint 4 atribui domínio, API, persistência, jobs, autorização, auditoria e RLS do backend a Dev 1; interfaces web/mobile a Dev 2; cenários independentes, revisão cruzada, integração e consolidação de evidências a Dev 3.
- Fontes de contrato: PRD 1.4 HU-008/HU-009/HU-011/HU-012 e RN-007/RN-010/RN-014/RN-015, Arquitetura, `s4-01-dev1-backend-baseline-e-decisoes.md`, `s4-03-dev1-contrato-investimentos.md`, `s4-04-dev1-contrato-alocacao.md`, plano da Sprint 4 e `openapi/openapi.json` do backend.
- Dev 2 informou em `s4-06-dev2-evidencias-clientes.md` testes web contra o snapshot OpenAPI de `b5826a3`. O checkout web disponível localmente está em `7cf4602` e o mobile em `3fec9a7`, anteriores às revisões daquele handoff. Não há verificação independente das implementações recentes de cliente neste checkout.
- Após autorização específica para integrar os históricos, foram tentados merges de `origin/main` em web e mobile. Ambos apresentaram conflitos em código/testes de Dev 2; ambos foram abortados. Nenhuma alteração ou commit de cliente permaneceu. Web permanece 1 commit à frente e 8 atrás; mobile, 2 à frente e 3 atrás do `origin/main` atualizado.

## Matriz requisito → código → teste → persistência/contrato

Os testes abaixo foram executados com fixtures sintéticas e PostgreSQL 17 descartável. “Local” não significa prova de comportamento no Pluggy Sandbox ou QStash real.

| Critério backend | Implementação e OpenAPI | Teste / migração / RLS | Estado e limite |
|---|---|---|---|
| HU-008: aceitar solicitação manual e consultar execução/última reconciliação | `src/modules/sync/application/pluggy-synchronization.ts`, `adapters/inbound/pluggy-sync.controller.ts`; POST, GET por run e GET `/latest` em OpenAPI | `pluggy-synchronization.spec.ts` e `test/contract/openapi.contract.spec.ts` | Verificado com testes sintéticos; E2E com cliente e Item real pendente. |
| HU-008: agenda diária às 12h de São Paulo, chave por conexão/dia | `enqueueDaily`, `createDaily`, `scripts/qstash/ensure-pluggy-daily-schedule.ts`; rota interna excluída da OpenAPI pública | `prisma/migrations/202611210001_s402_pluggy_sync/migration.sql`, `scripts/database/verify-pluggy-sync.sql` | Idempotência do banco verificada; agenda QStash real não consultada/ativada. |
| HU-008: impedir runs simultâneos e replays | Índice único de run ativo; `claim` e chave de dados por conexão; jobs contêm `runId`, `tenantId`, `userId` | Spec de sincronização, regressão SQL e suíte completa | Verificado nos cenários locais. Lease fixo de dez minutos, sem renovação, deixa risco de sobreposição se uma coleta exceder esse prazo. |
| HU-008: retries, falha, `partial` e `action_required` consultáveis | `processJob`, `pluggy-sync.types.ts`, publicador QStash; seis estados em OpenAPI | Spec de sincronização cobre falha transitória, limite de três retries e coleta parcial | Verificado com mocks; entrega real, atualização de Item e recuperação após reautorização pendentes. |
| HU-008: consentimento, propriedade e isolamento | Revalidação da conexão/consentimento antes da coleta; filtro por proprietário e tenant; assinatura do worker | Specs, políticas RLS da migração S4-02, `verify-rls.sql` | Verificado localmente; consentimento de novo Item Sandbox não testado. |
| HU-009: listar posições paginadas e total quando seguro | `src/modules/investments/application/investment-read.service.ts`, controller e `GET /api/v1/investments` em OpenAPI | Spec do serviço, integração `investment-read.repository.integration.spec.ts`, contrato OpenAPI | Verificado localmente; total multimoeda não é inventado. |
| HU-009: quantidade/saldo, investido, resultado, instituição e referência quando fornecidos | `pluggy-api.client.ts` mapeia campos; serviço publica `null` e `missingFields` | Specs do adapter e do serviço; migração `202611220001_s403_investment_read_contract` guarda status e proveniência | Verificado com respostas sintéticas; presença real dos campos por conector pendente. |
| HU-009: movimentos e renda fixa | Leitura paginada de movimentos; taxa, índice e vencimento separados; lista vazia completa distinta de indisponibilidade | Specs de serviço e integração; GET `/investments/{id}/movements` em OpenAPI | Verificado localmente; disponibilidade real por conector pendente. |
| HU-009: origem, identificador, tipo, moeda, qualidade, ausência e defasagem | Serviço informa `source`, `externalId`, `assetType`, `currencyCode`, `referenceDate`, `dataQuality`; fresco/antigo/desconhecido | Specs cobrem coleta incompleta, referência ausente/antiga e acesso cross-tenant; RLS das tabelas de investimento | Verificado localmente. A janela de frescor de 96 h ainda requer aceite de Produto registrado. |
| HU-011: base elegível e percentuais com cobertura parcial | `allocation()` calcula sobre todas as posições antes da paginação; considera apenas saldo positivo ACTIVE, moeda e coleta atuais/completos | `investment-read.service.spec.ts`, contrato OpenAPI; reutiliza leitura/RLS da HU-009 | Verificado localmente; conexões indisponíveis não geram contagem fictícia. |
| HU-011: agrupamentos por classe, instituição e moeda | Seis classes `assetType`; `OTHER`/desconhecido vira `UNCLASSIFIED`; nome de instituição exato ou `null`; denominador por moeda | Spec cobre classes, instituição ausente, moedas e exclusões | Verificado localmente. |
| HU-011: arredondamento, fonte e referência dos grupos | Percentual *half-up* com uma casa sem fechamento forçado; membros guardam `id`, `source` e `referenceDate` | Spec de serviço e esquema `investment-openapi.schema.ts` | Verificado localmente; apresentação pelo cliente depende de Dev 2. |
| HU-012: cadastrar bens com tipo, descrição, valor, avaliação e fonte | `src/modules/patrimony/domain/patrimony.ts`, serviço, controller; POST/GET/PATCH em OpenAPI | `patrimony.spec.ts`, `test/e2e/patrimony.e2e.spec.ts`; migração `202611210003_s405_manual_patrimony_tables` | Verificado localmente. |
| HU-012: financiamento/passivo, saldo e associação opcional ao bem | Serviço valida associação e usa FK composta por tenant; coleções `assets`, `financings`, `liabilities` | E2E e `test/integration/patrimony.integration.spec.ts` | Verificado localmente, inclusive associação de outro tenant negada. |
| HU-012: histórico, auditoria e isolamento | Revisões e auditoria mínima na mesma transação tenant-aware; endpoint `/history`; RLS e papéis nas migrações S4-05 | Integração cobre versões, rollback, auditoria e isolamento; `verify-rls.sql` | Verificado localmente; fluxo manual no cliente continua com Dev 2. |

## Correção técnica desta contribuição

O handoff de Dev 2 registra L-01: `POST /connections/pluggy/completions` respondeu `503 INTEGRATION_UNAVAILABLE` após o widget no Sandbox, e L-02: as causas internas eram descartadas. A conclusão passa por `getItem` e `listConsents`; ela **não publica um job QStash**. Sem executar o Sandbox, não há evidência para atribuir aquele 503 à Pluggy, à configuração ou a um formato de resposta específico.

Para tornar uma próxima ocorrência diagnosticável, o adapter Pluggy agora classifica falhas das consultas de Item/consentimento e da autenticação em códigos fechados (`missing_config`, `network`, `http_status`, `invalid_response`, `unknown`). O publicador QStash classifica configuração ausente e falha de publicação. O filtro HTTP mantém o mesmo `503` genérico ao cliente e grava apenas integração, operação, código e status HTTP quando aplicável. Não grava mensagens brutas, caminho com Item ID, corpo, credenciais ou payload. Testes novos verificam classificação e ausência de mensagem sensível nos logs e na resposta. **L-02 está coberta localmente; L-01 permanece aberta.**

## Comandos e resultados desta rodada

O banco foi criado em contêiner PostgreSQL 17 exclusivo, com volume temporário em memória, host `127.0.0.1:32768`, papéis `cfi_migrator`, `cfi_runtime` e `cfi_test`, e credenciais geradas apenas para este teste. Os três URLs foram validados como locais antes da suíte. O `.env` do repositório apontava a destinos não locais ou indeterminados e não foi usado para testes de banco. Nenhum serviço Sandbox, QStash real, R2 ou banco compartilhado foi chamado.

| Comando / verificação | Resultado |
|---|---|
| `npx vitest run` nos specs de adapter Pluggy, QStash, filtro, ciclo de conexão, sincronização, investimentos, patrimônio e contrato OpenAPI | Passou: 8 arquivos, 42 testes na primeira rodada. Após ajuste de classificação QStash, 3 specs focados passaram com 6 testes. A regressão adicional de falha do publicador passou (1 arquivo, 3 testes). |
| `npm run prisma:validate` | Passou. |
| `npm run typecheck` | Passou; repetido após o ajuste final. |
| `npm run lint` | Primeira execução falhou por import usado apenas como tipo no teste novo; corrigido. Reexecução passou, inclusive após o ajuste final. |
| `npm run build` | Passou. |
| `npm run openapi:generate` | Falhou com `EPERM` na criação do socket local do CLI `tsx`; limitação deste ambiente. |
| `node --import tsx scripts/generate-openapi.ts` e `git diff --exit-code -- openapi/openapi.json` | Passaram; OpenAPI gerada igual à versionada. |
| `npm run db:migrate:deploy` | Passou no banco descartável: 20 migrations aplicadas. A primeira tentativa no ambiente restrito falhou por acesso ao socket local; reexecução com acesso ao contêiner passou. |
| `npm run db:verify-migrations` | Passou: 20 migrations, ownership, RLS e papéis verificados. |
| `psql -U cfi_test -d cfi -v ON_ERROR_STOP=1 -f /workspace/scripts/database/verify-rls.sql` no contêiner | Passou; transação terminou em `ROLLBACK`. `npm run db:verify-rls` não foi usado porque não há `psql` no host; foi usado o mesmo SQL. |
| Mesmo `psql` com `verify-pluggy-sync.sql`, antes dos testes persistentes | Passou; fixtures sintéticas revertidas com `ROLLBACK`. |
| `npm test` com os três URLs locais | Passou após o ajuste final: **57 arquivos, 268 testes**. |
| API local com ambiente limpo: `GET /api/v1/health/live`, `/health/ready`, `/openapi.json` | `200` nos três; saúde `ok`; OpenAPI com 33 caminhos, oito relativos às rotas dessas histórias. Processo encerrado após o smoke. |
| `git diff --check` e inspeção de arquivos/relatórios/logs temporários | Diff limpo. Busca limitada por chaves privadas, Bearer tokens longos e credenciais literais longas não encontrou correspondências nos arquivos versionados inspecionados nem nos logs locais desta rodada. |

O teste local não comprova execução da agenda QStash, disponibilidade real de investimentos por conector, autenticação cliente ponta a ponta ou aceite de Dev 3. Não há dado financeiro real nas fixtures criadas nesta rodada. A busca de segredos é por padrões conhecidos; não equivale a auditoria de todos os logs externos.

## Handoff a Developer 2

- HU-008: `POST /connections/{id}/sync-runs` retorna `202` e ponteiros da execução; GET por run e `/latest` expõem estados e última reconciliação. `action_required` libera a vaga ativa; após reautorização, uma nova execução deve ser solicitada. `partial` traz apenas motivos seguros. L-01 impede validar o fluxo com conexão Sandbox; o backend ainda precisa confirmar o comportamento do widget em modo de atualização (L-05).
- HU-009: posições e movimentos são paginados; `total` da página é contagem, enquanto `portfolio.total` monetário pode ser `null`. Moedas não são convertidas. Campos ausentes não viram zero; referência e qualidade precisam permanecer visíveis. Não existe `GET /investments/{id}`; o limite de detalhe de carteiras grandes (L-03) exige decisão de contrato.
- HU-011: usar `portfolio.allocation` calculada antes da paginação; exibir cobertura, exclusões e uma composição por moeda. Barras usam `amount/denominatorAmount`, não o percentual arredondado. `UNCLASSIFIED` e instituição `null` têm rótulos definidos no handoff HU-011.
- HU-012: três coleções em `/patrimony/{collection}`, com criação, listagem, leitura, edição e histórico. Não há exclusão, Idempotency-Key na criação ou controle de versão no PATCH; L-04 precisa de decisão Dev 1/Produto antes de ampliar o contrato.
- A revisão efetiva dos clientes recentes depende da resolução dos merges com conflitos por Dev 2. Nenhuma afirmação de integração atual deve ser inferida dos checkouts locais anteriores.

## Handoff a Developer 3: lacunas, donos e aceite

| Lacuna | Impacto | Dono / próximo passo |
|---|---|---|
| L-01: completion retorna 503 no Sandbox; causa ainda não observada após a instrumentação | Bloqueia E2E com investimentos e sync reais | Dev 1: reproduzir apenas em ambiente autorizado, ler os códigos seguros do log e propor correção específica. |
| L-05: atualização de Item e retomada após reautorização | `action_required` sem prova ponta a ponta | Dev 1 + Dev 2; Dev 3 valida o fluxo após evidência autorizada. |
| Lease do worker de dez minutos sem renovação | Pode haver sobreposição de workers em coleta longa | Dev 1: plano arquitetural separado com duração/heartbeat e regressão de concorrência; Dev 3 não aceitar concorrência sem ressalva. |
| L-03: detalhe sem rota por ID | Carteira com mais de 500 posições pode não abrir detalhe | Dev 1 + Produto: decidir extensão do contrato. |
| L-04: sem idempotência/versionamento/exclusão patrimonial | Duplicação ou sobrescrita em concorrência | Dev 1 + Produto: decidir semântica antes de alterar API/persistência. |
| L-06: frescor de 96 h sem aceite de Produto registrado | Regra observável ainda não confirmada | Produto: confirmar ou revisar critério; Dev 1 ajusta somente após decisão. |
| Merges web/mobile conflitaram e foram abortados | Checkouts locais não representam os clientes recentes | Dev 2: resolver os conflitos e repetir contratos/fluxos; Dev 3 consolida evidência. |
| Agenda QStash, Item consentido e telas mobile/fluxos manuais | Não há prova integral da Sprint 4 | Dev 1 para backend em ambiente autorizado; Dev 2 para clientes; Dev 3 para aceite conjunto. |

**Backend Dev 1 verificado localmente:** critérios implementados com testes sintéticos, suíte completa, OpenAPI, migrations, RLS e smoke local conforme resultados acima, com as ressalvas indicadas. **Sprint 4 integralmente verificada:** não declarada; depende das evidências e decisões dos três responsáveis.
