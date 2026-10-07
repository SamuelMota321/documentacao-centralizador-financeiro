# S3-01 — O que os clientes web e mobile precisam do contrato

- Autor: Developer 2 (web e mobile) · 29/09/2026
- Para: Developer 1 (contrato e backend) e Developer 3 (critérios, cenários e decisões)
- Objetivo: fechar as decisões do S3-01 que mudam a interface, para o Developer 2 começar o S3-03/S3-04 sobre mocks do contrato proposto.
- Fontes: PRD 1.4 (HU-004, HU-007, RN-006 a RN-009), Arquitetura 1.6 ("Representação da importação OFX"), Plano da Sprint 3.

Cada item traz o **fato** que restringe a decisão, a **proposta** do Developer 2 e a **pergunta** que precisa de resposta. Propostas não são decisões: quem decide é quem o plano indica.

## 1. OFX — tamanho máximo do arquivo (bloqueia S3-02 e S3-03)

**Fatos:**

- No web, o access token nunca chega ao navegador (decisão da Sprint 1). O arquivo precisa passar pelo servidor Next, por Server Action ou Route Handler, antes de chegar ao backend.
- Server Actions aceitam no máximo **1 MB** de corpo por padrão. O limite é configurável (`serverActions.bodySizeLimit`) e inclui o overhead do `multipart/form-data`, de 10 a 20 KB (documentação do Next 16.3.4 instalado).
- A arquitetura hospeda o web na Vercel, onde uma função aceita no máximo **4,5 MB** de corpo, e esse limite não é configurável ([Vercel Functions Limits](https://vercel.com/docs/functions/limitations)).
- No mobile, o app chama o backend direto com o token, e só o limite do backend vale.

**Proposta:** limite abaixo de 4 MB, para passar pela Vercel com folga. O Developer 2 sugere **2 MB**: OFX é texto, e extratos de alguns meses devem ficar bem abaixo disso. **Vale confirmar com os arquivos de teste** antes de fixar. No web, o Developer 2 ajusta o `bodySizeLimit` para o valor decidido.

**Se a equipe quiser arquivos maiores que ~4 MB:** o envio pelo servidor Next deixa de funcionar na Vercel. Seria preciso upload direto para o R2 com URL pré-assinada emitida pelo backend. É mais trabalho no backend e nos dois clientes e não está no plano.

**Perguntas:**

1. Qual é o tamanho máximo?
2. O backend responde com qual código quando o arquivo passa do limite?

## 2. OFX — como o arquivo chega ao backend

**Proposta:** `multipart/form-data` com o arquivo num campo `file`, o mesmo formato nos dois clientes. A confirmação usa `Idempotency-Key`, com as mesmas regras de reuso e troca de chave de `POST /transactions` (os clientes já têm isso pronto).

**Perguntas:**

1. Qual é o nome do campo?
2. Quais tipos MIME e extensões são aceitos? (O PRD exclui PDF.)
3. Quais variantes e codificações de OFX são aceitas (SGML/1.x, XML/2.x, Latin-1, UTF-8)?

## 3. OFX — conta de destino (bloqueia a prévia)

**Fato:** o PRD não define como o extrato é associado a uma conta, e o plano lista isso como decisão pendente.

**Pergunta:** a pessoa escolhe a conta **antes** do envio (`accountId` no upload), ou o backend sugere a conta a partir do OFX e a pessoa confirma na prévia?

A escolha muda a tela: seletor de conta antes do arquivo, ou conta sugerida e editável na prévia. Um OFX pode trazer mais de uma conta? Se puder, a prévia precisa agrupar os itens por conta.

## 4. OFX — o que a prévia precisa devolver

Para os clientes mostrarem a prévia sem cálculos próprios:

| Campo | Para quê |
|---|---|
| `importRunId` e `status` | referência da prévia e da confirmação |
| conta de destino (ou sugestões) | ver item 3 |
| período do extrato (início e fim, datas civis AAAA-MM-DD) | contexto da prévia |
| contagens: total, novos, duplicados, inválidos | resumo no topo |
| itens: data civil, valor (string decimal, como `TransactionView.amount`), tipo `income`/`expense`, descrição, situação (`new`, `duplicate`, `invalid`) e código do motivo | lista da prévia |
| validade da prévia (`expiresAt`) | avisar "a prévia expirou, envie o arquivo de novo" |

**Perguntas:**

1. Os itens da prévia vêm paginados, como as outras listas (`page`/`pageSize`)?
2. Depois de importadas, as movimentações passam pelas regras pessoais de categorização (como no `POST /transactions`) ou chegam sem categoria?

## 5. OFX — duplicados (bloqueia a prévia e a confirmação)

**Fato:** o PRD aceita as duas formas ("ignoradas **ou** sinalizadas antes da gravação") e não define como identificar um duplicado.

Os clientes precisam de:

- uma lista fechada de motivos. Proposta: `ALREADY_IMPORTED` para o mesmo identificador de transação do OFX (FITID) já importado, e `POSSIBLE_MATCH` para uma movimentação existente com a mesma data, valor e conta;
- saber se a pessoa pode **incluir** um item sinalizado. Se puder, a confirmação precisa receber a lista de itens escolhidos.

**Proposta:** `ALREADY_IMPORTED` sempre ignorado, sem opção. `POSSIBLE_MATCH` sinalizado e ignorado por padrão, com opção de incluir, porque pode ser um lançamento manual que a pessoa quer substituir.

**Perguntas:**

1. Qual é a regra de identidade de um duplicado?
2. A pessoa pode incluir itens sinalizados?

## 6. OFX — confirmação, processamento longo e resultado

**Fato:** a arquitetura prevê que uma importação longa siga pelo QStash, com estado consultável.

Os clientes precisam de:

- **resposta da confirmação:** 200/201 com o resultado quando é síncrona, e 202 com `importRunId` quando é assíncrona. Estados como lista fechada (por exemplo `pending`, `processing`, `completed`, `failed`, `expired`);
- **consulta de estado:** `GET` por `importRunId`, com intervalo de consulta recomendado (`Retry-After` ou um valor documentado);
- **resultado:** contagens de importados, ignorados e com erro, os itens com erro e o código do motivo, e os ids das movimentações criadas, para o histórico destacar as linhas novas como já faz no registro manual.

**Perguntas:**

1. A partir de quando a importação vira assíncrona?
2. A consulta de estado é por uma importação só, ou existe uma lista de importações?

## 7. OFX — códigos de erro (Problem Details)

Os clientes nunca mostram o `detail` do backend: traduzem cada código para uma mensagem em português, como já fazem hoje. Precisam da lista fechada de códigos, por exemplo:

- arquivo grande demais;
- tipo não aceito, como PDF;
- estrutura ou codificação inválida;
- arquivo sem transações;
- conta de destino inválida ou arquivada;
- prévia expirada;
- prévia já confirmada;
- os códigos de `Idempotency-Key` já existentes.

**Pedido:** que esses códigos estejam no OpenAPI (respostas por operação), como os de Transactions.

## 8. Pluggy — contrato mínimo para S3-06 e S3-07

**Fatos:**

- O plano manda que só o backend tenha as credenciais da aplicação e que o cliente receba apenas um token de conexão temporário.
- O mobile já declara o scheme `coinciente` no `app.json`, e a documentação do Pluggy pede deep link para OAuth no mobile.

Os clientes precisam de:

1. **Endpoint que emite o token de conexão:** resposta com o token e o vencimento. O cliente pede um novo token a cada abertura do widget.
2. **Registro da conexão depois do sucesso no widget:** o cliente envia a referência do Item recebida e o backend a confere com o Pluggy antes de vincular ao tenant. O cliente não decide o vínculo.
3. **Estado da conexão:** lista fechada de estados e disponibilidade parcial por tipo de dado (HU-007).
4. **Listar e remover conexões:** remover interrompe novas coletas (HU-007). O que acontece com os dados já importados é decisão pendente no plano.
5. **URL de retorno do OAuth no mobile:** qual deep link cadastrar no Pluggy (proposta: `coinciente://pluggy`).

## 9. Dependências novas dos clientes (precisam de aprovação)

| Cliente | Dependência | Para quê |
|---|---|---|
| mobile | `expo-document-picker` | escolher o arquivo OFX (S3-04) |
| web | `react-pluggy-connect` | widget de conexão (S3-06) |
| mobile | `react-native-pluggy-connect` | widget de conexão (S3-07); compatibilidade com Expo SDK 57 ainda não verificada |

O plano já diz que citar os pacotes não os aprova. O Developer 2 verifica a compatibilidade antes de pedir a aprovação.

## 10. Do Developer 3

- Arquivos OFX sintéticos de teste, um por cenário: válido, com duplicados, inválido, vazio, grande, e com variante de codificação se houver. Cada cliente mantém sua cópia, sem compartilhar código entre web e mobile.
- Os cenários de aceite do S3-03 e do S3-04 escritos a partir das decisões acima.

## Resumo — o que destrava o Developer 2

1. Tamanho máximo (item 1).
2. Conta de destino: escolhida antes ou sugerida na prévia (item 3).
3. Regra de duplicado e se a pessoa pode incluir itens sinalizados (item 5).
4. Formato da prévia e do resultado (itens 4 e 6).
5. Lista de códigos de erro (item 7).

Com os itens 1 a 3 decididos, o Developer 2 começa os fluxos web e mobile sobre mocks do contrato proposto, como prevê o plano (S3-03 e S3-04, janela de 30/09 a 02/10).
