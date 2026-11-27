# Plano de recuperação e continuidade do Developer 3

**Estado de referência:** 23 de novembro de 2026

**Responsabilidade:** qualidade, contratos, isolamento, integração, documentação de evidências e aceite

**Leitor:** Developer 3 ou agente Codex encarregado de executar uma etapa isolada
**Ação esperada após a leitura:** selecionar o próximo plano elegível, executá-lo em uma conversa própria e registrar um handoff reproduzível antes de avançar.

## 1. Objetivo

Atualizar o Developer 3 em relação ao produto que já existe, fechar as validações históricas que ainda podem ser fechadas e registrar corretamente o que continua bloqueado por implementação, decisão ou ambiente.

Este plano não autoriza criar funcionalidades novas para substituir validações ausentes. A ordem é:

1. estabelecer o estado atual;
2. reconciliar contratos e documentação;
3. restabelecer a execução reproduzível;
4. fechar as Sprints 1, 2 e 3 naquilo que estiver implementado;
5. consolidar o baseline e os bloqueios da Sprint 4;
6. só então retomar as responsabilidades correntes da Sprint 5.

## 2. Regras de execução

- Execute um plano por conversa do Codex.
- Não execute o documento inteiro de uma vez.
- Antes de alterar qualquer repositório, leia suas instruções `AGENTS.md`.
- Cada conversa deve começar com investigação somente leitura e um plano específico para a etapa.
- Para autorizar alterações, envie exatamente: `planejamento aprovado, pode implementar`.
- Preserve alterações preexistentes e não as inclua nos commits do Developer 3.
- Não regenere snapshots ou altere testes apenas para obter uma suíte verde.
- Diferencie sempre: implementação presente, teste presente, teste executado, integração real, demonstração e aceite.
- Mocks não comprovam PostgreSQL/RLS, Auth0, Pluggy Sandbox, QStash ou armazenamento real.
- Dados de teste devem ser fictícios. Nunca registre segredos, tokens ou dados financeiros reais.
- Operações de banco devem usar exclusivamente ambiente local ou descartável explicitamente autorizado.
- Se uma falha pertencer ao produto, encaminhe-a ao responsável e mantenha o critério bloqueado. O Developer 3 não deve assumir silenciosamente o escopo do Dev 1 ou Dev 2.
- Cada plano deve terminar com evidências, limitações, bloqueios, responsáveis e a condição de entrada do próximo plano.

## 3. Estado conhecido no início da recuperação

### Sprint 1

Autenticação, contas, manutenção, auditoria e isolamento possuem implementação e cobertura relevante nos três repositórios. Falta transformar essa cobertura em execução atual, validação com banco e dois tenants, demonstração e aceite formal.

### Sprint 2

Movimentações, transferências, categorias, regras e isolamento de estado possuem implementação e testes. Faltam execução reproduzível de banco/E2E, demonstração cruzada web/mobile e fechamento da matriz de aceite.

### Sprint 3

OFX e Pluggy estão presentes no backend e nos dois clientes. A auditoria de 27 de outubro de 2026 que não localizou os clientes deve ser tratada como histórica.

Há uma divergência conhecida: o web acompanha o contrato Pluggy mais recente, com conclusão `202`, `Idempotency-Key` e importação inicial; o mobile ainda foi identificado usando o contrato anterior, com `200`, sem chave e sem o resultado da importação inicial. Essa divergência precisa ser revalidada no HEAD antes de qualquer aceite.

### Sprint 4

As histórias de sincronização, investimentos, alocação e patrimônio não estão implementadas como produto completo. Existe preparação parcial de `sync-runs` no web baseada em contrato e fixtures. Isso não comprova backend, tela, processamento ou integração. O Developer 3 pode fechar o baseline S4-01, mas não pode declarar P59/P60 ou a Sprint 4 concluídos enquanto as histórias dependentes estiverem ausentes.

### Sprint 5

Já existem documentação e trabalho de dashboard no web. O Developer 3 só inicia seu baseline corrente depois do gate de recuperação definido neste documento.

## 4. Artefatos de evidência

Use os artefatos existentes antes de criar novos documentos:

