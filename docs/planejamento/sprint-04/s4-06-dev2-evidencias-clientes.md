# S4-06 — Evidências dos clientes (Developer 2)

- Data: 25/11/2026 · Responsável: Developer 2 (web e mobile) · Destinatário: Developer 3
- Histórias: HU-008, HU-009, HU-011 e HU-012 (lado cliente)
- Revisões: web `b51a9f9` (main, sem alterações locais), mobile `4bd4995` (branch `spike/f5-expo-router-auth`), backend local `b5826a3` em Docker.
- Fontes: `Plano_Divisao_Atividades_Sprint_4.html` (critério/evidência principal por história), `s4-01` (C-01, C-03), `s4-03`, `s4-04`, `s4-dev2-plano-execucao.md`, `CONTRACT.md` do web e `DESIGN_DEFINITION_OF_DONE.md` do web.

Este registro liga critérios a código, testes e comportamento observado. **Não declara aceite**: o aceite é do Developer 3.

## Legenda

| Estado | Significado |
|---|---|
| Verificado | Executado contra o backend local ou observado em tela. |
| Simulado | Coberto por teste com fixtures sintéticas ou mocks; sem integração real. |
| Bloqueado | Depende de algo fora do cliente; dono indicado. |
| Não iniciado | Ainda não implementado. |

## 1. Validação executada em 25/11/2026

| Cliente | Comando | Resultado |
|---|---|---|
| Web | `pnpm lint && pnpm typecheck && pnpm test && pnpm build` | Passou. 59 arquivos, 880 testes. Build gerou `/investimentos`, `/investimentos/[id]`, `/patrimonio`, `/patrimonio/[colecao]/[id]` e `/contas/conectar`. |
| Web | `git diff --check` | Limpo. |
| Mobile | `pnpm typecheck` | Passou. |
| Mobile | `pnpm test` | Passou. 30 arquivos, 469 testes. |
| Mobile | `npx expo export --platform android` | Bundle Android gerado. |
| Backend local | `GET /api/v1/health/live` e `GET /api/v1/openapi.json` | `200`; 33 caminhos, iguais ao snapshot do web. |
| Web em execução | `GET /investimentos`, `/patrimonio`, `/contas/conectar` sem sessão | `307` para `/auth/login`: rotas protegidas. |

O mobile registrava 481 testes na validação de 23/11 (main). A branch da F5 tem 469; a diferença não foi reconciliada e fica com o Developer 2.

## 2. Matriz por história — web

### HU-008 — sincronização

| Critério (cliente) | Código | Teste | Estado |
|---|---|---|---|
| Disparo manual "Sincronizar agora" no detalhe da conexão | `contas/conectar/sync-panel.tsx`, `actions.ts` (`requestSyncAction`) | `actions.test.ts` › "pede a sincronização e devolve a execução aceita" | Simulado |
| Uma execução por conexão: botão desabilitado durante execução ativa | `sync-presentation.ts` (`canRequestSync`) | `sync-presentation.test.ts` › "só permite pedir outra sincronização fora do andamento" | Simulado |
| Seis estados mais "Sem execução ativa", com marcador e rótulo | `sync-presentation.ts` (`syncView`, `NO_ACTIVE_RUN`) | `sync-presentation.test.ts` › "estados da sincronização" | Simulado |
| Consulta a cada 10 s só em primeiro plano; parada em `action_required` e finais | `use-sync-run.ts`, `sync-presentation.ts` (`nextPollDelay`) | `sync-presentation.test.ts` › "consulta periódica" | Simulado. O agendamento do hook não tem teste próprio (o web não tem biblioteca de teste de componente); só a regra está coberta. |
| `partial` com motivos seguros, sem valores | `sync-presentation.ts` (`reasonText`) | `sync-presentation.test.ts` › "descreve os motivos sem valores" | Simulado |
| Última reconciliação visível em falha | `sync-panel.tsx`, `reconciledText` | `sync-presentation.test.ts` › "última reconciliação…" | Simulado |
| `action_required` → widget em modo de atualização → nova execução | `sync-panel.tsx`, `startUpdateSessionAction` | `actions.test.ts` › "devolve ao navegador só o token limitado da atualização" | Simulado; bloqueado para teste real (ver lacunas L-01, L-05) |
| `statusUrl` validado na origem da API e nunca seguido | `actions.ts` (`requestSyncAction`) | `actions.test.ts` › "recusa statusUrl de outra origem" | Simulado |
| C-01: ponteiro de retomada por usuário, limpo no logout, desconexão e 403/404 | `lib/connections/resume-pointer.ts`, `resume-store.ts`, `proxy.ts` | `resume-pointer.test.ts`; `actions.test.ts` › "ponteiro de retomada (C-01)"; `proxy.test.ts` › "sair apaga o cookie…" | Simulado |
| Contrato das quatro rotas | `lib/sync-runs/*` | `contract.test.ts` › "contrato OpenAPI de sincronização (HU-008)" | Verificado contra o snapshot do OpenAPI `b5826a3` |
| Execução real ponta a ponta | — | — | Bloqueado (L-01) |

