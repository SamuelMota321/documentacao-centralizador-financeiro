**O projeto tem implementação local consistente das funcionalidades das Sprints 1 e 2, backend parcial da Sprint 3 e planejamento da Sprint 4. Não há evidência suficiente para declarar essas sprints integralmente aceitas.** O maior descompasso está entre os handoffs da Sprint 3 e os clientes disponíveis: os documentos relatam OFX/Pluggy implementados, mas esses arquivos não aparecem nos checkouts web/mobile inspecionados.

A auditoria foi realizada em **27/10/2026**, sem alterações nos arquivos do projeto.

## 1. Avaliação geral

| Repositório | HEAD auditado | Alterações locais preexistentes |
|---|---|---|
| Documentação | `fea1b578d5aac5e5d67db728a21a13cc2636e2fb` | Baseline backend S4-01 modificado |
| Backend | `5414ea5642a854237f0a535e481a96d072c086b5` | Nenhuma |
| Web | `35f8fe81c0300efde33c8a17d87373c88fd6e8e1` | `CONTRACT.md` modificado |
| Mobile | `230e6b4f70d74cdb08df43255b70467fbe5e3765` | `CONTRACT.md` modificado |

**Fatos estabelecidos, confiança alta:**

- As suítes locais selecionadas passaram: **163 testes backend, 491 web e 370 mobile**.
- Backend contém autenticação, contas, Transactions, OFX e conexão/importação inicial Pluggy.
- Os clientes inspecionados contêm contas, movimentações, categorias e regras; não contêm os fluxos OFX/Pluggy relatados nos handoffs da Sprint 3.
- Os snapshots cliente referenciam `fa9b62a`, têm 15 caminhos e diferem da OpenAPI backend atual, que tem 24.
- Não foram encontrados domínio/API/modelos de sincronização HU-008, investimentos HU-009, alocação HU-011 ou patrimônio manual HU-012.

**Inferência, confiança alta:** o próximo trabalho deve começar pela reconciliação das entregas e dos contratos da Sprint 3, acompanhada do fechamento das decisões S4-01. Executar diretamente os prompts de implementação da Sprint 4 deixaria pré-requisitos relevantes sem resolução.

**Incertezas:** execução real de migrations/RLS, integração entre aplicações, Sandbox, dispositivos, pipelines e a localização do código cliente relatado na Sprint 3.

## 2. Inventário e cobertura dos prompts

Foram encontrados **62 arquivos**, sem duplicatas byte a byte. A distribuição correta é: 2 gerais, 13 da Sprint 1, 22 da Sprint 2 — incluindo três complementos —, 15 da Sprint 3 e 10 da Sprint 4.

Os IDs abaixo identificam os prompts nesta auditoria. As entregas enumeradas na seção seguinte constituem os requisitos auditáveis associados a cada ID.

**Fontes comuns:** [Visão](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/produto/visao.html), [PRD](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/produto/prd.html), [Arquitetura](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/arquitetura/arquitetura.html), [ADR de RLS](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/arquitetura/adr-rls-postgresql.html), planos das respectivas sprints e OpenAPI backend.

### Prompts gerais e Sprint 1

| ID e arquivo | Propósito, materiais e dependências |
|---|---|
| P01 — [Atualizar plano Sprint 1](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/atualizar-plano-divisao-atividades-sprint-1.md) | Converter/adaptar o plano PDF para HTML; preservar objetivo, sequência e três desenvolvedores; usar Visão/PRD/Arquitetura e atualizar navegação. |
| P62 — [Alinhar documentos de arquitetura](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/update-architecture-documents.md) | Alinhar Visão, PRD e Arquitetura ao MVP aprovado; pesquisa arquitetural é entrada, não alvo de edição. |
| P03 — [Dev 1: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev1/dev-1-sprint-1-fase-1-baseline.md) | S1-01 backend: limites Clean/Hexagonal, Identity/Accounts, persistência, tenancy e tecnologias aprovadas. |
| P04 — [Dev 1: fundação/modelagem](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev1/dev-1-sprint-1-fase-2-fundacao-modelagem.md) | S1-02/03: NestJS, Prisma, PostgreSQL, containers, migrations e modelos; depende do baseline. |
| P05 — [Dev 1: autenticação/contas](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev1/dev-1-sprint-1-fase-3-autenticacao-contas.md) | S1-04/05: JWT/identidade/tenant, criação/listagem, validação e OpenAPI; depende da fundação. |
| P06 — [Dev 1: manutenção/isolamento](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev1/dev-1-sprint-1-fase-4-manutencao-isolamento.md) | S1-06/07: atualização/desativação, auditoria, autorização e RLS; depende dos fluxos anteriores. |
| P07 — [Dev 1: testes/consolidação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev1/dev-1-sprint-1-fase-5-testes-consolidacao.md) | S1-08/09 backend: testes, JSON inválido/Problem Details, migrations novas, RLS, build e handoff. |
| P08 — [Dev 2: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev2/dev-2-sprint-1-fase-1-baseline.md) | Independência web/mobile, Auth0, contrato tipado e validação de borda. |
| P09 — [Dev 2: fundação/contrato](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev2/dev-2-sprint-1-fase-2-fundacao-contrato.md) | Fundação dos clientes, configuração e modelos; depende do baseline e contrato backend. |
| P10 — [Dev 2: autenticação/contas](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev2/dev-2-sprint-1-fase-3-autenticacao-contas.md) | Login/logout, proteção, sessão e criar/listar contas nas duas plataformas. |
| P11 — [Dev 2: manutenção/isolamento](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev2/dev-2-sprint-1-fase-4-manutencao-isolamento.md) | Editar/desativar com confirmação, limpar estado e tratar negação de acesso. |
| P12 — [Dev 2: testes/consolidação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev2/dev-2-sprint-1-fase-5-testes-consolidacao.md) | Testes, execução/build, contrato e demonstração; depende das fases anteriores. |
| P13 — [Dev 3: baseline/aceite](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev3/dev-3-sprint-1-fase-1-baseline-aceite-contratos.md) | Matriz de aceite S1-01–07, decisões, comandos e condições de entrada. |
| P14 — [Dev 3: testes críticos](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev3/dev-3-sprint-1-fase-2-testes-criticos-contratos-isolamento.md) | Verificação independente de autenticação, contas, contratos e isolamento; depende dos critérios e implementações. |
| P15 — [Dev 3: integração/evidências](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint1/dev3/dev-3-sprint-1-fase-3-integracao-documentacao-evidencias.md) | Integração real web/mobile/backend, pipelines, demonstração e fechamento S1-01–09. |

### Sprint 2