- prompts do Developer 3 das Sprints 1 a 4, acrescentando `Execution handoff` após cada execução;
- roteiros de demonstração das Sprints 2 e 3;
- contratos dos clientes e contrato/OpenAPI do backend;
- baseline e decisões S4-01;
- auditorias existentes como histórico.

Crie apenas um artefato novo para centralizar a recuperação: uma auditoria atual do Developer 3. Ela deve apontar para revisões Git, critérios e resultados, sem copiar grandes trechos de código ou logs.

## 5. Seleção de modelo no Codex

As recomendações abaixo são um ponto de partida. A disponibilidade varia por conta e produto; confira os modelos oferecidos no seletor do Codex. A orientação oficial recomenda GPT-6.2 Sol para a maioria das tarefas no Codex e GPT-6.2 Astra para projetos complexos e análise exigente: <https://developers.openai.com/api/docs/guides/model-selection>.

| Plano | Modelo recomendado | Raciocínio | Motivo |
|---|---|---:|---|
| 00 — Estado de referência | GPT-6.2 Astra | high | Reconciliação entre quatro repositórios e preservação de mudanças locais. |
| 01 — Matriz mestra | GPT-6.2 Astra | high | Classificação criteriosa de requisitos e evidências heterogêneas. |
| 02 — Contratos e documentação | GPT-6.2 Astra | high | Conflitos entre OpenAPI, snapshots, implementação e decisões históricas. |
| 03 — Base de execução | GPT-6.2 Sol | high | Instalação controlada, execução de ferramentas e diagnóstico objetivo. |
| 04 — Fechamento Sprint 1 | GPT-6.2 Sol | xhigh | Validação multirrepositório, banco, autenticação e isolamento. |
| 05 — Fechamento Sprint 2 | GPT-6.2 Sol | xhigh | Cenários de atomicidade, idempotência e estado cruzado. |
| 06 — Fechamento Sprint 3 | GPT-6.2 Astra | xhigh | Integrações externas, divergências contratuais e decisões abertas. |
| 07 — Baseline Sprint 4 | GPT-6.2 Astra | high | Critérios ainda condicionados e separação entre baseline e produto. |
| 08 — Consolidação histórica | GPT-6.2 Sol | medium | Síntese documental baseada em evidências já produzidas. |
| 09 — Continuidade Sprint 5 | GPT-6.2 Astra | high | Novo baseline transversal sobre trabalho já em andamento. |

Use `xhigh` somente quando a etapa realmente envolver execução longa e revisão cruzada. Se custo ou latência forem relevantes, comece com Sol em `high` e migre para Astra apenas quando houver conflito de fontes, decisão arquitetural ou investigação que não convergiu.

## 6. Como iniciar uma etapa no Codex

Abra uma conversa nova com o repositório de documentação como workspace principal e os repositórios backend, web e mobile disponíveis. Selecione o modelo recomendado e envie:

```text
Leia o Plano de recuperação e continuidade do Developer 3 e execute somente o Plano NN — <nome>.

Antes de qualquer alteração:
1. leia os AGENTS.md aplicáveis;
2. verifique branch, HEAD e working tree dos repositórios em escopo;
3. investigue apenas o necessário para esta etapa;
4. apresente um plano específico, arquivos afetados, riscos e validação;
5. aguarde a autorização literal exigida pelo repositório.

Durante a execução, preserve mudanças preexistentes, não assuma trabalho de outros developers e não declare como aprovado nada que não tenha sido executado. Termine com evidências, bloqueios, responsáveis e condição de entrada do próximo plano.
```

Depois de revisar o plano específico apresentado pelo Codex, autorize com:

```text
planejamento aprovado, pode implementar
```

Não reutilize essa autorização em outra conversa ou outro plano. Cada etapa pode descobrir arquivos, riscos ou dependências diferentes.

## 7. Plano 00 — Congelar o estado de referência

### Objetivo

Criar uma base verificável para todo o trabalho posterior.

### Tarefas

1. Registrar branch, HEAD, data do commit, remoto e working tree dos quatro repositórios.
2. Identificar sem alterar as modificações locais existentes, especialmente dependências do web.
3. Criar a auditoria atual do Developer 3, separada da auditoria histórica de outubro.

