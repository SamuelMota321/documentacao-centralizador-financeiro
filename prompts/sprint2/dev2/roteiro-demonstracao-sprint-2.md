# Roteiro de demonstração da Sprint 2 — clientes web e mobile (Dev 2)

- Escopo: parte web e mobile de S2-09 (experiência e demonstração).
- Dados: exclusivamente fictícios. Dois usuários de teste no mesmo tenant Auth0 do backend (A e B), cada um com o próprio espaço financeiro.
- Nunca mostrar: `.env`, tokens, aba de rede do navegador, URLs com parâmetros de autenticação, credenciais do Auth0.
- Preencha a coluna **Observado** durante a execução. Não marque como feito o que não foi executado.

## Preparação

1. Backend: `docker compose up -d --wait` em `backend-centralizador-financeiro` (usa npm, nunca pnpm). API em `http://localhost:3000/api/v1` ou `3100` com `compose.override.yaml`.
2. Web: `pnpm dev` em `web-centralizador-financeiro` → `http://localhost:3001`.
3. Mobile: `pnpm start` em `mobile-centralizador-financeiro`, com a aplicação Auth0 **Native** configurada (README do mobile, passo 4.1).
4. Usuários A e B criados no Auth0 com e-mails fictícios.

## Parte 1 — Web, usuário A

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| W1 | Abrir `http://localhost:3001` e **Entrar** como A | Auth0 e retorno a **Movimentações**; lista vazia com orientação para criar conta | |
| W2 | Contas → **Nova conta**: "Conta do dia a dia" (corrente, R$ 1.000,00, data de hoje em DD/MM/AAAA) e "Reserva" (poupança) | Duas contas na lista com saldo inicial em BRL e data | |
| W3 | Movimentações → **Registrar movimentação**: receita "Salário (fictício)" R$ 6.800,00 | Aviso de sucesso; linha com "+ R$ 6.800,00" | |
| W4 | Registrar despesa "Mercado do bairro" R$ 184,90 | Linha com "− R$ 184,90" | |
| W5 | Aba **Transferência entre contas**: da conta do dia a dia para a Reserva, R$ 250,00 | Aviso "Registro contábil criado" citando saída e entrada; duas linhas no histórico ("— saída" e "— entrada"), etiqueta "Não se aplica" | |
| W6 | Categorias → criar "Alimentação" e "Feira" | Ambas ativas | |
| W7 | Na despesa W4, **Categorizar** → Alimentação | Etiqueta "Alimentação · definida por você" | |
| W8 | Registrar despesa "Padaria" e **Categorizar** → **Marcar como incerta** | Etiqueta "Categoria incerta" | |
| W9 | Regras → regra A: descrição **contém** "mercado" → Alimentação, prioridade 10 | Frase "Se a descrição contém “mercado” → Alimentação", Ativa | |
| W10 | Regra B: descrição **começa com** "mercado bairro" → Feira, prioridade 20 | Lista em ordem: B antes de A | |
| W11 | Registrar despesa "Mercado Bairro centro" | Etiqueta "Feira · aplicada por regra" (B vence por prioridade) | |
| W12 | Explicar o aviso de precedência da tela de Regras | Maior prioridade vence; empate vale a mais antiga; escolha manual prevalece; regras não mudam o passado | |
| W13 | **Desativar** B e registrar outra "Mercado Bairro centro" | Nova linha com "Alimentação · aplicada por regra"; a de W11 continua "Feira" | |
| W14 | **Remover** B (confirmar) | B aparece como "Removida", sem ações | |
| W15 | Conferir W7 | Continua "definida por você" (correção manual não foi reprocessada) | |

## Parte 2 — Web, reenvio sem duplicar

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| R1 | Preencher uma despesa "Teste de reenvio" R$ 10,00, parar o backend (`docker compose stop api`) e enviar | Mensagem "Não foi possível registrar… Tente de novo."; valores continuam no formulário | |
| R2 | Subir o backend (`docker compose start api`) e enviar de novo sem alterar nada | Um único "Teste de reenvio" no histórico | |
| R3 | Clique duplo em **Registrar movimentação** numa nova despesa | Um único lançamento | |

## Parte 3 — Isolamento entre usuários (web)

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| I1 | **Sair** | Volta à página de entrada | |
| I2 | Botão **Voltar** do navegador | Nenhum dado de A; as rotas pedem login | |
| I3 | **Entrar** como B | Movimentações, Contas, Categorias e Regras vazias; nada de A aparece, nem por um instante | |

## Parte 4 — Mobile (mesmas etapas com o usuário A, depois B)

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| M1 | Abrir o app e **Entrar** como A | Abre em **Movimentações** com os dados criados no web (W2–W14) | |
| M2 | Conferir a transferência W5 | Duas linhas com "— saída" e "— entrada" | |
| M3 | Na despesa "Padaria", **Corrigir** → Alimentação | Etiqueta "Alimentação · definida por você" | |
| M4 | Voltar ao web e recarregar Movimentações | A correção de M3 aparece no web | |
| M5 | Regras: criar regra por **Tipo** = Despesa → Alimentação, prioridade 1 | Frase "Se o tipo é igual a Despesa → Alimentação" | |
| M6 | **Registrar** uma despesa sem descrição | Categoria aplicada pela regra de maior prioridade que combinar (a de M5) | |
| M7 | Tema escuro do sistema ligado | Telas legíveis, sem preto puro, etiquetas com texto | |
| M8 | Botão **Voltar** do Android com um formulário aberto | Fecha o formulário, não o app | |
| M9 | **Sair** e **Entrar** como B | Nenhum dado de A | |

## Evidências a guardar

- Capturas de W5, W11, W13, R2, I3, M1 e M4, com dados fictícios e sem barra de endereço contendo parâmetros de autenticação.
- Resultado das checagens: web `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`; mobile `pnpm typecheck`, `pnpm test`, `npx expo export --platform android`.