| ID e arquivo | Propósito, materiais e dependências |
|---|---|
| P02 — [Auditoria Dev 1](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint-2-dev-1-audit.md) | Auditar planejamento aprovado, código e documentação; produzir matriz, achados e verificações. |
| P16 — [Correção auditada](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/correcao-auditada.md) | Corrigir os achados S2-02/06/08/09; depende da auditoria e da escolha de lifecycle da conta. |
| P17 — [Dev 1: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/dev-1-sprint-2-fase-1-baseline-transactions.md) | Definir campos, transferências contábeis, regras, idempotência, auditoria e contrato antes da implementação. |
| P18 — [Dev 1: persistência](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/dev-1-sprint-2-fase-2-persistencia-transactions.md) | Domínio, portas, Prisma, constraints, migrations e RLS; depende do baseline aprovado. |
| P19 — [Dev 1: movimentações](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/dev-1-sprint-2-fase-3-movimentacoes-backend.md) | Receitas, despesas e transferências atômicas/idempotentes; depende da persistência e contrato. |
| P20 — [Dev 1: categorias/regras](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/dev-1-sprint-2-fase-4-categorizacao-regras.md) | Correção manual, estados incertos e lifecycle/precedência de regras. |
| P21 — [Dev 1: isolamento/auditoria](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/dev-1-sprint-2-fase-5-isolamento-auditoria.md) | Revisar autorização, RLS, atomicidade, idempotência e auditoria dos fluxos implementados. |
| P22 — [Dev 1: testes/consolidação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev1/dev-1-sprint-2-fase-6-testes-consolidacao.md) | Cobertura e consolidação backend; handoffs para clientes e Dev 3. |
| P23 — [Dev 2: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-1-baseline-contrato-clientes.md) | Mapear operações e decisões de dinheiro, datas, idempotência, navegação e testes. |
| P24 — [Dev 2: clientes tipados](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-2-clientes-tipados.md) | Snapshots, tipos, schemas, utilitários, HTTP e APIs; depende do baseline. |
| P25 — [Dev 2: movimentações](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-3-movimentacoes-clientes.md) | Listagem paginada, receita/despesa/transferência e reenvio idempotente. |
| P26 — [Dev 2: categorização](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-4-categorizacao-clientes.md) | Categorias, correção e todos os estados de categorização; depende das movimentações. |
| P27 — [Dev 2: regras pessoais](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-5-regras-pessoais-clientes.md) | Gramática aprovada, formulários, precedência e lifecycle. |
| P28 — [Dev 2: isolamento](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-6-isolamento-estado-clientes.md) | Sessão, respostas atrasadas, caches, chaves, erros e checklist com dois usuários. |
| P29 — [Dev 2: testes/consolidação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-fase-7-testes-consolidacao.md) | Testes, contrato final, execução limpa e demonstração dos fluxos anteriores. |
| P30 — [Extensão mobile](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-melhoria-interface-mobile.md) | Paginação de contas, tema automático, agrupamento, destaque, primeiros passos, ações, acessibilidade e testes; expressamente planejado/aguardando aprovação. |
| P31 — [Melhoria de interface](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/dev-2-sprint-2-melhoria-interface.md) | Registro da reformulação web/mobile e verificações; referencia Style Guide 1.0 e commits-base. |
| P32 — [Demonstração S2](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev2/roteiro-demonstracao-sprint-2.md) | Procedimento com resultados esperados para web/mobile, reenvio e dois usuários; requer ambiente e fluxos funcionais. |
| P33 — [Dev 3: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev3/dev-3-sprint-2-fase-1-baseline-aceite-transactions.md) | Consolidar critérios S2-01–09 e pré-requisitos herdados. |
| P34 — [Dev 3: testes](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev3/dev-3-sprint-2-fase-2-testes-movimentacoes-regras-isolamento.md) | Validar comportamento, persistência, RLS, contratos e clientes independentemente. |
| P35 — [Dev 3: integração](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/dev3/dev-3-sprint-2-fase-3-integracao-demonstracao-evidencias.md) | Fluxos completos, demonstração e reconciliação do aceite; depende dos resultados anteriores. |
| P36 — [Planejar S2](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint2/planejar-sprint-2.md) | Plano HTML para três desenvolvedores, critérios, dependências e janela 11–25/09; usa Sprint 1 e guia visual. |

### Sprint 3

| ID e arquivo | Propósito, materiais e dependências |
|---|---|
| P37 — [Dev 1: contratos](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev1/dev-1-sprint-3-fase-1-baseline-contratos-backend.md) | Baseline HU-004/HU-007, decisões e contratos; revalidar Sprints 1/2. |
| P38 — [Dev 1: fundação OFX](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev1/dev-1-sprint-3-fase-2-fundacao-ofx.md) | Parser, persistência, ownership, migrations e interfaces entre módulos; depende das decisões aprovadas. |
| P39 — [Dev 1: fluxo OFX](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev1/dev-1-sprint-3-fase-3-fluxo-ofx-previa-confirmacao.md) | Upload, prévia, duplicidades, confirmação idempotente, resultado e consulta. |
| P40 — [Dev 1: conexão/consentimento](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev1/dev-1-sprint-3-fase-4-conexao-pluggy-consentimento.md) | Token limitado, conexão, consentimento, revogação, ownership e RLS. |
| P41 — [Dev 1: importação inicial](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev1/dev-1-sprint-3-fase-5-importacao-inicial-consolidacao.md) | Contas/transações consentidas, mapeamento, idempotência, disponibilidade parcial e consolidação. |
| P42 — [Dev 2: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/dev-2-sprint-3-fase-1-baseline-contrato-clientes.md) | Decisões de upload, limites, navegação, picker, widgets, estados e testes. |
| P43 — [Dev 2: clientes tipados](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/dev-2-sprint-3-fase-2-clientes-tipados.md) | Multipart, APIs, schemas, arquivos, confirmação e contratos; depende do baseline. |
| P44 — [Dev 2: OFX](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/dev-2-sprint-3-fase-3-importacao-ofx-clientes.md) | Selecionar, validar, pré-visualizar, confirmar e consultar resultado nas duas plataformas. |
| P45 — [Dev 2: Pluggy](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/dev-2-sprint-3-fase-4-conexao-pluggy-clientes.md) | Widgets, token limitado, retorno mobile, estados e remoção; depende de contrato/SDK aprovados. |
| P46 — [Dev 2: consolidação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/dev-2-sprint-3-fase-5-testes-consolidacao.md) | Contrato final, isolamento, testes, README e demonstração; depende das fases anteriores. |
| P47 — [Demonstração S3](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/roteiro-demonstracao-sprint-3.md) | Procedimento OFX/Pluggy nas duas plataformas, reenvio e isolamento; requer ambiente autorizado. |
| P48 — [Dev 3: baseline](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev3/dev-3-sprint-3-fase-1-baseline-aceite-ofx-pluggy.md) | Reconciliar decisões, limites, expiração, retenção, mapeamento e critérios. |
| P49 — [Dev 3: testes](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev3/dev-3-sprint-3-fase-2-testes-ofx-pluggy-contratos-isolamento.md) | Verificar OFX/Pluggy, contratos e isolamento; separar mocks de integrações reais. |
| P50 — [Dev 3: integração](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev3/dev-3-sprint-3-fase-3-integracao-sandbox-documentacao-evidencias.md) | Consolidar S3-01–08 e handoff S4-01; depende das implementações e evidências. |
| P51 — [Planejar S3](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/planejar-sprint-3.md) | Um HTML de planejamento OFX/Pluggy para 25/09–09/10, sem implementação de produto. |

### Sprint 4