### HU-009 — investimentos

| Critério (cliente) | Código | Teste | Estado |
|---|---|---|---|
| Carteira e posições paginadas | `investimentos/page.tsx`, `lib/investments/api.ts` | `lib/investments/api.test.ts` › "lê a carteira paginada…" | Simulado |
| Total só quando o backend informa; motivo da ausência sem adivinhar a causa | `page.tsx`, `presentation.ts` (`totalNote`) | `presentation.test.ts` › "totalNote" | Simulado |
| Moedas nunca somadas nem convertidas | `presentation.ts` (`formatAmount`), resumo por moeda | `presentation.test.ts` › "usa o código de outra moeda sem converter"; "sem moeda não assume BRL" | Simulado |
| Campo ausente como "Não informado pela fonte", nunca zero | `presentation.ts` (`optionalAmount`, `optionalText`) | `presentation.test.ts` › "campos ausentes" | Simulado |
| Origem, referência e frescor (`current`, `stale`, `unknown`) | `metaLine`, `freshnessLabel`, `StatusChip` | `presentation.test.ts` › "referência e metadados"; "rótulos" | Simulado |
| `resultAmount` como "Resultado informado pela fonte" | `page.tsx`, `[id]/page.tsx` | Revisão de código | Simulado |
| Movimentos da posição; `unavailable` distinto de lista vazia | `[id]/page.tsx`, `listInvestmentMovements` | `api.test.ts` › "distingue lista vazia confirmada de indisponibilidade" | Simulado |
| Contrato das duas rotas | `lib/investments/schema.ts` | `contract.test.ts` › "contrato OpenAPI de investimentos e alocação" | Verificado contra o snapshot |
| Tela sem conexão | `page.tsx` (estado vazio) | — | Verificado em tela pelo Developer 2 contra o backend local, após recriar o container com as rotas novas |
| Carteira com dados reais | — | — | Bloqueado (L-01) |

### HU-011 — alocação

| Critério (cliente) | Código | Teste | Estado |
|---|---|---|---|
| Percentual do backend, sem ajuste para fechar 100,0% | `composition.tsx`, `percentageText` | `composition.test.ts` › "escreve o percentual do backend…" | Simulado |
| Barra pelos valores exatos, nunca pelo percentual arredondado | `lib/investments/allocation.ts` (`shareWidth`) | `allocation.test.ts`; `composition.test.ts` › "a largura da barra vem dos valores exatos…" | Simulado |
| Classe e instituição; "Não classificado" e "Instituição não informada" visíveis | `composition.tsx`, `assetClassLabel`, `institutionLabel` | `composition.test.ts` › "mostra 'Não classificado'…" | Simulado |
| Uma composição por moeda | `composition.tsx` | `composition.test.ts` › "cada moeda tem a sua base…" | Simulado |
| Cobertura e exclusões por motivo; estado sem base | `composition.tsx`, `coverageText`, `exclusionLabel` | `composition.test.ts` › "declara cobertura e exclusões quando parcial"; "sem base positiva…" | Simulado |
| Origem e referência por grupo | `groupMeta` | `presentation.test.ts` › "composição" | Simulado |
| Valores e barras sem animação | `composition.tsx` (sem `transition`) | `composition.test.ts` › "não usa animação nem transição nas barras" | Simulado |

