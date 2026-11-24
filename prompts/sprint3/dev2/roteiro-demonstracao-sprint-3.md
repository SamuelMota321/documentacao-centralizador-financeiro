# Roteiro de demonstração da Sprint 3 — clientes web e mobile (Dev 2)

- Escopo: parte web e mobile de S3-03, S3-04, S3-06 e S3-07, e a contribuição do Dev 2 para S3-08 (isolamento e evidências).
- Dados: exclusivamente fictícios e Sandbox. Dois usuários de teste no mesmo tenant Auth0 do backend (A e B), cada um com o próprio espaço financeiro. Arquivos OFX somente os sintéticos de `backend-centralizador-financeiro/test/fixtures/ofx/`.
- Nunca mostrar: `.env` (dos clientes ou do backend), tokens, `connectToken`, aba de rede do navegador, URLs com parâmetros de autenticação, credenciais do Auth0, do R2 ou do Pluggy.
- Preencha a coluna **Observado** durante a execução. Não marque como feito o que não foi executado; um passo bloqueado por ambiente é anotado como bloqueado.

> **Revisões verificadas em 24/11/2026:** backend `b9f6a7a`, web `0071713` e
> mobile `859abac`. Este roteiro registra o que é possível demonstrar e as
> condições de cada etapa. A [auditoria atual do Dev 3](../../../auditorias/auditoria-dev3-atual-2026-11-23.md#14-plano-02--revisões-e-procedência)
> traz a comparação dos contratos. Preencha a coluna Observado com o resultado real.

## Preparação

1. Backend: `docker compose up -d --wait` em `backend-centralizador-financeiro` (usa npm, nunca pnpm). API em `http://localhost:3100/api/v1` com `compose.override.yaml`. O serviço `migrate` precisa terminar com sucesso (inclui as migrations de conexões e importação inicial Pluggy da revisão usada).
2. Credenciais no `.env` **do backend**, nunca nos clientes:
   - OFX: `R2_ENDPOINT`, `R2_BUCKET_NAME`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY` (as quatro juntas). Sem elas, a prévia responde 503 e as Partes 1, 2 e 4 ficam bloqueadas.
   - Pluggy: `PLUGGY_CLIENT_ID` e `PLUGGY_CLIENT_SECRET` do Sandbox, junto com `PLUGGY_WEBHOOK_*`, `QSTASH_*` e `PUBLIC_API_BASE_URL` (o backend exige o conjunto completo). Sem elas, as Partes 3 e 4 ficam bloqueadas.
3. Web: `pnpm dev` em `web-centralizador-financeiro` → `http://localhost:3001`.
4. Mobile: `pnpm start` em `mobile-centralizador-financeiro`, com a aplicação Auth0 **Native** configurada (README do mobile, passo 4.1), no Expo Go de um celular Android.
5. Usuários A e B criados no Auth0 com e-mails fictícios. A tem as contas "Conta do dia a dia" (corrente) e "Reserva" (poupança); se não tiver, crie em Contas → **Nova conta**.
6. Arquivos copiados para o computador (web) e para o celular (mobile): `ofx-1-bank-ascii.ofx`, `ofx-2-credit-card-utf8.ofx`, `malformed.ofx`, `unsupported-pdf.pdf`, além de um `vazio.ofx` com 0 bytes e um arquivo fictício maior que 4 MiB.

## Parte 1 — Importação OFX no web, usuário A

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| O1 | Contas → **Importar extrato OFX** | Tela "Importar extrato OFX" com **Conta de destino** e arquivo | |
| O2 | Escolher "Conta do dia a dia" e `ofx-1-bank-ascii.ofx` → **Gerar prévia** | Prévia com "Nada foi gravado ainda. Confira as linhas e confirme."; 1 linha nova ("Mercado", − R$ 25,90) | |
| O3 | **Importar 1 movimentação** | Toast "Importação concluída. Confira o resultado abaixo."; resultado com 1 importada | |
| O4 | Abrir Movimentações | "Mercado" − R$ 25,90 aparece uma única vez | |
| O5 | Importar de novo o mesmo arquivo na mesma conta → **Gerar prévia** | A linha aparece como "Já registrada — será ignorada" e "Todas as linhas já estão registradas nesta conta. Não há nada novo para importar."; o botão de importar fica desativado | |
| O6 | Escolher `unsupported-pdf.pdf` | "Arquivos PDF não são aceitos. Exporte o extrato do banco no formato OFX." sem envio | |
| O7 | Escolher `vazio.ofx` | "O arquivo está vazio. Escolha o extrato OFX exportado pelo banco." sem envio | |
| O8 | Escolher o arquivo maior que 4 MiB | "O arquivo passa de 4 MB. Exporte um período menor no banco." sem envio | |
| O9 | Escolher `malformed.ofx` → **Gerar prévia** | "Não foi possível ler este OFX. Confira se é o extrato exportado pelo banco." | |

## Parte 2 — Confirmação dupla e reenvio sem duplicar (web)

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| D1 | Gerar prévia de `ofx-2-credit-card-utf8.ofx` na "Conta do dia a dia" e dar clique duplo em **Importar 1 movimentação** | Um único "Café da manhã" + R$ 102,50 em Movimentações | |
| D2 | Gerar prévia de `ofx-1-bank-ascii.ofx` na "Reserva", parar o backend (`docker compose stop api`) e **Importar** | Mensagem de falha; a prévia continua na tela | |
| D3 | Subir o backend (`docker compose start api`) e **Importar** de novo sem recarregar | Resultado normal e uma única movimentação importada | |

## Parte 3 — Conexão Pluggy Sandbox no web, usuário A

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| P1 | Contas → **Conectar banco (Sandbox)** | Explicação do que é autorizado: só leitura, Sandbox, nunca pagamento ou Pix, senha do banco não passa pelo Coinciente | |
| P2 | **Conectar** e fechar a janela do Pluggy sem escolher banco | "Conexão cancelada. Nada foi registrado." | |
| P3 | **Conectar** → conector "Pluggy Bank" com as credenciais de teste exibidas pelo Pluggy | "Conexão registrada."; detalhe com estado em texto ("Conectada" ou "Aguardando autorização"), produtos autorizados e datas | |
| P4 | Com autorização pendente ou importação inicial em andamento, selecionar **Verificar de novo** | O detalhe consulta a conexão por `connectionId` e atualiza o estado. Acompanhar `initialImport` separadamente do consentimento. Se ficar em `awaiting_account_mapping`, registrar P02-01 como bloqueio de mapeamento nos clientes. | |
| P5 | Recarregar a página (a URL tem `?conexao=`) | A mesma conexão é exibida, sem nada guardado no navegador | |
| P6 | Se o Sandbox oferecer um conector com dados parciais, conectar por ele | "Parcialmente disponível" com o texto de que só parte dos dados foi liberada. Se não houver conector assim, anotar "não disponível no Sandbox" | |
| P7 | **Remover conexão** → **Cancelar** no diálogo | Nada muda | |
| P8 | **Remover conexão** → confirmar | "Conexão removida. A coleta de novos dados parou."; estado "Desconectada" e **Conectar de novo** disponível | |

## Parte 4 — Mobile, usuário A

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| M1 | Contas → **Importar extrato OFX** → **Escolher arquivo** → `ofx-1-bank-ascii.ofx` na conta de O1 → **Gerar prévia** | A linha aparece como já registrada (importada em O3) | |
| M2 | **Escolher outro arquivo** → `unsupported-pdf.pdf` | Recusado antes do envio, com a mensagem de PDF | |
| M3 | Importar `ofx-2-credit-card-utf8.ofx` na "Reserva" e confirmar | Resultado com 1 importada; Movimentações mostra a linha | |
| M4 | Contas → **Conectar banco (Sandbox)** → **Conectar** → "Pluggy Bank" | **Bloqueado por B01.** O checkout mobile omite `Idempotency-Key` e o backend responde `400` nessa condição. Após a correção do Dev 2, esperar `202` com `connection` e `initialImport` e conferir a atualização do detalhe. | |
| M5 | **Conectar** e usar o botão Voltar do Android dentro do widget | Fecha o widget como cancelamento; nada registrado | |
| M6 | Em uma conexão de teste existente, selecionar **Remover conexão** → **Remover** | Mensagem de remoção e estado "Desconectada". Sem conexão de teste acessível, registrar o bloqueio de pré-condição. | |

## Parte 5 — Isolamento entre usuários

| # | Ação | Resultado esperado | Observado |
|---|---|---|---|
| I1 | No web, anotar a URL `/contas/conectar?conexao=<id>` da conexão de A (P5). Menu da conta → **Sair** | Volta à página de entrada | |
| I2 | Botão **Voltar** do navegador | Nenhuma prévia, resultado ou conexão de A; as rotas pedem login | |
| I3 | **Entrar** como B e abrir a URL anotada em I1 | "Esta conexão não foi encontrada. Ela pode ter sido feita por outra pessoa ou removida." (o mesmo texto de uma conexão inexistente); nada de A aparece | |
| I4 | Como B, abrir Contas → **Importar extrato OFX** | Só as contas de B no seletor; nenhuma prévia de A | |
| I5 | No mobile, com uma prévia aberta como A, **Sair** e **Entrar** como B | Nenhuma prévia, arquivo escolhido ou conexão de A | |

## Evidências a guardar

- Capturas de O2, O3, O5, D1, P1, P3, P8, I3, M1 e M4, com dados fictícios e sem barra de endereço contendo parâmetros de autenticação ou `connectToken`.
- Resultado das checagens: web `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`; mobile `pnpm typecheck`, `pnpm test`, `npx expo export --platform android`.
- Passos bloqueados por falta de credenciais R2 ou Pluggy, anotados como bloqueados, nunca como aprovados.

## Limitações e bloqueios da demonstração

- A S3-08 exige que a prévia expire em 24 horas. A API atual omite `expiresAt`
  e o caminho de confirmação não verifica a idade da prévia. Registrar B03
  como bloqueio da demonstração de vencimento. O prazo de retenção de metadados
  e a expiração da chave são critérios distintos.
- Não há lista de conexões; cada sessão aberta e cancelada deixa uma conexão "Aguardando autorização" no backend.
- O backend inicia a importação e publica o `PUT` de mapeamento. O web lê o
  estado da importação inicial. As ações `link`/`create` seguem bloqueadas
  nos clientes e a conclusão Pluggy mobile depende de B01. O roteiro cobre
  os passos disponíveis sem presumir importação de transações concluída.
- No mobile, o OAuth das instituições abre numa WebView dentro do app, e as WebViews do SDK do Pluggy mantêm cookies entre usuários do mesmo aparelho.