### Entregável

Auditoria com inventário dos repositórios, fontes consultadas, escopo, limitações e tabela inicial dos prompts P13–P60 pertencentes ao Developer 3.

### Critério de saída

- toda evidência futura pode ser ligada a um commit;
- mudanças preexistentes estão identificadas e preservadas;
- a auditoria antiga está explicitamente classificada como histórica;
- nenhuma suíte é declarada atual apenas por ter resultado histórico.

### Prompt curto

```text
Execute somente o Plano 00 deste documento. Produza o estado de referência dos quatro repositórios e a auditoria atual do Developer 3. Não instale dependências, não rode integrações externas e não altere código de produto.
```

## 8. Plano 01 — Construir a matriz mestra

### Pré-requisito

Plano 00 concluído.

### Objetivo

Relacionar todas as responsabilidades históricas do Developer 3 ao estado atual.

### Tarefas

1. Mapear P13–P15, P33–P35, P48–P50 e P58–P60 por critério observável.
2. Classificar cada critério como verificado, implementado mas não revalidado, parcial, bloqueado, não implementado ou obsoleto.
3. Registrar fonte, evidência, comando ou cenário, ambiente necessário, responsável e próxima ação.

### Critério de saída

- não existem critérios genéricos como “testar tudo”;
- handoffs de Dev 1 e Dev 2 aparecem como insumos, não como aceite;
- cada bloqueio tem responsável e condição de desbloqueio;
- a matriz distingue presença de código, presença de teste e execução observada.

### Prompt curto

```text
Execute somente o Plano 01 deste documento. Atualize a auditoria do Developer 3 com uma matriz por critério para P13–P60. Não execute testes ainda e não altere código de produto.
```

## 9. Plano 02 — Reconciliar contratos e documentação vigente

### Pré-requisito

Matriz mestra disponível.

### Objetivo

Remover contradições que tornariam os testes ou o aceite ambíguos.

### Tarefas

1. Comparar o OpenAPI vigente do backend com os snapshots e schemas dos dois clientes.
2. Corrigir somente a documentação vigente, preservando registros históricos claramente marcados.
3. Registrar divergências de produto como defeitos reproduzíveis para o responsável, sem corrigir silenciosamente o escopo alheio.

### Verificações obrigatórias

- conclusão Pluggy `200` versus `202`;
- presença e obrigatoriedade de `Idempotency-Key`;
- resposta e acompanhamento de `initialImport`;
- expiração e retenção OFX;
- mapeamento e elegibilidade de contas;
- estados, respostas e erros publicados;
- presença das rotas HU-008 no backend vigente e compatibilidade dos clientes com o contrato publicado;
- snapshots gerados a partir da revisão correta.

### Critério de saída

- cada cliente aponta para um contrato compatível ou declara um bloqueio exato;
- nenhum snapshot é atualizado sem análise do diff;
- documentação histórica não descreve indevidamente o estado atual;
- o desvio mobile Pluggy está corrigido em plano próprio ou encaminhado ao Dev 2.

### Prompt curto

```text
Execute somente o Plano 02 deste documento. Reconcile OpenAPI, snapshots, schemas e documentação. Não implemente funcionalidades novas; transforme divergências de produto em achados reproduzíveis com responsável.
```

## 10. Plano 03 — Restabelecer a base de execução

### Pré-requisito

Contratos reconciliados ou divergências explicitamente bloqueadas.

### Objetivo

Obter resultados atuais e reproduzíveis das verificações que não dependem de integrações reais.

### Tarefas

1. Restaurar dependências de forma reproduzível, preservando alterações locais e arquivos de lock.
2. Executar testes unitários e de contrato nos três repositórios.
3. Executar typecheck, lint e build aplicáveis, registrando resultados completos de forma resumida.

### Ordem de execução

1. backend: unitários e contrato OpenAPI;
2. web: testes, typecheck, lint e build;
3. mobile: testes, typecheck e verificações compatíveis com a versão do Expo;
4. backend: typecheck, lint e build.

