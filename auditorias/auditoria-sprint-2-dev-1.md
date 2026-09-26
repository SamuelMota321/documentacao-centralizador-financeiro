# Auditoria independente — Sprint 2, Dev 1

**Data da auditoria:** 26/09/2026  
**Escopo:** contribuições atribuídas a Dev 1 no backend e apoio de contrato/documentação em Sprint 2.  
**Repositórios consultados:** `documentacao-centralicador-financeiro` e `backend-centralizador-financeiro`.  
**Convenção de severidade:** não foi localizada escala de severidade do projeto; este relatório usa Critical / High / Medium / Low como convenção de auditoria.

## Resumo executivo

A documentação atribui a Dev 1 trabalho principal em S2-02, S2-03, backend de S2-05, domínio/API de S2-06 e S2-07; apoio de contrato em S2-04; participação obrigatória em testes backend de S2-08; e integração técnica em S2-09. O plano também exige que implementação, testes relevantes, revisão, documentação afetada, integração e evidências estejam concluídos ([Plano da Sprint 2](Plano_Divisao_Atividades_Sprint_2.html:75-81, 208-217)).

Foram verificados nove itens de planejamento: cinco estão Implemented, quatro estão Partial e nenhum foi classificado como Not implemented ou Cannot verify. Os pontos parciais são S2-02, S2-06, S2-08 e S2-09. Foram identificados três achados: lifecycle de conta arquivada conflita com a regra de conta ativa; a constraint de banco aceita uma condição `type` que o contrato/domain rejeitam; e os totais publicados para testes não fecham. A consolidação S2-09 também está incompleta no escopo verificável, com handoff de clientes pendente e artefatos backend presentes como alterações não commitadas no estado observado.

## Limitações da revisão

- O plano da Sprint permite mapear a responsabilidade de Dev 1, mas não há registro independente de aprovações de execução para todas as fases. O documento de fase 2 registra o handoff/auditoria de S2-02 e o plano técnico cita o commit `b61b205`; não se atribuiu autoria individual com base apenas em commits ou datas ([plano técnico](plano-implementacao-transactions.html:32-45)).
- O backend estava com alterações rastreadas e artefatos não rastreados no momento da revisão. As conclusões sobre esse estado referem-se à árvore de trabalho observada; não atribuem autoria ao Dev 1.
- A documentação delimita S2-04 como trabalho principal de Dev 2 e a contribuição de Dev 1 como apoio ao contrato. Web/mobile e seus testes não foram auditados.
- Testes de integração, REST/E2E, migrações e RLS não foram reexecutados: esses comandos usam PostgreSQL e alteram estado do banco de teste. Build e geração OpenAPI não foram executados porque geram/alteram artefatos. Os resultados citados para essas verificações são declarações históricas no relatório de consolidação backend, não resultados reproduzidos nesta auditoria.
- O relatório de consolidação não identifica o teste que explica a diferença entre os totais agregados e as suítes discriminadas; esse detalhe permanece sem verificação.

## Matriz de rastreabilidade

