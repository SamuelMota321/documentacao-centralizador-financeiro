# Evals for coinciente-visual-design

Evaluate observable behavior rather than aesthetic taste. Run each request without the skill, then with the skill. Keep all runs read-only; design advice does not authorize product-code edits.

## Scenario 1: Review the web movement list
- **Prompt**: `Revise a hierarquia visual da lista de movimentações web do Coinciente. Quero destacar o que importa sem esconder origem e data. O que você recomenda?`
- **Expected behavior**: Inspect current product/design guidance and the relevant web implementation. Separate documented guidance, verified implementation, and design inference; make specific but evidence-grounded recommendations.
- **Assertions**:
  1. The response cites current repository files for product-specific claims rather than treating the external research report as proof of current implementation.
  2. The response distinguishes documented guidance, verified implementation behavior, and design inference.
  3. The response keeps origin and reference date discoverable and does not propose changing product code without explicit authorization.
- **Notes**: Read-only review of the documentation and web repository.

## Scenario 2: Choose a chart before data exists
- **Prompt**: `Estou planejando o futuro dashboard do Coinciente. Qual gráfico devo usar para mostrar a saúde financeira? Ainda não defini as métricas nem os dados disponíveis.`
- **Expected behavior**: Explain that the question, metric definitions, data coverage, and reference dates must be established before choosing a chart. Check current product documentation, distinguish planned dashboard work and illustrative guide examples from confirmed available data, and offer conditional guidance without inventing financial measures or implying unsupported certainty.
- **Assertions**:
  1. The response asks for or identifies the missing question, metrics, coverage, and reference-date information.
  2. The response does not invent a balance, net worth, return, or other financial metric.
  3. Any chart recommendation is conditional on the data and comparison task, and includes a textual or tabular way to access important values.
  4. The response cites current product documentation to distinguish the dashboard's documented status and illustrative style-guide values from confirmed available data.
- **Notes**: No dashboard data is supplied; this is an intentional insufficient-evidence case.

## Scenario 3: Check a mobile touch-target claim
- **Prompt**: `Na tela mobile de contas, quero reduzir os botões para 36 px. O guia realmente exige alvo de 44? Confira a unidade e o que existe hoje antes de recomendar.`
- **Expected behavior**: Verify the current mobile product/design guidance and implementation. State the source and unit of any threshold; distinguish documented guidance from observed implementation and do not claim device testing that was not performed.
- **Assertions**:
  1. The response cites the current mobile design/product guidance and a relevant implementation location.
  2. The response states the unit only when the source establishes it, and says when the evidence does not settle the unit.
  3. The response does not present a repository inspection as a physical-device accessibility test.
- **Notes**: Read-only source inspection; do not edit the mobile app.

## Scenario 4: Route a non-visual request
- **Prompt**: `Crie uma nova regra de negócio no backend para transferências entre contas e ajuste a validação da API.`
- **Expected behavior**: Recognize that this is backend/API work rather than visual design. State the scope boundary briefly and avoid proposing visual changes or editing files.
- **Assertions**:
  1. The response identifies that the request is outside this skill's visual-design scope.
  2. The response makes no product-code or backend implementation changes.
- **Notes**: Negative trigger case; no code or data changes are authorized.

## Description trigger checks

Judge these against the skill name and description only. The skill should trigger for the first five and stay out of the last five.

| Expected | User query |
|---|---|
| Trigger | `A lista de contas está visualmente pesada; como deixo o principal mais fácil de encontrar?` |
| Trigger | `Revise a tela web de movimentações, principalmente hierarquia, data, origem e estados.` |
| Trigger | `Can you sketch a calmer Coinciente mobile summary screen using its current design guidance?` |
| Trigger | `Qual gráfico responde melhor a esta série de despesas mensais comparáveis?` |
| Trigger | `Os estados da interface dependem demais de vermelho e verde; como deixo isso acessível?` |
| Do not trigger | `A validação do endpoint de transferências está errada; corrija a regra no backend.` |
| Do not trigger | `Analise este CSV e categorize meus gastos por estabelecimento.` |
| Do not trigger | `Escreva testes unitários para a função que calcula o saldo da conta.` |
| Do not trigger | `A API de contas está retornando 500; encontre e corrija o bug.` |
| Do not trigger | `Gere e publique o build mobile na loja.` |

Treat this as a qualitative description check, not a measured trigger-rate benchmark. If a query is borderline, improve the description rather than weakening a valid scenario.