| ID e arquivo | Propósito, materiais e dependências |
|---|---|
| P52 — [Dev 1: baseline/decisões](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev1/dev-1-sprint-4-fase-1-baseline-backend-decisoes-pluggy.md) | Verificar HU-007, mapear requisitos, decisões e handoffs para Dev 2/3. |
| P53 — [Dev 1: sincronização](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev1/dev-1-sprint-4-fase-2-sincronizacao-pluggy-hu-008.md) | HU-008 diário/manual, idempotência, concorrência, retry e estado; depende de S4-01/HU-007. |
| P54 — [Dev 1: patrimônio manual](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev1/dev-1-sprint-4-fase-3-patrimonio-manual-hu-012.md) | HU-012: bens, financiamentos/passivos, associação, histórico e auditoria; independente de HU-008 após baseline/modelo. |
| P55 — [Dev 1: investimentos](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev1/dev-1-sprint-4-fase-4-investimentos-hu-009.md) | HU-009: posições, campos disponíveis, proveniência e defasagem; depende do contrato de sincronização e capacidades. |
| P56 — [Dev 1: alocação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev1/dev-1-sprint-4-fase-5-alocacao-hu-011.md) | HU-011: classe/instituição, percentuais e não classificados; depende de investimentos e regras de cálculo. |
| P57 — [Dev 1: consolidação](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev1/dev-1-sprint-4-fase-6-integracao-backend-evidencias.md) | Verificar quatro fatias backend, contrato, banco e handoffs; depende das implementações. |
| P58 — [Dev 3: baseline/aceite](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev3/dev-3-sprint-4-fase-1-baseline-decisoes-aceite.md) | Consolidar S4-01, pré-requisitos herdados, decisões e aceite observável. |
| P59 — [Dev 3: testes](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev3/dev-3-sprint-4-fase-2-testes-sincronizacao-investimentos-patrimonio.md) | Verificar sincronização, investimentos, alocação, patrimônio e clientes conforme decisões aprovadas. |
| P60 — [Dev 3: integração](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/dev3/dev-3-sprint-4-fase-3-integracao-consolidacao-evidencias.md) | Fechamento por critério, demonstração, revisão e evidências de todas as plataformas. |
| P61 — [Planejar S4](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint4/sprint-4-planning.md) | Planejamento HTML fundamentado no PRD e padrão anterior, com validação de referências. |

**Inclusões:** prompts de planejamento, execução, auditoria, correção e roteiros com entregas verificáveis.

**Exclusões:** templates de skills, instruções de agentes e propostas sem relação com essas entregas. Não foi realizada auditoria geral de segurança, desempenho ou preferências visuais.

**Relações e conflitos relevantes:**

- P16 é uma correção explicitamente derivada de P02; não substitui toda a Sprint 2.
- Os antigos caminhos `tcc`, arquivos HTML na raiz e caminhos de outros desenvolvedores não representam o layout atual. O histórico registra a reorganização documental, inclusive `e015c8f`.
- Os handoffs acrescentados aos prompts são **relatos históricos**, não autorização nem prova automática de execução.
- O adendo local S4-01 consolida rotas/estados que as seções anteriores ainda descrevem como pendentes. A versão precisa ser reconciliada antes de orientar implementação.
- S4-06 aparece na sequência e no cronograma, mas não possui ficha detalhada equivalente a S4-01–05.
- Não foram encontrados prompts Dev 2 da Sprint 4. Isso é lacuna de instruções disponíveis, não prova de ausência de trabalho fora destes materiais.

## 3. Matriz de progresso

### Evidências utilizadas

| Código | Evidência e implicação |
|---|---|
| E1 — Documentação | A [Visão:219](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/produto/visao.html:219) descreve clientes independentes e stack aprovada. O [índice:17](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/index.html:17) expõe as quatro sprints. |
| E2 — Fundação/identidade | O [bootstrap:23](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/main.ts:23) usa `app.setGlobalPrefix('api/v1')`. O [guard:34](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/identity/adapters/inbound/auth0-jwt.guard.ts:34) verifica identidade e resolve contexto local. |
| E3 — Tenancy/banco | A [transação tenant:20](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/infrastructure/database/prisma-tenant-transaction.ts:20) usa `set_config('app.current_tenant_id', …, true)`. As [migrations Pluggy:136](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/prisma/migrations/202610110001_s305_pluggy_initial_import/migration.sql:136) declaram ENABLE/FORCE RLS. Presença não comprova execução. |
| E4 — Transactions | A [transferência:109](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/transactions/application/use-cases/create-accounting-transfer.ts:109) usa unidade de trabalho e reserva idempotente. O [repositório:709](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/transactions/adapters/outbound/prisma-transactions.repository.ts:709) ordena regras por prioridade, criação e ID. |
| E5 — Correções S2 | A [migration:6](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/prisma/migrations/202609260001_s2_category_rule_guards/migration.sql:6) limita `type` a `income/expense` e impede arquivamento referenciado por regra ativa. Commit `e95d2af`; há testes unitários e de banco. |
| E6 — Clientes S1/S2 | [Web API:54](C:/Users/samue/Documents/GitHub/CFI/web-centralizador-financeiro/src/lib/transactions/api.ts:54) implementa operações tipadas com idempotência. O [mobile AuthContext:151](C:/Users/samue/Documents/GitHub/CFI/mobile-centralizador-financeiro/src/auth/AuthContext.tsx:151) rejeita 401 de sessão antiga. Telas, ações e testes estão presentes. |
| E7 — Contratos desatualizados | Ambos os contratos registram **“backend @ fa9b62a”**: [web:8](C:/Users/samue/Documents/GitHub/CFI/web-centralizador-financeiro/src/lib/api/CONTRACT.md:8), [mobile:8](C:/Users/samue/Documents/GitHub/CFI/mobile-centralizador-financeiro/src/lib/api/CONTRACT.md:8). A comparação atual encontrou 15 caminhos nos snapshots e 24 no backend; nove caminhos ausentes incluem o webhook, que não é operação cliente. |
| E8 — Extensão mobile | [AccountsScreen:46](C:/Users/samue/Documents/GitHub/CFI/mobile-centralizador-financeiro/src/screens/AccountsScreen.tsx:46) carrega apenas `listAccounts()` e substitui a lista pela página recebida. [app.json:9](C:/Users/samue/Documents/GitHub/CFI/mobile-centralizador-financeiro/app.json:9) mantém `"userInterfaceStyle": "light"`. Confirma pendências centrais de P30. |
| E9 — OFX backend | [Controller:69](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/ingestion/adapters/inbound/ingestion.controller.ts:69) publica prévia, confirmação e consulta. A [prévia:36](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/ingestion/application/use-cases/create-ofx-import-preview.ts:36) valida/parseia antes da gravação final; a [confirmação:64](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/ingestion/application/use-cases/confirm-ofx-import.ts:64) persiste por interface de Transactions. |
| E10 — OFX incompleto | O [contrato S3:508](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/planejamento/sprint-03/contrato-backend-s3-01.html:508) exige auditoria de prévia, confirmação e sucesso. Não encontrei essas chamadas nos casos de uso/repositório Ingestion; os [tipos de auditoria:206](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/prisma/schema.prisma:206) não representam esses eventos. Há datas de retenção, mas não encontrei rotina de expiração/limpeza das prévias abandonadas ou expurgo após retenção. |
| E11 — Pluggy backend | O [controller de importação inicial:70](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/ingestion/adapters/inbound/pluggy-initial-import.controller.ts:70) trata conclusão; também há consulta, mapping e worker. Commits `605cb07` e `234cb11` contêm conexão e importação inicial. |
| E12 — D13/arquitetura/testes | O [contrato:497](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/planejamento/sprint-03/contrato-backend-s3-01.html:497) exige fallback quando faltar ID. O [adapter:56](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/accounts/adapters/outbound/pluggy-api.client.ts:56) exige UUID; não encontrei fallback. O [caso de uso:14](C:/Users/samue/Documents/GitHub/CFI/backend-centralizador-financeiro/src/modules/ingestion/application/use-cases/pluggy-initial-import.ts:14) importa adapter outbound e serviço concreto QStash, contrariando a independência exigida. Os quatro testes desse caso de uso não cobrem replay da conclusão/concorrência. |
| E13 — Divergência S3 clientes | P46 relata [613/469 testes:148](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/prompts/sprint3/dev2/dev-2-sprint-3-fase-5-testes-consolidacao.md:148), snapshots `605cb07` e arquivos OFX/Pluggy. Esses arquivos não aparecem nos checkouts/referências Git locais consultados. Os adendos locais [web:150](C:/Users/samue/Documents/GitHub/CFI/web-centralizador-financeiro/src/lib/api/CONTRACT.md:150) e [mobile:151](C:/Users/samue/Documents/GitHub/CFI/mobile-centralizador-financeiro/src/lib/api/CONTRACT.md:151) registram ausência do fluxo Pluggy. |
| E14 — S4 planejada | O [plano:68](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html:68) exige quatro HUs. A inspeção de módulos, Prisma, controllers e OpenAPI não encontrou suas implementações. O [adendo local:179](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md:179) registra contrato de sync; [linha 185](C:/Users/samue/Documents/GitHub/CFI/documentacao-centralicador-financeiro/docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md:185) declara que não está implementado e enumera parâmetros pendentes. |