| Item aprovado | Escopo e critérios de aceite documentados | Evidência de implementação e documentação | Status |
|---|---|---|---|
| **S2-01 — Baseline e contratos** | Aprovar propostas e registrar especificação normativa; deixar S2-02 a S2-06 suficientemente precisos ([Plano](Plano_Divisao_Atividades_Sprint_2.html:88-95)). | A especificação registra: “baseline e propostas aprovados em 20/09/2026” e promove as propostas a decisões normativas para S2-02 a S2-06 ([especificação](especificacao-transactions.html:30-34)). O plano técnico aponta a especificação como contrato e separa as fases ([plano técnico](plano-implementacao-transactions.html:32-45)). | **Implemented** |
| **S2-02 — Domínio e persistência tenant-aware** | Modelar domínio, tabelas, migrations, constraints, índices e RLS; migration/RLS reproduzíveis e fail-closed; constraints/indexes devem impor invariantes aprovadas ([Plano](Plano_Divisao_Atividades_Sprint_2.html:97-105); prompt de fase 2: [linhas 86-96](prompts/sprint2/dev1/dev-1-sprint-2-fase-2-persistencia-transactions.md:86-96)). | A consolidação declara S2-02 implementado/verificado ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:13-15)). Porém, a constraint de condição só exige valor não vazio e operador `equals` para campos diferentes de descrição, sem restringir `type` a income/expense ([migration de fundação](../backend-centralizador-financeiro/prisma/migrations/202609200001_transactions_foundation/migration.sql:120-124)); o domínio rejeita outros valores ([category-rule.ts](../backend-centralizador-financeiro/src/modules/transactions/domain/category-rule.ts:249-255)). | **Partial — F2** |
| **S2-03 — Movimentações no backend** | Persistir entradas válidas do tenant, rejeitar campos inválidos, tornar transferências atômicas, negar combinações cross-tenant, garantir idempotência e alinhar OpenAPI ao REST ([prompt de fase 3](prompts/sprint2/dev1/dev-1-sprint-2-fase-3-movimentacoes-backend.md:75-84)). | Consolidação declara implementação e verificação por unit, integração e E2E ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:15, 41-54)); os testes unitários foram reexecutados nesta auditoria com sucesso. A validação de PostgreSQL/REST descrita ali não foi reproduzida (limitação acima). | **Implemented** |
| **S2-04 — Apoio de contrato dos clientes** | Responsabilidade principal de Dev 2; Dev 1 apoia o contrato. Critérios incluem não aceitar/manter dados de outro tenant ([Plano](Plano_Divisao_Atividades_Sprint_2.html:124-134)). | O plano de Sprint atribui expressamente “Developer 1 apoia o contrato” e responsabilidade principal a Developer 2 ([Plano](Plano_Divisao_Atividades_Sprint_2.html:124-126)); consolidação backend diz que clientes tipados devem ser regenerados/atualizados pelo Developer 2 ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:76)). A contribuição de contrato de Dev 1 não é contradita pela evidência consultada. | **Implemented — somente a fatia de apoio de Dev 1** |
| **S2-05 — Categorização e correção manual** | Backend implementa categorias/categorização/correção manual; incerteza explícita, ownership e comportamento conforme contrato ([Plano](Plano_Divisao_Atividades_Sprint_2.html:141-150); prompt de fase 4: [linhas 83-91](prompts/sprint2/dev1/dev-1-sprint-2-fase-4-categorizacao-regras.md:83-91)). | Consolidação declara categorias, categorização e correção manual implementadas e verificadas; a suíte E2E reporta fluxos correspondentes ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:17, 46, 84)). Sem contradição material identificada no escopo backend inspecionado. | **Implemented** |
| **S2-06 — Regras pessoais de categorização** | Regras criáveis/editáveis/ativáveis/desativáveis/removíveis; conflitos determinísticos; isolamento cross-tenant; condições e conta referenciada conforme contrato ([Plano](Plano_Divisao_Atividades_Sprint_2.html:152-164); prompt de fase 4: [linhas 83-91](prompts/sprint2/dev1/dev-1-sprint-2-fase-4-categorizacao-regras.md:83-91)). | Domínio limita condição `type` a income/expense e a especificação normativa diz “income ou expense” ([domain](../backend-centralizador-financeiro/src/modules/transactions/domain/category-rule.ts:249-255); [especificação](especificacao-transactions.html:153-160)). A migração S2-08 exige conta ativa em escrita de regra, mas archival de conta não verifica regras existentes ([migration](../backend-centralizador-financeiro/prisma/migrations/202609240001_s208_category_rule_contract/migration.sql:52-68); [use case](../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/deactivate-account.ts:22-30)). Ver F1 e F2. | **Partial — F1, F2** |
| **S2-07 — Idempotência, isolamento e auditoria** | Negar leituras/mutações cross-tenant; não vazar contexto; evitar duplicidade; preservar atomicidade e auditoria adequada ([Plano](Plano_Divisao_Atividades_Sprint_2.html:169-177); prompt de fase 5: [linhas 75-84](prompts/sprint2/dev1/dev-1-sprint-2-fase-5-isolamento-auditoria.md:75-84)). | Consolidação declara S2-07 implementado/verificado e documenta checks de migrations/RLS ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:19, 41-43)); esses checks não foram reproduzidos nesta auditoria. Sem achado de implementação adicional dentro do escopo de código revisado. | **Implemented** |
| **S2-08 — Testes e contratos** | Cobertura backend reproduzível para unit, integração, REST, migration, RLS e contrato; casos críticos com evidência; OpenAPI compatível; documentação atualizada ([Plano](Plano_Divisao_Atividades_Sprint_2.html:179-194); prompt de fase 6: [linhas 107-115](prompts/sprint2/dev1/dev-1-sprint-2-fase-6-testes-consolidacao.md:107-115)). | Consolidação discrimina 111 unit, 27 integração, 22 E2E e 4 contrato, soma 164, mas declara 165 testes em `npm test` ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:44-54)). Ver F3. | **Partial — F3** |
| **S2-09 — Integração, demonstração e revisão** | Consolidar backend, web, mobile, contrato, testes, documentação e demonstração; lint/testes/tipos/build passam e OpenAPI/migrations/instruções atualizados ([Plano](Plano_Divisao_Atividades_Sprint_2.html:196-205)). | Consolidação afirma que cobre somente backend e exclui clientes/demonstração; entrega de OpenAPI aos clientes fica para Developer 2 ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:7, 58, 76, 92-95)). No estado observado, backend tinha alterações locais rastreadas e migration/consolidação não rastreadas. O estado não comprova autoria nem integração final. | **Partial** |