Integração de banco, E2E real e serviços externos ficam para os planos seguintes.

### Critério de saída

- cada comando possui revisão, data, código de saída e resumo;
- falhas estão classificadas como produto, teste, contrato, ambiente ou ferramenta;
- contagens históricas não são reutilizadas como resultado atual;
- instalações ou limitações do ambiente são documentadas sem alterar dependências por conveniência.

### Prompt curto

```text
Execute somente o Plano 03 deste documento. Restabeleça a execução local e rode validações determinísticas. Pare antes de banco, Auth0, Pluggy, QStash, R2 ou qualquer serviço externo.
```

## 11. Plano 04 — Fechar a Sprint 1

### Pré-requisito

Base determinística verde ou falhas conhecidas que não invalidem os cenários.

### Objetivo

Fechar autenticação, contas, manutenção e isolamento com evidência atual.

### Tarefas

1. Executar migrations, integração, E2E e RLS em PostgreSQL descartável autorizado.
2. Validar autenticação e isolamento com dois usuários e tenants fictícios em web e mobile.
3. Executar a demonstração e preencher os handoffs P13–P15.

### Cenários mínimos

- token ausente, inválido e expirado;
- login, sessão, expiração e logout;
- criar, listar, editar e desativar conta;
- persistência e auditoria;
- leitura e mutação cross-tenant;
- troca de usuário sem reaproveitar estado;
- compatibilidade OpenAPI dos dois clientes;
- demonstração atual em web e mobile.

### Critério de saída

S1-01–S1-09 estão verificados ou possuem bloqueio residual preciso. RLS precisa de banco real; mocks não bastam. P13–P15 recebem `Execution handoff` com comandos, resultados e revisão.

### Prompt curto

```text
Execute somente o Plano 04 deste documento e feche a Sprint 1 sob responsabilidade do Developer 3. Use dois tenants fictícios e PostgreSQL descartável autorizado. Não avance para movimentações.
```

## 12. Plano 05 — Fechar a Sprint 2

### Pré-requisito

Sprint 1 fechada ou com bloqueio residual que não contamine a Sprint 2.

### Objetivo

Fechar movimentações, transferências, categorias, regras e isolamento de estado.

### Tarefas

1. Executar integração/E2E de domínio, persistência e REST.
2. Validar atomicidade, idempotência, RLS, auditoria, conflitos e falhas.
3. Executar o roteiro web/mobile com dois tenants e preencher P33–P35.

### Cenários mínimos

- receita, despesa e transferência;
- repetição com a mesma chave;
- falha transacional sem gravação parcial;
- categorização automática, incerta e manual;
- precedência e conflito entre regras;
- ativação, desativação e remoção;
- propriedade e negação cross-tenant;
- troca de usuário com resposta atrasada;
- reflexo observado entre web e mobile.

### Critério de saída

S2-01–S2-09 possuem resultado por plataforma, o roteiro não contém campos observados vazios e P33–P35 registram revisão, ambiente e limitações.

### Prompt curto

```text
Execute somente o Plano 05 deste documento e feche a Sprint 2 sob responsabilidade do Developer 3. Reutilize a base validada da Sprint 1 e não avance para OFX ou Pluggy.
```

## 13. Plano 06 — Regularizar e fechar a Sprint 3

### Pré-requisito

Contrato atual reconciliado e defeitos impeditivos encaminhados.

### Objetivo

Fechar OFX e Pluggy separando testes sintéticos de integrações autorizadas.

### Tarefas

1. Resolver ou bloquear formalmente divergências de contrato, identidade, mapping, replay, concorrência, auditoria, expiração e retenção.
2. Executar OFX ponta a ponta com banco e armazenamento autorizados, usando arquivos e dados fictícios.
3. Executar Pluggy Sandbox, importação inicial e processamento assíncrono quando o ambiente estiver autorizado.

### Verificações obrigatórias