**Histórico:** H1 = handoffs S1; H2 = auditoria/handoffs S2; H3 = handoffs S3; H4 = baseline S4, que explicitamente não comprova runtime; H0 = execução histórica não comprovada.

**Verificação atual:** VB = 163 testes backend; VW = 491 web; VM = 370 mobile; VD = `git diff --check`. Os resultados têm os limites da seção 4.

**Prioridade:** alta bloqueia entrega/integração ou decisão dependente; média impede critério específico; baixa corresponde a reconciliação documental sem bloqueio funcional demonstrado. Não encontrei fundamento para prioridade crítica.

### Progresso por requisito

Os sufixos identificam entregas distintas dentro de cada prompt. Critérios comuns de build, execução real, ausência de dados sensíveis e aprovação histórica permanecem sujeitos às limitações declaradas; não foram implicitamente aceitos por uma suíte verde.

| Requisito ID — entrega | Implementação e evidência | Histórico | Agora | Trabalho pendente | Confiança; prioridade e razão |
|---|---|---|---|---|---|
| P01-R1/R2 — HTML, objetivo/sequência/equipe/PDF; navegação | Implementado no caminho reorganizado; E1. PDF preservado pelo mesmo blob Git. Objetivo textual e S1-01–09 presentes. | Histórico de criação/realocação | VD; leitura PDF | Fidelidade visual e verificações originais não comprovadas. | Alta para conteúdo; baixa, evidência documental |
| P62-R1/R2 — escopo/stack/evolução coerentes; preservação e validação documental | Conteúdo principal implementado; E1. MVP, SaaS e possibilidades futuras separados. | Commit inicial `1599145` e reorganização | Inspeção; VD | Preservação visual e limites exatos da edição original indeterminados sem estado anterior. | Alta/média; baixa |
| P02-R1/R2 — relatório, matriz, achados/checks | Implementado em relatório de auditoria existente; E5/H2. | Comandos e resultados registrados no relatório | Achados rechecados | Tratar o relatório como histórico, não estado atual. | Alta; baixa |
| P03-R1/R2 — baseline arquitetural/tecnológico | Documentado; E1/E2/E3. Conformidade atual precisa considerar a dependência apontada em E12. | H0 | VB parcial ao requisito | Reconciliar desvio introduzido no fluxo S3. | Alta; média |
| P04-R1/R2/R3 — fundação, modelos e migrations/RLS | Implementado estaticamente; E2/E3. | H1 e histórico Git | VB | Reproduzir instalação/migrations/banco novo. | Alta para presença; alta para validação de banco |
| P05-R1/R2 — JWT/contexto; criar/listar contas | Implementado; E2/E6. | H1 | VB | Integração real Auth0/DB atual. | Alta; média |
| P06-R1/R2 — manutenção/auditoria; autorização/RLS | Implementado no código/SQL; E3/E5. | H1 | VB | Validar RLS e persistência reais. | Alta; alta para aceite de banco |
| P07-R1/R2/R3 — cobertura; migrations novas; consolidação | Parcial: testes presentes, verificação completa não reproduzida. | H1 | VB/VD | Banco novo, integração/E2E, formatação, build e handoff atual. | Alta; alta |
| P08-R1/R2 — independência/baseline cliente | Documentado e observado; E6/E7. | H1 | VW/VM | Contrato atual precisa reconciliação. | Alta; média |
| P09-R1/R2 — fundação; modelos/validação alinhados | Implementação presente; contrato atual parcial, E7. | H1 | VW/VM | Atualizar alinhamento com backend sem mascarar divergências. | Alta; alta |
| P10-R1/R2 — autenticação/sessão; criar/listar | Implementado; E6. | H1 relata web manual, mobile limitado | VW/VM | Fluxo real atual nas duas plataformas. | Alta; média |
| P11-R1/R2 — manutenção; limpeza/negação uniforme | Implementado em código; E6. | H1 | VW/VM | Dois usuários/dispositivo; apresentar conflito atual de arquivamento. | Alta; média |
| P12-R1/R2/R3 — cobertura, execução/build e demonstração | Parcial; suítes presentes, aceite real incompleto. | H1 | VW/VM | Build/runtime e demonstração atuais, sobretudo mobile. | Alta; alta |
| P13-R1/R2 — matriz independente; decisões/entrada | Parcial: fontes existem; consolidação própria não identificada. | H0 | Inspeção | Matriz Dev 3 por critério, sem tomar handoffs como aceite. | Média; alta |
| P14-R1/R2 — cobertura crítica; DB/clientes reais | Parcial: testes reutilizáveis existem; E2–E6. | H1 | VB/VW/VM | Evidência independente, RLS e integração. | Alta; alta |
| P15-R1/R2 — integração/pipelines; fechamento | Parcial/indeterminado; configuração CI backend existe, resultado não foi obtido. | H1 | Sem E2E real | Revisão, demonstração e resultados das plataformas. | Alta sobre a lacuna; alta |
| P16-R1/R2 — lifecycle e constraint `type` | Implementados no commit `e95d2af`; E5. Não reproduzem mais a ausência descrita na auditoria antiga. | H2 | Teste unitário incluído em VB | Verificação da migration/role runtime em banco isolado. | Alta; média |
| P16-R3/R4 — reconciliar contagens; integração/handoffs | Parcial/indeterminado. Relatório antigo removido em `2bf619b`; recuperável via Git. | H2 mantém 111+27+22+4 versus 165 | VB atual é outro recorte | Reconciliar a revisão histórica; publicar consolidação atual quando autorizada. | Alta; baixa para contagem, alta para integração |
| P17-R1/R2 — decisões e contrato Transactions | Implementados documentalmente; E4/E5. | H2 | Inspeção/VB | Reconciliar avisos antigos dos clientes com correções posteriores. | Alta; média |
| P18-R1/R2/R3 — domínio/persistência; ownership/RLS; testes | Implementado estaticamente; E3–E5. | H2 | VB | Banco/constraints/RLS atuais. | Alta; alta |
| P19-R1/R2 — movimentos/transferências; atomicidade/idempotência | Implementado; E4. | H2 | VB | Persistência e REST reais. | Alta; alta para aceite completo |
| P20-R1/R2 — categorização; lifecycle/precedência | Implementado; E4/E5. | H2 | VB | Integração real e contrato final dos clientes. | Alta; média |
| P21-R1/R2 — isolamento/atomicidade; auditoria | Implementado no código e SQL; E3/E4. | H2 | VB | RLS, pooling e falhas transacionais com banco. | Alta; alta |
| P22-R1/R2 — cobertura backend; consolidação/handoffs | Parcial; E4/E5. | H2 | VB/VD | Suítes de banco/E2E e consolidação atual. | Alta; alta |
| P23-R1/R2 — decisões cliente; rastreabilidade/contrato | Documentados, mas baseline ficou antigo; E7. | H2 | Inspeção | Atualizar contra contrato vigente. | Alta; alta |
| P24-R1/R2/R3 — tipos/APIs; dinheiro/data/idempotência; smoke | Código implementado; alinhamento e smoke atuais parciais, E6/E7. | H2 | VW/VM | Snapshots atuais e smoke real. | Alta; alta |
| P25-R1/R2 — listagem/formulários; reenvio e estados | Implementado; E6. | H2 relata web manual | VW/VM | Demonstração atual, mobile e falha ambígua após commit. | Alta; média |
| P26-R1/R2 — categorias; correção/estados/reflexo | Implementado; E6. | H2 | VW/VM | Reflexo real entre web/mobile. | Alta; média |
| P27-R1/R2 — gramática/precedência; lifecycle | Implementado; E6. | H2 | VW/VM | Verificação manual atual e contrato reconciliado. | Alta; média |
| P28-R1/R2/R3 — sessão/cache; idempotência; checklist | Parcial: mecanismos e checklist existem; dois tenants não comprovados. | H2 explicitamente registra bloqueios | VW/VM | Executar cenários de troca de usuário e respostas atrasadas em runtime. | Alta; alta |
| P29-R1/R2/R3 — testes; alinhamento final; demonstração | Parcial; testes passam, snapshots antigos e demonstração sem fechamento. | H2 | VW/VM | Integração/execução limpa e evidência observada. | Alta; alta |
| P30-R1 — paginação de contas | Não implementada no escopo inspecionado; E8. | Documento diz “aguardando aprovação” | Inspeção | Paginar e validar acesso à 21ª conta. | Alta; alta pelo dado omitido |
| P30-R2/R3 — tema/agrupamento/destaque/ações/onboarding; documentação/testes | Extensão não encontrada; tema permanece `light`, E8. | Planejado, sem execução declarada | Inspeção | Decidir/autorizar extensão e verificar em dispositivo. Haptics é opcional. | Alta; média |
| P31-R1/R2 — reformulação; verificações | Estrutura/componentes presentes; acabamento visual não auditado. | Relato datado e commits correspondentes | VW/VM | Conferência visual original não comprovada. | Alta/média; baixa |
| P32-R1/R2 — roteiro; resultados observados | Roteiro implementado; campos “Observado” vazios. | H2 | Leitura | Executar e registrar demonstração. | Alta; alta para aceite S2 |
| P33-R1/R2 — baseline/aceite; decisões/entrada | Parcial; fontes existem, consolidação independente não localizada. | H0 | Inspeção | Atualizar matriz com correções backend atuais. | Média; alta |
| P34-R1/R2 — testes comportamentais; integração/RLS/clientes | Parcial; cobertura existente reutilizável, execução real não comprovada. | H2 | VB/VW/VM | Validação independente de banco e clientes. | Alta; alta |
| P35-R1/R2 — E2E/demonstração; fechamento | Parcial/indeterminado. | H2 | Sem integração real | Fechar S2-01–09 por evidência de todas as responsabilidades. | Alta; alta |
| P36-R1/R2 — plano S2; navegação/verificação | HTML presente com atividades e critérios; E1. | Histórico documental | VD; inspeção | Validação visual original indeterminada. | Alta/média; baixa |
| P37-R1/R2 — contrato S3; decisões/handoffs | Documentado, com pendências explícitas e divergências posteriores; E9–E12. | Registro S3-01 | Inspeção | Reconciliar contrato, D12/D13 e aceite atual. | Alta; alta |
| P38-R1/R2/R3 — parser; persistência/portas; migrations/RLS | Implementado estaticamente; E9. | Commits `9887206`, `2c416cd` | VB | Banco, retenção e integrações de armazenamento. | Alta; alta |
| P39-R1/R2 — prévia/confirmação/resultado; contrato completo | Fluxo principal implementado; parcial por auditoria/lifecycle, E9/E10. | Código e histórico S3 | VB | Auditoria exigida; expiração/retenção e integração real. | Alta; alta |
| P40-R1/R2 — conexão/consentimento; revogação/ownership | Implementado em backend; E11. | Commit `605cb07` | VB | Sandbox e policies específicas em runtime. | Alta; alta |
| P41-R1/R2 — importação/mapping/disponibilidade; dedupe | Parcial: fluxo existe; D13 e elegibilidade não fechados, E11/E12. | Commit `234cb11` | VB | Fonte primária/casos de identidade, decisão de mapping, replay/concorrência. | Alta; alta |
| P41-R3/R4 — limites arquiteturais; consolidação | Parcial; importação de adapters em Application, E12. | H3/H4 | VB não testa a arquitetura | Propor correção mínima da dependência e consolidar evidência. | Alta; média |
| P42-R1/R2 — baseline S3 cliente; decisões/CONTRACT | Necessidades e handoff existem na documentação; não refletidos nos contratos cliente atuais. | H3 | E7/E13 | Recuperar/reconciliar material de execução. | Alta; alta |
| P43-R1/R2/R3 — multipart/APIs; schemas/idempotência; testes | Não encontrados nos clientes inspecionados. HTTP atual serializa corpo como JSON. | H3 relata implementação | VW/VM cobrem código anterior | Localizar entrega ou implementar conforme contrato atual. | Alta local; alta |
| P44-R1/R2 — fluxo OFX; estados/integração | Não encontrado nos clientes inspecionados; E13. | H3 relata implementação | Sem testes desse fluxo disponíveis | Recuperar código, ajustar contrato e validar ambas as plataformas. | Alta local; alta |
| P45-R1/R2/R3 — widgets/conexão; retorno/remoção; integração | Não encontrado nos clientes inspecionados; E13. | H3 relata implementação com limitações | Sem testes desse fluxo disponíveis | Recuperar código e validar contrato/SDK/ambiente. | Alta local; alta |
| P46-R1/R2/R3 — contrato final; isolamento/testes; README/demo | Parcial documental; a entrega cliente relatada não corresponde aos checkouts. | H3, `11c605a` na documentação | E7/E13 | Resolver proveniência, versão e código ausente. | Alta; alta |
| P47-R1/R2 — roteiro; resultados observados | Roteiro presente; colunas observadas sem execução registrada. | H3 | Leitura | Executar após recuperar clientes e ambiente. | Alta; alta |
| P48-R1/R2 — decisões/aceite S3; condições de entrada | Parcial; contrato/necessidades presentes, decisões e consolidação pendentes. | H3/H4 | Inspeção | Fechar baseline transversal sem aceitar relato contraditório. | Alta; alta |
| P49-R1/R2 — cobertura OFX/Pluggy; DB/storage/clientes | Parcial; testes backend presentes, lacunas E10/E12/E13. | H3 | VB somente | Testes faltantes e integrações independentes. | Alta; alta |
| P50-R1/R2 — reconciliação/E2E; handoff S4 | Parcial; baseline backend S4 não fecha S3. | H4 declara limites | Inspeção | Fechamento por plataforma/critério e pendências herdadas. | Alta; alta |
| P51-R1/R2 — plano único S3; critérios/dependências | HTML presente no destino solicitado; E1. | Histórico documental | VD; inspeção | Validação original e limite de escrita histórico indeterminados. | Alta/média; baixa |
| P52-R1/R2/R3 — baseline backend; decisões; handoffs | Parcial: documento detalhado existe, incluindo adendo local; E14. | H4, sem runtime | VB parcial aos pré-requisitos | Resolver decisões/capacidades e integrar evidência cliente/Dev 3. | Alta; alta |
| P53-R1/R2/R3 — sync diário/manual; controles; estado/testes | Não encontrado em código, Prisma ou OpenAPI; E14. | Planejamento, sem execução comprovada | Não há suíte HU-008 identificada | Decisões operacionais, implementação e validação. | Alta; alta |
| P54-R1/R2/R3 — bens/passivos; associação/histórico; isolamento | Não encontrado no escopo inspecionado; E14. | Planejamento | Não há suíte HU-012 identificada | Aprovar modelo, implementar API/clientes e testar. | Alta; alta |
| P55-R1/R2/R3 — posições/campos; ausência/defasagem; contrato | Não encontrado; conta `investment` não constitui posição, E14. | Planejamento | Não há suíte HU-009 identificada | Mapa de capacidades e contrato de investimentos. | Alta; alta |
| P56-R1/R2 — agrupamentos/percentuais; incompletos/proveniência | Não encontrado; depende de P55 e semânticas abertas. | Planejamento | Não há suíte HU-011 identificada | Denominador/moedas/arredondamento/classificação e implementação. | Alta; alta |
| P57-R1/R2 — matriz backend; verificações/handoffs | Não há consolidação executada das quatro HUs. | H4 é baseline | Sem verificação dessas HUs | Executar após implementações, sem confundir com S4-01. | Alta; alta |
| P58-R1/R2 — baseline transversal; critérios/decisões | Parcial; contribuição backend existe, consolidação Dev 3 não identificada. | H4 | Inspeção | Integrar clientes, decisões e critérios por HU. | Alta; alta |
| P59-R1/R2 — verificação das quatro HUs; clientes/banco | Não encontrada execução específica; pré-requisitos de produto ausentes. | H0 | Não aplicável executar fluxos ausentes | Definir critérios aprovados e validar incrementalmente. | Alta; alta |
| P60-R1/R2 — integração/demonstração; fechamento S4 | Não encontrado fechamento; depende das quatro HUs. | H0 | Não executado | Evidência real, revisão e definição S4-06. | Alta; alta |
| P61-R1/R2 — planejamento; referências/validação | Plano presente; parcial na especificação S4-06, E14. | Histórico documental | VD; inspeção | Detalhar aceite/ownership de S4-06 e reconciliar decisões. | Alta; média |