### HU-012 — bens, financiamentos e passivos

| Critério (cliente) | Código | Teste | Estado |
|---|---|---|---|
| Cadastro de bem (tipo, descrição, valor, data, fonte) | `patrimonio/patrimony-form.tsx`, `actions.ts`, `lib/patrimony/form.ts` | `form.test.ts` › "monta o bem…"; "aponta cada campo inválido do bem" | Simulado |
| Cadastro de financiamento e passivo com saldo devedor | idem | `actions.test.ts` › "envia o passivo convertido…" | Simulado |
| Associação do financiamento a um bem, exibido pela descrição | `patrimony-form.tsx` (seletor), `presentation.ts` (`assetLabel`) | `form.test.ts` › "financiamento sem bem…"; `presentation.test.ts` › "nomeia o bem…" | Simulado |
| Edição parcial só com o que mudou | `actions.ts` (`updatePatrimonyAction`), `changedFields` | `actions.test.ts` › "envia só o campo alterado…"; "sem mudança, não envia PATCH" | Simulado |
| Histórico das versões | `patrimonio/[colecao]/[id]/page.tsx` | `api.test.ts` › "lê as versões…" | Simulado |
| Sem patrimônio líquido nem somas | `page.tsx` | Revisão de código | Simulado |
| Contrato das cinco operações | `lib/patrimony/schema.ts` | `contract.test.ts` › "contrato OpenAPI de bens, financiamentos e passivos" | Verificado contra o snapshot |
| Criar, editar e ver histórico contra o backend local | — | Roteiro da seção 4 | Pendente de execução manual pelo Developer 2 |

## 3. Matriz — mobile

| História | Estado | Motivo |
|---|---|---|
| HU-008, HU-009, HU-011, HU-012 | Não iniciado | Decisão de 24/11: o mobile conclui a F5 (expo-router, ADR-003) antes das telas novas. |
| F5 — rotas por seção e guarda de sessão | Simulado | Tipos, testes e export passam. Formulários como telas de pilha, abas nativas, vibração e toque com mola não foram feitos. |
| F5 — retorno do login Auth0 com rotas | Bloqueado | Exige development build no aparelho. Projeto EAS criado; build e teste pendentes com o Developer 2. Variáveis `EXPO_PUBLIC_*` precisam estar no ambiente `development` do EAS e a URL da API precisa ser acessível pelo celular. |

## 4. Roteiro manual contra o backend local (web)

Pré-requisitos: backend em Docker recriado em `b5826a3` (33 caminhos), web com `pnpm dev`, login feito.

1. **Bens e dívidas:** criar um bem ("Imóvel", "Apartamento de teste", 350.000,00, data de hoje, "Estimativa própria"); criar um financiamento associado a ele; criar uma dívida. Conferir que o financiamento mostra o bem pela descrição.
2. Editar o valor do bem; conferir o aviso de sucesso e a linha atualizada. Editar sem mudar nada e conferir "Nada foi alterado".
3. Abrir "Histórico" do bem e conferir as versões 1 e 2.
4. **Investimentos:** conferir o estado vazio com o atalho "Conectar um banco".
5. **Responsivo:** repetir 1 e 4 com a janela em largura de celular; conferir que as tabelas rolam dentro do painel e a página não rola na horizontal.
6. **Reduzir movimento:** ativar no sistema e recarregar; nada se desloca.

Cada passo confirmado entra neste registro como "Verificado" com a data.

## 5. Definition of Done das telas novas (revisão de código)

