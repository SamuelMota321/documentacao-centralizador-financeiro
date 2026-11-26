# Auditoria atual do Developer 3 — estado de referência e matriz mestra

> **Leitura atual:** as seções 1–7 e o primeiro `Execution handoff` preservam a coleta do Plano 00, de 23/11/2026. As seções 8–13 registram o Plano 01, e as seções 14–17 registram o Plano 02. As seções 18–23 registram a execução de 24/11/2026 do **Plano 03**. A seção 23 contém o encerramento, após a instalação limpa offline e o build padrão do web com fontes locais. O nome do arquivo foi mantido para preservar as referências existentes.

**Plano executado:** somente Plano 00 — Congelar o estado de referência.

**Data:** 23 de novembro de 2026, fuso America/Sao_Paulo (UTC−03:00).

**Coleta Git de referência:** 2026-11-23, 23:16:24−03:00.

**Responsável pelo registro:** Developer 3 / agente Codex.

**Autorização:** `planejamento aprovado, pode implementar`, recebida nesta conversa após apresentação do plano específico.

O estado de referência dos quatro checkouts está identificado abaixo. Esta etapa estabelece rastreabilidade e um inventário inicial de responsabilidades; não revalida funcionalidades, contratos, suítes, integrações, demonstrações ou aceite das sprints.

## 1. Escopo e método