### Achados que alteram a sequência de execução

1. **Alta — proveniência das entregas cliente S3 não resolvida.** E13 demonstra contradição documental/local. Não há base para afirmar que o código foi perdido ou que nunca existiu; é necessário localizar revisão, branch, clone ou patch correspondente.

2. **Alta — testes de contrato cliente não estabelecem compatibilidade atual.** Eles leem snapshots locais antigos. Seu sucesso é válido para esse recorte, mas não fecha P24/P29/P43/P46.

3. **Alta — backend S3 não atende integralmente ao contrato auditado.** Fallback D13 não encontrado, auditoria OFX não localizada e replay/concorrência sem cobertura dedicada. As garantias reais do provedor continuam indeterminadas.

4. **Média — lifecycle OFX incompleto no material inspecionado.** Há cálculo de retenção e exclusão do arquivo no caminho terminal de confirmação, mas não encontrei mecanismo completo para prévias abandonadas/expiradas e expurgo posterior. O prazo da prévia precisa ser estabelecido antes de inventar comportamento.

5. **Média — dependência arquitetural no importador Pluggy.** Application importa `PluggyUnavailable` e tipos/serviço do adapter QStash. Isso afeta um requisito explícito dos prompts; não é sugestão de refatoração geral.

6. **Alta — paginação mobile de contas continua pendente.** O código confirma a limitação registrada em P30; as contas além da primeira página não são alcançadas por esse fluxo.