| Item | Investimentos | Bens e dívidas | Painel de sincronização |
|---|---|---|---|
| Objetivo em uma frase no cabeçalho | Sim | Sim | Seção dentro do detalhe da conexão |
| Loading, vazio, erro e sucesso | `loading.tsx`, estado vazio, `error.tsx` | `loading.tsx`, vazio por seção, erro por seção e `error.tsx`, toast de sucesso | Carregando, sem execução, erro em aviso |
| Ação destrutiva com confirmação | Não há | Não há (a API não tem exclusão) | Não há |
| Origem, referência e frescor de dado externo | Sim (`metaLine`, marcador de frescor) | Não se aplica (dado do usuário); fonte e data da avaliação na linha de metadados | Referência da fonte na última reconciliação |
| Valor financeiro animado | Não | Não | Não; só a opacidade do bloco de estado muda (`--motion-hover`, `--ease-out`) |
| Reduzir movimento | Sem movimento | Sem movimento além dos painéis existentes | Opacidade é mantida pela regra do Style Guide |
| Tokens do `DESIGN.md` | Sim; cores de classe pelos `--cat-*` | Sim | Sim |
| Alvo de 44 px no toque | Botões sobem a 44 px em `pointer: coarse` (`ui.module.css`). O nome da posição é link de texto na tabela: alvo menor que 44 px de altura. | Botões `small` também sobem a 44 px no toque | Sim |
| Sem rolagem horizontal da página | Tabelas rolam dentro do painel | Idem | Sim |
| Teclado e foco visível | `:focus-visible` global; links e botões nativos | Idem | Idem |
| HTML semântico | `section` com título, `table` com `th scope`, `dl` | Idem | `role="status"` com `aria-live` |

Pendências do DoD: conferência visual nos três tamanhos (roteiro, passo 5), o teste com "Reduzir movimento" (passo 6) e o alvo de toque do link de posição. Esse alvo é ajuste de layout pequeno, que fica com o Developer 2 com plano próprio.

## 6. Lacunas e donos

| ID | Lacuna | Efeito | Dono |
|---|---|---|---|
| L-01 | `POST /connections/pluggy/completions` responde `503 INTEGRATION_UNAVAILABLE` após o widget conectar no Sandbox, inclusive no Render. | Sem conexão real: investimentos com dados e sincronização não têm verificação ponta a ponta. | Developer 1 |
| L-02 | Os `catch` de `pluggy-api.client.ts` e `qstash-pluggy-webhook.service.ts` não registram a causa. | Não é possível saber qual integração falhou em L-01. | Developer 1 |
| L-03 | Não existe `GET /investments/{id}`; o detalhe percorre a carteira (até 500 posições). | Carteiras maiores podem não abrir o detalhe. | Developer 1 |
| L-04 | Patrimônio sem exclusão, sem `Idempotency-Key` na criação e sem controle de versão no `PATCH`. | Duplo envio pode duplicar; duas abas sobrescrevem uma à outra. | Developer 1 e Produto |
| L-05 | Confirmar se o token de `update-session` basta para o widget em modo de atualização sem o `itemId`, e quem cria a nova execução após reautorizar. | Recuperação de `action_required` sem verificação real. | Developer 1 |
| L-06 | Frescor `current` em 96 h sem aceite de Produto registrado. | O cliente exibe o que o backend devolve. | Produto |
| L-07 | Mobile sem telas da Sprint 4 e F5 incompleta; login com rotas não testado. | Critérios mobile não iniciados. | Developer 2 |
| L-08 | Diferença de testes no mobile (481 na main em 23/11; 469 na branch da F5). | Possível perda de cobertura na branch. | Developer 2 |
| L-09 | Roteiro manual da seção 4 e pendências do DoD. | Itens "Simulado" de HU-012 sem confirmação integrada. | Developer 2 |

## 7. Handoff ao Developer 3

- **Pronto para revisão:** a matriz web das quatro histórias, os testes citados e o contrato conferido contra o snapshot do OpenAPI `b5826a3`.
- **Não aceitar ainda:** nenhuma linha "Simulado" equivale a integração. HU-008 e a parte com dados de HU-009/HU-011 dependem de L-01. HU-012 depende do roteiro manual (L-09).
- **Mobile:** nada da Sprint 4 para aceitar; acompanhar L-07.
- **Próximo registro:** após o roteiro manual e a correção de L-01, atualizar este documento com as linhas que passarem a "Verificado".
