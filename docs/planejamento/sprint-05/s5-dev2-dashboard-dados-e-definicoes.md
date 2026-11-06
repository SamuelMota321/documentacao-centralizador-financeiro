# S5 — Dashboard: dados por tela, definições pendentes e plano do Developer 2

- Data: 02/11/2026 · Responsável: Developer 2 (web e mobile)
- Histórias: **HU-010** (dashboard consolidado), com dependência de **HU-013** (patrimônio líquido), **HU-009** (investimentos), **HU-012** (bens e passivos) e **HU-008** (sincronização)
- Fontes: PRD 1.4 (HU-010, HU-013; RN-009 a RN-011, RN-017; RNF-006 a RNF-009, RNF-013), Plano da Sprint 4 (proposta da Sprint 5), Style Guide 2.0 (seções 05, 07, 08 e 09), `docs/planejamento/sprint-04/s4-dev2-mapeamento-dados-por-tela.md`, OpenAPI do backend em `origin/main` e tipos atuais dos clientes.

## Para que serve este documento

1. **Para Produto:** reunir, com uma recomendação cada, as definições de cálculo que o PRD não fixa (seção 4).
2. **Para o Developer 1:** dizer quais agregações a tela precisa, com quais campos (seção 5). A forma das rotas e os nomes finais ficam com o Developer 1.
3. **Para o Developer 3:** oferecer a base observável dos critérios de aceite (seção 6).
4. **Para o Developer 2:** o plano de trabalho com condições de entrada (seção 7).

Limites: é levantamento de apresentação, não contrato nem cálculo. As recomendações da seção 4 são propostas do Developer 2; quem decide está indicado em cada linha. Nada aqui foi implementado.

## 1. O que o PRD exige (HU-010)

| Critério | Implicação para a tela |
|---|---|
| Consolida contas, transações, investimentos, bens e passivos do tenant | Precisa das cinco fontes; três delas (investimentos, bens, passivos) ainda não existem. |
| Exibe saldos, fluxo por período, gastos por categoria e patrimônio líquido | Quatro blocos de conteúdo. Patrimônio líquido depende da HU-013. |
| Período e referência temporal dos dados são claros | Todo bloco mostra seu período e sua referência (linha de metadados). |
| Estado sem dados orienta o próximo passo | Estado vazio com ação, reaproveitando o padrão "Primeiros passos". |
| Dados indisponíveis ou defasados não são apresentados como atuais | Marcador de frescor por bloco e por linha; total parcial nunca aparece como total. |

Requisitos transversais: RNF-006 (P90 abaixo de 2 s com até 10.000 transações por usuário, objetivo a validar), RNF-007 (relatório de desempenho), RNF-008 (falha de integração preserva o último dado válido e mostra a defasagem), RNF-013 (agregação no servidor com índices e paginação), RN-017 (nada que movimente dinheiro).

## 2. Situação atual verificada (02/11/2026)

| Item | Estado |
|---|---|
| Rotas do backend (`origin/main`) | Contas, transações, transferências, categorias, regras, OFX e conexão Pluggy. **Nenhuma rota de agregação** (saldo atual, fluxo, gastos por categoria, patrimônio). |
| `GET /transactions` | Só `page` e `pageSize`; sem filtro de período, conta ou categoria. Não serve para agregar no cliente. |
| Saldo das contas | Só `initialBalance` + `initialBalanceAsOf`. Não existe saldo atual. A interface hoje não calcula nem insinua saldos (PRODUCT.md). |
| Tipos de conta | `checking`, `savings`, `payment`, `cash`, `credit_card`, `investment`, `other`. |
| Moeda das contas | Só `BRL`. |
| Movimentações | `income`, `expense`, `transfer` (com lado `outgoing`/`incoming`); status `posted` ou `voided`. |
| Categorização | `unclassified`, `categorized`, `uncertain`, `unrecognized`, `not_applicable` (transferências). |
| Investimentos, bens, passivos, patrimônio líquido | Não existem (HU-009, HU-012, HU-013). |
| Padrões visuais | Style Guide 2.0 já define faixa de números, gráfico de linha com pontos, barra 100% com tabela, marcador e linha de metadados; mockup "Visão geral" na seção 09. |

## 3. Tela por tela

### 3.1 Navegação

- Novo destino **"Visão geral"** no topo da lateral, acima de "Registros" (web), e primeira aba (mobile).
- Proposta (D-11): passa a ser a tela inicial depois do login quando existir; hoje é Movimentações.