- variantes OFX, arquivo inválido, prévia, confirmação, duplicidade e expiração;
- isolamento, auditoria, retenção e limpeza;
- criação de sessão Pluggy, conclusão idempotente e consulta;
- importação inicial, replay e concorrência;
- mapping `link`/`create` e conta não elegível;
- deduplicação D13 com evidência de fonte primária;
- web e mobile contra a mesma revisão do contrato;
- estados parciais, indisponibilidade e falhas do provedor;
- separação explícita entre fixture, banco/storage, Sandbox e QStash.

### Critério de saída

P48–P50 e o roteiro S3 possuem resultados observados. Nenhum critério de Sandbox, armazenamento, QStash ou RLS é aprovado por mock. Decisões de Produto permanecem bloqueadas com dono identificado.

### Prompt curto

```text
Execute somente o Plano 06 deste documento e regularize a Sprint 3. Comece revalidando a divergência Pluggy mobile no HEAD. Não faça chamadas externas sem ambiente e autorização explícitos.
```

## 14. Plano 07 — Fechar o baseline da Sprint 4

### Pré-requisito

Estado herdado da Sprint 3 conhecido.

### Objetivo

Atualizar S4-01 e produzir critérios executáveis sem declarar produto inexistente.

### Tarefas

1. Consolidar backend, mapeamento do Dev 2 e estado real dos clientes.
2. Definir critérios verificáveis para HU-008, HU-009, HU-011 e HU-012.
3. Registrar decisões, bloqueios e condições de entrada para validação incremental.

### Decisões e dependências mínimas

- intervalo de consulta do cliente;
- horário, fuso e janela diária;
- retries, backoff e retenção;
- causas e ações de `action_required`;
- recuperação da última execução;
- regra de conta correspondente;
- campos e capacidades do provedor para investimentos;
- ausência, indisponibilidade e defasagem;
- denominador, moedas e arredondamento;
- modelo de bens, passivos, financiamento, histórico e auditoria.

### Critério de saída

P58 pode ser encerrado como baseline. P59 e P60 permanecem bloqueados quando as quatro histórias não estiverem implementadas. A camada web de `sync-runs` baseada em fixtures não é descrita como funcionalidade entregue.

### Prompt curto

```text
Execute somente o Plano 07 deste documento. Consolide S4-01 e os critérios das quatro HUs. Não implemente as HUs e não declare P59/P60 concluídos sem produto executável.
```

## 15. Plano 08 — Consolidar o fechamento histórico

### Pré-requisito

Planos 00–07 executados ou formalmente bloqueados.

### Objetivo

Produzir um ponto único e confiável para continuidade.

### Tarefas

1. Revisar e completar os `Execution handoff` dos prompts executados.
2. Consolidar a auditoria por sprint e critério, sem duplicar logs.
3. Registrar defeitos, decisões e dependências encaminhados ao Dev 1, Dev 2, Produto ou responsável pelo ambiente.

### Estado final esperado

- Sprint 1: fechada ou com bloqueio residual explícito;
- Sprint 2: fechada ou com bloqueio residual explícito;
- Sprint 3: fechada, ou condicional com poucos bloqueios exatos;
- Sprint 4: baseline fechado e produto ainda em construção;
- nenhuma tarefa sem status, responsável ou próxima ação.

### Critério de saída

Um leitor novo consegue saber o que foi executado, em qual revisão, em qual ambiente, o que falhou e qual é a próxima ação sem consultar esta conversa.

### Prompt curto

```text
Execute somente o Plano 08 deste documento. Consolide os handoffs e a auditoria sem executar novas funcionalidades nem repetir testes que já tenham evidência válida no mesmo HEAD.
```

## 16. Plano 09 — Retomar as responsabilidades correntes

### Gate de entrada

- P13–P15 e P33–P35 fechados ou bloqueados com evidência atual;
- P48–P50 com contrato reconciliado e bloqueios ambientais exatos;
- P58 consolidado;
- P59/P60 corretamente bloqueados pelas histórias ausentes;
- resultados atuais das suítes registrados;
- documentação histórica separada da vigente.

### Objetivo

Iniciar o baseline do Developer 3 para Sprint 5/HU-010 e passar a acompanhar novas entregas de forma incremental.

### Tarefas

