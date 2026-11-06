# S4 — Mapeamento de dados por tela (Developer 2)

- Data: 02/11/2026 · Responsável: Developer 2 (web e mobile)
- Itens da S4-01 atendidos: **C-04** (escopo de dados por tela/fluxo) e **C-06** (apresentação e interações de investimentos); apoio a **C-01** e **C-03** (consumo da sincronização)
- Fontes: PRD 1.4 (HU-008, HU-009, HU-011; RN-007, RN-009, RN-010, RN-014, RN-017), `s4-01-dev1-backend-baseline-e-decisoes.md` (adendo de 27/10), Style Guide 2.0 (seções 05 e 08), código atual de `web-centralizador-financeiro` e `mobile-centralizador-financeiro`.

## Limites deste documento

- É levantamento de apresentação, não contrato. **Não corta escopo do PRD** (C-04) e **não cria campo, métrica ou valor substituto** (C-06).
- A capacidade real do provedor não foi verificada aqui; é responsabilidade do Developer 1 (C-04, C-06). Cada linha marcada "depende de capacidade" só vira tela quando o mapa PRD → capacidade → API existir.
- Onde a semântica não está definida em nenhuma fonte, o item aparece em **Perguntas abertas**, com quem decide.
- Nenhuma tela descrita aqui está implementada. O estado atual dos clientes está na última seção.

## Convenções de apresentação (Style Guide 2.0)

- **Linha de metadados** (`Origem · ref. DD/MM HH:MM · Conta`) logo abaixo de todo dado externo. Atende RN-010 e o critério "fonte e data de referência permanecem acessíveis" (HU-011).
- **Marcador** (quadrado de 6px + texto) para estado: atualizado, desatualizado, indisponível; e para os estados de sincronização.
- **Campo ausente** é escrito como ausente ("Não informado pela fonte"), nunca como zero, traço vazio ou valor estimado.
- Valores financeiros em Manrope 600 tabular, alinhados à direita; nenhum número se anima.

## HU-008 — Sincronização

### Tela: detalhe da conexão (web `contas/conectar`; mobile tela Conectar)

| Elemento | Dado | Fonte | Observação |
|---|---|---|---|
| Ação "Sincronizar agora" | dispara `POST /connections/{connectionId}/sync-runs` | C-03 | Visível com a conexão `connected`. Durante execução ativa, a ação mostra a execução existente (C-03: no máximo uma ativa por conexão). |
| Estado da execução | `status` ∈ `queued`, `running`, `action_required`, `succeeded`, `partial`, `failed` | C-03 | Marcador + rótulo conforme Style Guide 2.0, seção 08. Três primeiros não são finais. |
| Momento da solicitação | `acceptedAt` | C-03 | Linha de metadados: "Solicitada às HH:MM". |
| Início e fim | `startedAt`, `completedAt` | C-03 | Quando aplicáveis. "Concluída às HH:MM" alimenta a referência dos dados exibidos. |
| Ação necessária | estado `action_required` | C-03 | Aviso fixo com o que fazer e botão. **O que exatamente a pessoa deve fazer depende do mapeamento de `action_required`, ainda pendente** (ver P-03). |
| Resultado parcial | estado `partial` | C-03 | Aviso dizendo o que ficou de fora. **Quais dados ficaram de fora não está no contrato público** (ver P-04). |
| Última sincronização | último `completedAt` com `succeeded`/`partial` | C-03 | Mostrado mesmo sem execução ativa. **Recuperar a última execução sem `runId` guardado não tem rota definida** (ver P-02). |

### Retomada (C-01 — decisão fechada, implementação pendente)

| Plataforma | O que guardar | Onde | Quando limpar |
|---|---|---|---|
| Web | `connectionId`; após aceite: `runId`, `statusUrl`, `status`, `acceptedAt` | Preferir estado no servidor (sessão); `localStorage` só se precisar sobreviver ao fechamento do navegador | Logout, troca de usuário, ou quando a API negar acesso |
| Mobile | os mesmos ponteiros | Expo Secure Store, registro separado da sessão, associado ao usuário | Logout, troca de usuário, ou quando a API negar acesso |

- Consultar o andamento só com o app em primeiro plano; parar em `succeeded`, `partial` ou `failed`.
- Validar a origem de `statusUrl` antes de usar.
- **Intervalo de consulta: pendente entre Developer 1 e Developer 3** (C-03). Os clientes não fixam valor até a definição.

### Telas afetadas pela sincronização (sem tela nova)

| Tela | Efeito | Observação |
|---|---|---|
| Contas | Contas conectadas mostram a referência da última sincronização | Hoje a conta conectada mostra só "Conectada" e o saldo inicial. |
| Movimentações | Movimentações vindas do Pluggy mostram a origem | **`Transaction` não tem campo de origem no contrato atual** (ver P-01). |

## HU-009 — Investimentos

Todos os campos abaixo vêm dos critérios do PRD. Todos "dependem de capacidade" até o mapa do Developer 1.

### Tela: carteira (lista de posições)