### 3.2 Visão geral — desktop (web)

Ordem de leitura, do mais importante ao detalhe, como no mockup da seção 09 do Style Guide 2.0:

| # | Bloco | Conteúdo | Etapa |
|---|---|---|---|
| 1 | Cabeçalho | Título, seletor de período (D-05) e caminho "Visão geral" | Dashboard 1 |
| 2 | Faixa de números | Disponível · Saídas do período · Entradas do período (Dashboard 1); Patrimônio líquido entra como primeiro número no Dashboard 2 | 1 e 2 |
| 3 | Saldos por conta | Tabela: conta, tipo, origem, saldo atual, referência | Dashboard 1 |
| 4 | Fluxo por período | Barras de entradas e saídas por mês + tabela com os valores | Dashboard 1 |
| 5 | Gastos por categoria | Barras horizontais ordenadas por valor + tabela; linha "A revisar" | Dashboard 1 |
| 6 | Composição do patrimônio | Tabela: recursos, investimentos, bens, financiamentos e passivos, com fonte e referência | Dashboard 2 |
| 7 | Investimentos por classe | Barra 100% + tabela (mesmo componente da alocação da HU-011) | Dashboard 2 |

### 3.3 Visão geral — celular (web estreito e mobile)

Mesmo conteúdo, empilhado: número principal com linha de metadados; seletor de período; os blocos 3, 4 e 5 como listas com valor à direita; gráficos só onde couberem com leitura (barras horizontais sim; colunas por mês viram lista "mês · entradas · saídas").

### 3.4 Blocos em detalhe

**Faixa de números (bloco 2)**

| Número | Dado | Fonte | Metadado | Estados |
|---|---|---|---|---|
| Disponível | Soma do saldo atual das contas que contam como disponíveis (D-01, D-03) | Agregação "saldo atual" | `N contas · ref. DD/MM HH:MM` | Sem contas: estado vazio. Alguma conta conectada desatualizada: marcador atenção "Inclui conta desatualizada". |
| Entradas do período | Soma de `income` `posted` no período, sem transferências (D-04) | Agregação "fluxo" | período | Período sem movimentações: "R$ 0,00" com texto "Nenhuma entrada no período" (zero real, não ausência). |
| Saídas do período | Soma de `expense` `posted` no período, sem transferências | Agregação "fluxo" | período | Idem. |
| Patrimônio líquido (Dashboard 2) | Resultado da HU-013 | Agregação "patrimônio" | referência mais antiga entre as fontes (D-07) | Alguma fonte indisponível: "Patrimônio parcial" + o que ficou de fora; nunca o parcial como total. |

**Saldos por conta (bloco 3)** — colunas: Conta (nome + instituição em metadado), Tipo, Origem (manual/OFX/Pluggy), Saldo atual (tabular, à direita), Referência (data + marcador de frescor). Contas `credit_card` em grupo próprio "Cartões" (D-03). Contas desativadas não aparecem.

**Fluxo por período (bloco 4)** — por mês: entradas, saídas e resultado (entradas − saídas). Barras verticais pareadas (entradas em `foreground`, saídas em `text-secondary`; nenhuma cor de "ganho/perda") com eixo em reais, mais tabela com os valores. Mês corrente marcado "parcial" (D-05). Transferências fora (D-04).

**Gastos por categoria (bloco 5)** — só `expense` `posted` no período. Barras horizontais ordenadas do maior para o menor com valor e percentual sobre o total de saídas do período; tabela com os mesmos dados. Linha "A revisar" soma `unclassified`, `uncertain` e `unrecognized`, com link para Movimentações filtradas (filtro depende de rota futura; sem ele, link para Movimentações) (D-06). Categorias arquivadas aparecem com o nome e o marcador "arquivada".

**Composição do patrimônio (bloco 6, Dashboard 2)** — linhas: Recursos (saldos das contas disponíveis), Investimentos (HU-009), Bens (HU-012), Financiamentos e passivos (HU-012, com "−"), Cartões (se D-03 decidir tratá-los como passivo), Patrimônio líquido. Cada linha com fonte e referência. Linha indisponível escrita como indisponível.

**Estados da tela inteira**