7. **Correção de diagnóstico histórico:** os antigos achados de constraint `type` e arquivamento com regra ativa possuem implementação corretiva em `e95d2af`. Permanecem sem reprodução atual em PostgreSQL, mas não devem ser apresentados como código ainda ausente.

## 4. Registro de verificação

Os comandos usaram Node **22.14.0**, dependências locais existentes e os HEADs da seção 1.

| Comando | Diretório | Finalidade | Resultado/exit code | Limites |
|---|---|---|---|---|
| `node node_modules/vitest/vitest.mjs run src test/contract --no-cache --configLoader runner` | Backend | Unidades e contrato versionado | **Falhou, 1**: 28 arquivos falharam ao carregar; 9 passaram, 35 testes passaram | `ENOENT` em módulos temporários do sandbox; não foi falha de assertiva demonstrada. |
| `node node_modules/vitest/vitest.mjs run --no-cache --configLoader runner` | Web | Suíte cliente existente | **Falhou, 1**: 23 arquivos falharam ao carregar; 5 passaram, 93 testes passaram | Mesmo problema de temporários. |
| Mesmo comando anterior | Mobile | Suíte cliente existente | **Falhou, 1**: 15 arquivos falharam ao carregar; 6 passaram, 88 testes passaram | Mesmo problema de temporários. |
| `node node_modules/vitest/vitest.mjs run src test/contract --no-cache --configLoader runner --pool threads` | Backend | Repetição com workers no mesmo processo, para contornar o acesso a temporários | **Passou, 0: 37 arquivos, 163 testes** | Sem integração PostgreSQL, REST real ou Sandbox. |
| `node node_modules/vitest/vitest.mjs run --no-cache --configLoader runner --pool threads` | Web | Mesma suíte, alterando somente o pool | **Passou, 0: 28 arquivos, 491 testes** | HTTP/Auth0/Next substituídos nos testes; snapshot antigo. |
| Mesmo comando anterior | Mobile | Mesma suíte, alterando somente o pool | **Passou, 0: 21 arquivos, 370 testes** | Não executa telas, dispositivo ou autenticação real. |
| `git diff --check` | Cada um dos quatro repositórios | Whitespace no diff atual | **Passou, 0 nos quatro** | Aviso LF/CRLF na documentação; não valida funcionalidade. |
| Comparação em memória dos JSONs OpenAPI | Documentação, lendo os três produtos | Identificar divergência dos artefatos versionados | **Concluída, 0**: backend 24 caminhos; cada snapshot 15 | Comparação estática; caminhos adicionais não equivalem todos a operações cliente obrigatórias. |
| Leitura PDF em memória com `pypdf` | Documentação | Comparar base do plano S1 | Primeira leitura interrompida por encoding de saída; repetição UTF-8 concluída | Sem verificação visual. Blob atual igual ao original: `959e89f686242b4206442aa246c69071710838de`. |
| `git status`, HEADs e SHA-256 dos três arquivos previamente modificados | Quatro repositórios | Confirmar preservação do estado | Estado e hashes iguais ao início | Confirmação no escopo Git e dos arquivos preexistentes acompanhados. |

