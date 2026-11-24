# S4-03 / HU-009 — contrato de leitura de investimentos (Dev 1)

Data: 2026-11-22. Escopo: backend, dados Pluggy autorizados por Item e consentimento ativo com `INVESTMENTS` e `INVESTMENTS_TRANSACTIONS`. Este registro descreve o código local; não comprova disponibilidade em um novo Item Sandbox nem aceite de Dev 3.

## API para Dev 2

- `GET /api/v1/investments?page=1&pageSize=20`: carteira das conexões Pluggy pertencentes ao usuário autenticado e ao tenant. `portfolio` contém `availability` (`complete`, `partial`, `unavailable`), `total`, `totalsByCurrency`, `referenceDate` e disponibilidade por `connectionId`. `positions` é paginada; `total` é o número de posições, não um valor monetário.
- `GET /api/v1/investments/{id}/movements?page=1&pageSize=20`: movimentações da posição autorizada. `availability=complete` com lista vazia significa nenhuma movimentação na coleta completa; `unavailable` significa que a coleta não comprovou a lista. ID inexistente ou de outro usuário/tenant retorna 404.
- Campos monetários e quantidade são strings decimais; opcionais ausentes são `null` e constam em `missingFields`. Cada posição inclui `source=pluggy`, `externalId`, `assetType`, `providerStatus`, `currencyCode`, `referenceDate` e `dataQuality` com disponibilidade e frescor. Movimentações não têm moeda própria na operação Pluggy mapeada; `currencyCode` é `null`, sem inferência pela posição.
- `investedAmount` mapeia `amountOriginal`; `resultAmount` mapeia `amountProfit`; `balance` é o saldo líquido atual. Para renda fixa, `rate`, `rateType`, `fixedAnnualRate` e `maturityDate` são preservados separadamente, sem cálculo de rentabilidade.
- `total` da carteira usa somente `balance` de posições `ACTIVE`, após coleta completa e referência atual. `PENDING` aparece na lista, mas não entra na soma; `TOTAL_WITHDRAWAL` não entra. Quando há moedas diferentes, valores ausentes, dados antigos ou cobertura incompleta, `total` é `null`. `totalsByCurrency` só é preenchido quando todas as posições elegíveis permitem soma segura. Sem posição ativa, `total` é `null` e a lista vazia expressa carteira sem posições confirmadas.
- Frescor `current`: referência da posição dentro de 96 horas, coleta completa e registro observado nessa execução. `stale`: referência mais antiga ou execução posterior sem coleta completa. `unknown`: referência ausente/futura ou registro anterior à migração sem execução observada. Nunca usar a data do Item como substituta silenciosa da data da posição.

## Persistência e limites

A nova migração acrescenta `status`, `fixed_annual_rate` e `last_seen_run_id` às posições; `last_seen_run_id` e valor opcional às movimentações; e indicadores de coleta completa à execução. O backend busca páginas do provedor fora da transação de banco e publica posições, movimentações e estado final em uma transação tenant-aware. Uma tentativa interrompida não substitui o último snapshot completo. Dados existentes sem proveniência de execução podem ser exibidos com frescor desconhecido, nunca incluídos no total atual.

Antes de publicar, a transação bloqueia a conexão e revalida proprietário, status, prazo e produtos do consentimento. Se o consentimento mudou, não grava a coleta e encerra a execução como parcial com motivos seguros de indisponibilidade.

Não há conversão cambial, cálculo HU-010/HU-013 nem inferência de campos opcionais. O contrato oficial da Pluggy informa que `amountProfit` pode ser nulo em conectores Open Finance e que `institution` depende do conector. A disponibilidade concreta dos campos em um novo Item Pluggy Bank Sandbox ainda requer validação autorizada. A OpenAPI versionada é a referência de nomes, tipos e respostas HTTP.

## Evidência para Dev 3

- Fixtures sintéticas: posições completas e parciais, renda fixa, moedas diferentes, `PENDING`, opcionais nulos, ausência de consentimento, referência antiga/desconhecida, movimento sem valor e publicação interrompida.
- Verificar autenticação da rota, propriedade da conexão, 404 para posição alheia, RLS, paginação e distinção entre lista vazia confirmada e indisponibilidade.
- Executar integração Sandbox somente com novo Item e consentimento explicitamente autorizados; registrar presença/ausência por campo sem copiar payload financeiro. Validar também a transição real de Item/produto e a data de referência por conector.

Comandos locais: `npm run prisma:validate`, `npm run typecheck`, `npm run lint`, `npm run openapi:generate` e testes focados de `src/modules/investments`, sincronização, adapter Pluggy, contrato OpenAPI e `test/integration/investment-read.repository.integration.spec.ts` em PostgreSQL descartável com `DATABASE_URL` para `cfi_runtime` e `TEST_DATABASE_URL` para `cfi_test`.

## Validação local desta contribuição

- `npm run prisma:validate`, `npm run typecheck`, `npm run lint` e `npm run openapi:generate`: passaram.
- Quatro arquivos de testes focados, 25 testes sintéticos: passaram. Teste de integração de repositório em PostgreSQL 17 descartável, 4 casos: passaram, incluindo isolamento/RLS, publicação atômica, rollback e revogação de consentimento.
- No worktree que também continha a HU-012 local, as 19 migrations aplicaram e o verificador de histórico/roles passou. O verificador RLS passou. A regressão SQL de sincronização passou em banco limpo; sua primeira execução no mesmo banco após fixtures persistentes falhou por supor uma única conexão elegível, não por falha da HU-009.
- Nenhuma chamada ao Pluggy Sandbox, QStash real, banco compartilhado ou cliente web/mobile foi feita. A aceitação independente de Dev 3 e a validação por campo no novo Item Sandbox permanecem pendentes.

### Revisão do commit isolado de HU-009 — 23/11/2026

Uma cópia do índice contendo somente a HU-009, sem HU-012 e sem as correções OFX/contas, passou em `prisma:validate`, `typecheck`, `lint` e `build`. A OpenAPI gerada nessa cópia coincide exatamente com a versão preparada para o commit. Quatro specs sintéticos passaram (24 testes); a integração de investimentos passou (4 testes) em PostgreSQL 17 descartável. As 17 migrations da cópia aplicaram; o verificador de migrations e o SQL de RLS passaram. Nenhuma credencial, Item ou payload financeiro externo foi usado.