| Situação | O que aparece |
|---|---|
| Sem nenhuma conta | Estado vazio "Crie sua primeira conta" (reaproveita Primeiros passos) |
| Contas sem movimentações | Saldos com o saldo inicial; fluxo e gastos com "Nenhuma movimentação no período" |
| Carregando | Esqueleto com a forma da faixa e das tabelas |
| Falha de uma agregação | Só o bloco afetado mostra aviso com "Tentar de novo"; os outros continuam (RNF-008) |
| Fonte desatualizada | Marcador atenção no bloco e na linha; valor continua visível com sua referência |

Regras visuais fixas: nenhum número anima (Style Guide 2.0, seção 07); nada de rosca, área preenchida ou eixo duplo; todo gráfico tem tabela ou resumo em texto com os valores.

## 4. Definições pendentes (para Produto)

| ID | Pergunta | Recomendação do Developer 2 | Quem decide | Bloqueia |
|---|---|---|---|---|
| D-01 | Como se calcula o saldo atual de uma conta? | Saldo inicial na data de referência + entradas − saídas + transferências recebidas − enviadas, só `posted`, com data **posterior** a `initialBalanceAsOf` (o saldo inicial já inclui o próprio dia). | Produto; Developer 1 confirma viabilidade | Bloco 2 e 3 |
| D-02 | Movimentações `voided` entram em algum total? | Não entram em nenhum total. | Produto | Todos os totais |
| D-03 | Quais tipos de conta somam em "Disponível"? E cartão de crédito? | Disponível: `checking`, `savings`, `payment`, `cash`. `credit_card` aparece em "Cartões", fora do Disponível; no patrimônio, como passivo. `investment` fica para a HU-009 (não soma no Disponível). `other`: perguntar. | Produto | Bloco 2, 3 e 6 |
| D-04 | Transferências entram no fluxo e nos gastos? | Não: movem dinheiro entre contas próprias e somariam zero. Aparecem só nos saldos por conta. | Produto | Bloco 2, 4 e 5 |
| D-05 | Qual o período padrão e quais opções? | Padrão: mês corrente (dia 1 até hoje), marcado "parcial". Opções: meses anteriores fechados. Fluxo: últimos 6 meses. Fuso: o do usuário no Brasil (`America/Sao_Paulo`), a confirmar. | Produto | Bloco 1, 2, 4 e 5 |
| D-06 | Como tratar saídas sem categoria ou com categoria incerta? | Somar em "A revisar", sempre visível quando maior que zero; não diluir em "Outros". | Produto | Bloco 5 |
| D-07 | Qual referência temporal mostrar quando um total mistura fontes com datas diferentes? | A mais antiga entre as fontes somadas, com marcador "desatualizado" se alguma estiver além do prazo de D-08. | Produto | Bloco 2 e 6 |
| D-08 | A partir de quando um dado é desatualizado? (mesma questão P-07 da Sprint 4) | Conectado: sem sincronização bem-sucedida há mais de 48 h. Manual e OFX: não expiram; mostram a data do registro ou da importação. Valor a confirmar. | Produto | Marcadores de frescor |
| D-09 | Como tratar outras moedas? (P-06 da Sprint 4) | Contas são só BRL hoje. Investimentos em outra moeda ficam fora dos totais em reais, listados à parte com aviso, até existir regra de conversão. | Produto | Dashboard 2 |
| D-10 | Composição do patrimônio líquido (HU-013) | Recursos (D-03) + investimentos + bens − financiamentos − passivos − cartões (se D-03 confirmar cartão como passivo). | Produto; Developer 1 implementa | Dashboard 2 |
| D-11 | "Visão geral" vira a tela inicial depois do login? | Sim, quando o Dashboard 1 existir. | Produto e time | Navegação |
| D-12 | Percentual dos gastos é sobre o total de saídas do período (incluindo "A revisar")? | Sim, para fechar 100% com o que de fato saiu; arredondamento com uma casa decimal e a soma exibida sem ajuste forçado. | Produto | Bloco 5 |

## 5. Pedido de contrato ao Developer 1

O cliente precisa receber os totais já calculados. A forma das rotas, os nomes e a paginação ficam com o Developer 1; abaixo estão os **dados** que cada bloco consome. Todos autorizados por tenant e proprietário, sem payload bruto de provedor.