A repetição dos testes foi justificada por uma alteração concreta de execução — `--pool threads` — após o erro comum de temporários. Não houve alteração de expectativas, mocks ou configuração para obter sucesso.

**Não executados:**

| Verificação | Motivo específico |
|---|---|
| Integração/E2E PostgreSQL e `db:verify-rls` | `TEST_DATABASE_URL` não estava definido no processo consultado; banco descartável/autorizado não foi estabelecido. Os testes/verificadores escrevem e limpam dados. |
| Deploy de migrations | Modifica schema e histórico; não autorizado nesta auditoria. |
| `db:verify-migrations` | Exige alvo de banco identificado e `DIRECT_DATABASE_URL`; nenhum alvo foi autorizado/verificado. |
| Build, geração Prisma e geração OpenAPI | Os scripts gravam artefatos; `openapi:generate` escreve explicitamente o JSON versionado. |
| Fluxos reais Auth0, Pluggy, QStash e R2 | Ambiente e operações específicas não estabelecidos/autorizados. |
| Dispositivo/emulador e demonstrações | Não foram exercitados nesta auditoria. |
| Pipelines remotos | Configuração backend inspecionada; resultados de execução não obtidos. |

## 5. Roteiro ordenado

Todos os comandos abaixo são **propostos para outra tarefa**, salvo os já registrados na seção 4.

| Etapa | Objetivo e prioridade | Pré-requisitos | Ações e locais afetados | Aceite e verificação | Decisão bloqueadora |
|---|---|---|---|---|---|
| 1 | **Reconciliar a entrega S3 cliente — alta** | Handoffs P42–P46 e inventário atual | Localizar commit/branch/clone/patch; confrontar com E13. Áreas citadas: `ingestions`, `connections`, telas OFX/Pluggy e snapshots. | Cada arquivo relatado possui revisão verificável ou é formalmente classificado como pendente. Não reimplementar antes dessa busca. | D1 |
| 2 | **Consolidar a fonte vigente S4-01 — alta** | Estado local preservado | Reconciliar tabela anterior e adendo do baseline; separar decisões registradas de propostas e pré-requisitos. Dev 3 consolida, Dev 1/2 validam suas fronteiras. | Uma versão coerente, com fonte, responsável e efeito de cada decisão; sem declarar runtime. | D2 |
| 3 | **Preparar validação descartável de banco — alta** | Aprovação de ambiente/operações na próxima tarefa | Seguir README, scripts, roles e migrations existentes do backend. Estabelecer alvo local descartável e credenciais sem exposição. | Banco novo aplica migrations; histórico íntegro; role runtime sem bypass; integração/RLS reproduzíveis. Comandos existentes: `npm run db:migrate:deploy`, `npm run db:verify-migrations`, `npm run db:verify-rls`, suítes integration/E2E. | D3 |
| 4 | **Fechar lacunas backend S3 — alta** | Decisões D4/D5; ambiente da etapa 3 quando necessário | D13, elegibilidade de mapping, replay/concorrência, auditoria OFX, lifecycle/limpeza e dependência Application→adapter. Arquivos E9–E12 e testes associados. | Cada regra deriva do contrato; regressões focadas; banco/armazenamento reais separados dos mocks; OpenAPI coerente. | D4/D5 |
| 5 | **Alinhar/restaurar clientes S3 — alta** | Etapa 1; contrato backend vigente | Recuperar ou implementar P43–P46 independentemente por plataforma; comparar snapshots/tipos, multipart, confirmação, mapping e estados atuais. | OFX/Pluggy presentes; contrato corresponde à revisão registrada; testes falham diante de drift relevante; nenhuma função continua marcada como pronta sem implementação. | D1/D4/D6 |
| 6 | **Consolidar aceite herdado S1–S3 — alta** | Etapas 3–5; usuários fictícios e ambiente autorizado | Dev 3 executa critérios, dois tenants, demonstrações e revisão. Preencher resultados observados de P32/P47. | Evidências por plataforma/revisão; nenhum aceite de Sandbox ou RLS baseado só em mocks; pendências preservam sprint de origem. | D3/D6 |
| 7 | **Implementar HU-008 — alta** | S4-01, HU-007 utilizável, capacidades e parâmetros aprovados | Persistência/controle de execuções, gatilhos diário/manual, QStash, acompanhamento, autorização, idempotência e concorrência; depois consumo cliente. | Agenda/manual observáveis; repetição e sobreposição controladas; retries aprovados; estados terminais e retomada testados. | D2/D4/D7 |
| 8 | **Implementar HU-012 — alta, ramo independente** | Baseline e modelo patrimonial aprovados | Domínio/API/Prisma/RLS/auditoria, depois clientes. Pode avançar sem aguardar HU-008. | Campos PRD, vínculo financiamento↔bem, histórico e isolamento verificados. | D8 |
| 9 | **Implementar HU-009 — alta** | Contrato/comportamento de sincronização aprovado; mapa de capacidade | Provider mapping, domínio, persistência/API e clientes; ausência/indisponibilidade/defasagem explícitas. | Campos e totais rastreáveis à fonte; nenhuma substituição inventada; contrato e casos parciais testados. | D4/D9 |
| 10 | **Implementar HU-011 — alta** | HU-009 e cálculo aprovado | Agrupamento classe/instituição; percentuais; não classificados; referência e dados parciais. | Casos esperados de denominador, moedas, arredondamento e incompletude reproduzíveis. | D9 |
| 11 | **Fechar S4-06/Sprint 4 — alta** | Quatro HUs implementadas e critérios detalhados | Dev 3 consolida P57/P59/P60, contratos, documentação, demonstração e revisão cruzada. | Matriz completa por HU/plataforma, verificações reais e bloqueios identificados. | D10 |
| 12 | **Executar extensão mobile aprovada — prioridade mista** | Plano P30 autorizado separadamente | Priorizar paginação de contas; depois tema e demais entregas solicitadas. Reutilizar componentes existentes. | 21ª conta acessível; tema conforme decisão; lógica testada e conferência em dispositivo. | Aprovação do escopo P30 |