## Achados

### F1 — Lifecycle de conta arquivada pode invalidar regra pessoal existente

**Severidade:** Medium — convenção de auditoria.  
**Item/critério:** S2-06; referência `accountId` deve ser conta ativa do mesmo tenant ([especificação](especificacao-transactions.html:153-160)).

**Evidência:**

- A migration verifica que conta de uma nova regra seja ativa ao inserir/atualizar a regra ([migration S2-08](../backend-centralizador-financeiro/prisma/migrations/202609240001_s208_category_rule_contract/migration.sql:52-68)).
- O trigger é definido para INSERT/UPDATE da tabela `category_rules`, não para archival em `accounts` ([migration S2-07](../backend-centralizador-financeiro/prisma/migrations/202609230001_s207_transactions_security_hardening/migration.sql:122-125)).
- O use case de desativação chama `accounts.deactivate` sem checar regras vinculadas ([deactivate-account.ts](../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/deactivate-account.ts:22-30)); o adapter marca `archived_at` ([repository](../backend-centralizador-financeiro/src/modules/accounts/adapters/outbound/prisma-accounts.repository.ts:122-130)).
- A própria migration S2-08 falha se encontra regra existente referenciando conta arquivada ([migration](../backend-centralizador-financeiro/prisma/migrations/202609240001_s208_category_rule_contract/migration.sql:3-16)).

**Gap e impacto:** criar regra por conta e depois arquivar essa conta pode produzir o estado que a migration rejeita; a regra também permanece associada a uma conta não ativa. A regra de escrita atual não define como a operação de archival deve manter o invariante ao longo do lifecycle.

**Correção sugerida:** definir e aprovar o comportamento de lifecycle antes de alterar código (por exemplo, impedir archival enquanto regra ativa a referencia, desativar/retirar regras vinculadas ou permitir referências históricas e ajustar o contrato/constraint). Implementar a alternativa aprovada de forma transacional e adicionar teste cobrindo criar regra → arquivar conta e a política escolhida.

### F2 — Constraint PostgreSQL não impõe valores aprovados para condição `type`