| Elemento | Dado do PRD | Apresentação |
|---|---|---|
| Faixa de números | total da carteira "quando disponível" | `figure` com linha de metadados (referência mais antiga entre as posições somadas). Se indisponível, texto "Total indisponível" — nunca soma parcial apresentada como total (ver P-05, P-06). |
| Coluna: ativo | tipo de ativo, instituição | Nome do ativo; instituição na linha de metadados. |
| Coluna: quantidade ou saldo | quantidade ou saldo "quando fornecidos" | Tabular, à direita. |
| Coluna: valor investido | valor investido "quando fornecido" | Tabular, à direita. |
| Coluna: resultado | resultado "quando fornecido" | Tabular, à direita, com sinal "+"/"−". **Apresentado como dado da fonte, nunca como rentabilidade prometida** (PRODUCT.md). |
| Coluna: referência | data de referência | Linha de metadados + marcador de frescor. |
| Estado do dado | qualidade do dado; ausente, indisponível, desatualizado | Marcador. **O prazo que torna um dado "desatualizado" não está definido** (ver P-07). |

### Tela: detalhe da posição

| Elemento | Dado do PRD | Apresentação |
|---|---|---|
| Identificação | tipo de ativo, instituição, identificador externo | Identificador externo em `meta`, para rastreabilidade (RN-010). |
| Valores | quantidade ou saldo, valor investido, resultado | Lista de definição alinhada. |
| Renda fixa | taxa, índice, vencimento "quando fornecidos" | Bloco próprio só para renda fixa. |
| Proveniência | fonte, data de referência, moeda, qualidade | Linha de metadados completa. |
| Movimentações da posição | movimentações "quando disponibilizadas" | Tabela como em Movimentações; vazio explicado ("A fonte não fornece movimentações para este ativo"). |

## HU-011 — Alocação

### Tela: alocação (carteira)

| Elemento | Dado do PRD | Apresentação |
|---|---|---|
| Agrupamento | por classe e por instituição | Controle segmentado "Classe · Instituição". |
| Composição | percentuais "sobre os dados disponíveis" | Barra 100% estática + tabela (classe/instituição, %, valor), Style Guide 2.0. |
| Não classificado | posições sem classificação | Linha "Não classificado" sempre visível quando existir; segmento hachurado. |
| Proveniência | fonte e data de referência acessíveis | Linha de metadados acima da tabela; detalhe por linha no toque/clique. |
| Cobertura | percentuais só do que está disponível | Texto: "Calculado sobre N de M posições com valor disponível". **Denominador, moedas e arredondamento pendentes** (ver P-05, P-06, P-08). |

## Perguntas abertas

| ID | Pergunta | Por que importa | Quem decide | Bloqueia |
|---|---|---|---|---|
| P-01 | `Transaction` terá campo de origem (manual, OFX, Pluggy)? | Sem ele, Movimentações não mostram proveniência (RN-010 pede para investimentos; para transações é recomendação do Style Guide). | Developer 1 propõe; Produto aprova | Linha de metadados em Movimentações |
| P-02 | Como recuperar a última execução de uma conexão sem `runId` guardado (outro dispositivo, cache limpo)? | C-01 proíbe listagem de conexões, mas não trata a última execução. | Developer 1 propõe; Developer 3 valida aceite | "Última sincronização" no detalhe |
| P-03 | Quais situações geram `action_required` e qual ação o cliente oferece em cada uma? | O aviso precisa dizer o que fazer. | Developer 1 (mapeamento pendente em C-03) | Aviso de ação necessária |
| P-04 | `partial` informa quais dados ficaram de fora? Em que forma? | Sem isso, o aviso só pode dizer "parte dos dados não atualizou". | Developer 1 propõe; Produto decide o nível de detalhe | Aviso de resultado parcial |
| P-05 | Qual é o denominador dos percentuais e do total da carteira quando há posições sem valor? | PRD diz "sobre os dados disponíveis", sem fixar o denominador. | Produto | Total e alocação |
| P-06 | Como tratar posições em moedas diferentes? | C-06: "total multimoeda exige regra aprovada". | Produto | Total e alocação |
| P-07 | A partir de quando um dado é "desatualizado"? | Marcador de frescor (RN-010). | Produto | Marcador em todas as telas |
| P-08 | Regra de arredondamento dos percentuais (e se a soma deve fechar 100%)? | Evita total visual diferente de 100%. | Produto | Alocação |
| P-09 | Fronteira HU-008/HU-009: a sincronização traz posições e movimentos de investimento? | C-04 em aberto; define se a tela da carteira é alimentada pela sincronização. | Produto, após mapa do Developer 1 | Toda a HU-009 |

## Estado atual dos clientes (02/11/2026)

| Item | Web | Mobile |
|---|---|---|
| Conexão Pluggy, conclusão e detalhe | Existe (`src/app/(app)/contas/conectar`), recupera a conexão por `?conexao=` | Existe (fluxo Conectar) |
| Guarda de `connectionId` / `runId` | Não existe | Não existe |
| Camada de dados `sync-runs` | Tipos, esquema e chamadas preparados contra o contrato C-03, sem tela e sem consulta periódica (nesta mesma data) | Não existe |
| Telas de sincronização, investimentos, alocação | Não existem | Não existem |