1. Reconciliar requisitos do dashboard com o que já existe no web e com as fontes de dados disponíveis.
2. Definir critérios para cálculos, estados vazios/parciais, acessibilidade, contratos e demonstração.
3. Estabelecer o ciclo contínuo: baseline antes da implementação, evidência durante a entrega e fechamento no fim da fase.

### Critério de saída

O Developer 3 deixa de atuar por recuperação histórica e passa a atuar preventivamente, com critérios e evidências acompanhando o desenvolvimento corrente.

### Prompt curto

```text
Confirme primeiro o gate do Plano 09. Se estiver atendido, execute somente o baseline do Developer 3 para Sprint 5/HU-010. Não assuma que o dashboard existente já satisfaz os critérios.
```

## 17. Handoff obrigatório de cada plano

Ao terminar uma etapa, o Codex deve registrar:

```markdown
## Execution handoff

- Plano executado:
- Repositórios e revisões:
- Arquivos alterados:
- Critérios verificados:
- Comandos executados e resultados:
- Verificações não executadas:
- Defeitos encontrados e responsáveis:
- Decisões ainda abertas:
- Bloqueios de ambiente:
- Riscos residuais:
- Próximo plano elegível:
- Condição de entrada do próximo plano:
```

Se o plano estiver bloqueado, o handoff deve registrar o bloqueio sem marcar a etapa como concluída. Um bloqueio não autoriza pular silenciosamente para a próxima sprint.

## 18. Como acompanhar o progresso

Use esta tabela como índice. Atualize o status somente com evidência registrada no handoff correspondente.

| Plano | Status inicial | Saída esperada |
|---|---|---|
| 00 | Não iniciado | Estado dos quatro repositórios congelado |
| 01 | Não iniciado | Matriz P13–P60 atual |
| 02 | Concluído com ressalvas | Contratos reconciliados e divergências com responsáveis. B01 mobile aprovado no Pluggy Sandbox em 25/11/2026. Reteste web e demais achados pendentes. [Handoff do Plano 02](../../auditorias/auditoria-dev3-atual-2026-11-23.md#execution-handoff--plano-02) · [Reteste no tablet](../../auditorias/auditoria-dev3-atual-2026-11-23.md#reteste-pluggy-no-tablet-em-25112026). |
| 03 | Concluído | Base determinística dos três produtos verificada. Web aprovado com instalação limpa offline e build padrão com fontes locais. [Handoff final do Plano 03](../../auditorias/auditoria-dev3-atual-2026-11-23.md#handoff-final-do-plano-03). |
| 04 | Bloqueado | Testes focados e contratos de contas aprovados em 26/11/2026. PostgreSQL/RLS e demonstração Auth0 com duas identidades em web e Android pendentes. [Handoff do Plano 04](../../auditorias/auditoria-dev3-atual-2026-11-23.md#execution-handoff--plano-04). |
| 05 | Não iniciado | Sprint 2 aceita ou bloqueada com precisão |
| 06 | Não iniciado | Sprint 3 aceita ou condicionada com precisão |
| 07 | Não iniciado | Baseline Sprint 4 fechado |
| 08 | Não iniciado | Fechamento histórico consolidado |
| 09 | Bloqueado pelo gate | Baseline corrente Sprint 5 iniciado |

Status permitidos: `não iniciado`, `em execução`, `bloqueado`, `concluído com ressalvas` e `concluído`.

## 19. Definição de pronto da recuperação

A recuperação do Developer 3 termina quando:

- o estado dos quatro repositórios está ligado a revisões exatas;
- todos os critérios históricos do Developer 3 possuem status e evidência;
- os contratos backend/web/mobile estão reconciliados ou possuem divergência formal;
- Sprints 1 e 2 foram revalidadas no nível necessário;
- Sprint 3 separa claramente mocks de integrações reais;
- Sprint 4 possui baseline atual sem falso fechamento;
- documentação histórica não é usada como estado presente;
- bloqueios têm responsáveis e próximas ações;
- o gate do Plano 09 pode ser avaliado objetivamente.

Depois disso, o trabalho do Developer 3 deve acompanhar cada nova entrega desde o baseline até o aceite, evitando outra rodada de recuperação retrospectiva.