| Agregação | Entrada | Saída mínima por item | Usado em |
|---|---|---|---|
| Saldo atual por conta | — | conta (id, nome, tipo, origem, instituição), saldo atual (decimal com 2 casas), moeda, referência (data/hora), frescor (`current`/`stale`/`unavailable`) | Blocos 2 e 3 |
| Fluxo por período | intervalo de meses, fuso | mês, entradas, saídas, resultado, indicador "mês parcial" | Blocos 2 e 4 |
| Gastos por categoria | período | categoria (id, nome, arquivada), valor, quantidade; item agregado "a revisar"; total de saídas do período | Bloco 5 |
| Patrimônio líquido (HU-013) | data de referência | componentes (recursos, investimentos, bens, financiamentos/passivos, cartões) com valor, fonte, referência e disponibilidade; total; indicador "parcial" | Blocos 2 e 6 |

Requisitos não funcionais que o contrato precisa permitir: RNF-006 (P90 < 2 s com 10.000 transações), RNF-008 (último dado válido + defasagem), RNF-013 (índices). Valores sempre como decimal em texto, como nas rotas atuais.

## 6. Base para os critérios de aceite (Developer 3)

- Com dataset fictício conhecido, cada número da faixa e cada linha das tabelas confere com o cálculo manual definido em D-01 a D-06.
- Transferência entre contas próprias altera os saldos das duas contas e não altera entradas, saídas nem gastos.
- `voided` não aparece em nenhum total.
- Falha de uma agregação não derruba os outros blocos.
- Fonte desatualizada aparece com marcador e referência; total parcial nunca aparece como total.
- Dois usuários: nenhum número de um aparece para o outro.
- Desempenho: P90 medido com até 10.000 transações, com dataset e condições registrados (RNF-007).
- Acessibilidade: todo gráfico com tabela ou resumo em texto; navegação por teclado; movimento reduzido.

## 7. Plano do Developer 2

| Fase | Entrega | Condição de entrada | Validação |
|---|---|---|---|
| **0 — agora** | Este documento levado ao time; respostas de Produto registradas na seção 4 | — | Decisões com responsável e data |
| **1 — feita em 02/11/2026** | Mockup da Visão geral na seção 09 do Style Guide 2.0 (`docs/design/style-guide.html#aplicacoes`), desktop e celular: blocos 1 a 6, com "Etapa 2" marcando o que depende de HU-009, HU-012 e HU-013. O bloco 7 (investimentos por classe) reaproveita a barra 100% já mostrada na seção 08 e não foi repetido. | — | Aguarda revisão do time |
| **2 — após o mockup** | Componentes de visualização da 2.0, sem ligação com a API: faixa de números, barras pareadas por mês, barras horizontais ordenadas e barra 100% com tabela. Web em SVG próprio; mobile com `react-native-svg` (já instalado). Fixtures e testes, cada gráfico com tabela/resumo em texto. A barra 100% atende também a alocação da HU-011. | Mockup aprovado | lint, typecheck, testes, build; contraste; movimento reduzido |
| **3 — Dashboard 1** | Tela "Visão geral" com blocos 1 a 5 no web e no mobile; tipos, esquemas e chamadas das agregações; navegação (D-11); estados da seção 3.4 | D-01 a D-08, D-11, D-12 respondidas; agregações de saldo, fluxo e gastos publicadas no OpenAPI | Critérios da seção 6; medição com o Developer 3 |
| **4 — Dashboard 2** | Blocos 6 e 7 e Patrimônio líquido na faixa | HU-009, HU-012 e HU-013 publicadas; D-09 e D-10 respondidas | Idem |
| **5 — evidências** | Checklist da definição de pronto, relatório de desempenho com o Developer 3, roteiro de demonstração | Fases 3 e 4 | Evidência por plataforma |

O que não entra: cálculo no cliente além de formatação; projeções (HU-014, que tem sua própria tela); recomendações ou linguagem de ganho; animação de valores.

## 8. Riscos

| Risco | Efeito | Tratamento |
|---|---|---|
| Definições da seção 4 sem resposta | Números diferentes entre web, mobile e backend | Nenhuma fase de tela começa sem D-01 a D-08 respondidas |
| Agregações demoram (Developer 1 ocupado com a Sprint 4) | Dashboard 1 atrasa | As agregações do Dashboard 1 usam só dados que já existem; pedir prioridade separada da Sprint 4 |
| Desempenho acima de 2 s | Falha no RNF-006 | Agregação no servidor; medir cedo com 10.000 transações fictícias |
| Saldo "atual" de conta conectada sem sincronização (HU-008 pendente) | Saldo parecer atual sem ser | Marcador de frescor obrigatório (D-08) desde o Dashboard 1 |
