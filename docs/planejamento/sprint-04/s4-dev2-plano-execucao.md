# S4 — Plano de execução do Developer 2 (web e mobile)

- Data: 24/11/2026 · Responsável: Developer 2 (web e mobile)
- Histórias: **HU-008** (sincronização), **HU-009** (investimentos), **HU-011** (alocação) e **HU-012** (bens, financiamentos e passivos)
- Fontes: `Plano_Divisao_Atividades_Sprint_4.html`, `s4-dev2-mapeamento-dados-por-tela.md`, `s4-03-dev1-contrato-investimentos.md`, `s4-04-dev1-contrato-alocacao.md`, `s4-06-validacao-local-2026-11-23.md`, OpenAPI do backend em `origin/main` (24/11/2026), prompts `prompts/sprint4/dev2/` e ADR-003.

## Para que serve este documento

1. **Para o time:** registrar a ordem de trabalho do Developer 2 nesta etapa e o que cada fase entrega em cada plataforma.
2. **Para o Developer 3:** mostrar o que está pronto, o que está bloqueado e onde nascem as evidências.
3. **Para o Developer 1:** listar o que os clientes ainda esperam do backend.

Limites: é planejamento, não implementação. Nada aqui foi construído além do que a seção 1 descreve como existente.

## 1. Estado em 24/11/2026

| Área | Estado verificado |
|---|---|
| Backend | Rotas publicadas no OpenAPI: sincronização (`POST .../sync-runs`, `GET .../sync-runs/latest`, `GET .../sync-runs/{runId}`, `POST .../update-session`), investimentos (`GET /investments`, `GET /investments/{id}/movements`, com a alocação dentro de `portfolio.allocation`) e patrimônio (`/patrimony/{assets\|financings\|liabilities}`, com histórico). A validação local de 23/11 passou: 258 testes e 20 migrações aplicadas. |
| Web | Última validação (23/11): 754 testes, lint, tipos e build. Da Sprint 4 existe só a camada de dados `src/lib/sync-runs`, escrita antes de a rota existir e sem tela. Não há telas de sincronização, investimentos, alocação nem patrimônio. A Visão geral (Sprint 5) existe em prévia atrás de `OVERVIEW_PREVIEW`. |
| Mobile | Última validação (23/11): 481 testes, tipos e export Android. Nada da Sprint 4. A navegação troca seções com `useState`. O teste da F5 (expo-router) está na branch local `spike/f5-expo-router-auth`, sem commit. |

## 2. Perguntas abertas do mapeamento de dados

| ID | Situação | Como fechou ou o que falta |
|---|---|---|
| P-01 | Aberta | Origem em `Transaction` (manual, OFX, Pluggy). Fora do caminho crítico; segue com Developer 1 e Produto. |
| P-02 | Fechada | Rota `GET .../sync-runs/latest`, que devolve `latest` e `lastReconciled`. |
| P-03 | Aberta | O que gera `action_required` e qual ação o cliente oferece. A fase 4 confere se o campo `reasons` cobre; senão, vira pedido ao Developer 1. |
| P-04 | Parcial | A execução traz `reasons`. A fase 1 confere os códigos publicados. |
| P-05, P-06, P-08 | Fechadas | Contrato S4-04: uma composição por moeda, sem conversão; percentual com uma casa, meio para cima, sem forçar a soma a 100%. O contrato registra a decisão de Produto como aprovada antes da implementação. |
| P-07 | Definida no backend | Contrato S4-03: `current` até 96 h da referência; depois, `stale`; referência ausente ou futura, `unknown`. O aceite de Produto não está registrado em documento. |
| P-09 | Fechada | O contrato S4-03 lê as posições de conexões Pluggy já sincronizadas. |

## 3. Decisões de 24/11/2026

- **O mobile termina a F5 (expo-router) antes das telas novas.** Evita criar telas na navegação antiga e migrá-las depois, ao custo de atrasar a Sprint 4 no mobile.
- **Cada fase fecha no web e no mobile juntos,** exceto a fase 1, que o web começa em paralelo à F5.
- **Em cada fase,** o levantamento e o plano seguem o prompt correspondente, com a aprovação exata do `AGENTS.md` de cada repositório antes de qualquer alteração.

## 4. Fases