Para as etapas de código, os comandos já existentes incluem `npm run test:unit`, `npm run test:integration`, `npm run test:e2e`, `npm run lint`, `npm run typecheck`, `npm run build` e geração OpenAPI no backend; `pnpm test`/`pnpm typecheck` nos clientes, mais build/lint web. Devem ser novamente conferidos na revisão recuperada, pois ela pode alterar scripts e pré-requisitos.

Nenhum comando de implementação da Sprint 5 foi proposto: patrimônio líquido, dashboard e projeções permanecem posteriores às bases exigidas.

## 6. Registro de decisões

| ID / questão | Evidência e importância | Opções e consequências | Recomendação / confiança | Etapas bloqueadas |
|---|---|---|---|---|
| **D1 — Onde está a entrega S3 cliente relatada?** | E13; documentação e checkout divergem. | Recuperar revisão existente evita trabalho duplicado; declarar não recuperável exige replanejar implementação; outro clone precisa ter proveniência demonstrada. | Localizar a revisão antes de reconstruir. **Alta.** | 1, 5, 6 |
| **D2 — Qual versão de S4-01 orienta o próximo plano?** | Adendo local define rotas/estados, enquanto seções anteriores ainda os deixam pendentes. | Consolidar adendo preserva decisões registradas; manter versões concorrentes permite interpretações incompatíveis. | Reconciliar a fonte vigente e registrar autoridade; não confundir isso com autorização de implementação. **Alta.** | 2, 7 |
| **D3 — Qual ambiente descartável valida migrations/RLS?** | E3; verificadores usam URLs específicas e escrevem dados. | Banco local descartável oferece isolamento; ambiente compartilhado exige autorização e controles adicionais. | Usar local descartável conforme tooling existente. **Alta.** | 3, parte de 4 e 6 |
| **D4 — Qual conta é elegível para `link`?** | D12 permite escolha explícita, mas “correspondente” permanece aberto. | Identidade externa exata reduz associação incorreta; seleção entre contas locais ativas cobre contas manuais, mas exige regra clara; heurística automática não foi autorizada. | Manter escolha explícita e não inventar matching; Produto fecha elegibilidade/ambiguidade. **Alta.** | Mapping em 4/5, parte de 6/7 |
| **D5 — D13 continua exigindo fallback? E qual lifecycle da prévia?** | Contrato exige fallback; adapter exige UUID. Não há garantia do provedor verificada nesta auditoria. Prazo de prévia não está estabelecido no material inspecionado. | Cumprir fallback aprovado; ou revisar formalmente a exigência com evidência primária. Para expiração, definir prazo/efeito antes de codificar; não confundir retenção de 90 dias com validade da prévia. | Verificar documentação primária e testes; preservar D13 até decisão responsável. Definir lifecycle explicitamente. **Alta sobre a necessidade; indeterminada sobre garantias do provedor.** | 4, aceite S3 |
| **D6 — Quais integrações/SDKs e plataformas serão exercitados?** | H3 cita limitações de Auth0 Native, SDK/deep link, R2 e Sandbox; código correspondente não está disponível aqui. | Recuperar versões exatas e validar compatibilidade; alterar SDK/dependência exige decisão própria. | Primeiro recuperar a entrega; depois verificar requisitos reais e autorizar operações específicas. **Alta.** | 5, 6 |
| **D7 — Parâmetros HU-008** | Adendo deixa horário/fuso/janela, retries/backoff, retenção, polling e atualização do Item pendentes. | Valores diferentes alteram carga, recuperação, UX e resultado observável. | Dev 1 propõe parâmetros com evidência; Produto decide os de negócio; Dev 2/3 validam consumo/aceite. Não há base para inventar números. **Alta.** | 7 |
| **D8 — Modelo HU-012** | PRD exige campos e associação, mas não define taxonomia/subtipos completos. | Modelo mínimo atende campos explícitos; especialização adicional aumenta contrato e validação. | Fechar somente os campos necessários às HUs aprovadas. **Alta.** | 8 |
| **D9 — Capacidades e cálculo de investimentos/alocação** | E14; fronteira HU-008/HU-009, campos, multimoeda, classificação, denominador e arredondamento não estão integralmente decididos. | Cobertura depende do que a fonte fornece; cortes exigem decisão; somar moedas sem regra produz total sem significado definido. | Mapa PRD→capacidade→campo→estado; aprovar cálculo antes da alocação. **Alta.** | 9, 10 |
| **D10 — Critérios e ownership de S4-06** | Plano referencia integração/cronograma, sem ficha equivalente às demais tarefas. | Derivar apenas critérios já sustentados pela definição de pronto; qualquer expansão precisa decisão explícita. | Detalhar fechamento por plataforma, revisão e evidência. **Alta.** | 11 |

A necessidade de **listagem de conexões não deve ser reaberta automaticamente**: o adendo local registra contrato sem listagem. Falta implementar/verificar recebimento e recuperação dos identificadores, respeitando essa decisão.

## 7. Limitações e afirmações não comprovadas

- **Não ficou comprovado que as Sprints 1–4 estão concluídas.** Faltam critérios de integração, revisão e demonstração; Sprint 4 também tem implementação principal ausente.
- **Não ficou comprovado que o trabalho cliente S3 nunca ocorreu.** Para resolver: commit, branch, clone, patch ou arquivo exportado que corresponda aos handoffs.
- **Não foi comprovada execução atual de migrations/RLS.** Para resolver: banco descartável identificado, comandos autorizados, resultados e histórico `_prisma_migrations`.
- **Não foi comprovada integração real Pluggy/QStash/R2/Auth0.** Para resolver: ambiente autorizado e registros sanitizados por cenário/revisão.
- **A contagem histórica 164 versus 165 não foi reconciliada.** Os 163 testes backend desta auditoria são outro recorte e outra revisão; não resolvem essa diferença.
- **Aprovações históricas foram tratadas como registros documentais.** Não foram usadas para autorizar alterações nesta tarefa.
- **Não houve verificação visual dos produtos/documentos ou medição de desempenho.** Os limites de escopo e os resultados acima não sustentam alegações nesses campos.
- O PDF-base da Sprint 1 permaneceu com o mesmo blob Git original. Sua leitura foi apenas textual: :codex-file-citation{path="C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro\assets\Plano_Divisao_Atividades_Sprint_1_3_Desenvolvedores.pdf" purpose="source"}

Os quatro HEADs, os estados Git e os hashes dos três arquivos previamente modificados permaneceram iguais aos do início. **Nenhum arquivo do projeto foi criado ou alterado; nenhuma dependência foi instalada, migration aplicada ou etapa futura implementada.**