Foi executado o [Plano 00 do plano de recuperação](../docs/planejamento/plano-recuperacao-dev3.md#7-plano-00--congelar-o-estado-de-referência): inventário Git local dos quatro repositórios, identificação das alterações preexistentes e criação desta auditoria, separada da auditoria de outubro.

As verificações foram locais e de leitura, exceto pela criação deste arquivo. Não houve instalação de dependências, chamadas a integrações externas, fetch/pull, execução de aplicações, testes, lint, typecheck, build, migrations, alteração de código de produto ou regeneração de snapshots. Nenhum comando de instalação ou script de projeto foi executado.

O inventário usa `git status --porcelain=v1 --untracked-files=all`. “Sem alterações” significa ausência de alterações reportadas por esse comando; arquivos ignorados, dependências instaladas e configurações locais ignoradas não foram inventariados. Os remotos abaixo são configurações locais, sem confirmação de disponibilidade ou atualização em relação ao servidor.

## 2. Inventário dos quatro repositórios

Diretório comum dos checkouts:

```text
C:/Users/thi4g/OneDrive - União Brasileira de Educação Católica – UBEC/Documentos/CFI/
```

Cada nome abaixo identifica um subdiretório desse diretório comum. As datas são do committer do último commit (`%cI`), e não da coleta.

| Repositório | Branch | HEAD completo | Data do commit | Working tree inicial |
|---|---|---|---|---|
| `documentacao-centralizador-financeiro` | `main` | `0f8c9a6e8fa5bc15ee79e4d1677b7b31455c17f7` | `2026-11-06T20:15:24-03:00` | Um arquivo não versionado: `docs/planejamento/plano-recuperacao-dev3.md` |
| `backend-centralizador-financeiro` | `main` | `5414ea5642a854237f0a535e481a96d072c086b5` | `2026-10-22T20:36:45-03:00` | Sem alterações reportadas |
| `web-centralizador-financeiro` | `main` | `f8188d81b90ed46f294550428ceb169ceba9262d` | `2026-11-14T16:32:07-03:00` | Dois arquivos modificados, fora do stage: `package.json` e `pnpm-lock.yaml` |
| `mobile-centralizador-financeiro` | `main` | `859abacccb17dc165877d8f1832a6bf0686797d8` | `2026-10-28T23:10:55-03:00` | Sem alterações reportadas |

Nenhum dos quatro repositórios possuía alterações no stage (`git diff --cached --name-only` vazio).

| Repositório | Remoto `origin` — fetch e push | Assunto do commit |
|---|---|---|
| Documentação | `https://github.com/SamuelMota321/documentacao-centralizador-financeiro.git` | `docs(design): Style Guide 2.1 com cores de categoria e rosca (ADR-005)` |
| Backend | `https://github.com/SamuelMota321/backend-centralizador-financeiro.git` | `fix: allow Pluggy connection audit metadata` |
| Web | `https://github.com/SamuelMota321/web-centralizador-financeiro.git` | `Merge feat/graficos-animacao into main` |
| Mobile | `https://github.com/SamuelMota321/mobile-centralizador-financeiro.git` | `Merge origin/main: integrar Sprint 3 e reconciliar baseline HU-008` |

### 2.1. Alterações preexistentes preservadas

| Repositório / arquivo | Diferença observada | Tratamento nesta etapa |
|---|---|---|
| Documentação / `docs/planejamento/plano-recuperacao-dev3.md` | Arquivo não versionado e insumo da execução; seu conteúdo não pertence ao HEAD da documentação | Preservado integralmente; identificado por SHA-256 abaixo |
| Web / `package.json` | `devDependencies.@types/node`: `^20` → `^22.12.0`; uma linha adicionada e uma removida | Preservado; não atribuído ao Developer 3 |
| Web / `pnpm-lock.yaml` | Resolução de `@types/node`: `20.19.43` → `22.20.5`, com referências correspondentes de dependências e snapshots do lockfile; 22 linhas adicionadas e 22 removidas | Preservado; não instalado, normalizado ou regenerado |

O diff do web totaliza 23 inserções e 23 remoções em dois arquivos. Isso descreve o conteúdo local em relação ao HEAD, sem validar compatibilidade, origem ou intenção da alteração. O Git emitiu aviso de possível conversão futura LF → CRLF para o lockfile; esta etapa não realizou essa conversão.

### 2.2. Impressões digitais dos arquivos preservados

SHA-256 dos bytes locais coletados antes da criação da auditoria, usados também na conferência final de preservação:

| Repositório / arquivo | Bytes | SHA-256 |
|---|---:|---|
| Documentação / `docs/planejamento/plano-recuperacao-dev3.md` | 23416 | `C4B779BF816D1B2E8ED70E8DEE7E55D4DB0F8CA190AB5933C2F15630DFC693FE` |
| Web / `package.json` | 932 | `E82B8F29C36E823F83C7EBE7A1EAE06CA5E464AAD410B2967B52D637F36C33EA` |
| Web / `pnpm-lock.yaml` | 168228 | `B81E7B5E2CD108E90E00DEBB2BBDC56A105A86062B342C145FCD981EA6C161AF` |
| Documentação / `auditorias/auditoria-progresso-cfi-2026-10-27.m` | 61132 | `EB1B52720A182EFC0A5A27F55B3DE95BA44E80D2233BF4B3BECB2751D9822D27` |

### 2.3. Como vincular evidências futuras

Cada execução posterior deve registrar repositório, branch, HEAD completo, data/fuso, comando ou cenário, ambiente, resultado e código de saída quando aplicável. Deve registrar também o working tree usado. Um HEAD isolado não reproduz uma execução feita com arquivos locais diferentes do commit.

No web, qualquer execução que mantenha as alterações acima deve ser descrita como **HEAD mais alterações locais identificadas**, sem atribuir o resultado somente ao commit. Se os arquivos mudarem, registrar novo diff e novas impressões digitais. O plano de recuperação, por não estar versionado, é referenciado pela combinação de caminho e SHA-256 desta coleta.

Este documento é o artefato novo da etapa. Os quatro HEADs da tabela são as revisões auditadas, anteriores a qualquer eventual commit desta auditoria. Não foi criado commit nesta execução.

## 3. Fontes consultadas e sua autoridade

| Fonte | Uso no Plano 00 | Limite |
|---|---|---|
| Solicitação atual e autorização literal do usuário | Delimitação ao Plano 00 e autorização para criar somente esta auditoria | Não autoriza os Planos 01–09 |
| `AGENTS.md` dos quatro repositórios; módulos `00-workflow-and-evidence.md`, `02-change-control.md`, `03-validation.md` e `04-delivery.md` da documentação | Regras de investigação, aprovação, validação e entrega | Não constituem evidência de produto |
| [Plano de recuperação](../docs/planejamento/plano-recuperacao-dev3.md), especialmente seções 2, 4, 7 e 17 | Objetivo, entregável e handoff desta etapa | Estado conhecido da seção 3 é insumo a revalidar; arquivo local não versionado |
| Git local dos quatro checkouts | Branches, revisões, datas, remotos e alterações locais | Sem consulta ao servidor remoto e sem execução do produto |
| Diff de `package.json` e `pnpm-lock.yaml` do web | Identificação das alterações preexistentes | Não comprova instalação ou compatibilidade |
| [Auditoria de 27/10/2026](auditoria-progresso-cfi-2026-10-27.m), abertura e inventário dos prompts | Histórico e identificação estável de P13–P60 | Resultados e achados históricos não são resultados atuais |
| Os 12 prompts vinculados na seção 5, títulos, instruções específicas e estrutura de seções | Responsabilidades e inventário inicial de evidências | Um prompt descreve trabalho esperado; não comprova sua execução |

As fontes versionadas da documentação foram consultadas no HEAD indicado na seção 2 e não apresentaram alterações locais. Não há diretório `.planning` no checkout da documentação; não foram criados arquivos de estado GSD como parte desta etapa. Documentos de contratos, roteiros de demonstração, baseline S4-01 e código de produto não foram analisados para estabelecer comportamento atual no Plano 00.

## 4. Separação da auditoria histórica

A [auditoria de 27 de outubro de 2026](auditoria-progresso-cfi-2026-10-27.m) é **histórica** e permanece intacta. Ela registrou estas revisões:

| Repositório | HEAD auditado em outubro | Relação com esta coleta |
|---|---|---|
| Documentação | `fea1b578d5aac5e5d67db728a21a13cc2636e2fb` | Diferente do HEAD atual |
| Backend | `5414ea5642a854237f0a535e481a96d072c086b5` | Mesmo HEAD; nenhuma suíte foi reexecutada nesta etapa |
| Web | `35f8fe81c0300efde33c8a17d87373c88fd6e8e1` | Diferente do HEAD atual |
| Mobile | `230e6b4f70d74cdb08df43255b70467fbe5e3765` | Diferente do HEAD atual |

As contagens de testes e observações de ausência de clientes OFX/Pluggy daquele relatório não são transportadas como conclusões atuais. Mesmo o backend com HEAD idêntico exige identificação de ambiente e execução para produzir resultado atual. O plano de recuperação relata que os clientes S3 passaram a existir; essa informação também não substitui a revalidação posterior.

Os IDs P13–P60 abaixo vêm do inventário de outubro, usado somente para identificar os prompts, não para herdar seu aceite. A divergência Pluggy mobile, a preparação parcial de `sync-runs` e as lacunas de produto da Sprint 4 são **pendências relatadas pelo plano de recuperação, ainda não revalidadas nesta etapa**.

## 5. Tabela inicial dos prompts do Developer 3

Foram localizados os 12 arquivos esperados. Nenhum contém seção de título `Execution handoff` na coleta. Essa ausência é uma lacuna documental nos arquivos inspecionados; não prova que o trabalho nunca foi executado ou que não exista evidência em outra fonte.

**Status inicial comum:** execução e aceite não revalidados no Plano 00. A tabela inventaria responsabilidades; a matriz por critério pertence ao Plano 01. Nenhum desses prompts é marcado como concluído por esta auditoria.

| ID | Sprint | Prompt / responsabilidade | Evidência documental localizada no Plano 00 | Próxima ação do Developer 3 |
|---|---|---|---|---|
| P13 | 1 | [Baseline, aceite e contratos](../prompts/sprint1/dev3/dev-3-sprint-1-fase-1-baseline-aceite-contratos.md): contribuição S1-01–S1-07 | Prompt presente; sem `Execution handoff` | Mapear critérios e fontes no Plano 01 |
| P14 | 1 | [Testes críticos, contratos e isolamento](../prompts/sprint1/dev3/dev-3-sprint-1-fase-2-testes-criticos-contratos-isolamento.md): S1-08 e validação S1-02–S1-07 | Prompt presente; sem `Execution handoff` | Inventariar cobertura e pré-requisitos no Plano 01; execução posterior |
| P15 | 1 | [Integração, documentação e evidências](../prompts/sprint1/dev3/dev-3-sprint-1-fase-3-integracao-documentacao-evidencias.md): S1-09 e reconciliação S1-01–S1-09 | Prompt presente; sem `Execution handoff` | Mapear integração, demonstração e aceite pendentes no Plano 01 |
| P33 | 2 | [Baseline e aceite de Transactions](../prompts/sprint2/dev3/dev-3-sprint-2-fase-1-baseline-aceite-transactions.md): S2-01 e cobertura S2-02–S2-09 | Prompt presente; sem `Execution handoff` | Mapear critérios e dependências herdadas no Plano 01 |
| P34 | 2 | [Testes de movimentações, regras e isolamento](../prompts/sprint2/dev3/dev-3-sprint-2-fase-2-testes-movimentacoes-regras-isolamento.md): S2-07/S2-08 e validação S2-02–S2-06 | Prompt presente; sem `Execution handoff` | Inventariar cobertura e ambientes no Plano 01; execução posterior |
| P35 | 2 | [Integração, demonstração e evidências](../prompts/sprint2/dev3/dev-3-sprint-2-fase-3-integracao-demonstracao-evidencias.md): reconciliação S2-01–S2-09 | Prompt presente; sem `Execution handoff` | Mapear evidência observada por plataforma no Plano 01 |
| P48 | 3 | [Baseline e aceite de OFX/Pluggy](../prompts/sprint3/dev3/dev-3-sprint-3-fase-1-baseline-aceite-ofx-pluggy.md): S3-01 e critérios S3-02–S3-08 | Prompt presente; sem `Execution handoff` | Mapear decisões e contratos no Plano 01; reconciliar no Plano 02 |
| P49 | 3 | [Testes OFX/Pluggy, contratos e isolamento](../prompts/sprint3/dev3/dev-3-sprint-3-fase-2-testes-ofx-pluggy-contratos-isolamento.md): S3-02–S3-08 | Prompt presente; sem `Execution handoff` | Separar cobertura sintética e integração real na matriz do Plano 01 |
| P50 | 3 | [Integração, Sandbox, documentação e evidências](../prompts/sprint3/dev3/dev-3-sprint-3-fase-3-integracao-sandbox-documentacao-evidencias.md): S3-08 e handoff S4-01 | Prompt presente; sem `Execution handoff` | Mapear integrações, autorizações e dependências no Plano 01 |
| P58 | 4 | [Baseline, decisões e aceite](../prompts/sprint4/dev3/dev-3-sprint-4-fase-1-baseline-decisoes-aceite.md): S4-01 e critérios HU-008/HU-009/HU-011/HU-012 | Prompt presente; sem `Execution handoff` | Inventariar decisões no Plano 01; fechamento do baseline no Plano 07 |
| P59 | 4 | [Testes de sincronização, investimentos e patrimônio](../prompts/sprint4/dev3/dev-3-sprint-4-fase-2-testes-sincronizacao-investimentos-patrimonio.md): S4-02–S4-05 | Prompt presente; sem `Execution handoff`; dependência de produto relatada pelo plano, sem revalidação atual | Confirmar bloqueios por história no Plano 01; não declarar aceite sem produto executável |
| P60 | 4 | [Integração e consolidação de evidências](../prompts/sprint4/dev3/dev-3-sprint-4-fase-3-integracao-consolidacao-evidencias.md): fechamento S4-01–S4-05 e critérios suportados S4-06 | Prompt presente; sem `Execution handoff`; dependência de produto relatada pelo plano, sem revalidação atual | Confirmar pré-requisitos no Plano 01; manter fechamento condicionado às entregas |

Para todos os IDs, presença de implementação, presença de testes, teste executado nesta coleta, integração real, demonstração e aceite são evidências distintas. Nesta etapa, somente a presença dos prompts e a ausência da seção de handoff nesses arquivos foram verificadas. As demais dimensões não foram avaliadas.

## 6. Registro de comandos e resultados

Os comandos abaixo foram executados localmente nesta conversa; o inventário Git foi reconferido após a autorização. Os comandos Git de inventário foram executados separadamente em cada um dos quatro diretórios da seção 2.

| Comando / procedimento | Resultado observado | Limite |
|---|---|---|
| `Get-Date -Format o` | Data/fuso da coleta registrados; reconferência às 23:16:24−03:00 | Relógio local |
| `git branch --show-current` e `git rev-parse HEAD` | Sucesso, saída 0; quatro branches `main` e revisões da seção 2 | Estado local |
| `git log -1 --format='%cI%n%s'` | Sucesso, saída 0; datas e assuntos da seção 2 | Último commit local |
| `git remote -v` | Sucesso, saída 0; `origin` de fetch/push registrado | Sem acesso remoto |
| `git status --porcelain=v1 --untracked-files=all` | Sucesso, saída 0; inventário inicial da seção 2 | Exclui arquivos ignorados |
| `git diff --cached --name-only` | Sucesso, saída 0 e sem caminhos nos quatro repositórios | Nenhuma alteração preparada para commit |
| `git diff -- package.json pnpm-lock.yaml`, `git diff --stat` e `git diff --numstat` no web | Sucesso, saída 0; somente os dois arquivos e diferenças da seção 2.1 | Aviso LF/CRLF do lockfile; sem alteração pelo agente |
| `git ls-files` nos diretórios dos prompts e auditorias | Arquivos da auditoria histórica e dos 12 prompts versionados | Não comprova execução dos prompts |
| `rg --files` e leitura direcionada dos prompts e da auditoria histórica | Doze prompts identificados; associação dos IDs confirmada no inventário histórico | Leitura dos objetivos e estrutura; sem auditoria de produto |
| Busca de títulos `Execution handoff` nos 12 prompts | Zero seções localizadas em cada arquivo | Não exclui evidências em outros locais |
| `Get-FileHash -Algorithm SHA256` e tamanho dos arquivos preservados | Impressões digitais da seção 2.2 | Identifica bytes locais, inclusive do plano não versionado |
| `Test-Path -LiteralPath '.planning'` | `False` | Contexto GSD inexistente nesse checkout |

A conferência final desta etapa validou os quatro HEADs, branches e estados locais esperados, os quatro hashes de preservação, 16 referências locais e os 12 IDs sem ausência ou duplicação. A checagem documental terminou com `VALIDACAO DOCUMENTAL APROVADA`, saída 0. As seções de handoff ausentes foram reconferidas nos 12 prompts.

O arquivo novo foi incluído na verificação de whitespace. A tentativa com `git diff --no-index --check -- /dev/null auditorias/auditoria-dev3-atual-2026-11-23.md` retornou 1: inicialmente apontou quatro quebras Markdown com espaços finais, substituídas por linhas em branco; depois permaneceu com retorno 1 sem apontamentos de whitespace, pois há diferença em relação ao arquivo vazio. O Git também avisou sobre possível conversão futura LF → CRLF, sem alterar o arquivo. Para obter uma verificação inequívoca, a conferência final verificou diretamente todas as linhas com `Get-Content`, comparando cada linha com seu `TrimEnd()`: nenhum espaço final encontrado, saída 0. `git diff --check` isolado não incluiria o arquivo não versionado.

## 7. Limitações, pendências e responsáveis

| Item | Situação nesta etapa | Responsável / condição de continuidade |
|---|---|---|
| Evidência por critério dos 12 prompts | Ainda não consolidada; nenhuma execução atual presumida | Developer 3: construir a matriz no Plano 01 |
| Testes, lint, typecheck e build | Não executados por delimitação ao Plano 00; ambiente de execução não diagnosticado | Developer 3: Plano 03, depois da reconciliação prevista |
| PostgreSQL/RLS, Auth0, Pluggy Sandbox, QStash e armazenamento | Não acessados; disponibilidade e credenciais não verificadas | Responsável pelo ambiente: disponibilizar ambiente e autorização nas etapas correspondentes; Developer 3 registra o bloqueio concreto quando avaliado |
| Divergência Pluggy mobile e dependências de produto S4 | Relatadas pelo plano de recuperação; não confirmadas no HEAD nesta etapa | Developer 3 revalida; Dev 1 responde por backend e Dev 2 por clientes quando houver defeito comprovado; Produto responde por decisões de negócio pendentes |
| Dependências locais do web | Diferem do HEAD; intenção e compatibilidade não avaliadas | Autor das alterações locais / responsável pelo web, ainda não identificado; preservar e considerar na reprodução futura |
| Plano de recuperação não versionado | Fonte identificada por SHA-256, sem commit próprio | Usuário / responsável pela documentação decide seu versionamento em escopo separado |
| Estado dos remotos e pipelines | Não consultado | Verificar em etapa que exija e autorize essa evidência |

Não foi confirmado defeito novo de produto nesta etapa, pois código e comportamento não foram auditados. As pendências acima não autorizam assumir o escopo do Dev 1 ou Dev 2. Nenhuma decisão arquitetural ou de negócio foi tomada.

## Execution handoff

- **Plano executado:** Plano 00 — Congelar o estado de referência. Status: `concluído`, limitado ao inventário e à auditoria inicial; não representa conclusão da recuperação ou aceite das sprints.
- **Repositórios e revisões:** os quatro HEADs completos e estados locais estão na seção 2. A coleta inicial e a reconferência após autorização coincidiram.
- **Arquivos alterados:** somente criação de `auditorias/auditoria-dev3-atual-2026-11-23.md`. O plano de recuperação, a auditoria antiga, os prompts e os arquivos locais do web foram preservados. Não foi atualizado o índice de status do plano de recuperação, por ser um arquivo preexistente fora do conjunto aprovado de escrita; este handoff é o registro de execução do Plano 00.
- **Critérios verificados:** identificação das quatro revisões, branches, datas, remotos e working trees; alterações preexistentes identificadas; doze prompts inventariados; histórico explicitamente separado; nenhuma suíte histórica declarada atual. A conferência documental final verifica links, IDs, hashes e preservação dos estados.
- **Comandos executados e resultados:** seção 6; inventário Git local com saída 0, sem alterações no stage, e hashes dos arquivos preservados registrados. Conferência final de preservação e referências locais realizada sem executar scripts de produto.
- **Verificações não executadas:** suítes, lint, typecheck, build, contratos em execução, banco/RLS, integrações externas, demonstração, aceite, pipelines e atualização remota. Nenhuma instalação foi realizada.
- **Defeitos encontrados e responsáveis:** nenhum defeito novo de produto confirmado; lacuna de `Execution handoff` nos 12 prompts a investigar e consolidar pelo Developer 3 no Plano 01. Demais pendências e responsáveis na seção 7.
- **Decisões ainda abertas:** não foram resolvidas decisões de produto, contrato, dependências locais ou versionamento do plano preexistente.
- **Bloqueios de ambiente:** nenhum impediu o inventário local; disponibilidade de ambientes para planos posteriores não avaliada. Ausência de execução não foi classificada como falha de produto ou ambiente.
- **Riscos residuais:** revisões podem avançar após esta coleta; web possui mudanças locais; plano de recuperação não versionado; resultados históricos e relatos do plano ainda exigem revalidação por critério.
- **Próximo plano elegível:** Plano 01 — Construir a matriz mestra, em conversa própria. Não executado aqui.
- **Condição de entrada do próximo plano:** consultar esta auditoria, reconferir HEADs e working trees, identificar eventuais diferenças e obter a autorização específica exigida após apresentar o plano da nova etapa. A matriz deve separar implementação, teste presente, execução observada, integração real, demonstração e aceite.
- **Sugestão de commit:** `docs(dev3-00): registra estado de referencia e auditoria inicial`, incluindo exclusivamente esta auditoria e excluindo as alterações preexistentes. Nenhum commit foi criado nesta etapa.

## 8. Plano 01 — escopo, autorização e nova referência

**Atualização:** leitura iniciada em 23/11/2026 às 23:58−03:00 e continuada em 24/11/2026, America/Sao_Paulo. **Autorização específica:** `planejamento aprovado, pode implementar`, recebida após o plano desta etapa. **Arquivo de escrita autorizado:** somente esta auditoria.

O [Plano 01](../docs/planejamento/plano-recuperacao-dev3.md#8-plano-01--construir-a-matriz-mestra) exige mapear os critérios dos **12 prompts do Developer 3**: P13–P15, P33–P35, P48–P50 e P58–P60. O intervalo P13–P60 não inclui prompts de outros developers. O Plano 00 está concluído conforme o handoff preservado acima; não foi repetido nem teve seu histórico sobrescrito.

### 8.1. Revisões efetivamente consultadas

| Repositório | Branch / HEAD completo | Diferença em relação ao Plano 00 | Working tree na entrada do Plano 01 |
|---|---|---|---|
| Documentação | `main` / `7f43b05d85c69c2ceacdaadd5063cbacfb494608` | Auditoria e plano de recuperação já versionados; último commit `docs(dev3): adiciona plano de recuperacao e continuidade`, de 23/11/2026, 23:32:40−03:00 | Sem alterações reportadas |
| Backend | `main` / `5414ea5642a854237f0a535e481a96d072c086b5` | Mesmo HEAD da referência | Sem alterações reportadas |
| Web | `main` / `00717135e92f62e84d2c53cb3f63f8c91a44b7ca` | Último commit `chore(deps): atualiza tipos do Node para a versao 22`, de 23/11/2026, 23:32:44−03:00; as alterações locais de dependências descritas no Plano 00 estão agora versionadas | Sem alterações reportadas |
| Mobile | `main` / `859abacccb17dc165877d8f1832a6bf0686797d8` | Mesmo HEAD da referência | Sem alterações reportadas |

Os quatro estados foram lidos com `git branch --show-current`, `git rev-parse HEAD`, `git status --porcelain=v1 --untracked-files=all` e `git log -1 --format='%cI%n%s'`. Sem fetch/pull ou consulta a pipelines remotos. O SHA-256 do plano de recuperação continua `C4B779BF816D1B2E8ED70E8DEE7E55D4DB0F8CA190AB5933C2F15630DFC693FE`; o da auditoria de outubro continua `EB1B52720A182EFC0A5A27F55B3DE95BA44E80D2233BF4B3BECB2751D9822D27`.

### 8.2. Método e limites

Foi feita leitura dos 12 prompts, critérios dos planos de sprint, especificações diretamente vinculadas, decisões S3/S4, handoffs selecionados e arquivos pertinentes de implementação/teste. Títulos de testes, assertions e configuração foram inspecionados para identificar **testes presentes**, sem inferir aprovação ou cobertura exaustiva. Ausências abaixo são limitadas às áreas enumeradas; não resultam de execução do produto.

Nenhum teste, lint, typecheck, build, instalação, aplicação, migration ou integração externa foi executado. Não se abriu `.env`, não se verificou valor de credencial e não se acessou banco, Auth0, Pluggy, QStash ou R2. A disponibilidade desses ambientes permanece **não avaliada**; necessidade de ambiente não equivale a indisponibilidade comprovada. Código, snapshots, testes, contratos e roteiros permanecem intactos. Os cenários e comandos da matriz são para etapas futuras e não são autorização para executá-los agora.

## 9. Fontes e catálogo de evidências do Plano 01

As fontes versionadas pertencem aos HEADs da seção 8.1. Os IDs dos prompts e seus links estão na seção 5. Cada subseção da matriz herda o prompt indicado, além da fonte normativa identificada na linha. A evidência usa caminhos relativos a esta auditoria, inclusive para os checkouts irmãos.

### 9.1. Fontes de critério

| ID | Fonte e parte aplicável | Autoridade / limite |
|---|---|---|
| F1 | [Plano Sprint 1](../docs/planejamento/sprint-01/Plano_Divisao_Atividades_Sprint_1.html), S1-01–S1-09 e checklist; [Autenticação e contas](../docs/planejamento/sprint-01/especificacao-autenticacao-contas.html); [Manutenção e isolamento](../docs/planejamento/sprint-01/especificacao-manutencao-isolamento-contas.html) | Manutenção resolve “desativar/excluir” em desativação lógica; hard delete não é critério atual |
| F2 | [Plano Sprint 2](../docs/planejamento/sprint-02/Plano_Divisao_Atividades_Sprint_2.html), S2-01–S2-09; [Especificação Transactions](../docs/planejamento/sprint-02/especificacao-transactions.html), TX/TRF/CAT/RULE/IDEM/AUD | Transferências contábeis; idempotência 24h; maior prioridade, depois `createdAt` e `id` ascendentes; correção manual prevalece; só regras pessoais no S2 |
| F3 | [Plano Sprint 3](../docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html), S3-01–S3-08; [Contrato S3-01](../docs/planejamento/sprint-03/contrato-backend-s3-01.html), D1–D17 e estados; [Necessidades dos clientes](../docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md) | Diferenciar decisões de propostas e relatos antigos; limites web 4 MiB, backend/mobile 10 MiB; prévia 24h e mapeamento são requisitos distintos da retenção de resultado |
| F4 | [Plano Sprint 4](../docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html), S4-01–S4-05, referências a S4-06 e definição de pronto | S4-06 suporta integração/contrato/evidências; não autoriza inventar escopo adicional. Sprint 5 excluída |
| F5 | [Baseline Dev 1 S4-01](../docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md), **adendo de 27/10** e C-01–C-06; [Mapa Dev 2](../docs/planejamento/sprint-04/s4-dev2-mapeamento-dados-por-tela.md), P-01–P-09 | Adendo consolida contrato público HU-008 e ausência de listagem, sem implementá-los; parâmetros operacionais, capacidade e decisões de Produto seguem pendentes |
| F6 | [OpenAPI backend](../../backend-centralizador-financeiro/openapi/openapi.json); contratos locais [web](../../web-centralizador-financeiro/src/lib/api/CONTRACT.md) e [mobile](../../mobile-centralizador-financeiro/src/lib/api/CONTRACT.md) | Contrato publicado descreve a API existente; divergência com requisito aprovado vira pendência, sem alterar a expectativa para acomodar produto incompleto |

### 9.2. Evidência estática de implementação e testes presentes

`I` significa implementação/artefato inspecionado; `T` significa teste localizado e lido no recorte relevante. Nenhum `T` significa teste executado. Referências a diretórios são inventários limitados, não comprovação de cobertura total.

| ID | Implementação / documentação inspecionada | Testes presentes e alcance observado |
|---|---|---|
| E01 | READMEs [backend](../../backend-centralizador-financeiro/README.md), [web](../../web-centralizador-financeiro/README.md), [mobile](../../mobile-centralizador-financeiro/README.md); `package.json` dos três; [CI backend](../../backend-centralizador-financeiro/.github/workflows/ci.yml) | [Configuração backend](../../backend-centralizador-financeiro/src/config/environment.schema.spec.ts); scripts declarados, sem execução. `.github` não foi encontrado nos clientes; isso não prova ausência de pipeline externo |
| E02 | Backend [verificador JWT](../../backend-centralizador-financeiro/src/modules/identity/adapters/inbound/auth0-access-token-verifier.ts), [guard](../../backend-centralizador-financeiro/src/modules/identity/adapters/inbound/auth0-jwt.guard.ts), resolução de identidade | Specs vizinhos do verificador/guard; [accounts E2E](../../backend-centralizador-financeiro/test/e2e/accounts.e2e.spec.ts), casos bearer ausente/inválido/expirado com verificador substituído. Não exercitam assinatura/JWKS reais |
| E03 | Backend [criação](../../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/create-manual-account.ts), [listagem](../../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/list-accounts.ts), [schema Prisma](../../backend-centralizador-financeiro/prisma/schema.prisma) | Specs vizinhos; [persistência Accounts](../../backend-centralizador-financeiro/test/integration/prisma-accounts.repository.integration.spec.ts); accounts E2E: tenant, ativas, validação e duplicidade |
| E04 | Backend [update](../../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/update-account.ts), [deactivate](../../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/deactivate-account.ts), [AuditRecord](../../backend-centralizador-financeiro/src/modules/audit/application/audit-record.ts) | Specs vizinhos; [maintenance E2E](../../backend-centralizador-financeiro/test/e2e/account-maintenance.e2e.spec.ts): idempotência, arquivada, connected, cross-tenant; deactivate spec contempla falha da auditoria |
| E05 | [Transação tenant-aware](../../backend-centralizador-financeiro/src/infrastructure/database/prisma-tenant-transaction.ts), [migrations](../../backend-centralizador-financeiro/prisma/migrations), [verificador SQL RLS](../../backend-centralizador-financeiro/scripts/database/verify-rls.sql) | [Identity/Accounts integração](../../backend-centralizador-financeiro/test/integration/identity-accounts.integration.spec.ts), [RLS](../../backend-centralizador-financeiro/test/integration/rls.integration.spec.ts); exigem PostgreSQL, não mocks |
| E06 | OpenAPI F6 e snapshots [web](../../web-centralizador-financeiro/src/lib/api/openapi.snapshot.json) / [mobile](../../mobile-centralizador-financeiro/src/lib/api/openapi.snapshot.json) | [Contrato backend](../../backend-centralizador-financeiro/test/contract/openapi.contract.spec.ts), [web](../../web-centralizador-financeiro/src/lib/api/contract.test.ts), [mobile](../../mobile-centralizador-financeiro/src/lib/api/contract.test.ts); cliente compara seu snapshot local, não garante paridade com HEAD backend |
| E07 | Web [Auth0](../../web-centralizador-financeiro/src/lib/auth0.ts), [proxy](../../web-centralizador-financeiro/src/proxy.ts), [contas](../../web-centralizador-financeiro/src/app/(app)/contas), [API Accounts](../../web-centralizador-financeiro/src/lib/accounts/api.ts) | `src/proxy.test.ts`, `src/lib/accounts/*.test.ts`, `contas/actions.test.ts`: sessão simulada, PATCH, duplicidade, mensagens e desativação. Sem navegador real |
| E08 | Mobile [AuthContext](../../mobile-centralizador-financeiro/src/auth/AuthContext.tsx), [App](../../mobile-centralizador-financeiro/App.tsx), [AccountsScreen](../../mobile-centralizador-financeiro/src/screens/AccountsScreen.tsx), API Accounts | [session-store](../../mobile-centralizador-financeiro/src/auth/session-store.test.ts), [session-epoch](../../mobile-centralizador-financeiro/src/auth/session-epoch.test.ts), [Accounts API](../../mobile-centralizador-financeiro/src/lib/accounts/api.test.ts): expiração, limpeza, bearer e mutações; não renderizam telas |
| E09 | Backend [movimentação](../../backend-centralizador-financeiro/src/modules/transactions/application/use-cases/create-manual-transaction.ts), [transferência](../../backend-centralizador-financeiro/src/modules/transactions/application/use-cases/create-accounting-transfer.ts), [idempotência](../../backend-centralizador-financeiro/src/modules/transactions/application/idempotency.ts) | [create-movements](../../backend-centralizador-financeiro/src/modules/transactions/application/use-cases/create-movements.spec.ts), [Transactions E2E](../../backend-centralizador-financeiro/test/e2e/transactions.e2e.spec.ts): duas entradas, replay, conflito, expiração, concorrência e rollback |
| E10 | Backend [correção de categoria](../../backend-centralizador-financeiro/src/modules/transactions/application/use-cases/update-transaction-category.ts), [regras](../../backend-centralizador-financeiro/src/modules/transactions/application/use-cases/category-rule-lifecycle.ts), domínio Transactions e repositório Prisma | `category-rule.spec.ts`, `update-transaction-category.spec.ts`, `transactions.use-cases.spec.ts`, Transactions E2E: prioridade, correção, ciclo de vida e ownership |
| E11 | Backend [Prisma Transactions](../../backend-centralizador-financeiro/src/modules/transactions/adapters/outbound/prisma-transactions.repository.ts), [idempotência Prisma](../../backend-centralizador-financeiro/src/modules/transactions/adapters/outbound/prisma-idempotency.repository.ts) | [Persistência Transactions](../../backend-centralizador-financeiro/test/integration/prisma-transactions.repository.integration.spec.ts): rollback de segunda entrada e auditoria; [RLS Transactions](../../backend-centralizador-financeiro/test/integration/transactions-rls.integration.spec.ts): sem contexto, tenant e constraints |
| E12 | Web [movimentações](../../web-centralizador-financeiro/src/app/(app)/movimentacoes), [regras](../../web-centralizador-financeiro/src/app/(app)/regras), APIs `transactions`, `categories`, `category-rules` | Tests vizinhos de APIs/schemas, `movimentacoes/actions.test.ts` e `regras/actions.test.ts`/`rule-logic.test.ts`; funções e Server Actions com dependências simuladas |
| E13 | Mobile [MovementsScreen](../../mobile-centralizador-financeiro/src/screens/MovementsScreen.tsx), [RulesScreen](../../mobile-centralizador-financeiro/src/screens/RulesScreen.tsx), APIs Transactions/categorias/regras | `src/lib/transactions/api.test.ts`, `src/lib/category-rules/api.test.ts`, `src/screens/movement-input.test.ts`, `rule-logic.test.ts`; lógica sem fluxo de tela real |
| E14 | Backend [prévia OFX](../../backend-centralizador-financeiro/src/modules/ingestion/application/use-cases/create-ofx-import-preview.ts), [confirmação](../../backend-centralizador-financeiro/src/modules/ingestion/application/use-cases/confirm-ofx-import.ts), [ImportRun](../../backend-centralizador-financeiro/src/modules/ingestion/domain/import-run.ts), [repositório](../../backend-centralizador-financeiro/src/modules/ingestion/adapters/outbound/prisma-ingestion.repository.ts), [R2](../../backend-centralizador-financeiro/src/modules/ingestion/adapters/outbound/cloudflare-r2-ofx-source-object-store.adapter.ts) | Specs de parser/prévia/confirmação/ImportRun; [OFX integração](../../backend-centralizador-financeiro/test/integration/ofx-ingestion.integration.spec.ts), [ingestion E2E](../../backend-centralizador-financeiro/test/e2e/ingestion.e2e.spec.ts): arquivo inválido, limite, dedupe, tenant e replay; storage/provider substituídos quando aplicável |
| E15 | Web [OFX](../../web-centralizador-financeiro/src/app/(app)/contas/importar-ofx), [validação de arquivo](../../web-centralizador-financeiro/src/lib/ingestions/file-validation.ts), [config Next](../../web-centralizador-financeiro/next.config.ts) | `src/lib/ingestions/*.test.ts`, `importar-ofx/actions.test.ts`/`presentation.test.ts`; schema test **rejeita** `awaiting_account_mapping`; limite 4 MiB e folga multipart declarados |
| E16 | Mobile [OfxImportScreen](../../mobile-centralizador-financeiro/src/screens/OfxImportScreen.tsx), [schema](../../mobile-centralizador-financeiro/src/lib/ingestions/schema.ts), [arquivo](../../mobile-centralizador-financeiro/src/lib/ingestions/file-validation.ts) | `src/lib/ingestions/*.test.ts`, [ofx-import-logic](../../mobile-centralizador-financeiro/src/screens/ofx-import-logic.test.ts); schema test rejeita `awaiting_account_mapping`; limite 10 MiB |
| E17 | Backend [lifecycle Pluggy](../../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/pluggy-connection-lifecycle.ts), [provider adapter](../../backend-centralizador-financeiro/src/modules/accounts/adapters/outbound/pluggy-api.client.ts), [fila/webhook](../../backend-centralizador-financeiro/src/modules/accounts/adapters/outbound/qstash-pluggy-webhook.service.ts) | `pluggy-connection-lifecycle.spec.ts`, `pluggy-api.client.spec.ts`: token limitado, Item alheio, revogação, repetição webhook e rechecagem de consentimento com dublês |
| E18 | Backend [importação inicial](../../backend-centralizador-financeiro/src/modules/ingestion/application/use-cases/pluggy-initial-import.ts), [controller](../../backend-centralizador-financeiro/src/modules/ingestion/adapters/inbound/pluggy-initial-import.controller.ts), [repositório](../../backend-centralizador-financeiro/src/modules/ingestion/adapters/outbound/prisma-pluggy-initial-import.repository.ts), [mapeamento](../../backend-centralizador-financeiro/src/modules/accounts/application/use-cases/pluggy-account-mapping.ts), [importador](../../backend-centralizador-financeiro/src/modules/transactions/application/use-cases/import-pluggy-transaction.ts) | `pluggy-initial-import.spec.ts`: escopo consentido, exclui investimento, inelegibilidade, preserva importadas após falha; `import-pluggy-transaction.spec.ts`: identidade estável. Não localizado caso específico de replay da conclusão no spec da importação inicial |
| E19 | Web [API conexões](../../web-centralizador-financeiro/src/lib/connections/api.ts), [schema](../../web-centralizador-financeiro/src/lib/connections/schema.ts), [fluxo conectar](../../web-centralizador-financeiro/src/app/(app)/contas/conectar) | `src/lib/connections/api.test.ts`, `conectar/actions.test.ts`: chave na conclusão, resposta aceita, reenvio, erros. Não comprova UI de mapeamento/retomada da importação inicial |
| E20 | Mobile [API conexões](../../mobile-centralizador-financeiro/src/lib/connections/api.ts), [schema](../../mobile-centralizador-financeiro/src/lib/connections/schema.ts), [ConnectScreen](../../mobile-centralizador-financeiro/src/screens/ConnectScreen.tsx) | `src/lib/connections/api.test.ts` espera explicitamente resposta `200` **sem** `Idempotency-Key`; `connect-logic.test.ts` cobre estados e mensagens. Expectativa antiga não valida o contrato atual |
| E21 | Web [sync-runs](../../web-centralizador-financeiro/src/lib/sync-runs/api.ts), schema/tipos/fixtures vizinhos | [api.test.ts](../../web-centralizador-financeiro/src/lib/sync-runs/api.test.ts): solicitação `202`, consulta, status finais e origem de `statusUrl`, todos com fetch simulado; não há chamada de tela para essas funções |
| E22 | Inventário backend `src/modules`, Prisma, controllers e OpenAPI; clientes `src`/mobile `App.tsx` | Não localizados backend/modelos/rotas/specs HU-008/HU-009/HU-011/HU-012, nem telas de investimento/alocação/patrimônio. Mobile sem camada `sync-runs`; web apenas E21. Conta de tipo `investment` não equivale a posição de investimento |

### 9.3. Handoffs e roteiros são insumos, não aceite

| ID | Insumo consultado | Uso e limite nesta matriz |
|---|---|---|
| H1 | [Dev 2 S1, fase 5](../prompts/sprint1/dev2/dev-2-sprint-1-fase-5-testes-consolidacao.md), `Execution handoff` de 23/09 | Relata testes e demo web histórica; mobile manual pendente. Não transporta contagens ou sucesso para os HEADs atuais |
| H2 | [Dev 1 S2-02](../prompts/sprint2/dev1/dev-1-sprint-2-fase-2-persistencia-transactions.md), `Execution handoff` | Evidência histórica da fundação em `b61b205`; não aceita fases posteriores nem substitui PostgreSQL atual |
| H3 | [Dev 2 S2, fase 7](../prompts/sprint2/dev2/dev-2-sprint-2-fase-7-testes-consolidacao.md), `Execution handoff`; [roteiro S2](../prompts/sprint2/dev2/roteiro-demonstracao-sprint-2.md) | Casos W/R/I/M reaproveitáveis, colunas `Observado` vazias; contrato/revisões históricos exigem reconferência |
| H4 | [Dev 2 S3, fase 5](../prompts/sprint3/dev2/dev-2-sprint-3-fase-5-testes-consolidacao.md), `Execution handoff`; [roteiro S3](../prompts/sprint3/dev2/roteiro-demonstracao-sprint-3.md) | Cenários O/D/P/M/I, mocks e bloqueios históricos explicitados; ausência histórica de importação inicial já não descreve todo o backend/web |
| H5 | Baseline Dev 1 e mapa Dev 2 F5 | Decisões/levantamento, sem aceite transversal S4-01 ou comprovação de capacidade Pluggy. Adendo prevalece sobre perguntas já resolvidas do corpo histórico |

Os 12 prompts Dev 3 continuam sem `Execution handoff` próprio; o handoff desta recuperação fica na seção 13, sem afirmar execução dos prompts originais. Demonstração, revisão cruzada e aceite formal atuais não foram observados.

## 10. Como interpretar e reproduzir a matriz

### 10.1. Classificação e execução

| Código | Classificação | Regra de uso |
|---|---|---|
| V | Verificado | Somente fato documental/estático efetivamente observado nesta etapa; não aceita comportamento do produto |
| IR | Implementado mas não revalidado | Caminho de implementação e teste/evidência presentes no recorte; comportamento exige execução posterior |
| PA | Parcial | Parte do critério existe e a lacuna está identificada; não é aceite parcial implícito |
| BL | Bloqueado | Falta decisão, implementação dependente ou evidência indispensável identificada na linha e/ou seção 12 |
| NI | Não implementado | Implementação exigida não localizada nas áreas explicitamente inspecionadas; não confundir com teste não executado |
| OB | Obsoleto | Premissa histórica superada por fonte específica; preservar histórico e indicar substituição |

Em **Exec.**, `NE` significa **não executado nesta etapa**, sem resultado aprovado/reprovado. `LE` significa **leitura estática/documental realizada**, sem execução de teste. Na coluna de evidência, `I` e `T` se referem aos itens E01–E22; `T: não localizado` é uma lacuna no recorte, não uma busca universal. Ausência de teste específico não vira automaticamente falha de produto. Não há aceite de sprint ou integração real nesta matriz.

### 10.2. Ambientes e métodos de verificação futura

Cada linha fornece cenário concreto e ambiente. Quando indica método C1–C8, o comando exato e diretório são os seguintes. **Nenhum foi executado aqui.** Selecionar arquivos pertinentes ao critério em nova etapa autorizada; não executar tudo indiscriminadamente.

| Método / ambiente | Comando ou procedimento futuro | Pré-requisitos / efeitos |
|---|---|---|
| DOC | Leitura de fonte e comparação localizada de artefatos nos HEADs da seção 8.1 | Sem execução do produto; pode ser realizada nesta etapa |
| C1 / U-B | Backend: `npm test -- <caminho-do-spec-em-src>` | Node/dependências do backend; Vitest filtrado por arquivo de `src`, sem acrescentar o filtro amplo `src` dos scripts de grupo; dublês não comprovam serviços reais |
| C2 / DB | Backend: `npm test -- <caminho-do-spec-em-test/integration>` | `TEST_DATABASE_URL` com papel de teste e migrations fornecidos por Dev 1 em PostgreSQL **local/descartável autorizado**; cria/limpa dados sintéticos; filtro apenas pelo arquivo selecionado |
| C3 / DB | Backend: `npm test -- <caminho-do-spec-em-test/e2e>` | Mesmo banco C2; Supertest inicializa aplicação e substitui autenticador/provider conforme spec; não é sessão Auth0 real; filtro apenas pelo arquivo selecionado |
| C4 / U-B | Backend: `npm test -- test/contract/openapi.contract.spec.ts` | Dependências/configuração de teste; cotejar também F6 com cada cliente, sem regenerar snapshots |
| C5 / U-W | Web: `pnpm test -- <caminho-do-test>` | Dependências web; fetch/Auth0/Next simulados; não cobre navegador real |
| C6 / U-M | Mobile: `pnpm test -- <caminho-do-test>` | Dependências mobile; lógica/API com dublês; não cobre dispositivo ou widget real |
| C7 / DB | Backend: `npm run db:verify-rls` | Revisar previamente scripts e alvo; banco descartável autorizado e papéis sem bypass de RLS. Verificação pode escrever dados de ensaio |
| C8 / Q | Backend: `npm run lint`, `npm run typecheck`, `npm run build`; web: `pnpm lint`, `pnpm typecheck`, `pnpm build`; mobile: `pnpm typecheck` | Scripts lidos nos `package.json`; typecheck/build podem gerar Prisma, tipos e artefatos. Mobile não declara scripts `lint`/`build`; não inventar comando ou tratar ausência como passe |
| REAL-W | Executar o cenário indicado no navegador com backend e Auth0 de teste autorizados; duas identidades A/B, tenants financeiros distintos | Runtime + PostgreSQL, configuração segura; cria registros fictícios. Não iniciado nesta etapa |
| REAL-M | Mesmo cenário em dispositivo/emulador Expo, Auth0 Native e backend alcançável | Resultado separado do web; sem biblioteca nova ou sessão real presumida |
| EXT | Pluggy Sandbox + QStash e/ou bucket R2 privado, **somente quando o cenário exigir** e houver autorização específica | Responsável de ambiente/Dev 1 confirma configuração e operações; não inferir acesso. OFX atual usa R2; preparação HU-008 não torna R2 dependência universal |
| CI | Ler configuração e obter resultado de run no SHA auditado em etapa posterior | Sem disparar deploy. Configuração backend encontrada; existência/resultado remoto dos clientes não avaliados |

Os comandos por arquivo usam os caminhos dos testes do catálogo E. Os diretórios de trabalho são os checkouts da seção 2/8.1. Antes da execução futura, confirmar seleção do runner e revisar helpers, credenciais e possíveis efeitos; esta etapa não diagnostica a base de execução do Plano 03.

## 11. Matriz mestra por critério

Os sufixos `.01`, `.02` etc. são identificadores desta matriz, não novos prompts ou tarefas de produto. A fonte F indicada em cada linha complementa o prompt da seção 5. Quando o mesmo comportamento aparece em baseline, teste e integração, os critérios mantêm essas finalidades distintas. **Todos os resultados de runtime são NE.** O estado do prompt inteiro não é calculado pela contagem de arquivos ou testes.

**Inventário:** 128 critérios: 9 V (fatos documentais/estáticos), 39 IR, 38 PA, 28 BL, 13 NI e 1 OB. As sete premissas históricas da seção 12.1 são explicações complementares e não entram nessa contagem. Nenhum desses números representa testes executados ou critérios de produto aceitos.

### 11.1. P13 — Sprint 1: baseline, aceite e contratos

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P13.01 | S1-01: identificar três produtos independentes, REST `/api/v1`, Auth0, tenancy e fontes de aceite (F1) | V | E01, E02, E06 e esta matriz identificam os três checkouts e contratos | E06 localizado; resultado não usado para este fato | LE | Conferir revisões, fontes e escopo da seção 8 | DOC | D3: baseline documental mapeado; aceite funcional segue P14/P15 |
| P13.02 | S1-02: instruções permitem instalação/configuração/execução reproduzíveis e seguras (F1) | PA | E01: READMEs e scripts presentes | E01: validação de configuração presente | NE | Reproduzir setup a partir das instruções sem mostrar valores de ambiente; registrar cada saída | Q + DB + REAL-W/M | D3, apoio D1/D2: diagnosticar no Plano 03; não assumir que instalação histórica reproduz hoje |
| P13.03 | S1-03: usuário, tenant, identidade e conta têm propriedade obrigatória e persistência (F1) | IR | E03/E05: modelos e transação tenant-aware | E03/E05: integração de identidade e contas | NE | C2: provisionar duas identidades, persistir conta A, consultar como A/B | DB | D3: Plano 04; D1 recebe inconsistência comprovada |
| P13.04 | S1-04: critérios separam rejeição JWT, sessão web e sessão mobile (F1) | V | E02/E07/E08: três mecanismos identificados; P14.01–03 independentes | Specs de guard/proxy/session-store identificados | LE | Conferir separação dos cenários e limites de mocks | DOC | D3: não converter validação simulada em Auth0 real |
| P13.05 | S1-05: criação/listagem incluem validação, propriedade, BRL e confirmação de possível duplicidade (F1) | IR | E03/E07/E08 | Specs de criação/listagem, accounts E2E e APIs clientes | NE | C1/C3/C5/C6: criar válida, rejeitar campo inválido/tenant enviado, confirmar candidata connected e listar só ativas próprias | U-B/W/M + DB | D3: Plano 04; D1 backend, D2 clientes se falhar |
| P13.06 | S1-06: manutenção usa desativação lógica, conta arquivada não aceita PATCH, connected é somente leitura (F1) | IR | E04/E07/E08 | E04: update/deactivate e maintenance E2E; APIs clientes | NE | C1/C3: desativar duas vezes, preservar instante/histórico, tentar PATCH arquivada/connected | U-B/W/M + DB | D3: Plano 04, usando contrato normativo de manutenção |
| P13.07 | S1-07: matriz cobre autorização da aplicação e RLS separadamente, inclusive mutações (F1) | V | E05 e P14.07–09 distinguem camadas | RLS e E2E localizados, sem execução | LE | Conferir que caso permitido e cross-tenant têm cenário/ambiente próprio | DOC | D3: executar defesas em profundidade só no Plano 04 |
| P13.08 | S1-03/08: clientes tipados independentes têm origem e compatibilidade verificáveis (F1/F6) | PA | E06; F6 informa tipos mantidos à mão e gerador ainda sem decisão | Contratos de snapshot presentes em ambos | NE | Comparar operações de contas com OpenAPI atual; distinguir tipos manuais de cliente gerado | DOC + U-W/M | D1/D2: esclarecer contrato de geração B11; D3 reconciliar no Plano 02 |

### 11.2. P14 — Sprint 1: testes críticos, contratos e isolamento

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P14.01 | S1-04/08: bearer ausente, inválido ou expirado impede caso de uso; contexto local inválido retorna 403 genérico (F1) | IR | E02: guard/verificador | Guard/verificador specs e accounts E2E, com autenticador substituído | NE | C1/C3: repetir cada token e conferir 401/403 sem detalhe sensível; assinatura/issuer/audience reais exigem cenário Auth0 separado | U-B + DB; REAL-W/M para Auth0 | D3: Plano 04; não afirmar criptografia/JWKS real por mock |
| P14.02 | S1-04: login, área protegida, expiração e logout web bloqueiam acesso e navegação anterior (F1) | IR | E07: SDK, proxy e sessão no servidor | `proxy.test.ts` e actions com sessão simulada | NE | C5 + roteiro README S1: A entra/sai, volta no navegador e tenta rota sem sessão | U-W + REAL-W | D3/D2: produzir observação própria do web no Plano 04 |
| P14.03 | S1-04: sessão mobile expira, limpa SecureStore e ignora 401 tardio de sessão anterior (F1) | IR | E08: AuthContext/SessionEpoch | Session-store/epoch e API Accounts | NE | C6 + login/logout/expiração no dispositivo; iniciar A, sair, entrar B, receber resposta tardia | U-M + REAL-M | D3/D2: validar Native/redirect e dispositivo no Plano 04, B09 |
| P14.04 | S1-05: criação/listagem persistem valores e paginação sem expor conta alheia (F1) | IR | E03, E07, E08 | Persistência Accounts, accounts E2E, schemas/APIs clientes | NE | C2/C3: criar A, reler em outra requisição, paginar e comparar visibilidade A/B; C5/C6 para contrato | DB + U-W/M | D3: Plano 04; D1/D2 corrigem sua camada |
| P14.05 | S1-06: PATCH valida campos permitidos, par saldo/data e duplicidade confirmável (F1) | IR | E04; PATCH clients E07/E08 | Update spec, maintenance E2E e patch/actions tests | NE | C1/C3/C5/C6: PATCH vazio/imutável/par incompleto, duplicidade sem/com confirmação | U-B/W/M + DB | D3: Plano 04 |
| P14.06 | S1-06: desativação é idempotente, some da listagem e exige confirmação visual em cada cliente (F1) | PA | E04; diálogo/alerta em E07/E08 | Backend e APIs cobertos; confirmação visual não exercitada | NE | C3: repetir desativação; REAL-W e REAL-M: cancelar e confirmar, conferir estado após resposta | DB + REAL-W/M | D3/D2: validar UI separadamente; não inferir diálogo a partir de API test |
| P14.07 | S1-07: leitura/criação/edição/desativação não permitem manipular tenant ou recurso alheio (F1) | IR | E02–E05: contexto derivado e filtros | Accounts/maintenance E2E e integração de propriedade | NE | C2/C3: A permitido, B recebe resposta uniforme; tentar tenant no input e mutar ID de A como B | DB | D3: Plano 04; D1 recebe falha de autorização |
| P14.08 | S1-07: banco nega leitura/escrita cruzada e falha fechado sem contexto (F1) | IR | E05: policies e tenant GUC | RLS integração e verificador SQL | NE | C2/C7: executar como papel sem bypass, A/B e contexto ausente/inválido | DB | D3/D1: confirmar alvo/papéis descartáveis antes de executar; B09 |
| P14.09 | S1-07: logout/troca de usuário não mistura dados ou estado nos clientes (F1) | IR | E07/E08: sessão por request, desmontagem mobile | Proxy, session-epoch/store; cobertura de funções, sem tela E2E | NE | A carrega contas, sai, B entra e usa Voltar; induzir resposta tardia de A em ambas as plataformas | REAL-W/M | D3/D2: Plano 04, guardar resultado por plataforma |
| P14.10 | S1-06/07: auditoria mínima e alteração são atômicas; falha de audit não confirma sucesso (F1) | IR | E04: AuditRecord, unidade de trabalho | Deactivate spec e manutenção/persistência existentes; confirmar rollback real | NE | C1/C2/C3: provocar falha de auditoria controlada, reler conta e trilha, conferir requestId/metadados mínimos | U-B + DB | D3: Plano 04; D1 fornece suporte se cenário de DB exigir cobertura adicional |
| P14.11 | S1-08: OpenAPI de contas corresponde aos schemas de cada cliente e erros esperados (F1/F6) | PA | E06; geração de cliente ainda não estabelecida | Três contract specs presentes | NE | C4/C5/C6: operações GET/POST/PATCH/deactivate e Problem Details; comparar snapshot com backend, não só consigo mesmo | U-B/W/M + DOC | D3: Plano 02 antes de aceite; B11 |
| P14.12 | S1-08: fluxos críticos completos funcionam nos dois clientes sobre backend real (F1) | PA | E03/E04/E07/E08; H1/READMEs fornecem roteiro | Testes de funções/API presentes; telas/Auth0 reais fora da suíte | NE | Login → criar → listar → editar → cancelar/confirmar desativação → logout → B; registrar web e mobile separadamente | REAL-W/M + DB | D3: Plano 04, habilitar ambiente B09; não usar H1 como aceite |

### 11.3. P15 — Sprint 1: integração, documentação e evidências

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P15.01 | S1-09: fluxo web completo integrado ao backend com dados fictícios (F1) | PA | E07 e H1/README | E07 não substitui sessão e banco reais | NE | Executar sequência P14.12 no navegador e vincular observações aos HEADs | REAL-W + DB | D3/D2: Plano 04; ambiente B09 |
| P15.02 | S1-09: fluxo mobile completo integrado ao mesmo contrato (F1) | PA | E08 e H1/README | E08 sem teste de renderização/Auth0 real | NE | Executar P14.12 no dispositivo; registrar plataforma e versão do app, sem herdar sucesso web | REAL-M + DB | D3/D2: Plano 04; B09 |
| P15.03 | S1-09: pipelines independentes têm configuração e resultado vinculado à revisão (F1) | PA | E01: CI backend; clientes sem `.github` localizado | CI lista checks, sem run consultado | NE | CI: obter run por SHA backend e identificar pipeline real de cada cliente, sem deploy | CI | D3 com D1/D2: B10, registrar ausência de evidência sem inventar pipeline |
| P15.04 | S1-09: lint, testes, tipos e builds relevantes têm resultado atual (F1) | BL | E01: scripts descobertos; somente configuração observada | Inventário E02–E08, não executado | NE | C1–C8 conforme critérios S1; registrar saída por comando, skipped/failed/blocked individualmente | Q + DB + U-B/W/M | D3: execução deliberadamente adiada ao Plano 03/04; B12, sem falha de produto presumida |
| P15.05 | S1-09: configuração, instruções e demonstração não expõem segredo/dado financeiro real (F1) | PA | E01/READMEs; H1 é evidência histórica | Não há inspeção atual de bundle/log de execução | NE | Revisar exemplos e artefatos realmente produzidos na etapa futura; demonstrar só dados sintéticos | DOC + Q + REAL-W/M | D3/D1/D2: Plano 04; não registrar credenciais como evidência |
| P15.06 | S1-01–09: implementação, testes, integração, demonstração, revisão e aceite têm registros separados (F1) | PA | Esta matriz + H1; sem aceite/revisão atuais localizados no recorte | Testes presentes não resolvem revisão/demonstração | NE | Preencher por critério os resultados P14/P15 e registrar revisão cruzada/demonstração identificáveis | DOC + REAL-W/M | D3: B10; fechar ou bloquear cada dimensão no Plano 04 |
| P15.07 | S1-06: exigir remoção física por “excluir” é substituído por desativação lógica (F1) | OB | Especificação normativa de manutenção exclui DELETE/hard delete; E04 usa archive | Deactivate/maintenance specs | LE | Usar P14.06; não criar teste de hard delete como condição de Sprint 1 | DOC | D3: manter regra resolvida, sem nova decisão de produto |

### 11.4. P33 — Sprint 2: baseline e aceite de Transactions

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P33.01 | S2-01: receitas/despesas exigem conta, valor, data e tipo, sem movimento de fundos (F2) | IR | E09: casos de uso e validação | Create-movements e Transactions E2E | NE | C1/C3: entradas válidas/invalidas e conta alheia/arquivada; conferir ausência de efeito de pagamento | U-B + DB | D3: Plano 05; D1 recebe divergência |
| P33.02 | S2-01/03: transferência são duas entradas consistentes e atômicas (F2) | IR | E09/E11: mesma unidade de trabalho | Specs de movimento, persistência e E2E | NE | Criar par, conferir lados/valor/IDs e provocar falha na segunda gravação, sem saldo parcial | U-B + DB | D3/D1: Plano 05 |
| P33.03 | S2-01/07: idempotência define chave por tenant/operação, hash, replay, conflito e janela 24h (F2) | IR | E09/E11 | Create-movements e repository integration | NE | Mesma chave/payload repete resposta; payload diferente e chave expirada conflitam; tenant B isolado | U-B + DB | D3: Plano 05, sem inventar janela alternativa |
| P33.04 | S2-01/05: categoria incerta/não reconhecida é explícita e correção manual persiste (F2) | IR | E10/E12/E13 | Correção spec, schemas e APIs | NE | C1/C3/C5/C6: estados distintos, categoria do tenant e correção manual refletida | U-B/W/M + DB | D3: Plano 05; D2 valida apresentação |
| P33.05 | S2-01/06: conflitos seguem prioridade maior, createdAt/id ascendentes; manual prevalece (F2) | IR | E10 e F2: regras pessoais do baseline | Domain category-rule/create-movements/E2E | NE | Empatar prioridade/data, comparar desempate por ID e confirmar que correção manual não é sobrescrita | U-B + DB | D3: Plano 05, sem criar precisão mínima/dataset arbitrário |
| P33.06 | S2-02/07: tenant, RLS, auditoria e persistência têm cenários próprios (F2) | V | E05/E09–E11 e P34.08–11 | Testes de aplicação e DB identificados | LE | Conferir separação entre regra, autorização e defesa no banco | DOC | D3: mapeamento feito; execução depende de B09/B12 |
| P33.07 | S2-01: pré-requisitos S1 são verificados individualmente, sem aceite presumido (F2) | PA | P14 cobre identidade, contas ativas, contrato e tenant; sem resultado atual | E02–E08 reutilizáveis | NE | Antes de cenário S2, validar autenticação/conta/isolamento usados; não bloquear teste unitário de regra por demo S1 pendente | U-B + DB + REAL-W/M quando aplicável | D3: Planos 04/05; preservar atribuição das pendências S1 |
| P33.08 | S2-01/08: clientes mantêm contrato independente e estados/erros rastreáveis (F2/F6) | PA | E06/E12/E13; tipos manuais | Contract/API/schema tests em ambos | NE | Comparar campos, enum, headers e códigos com F6 atual; verificar decisões de geração B11 | DOC + U-W/M | D3/D1/D2: Plano 02 e depois 05 |

### 11.5. P34 — Sprint 2: testes de movimentações, regras e isolamento

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P34.01 | S2-03/08: validar receitas/despesas e propriedade da conta (F2) | IR | E09, E12/E13 para input | Create-movements, input/schema e Transactions E2E | NE | C1/C3/C5/C6: valor nulo/zero, data inválida, tipo ausente, conta inexistente/arquivada/estrangeira e entrada válida | U-B/W/M + DB | D3: Plano 05 |
| P34.02 | S2-03/08: transferência cria exatamente saída/entrada em contas distintas (F2) | IR | E09: create-accounting-transfer | Create-movements/Transactions E2E; APIs clientes validam duas entradas | NE | C1/C3: conferir transferId, lados, mesmo valor/data; rejeitar contas iguais e alheias | U-B/W/M + DB | D3: Plano 05 |
| P34.03 | S2-03/07: falha na segunda entrada ou audit faz rollback do movimento e chave (F2) | IR | E09/E11 | Persistência Transactions: testes específicos de rollback; use-case spec | NE | C2: induzir falhas previstas nos specs e reler registros/chave; separar memória de PostgreSQL | U-B + DB | D3/D1: Plano 05 |
| P34.04 | S2-03/07: replay, payload divergente, expiração e concorrência não duplicam (F2) | IR | E09/E11 | Create-movements e E2E com concorrência de mesma chave | NE | C1/C2/C3: executar quatro cenários isolados e contar registros/IDs finais | U-B + DB | D3: Plano 05, registrar cada resultado |
| P34.05 | S2-05: distinguir unclassified/uncertain/unrecognized e permitir correção manual (F2) | IR | E10/E12/E13 | Schemas, correção use-case e Transactions E2E | NE | C1/C3/C5/C6: gerar estados, corrigir para categoria permitida e reler após outra requisição | U-B/W/M + DB | D3: Plano 05; nenhuma alegação de precisão estatística |
| P34.06 | S2-06: criar/editar/ativar/desativar/remover regra do tenant (F2) | IR | E10/E12/E13 | Transactions E2E e category-rules API tests | NE | C3/C5/C6: percorrer lifecycle, rejeitar categoria/conta arquivada ou alheia; conferir estado removido | U-B/W/M + DB | D3: Plano 05 |
| P34.07 | S2-06: condições, operadores e conflitos obedecem gramática e desempate aprovados (F2) | IR | E10 | Category-rule domain, rule-logic/schema e create-movements | NE | C1/C5/C6: operador inválido por campo, limites de prioridade, empate de prioridade/data/ID e categoria manual | U-B/W/M | D3: Plano 05; não exigir regra geral que F2 exclui |
| P34.08 | S2-02/07: leitura e mutação alheias são negadas sem revelar recursos (F2) | IR | E09–E11 e filtros tenant-aware | Use-cases, correção e E2E; RLS integração | NE | C3: trocar IDs de conta/transação/categoria/regra entre A/B e comparar erro com recurso inexistente | DB | D3: Plano 05; falha encaminhada a D1 |
| P34.09 | S2-02/07: constraints e RLS bloqueiam zero, referências cruzadas e falta de contexto (F2) | IR | E05/E11 | Transactions RLS e repository integration | NE | C2/C7: SQL pelo papel runtime sem bypass; insert/update alheio, zero, categoria/regra cruzada e tenant ausente | DB | D3/D1: preparar B09 antes do Plano 05 |
| P34.10 | S2-07: audit contém ator/tenant/ação/recurso/instante/resultado/correlação sem payload excessivo (F2) | IR | E04/E09–E11: AuditRecord e gravação na unidade de trabalho | AuditRecord spec e teste de falha do audit/persistência | NE | C1/C2/C3: conferir metadados e requestId de create/correction/rule; separar registro de negócio de log técnico | U-B + DB | D3: Plano 05; inspecionar logs produzidos só quando executar |
| P34.11 | S2-08: REST/OpenAPI e clientes tipados mantêm campos/erros/headers compatíveis (F2/F6) | PA | E06, E12/E13; comparação integral ainda pendente | Contratos e APIs/schema tests | NE | C4/C5/C6: transactions/transfers/categories/category-rules; comparar com backend atual e decisão B11 | DOC + U-B/W/M | D3: Plano 02 antes do aceite no Plano 05 |
| P34.12 | S2-04/08: fluxos web e isolamento de estado respeitam input, reenvio e logout (F2) | IR | E07/E12 | Actions/schema/API/presentation e proxy tests, com mocks | NE | H3 W/R/I: criar receita/despesa, transferir, corrigir, gerir regra, reenviar e trocar A/B | U-W + REAL-W | D3/D2: Plano 05, não promover teste de action a demo |
| P34.13 | S2-04/08: mesmos fluxos funcionam no mobile sem mistura de sessões (F2) | IR | E08/E13 | Lógica/API/session-epoch, sem tela real | NE | H3 M1–M9: dados web aparecem, corrigir no mobile/refletir no web, logout A/B e resposta tardia | U-M + REAL-M | D3/D2: Plano 05, resultado independente |

### 11.6. P35 — Sprint 2: integração, demonstração e evidências

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P35.01 | S2-09: receita/despesa/transferência/correção/regras demonstradas no web (F2) | PA | E12 e H3 roteiro, `Observado` vazio | Testes de funções presentes; demo não observada | NE | Executar H3 W1–W15, R1–R3, I1–I3; guardar resultado por passo e revisão | REAL-W + DB | D3/D2: Plano 05, B09 |
| P35.02 | S2-09: fluxos mobile e alteração cruzada entre plataformas demonstrados (F2) | PA | E13 e H3 | Testes de lógica presentes, sem dispositivo atual | NE | Executar H3 M1–M9 e reler no web a categoria corrigida no mobile | REAL-M + REAL-W + DB | D3/D2: Plano 05, sem herdar sucesso do backend |
| P35.03 | S2-02/09: migrations/RLS e instruções de D1 são insumos reproduzíveis (F2) | PA | E01/E05/E11; H2 histórico | Integrações DB presentes | NE | Revisar evidência de aplicação/ordem de migrations fornecida por D1; C2/C7 depois de preparar DB | DOC + DB | D1 fornece base e evidência; D3 valida no Plano 05, sem aplicar migration no escopo P35 |
| P35.04 | S2-08/09: checks relevantes e contratos têm resultado atual por repositório (F2/F6) | BL | E01/E06 e H3, revisões históricas diferentes | Inventário P34 sem execução | NE | C4–C8 e testes dirigidos P34, depois de reconciliar contrato e preparar ambiente | Q + U-B/W/M + DB | D3: B12; Planos 03/05, sem declarar falha por ausência de execução |
| P35.05 | S2-09: instruções, roteiro e evidências só usam dados fictícios e não expõem segredos (F2) | PA | H3/READMEs contêm preparação e cuidados; sem observação atual | Testes não provam conteúdo do artefato final | NE | Revisar evidências geradas em H3 e logs/bundles pertinentes após execução, sem registrar payload real | DOC + REAL-W/M + Q | D3/D2/D1: Plano 05 |
| P35.06 | S2-01–09: fechamento registra revisão, demo, lacunas e atribuição original (F2) | PA | Matriz P33–P35 e H2/H3; sem aceite formal atual | Presença de T não substitui cross-review | NE | Consolidar cada resultado P34/P35, vincular revisão e manter pendência S1/S2 sob seu ID original | DOC | D3: B10; fechamento apenas após evidência no Plano 05 |

### 11.7. P48 — Sprint 3: baseline e aceite OFX/Pluggy

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P48.01 | S3-01/02: variantes OFX, conteúdo inválido/PDF e limites por plataforma têm expectativa rastreável (F3) | IR | E14–E16: parser/backend 10 MiB, web 4 MiB, mobile 10 MiB | Parser, ingestion E2E, file-validation tests | NE | C1/C3/C5/C6: OFX sintético 1/2 e encodings aprovados, PDF, vazio, malformado e limites exatos | U-B/W/M + DB | D3: Plano 06; não homogeneizar limites distintos |
| P48.02 | S3-02–04: conta é mapeada após leitura e antes da prévia final/duplicatas (F3) | PA | E14 exige destino em `execute`; E15/E16 exigem conta junto ao arquivo; estado OFX de espera ausente | Tests atuais validam fluxo conta+arquivo; schema tests rejeitam `awaiting_account_mapping` | NE | Contrastar fluxo arquivo → conta → prévia com fluxo atual; exigir novo cenário após alinhamento | DOC + U-B/W/M | D1 API/backend e D2 clientes: B02; D3 Plano 02 registra divergência, Plano 06 revalida |
| P48.03 | S3-02: dedupe por FITID/fallback e confirmação repetida não duplicam; resultado tem contagens (F3 D4/D5) | IR | E14 e Transactions import OFX | Preview/confirm specs, OFX integração e ingestion E2E | NE | Reimportar mesma conta, conferir nova conta separadamente, FITID ausente/duplicado e importados/ignorados/erros | U-B + DB | D3: Plano 06; não inventar motivo/enum de duplicidade não contratado |
| P48.04 | S3-03/04/08: prévia vence em 24h, cliente informa prazo e backend rejeita confirmação tardia (F3) | PA | E14 tem enum `expired`, sem prazo de prévia no modelo/API; E15/E16 sem `expiresAt` de prévia | Tests de apresentação aceitam expired; não localizado cenário de envelhecimento da prévia 24h | NE | Relógio controlado: antes/no limite/depois de 24h; separar validade da chave de idempotência e retenção do run | U-B/W/M + DB | D1/D2: B03; D3 não aceita enum isolado como expiração implementada |
| P48.05 | S3-02: remover objeto fonte em terminal e reter resultado 90 dias, sem confundir com prévia (F3 D7/D11) | PA | E14: delete em confirmação terminal/compensação e `retentionExpiresAt`; sem expurgo periódico localizado | Confirm/ImportRun specs; integração R2 real ausente | NE | Sucesso, parcial, falha e expiração: conferir objeto removido; após 90 dias conferir política/expurgo documentado | U-B + DB + EXT/R2 | D1: B03/B09, confirmar implementação de todos os terminais/expurgo; D3 Plano 06 |
| P48.06 | S3-02: assíncrono OFX só é exigido quando exceder orçamento medido (F3 D6) | BL | E14 processa confirmação no request; enum queued não comprova worker OFX | Nenhuma medição de limiar nem teste de worker OFX localizado | NE | Medir tempo/carga de ensaio autorizado e registrar decisão do orçamento; só então verificar fila/estado se aplicável | Q + DB; EXT se necessário | D1 propõe medição/configuração, Produto decide corte material: B13; D3 não inventa limiar |
| P48.07 | S3-05: conexão/consentimento/token limitado/revogação têm critérios e fronteira de backend (F3 D8–D10) | IR | E17: lifecycle, provider, consentimento e desconexão | Lifecycle/client specs com dublês | NE | C1: Item alheio, token não persistido, consentimento revogado/expirado e falha de revogação remota | U-B | D3: Plano 06; integração oficial real fica separada |
| P48.08 | S3-05–07: conclusão Pluggy aceita importação inicial com chave e resposta publicadas (F3/F6) | PA | E18/E19: `202` + chave + estado inicial; E20 mobile envia sem chave e lê Connection antigo | Web tests do contrato atual; mobile test fixa ausência de chave e resposta 200 | LE | Comparação estática confirmou diferenças; após correção executar sessão → conclusão → consulta em cada cliente | DOC; U-B/W/M + EXT na revalidação | D2 corrige mobile: B01; D3 registra no Plano 02, sem regeneração silenciosa |
| P48.09 | S3-05: mapeamento explícito link/create precede transações e trata conta correspondente (F3 D12/D14; F5 C-02) | BL | E18: backend tem mapeamento/espera; E19/E20 sem fluxo completo de associação | Importação spec parcial; não localizado teste específico de UX de link/create | NE | Definir elegibilidade/ausência/ambiguidade e testar espera sem gravar transações até mapear todas | DOC + U-B/W/M + DB | Produto decide, D1 confirma enforcement, D2 entrega fluxo: B05; D3 deriva aceite |
| P48.10 | S3-01/08: Sandbox, fila, storage, decisões e entrada da fase de testes têm limites explícitos (F3) | V | Seções 10/12; H4 e F5 identificam dependências, sem afirmar acesso | Catálogo distingue dublês e testes DB | LE | Conferir pré-requisito por cenário; R2 para OFX atual, QStash para importação inicial, Sandbox para provider real | DOC | D3: não transportar bloqueio de ambiente histórico como diagnóstico atual; B09 |

### 11.8. P49 — Sprint 3: testes OFX/Pluggy, contratos e isolamento

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P49.01 | S3-02/08: OFX válido/malformado/PDF/vazio é validado antes de persistir (F3) | IR | E14: parser e borda autenticada | Parser/preview specs e ingestion E2E | NE | C1/C3: fixtures sintéticas aprovadas, negar bearer e provar ausência de efeito nos inválidos | U-B + DB | D3: Plano 06 |
| P49.02 | S3-03/08: web aceita 4 MiB, rejeita acima e comporta multipart abaixo do teto aprovado (F3) | IR | E15: MAX 4 MiB, body 4 MiB + 64 KiB em Next config | File-validation e actions tests; HTTP real não observado | NE | C5: tamanho exato/+1; REAL-W: arquivo 4 MiB com overhead e corpo acima do limite de action | U-W + REAL-W + EXT/R2 | D3/D2: Plano 06; configuração lida não comprova deploy Vercel |
| P49.03 | S3-02/04: backend/mobile aceitam 10 MiB e rejeitam excedente (F3) | IR | E14/E16 | Backend ingestion E2E e mobile file-validation tests | NE | C3/C6: 10 MiB/+1, tamanho ausente no seletor e validação final do servidor | U-M + DB; REAL-M para seletor | D3/D1/D2: Plano 06 |
| P49.04 | S3-02–04: mapeamento precede prévia final e estados compartilhados incluem espera de conta (F3) | BL | P48.02: fluxo atual incompleto; backend/clients OFX sem estado de espera | Testes locais rejeitam o estado exigido; não suprem o critério | NE | Após B02, verificar envio sem destino, escolha autorizada, duplicatas recalculadas e confirmação separada em cada cliente | U-B/W/M + DB + REAL-W/M | D1/D2 implementam B02; D3 Plano 06 |
| P49.05 | S3-02: dedupe por conta evita duplicata em reimportação e corrida (F3 D4/D5) | IR | E14 e import-ofx-transaction/Transactions repository | OFX integração e transactions.use-cases: duplicata concorrente/fallback | NE | C1/C2: mesmo FITID na mesma conta, conta distinta, FITID ausente e corrida; conferir auditoria sem duplicar | U-B + DB | D3: Plano 06 |
| P49.06 | S3-02: confirmação idempotente produz contagens exatas e preserva resultado parcial (F3) | IR | E14: confirmação por item e finishRun | Confirm spec e ingestion E2E; apresentação E15/E16 | NE | C1/C3/C5/C6: repetir confirmação, erro conhecido em uma linha, somar importados/ignorados/falhos e reler estado | U-B/W/M + DB | D3: Plano 06 |
| P49.07 | S3-03/04: prévia expirada não confirma mesmo com nova chave (F3) | BL | P48.04: prazo real de prévia não localizado; 24h da chave é mecanismo diferente | Não localizado teste temporal específico de prévia | NE | Avançar tempo 24h e enviar chave nova; exigir rejeição por validade da prévia, não por chave velha | U-B + DB + U-W/M | D1/D2: B03; D3 testar somente após critério implementável |
| P49.08 | S3-02: cleanup/retention cobre terminal, compensação e resultados 90 dias (F3 D7/D11) | PA | E14: delete e timestamp implementados parcialmente; expurgo periódico não localizado | Confirm/ImportRun specs sem comprovação de R2 real ou purge completo | NE | Inspecionar put/delete no fake, depois comprovar objeto ausente no bucket de teste; distinguir timestamp de remoção efetiva após retenção | U-B + DB + EXT/R2 | D1 completa/explicita ciclo B03; ambiente B09; D3 Plano 06 |
| P49.09 | S3-02: execução longa tem fila e estado apenas se D6 tornar aplicável (F3) | BL | P48.06; não inferir processamento OFX de fila Pluggy | Não localizado teste worker OFX | NE | Depois de B13, exceder orçamento aprovado, verificar 202/consulta/falha controlada e job mínimo se aplicável | DB + EXT/QStash se aplicável | D1/Produto definem aplicabilidade; D3 mantém condicional |
| P49.10 | S3-05: token limitado, consentimento e tenant impedem coleta indevida (F3 D8/D9) | IR | E17/E18: eligibility antes da coleta | Lifecycle/initial-import specs: Item estrangeiro, escopo não consentido, inelegibilidade | NE | C1: concessão/expiração/revogação, produto sem TRANSACTIONS e tentativa de tenant B | U-B | D3: Plano 06; execução Sandbox é outro critério |
| P49.11 | S3-05: importação inicial aguarda todas as associações e só importa contas/transações consentidas (F3 D8/D12/D14) | PA | E18: espera e mapping backend; sem fluxo cliente completo | Initial-import spec cobre escopo/exclusão de investment, sem cobertura completa de mapping cliente | NE | C1/C2: múltiplas contas, uma pendente, link/create, unsupported; nenhuma transação antes da resolução | U-B/W/M + DB | D1 confirma teste DB/mapping; D2 clientes; B05/B01, Plano 06 |
| P49.12 | S3-05: repetir conclusão com mesma chave/payload recupera run sem duplicar (F6; F5) | PA | E18: `reserveStart`, requeue/replay existentes | Não localizado caso específico de replay da conclusão no initial-import spec; web action cobre reenvio com mock | NE | Mesma chave/item, chave/payload divergentes, reserva em progresso, run falho e nova tentativa; contar runs/jobs/transações | U-B + DB + EXT para fila real | D3 propõe cobertura futura; D1 confirma semântica: B04; não testar como conforme contrato antigo sem chave |
| P49.13 | S3-05: dedupe Pluggy satisfaz D13 inclusive identidade ausente/fallback (F3 D13; F5 C-05) | BL | E18 exige providerTransactionId UUID e usa hash conexão/conta/ID; fallback D13 não localizado nesse importador | Import-pluggy spec cobre ID estável, não garante ausência/estabilidade real do provedor | NE | D1 confirmar ID/capacidade em fonte primária e fixtures sanitizadas; definir caminho sem ID e aviso antes de validar fallback | DOC + U-B + DB; EXT se autorizado | D1/Produto: B04; D3 não afirma conformidade D13 a partir do teste de ID |
| P49.14 | S3-05: revogação/falha externa bloqueia novas coletas e preserva dados já válidos (F3 D9/D10) | IR | E17/E18 | Lifecycle: delete remoto falha; initial-import: falha após página importada | NE | C1: revogar no meio do fluxo, falhar página seguinte e reler dados; repetir em Sandbox autorizado separadamente | U-B + DB + EXT/Pluggy | D3/D1: Plano 06; retenção local não se confunde com novas coletas |
| P49.15 | S3-02–08: backend/OpenAPI, schemas e snapshots independentes suportam o mesmo fluxo (F3/F6) | PA | E06/E14–E20: mobile divergente, OFX mapping/validade incompletos | Contract tests locais presentes; podem passar contra snapshot antigo | NE | C4/C5/C6 após reconciliação; conferir conclusão 202/chave/initialImport e estados OFX por plataforma | DOC + U-B/W/M | D3/D1/D2: Plano 02, B01–B03/B11 |
| P49.16 | S3-02/05/08: isolamento de runs, itens, conexões e mutações vale na aplicação e no PostgreSQL (F3) | PA | E05/E14/E17/E18: filtros/policies; migrations Pluggy com FORCE RLS | OFX integração + lifecycle simulado; verificador SQL contempla tabelas Pluggy, sem prova DB recente | NE | C2/C7: A/B tentam GET/confirm/map/disconnect; SQL sem tenant/estrangeiro em tabelas de initial import | DB + U-B/W/M | D3/D1: Plano 06, confirmar cobertura DB Pluggy antes de marcar completo; B09 |

### 11.9. P50 — Sprint 3: integração, Sandbox e evidências

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P50.01 | S3-08: OFX completo no web: seleção, mapping, prévia, duplicatas, confirmação, resultado e expiração (F3) | BL | E15/H4: fluxo básico e roteiro, lacunas P49.04/07 | API/action/presentation com mocks | NE | H4 O/D ampliado para B02/B03; registrar cada passo, tenant e contagens no web | REAL-W + DB + EXT/R2 | D1/D2 resolvem B02/B03; D3 executa Plano 06 |
| P50.02 | S3-08: mesmo fluxo OFX no mobile com seletor e limites próprios (F3) | BL | E16/H4; mesmas lacunas de mapping/expiração | Lógica/API tests, sem dispositivo | NE | H4 M OFX mais seleção/cancelamento, 10 MiB e prévia vencida; reler lançamento no web | REAL-M + DB + EXT/R2 | D1/D2: B02/B03; D3 resultado mobile independente |
| P50.03 | S3-08: Pluggy web conclui, mapeia, acompanha importação e desconecta com estado consistente (F3/F6) | PA | E19/H4: sessão e conclusão atuais; UX de mapping inicial não comprovada | Connection/action tests, sem fluxo de associação real | NE | H4 P ampliado: 202, run, link/create, contagens, consentimento e desconexão | REAL-W + DB + EXT/Pluggy/QStash | D2 fluxo, D1 enforcement, Produto C-02: B05; D3 Plano 06 |
| P50.04 | S3-08: Pluggy mobile segue contrato atual e funciona no dispositivo (F3/F6) | BL | E20: contrato anterior impede fechamento | Tests esperam 200 sem chave | NE | Após B01, widget → concluir 202 com chave → consultar/mapping/run → desconectar | REAL-M + DB + EXT/Pluggy/QStash | D2 corrige e entrega; D3 valida Plano 06 |
| P50.05 | S3-08: Sandbox, R2 e QStash têm evidência real separada de dublês (F3) | BL | Adapters E14/E17/E18 existem; acesso não avaliado | Tests com doubles não fecham integração externa | NE | Demonstrar OFX put/delete em bucket privado e sessão/initial import via fila Sandbox; guardar IDs internos/resultados sanitizados | EXT + DB + REAL-W/M | Ambiente/usuário e D1 disponibilizam/autorizam B09; D3 executa somente o cenário autorizado |
| P50.06 | S3-08: documentação/snapshots relatam estado atual sem ocultar drift (F3/F6) | PA | F6 ainda contém afirmações antigas de ausência de Pluggy/importação/chave; E18/E19 as contradizem | E06: snapshot mobile antigo; hash web/backend diferente não prova incompatibilidade integral | LE | Plano 02 deve comparar operações/campos e corrigir só documentação vigente ou registrar defeito; preservar seções históricas | DOC | D3/D1/D2: B01/B14; nenhum snapshot regenerado aqui |
| P50.07 | S3-01–08: checklist, demonstração, revisão e aceite têm evidência atual sem segredos (F3) | PA | H4 roteiro `Observado` vazio; esta matriz separa critérios e bloqueios | Não há execução/revisão/demonstração atual | NE | Consolidar P49 e P50 por plataforma, executar checks relevantes C8 e revisão das evidências produzidas | DOC + Q + REAL-W/M | D3: Planos 03/06; B10/B12, sem fechar S3 com backend/mocks apenas |
| P50.08 | S4-01: handoff preserva pendências herdadas de conexão/replay/mapping/initial import/ambiente (F3/F5) | V | P48–P50 e seção 12 mantêm origem S3 e responsáveis | Presença e lacunas T registradas | LE | Conferir referências B01–B05/B09/B13/B14 antes do Plano 07; não promover backend-only a baseline fechado | DOC | D3: handoff documental desta etapa disponível; não equivale a executar P50 |

### 11.10. P58 — Sprint 4: baseline, decisões e aceite

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P58.01 | S4-01: base HU-007 é avaliada nos três produtos, sem herdar fechamento backend-only (F4/F5) | PA | P48–P50, E17–E20 e H5 | Backend/web/mobile com cobertura desigual e sem execução atual | NE | Revalidar conclusão, acesso por ID, mapping, importação e revogação em cada produto | U-B/W/M + DB + REAL-W/M + EXT | D3: Plano 07 após tratar pendências S3; B01/B04/B05/B09 |
| P58.02 | S4-01 C-01: recuperação por IDs não exige listagem de conexões; ponteiros são vinculados à sessão e limpos (F5 adendo) | PA | Decisão sem listagem documentada; E19/E20 usam ID; retomada persistente completa não localizada | E21 testa origem de statusUrl; session tests não cobrem ponteiros de sync | NE | A guarda connectionId/runId, reinicia, retoma; logout/B e 404 limpam ponteiros; statusUrl externa rejeitada | U-W/M + REAL-W/M | D2: implementar retomada no escopo aprovado; D1/D3 resolver recuperação da última execução sem runId, B06 |
| P58.03 | S4-01 C-03: contrato público de solicitação/consulta e estados está registrado (F5 adendo) | V | F5 define POST/GET sync-runs, 202, seis estados, três finais, uma execução ativa | E21 tem tests locais; não há rota publicada em F6 | LE | Comparar direção de contrato com E21; distinguir documento aprovado de OpenAPI/runtime ausentes | DOC | D3: baseline documental identificado; D1 publica implementação/contrato em B06 |
| P58.04 | S4-01 C-03: horário/fuso/janela, retries/backoff, retenção, polling e action_required são decididos (F5) | BL | Pendências expressas no adendo e P-02/P-03/P-04 do mapa D2 | Não há teste de timing/retry HU-008 localizado | NE | Registrar cada parâmetro e fonte, inclusive atualização manual do Item; só depois derivar teste temporal | DOC | D1 propõe, Produto decide negócio, D2 valida consumo, D3 aceita critério: B06 |
| P58.05 | S4-01 C-02: regra de conta correspondente distingue elegibilidade, ausência e ambiguidade (F5) | BL | E18 link/create existe; decisão de Produto incompleta | Sem prova de cobertura integral dessa regra em backend/clientes | NE | Formalizar seleção permitida e caminhos sem candidata/com várias; manter escolha explícita | DOC | Produto decide; D1 enforcement, D2 UX e D3 matriz: B05 |
| P58.06 | S4-01 C-04/C-05/C-06: capacidade Pluggy e identidade/dedupe são verificadas antes de aceitar domínios (F5) | BL | H5 mapa de apresentação não confirma provider; E18 só contas/transações iniciais | Specs de ID e escopo não comprovam capacidade real ou D13 fallback | NE | D1 fornece mapa PRD → capacidade confirmada por conector → API/fixture; Produto decide desvio/corte | DOC + EXT se autorizado | D1/Produto: B04/B07; D3 deriva critérios sem cortar PRD por D8 |
| P58.07 | S4-03/04: investimento/alocação definem ausente, indisponível, defasado, denominador, moeda e arredondamento (F4/F5) | BL | Mapa D2 P-05–P-09 explicita decisões abertas; E22 sem produto | Não localizados testes HU-009/HU-011 | NE | Fixar semânticas com fonte e exemplos sintéticos; não substituir valor ausente por zero ou converter moeda sem regra | DOC | Produto decide; D1 dados/capacidade, D2 apresentação, D3 expectativas: B07 |
| P58.08 | S4-05: campos aplicáveis de bem/passivo/financiamento e associação opcional estão normatizados (F4) | BL | F4 exige campos-base, mas taxonomia/subtipos não completos; E22 sem módulo | Não localizados testes HU-012 | NE | Definir campos por tipo apenas onde faltam, validação/associação/history; preservar o mínimo já exigido pelo PRD | DOC | Produto e D1 modelo; D2 consumo e D3 critérios: B08 |
| P58.09 | S4-01: Sandbox/QStash/R2 são dependências por cenário, sem bloqueio universal por storage (F4/F5) | V | Seção 10: OFX atual requer R2; HU-008 não demonstrou necessidade de R2 | Nenhuma execução externa | LE | Conferir dependência real do caminho; deixar autorização/configuração como pré-requisito não avaliado | DOC | D3/Ambiente/D1: B09, sem inferir indisponibilidade |
| P58.10 | S4-01/S4-06: critérios, decisões abertas e entrada P59 estão explícitos sem antecipar Sprint 5 (F4) | PA | Matriz P58–P60 e bloqueios abaixo; baseline transversal ainda não fechado | Tests E21 são só preparação web | NE | No Plano 07, consolidar C-01–C-06 com evidência dos clientes e separar critério implementável do bloqueado | DOC | D3: concluir baseline no Plano 07; não iniciar P59/P60 nem Sprint 5 nesta etapa |

### 11.11. P59 — Sprint 4: testes de sincronização, investimentos e patrimônio

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P59.01 | S4-02: solicitar sync manual atualiza Item e aceita run rastreável (F4/F5 C-03) | PA | E21 chamadas web preparadas; E22 sem backend, tela ou mobile; adapter atual sem atualização manual HU-008 | E21 fetch simulado; nenhum spec backend HU-008 localizado | NE | Depois de B06: POST manual → 202/run/statusUrl → atualização/coleta → GET terminal | U-B/W/M + DB + EXT | D1 backend/adapter, D2 clientes, D3 verificação; preparação web não fecha história |
| P59.02 | S4-02: execução diária interna usa janela/fuso aprovados, sem forçar update diário do Item (F4/F5) | NI | E22: scheduler/job HU-008 não localizado; fila de importação inicial é outro fluxo | Nenhum teste de agendamento HU-008 localizado | NE | Após decidir horário/fuso, avançar relógio da janela e comprovar coleta diária única por conexão | U-B + DB + EXT/QStash | D1 implementa, Produto parâmetros; D3 testa após B06 |
| P59.03 | S4-02: repetição por conexão/janela não duplica contas, transações, posições ou movimentos (F4/F5) | NI | E22: idempotência de sync ausente; E18 initial import não substitui HU-008 | Nenhum spec HU-008; specs iniciais têm escopo menor | NE | Reentregar job e solicitação na mesma janela, comparar IDs/contagens por domínio autorizado | U-B + DB | D1 implementa B06/B07; D3 mantém dependências por domínio |
| P59.04 | S4-02: no máximo uma execução ativa por conexão, nova solicitação devolve a ativa (F5 C-03) | NI | E22: lock/serialização/run HU-008 não localizado | E21 não testa concorrência de servidor | NE | Disparar duas solicitações simultâneas e job concorrente, conferir uma ativa e resposta da existente | U-B + DB | D1 implementa B06; D3 valida concorrência real em DB |
| P59.05 | S4-02: falhas/retries seguem classificação e backoff aprovados (F4/F5) | BL | E22 sem worker HU-008; parâmetros ainda pendentes | Nenhum spec de retry HU-008 localizado | NE | Após B06: erro transitório, definitivo, consentimento perdido e limite de tentativas, com relógio controlado | U-B + DB + EXT/QStash | D1 propõe/implementa, Produto decide parâmetros; D3 deriva expectativa |
| P59.06 | S4-02: queued/running/action_required/succeeded/partial/failed e tempos são consultáveis (F5 C-03) | PA | E21 schema/tipos web; E22 sem persistência/consulta/tela | E21 valida enums/finais no fake, não transição real | NE | Após B06: consultar cada transição/startedAt/completedAt; retomada pós-ação cria nova execução preservando anterior | U-B/W/M + DB + REAL-W/M | D1 contrato/runtime, D2 estados; D3 valida após resolver action_required |
| P59.07 | S4-02: jobs levam só IDs/metadados mínimos, sem tokens/payload financeiro (F4) | NI | E22: job HU-008 não localizado | Nenhum spec de payload HU-008 localizado | NE | Capturar publicação sintética e comparar lista permitida; verificar logs sanitizados, sem copiar segredo | U-B + EXT/QStash | D1 implementa B06; D3 revisa payload e efeito real separadamente |
| P59.08 | S4-02: tenant/proprietário controlam disparo, consulta, persistência e execução (F4/F5) | NI | E22: sem rotas/tabelas/policies de sync; RLS inicial não as comprova | Nenhum spec HU-008 app/DB localizado | NE | A permitido, B vê inexistente; job com referência estrangeira e SQL sem contexto falham fechado | U-B + DB | D1 implementa B06; D3 adiciona/verifica casos após contrato |
| P59.09 | S4-02: clientes retomam run só no primeiro plano e param nos três estados finais (F5 C-01/C-03) | PA | E21 identifica finais/origem; sem polling/tela; mobile sem camada | E21 testa helper, não ciclo de vida do app | NE | Background/foreground, final/ação pendente, logout/A→B e URL externa; intervalo só após decisão | U-W/M + REAL-W/M | D2 implementa após B06; D3 não inventa intervalo de consulta |
| P59.10 | S4-03: posições e total da carteira aparecem quando disponíveis (F4) | NI | E22: sem modelo/API/tela HU-009; tipo de conta investment não supre | Nenhum teste HU-009 localizado | NE | Após B07: fixture com posições e total esperado conforme regra de moeda/denominador aprovada | U-B/W/M + DB + REAL-W/M | D1 API/dados, D2 telas; D3 valida |
| P59.11 | S4-03: quantidade/saldo, investido, resultado, instituição e referência respeitam disponibilidade (F4) | NI | E22; F5 mapa de apresentação somente | Nenhum teste HU-009 localizado | NE | Para cada campo fornecido/ausente, conferir valor preservado e rótulo de ausência, sem fallback inventado | U-B/W/M + DB | D1/D2 implementam B07; D3 cenários campo a campo |
| P59.12 | S4-03: movimentos e taxa/índice/vencimento de renda fixa aparecem quando fornecidos (F4) | NI | E22: módulo/provider de investimento não localizado | Nenhum teste de movimentos/renda fixa localizado | NE | Fixtures com/sem movimentos e com cada campo de renda fixa, sem exigir capacidade não confirmada | U-B/W/M + DB; EXT quando aplicável | D1 confirma capacidade B07, D2 apresenta, D3 valida |
| P59.13 | S4-03: dados ausentes/indisponíveis/desatualizados são explícitos e não parecem atuais (F4/F5 P-07) | BL | E22 sem produto; limiar de defasagem não decidido | Nenhum teste HU-009 temporal localizado | NE | Decidir frescor, variar referência/qualidade com relógio controlado e confirmar rótulos por plataforma | DOC + U-B/W/M | Produto decide B07; D1/D2 implementam; D3 valida |
| P59.14 | S4-03: fonte/ID externo/tipo/referência/moeda/qualidade são preservados quando aplicáveis (F4) | NI | E22: sem estrutura HU-009; mapa F5 não é API | Nenhum teste HU-009 de proveniência localizado | NE | Fixture rastreável de origem, persistir/reler e comparar todos os metadados sem expor payload bruto | U-B/W/M + DB | D1/D2 implementam B07; D3 verifica rastreabilidade |
| P59.15 | S4-04: percentuais usam dados disponíveis com denominador/moeda/arredondamento aprovados (F4/F5 P-05/06/08) | BL | E22 sem cálculo de alocação; decisões abertas | Nenhum teste HU-011 localizado | NE | Após B07: exemplos com posição sem valor, zero, moedas distintas e arredondamento; só usar totais esperados aprovados | DOC + U-B/W/M | Produto decide; D1/D2 implementam; D3 calcula expectativa sem inventar regra |
| P59.16 | S4-04: agrupamento por classe e instituição conserva itens não classificados (F4) | NI | E22 sem agregação/tela HU-011 | Nenhum teste HU-011 localizado | NE | Misturar instituições/classes, posição sem classe e dados parciais; conferir partições e grupo não classificado | U-B/W/M + DB | D1/D2 implementam B07; D3 valida depois |
| P59.17 | S4-04: origem e referência continuam acessíveis ao consultar alocação (F4) | NI | E22 sem UI/contrato HU-011 | Nenhum teste de proveniência HU-011 localizado | NE | Agrupar por classe/instituição e acessar a fonte/data por linha sem perder vínculo com posições | REAL-W/M + DB | D1/D2 implementam B07; D3 observa por plataforma |
| P59.18 | S4-05: bem valida tipo, descrição, valor estimado, data de avaliação e fonte (F4) | NI | E22 sem modelo/endpoint/tela patrimonial | Nenhum teste HU-012 localizado | NE | Campos-base válidos, ausentes e inválidos; persistir/reler sob tenant autenticado | U-B/W/M + DB | D1 modelo/API, D2 clientes; D3 testa após B08 |
| P59.19 | S4-05: financiamento/passivo valida saldo devedor/dados aplicáveis e associação opcional a bem (F4) | BL | E22 sem produto; subtipos/campos além do mínimo precisam de decisão | Nenhum teste HU-012 localizado | NE | Após B08: criar sem bem/com bem próprio, associação estrangeira e campos por subtipo aprovados | DOC + U-B/W/M + DB | Produto/D1 definem o pendente, D2 consumo, D3 valida |
| P59.20 | S4-05: ownership, histórico, auditoria e persistência protegem alterações relevantes (F4) | NI | E22 sem aggregate/tabelas/policies HU-012 | Nenhum teste HU-012 de histórico/RLS localizado | NE | Alterar registro, reler histórico/audit mínimo; falhar audit e negar leitura/mutação A/B e SQL sem tenant | U-B + DB | D1 implementa B08; D3 verifica atomicidade e RLS separadamente |
| P59.21 | S4-02–05: OpenAPI e schemas/clientes independentes refletem o produto implementado (F4) | BL | E06 sem rotas S4; E21 baseado em direção documental, fora do snapshot | Nenhum contract spec backend S4; fake web não resolve | NE | Após contratos publicados, C4/C5/C6 confrontam campos/erros/estados e rotas de cada história | DOC + U-B/W/M | D1 publica; D2 alinha; D3: B06–B08/B11 |
| P59.22 | S4-02–05: fluxos críticos web/mobile são verificados separados de mocks/integração real (F4) | BL | E22 sem histórias completas; E21 é preparação | Nenhuma cobertura E2E dessas histórias localizada | NE | Sync manual/diária, consultar posições, agrupar carteira e criar/alterar patrimônio em cada cliente após entregas | REAL-W/M + DB + EXT para Pluggy/jobs | D1/D2 entregam B06–B08; D3 verifica, sem assumir escopo de implementação |

### 11.12. P60 — Sprint 4: integração e consolidação de evidências

| ID | Critério observável / fonte | Estado | Implementação ou artefato | Teste presente | Exec. | Comando ou cenário de verificação | Ambiente | Responsável / próxima ação |
|---|---|---|---|---|---|---|---|---|
| P60.01 | S4-06: integrar solicitação/consulta/sync diária e manual em web/backend/mobile (F4/F5) | BL | E21/E22; histórias indisponíveis para fluxo completo | Fake web somente; nenhum backend/mobile HU-008 | NE | Percorrer P59.01–09 com uma conexão e duas identidades, registrar resultados por plataforma | REAL-W/M + DB + EXT | D1/D2 entregam B06; D3 integra após ambiente B09 |
| P60.02 | S4-06: consulta e alocação integradas preservam parcialidade e proveniência (F4) | BL | E22 sem HU-009/HU-011; F5 só proposta de telas | Nenhum teste integrado localizado | NE | Percorrer P59.10–17 com dados completos/parciais/sem classe, comparar referências e percentuais aprovados | REAL-W/M + DB + EXT se aplicável | D1/D2/Produto resolvem B07; D3 valida |
| P60.03 | S4-06: patrimônio manual integrado preserva associação, história, audit e tenant (F4) | BL | E22 sem HU-012 | Nenhum teste integrado localizado | NE | P59.18–20 em web e mobile, reler mudanças e tentar outro tenant | REAL-W/M + DB | D1/D2/Produto resolvem B08; D3 valida |
| P60.04 | S4-01/06: achados herdados de S2/S3 mantêm origem e impacto atual comprovável (F4) | PA | P33–P50, B01–B05; H2/H3/H4 históricos não aceitos automaticamente | Specs atuais inventariados, resultados NE | LE | Leitura confirmou drift mobile/OFX; Plano 02 revalida documentação e Planos 05/06 executam cenários antes de carregar falhas históricas | DOC | D3: manter ID original e dependência afetada; não transformar todos os relatos de outubro em defeitos atuais |
| P60.05 | S4-06: OpenAPI, clientes, instruções e evidências acompanham contratos disponíveis (F4) | BL | E06/E22 sem APIs S4; F5 decisões e E21 não equivalem a OpenAPI publicada | E21 fake; nenhum contract spec S4 backend localizado | NE | Após B06–B08, comparar artefatos por operação e atualizar instruções somente do produto entregue | DOC + U-B/W/M | D1/D2 publicam; D3 reconcilia e registra sem regenerar snapshot para ocultar erro |
| P60.06 | S4-06: demo sintética, integração Sandbox real e revisão cruzada têm registros próprios (F4) | BL | Produto necessário ausente; sem demonstração S4 atual localizada | Mocks/fixtures não constituem demo ou integração real | NE | Preparar roteiro por história entregue e registrar observado, revisão e resultado sanitizado; EXT separado de doubles | REAL-W/M + DB + EXT + CI | D3 após D1/D2 e B06–B10; não criar evidência fictícia |
| P60.07 | S4-01–05/06: checklist de encerramento fecha cada critério ou registra bloqueio/responsável (F4) | PA | Matriz P58/P59/P60 explicita bloqueios; baseline e histórias continuam abertos | Não há resultado funcional atual | LE | Consolidar critérios no Plano 07/08 após respectivas evidências; manter NI/BL sem aceite presumido | DOC | D3: esta etapa entrega mapa de trabalho, não fechamento de P60 ou Sprint 4 |
| P60.08 | S4: não usar net worth/projeção/dashboard S5 como substituto das quatro histórias (F4) | V | Escopo desta matriz limitado a HU-008/009/011/012 e integração suportada | Testes S5 excluídos desta análise | LE | Avaliar gate do Plano 09 só após consolidação histórica; dashboard existente não prova histórias S4 | DOC | D3/Produto: preservar fronteira; nenhum trabalho S5 iniciado |

## 12. Bloqueios, divergências e responsáveis

`D1` = Developer 1 (backend), `D2` = Developer 2 (clientes), `D3` = Developer 3 (verificação/evidências). **Produto** é o usuário/responsável pela decisão de negócio, não uma decisão assumida pelo agente. A criticidade abaixo é de planejamento/aceite; esta etapa não atribui severidade de segurança ou falha de runtime sem execução.

| ID | Origem / evidência e impacto | Responsável | Condição objetiva de desbloqueio / próxima ação |
|---|---|---|---|
| B01 | **S3-07/S3-08, herdado em S4-01.** E20 `completePluggyConnection` envia só `{ itemId }` sem chave; teste usa `stubFetch(200, connectionView())` e exige ausência do header. E18 controller exige chave e `@HttpCode(202)`; F6 confirma. Incompatibilidade estática confirmada, sem request real | D2; D1 confirma contrato; D3 registra | Alinhar mobile ao contrato publicado de conclusão/consulta/importação inicial, entregar testes significativos e revalidar no Plano 06. Plano 02 registra a divergência, sem corrigir produto. Não alterar o teste apenas para aceitar resposta incompatível |
| B02 | **S3-02/03/04/08.** F3 exige arquivo → mapeamento → prévia final; E14 recebe destino obrigatório e inicia em preview_ready; E15/E16 rejeitam awaiting_account_mapping no schema. Há fluxo básico, falta o requisito completo | D1 API/estado, D2 clientes; Produto decide somente eventual alteração do requisito | Publicar/implementar operação e estados conforme requisito ou registrar alteração formal aprovada. D3 deriva casos de mapping/duplicatas antes da confirmação. Mapping Pluggy existente não resolve mapping OFX |
| B03 | **S3-02/03/04/08.** E14 não publica validade da prévia 24h nem verifica sua idade em startConfirmation; prazo de chave 24h e metadata 90 dias não são validade da prévia. Delete em confirmação/compensação existe, sem comprovação de cleanup em todo terminal ou expurgo periódico | D1 ciclo de vida/cleanup/persistência, D2 prazo/estado de UI; D3 critérios temporais | Implementação ou evidência localizada de validade/rejeição/cleanup/retenção, com testes temporais dirigidos e integração de storage quando autorizada. Não substituir expiresAt de prévia por retenção ou expiração da chave |
| B04 | **S3-05/S3-08 e C-05 S4-01.** E18 implementa replay/reserva, sem caso dedicado localizado de replay da conclusão; importador exige UUID de providerTransactionId. D13 fallback/estabilidade não comprovados; H5 mantém a pendência | D1 verifica capacidade/identidade e contrato; D3 cobertura; Produto decide desvio se necessário | Evidência primária de ID/estabilidade/ausência e tratamento de fallback/aviso; cenário de mesma chave/item, conflitos e retry com resultado persistido. Não supor garantia do provedor nem conformidade D13 com ID sintético |
| B05 | **D12/C-02, S3/S4-01.** Backend link/create e espera existem; regra de elegibilidade/correspondência/ambiguidade segue aberta em F5, clientes sem associação completa comprovada | Produto decide regra; D1 enforcement, D2 UX, D3 aceite | Registrar regra de seleção, ausência/ambiguidade e caminhos por plataforma; comprovar nenhuma transação sem conta resolvida. Não atribuir a D3 poder de escolher regra de negócio |
| B06 | **S4-01/02.** F5 adendo fecha direção de API e máximo uma ativa; E22 não tem sync backend/tabelas/policies/jobs/telas, mobile sem camada. E21 é preparação web. Fuso/janela, backoff, retenção, polling, action_required e recuperação sem runId pendentes | D1 propõe/implementa/publica, Produto parâmetros de negócio, D2 consumo/retomada, D3 critérios | Fechar parâmetros pendentes sem reabrir o já decidido, publicar OpenAPI e implementar HU-008 backend/clientes. Entregar evidência de manual/diária, serialização/idempotência, estados/erros, metadados mínimos e isolamento antes de P59/P60 |
| B07 | **S4-03/04, C-04/C-06.** E22 sem posições/consulta/alocação. Mapa D2 P-05–P-09 mantém denominador, moedas, arredondamento, defasagem e fronteira/capacidade em aberto | D1 mapa de capacidade/contrato/dados; Produto regras e cortes; D2 clientes; D3 expectativas | Mapa PRD → capacidade por conector → API/fixtures e decisões das semânticas abertas; implementar histórias com dados/ausência explícitos. Não equiparar conta investment a posição nem gráficos de dashboard a alocação |
| B08 | **S4-05 HU-012.** E22 sem modelo/API/tela; mínimo PRD está descrito, campos adicionais por subtipo carecem de decisão | D1 modelo/API/RLS/history, Produto semânticas pendentes, D2 clientes, D3 critérios | Definir apenas lacunas de campo/tipo, implementar cadastro de bens/passivos/financiamentos e associação opcional; fornecer cenários de persistência/audit/tenant antes de integração |
| B09 | **Pré-requisito de execução, não indisponibilidade diagnosticada.** PostgreSQL descartável/papéis, Auth0 de teste, dispositivo, Sandbox/QStash e R2 conforme cenário não foram acessados nem verificados | Usuário/responsável de ambiente com D1/D2; D3 registra prontidão | Confirmar configuração segura/alvo autorizado por cenário e registrar ambiente/versões sem segredos. Só então executar na etapa correspondente. Ausência de resultado aqui não é falha do serviço |
| B10 | **S1/S2/S3/S4 encerramento.** Handoffs/roteiros não fornecem revisão, demonstração e aceite atuais; CI backend configurada sem resultado por SHA; `.github` não localizado nos clientes | D3 consolida; D1/D2 fornecem revisão/evidência/pipeline quando existente | Identificar runs e revisão aplicável, preencher resultado observado de cada roteiro por plataforma e ligar ao critério/HEAD. Não inferir passe remoto por YAML ou impor pipeline novo nesta etapa |
| B11 | **S1-03/08, S2-08 e alinhamento transversal.** F6 documenta tipos manuais e gerador não aprovado; snapshots/testes locais não garantem derivação/paridade com backend atual | D1/D2 contrato e geração, Produto se decisão necessária; D3 compatibilidade | Plano 02 distingue o mecanismo vigente de tipos do requisito de cliente derivado/gerado, registra decisão aplicável e compara operações. Não instalar gerador, compartilhar schemas ou promover tipos manuais a gerados por descrição |
| B12 | **Planos 03–06: execução atual pendente por escopo explícito.** Todos os testes/checks de produto ficaram NE, inclusive quando implementação e T existem | D3 | Obter etapa autorizada para preparar ambiente e executar comandos dirigidos; registrar passe/falha/skipped/blocked por critério. Não é bloqueio ambiental comprovado e não impede concluir a matriz do Plano 01 |
| B13 | **S3-02 D6.** Confirmação OFX síncrona e enum queued presentes; falta evidência medida para decidir caminho assíncrono e limiar. QStash de importação inicial não comprova OFX longo | D1 medições/proposta; Produto se corte/semântica mudar; D3 verificação | Definir orçamento com medição e fonte; decidir aplicabilidade. Se necessário, implementar e validar caminho assíncrono; se inaplicável, justificar com evidência, sem inventar requisito numérico |
| B14 | **Documentação vigente S3/S4.** F6/H4 ainda relatam ausência de conexão/importação/chave em revisões antigas. E18/E19 confirmam presença atual; mobile ainda diverge. Hashes backend/web distintos exigem comparação semântica, não cópia cega | D3 reconcilia documentação no Plano 02, D1/D2 validam suas interfaces | Separar trechos históricos, corrigir afirmações vigentes com referência a HEAD/operação e registrar diferenças que são de produto. Não editar histórico de outubro, regenerar snapshots ou assumir que as três versões estão iguais |

### 12.1. Premissas históricas superadas ou com alcance reduzido

| Premissa | Classificação | Substituição observada |
|---|---|---|
| “Clientes OFX/Pluggy não existem”, da auditoria de outubro | OB | E15/E16/E19/E20 estão presentes nos HEADs atuais. Isso não aceita os fluxos completos |
| “Importação inicial e chave na conclusão não existem no backend/web” | OB para backend/web; mobile continua divergente | E18/E19 e F6 publicam/consomem 202 com chave; B01 identifica o recorte mobile ainda antigo |
| “A conclusão do mesmo Item sem chave é o contrato atual” | OB | Backend exige Idempotency-Key. A expectativa antiga em E20 é evidência de drift, não autorização para manter o comportamento |
| “C-01 exige decidir/implementar listagem” | OB como exigência de aceite atual | Adendo F5 fecha retomada sem listagem. Não criar GET coleção para fechar esta recuperação |
| “C-03 inteiro está indefinido” | OB no trecho já consolidado | Rotas/202/status/máximo uma ativa definidos em F5; parâmetros listados em B06 continuam abertos; implementação continua ausente |
| “R2 é necessário para qualquer validação da Sprint 4” | OB como dependência universal | OFX atual depende de R2; não há caminho HU-008 demonstrado que o exija. QStash/Pluggy/DB também dependem do cenário |
| “S1-06 exige DELETE físico” | OB | F1 resolve para archive lógico; P15.07 mantém rastreabilidade |

### 12.2. Comparação estática localizada dos contratos

A leitura JSON da operação `POST /api/v1/connections/pluggy/completions` encontrou **202 + Idempotency-Key obrigatório** no backend e snapshot web, e **200 sem esse header obrigatório** no snapshot mobile. Nenhum dos três publica rota `sync-runs`. Isso é comparação de artefatos, não execução de testes ou reconciliação integral do Plano 02.

| Artefato no HEAD da seção 8.1 | SHA-256 observado |
|---|---|
| Backend `openapi/openapi.json` | `32ADD5351A0400872A6D18949DFC4A08A13051726B04797763C461B623BF222E` |
| Web `src/lib/api/openapi.snapshot.json` | `F301F9B4A0B8A6AA9684CBED0478EEFBC656B6AC4A7D628C216D3CA4F252B287` |
| Mobile `src/lib/api/openapi.snapshot.json` | `2882E8B595D5AF63320F08DC4E057C7BFC85B5E0A029FA610FD8584F3F467E39` |

Hashes distintos não dizem, sozinhos, quais operações são incompatíveis. O Plano 02 deve comparar o conteúdo relevante e preservar a distinção entre divergência documental, divergência de produto e decisão aberta.

## 13. Registro e handoff do Plano 01

### 13.1. Operações realizadas e validação documental

Foram usados somente inventário Git, `rg --files`/`rg -n`, leitura dirigida com `Get-Content`, extração de texto de HTML para leitura, `ConvertFrom-Json` para a comparação localizada de contratos, `Get-FileHash` e edição desta auditoria. Algumas buscas iniciais com glob diretamente no argumento de caminho do `rg` retornaram erro de sintaxe do Windows; foram refeitas com diretórios/arquivos explícitos ou enumeração PowerShell. `.github` ausente nos clientes foi registrado como ausência local, sem concluir sobre serviço remoto.

A conferência é documental: IDs únicos e cobertura dos 12 prompts; nove colunas por linha; fonte, implementação/teste, execução, cenário/ambiente, responsável e próxima ação preenchidos; referências locais existentes; whitespace; preservação dos quatro HEADs e dos arquivos fora do conjunto aprovado. Essa conferência não executa scripts ou testes do produto.

**Resultado observado em 24/11/2026:** `VALIDACAO DOCUMENTAL APROVADA`, saída 0: **128 critérios, 12 prompts, 118 referências locais existentes**, IDs únicos/sequenciais, nove colunas completas, seis classificações válidas, registro textual do Plano 00 preservado após o título/nota de evolução, somente a auditoria no diff e stage vazio. `git diff --check` também retornou 0; houve apenas aviso de possível conversão futura LF → CRLF, sem apontamento de whitespace. A primeira comparação automática do histórico usou um índice incorreto por causa da nota nova na abertura; o índice foi corrigido e a comparação repetida com sucesso, sem modificar o registro do Plano 00.

### Execution handoff — Plano 01

- **Plano executado:** Plano 01 — Construir a matriz mestra. **Status: concluído**, limitado aos 128 critérios e à rastreabilidade documental/estática. Os Planos 02–09 e os prompts P13–P60 não foram executados como fases de implementação/validação funcional.
- **Repositórios e revisões:** quatro HEADs completos e estados de entrada na seção 8.1. Documentação/web avançaram e estão limpos na entrada; backend/mobile mantêm os HEADs do Plano 00. A mudança desta execução é somente a auditoria na documentação.
- **Arquivos alterados:** `auditorias/auditoria-dev3-atual-2026-11-23.md`. Registro do Plano 00 preservado e identificado como histórico, nova referência, catálogo, matriz, bloqueios e este handoff acrescentados. Plano de recuperação, auditoria de outubro, prompts e três repositórios de produto preservados.
- **Critérios verificados:** mapeamento dos 12 prompts por critério; fontes e responsabilidades; distinção I/T/execução/integração/demo/aceite; drift estático da conclusão mobile; presença atual de OFX/Pluggy; preparação limitada sync-runs web; ausência de produto S4 no recorte inspecionado. V/LE não significam aceite de comportamento.
- **Comandos executados e resultados:** seção 13.1 e coleta Git da seção 8.1; comparação JSON e hashes da seção 12.2. Validação documental de 128 critérios/12 prompts/118 referências aprovada com saída 0 e `git diff --check` com saída 0. A reconferência final após a edição deve manter esses resultados, os HEADs, os hashes preservados e apenas esta auditoria modificada.
- **Verificações não executadas:** testes de qualquer espécie do produto, lint, typecheck, build/export, instalação, geração de OpenAPI/snapshots, banco/RLS em execução, migrations, Auth0 real, Pluggy Sandbox, QStash, R2, demonstração, revisão externa e aceite formal. Nenhum resultado histórico foi reapresentado como atual.
- **Defeitos/divergências e responsáveis:** B01 mobile/contrato e B02/B03 OFX confirmados por leitura de código/artefatos, sem falha de runtime presumida. D2 responde por clientes, D1 por backend/contrato/ciclo de vida; D3 registra e verifica posteriormente. B04–B08/B11/B13/B14 distinguem cobertura, decisões, produto ausente e documentação. Não foram corrigidos produtos ou contratos nesta etapa.
- **Decisões ainda abertas:** C-02, parâmetros C-03, capacidades/escopo C-04, prova D13/C-05, C-06 e semânticas investimento/alocação/patrimônio conforme B04–B08; mecanismo de geração B11 e aplicabilidade assíncrona OFX B13. Decisão fechada sem listagem e direção de API sync não foram reabertas.
- **Bloqueios de ambiente:** nenhum impediu a matriz local. Disponibilidade de ambientes futuros não avaliada; B09 exige prontidão/autorização por cenário. B12 é adiamento explícito da execução, não indisponibilidade técnica constatada.
- **Riscos residuais:** evidência estática não garante runtime, totalidade da cobertura, integridade em banco, integração externa ou UI real. As revisões podem avançar. Handoffs/contratos contêm trechos históricos; Plano 02 ainda precisa reconciliá-los. Nenhuma sprint ou P59/P60 está aceita por esta matriz.
- **Próximo plano elegível:** Plano 02 — Reconciliar contratos e documentação vigente, em conversa própria; não iniciado aqui. Os checks e comandos futuros da matriz são roteiro, sem autorização de execução nesta conversa.
- **Condição de entrada do próximo plano:** consultar matriz/catalogo/B01–B14, reconferir HEADs e estados, comparar contrato backend com snapshots/schemas de ambos os clientes e obter aprovação específica após o plano da nova etapa. Limitar correções a documentação vigente e formalizar defeitos de produto com responsáveis. Testes ficam para as etapas autorizadas.
- **Índice de recuperação:** o status inicial do Plano 01 no documento de recuperação não foi editado porque esse arquivo está fora do conjunto de escrita aprovado; este handoff registra a execução. A conclusão da matriz não fecha os critérios funcionais nela classificados IR/PA/BL/NI.
- **Sugestão de commit:** `docs(dev3-01): consolida matriz por criterio e bloqueios P13-P60`, incluindo somente esta auditoria. Nenhum commit criado nesta etapa.

## 14. Plano 02 — revisões e procedência

A matriz do Plano 01 é o ponto de partida. Esta seção registra a comparação de 24/11/2026 após o pull, sob aprovação `planejamento aprovado, pode implementar`. O OpenAPI e os controllers descrevem o contrato publicado. As decisões da Sprint 3 e da Sprint 4 definem os critérios de aceite. Diferenças entre essas fontes estão nos achados da seção 16.

| Checkout `main` | HEAD completo | Estado na entrada |
|---|---|---|
| Documentação | `d14b776408f8145003d8cf6de33ea9ad20c740c0` | Limpo. Incorpora adendos S4 e o registro local de validação. |
| Backend | `b9f6a7a7e1b937dce6d8353b2572058591fb9ecf` | Limpo. O pull trouxe `9fc5a1f` (HU-008), `e4c6a48` (HU-009), `a730f56` (HU-012) e a correção HTTP de contas/OFX em `b9f6a7a`. |
| Web | `00717135e92f62e84d2c53cb3f63f8c91a44b7ca` | Limpo. Snapshot web introduzido em `35c1cfc`. |
| Mobile | `859abacccb17dc165877d8f1832a6bf0686797d8` | Limpo. Snapshot mobile introduzido em `3440ca6`. |

| Artefato | SHA-256 do arquivo | Comparação semântica |
|---|---|---|
| Backend `openapi/openapi.json` | `1262d18a4345d72d9217f1742d07ea532cc3d2a9d2793f09f23c919e14ec8b58` | 40 operações, 16 schemas em `components.schemas`. |
| Web `src/lib/api/openapi.snapshot.json` | `f301f9b4a0b8a6aa9684cbed0478eefbc656b6ac4a7d628c216d3ca4f252b287` | O JSON completo equivale a `234cb11` removida a rota `PUT` de mapeamento. No HEAD do backend, 28 operações comuns são idênticas, assim como os 16 schemas de componentes. Faltam 12 operações publicadas. |
| Mobile `src/lib/api/openapi.snapshot.json` | `2882e8b595d5af63320f08dc4e057c7bfc85b5e0a029fa610fd8584f3f467e39` | O blob é idêntico ao de `605cb07`. No HEAD do backend, 26 operações são idênticas e duas mudaram. Faltam as mesmas 12 operações e dois componentes, `PluggyDataAvailability` e `PluggyImportAccount`. |

As operações ausentes dos dois snapshots são mapeamento Pluggy (1), sincronização e sessão de atualização HU-008 (4), consulta de investimentos e movimentos HU-009 (2) e patrimônio HU-012 (5). As últimas sete entram na contagem do diff. A revisão de produto dessas histórias pertence às etapas da Sprint 4. As duas operações diferentes no mobile são a conclusão Pluggy e o detalhe da conexão. O conjunto atual de rotas de contas, movimentações e categorização é idêntico nos snapshots e no backend. Os tipos e schemas dos clientes são mantidos localmente à mão. O mecanismo de geração continua sem decisão registrada (B11).

### 14.1. Como reproduzir o diff

Da raiz da documentação, executar o bloco em Node por entrada padrão. O script usa os checkouts irmãos e os commits de origem para comparar método, caminho, parâmetros, corpo, respostas, segurança e schemas, sem depender de serviços em execução. A ordem das propriedades dos objetos JSON é normalizada antes da comparação.

```js
const fs = require("node:fs");
const { execFileSync } = require("node:child_process");
const roots = ["backend", "web", "mobile"].map(name => "../" + name + "-centralizador-financeiro");
const files = ["openapi/openapi.json", "src/lib/api/openapi.snapshot.json", "src/lib/api/openapi.snapshot.json"];
const [backend, web, mobile] = roots.map((root, index) =>
  JSON.parse(fs.readFileSync(root + "/" + files[index], "utf8")));
const normalize = value => Array.isArray(value) ? value.map(normalize)
  : value && typeof value === "object"
    ? Object.fromEntries(Object.keys(value).sort().map(key => [key, normalize(value[key])]))
    : value;
const same = (a, b) => JSON.stringify(normalize(a)) === JSON.stringify(normalize(b));
const operations = doc => Object.fromEntries(Object.entries(doc.paths).flatMap(([path, item]) =>
  Object.entries(item).filter(([method]) => /^(get|post|put|delete|patch|head|options|trace)$/.test(method))
    .map(([method, value]) => [method.toUpperCase() + " " + path, value])));
const current = operations(backend);
for (const [name, client] of [["web", web], ["mobile", mobile]]) {
  const local = operations(client);
  const schemas = backend.components.schemas;
  const localSchemas = client.components.schemas;
  console.log(name, {
    published: Object.keys(current).length,
    snapshot: Object.keys(local).length,
    missing: Object.keys(current).filter(key => !(key in local)),
    extra: Object.keys(local).filter(key => !(key in current)),
    changed: Object.keys(local).filter(key => key in current && !same(local[key], current[key])),
    changedSchemas: [...new Set([...Object.keys(schemas), ...Object.keys(localSchemas)])]
      .filter(key => !same(schemas[key], localSchemas[key])),
  });
}
const getOrigin = revision => JSON.parse(execFileSync("git",
  ["-C", roots[0], "show", revision + ":" + files[0]], { encoding: "utf8" }));
const webOrigin = getOrigin("234cb11");
delete webOrigin.paths["/api/v1/connections/{connectionId}/accounts/{providerAccountId}/mapping"];
console.log("origem web sem mapping:", same(webOrigin, web));
console.log("origem mobile:", same(getOrigin("605cb07"), mobile));
```

## 15. Contrato publicado e consumo verificado

Os caminhos abaixo têm prefixo `/api/v1`. Os códigos de erro da tabela são as respostas do OpenAPI, conferidas também nos snapshots quando a operação está presente. Os schemas de cliente foram inspecionados em `src/lib/ingestions/schema.ts`, `src/lib/connections/schema.ts` e, no web, `src/lib/sync-runs/schema.ts`. Os testes citados nos achados são evidência de cobertura presente.

| Operação | Sucesso e campos relevantes | Erros publicados | Consumo |
|---|---|---|---|
| `POST /ingestions/ofx/previews` | `201` com `ImportRun`. Multipart `file` e `destinationAccountId`. Chave obrigatória. | `400/401/403/404/409/413/415/422/500/503` | Ambos. Limite local de 4 MiB no web e de 10 MiB no mobile e na API. |
| `POST /ingestions/{importRunId}/confirmations` | `200` com `ImportRun`. Mesmo destino em JSON. Chave obrigatória. | `400/401/403/404/409/500/503` | Ambos. Confirmação síncrona no backend. A aplicabilidade de processamento assíncrono requer medição (B13). |
| `GET /ingestions/{importRunId}` | `200` com `ImportRun`. Sem chave. | `400/401/403/404/500` | Ambos. |
| `POST /connections/pluggy/sessions` | `201` com `connection`, `connectToken` e `expiresAt`. | `401/500/503` | Ambos. |
| `POST /connections/pluggy/completions` | `202` com `{ connection, initialImport }`. `Idempotency-Key` obrigatória e `{ itemId }`. | `400/401/404/409/500/503` | Web compatível. Mobile envia sem chave e espera a conexão isolada. B01. |
| `GET /connections/{connectionId}` | `200` com conexão e `initialImport` obrigatório como campo, que pode ser nulo. | `400/401/404/409/500` | Web valida e oferece atualização manual. Mobile lê campos da conexão e descarta `initialImport`. B01. |
| `POST /connections/{connectionId}/disconnect` | `200` com a conexão após a operação. | `400/401/404/409/500/503` | Ambos. |
| `PUT /connections/{connectionId}/accounts/{providerAccountId}/mapping` | `200` com `connectionId`, `providerAccountId`, `accountId` e `initialImport`. `{ action: "link", accountId }` ou `{ action: "create" }`. | `400/401/404/409/500/503` | Ausente dos dois clientes e snapshots. P02-01. |
| `POST /connections/{connectionId}/sync-runs` | `202` com execução. Sem chave. Requisições enquanto uma execução está ativa reaproveitam o run. | `400/401/404/409/500/503` | Web tem chamada de biblioteca, mobile sem consumo. P02-04. |
| `GET /connections/{connectionId}/sync-runs/{runId}` | `200` com execução. | `400/401/404` | Web tem chamada de biblioteca, mobile sem consumo. P02-04. |
| `GET /connections/{connectionId}/sync-runs/latest` | `200` com `latest` e `lastReconciled`, ambos anuláveis. | `400/401/404` | Ausente dos dois clientes. P02-04. |
| `POST /connections/{connectionId}/update-session` | `200` com `connectToken` e `expiresAt` para ação do usuário. | `400/401/404/409/503` | Ausente dos dois clientes. P02-04. |

- **Estados OFX.** Os dois schemas aceitam `preview_ready`, `queued`, `processing`, `completed`, `completed_with_errors`, `failed` e `expired`, com estado e contadores de itens separados. A prévia expõe `isDuplicate` e `warnings`. O cliente usa `external_id_missing` para aviso e a API deixa `errorCode` do item aberto. `awaiting_account_mapping` e `expiresAt` da prévia são exigidos pela S3-08 e estão ausentes do contrato OFX. `queued` no enum não demonstra processamento assíncrono.
- **Estados Pluggy.** A conexão pode estar `pending_authorization`, `connected`, `partially_available`, `expired`, `revoked` ou `disconnected`. O status do consentimento pode ser `granted`, `expired`, `revoked` ou nulo. `initialImport` tem estados próprios `queued`, `processing`, `awaiting_account_mapping`, `completed`, `completed_with_errors` e `failed`. A disponibilidade de contas e transações é independente, com `pending`, `available`, `unavailable` e `failed`. O mapeamento por conta pode estar `pending`, `mapped` ou `unsupported`.
- **Estados HU-008.** `queued`, `running`, `action_required`, `succeeded`, `partial` e `failed`. O contrato de execução exige `trigger` (`manual` ou `daily`), `acceptedAt`, `startedAt`, `completedAt`, `referenceDate`, `reasons` e `statusUrl` além de estado e IDs. As datas posteriores podem ser nulas. Os motivos publicados são `unavailable`, `failed` e `ambiguous_identity` por tipo de dado.
- **Problem Details.** OFX distingue `ACCOUNT_NOT_FOUND` e `ACCOUNT_ARCHIVED`, conflitos de idempotência (`IDEMPOTENCY_KEY_REUSED` e `IDEMPOTENCY_KEY_EXPIRED`) e erros de arquivo `413/415/422` com `INVALID_REQUEST`. A revisão `b9f6a7a` corrige também o ramo de `PayloadTooLargeException` para `413`. Conexões/Pluggy mapeiam falta da chave para `400 INVALID_REQUEST`, conexão não localizada para `404 CONNECTION_NOT_FOUND`, conflito de estado ou idempotência para `409 CONNECTION_CONFLICT` e falha de integração para `503 INTEGRATION_UNAVAILABLE`. A diferença entre o filtro compartilhado e as respostas publicadas está em P02-06.

## 16. Achados reproduzíveis e encaminhamentos

As observações abaixo foram verificadas pelo diff e por leitura dirigida na revisão da seção 14. Os cenários de execução propostos usam fixtures, relógio controlado ou ambiente descartável autorizado. Registre o resultado observado quando forem executados.

| Achado e impacto | Como reproduzir e evidência observada | Critério de correção e responsável |
|---|---|---|
| **B01 · Alta · Conclusão Pluggy mobile bloqueada** | Comparar o `POST .../completions` e o `GET .../{connectionId}` do OpenAPI e do snapshot mobile. Em `src/lib/connections/api.ts`, `completePluggyConnection` envia só `{ itemId }` e usa `connectionSchema`. `api.test.ts` fixa `200` sem header. O controller `pluggy-initial-import.controller.ts` retorna `400` se a chave faltar e publica `202` com envelope. Cenário dirigido após a correção: repetição do mesmo Item/chave após resposta perdida e consulta dos estados até resultado. | **Dev 2**, encaminhado no contrato mobile. Gerar uma chave por conclusão, manter a mesma em retries do mesmo payload, ler o envelope `202` e preservar `initialImport` no detalhe. Dev 1 mantém contrato/replay. Dev 3 verifica no Plano 06. |
| **P02-01 / B05 · Alta · Mapeamento Pluggy bloqueado nos clientes** | Comparar o `PUT .../mapping` no OpenAPI com snapshots e `src/lib/connections` nos dois clientes. Usar estado sintético `awaiting_account_mapping` com conta externa pendente. Web exibe espera e atualização, sem ações `link/create`. O mobile também depende de B01 para acessar o estado. `PluggyInitialImport.mapAccount` valida conexão elegível e rejeita conta externa `unsupported`. A coleta inicial filtra produtos autorizados e representa conta externa corrente, poupança ou cartão em BRL como tipos mapeáveis, sujeitos a nome válido. O caminho `create` aplica restrições adicionais de saldo/data. Em um novo `link`, o domínio rejeita conta arquivada e vínculo a outro ID externo. A seleção consulta contas do tenant e a conexão pertence ao usuário. | **Dev 2** implementa seleção e ações em plano próprio. **Dev 1** confirma guardas e regressões de titularidade, conta arquivada e vínculo anterior. C-02 já decide seleção explícita entre locais ativas e elegíveis, criação quando não houver opção e espera enquanto não houver escolha. Dev 3 verifica retomada após o último mapeamento e validação negativa. [Decisões C-02 e C-03](../docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md). |
| **B02 / P02-02 · Alta · OFX exige destino cedo e lista conta inelegível** | Conferir `destinationAccountId` obrigatório no multipart e em `CreateOfxImportPreview`. O seletor web `contas/importar-ofx/page.tsx` e o mobile `OfxImportScreen.tsx` mapeiam todas as contas de `listAccounts` sem filtrar `origin`. Com uma conta manual ativa e uma conectada ativa do mesmo tenant, selecionar cada uma para o mesmo OFX sintético, usando chaves próprias. Pelo código, a manual é elegível. A conectada é exibida, mas recusada pelo backend com `409`. Comparar também a ausência de `awaiting_account_mapping` nos schemas da prévia. | **Dev 1** alinha contrato/API ao fluxo arquivo → escolha de destino → prévia final da S3-08. **Dev 2** alinha seletores e estado. Dev 3 verifica num cenário com conta elegível, conectada, arquivada e inacessível e comprova duplicatas só após destino resolvido. [Critérios S3-08](../docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html). |
| **B03 / P02-03 · Alta · Validade e limpeza de OFX incompletas** | Conferir `ingestion-openapi.schema.ts`, `ImportRun`, `PrismaIngestionRepository.startConfirmation` e `ConfirmOfxImport`. O caminho de confirmação aceita `PREVIEW_READY` sem conferir idade. `GetImportRun` lê estado persistido. A regra de expiração de chave opera sobre o registro de idempotência. A confirmação em estado terminal tenta apagar o objeto no R2 e a criação compensa falha de gravação. `retentionExpiresAt` é calculado 90 dias após o terminal. A busca em código e migrations não encontrou rotina OFX de expiração de prévia abandonada ou expurgo de metadados. Cenário dirigido: criar prévia com fixture, avançar o relógio até a borda de 24h, consultar e confirmar com chave nova para isolar o prazo da prévia. Em cenário de retenção, observar objeto após terminal/abandono e metadados na borda de 90 dias. | **Dev 1** implementa ou comprova validade, rejeição sem escrita, transição para `expired` e limpeza/expurgo conforme S3-08 e D7/D11. **Dev 2** representa prazo e estado quando publicados. Dev 3 valida ciclos com relógio, banco e storage descartáveis. [Critérios S3-08](../docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html) · [Decisões S3-01](../docs/planejamento/sprint-03/contrato-backend-s3-01.html). |
| **B06 / P02-04 · Alta · HU-008 publicado no backend, consumo incompleto** | Inspecionar `pluggy-sync.controller.ts`, `pluggy-sync-openapi.schema.ts` e os quatro caminhos da seção 15. Buscar chamadas fora de `src/lib/sync-runs` no web e nos arquivos mobile. O web oferece POST e GET por ID em biblioteca com testes de fixtures. O schema descarta `trigger`, `referenceDate` e `reasons` e aceita omissão de datas que são campos obrigatórios e anuláveis na API. `latest`, `update-session`, tela e acompanhamento não foram localizados nos clientes do recorte. Para reproduzir a perda de campos, validar no schema web um corpo sintético completo com `partial` e `reasons`. | **Dev 2** reconcilia snapshots/schemas com diff e entrega consumo e UX de acompanhamento, resultado e ação requerida. **Dev 1** mantém o contrato. Dev 3 valida gatilhos manual/diário, reaproveitamento de execução ativa, estados, ações, tenant e plataforma antes de P59/P60. [Decisões S4-01](../docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md). |
| **B04 / P02-05 · Média · Deduplicação implementada, aviso de ambiguidade incompleto na importação inicial** | Comparar `ImportPluggyTransaction`, `pluggy-api.client.ts`, a chamada do importador nos dois fluxos e os schemas de suas respostas. O adapter aceita ID ausente/nulo. O backend cria identidade estável escopada por conexão/conta e usa índice único por tenant/conta/identidade. Sem ID, consulta candidatos por conta, tipo, data, valor e descrição. Uma correspondência é duplicata. Múltiplas devolvem `ambiguous` sem inserir. A sincronização publica motivo `ambiguous_identity`. Na importação inicial, `ambiguous` incrementa `failedTransactions` e o contrato expõe contadores, sem motivo consultável equivalente. O replay da chave de conclusão já tem spec no backend `7c34b4d`. | **Dev 1** confirma com Produto o estado/aviso inicial exigido por C-05 e entrega evidência do mesmo ID na mesma conexão, ID ausente e zero/uma/múltiplas correspondências nos dois fluxos. Dev 3 valida aviso, continuidade do lote e garantia do identificador do provedor sob autorização própria. [C-05 e D13](../docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md). |
| **P02-06 · Média · Respostas do filtro de conexões sem cobertura integral no OpenAPI HU-008** | Comparar `responses` dos quatro caminhos com `ConnectionsProblemDetailsFilter`. O filtro traduz contexto indisponível em `403 IDENTITY_CONTEXT_UNAVAILABLE`, ausente das quatro definições. Também prevê `500 INTERNAL_ERROR`, publicado no POST de sync e ausente das consultas e de `update-session`. A aplicabilidade de cada ramo em runtime requer teste dirigido. | **Dev 1** confirmar as respostas possíveis por operação com testes de contexto indisponível e falha interna controlada e publicar as respostas aplicáveis. **Dev 2** revisar o tratamento quando alinhar os clientes. |

**Chave por requisição e identidade por movimentação.** No mobile manual, `MovementFormScreen.tsx` cria a chave de `POST /transactions` via `expo-crypto` e a mantém no mesmo envio repetido quando o backend não pede rotação. A conclusão Pluggy usa uma chave para o comando que inicia o run. A importação inicial e a sincronização recorrente chamam o importador do backend para cada movimentação. A função `createPluggyExternalIdentityKey` incorpora o ID Pluggy à identidade da conexão e da conta externa ou usa moeda, data, valor, tipo e descrição quando o ID falta. O importador grava com `createIfExternalIdentityAbsent`. A garantia sobre presença e estabilidade dos IDs em conectores reais e a evidência após reconexão permanecem condicionais.

**Impacto na matriz do Plano 01.** B01, B02 e B03 seguem reproduzíveis estaticamente. B05 passa de decisão em aberto para consumo e confirmação dos guardas C-02. B06/P59/P60 passam a separar backend publicado de consumo e validação pendentes. A leitura de “backend ausente” em B06–B08 pertence à linha de base anterior. HU-009 e HU-012 ganharam operações no backend. A matriz histórica permanece disponível para rastrear essa evolução. B14 é tratado nas seções vigentes dos contratos e no roteiro atualizado. [Validação local da S4 de 23/11/2026](../docs/planejamento/sprint-04/s4-06-validacao-local-2026-11-23.md).

## 17. Validação e handoff do Plano 02

### Execution handoff — Plano 02

- **Plano executado.** Plano 02 — Reconciliar contratos e documentação vigente. **Concluído com ressalvas.** A compatibilidade está descrita por operação e os bloqueios de produto têm responsável.
- **Repositórios e revisões.** Os quatro HEADs e os três hashes estão na seção 14. A validação local S4 de 23/11 serve como evidência histórica de execução, com revisões e estado de checkout próprios.
- **Arquivos alterados.** Esta auditoria, o [índice de recuperação](../docs/planejamento/plano-recuperacao-dev3.md#18-como-acompanhar-o-progresso), o [roteiro da Sprint 3](../prompts/sprint3/dev2/roteiro-demonstracao-sprint-3.md) e `src/lib/api/CONTRACT.md` em cada cliente.
- **Critérios verificados.** Revisão de origem e diff estrutural de 40 operações publicadas, 28 em cada snapshot, schemas de borda, códigos publicados, conclusão e andamento Pluggy, elegibilidade/mapeamento, ciclo OFX e publicação da HU-008. A procedência e as diferenças foram registradas com preservação dos snapshots.
- **Comandos e resultados.** Coleta com `git status`, `git rev-parse`, `git log`, `git show`, `rg` e leitura dirigida. A comparação em Node da seção 14.1 retornou 12 operações ausentes por cliente, zero extras, zero alterações comuns no web e duas no mobile. As duas verificações de origem retornaram `true`. A validação documental adicional conferiu 12 linhas de respostas contra o JSON, os três SHA-256, 17 links locais no recorte editado, o histórico dos Planos 00/01 e o conjunto de cinco arquivos aprovados. `git diff --check` retornou 0 nos quatro checkouts.
- **Verificações não executadas.** Suítes de produto, lint, typecheck, build, geração de artefatos, inspeção de ambiente externo, runtime com PostgreSQL/RLS, Auth0, Pluggy Sandbox, QStash, R2, demonstração e aceite.
- **Defeitos e responsáveis.** B01 está encaminhado ao Dev 2 no `CONTRACT.md` mobile. Seção 16 detalha as demais reproduções e respectivos responsáveis. O encaminhamento está nos documentos locais.
- **Decisões ainda abertas.** Mecanismo de geração dos clientes (B11), limiar mensurado para OFX assíncrono (B13), confirmação do aviso da importação inicial e evidência do provedor em C-05. C-02 já tem decisão de Produto.
- **Bloqueios de ambiente.** Nenhum impediu a comparação local. As condições citadas no roteiro dependem da prontidão dos ambientes autorizados quando executado.
- **Riscos residuais.** Compatibilidade estática não verifica integração, comportamento em execução, segurança de tenant ou jornadas completas. O snapshot mobile reproduz o contrato antigo e os dois omitem mapeamento Pluggy e HU-008. O histórico de testes da S4 não cobre a validação do consumo HU-008 nas revisões dos clientes deste handoff.
- **Próximo plano elegível.** Plano 03 — Restabelecer a base de execução, em conversa própria.
- **Condição de entrada.** Contratos reconciliados no recorte compatível ou bloqueados com evidência e responsável, conforme este handoff. Reconfirmar os HEADs, preparar a execução e obter aprovação do Plano 03.

## 18. Plano 03 — Base local e revisões

Executado em 24/11/2026, horário de Brasília, em Windows x64 com Node 22.16.0, npm 10.9.2 e pnpm 12.3.4. O [handoff do Plano 02](#execution-handoff--plano-02) atendia à condição de entrada. Os HEADs dos clientes incorporavam o commit documental daquele plano.

| Checkout `main` | HEAD | Estado versionado na entrada |
|---|---|---|
| Backend | `b9f6a7a7e1b937dce6d8353b2572058591fb9ecf` | Limpo |
| Web | `6488cc61b767d4bf1d553b56639ebaf96fdf6280` | Limpo |
| Mobile | `411763747a79507e85631721722e27a05525af69` | Limpo |
| Documentação | `658a130985c66e5883386f2436b1490385976746` | Limpo |

O npm trabalhou em modo offline e sem scripts de instalação. O executável do pnpm 12.3.4 foi extraído do cache npm, com SHA-512 conferido contra o lockfile, após falhas de inicialização pelo Corepack. A geração do Prisma usou uma cópia local do motor 7.10.0. Os executores Node receberam configuração fictícia, bloqueio de conexões e telemetria desabilitada. Nos comandos nativos de instalação do pnpm foram passados os sinalizadores de modo offline e congelamento do lockfile. A recuperação produziu apenas dependências, arquivos de compilação e auxiliares locais nos checkouts de produto.

## 19. Plano 03 — Comandos e resultados

Todas as linhas herdam a data e o HEAD da seção 18. As horas são locais. A classificação refere-se à falha observada na tentativa.

| Checkout | Hora | Comando ou verificação | Saída | Resultado |
|---|---|---|---:|---|
| Backend | 01:44 | `npm ci --offline --no-audit --no-fund --ignore-scripts` | 0 | 640 pacotes instalados a partir do cache. Aviso de descontinuação do ESLint 9.39.5. |
| Backend | 01:44 | `npm run prisma:generate` | 1 | Ambiente. O Windows negou a atualização da data do executável no cache global do Prisma. |
| Backend | 01:44 | `npm run test:unit` | 0 | 39 arquivos, 180 testes aprovados. |
| Backend | 01:44 | `npm test -- test/contract/openapi.contract.spec.ts` | 0 | 1 arquivo, 8 testes de contrato OpenAPI aprovados. |
| Backend | 01:45 | `npm run prisma:generate` com `PRISMA_SCHEMA_ENGINE_BINARY` local | 0 | Cliente Prisma 7.10.0 gerado a partir do schema versionado. |
| Web | 01:44–01:46 | `corepack pnpm --version`, inicialização direta do wrapper e `npm pack … --offline` | 1 | Ferramenta e ambiente. O Corepack não encontrou o binário exigido e a consulta npm por nome falhou com `ENOTCACHED`. |
| Web | 01:46 | Extração por SHA-512 e `pnpm.exe --version` | 0 | Executável local 12.3.4 confirmado. |
| Web | 01:46–01:47 | `pnpm install --offline --frozen-lockfile --ignore-scripts` | 1 | Ambiente. A reinstalação removeu os atalhos em `node_modules/.bin` antes de falhar com acesso negado. A parte do lockfile que descreve as dependências era idêntica ao lockfile da instalação existente. As primeiras chamadas a teste, typecheck, lint e build saíram com 1 por falta dos atalhos. |
| Web | 01:48–01:52 | Instalação isolada com `--frozen-store` e tentativas com cache explícito e `--trust-lockfile` | 1 / 2 / 1 / -1073741571 | Ambiente e ferramenta. Duas faltas de metadados offline, uma opção de cache rejeitada e um estouro de pilha do pnpm 12.3.4. |
| Web | 01:48–01:49 | Vitest, `next typegen`, `tsc --noEmit` e ESLint por caminho direto | 0 cada | 49 arquivos e 749 testes aprovados, incluindo contrato. Tipos e lint aprovados. |
| Web | 01:49–01:50 | Regeneração dos atalhos a partir dos manifestos instalados e `pnpm exec vitest --version` / `pnpm exec next --version` | 0 | Atalhos de Vitest, Next.js, ESLint, TypeScript e tsserver restaurados. Vitest 5.0.1 e Next.js 16.3.4 confirmados. |
| Web | 01:49–01:55 | `next build --webpack` com fontes simuladas e tentativas de isolar a saída | 1 | Ambiente e ferramenta. `EPERM` na gravação de páginas ou tipos. A tentativa de criar um vínculo de diretório foi negada. A primeira configuração temporária de saída também falhou ao carregar o Next e foi ajustada. |
| Web | 01:58–02:00 | `pnpm run build --webpack` com fontes simuladas, saída separada e um worker | 0 | Compilação, validação TypeScript e geração de 11 páginas concluídas após autorização para gravar fora das restrições que provocaram `EPERM`. Aviso de importação dinâmica em `dpopUtils.js` do SDK Auth0, sem impedir o build. |
| Web | 02:00–02:01 | `pnpm test`, `pnpm typecheck`, `pnpm lint` com os atalhos restaurados | 0 cada | 49 arquivos, 749 testes aprovados. Typecheck e lint aprovados pelos scripts do projeto. |
| Mobile | 01:52–01:54 | `pnpm install --offline --frozen-lockfile --frozen-store --ignore-scripts --trust-lockfile` | -1073741571 | Ferramenta. O pnpm 12.3.4 esgotou a pilha durante a instalação. |
| Mobile | 01:54 | Repetição offline isolada com `node-linker=hoisted` | 1 | Ambiente. `ERR_PNPM_NO_OFFLINE_TARBALL` para `encodeurl@1.0.2` no store pnpm. O npm tinha esse tarball por integridade. |
| Mobile | 01:56 | Conferência dos caches por integridade e tentativa com pnpm 11.25.0 isolado | 1 / -4048 | Ambiente. Das 526 entradas compatíveis com Windows x64 examinadas, 138 estavam indexadas no pnpm, 63 apareciam apenas no npm e 325 estavam ausentes de ambos. O pnpm alternativo também esbarrou em `EPERM`. A consulta dirigida confirmou a ausência de `expo@57.0.22`, `@expo/cli@57.0.24`, Expo Crypto e Expo Secure Store. |
| Mobile | 01:59 | Vitest compartilhado, primeiras tentativas com configuração temporária | 1 cada | Ambiente. A primeira tentativa esbarrou na pasta temporária do Vite. Em seguida, os 30 arquivos ficaram sem testes executados pela ausência de `expo/tsconfig.base`. |
| Mobile | 02:00–02:01 | `vitest run --config node_modules/.cache/dev3-mobile.config.mts` pelo executável do web | 0 | 30 arquivos e 469 testes aprovados, incluindo contrato. Vitest 5.0.1 e Zod do web, configuração temporária para transpilar TypeScript em Node e dublês das próprias suítes. |
| Mobile | 02:01 | `pnpm typecheck` | 1, interrompido | Ferramenta. O pnpm iniciou instalação automática e tentou buscar pacotes no registro npm. As requisições observadas falharam em DNS. O processo foi interrompido e as verificações seguintes usaram chamadas diretas. |
| Mobile | 02:01–02:02 | Leitura estática de `app.json` e `package.json`, `tsc --noEmit --pretty false` direto e teste de presença do Expo | 0 / 2 / 1 | SDK declarado `~57.0.22`, 5 arquivos de imagem presentes e 3 plugins declarados. O compilador encontrou módulos e tipos indisponíveis, incluindo React Native e módulos Expo. O CLI local e o arquivo-base do Expo estavam ausentes. |
| Backend | 01:58–02:00 | `npm run typecheck`, `npm run lint`, `npm run build` | 0 cada | Typecheck, ESLint e build NestJS concluídos. Typecheck e build geraram o cliente Prisma localmente. |

O teste mobile pelo executor compartilhado preservou os arquivos de teste e fixtures originais. A configuração temporária aponta para Vitest e Zod no web, replica a configuração de teste do mobile e passa ao Vite um `tsconfig` local para a transpiração em Node. Essa execução cobre os asserts e o snapshot local do mobile. O typecheck completo exige a instalação do SDK e a resolução dos módulos e tipos do app.

## 20. Validação e handoff do Plano 03

### Execution handoff — Plano 03

- **Plano executado.** Plano 03 — Restabelecer a base de execução. **Bloqueado no mobile.** Backend e web têm resultados determinísticos atuais. A suíte mobile passou pelo executor isolado, com a instalação completa pendente.
- **Repositórios e revisões.** Quatro HEADs na seção 18. As validações de produto correspondem a essas revisões.
- **Arquivos alterados.** Esta auditoria e a linha do Plano 03 no [índice de recuperação](../docs/planejamento/plano-recuperacao-dev3.md#18-como-acompanhar-o-progresso). A verificação com `git diff --check HEAD` retornou 0 nos quatro checkouts. O Git confirmou que código, testes, snapshots, manifests, configurações e lockfiles dos três produtos ficaram sem alterações.
- **Critérios verificados.** 188 testes backend, 749 web e 469 mobile aprovados. Backend e web também passaram em typecheck, lint e build. O build web usou Webpack e fontes simuladas. A instalação mobile, seu typecheck e a execução do Expo permanecem bloqueados.
- **Comandos e resultados.** Seção 19. Os resultados vêm desta execução de 24/11/2026.
- **Verificações fora do recorte.** Banco, RLS, E2E real, Auth0, Pluggy, QStash, R2, demonstração e aceite. O Expo Doctor e o empacotamento nativo aguardam a base do SDK. O build web padrão com fontes reais também ficou fora da validação local.
- **Defeitos e responsáveis.** Developer 3 e responsável pelo ambiente tratam a disponibilidade de cache e a reprodução offline. O aviso de compilação em `dpopUtils.js` vem da dependência web. Os bloqueios de contrato do Plano 02 seguem com os responsáveis já registrados, pois a suíte de cada cliente verifica seu próprio snapshot e seus dublês.
- **Decisões ainda abertas.** Forma de fornecer localmente as dependências congeladas do mobile e reexecutar o SDK 57. A reinstalação web a partir de um diretório vazio também permanece sem confirmação neste ambiente.
- **Bloqueios de ambiente.** Pacotes fixados do mobile ausentes nos caches locais. Os erros de acesso do Windows foram contornados para o Prisma e o build web. O comportamento do pnpm 12.3.4 impediu reinstalações e disparou uma tentativa de busca no registro npm, bloqueada por DNS.
- **Riscos residuais.** O resultado dos testes mobile cobre Node com dublês. A reprodução da compilação web utiliza um diretório temporário, um worker e fontes simuladas. As evidências de aceite e as validações com provedores pertencem às etapas posteriores.
- **Próximo plano elegível.** Plano 04, em conversa própria, após a condição de entrada.
- **Condição de entrada.** Base determinística verde ou falhas conhecidas que preservem os cenários a validar. A execução da parte mobile do Plano 04 exige confirmar a base do app com as dependências congeladas e o SDK 57.
- **Sugestão de commit.** `docs(dev3-03): registra validacoes offline e bloqueio mobile`.

## 21. Plano 03 — Confirmação da instalação mobile

### Handoff da instalação mobile

**Status naquele momento: concluído com ressalvas.** Em 24/11/2026, o Developer 3 conferiu a instalação preparada pelo usuário no mesmo HEAD mobile, `411763747a79507e85631721722e27a05525af69`. O registro abaixo atualiza o resultado mobile da seção 20. O encerramento do plano está na seção 23.

A instalação usa Node 22.16.0, pnpm 12.3.4 e `expo@57.0.22`. O grafo instalado coincide com o documento do aplicativo em `pnpm-lock.yaml`, com 549 registros de pacotes e 549 snapshots. As 20 dependências diretas instaladas correspondem às versões fixadas. O store contém as 524 entradas do aplicativo compatíveis com Windows x64. Ele foi criado na pasta literal `$store/`, dentro do checkout mobile, e aparece como pasta local não rastreada. O registro de instalação aponta para essa pasta.

Todos os comandos abaixo usaram a revisão mobile acima. Os horários são de Brasília. Os executores do projeto usaram o ambiente fictício de teste e as verificações do Expo rodaram com `EXPO_OFFLINE=1` e telemetria desabilitada.

| Hora | Comando ou verificação | Saída | Resultado |
|---|---|---:|---|
| 02:16 | `node_modules/.bin/vitest.cmd run` | 0 | Script de teste do projeto executado com o Vitest e a configuração do mobile. 469 testes em 30 arquivos aprovados, incluindo contrato. |
| 02:16 | `node_modules/.bin/tsc.cmd --noEmit` | 0 | Typecheck do projeto aprovado com TypeScript 6.0.3 e a configuração-base do Expo instalada. |
| 02:16 | `node_modules/.bin/expo.cmd config --type public --json` | 0 | Configuração pública resolvida com SDK 57.0.0 e os três plugins declarados. |
| 02:16 | `node_modules/.bin/expo.cmd install --check` | 0 | O Expo informou que as dependências estavam atualizadas e registrou a limitação de confiabilidade da checagem em modo offline. |
| 02:17 | `node_modules/.bin/expo.cmd export --platform android --max-workers 2 --output-dir <pasta temporária>` | 0 | Metro empacotou 958 módulos e gerou um bundle Hermes para Android com 5 assets. |
| 02:17–02:18 | Conferência de manifests, lockfile instalado e índice do store. `pnpm --version` pelo binário local | 0 no recorte do app | As 524 entradas do aplicativo constam do store. A primeira contagem retornou 1 ao incluir dois pacotes do próprio gerenciador mantidos fora desse store. O executável local de pnpm 12.3.4 retornou 0. |

- **Ressalvas naquela execução.** O web usou a instalação recuperada e fontes simuladas no build. A reinstalação em diretório vazio ainda aguardava confirmação. No mobile, a checagem de compatibilidade usou o modo offline e a exportação Android verificou o bundle local.
- **Arquivos e escopo.** A auditoria e o índice de recuperação registram o encerramento. Os manifests, testes, contratos e lockfiles dos produtos permanecem com o conteúdo dos HEADs verificados. Banco e integrações reais pertencem aos planos seguintes.
- **Próximo plano elegível.** Plano 04, em conversa própria. A base local do mobile foi verificada para os testes, o typecheck e a exportação Android.
- **Sugestão de commit.** `docs(dev3-03): registra validacoes deterministicas e recuperacao mobile`.

## 22. Plano 03 — Verificação das ressalvas do web

Em 24/11/2026, o checkout web `6488cc61b767d4bf1d553b56639ebaf96fdf6280` foi exportado para uma pasta de trabalho vazia. A leitura do índice retornou 432 registros de pacotes do aplicativo compatíveis com Windows x64. O índice indica os registros cadastrados. A instalação limpa verifica se o pnpm consegue usá-los.

| Hora de Brasília | Comando ou verificação | Saída | Resultado |
|---|---|---:|---|
| 02:21–02:22 | `pnpm install --offline --frozen-lockfile --frozen-store`, em cópia limpa | 1 | Ambiente. A primeira tentativa encontrou `ERR_PNPM_NO_OFFLINE_META` no cache isolado do Windows. |
| 02:22–02:23 | Mesmo comando com acesso ao cache local do Windows | 1 | Ambiente. A verificação de metadados passou e a instalação reaproveitou centenas de pacotes. O pnpm retornou `ERR_PNPM_NO_OFFLINE_TARBALL` para `delaunator@5.1.0`. O tarball com o SHA-512 do lockfile foi localizado separadamente no cache do npm. |
| 02:23–02:27 | Recuperação de fontes WOFF2 do cache do Next e `next build` com Turbopack, resposta de fontes local e saída isolada | 0 para a recuperação dos arquivos, 1 para o build | Ferramenta. Foram recuperados nove arquivos WOFF2 de Manrope e Newsreader. O build padrão falhou na comunicação com o subprocesso que avalia as respostas locais de fontes. |

Essas tentativas deixaram duas verificações pendentes naquela revisão. A seção 23 registra a instalação limpa e o build padrão bem-sucedidos na revisão web seguinte, que inclui as fontes locais.

## 23. Plano 03 — Encerramento

### Handoff final do Plano 03

**Concluído em 24/11/2026.** O usuário executou o roteiro do web em duas cópias limpas da revisão `69aa6b9046c1255d29e353490114fee6609fbcb0` e forneceu o log. Essa revisão acrescenta Manrope e Newsreader com as respectivas licenças OFL 1.1 e carrega os arquivos com `next/font/local`. O backend permanece na revisão `b9f6a7a7e1b937dce6d8353b2572058591fb9ecf` e o mobile em `411763747a79507e85631721722e27a05525af69`.

| Comando no web | Saída | Evidência de 24/11/2026 |
|---|---:|---|
| `pnpm install --frozen-lockfile --store-dir <store>` na cópia de preparo | 0 | pnpm 12.3.4 preparou o store com 425 pacotes fixados. |
| `pnpm install --offline --frozen-lockfile --store-dir <store>` na cópia de validação | 0 | Reinstalação limpa. 425 pacotes reaproveitados e zero downloads. |
| `pnpm run test` na cópia de validação | 0 | 749 testes em 49 arquivos aprovados, incluindo contrato. |
| `pnpm run typecheck` e `pnpm run lint` | 0 cada | Geração dos tipos de rotas, TypeScript e ESLint concluídos. |
| `pnpm run build` | 0 | Next.js 16.3.4 com Turbopack compilou e concluiu a geração estática de 11 entradas. O build usou as fontes locais da revisão e valores fictícios de ambiente. |
| `git diff --exit-code HEAD -- package.json pnpm-lock.yaml pnpm-workspace.yaml` | 0 | Sem diferenças nesses arquivos. A conferência independente confirmou o conteúdo do commit após normalizar os finais de linha. |

- **Verificação do artefato.** O `BUILD_ID` está presente. Os dois arquivos de fonte emitidos pelo build têm o mesmo SHA-256 dos arquivos daquela cópia de validação. O log explicita o modo offline da instalação e registra os comandos e resultados do build.
- **Critérios de saída.** Backend com 180 testes unitários, 8 de OpenAPI, typecheck, lint e build aprovados. Web com instalação limpa offline, 749 testes, typecheck, lint e build padrão aprovados. Mobile com dependências fixadas verificadas, 469 testes, typecheck, configuração do Expo 57 e exportação Android aprovados.
- **Escopo.** Banco, Auth0, Pluggy, QStash, R2 e demais integrações de produto pertencem às validações posteriores. O cache mobile `$store/` é local e está fora do Git. O histórico de tentativas e avisos permanece nas seções anteriores.
- **Próximo plano elegível.** Plano 04, em conversa própria. A base determinística do Plano 03 está verificada.
- **Sugestão de commit.** `docs(dev3-03): encerra validacao deterministica dos tres produtos`.

## 24. Implementação das pendências do Plano 02 — Parte 1 (B01)

**Data:** 24/11/2026. **Status:** implementado e validado localmente. O login e o aceite da conclusão Pluggy no Sandbox foram aprovados no tablet. O reteste no web segue pendente. A seção 16 preserva a evidência original do bloqueio.

- **Revisões de referência.** Mobile `4117637`, backend `b9f6a7a` e web `69aa6b9`. A implementação usa o contrato publicado pelo backend e o fluxo web como referência.
- **Conclusão.** `ConnectScreen.tsx` cria um UUID ao abrir uma sessão do widget e preserva em memória a chave e o `itemId` para **Tentar de novo**. O primeiro desfecho do widget governa a tentativa. `completePluggyConnection` envia `Idempotency-Key` e valida o envelope de `202` com `connection` e `initialImport`.
- **Acompanhamento.** O cliente preserva `initialImport` da consulta, inclusive quando nulo. A tela exibe o estado da importação inicial separadamente da autorização. **Verificar de novo** consulta o backend durante fila, processamento ou espera pelo mapeamento, além do estado já existente de autorização pendente.
- **Snapshot e documentação.** O diff estrutural confirmou duas operações atualizadas e dois componentes incluídos. As 28 operações no snapshot mobile coincidem com as correspondentes de `b9f6a7a`. O `CONTRACT.md` mobile documenta a correção e o limite do mapeamento.
- **Verificação local.** Testes focados de API, contrato e estados da tela (`vitest run src/lib/connections/api.test.ts src/lib/api/contract.test.ts src/screens/connect-logic.test.ts`) passaram com 115 testes. A suíte mobile completa passou com 481 testes em 30 arquivos. `tsc --noEmit` e `expo export --platform android --max-workers 2` passaram. A exportação foi offline, com valores fictícios e saída temporária. `git diff --check` passou.
- **Aceite de campo.** Com backend de teste, Auth0 de teste, Pluggy Sandbox e a fila configurados, abrir **Contas → Conectar banco**, autorizar uma conta de teste e conferir o detalhe. O registro da conexão deve aparecer e o estado da importação deve ser mostrado em um aviso próprio. Enquanto estiver em andamento ou aguardando mapeamento, tocar em **Verificar de novo** e confirmar que o detalhe é atualizado. O cenário de reenvio com a mesma chave tem cobertura automatizada com uma primeira falha de transporte simulada.
- **Escopo restante.** A espera pelo mapeamento é exibida. Vincular ou criar a conta pertence à Parte 2 (P02-01). As etapas seguintes permanecem registradas na seção 16.

### Resultado em dispositivo e ressalva do Plano 02

> Registro da primeira tentativa em campo. O reteste após a correção do backend está na subseção seguinte.

- **Android e Auth0 — aprovados em campo.** O usuário instalou a versão de desenvolvimento no tablet Android e confirmou que concluiu o login pelo Auth0. O mobile usa `coinciente://auth` para o retorno no app instalado, com o mesmo endereço configurado na aplicação Native de teste. O logout em dispositivo não foi observado.
- **Pluggy — aceite pendente no web e no tablet.** Depois de passar pelo widget do Sandbox, os dois clientes exibiram “A conexão não foi registrada” e o aviso de serviço indisponível. O usuário voltou a relatar o erro no web após confirmar que o deploy do backend no Render estava ativo. O comportamento é compatível com `503 / INTEGRATION_UNAVAILABLE` no código inspecionado. O status HTTP da tentativa no backend não foi capturado. O `200` visto para `conectar` no navegador é da ação do servidor web.
- **Evidência da investigação.** No Render foi observado o registro de inicialização da rota `POST /api/v1/connections/pluggy/completions`, sem registro que identifique a causa da tentativa. O usuário confirmou que a URL do QStash no Render aponta para US East e que o token corresponde à sua conta pessoal nessa região. Os logs consultados estavam vazios. A ausência de mensagem registrada deixa em aberto se houve falha ao confirmar com o Pluggy ou ao publicar a importação inicial no QStash.
- **Responsável e critério de saída.** Dev 1 investiga a conclusão no backend e identifica a etapa e o status da falha com registro sanitizado. Dev 3 repete no web e no tablet após a correção. O B01 pode ter o aceite de campo fechado quando o mobile mostrar **Conexão registrada** e o estado da importação inicial, inclusive quando aguardar mapeamento. O Plano 02 permanece **concluído com ressalvas**.

### Reteste Pluggy no tablet em 25/11/2026

- **Contexto do reteste.** O Dev 1 corrigiu a validação da resposta de consentimentos Pluggy no backend, conforme relato do usuário. A seção anterior registra a falha observada antes da correção. A revisão exata do deploy usado no reteste não foi confirmada.
- **B01 mobile — aceite de campo aprovado.** A captura do tablet mostra **Conexão registrada**, estado **Conectada** e o aviso **A importação inicial está em andamento**. Na mesma conexão, após tocar em **Verificar de novo**, o usuário confirmou que o aviso mudou para **A importação inicial aguarda o mapeamento de contas**. Isso confirma a conclusão Pluggy e a atualização do estado da importação no mobile.
- **Pendências.** O reteste no web após a correção ainda não foi confirmado. A execução aguardava o mapeamento, que pertence à Parte 2 (P02-01). As demais divergências permanecem na seção 16, incluindo HU-008, OFX e o aviso de ambiguidade na deduplicação. O Plano 02 permanece **concluído com ressalvas**.