| # | Fase | Web | Mobile | Tamanho | Depende de |
|---|---|---|---|---|---|
| 0 | **F5 — navegação expo-router** (ADR-003) | — | Concluir a partir do teste da branch `spike/f5-expo-router-auth`: confirmar que o login funciona com o expo-router; abas nativas; pilha com gesto de voltar; toque com mola e vibração leve só ao concluir, conforme a tabela de movimento do `DESIGN.md`; migrar as telas atuais sem mudar o que fazem. | G | — |
| 1 | **Contrato e retomada** (S4-01, C-01) | Comparar o snapshot do OpenAPI e o `CONTRACT.md` com o backend; alinhar tipos, esquemas e fixtures das rotas publicadas; guardar o `connection.id` devolvido na conclusão, nunca derivado do `accountId` ou do Item da Pluggy; estado no servidor, limpo no logout. | O mesmo; ponteiros no Expo Secure Store, em registro separado da sessão, por usuário. | P | — (mobile: fase 0) |
| 2 | **Investimentos e alocação** (HU-009, HU-011) | Tela de investimentos: total só quando o backend o informa; posições paginadas; detalhe com movimentos; origem, referência e campos ausentes escritos como ausentes. Composição por classe e por instituição com a barra 100% e a tabela, "Não classificado" visível, cobertura e exclusões declaradas. | As mesmas telas, em lista, no expo-router. | G | 1 |
| 3 | **Bens e dívidas** (HU-012) | Tela com três tabelas (bens, financiamentos, passivos); criar e editar; financiamento associado a um bem; histórico. Sem patrimônio líquido (HU-013, Sprint 5). | O mesmo, com formulário em tela própria. | M | 1 |
| 4 | **Sincronização** (HU-008) | "Sincronizar agora" no detalhe da conexão; os seis estados mais "sem execução ativa"; consulta a cada 10 s só em primeiro plano; última reconciliação; "Ação necessária" com o caminho de recuperação. | O mesmo; a consulta para ao ir para segundo plano. | M | 1 e P-03 |
| 5 | **Integração e evidências** (S4-06) | Cada critério de aceite ligado a código e a teste; roteiro contra o backend local com dados sintéticos; definição de pronto. | O mesmo, com toque de 44 pt e "Reduzir movimento" testado no aparelho. | P | 2, 3 e 4 |

**Por que essa ordem:** investimentos e patrimônio dependem só de rotas já publicadas e de componentes que existem. A sincronização fica depois porque tem a P-03 aberta e é a parte de maior risco (consulta periódica e retomada).

## 5. Onde as telas entram

- **Web:** novo grupo "Patrimônio" na navegação lateral, com "Investimentos" e "Bens e dívidas". A sincronização entra no detalhe da conexão existente, em `contas/conectar`.
- **Mobile:** novas abas ou itens no expo-router, definidos no plano da fase 0. A sincronização entra na tela Conectar.

## 6. Regras que valem para todas as fases

- Style Guide 2.1: listas como tabelas; linha de metadados `Origem · ref. DD/MM HH:MM`; marcador para estado; campo ausente escrito como "Não informado pela fonte", nunca zero.
- Nenhum valor ou barra de investimento anima; `resultAmount` nunca é apresentado como rendimento prometido; nunca somar moedas.
- A alocação usa os valores exatos `amount` e `denominatorAmount` para as barras, e nunca o percentual arredondado; o percentual nunca é calculado só sobre a página visível.
- Só código, testes e documentação dos clientes mudam. Qualquer diferença de contrato vira pedido reproduzível ao Developer 1, e o cliente não a contorna.
- Validação de cada fase: lint, tipos, testes e build no web; tipos, testes e `npx expo export --platform android` no mobile. O que for simulado fica registrado como simulado.

## 7. Riscos

| Risco | Efeito | Resposta |
|---|---|---|
| Sprint atrasada | O plano original terminava em 23/10 e o backend fechou HU-009 e HU-011 só agora. | Reestimar P/M/G com o Developer 3 ao abrir cada fase. |
| F5 é o caminho crítico do mobile | Se o login não funcionar com o expo-router, o ADR-003 manda parar. | Registrar o bloqueio antes de migrar as telas e voltar com a alternativa. |
| Campos reais da Pluggy | A disponibilidade por campo depende de um novo Item Sandbox com consentimento autorizado. | Validar com dados sintéticos e registrar a pendência com Developer 3. |
| P-03 aberta | A fase 4 pode ficar sem a instrução específica de "Ação necessária". | Mostrar o aviso genérico do contrato e pedir o mapeamento ao Developer 1. |
| Alterações locais não commitadas no mobile | O teste da F5 está só na máquina do desenvolvedor. | Commitar o teste na própria branch antes de continuar. |

## 8. Próximo passo

Plano detalhado, com arquivos afetados, riscos e validação, da **fase 0 no mobile** e da **fase 1 no web**, cada um para aprovação própria.