**Severidade:** Medium — convenção de auditoria.  
**Item/critério:** S2-02 e S2-06; S2-02 exige constraints que implementem invariantes aprovadas, e S2-06 aceita apenas as condições aprovadas. O contrato restringe `type` a `income` ou `expense` ([especificação](especificacao-transactions.html:153-157)).

**Evidência:**

- A constraint `category_rules_condition_check` verifica valor não vazio e operador; ela não valida os valores permitidos para `type` ([migration de fundação](../backend-centralizador-financeiro/prisma/migrations/202609200001_transactions_foundation/migration.sql:120-123)).
- O papel `cfi_runtime` recebe INSERT e UPDATE na tabela ([migration de fundação](../backend-centralizador-financeiro/prisma/migrations/202609200001_transactions_foundation/migration.sql:168-170)).
- O domínio, em contraste, rejeita qualquer valor de condição `type` além de income/expense ([category-rule.ts](../backend-centralizador-financeiro/src/modules/transactions/domain/category-rule.ts:249-255)).

**Gap e impacto:** uma escrita SQL aceita pela role runtime pode persistir `condition_field = 'type'` com valor fora do contrato. **Impacto inferido do código:** `CategoryRule.reconstitute` aplica o mesmo parser/normalizador do domínio e rejeita valor inválido; portanto, ler/reconstituir essa linha pode falhar ([category-rule.ts](../backend-centralizador-financeiro/src/modules/transactions/domain/category-rule.ts:89-110, 249-255)). O banco não impõe o invariante aprovado, divergindo da proteção requerida em S2-02.

**Correção sugerida:** adicionar constraint forward-only para valores permitidos de `condition_field = 'type'`, compatível com o contrato; cobrir valor inválido via teste de integração PostgreSQL executado com role autorizada e manter domínio, API, OpenAPI e migration alinhados.

### F3 — Evidência publicada de contagem de testes é inconsistente

**Severidade:** Low — convenção de auditoria.  
**Item/critério:** S2-08 exige evidência de cobertura reproduzível e relatório final com handoff claro ([prompt de fase 6](prompts/sprint2/dev1/dev-1-sprint-2-fase-6-testes-consolidacao.md:107-115)).

**Evidência:** a consolidação registra 111 unit, 27 integration, 22 E2E e 4 contract tests, que somam 164; na mesma tabela, `npm test` reporta 165 testes ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:44-54)).

**Gap e impacto:** o leitor não consegue reconciliar a cobertura agregada com a composição publicada, reduzindo a rastreabilidade da evidência de conclusão.

**Correção sugerida:** repetir a consolidação a partir dos relatórios atuais das suítes, identificar a suíte/caso que compõe a diferença ou corrigir o total, e registrar os comandos e contagens reproduzíveis.

## Verificações executadas nesta auditoria

Executadas no repositório backend. Os comandos abaixo não alteraram arquivos rastreados; não foram executadas suítes com escrita no banco.

| Comando | Resultado |
|---|---|
| `npm run test:unit` | Passou: 24 arquivos, 111 testes. |
| `npx vitest run test/contract/openapi.contract.spec.ts` | Passou: 1 arquivo, 4 testes. |
| `npm run lint` | Passou (exit code 0). |
| `npx tsc --noEmit` | Passou (exit code 0); usado sem o script `typecheck`, que gera Prisma Client. |
| `npm run prisma:validate` | Passou; schema Prisma válido. |
| `git diff --check` | Passou (exit code 0); Git emitiu avisos de normalização LF/CRLF. |
| `git status --short` | Mostrou alterações rastreadas e arquivos não rastreados no backend; limita a atribuição/integridade do estado integrado. |

A consolidação existente também declara sucesso para integration, E2E, migration/RLS, typecheck, build e geração OpenAPI ([consolidação](../backend-centralizador-financeiro/docs/sprint-2-dev1-backend-consolidation.md:41-58)); esses resultados são citados como documentação, não como verificações executadas nesta auditoria.



