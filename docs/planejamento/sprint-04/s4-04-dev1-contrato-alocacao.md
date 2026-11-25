# S4-04 / HU-011 — contrato backend de alocação (Dev 1)

Data: 2026-11-24. A decisão de Produto para classe, base, moedas, instituição e arredondamento foi aprovada pelo usuário antes desta implementação. Esta contribuição não implementa as telas de Dev 2 nem representa o aceite independente de Dev 3.

## Regras aprovadas

- A classe é o `assetType` da posição Pluggy quando seu valor é `FIXED_INCOME`, `EQUITY`, `ETF`, `MUTUAL_FUND`, `COE` ou `SECURITY`. `OTHER` e valores desconhecidos formam `UNCLASSIFIED` (rótulo cliente: “Não classificado”). `subtype` nunca determina a classe. A [referência oficial Pluggy](https://docs.pluggy.ai/en/reference/investment/investments-retrieve) define `type` como classe e `balance` como saldo líquido atual.
- Só entram no cálculo posições `ACTIVE` com `balance > 0`, `currencyCode` conhecido, `dataQuality.availability=complete` e `dataQuality.freshness=current`. Os valores são somados em centavos inteiros. Posições conhecidas excluídas são contadas; conexões indisponíveis aparecem em `portfolio.connections`, mas suas posições desconhecidas não entram na contagem.
- Cada moeda tem denominador independente: soma dos `balance` elegíveis naquela moeda. Não há conversão ou percentual entre moedas. Sem denominador positivo, `allocation.availability=unavailable` e `currencies=[]`.
- A instituição é agrupada por `institutionName` exato, sem normalizar nomes parecidos. Valor ausente vira `null` (rótulo cliente: “Instituição não informada”).
- O percentual de cada grupo é `saldo do grupo / denominador da moeda × 100`, arredondado *half-up* para uma casa decimal. Não há ajuste artificial para fazer as linhas somarem 100,0%. Barras devem usar os valores exatos `amount` e `denominatorAmount`, não o percentual arredondado.

## API e cobertura

`GET /api/v1/investments` preserva a lista `positions` paginada e acrescenta `portfolio.allocation`, calculada sobre todas as posições autorizadas antes da paginação. Não há rota, dependência, tabela ou permissão nova.

| Campo | Semântica |
|---|---|
| `basis` | Valor fixo `active_current_complete_positive_balance`. |
| `availability` | `complete` somente se há denominador positivo, todas as conexões estão completas e nenhuma posição conhecida foi excluída; `partial` se há denominador mas cobertura incompleta ou exclusões; `unavailable` sem denominador positivo. |
| `knownPositionCount`, `includedPositionCount`, `excludedKnownPositionCount` | Cobertura apenas das posições retornadas pelas conexões autorizadas. Não estimam posições de conexões indisponíveis. |
| `excludedByReason` | Contagens exclusivas, pela primeira condição aplicável: `incomplete_or_stale`, `non_active`, `non_positive_balance`, `unknown_currency`. A soma equivale a `excludedKnownPositionCount`. |
| `currencies[]` | `currencyCode`, `denominatorAmount`, `byClass[]` e `byInstitution[]`. Cada grupo traz `amount`, `percentage` (string com uma casa) e `positions[]` com `id`, `source` e `referenceDate`. |
| `byClass[].assetClass` | Uma das seis classes reconhecidas ou `UNCLASSIFIED`. |
| `byInstitution[].institutionName` | Nome exato ou `null` para ausência. |

`portfolio.availability`, `portfolio.total`, `portfolio.totalsByCurrency`, `portfolio.referenceDate` e `portfolio.connections` mantêm as regras da HU-009. O total HU-009 pode ser `null` mesmo quando uma alocação parcial tem denominador: o denominador é declarado como base elegível da composição, nunca como total comprovado da carteira. A OpenAPI versionada define nomes e tipos da resposta.

O modelo HU-009 exige `balance` nas posições persistidas. Portanto, as contagens da alocação abrangem somente posições conhecidas nesse modelo; um registro do provedor sem saldo que não tenha sido publicado não pode ser contado individualmente. A disponibilidade da conexão continua sendo necessária para explicar cobertura incompleta.

## Handoff e validação

- **Dev 2:** apresentar o estado `partial` e as exclusões, inclusive a disponibilidade por conexão; usar uma composição por moeda. Para detalhes de origem e referência, usar os membros dos grupos. `UNCLASSIFIED` e instituição `null` recebem os rótulos acima. A lista de posições segue paginada; não calcular percentual apenas da página visível.
- **Dev 3:** validar a base elegível, contagens, agrupamentos por classe/instituição, isolamento por moeda, arredondamento sem fechamento forçado e proveniência por grupo. Conferir que conexões indisponíveis não criam uma contagem fictícia de posições.
- **Testes locais:** fixtures sintéticas cobrem paginação, classe desconhecida/`OTHER`, instituição ausente e nomes distintos, múltiplas moedas, empate *half-up*, dados parciais/defasados, cada motivo de exclusão e ausência de denominador. A integração real com um novo Item Sandbox e o aceite independente continuam pendentes.

## Verificação local desta contribuição

- `npm test -- src/modules/investments/application/investment-read.service.spec.ts test/contract/openapi.contract.spec.ts`: 20 testes passaram em 2 arquivos.
- `npm run typecheck` e `npm run lint`: passaram.
- A OpenAPI foi gerada pelo mesmo script com `node --import tsx scripts/generate-openapi.ts`. A invocação via `npm run openapi:generate` encontrou `EPERM` ao criar o socket local do CLI `tsx` neste ambiente; o gerador executado diretamente concluiu e o teste de contrato validou o JSON produzido.
- `git diff --check` passou nos repositórios backend e documentação. Não houve chamada ao Pluggy Sandbox, banco externo ou clientes.
