# Roteiro de apresentação — Coinciente (Centralizador Financeiro Inteligente)

- **Público:** banca de avaliação externa.
- **Duração total:** 15:00, divididos em fala 10:00 (slides 1 a 10 e 12), demonstração ao vivo 3:00 (slide 11) e perguntas 2:00 (slide 13).
- **Premissa de dimensionamento:** 140 palavras por minuto, ritmo de apresentação acadêmica em português. A fala de cada slide fica dentro de ±15% do orçamento (0:30 ≈ 70 palavras; 0:45 ≈ 105; 1:00 ≈ 140; 1:30 ≈ 210; 2:00 ≈ 280). Os blocos de demonstração e de perguntas trazem falas de condução, não dimensionadas por palavra.
- **Apresentadores por papel:** Dev 1 Samuel Mota (backend); Dev 2 Miguel Candido (web e mobile); Dev 3 Thiago Marques (qualidade, contratos, integração e documentação). O mapeamento dos nomes aos papéis foi informado pela equipe em 27/11/2026; a documentação registra apenas os papéis Dev 1, Dev 2 e Dev 3 e os três nomes no rodapé dos documentos.
- **Contexto da banca (informado pela equipe em 27/11/2026, não consta na documentação):** Universidade Católica de Brasília (UCB), curso de Ciência da Computação, disciplina Soluções Computacionais, orientador Andre Gustavo Bastos Lima, apresentação em 27/11/2026. A documentação registra somente "Documentação acadêmica · UCB · 2026".
- **Data de referência dos fatos de estado:** os registros mais recentes da documentação datam de 26/11/2026 (evidências da Sprint 4 e plano de recuperação do Dev 3) e 27/11/2026 (Style Guide 2.3). Tudo o que descreve "estado atual" refere-se a essas datas.
- **Como usar este arquivo no Claude Design:** cole o arquivo inteiro. A seção "Guia visual para o Claude Design" é o sistema visual completo e substitui o acesso ao repositório. Cada bloco "## Slide N" vira um slide 16:9: a linha "Conteúdo on-slide" é o texto e os elementos que aparecem; a linha "Visual" é o layout e os tokens; a linha "Fala" vai para as notas do apresentador e não aparece no slide; a linha "Fontes" é rastreabilidade e não aparece no slide. Não invente cores, fontes, ícones, ilustrações ou efeitos fora do guia; onde o guia não cobre algo, o brief do slide diz o que fazer.

## Conflitos entre documentos

### Decididos pela equipe em 27/11/2026 (o roteiro segue a decisão)

| ID | Conflito | Decisão aplicada no roteiro |
|---|---|---|
| C1 | O plano da Sprint 2 (11/09/2026) adota "Sprint 1 considerada concluída"; o plano de recuperação do Dev 3 (23/11, atualizado em 26/11) mantém o Plano 04 "Bloqueado": testes focados e contratos de contas aprovados em 26/11, mas PostgreSQL/RLS em banco real e demonstração Auth0 com duas identidades ainda pendentes. Fontes: `docs/planejamento/sprint-02/Plano_Divisao_Atividades_Sprint_2.html`, `docs/planejamento/plano-recuperacao-dev3.md`. | Apresentar a Sprint 1 como implementada e testada, com aceite formal pendente. |
| C3 | A Arquitetura 1.6 implanta o web na Vercel e o backend no Google Cloud Run; as evidências dos clientes citam o web publicado no Render (`coinciente.onrender.com`, lacuna L-10) e a conclusão Pluggy falhando "inclusive no Render" (L-01). Fontes: `docs/arquitetura/arquitetura.html`, `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md`. | Vercel e Cloud Run são a implantação alvo da arquitetura; o Render é citado apenas como ambiente atual de demonstração. |
| C4 | O documento do dashboard (02/11/2026) fixa "nada de rosca, área preenchida ou eixo duplo"; o ADR-005 (06/11/2026) e o Style Guide 2.1 em diante adotam a rosca de gastos por categoria com a lista de valores ao lado. Fontes: `docs/planejamento/sprint-05/s5-dev2-dashboard-dados-e-definicoes.md`, `docs/arquitetura/adr-005-cores-categoria-rosca.html`, `docs/design/style-guide.html`. | Seguir o Style Guide 2.3: rosca com no máximo seis fatias e valores escritos; a regra do documento do dashboard é tratada como superada. |
| C8 | O plano de recuperação registra o mobile aprovado no Pluggy Sandbox em 25/11/2026 (achado B01) com reteste do web pendente; a evidência do Dev 1 do mesmo dia mantém aberta a lacuna L-01 (conclusão responde 503). Fontes: `docs/planejamento/plano-recuperacao-dev3.md`, `docs/planejamento/sprint-04/s4-06-dev1-backend-evidencias.md`. | Apresentar a conexão Pluggy como aprovada no Sandbox pelo mobile em 25/11 e o web como pendente de reteste (L-01). |

### Em aberto (o apresentador decide antes da banca)

| ID | Conflito | Fontes |
|---|---|---|
| C2 | A Sprint 4 foi planejada para entrega em 23/10/2026 (janela 10 a 23/10). Os contratos backend de investimentos (22/11) e alocação (24/11) e as evidências (23 a 26/11) datam de novembro; o plano do Dev 2 registra "Sprint atrasada" e o mobile sem nada da Sprint 4. A Sprint 5 tinha período inferido (24/10 a 06/11) e nunca confirmado. | `docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html`, `docs/planejamento/sprint-04/s4-03-dev1-contrato-investimentos.md`, `docs/planejamento/sprint-04/s4-04-dev1-contrato-alocacao.md`, `docs/planejamento/sprint-04/s4-dev2-plano-execucao.md` |
| C5 | A Arquitetura 1.6 afirma que "o documento de identidade visual ainda não existe"; o Style Guide está na versão 2.3 (27/11/2026). A afirmação da Arquitetura está desatualizada. | `docs/arquitetura/arquitetura.html`, `docs/design/style-guide.html` |
| C6 | Contagem de testes do mobile: 481 na main em 23/11/2026 e 469 na branch F5 em 25/11/2026; a diferença não foi reconciliada (lacuna L-08). | `docs/planejamento/sprint-04/s4-06-validacao-local-2026-11-23.md`, `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` |
| C7 | O frescor "atual" das posições de investimento foi fixado em 96 horas no backend sem aceite de Produto registrado (lacuna L-06); a recomendação D-08 do dashboard propõe 48 horas para contas conectadas. Objetos diferentes, prazos diferentes, nenhum aprovado por Produto. | `docs/planejamento/sprint-04/s4-03-dev1-contrato-investimentos.md`, `docs/planejamento/sprint-05/s5-dev2-dashboard-dados-e-definicoes.md` |

Nota: ADR-002 e ADR-003 citam o "Style Guide 1.1", o ADR-004 cita a versão 2.0, o ADR-005 a 2.1 e o guia publicado está na 2.3. É evolução documentada no histórico de versões do guia, não conflito; este roteiro usa a 2.3.

## Lacunas (marcadores [A CONFIRMAR] no roteiro)

- [A CONFIRMAR: período exato da Sprint 1. Os documentos mostram apenas o fechamento do baseline backend em 08/09/2026, dos clientes em 10/09/2026 e as especificações de 10 e 11/09/2026.]
- [A CONFIRMAR: período e estado da Sprint 5. A documentação registra a Visão geral em prévia atrás da flag OVERVIEW_PREVIEW no web (24/11/2026) e as definições D-01 a D-12 pendentes com Produto; HU-013 e HU-014 não têm registro de implementação.]
- [A CONFIRMAR: ambiente da demonstração. Recomendação: backend local em Docker e web em modo de desenvolvimento, porque o ambiente publicado no Render não carregou Contas, Movimentações e Investimentos em 26/11/2026 (L-10).]
- [A CONFIRMAR: build mobile disponível no aparelho para a demonstração. A documentação registra a branch F5 com login Auth0 pendente de development build.]
- [A CONFIRMAR: estado dos Planos 05 a 09 da recuperação do Dev 3; em 26/11/2026 o Plano 02 estava concluído com ressalvas, o 03 concluído, o 04 bloqueado e os demais não iniciados.]
- [A CONFIRMAR: status final dos ADR-002 a ADR-005, todos "proposto" na documentação.]
- [A CONFIRMAR: nenhum resultado de desempenho (RNF-006, P90 abaixo de dois segundos com 10.000 transações) foi medido; o roteiro apresenta como hipótese a validar.]
- [A CONFIRMAR: estado da conexão Pluggy no web no dia da banca (L-01 aberta em 25/11/2026).]

---

## Guia visual para o Claude Design

Este guia reúne tudo o que o Claude Design precisa para desenhar os slides. Cada item nomeia o arquivo de origem no repositório de documentação. Nada fora deste guia deve ser introduzido.

Fontes tipográficas usadas neste roteiro: Manrope, Newsreader.

### 1. Essência e princípios (fonte: docs/design/style-guide.html)

- **Coinciente** é o nome de exibição do Centralizador Financeiro Inteligente. Tagline: "Clareza para cuidar do que é seu." Direção visual da versão 2.x: "Instrumento de precisão".
- Três princípios: **Segurança** (institucional, não distante: ordem, precisão e consistência), **Clareza** (complexidade progressiva: o essencial primeiro, fonte e referência temporal sempre perto do dado) e **Tranquilidade** (calma sem passividade: espaço, ritmo e cores controladas; alertas firmes, nunca alarmistas).
- A experiência não promete enriquecer, não aconselha investimentos e nunca se comporta como banco.

### 2. Marca e logo (fontes: docs/design/style-guide.html, assets/coinciente-symbol.svg, assets/styles.css)

- **Nome:** Coin + consciente. "Coin" dá o território; "ciente" desloca a promessa para clareza e responsabilidade.
- **Símbolo:** dois "C" concêntricos (arcos abertos à direita) com um ponto no centro. As camadas representam fontes financeiras consolidadas; o ponto representa o usuário. Use o arquivo `assets/coinciente-symbol.svg` tal como está, com a cor de traço própria do arquivo (um verde de marca próximo ao Clareza); não recolorir, não distorcer, não rotacionar, não contornar e não aplicar sombra. Não substituir o verde por cores de status.
- **Assinatura principal (símbolo + nome):** usar em apresentações, entrada do produto e materiais institucionais. Este deck usa a assinatura na abertura e no encerramento; nos demais slides, símbolo isolado pequeno no canto é suficiente.
- **Wordmark no site de documentação:** "Coinciente" em Manrope, peso 760, espaçamento −0.035em; sobre fundo escuro a sílaba "Coin" recebe #73dfb5 (`.brand-name em` em assets/styles.css). O símbolo fica dentro de um quadrado de 40px com raio 13px e fundo rgba(61, 199, 149, .10) (`.brand-mark`).
- **Lockup de capa ("brand-stage"):** fundo Confiança #10251F, símbolo a 76px, nome em peso forte com espaçamento −0.065em e, abaixo, a tagline em caixa alta, 0.78rem, peso 650, espaçamento 0.08em, cor #a9c6bb. Atrás do lockup, um círculo de 340px com borda 1px rgba(85, 214, 164, .14) e dois halos de 70px e 140px em rgba(85, 214, 164, .035) e rgba(85, 214, 164, .025).
- **Área de proteção:** ao redor da marca, no mínimo quatro vezes a largura do ponto central do símbolo.

### 3. Cores e temas (fontes: assets/style-guide-2.css, docs/design/style-guide.html)

A interface é desenhada em neutros frios, como um instrumento. O verde **Consciência** é sinal, não superfície: aparece só em ação primária, foco, item selecionado e no sinal "+" de entradas. Cor rara vira informação; cor em tudo vira ruído. Texto mantém no mínimo 4,5:1 em todas as superfícies; bordas de campo, 3:1.

**Tema claro (`.sg2-light`, assets/style-guide-2.css):**

| Token | Valor | Uso |
|---|---|---|
| `--sg-bg` | #F6F7F7 | Fundo da página |
| `--sg-surface` | #FFFFFF | Superfície de painéis e tabelas |
| `--sg-sunken` | #EFF1F1 | Rebaixado: lateral, cabeçalhos de dia, trilhos |
| `--sg-line` | #E2E5E5 | Linha divisória de 1px |
| `--sg-line-strong` | #C9CFCE | Linha forte: bordas de molduras e controles |
| `--sg-input` | #808A87 | Borda de campo |
| `--sg-text` | #0F1413 | Texto principal (18,6:1) |
| `--sg-text-2` | #434D4A | Texto secundário (8,7:1) |
| `--sg-text-3` | #5F6966 | Texto terciário, metadados e rótulos (≥ 5,0:1) |
| `--sg-signal` | #087A55 | Consciência: ação primária, foco, seleção, sinal "+" (≥ 4,7:1) |
| `--sg-on-signal` | #FFFFFF | Texto sobre o sinal |
| `--sg-negative` | #B5473F | Negativo |
| `--sg-warning` | #9A5D0F | Atenção |
| `--sg-info` | #2B6F89 | Informação |
| `--sg-ramp-1` a `--sg-ramp-4` | #0F1413, #434D4A, #808A87, #C9CFCE | Rampa neutra de gráficos |

**Tema escuro (`.sg2-dark`, assets/style-guide-2.css):**

| Token | Valor | Uso |
|---|---|---|
| `--sg-bg` | #0A0C0C | Fundo |
| `--sg-surface` | #101313 | Superfície |
| `--sg-sunken` | #0D1010 | Rebaixado |
| `--sg-raised` | #161A1A | Elevado (menus) |
| `--sg-line` | #232828 | Linha |
| `--sg-line-strong` | #323939 | Linha forte |
| `--sg-input` | #5E6865 | Borda de campo |
| `--sg-text` | #E9EDEC | Texto |
| `--sg-text-2` | #AAB3B0 | Texto secundário |
| `--sg-text-3` | #87918E | Texto terciário |
| `--sg-signal` | #55D6A4 | Clareza: o verde sinal do tema escuro (≥ 9,6:1) |
| `--sg-on-signal` | #07140F | Texto sobre o sinal |
| `--sg-negative` | #FF9188 | Negativo |
| `--sg-warning` | #F3B866 | Atenção |
| `--sg-info` | #75C4DF | Informação |
| `--sg-ramp-1` a `--sg-ramp-4` | #E9EDEC, #AAB3B0, #6B7673, #3A4242 | Rampa neutra de gráficos |

**Cores de marca (docs/design/style-guide.html):** Confiança #10251F, só em ativos institucionais (capa, encerramento, brand-stage); Clareza #55D6A4, o verde sinal do tema escuro. Positivo, negativo, atenção e informação só significam algo junto de texto, sinal ou marcador.

**Cores de categoria (docs/design/style-guide.html, versão 2.2; `--sg-cat-1` a `--sg-cat-6` em assets/style-guide-2.css):** doze tons só para dizer qual categoria é qual, nunca estado, ganho ou perda. Cor fixa por categoria pela ordem de criação; da 13ª em diante, neutra.

| Nº | Nome | Claro | Escuro |
|---|---|---|---|
| 1 | Azul | #3B72C4 | #4A80D6 |
| 2 | Terracota | #D0683A | #D0683A |
| 3 | Verde-azulado | #1F9A8A | #219A89 |
| 4 | Âmbar | #D39A1A | #B88518 |
| 5 | Rosa | #C95B8A | #CC5F8E |
| 6 | Violeta | #6C5BD0 | #8576E0 |
| 7 | Ocre | #A8742A | #A8742A |
| 8 | Índigo | #4555A8 | #6C7AC3 |
| 9 | Coral | #D1495B | #D35162 |
| 10 | Ameixa | #9A4AA6 | #AD60B8 |
| 11 | Oliva | #6E7D16 | #768618 |
| 12 | Magenta | #C0398F | #CA4D9D |
| — | Outras (neutra) | #808A87 | #6B7673 |

A ordem foi validada para daltonismo em pares vizinhos nos dois temas. O âmbar fica abaixo de 3:1 sobre o branco, por isso nome e valor vão sempre escritos ao lado da cor.

**Tema do site de documentação (assets/styles.css), para referência apenas:** o site que publica estes documentos usa `--theme-background` #f2f6f4, `--theme-foreground` #14231e, `--theme-muted` #60736b, `--theme-surface` #ffffff, `--theme-surface-soft` #f7faf8, `--theme-body-text` #354a42, `--theme-primary` #087a55, `--theme-primary-bright` #22b983, `--theme-primary-hover` #056746, `--theme-nav` e `--theme-accent-dark` #10251f, `--theme-warning` #a86512; no tema escuro, fundo #0c1714, texto #edf6f2, superfície #13231e, primário #55d6a4. Os slides devem usar a paleta do produto (tabelas acima); o tema do site só serve se um slide quiser reproduzir a aparência da biblioteca de documentação.

**Recomendação para projeção:** slides de conteúdo no tema claro (fundo `--sg-bg` #F6F7F7, painéis `--sg-surface` #FFFFFF); abertura e encerramento no brand-stage #10251F. Não misturar os dois temas no mesmo slide.

### 4. Tipografia (fontes: docs/design/style-guide.html, assets/style-guide-2.css, assets/styles.css)

- **Newsreader** (serifa, eixo óptico 6 a 72, pesos 400 a 600): restrita à marca, títulos institucionais e o próprio guia. Nunca em números, rótulos, botões ou listas. No deck: título de cada slide e frases de marca.
- **Manrope** (sans, pesos 400 a 800): toda a interface, inclusive números grandes. Valores usam algarismos tabulares. No deck: todo o corpo, tabelas, números, rótulos e legendas.
- Sem outras famílias. Sem itálico decorativo.

| Papel | Especificação | Onde no deck |
|---|---|---|
| Marca | Newsreader 400, espaçamento −0.035em, entrelinha 1.02 | Tagline na abertura |
| Título institucional | Newsreader 400 a 450, espaçamento −0.035em, entrelinha 1.03 a 1.04 | Título dos slides |
| Subtítulo institucional | Newsreader 550, espaçamento −0.02em | Subtítulos de seção dentro de um slide |
| Eyebrow / rótulo de seção | Manrope 800, 0.74 a 0.76rem, caixa alta, espaçamento 0.16 a 0.18em, cor `--sg-signal` | Linha pequena acima do título ("01 · Essência") |
| Número grande | Manrope 600, 28 a 40px, tabular, espaçamento −0.02em, entrelinha 1.1 | Faixa de números |
| Título de componente | Manrope 600, 20px, entrelinha 1.3, espaçamento −0.01em | Cabeçalhos de painel |
| Corpo | Manrope 500, 14px, entrelinha 1.45 a 1.5, cor `--sg-text-2` | Texto corrido e bullets |
| Metadado | Manrope 500, 12px, tabular, cor `--sg-text-3` | Linha de metadados, legendas, fontes |
| Rótulo (micro) | Manrope 650, 11px, caixa alta, espaçamento 0.06em, cor `--sg-text-3` | Cabeçalhos de coluna e de grupo |
| Marcador | Manrope 600, 12px, cor `--sg-text-2` | Estados |

Para o deck, escale os tamanhos proporcionalmente ao slide mantendo a hierarquia (o guia não define tamanhos de projeção).

### 5. Espaçamento, layout e componentes (fontes: docs/design/style-guide.html, assets/style-guide-2.css)

- **Grade:** 4px; ritmo de 8px; divisórias de 1px em `--sg-line`. A estrutura vem de linhas finas e alinhamento rigoroso, não de cartões, sombras ou cor.
- **Raios:** 6px em controles, 8px em painéis, 12px em sobreposições. Elevação é feita por linha; sombra neutra só em menus e diálogos.
- **Painel:** borda 1px `--sg-line`, raio 8px, fundo `--sg-surface`; cabeçalho de 36px mínimo com padding 8px 12px e borda inferior; corpo com padding 12px.
- **Tabela:** cabeçalho de coluna em rótulo micro, altura 32px; linhas de 40px no desktop (48px no toque), padding 8px 12px, borda inferior 1px; valores tabulares alinhados à direita; linha de grupo ("dia") com 28px, fundo `--sg-sunken`, 12px peso 650.
- **Faixa de números:** valores separados por linhas finas, sem cartões: borda superior e inferior 1px, cada número com padding 14px 16px e borda esquerda 1px a partir do segundo; rótulo micro acima, valor em número grande, metadado abaixo.
- **Marcador:** quadrado de 6px (raio 1px) mais texto, gap 6px, sem fundo e sem pílula. Tons: sinal `--sg-signal`, atenção `--sg-warning`, negativo `--sg-negative`, informação `--sg-info`, neutro `--sg-text-3`.
- **Linha de metadados:** legenda técnica logo abaixo do dado que qualifica, formato "Origem · ref. DD/MM/AAAA HH:MM · Conta".
- **Botão primário:** 32px de altura, padding 0 12px, raio 6px, fundo `--sg-signal`, texto `--sg-on-signal`, Manrope 650 13px. **Secundário:** borda 1px `--sg-line-strong`, fundo `--sg-surface`, texto `--sg-text`.
- **Controle segmentado (período):** moldura com padding 2px, borda 1px `--sg-line-strong`, raio 6px, fundo `--sg-sunken`; item com padding 4px 10px, raio 4px, 12px peso 600; item ativo com fundo `--sg-surface`.
- **Navegação lateral:** 196px, fundo `--sg-sunken`, borda direita 1px; itens de 32px, raio 6px, 13px peso 600 em `--sg-text-2`; item ativo com fundo `--sg-surface`, contorno interno 1px e barra vertical de 2px em `--sg-signal` à esquerda. Grupos: Visão geral; Registros (Movimentações, Contas); Patrimônio (Investimentos, Bens e passivos); Organização (Categorias, Regras).
- **Barra superior:** 44px, borda inferior 1px, marca à esquerda (símbolo 20px + nome 13px peso 750), caminho em `--sg-text-3`, metadado à direita.
- **Site de documentação (assets/styles.css), só para referência:** chips em pílula (raio 999px, borda `--line`), cartões com raio 16 a 20px e sombra 0 12px 32px rgba(25, 54, 44, .07). Não usar nos slides de produto.

### 6. Fundos decorativos (fontes: docs/design/style-guide.html, assets/styles.css)

- Regra geral: sem gradientes, sem fundos verdes, sem estética de criptomoeda.
- **Exceção 1, faixa de destaque:** gradiente suave, única exceção aprovada na versão 2.2 (o guia não publica os valores do gradiente; se usar, manter sutil e neutro-esverdeado, nunca sob tabelas ou números).
- **Exceção 2, ondas decorativas (versão 2.3):** ondas verdes em três camadas com deriva muito lenta (70, 105 e 150 segundos) na base da lateral e no canto superior do conteúdo, atrás de tudo e nunca sob tabelas ou números; intensidade menor na lateral para manter 4,5:1 no texto secundário; paradas em "reduzir movimento"; só desktop e tablet. No deck: no máximo um canto por slide, estáticas, atrás do conteúdo, nunca atrás de tabelas, números ou gráficos. O guia não publica os valores exatos das ondas; derive-as do verde sinal com opacidade baixa.
- **Brand-stage:** fundo #10251F com anéis concêntricos (seção 2). Usar na abertura e no encerramento.
- **Site de documentação:** o corpo usa um gradiente radial muito suave do primário a 12% no canto superior esquerdo sobre #f2f6f4. Não usar nos slides de produto.

### 7. Gráficos e cores de categoria (fontes: docs/arquitetura/adr-004-graficos-animacao-web.html, docs/arquitetura/adr-005-cores-categoria-rosca.html, docs/design/style-guide.html, assets/style-guide-2.css)

- **Vocabulário:** barras pareadas por mês (entradas em `--sg-text`, saídas em `--sg-ramp-3`; mês parcial com opacidade 0.45), linha com pontos (linha 1,5px em `--sg-text`, ponto com fundo `--sg-surface`, último ponto em `--sg-signal`), barras horizontais ordenadas (8px, raio 1px), barra 100% estática (10px, gap 2px, segmento "não classificado" hachurado a 135° em `--sg-line-strong`) e rosca.
- **Grade e eixo:** grade tracejada (traço 2, espaço 3) em `--sg-line`; eixo em `--sg-line-strong`; rótulos em Manrope 500 10px `--sg-text-3`, tabulares.
- **Minigráfico (sparkline):** 80×24px, traço 1,5px em `--sg-text-3`, trecho parcial tracejado (3 3), último ponto em `--sg-signal` ou aberto quando o período está em andamento.
- **Rosca (ADR-005):** 128px, raio 52, traço 14; trilho em `--sg-sunken`; no máximo seis fatias com cor de categoria, excedente em "Outras" (neutra); "A revisar" hachurada em `--sg-warning`, sempre por último; total no centro; lista ao lado com cor, nome, valor, percentual e barrinha de 4px. Nunca rosca sem os valores escritos.
- **Regras:** todo gráfico tem tabela ou resumo em texto com os valores; percentuais calculados em centavos; a cor de categoria nunca indica estado; variação contra o mês anterior não usa verde nem vermelho; nenhum número anima, nenhuma barra cresce ao carregar. Nada de área preenchida ou eixo duplo.
- **Fluxo, números e estados** continuam neutros.

### 8. Movimento (fonte: docs/design/style-guide.html)

- O movimento existe para mostrar de onde algo veio, o que mudou e para onde a atenção vai; nunca decora. Valores financeiros nunca crescem, contam ou deslizam. Com "reduzir movimento", sai todo deslocamento e escala; ficam opacidade e cor.
- Tokens: `--motion-feedback` 120ms; `--motion-hover` 180ms; `--motion-popover` 160ms; `--motion-reveal` 240ms; `--motion-settle` 320ms; `--motion-intro` 600ms; `--motion-arrival` 1600ms.
- Curvas: `--ease-out` cubic-bezier(0.23, 1, 0.32, 1); `--ease-in-out` cubic-bezier(0.77, 0, 0.175, 1); `--ease-drawer` cubic-bezier(0.32, 0.72, 0, 1).
- No deck: transição entre slides somente por opacidade (crossfade) em 180ms com `--ease-out`, como a navegação do app (ADR-002). Sem entradas de texto voando, sem números contando.

### 9. Proveniência e estados (fonte: docs/design/style-guide.html)

- Todo dado diz de onde vem e quando: origem (Manual, OFX ou Pluggy), data de referência (DD/MM/AAAA ou "Hoje"/"Ontem") e frescor (atual, desatualizado ou indisponível), sempre em texto e ícone, nunca só cor.
- Estados de sincronização (contrato C-03): "Na fila" (neutro), "Sincronizando" (informação), "Ação necessária" (atenção), "Concluída" (sinal), "Concluída em parte" (atenção), "Falhou" (negativo). O dado anterior continua legível durante a sincronização.

### 10. Voz (fonte: docs/design/style-guide.html)

- Humana no tom, precisa no conteúdo. Explica sem infantilizar e orienta sem aconselhar.
- Prefira "Sua conexão precisa ser atualizada" a "Erro de integração"; prefira "Projeção baseada nestas premissas" a "Você terá".
- Sem promessas de rentabilidade ou enriquecimento. Sem linguagem de ganho.

### 11. Faça e evite (fontes: docs/design/style-guide.html, docs/arquitetura/adr-005-cores-categoria-rosca.html)

Faça:
- Mostre período, fonte e data de referência como linha de metadados.
- Use tabelas com colunas alinhadas para comparar valores.
- Reserve o verde para ação, seleção, foco e o sinal "+".
- Diferencie ação, informação e alerta com texto e marcador.
- Mostre valores em Manrope 600 com algarismos tabulares.
- Mostre alocação em barras estáticas acompanhadas de tabela e resumo em texto.
- Mostre posições sem classe como "Não classificado".

Evite:
- Promessas de rentabilidade ou enriquecimento.
- Gradientes, fundos verdes e estética de criptomoeda (exceções: a faixa de destaque e as ondas decorativas).
- Grades de cartões de KPI soltos e pílulas coloridas em toda linha.
- Rosca com mais de seis fatias ou sem os valores escritos ao lado; cor de categoria como estado.
- Esconder indisponibilidade ou defasagem do dado.
- Barras que crescem ou números que contam ao carregar.
- Inferir uma classe que a fonte não informou.

### 12. O que o guia não cobre (e o que fazer no deck)

- **Iconografia:** o guia não define um conjunto de ícones; a interface usa texto e marcador. No deck, não introduzir ícones ilustrativos; usar o marcador de 6px, números em Manrope e o símbolo da marca.
- **Ilustrações e fotos:** não existem no guia. Não usar.
- **Tamanhos de projeção:** não definidos; escalar a hierarquia tipográfica proporcionalmente.
- **Diagramas de arquitetura:** o guia não os cobre. Desenhar com caixas de borda 1px `--sg-line-strong`, raio 8px, fundo `--sg-surface`, texto Manrope 600 14px, setas de 1px em `--sg-text-3` e rótulos em metadado; sem cor de preenchimento, sem sombra; destacar no máximo um elemento com `--sg-signal`.
- **Capturas de tela do produto:** o guia traz dois mockups (Visão geral no tema claro e Fontes de dados no tema escuro) e um exemplo mobile. Quando um slide pedir uma captura, reproduzir esses mockups com os componentes da seção 5.

---

## Slide 1 — Coinciente, abertura
- Tempo: 0:30 (acumulado: 0:30)
- Quem fala: Dev 3, Thiago Marques
- Conteúdo on-slide: assinatura principal (símbolo + "Coinciente"); tagline "Clareza para cuidar do que é seu."; linha "Centralizador Financeiro Inteligente · MVP acadêmico"; linha de metadados "UCB · Ciência da Computação · Soluções Computacionais · 27/11/2026" (dados informados pela equipe); nomes "Samuel Mota · Miguel Candido · Thiago Marques".
- Fala: Boa tarde à banca. Somos Samuel Mota, Miguel Candido e Thiago Marques, e vamos apresentar o Coinciente, nome de exibição do Centralizador Financeiro Inteligente. É uma aplicação analítica de finanças pessoais para uma pessoa, construída como MVP acadêmico com dados fictícios. Nos próximos quinze minutos vamos mostrar o problema, a solução, a arquitetura, o que entregamos em quatro sprints, uma demonstração ao vivo e, ao final, abrimos para perguntas.
- Visual: brand-stage da seção 2 do guia: fundo Confiança → #10251F ocupando o slide inteiro; círculo de 340px com borda rgba(85, 214, 164, .14) e halos atrás do lockup; lockup centralizado com o símbolo a 76px e "Coinciente" em Manrope peso forte, espaçamento −0.065em, cor #FFFFFF; tagline em Newsreader 400 abaixo, cor #FFFFFF; linha institucional e nomes em metadado Manrope 12 a 14px, cor #a9c6bb, caixa alta com espaçamento 0.08em. Sem gradiente, sem ondas.
- Fontes: `docs/design/style-guide.html` (nome de exibição, tagline, lockup), `docs/produto/visao.html` (introdução; rodapé "Documentação acadêmica · UCB · 2026" e os três nomes). Curso, disciplina, orientador e data: informados pela equipe em 27/11/2026, não constam na documentação.

## Slide 2 — Equipe e papéis
- Tempo: 0:30 (acumulado: 1:00)
- Quem fala: Dev 3, Thiago Marques
- Conteúdo on-slide: eyebrow "Equipe"; título "Três papéis, um produto"; três colunas: "Dev 1 · Samuel Mota — backend: NestJS, domínio, API REST, Prisma, PostgreSQL, autorização e RLS"; "Dev 2 · Miguel Candido — web Next.js e mobile Expo, clientes tipados do OpenAPI, estados da interface"; "Dev 3 · Thiago Marques — critérios de aceite, testes, contrato OpenAPI, isolamento, integração, documentação e evidências"; rodapé em metadado: "Responsabilidade principal, não propriedade exclusiva: revisão cruzada e evidência reproduzível em toda atividade".
- Fala: O projeto foi conduzido por três desenvolvedores com responsabilidades principais, mas não exclusivas. O Samuel, como Dev 1, cuidou do backend: domínio, API, persistência, autorização e isolamento. O Miguel, como Dev 2, cuidou das experiências web e mobile, independentes entre si. Eu, Thiago, como Dev 3, cuidei de critérios de aceite, testes, contratos, integração e evidências. Toda atividade passou por revisão de outro integrante e precisou de evidência reproduzível antes de ser considerada pronta.
- Visual: tema claro; fundo `--sg-bg` → #F6F7F7; eyebrow em Manrope 800 caixa alta `--sg-signal` → #087A55; título em Newsreader 400 `--sg-text` → #0F1413; três colunas separadas por linhas verticais de 1px `--sg-line` → #E2E5E5 (padrão da faixa de números, sem cartões); nome do papel em rótulo micro `--sg-text-3` → #5F6966, nome da pessoa em Manrope 600 20px, responsabilidades em corpo Manrope 500 `--sg-text-2` → #434D4A; rodapé em metadado. Símbolo isolado pequeno no canto superior esquerdo.
- Fontes: `docs/planejamento/sprint-01/Plano_Divisao_Atividades_Sprint_1.html` (estrutura de responsabilidades dos três desenvolvedores e regra de revisão cruzada), `docs/produto/visao.html` (rodapé com os três nomes). Mapeamento nome ↔ papel informado pela equipe em 27/11/2026.

## Slide 3 — O problema: vida financeira fragmentada
- Tempo: 1:00 (acumulado: 2:00)
- Quem fala: Dev 2, Miguel Candido
- Conteúdo on-slide: eyebrow "Contexto"; título "Vários bancos, cartões e corretoras. Nenhuma visão única."; três consequências em lista com marcador: "Informação fragmentada entre instituições", "Retrabalho para consolidar", "Dificuldade de entender gastos, investimentos e patrimônio líquido"; linha de metadados: "Público da marca: pessoas de 20 a 30 anos começando a organizar a vida financeira"; frase de fechamento em Newsreader: "Coin + consciente. Dinheiro compreendido."
- Fala: Quem usa vários bancos, cartões e corretoras convive com informação fragmentada. Cada instituição mostra só a sua parte, e juntar tudo vira tarefa da própria pessoa. O resultado é retrabalho e dificuldade real de entender três coisas simples: quanto gasta, quanto tem investido e qual é o seu patrimônio líquido. O Documento de Visão parte exatamente desse contexto. A proposta é reduzir essa fragmentação sem assumir o papel de banco, de iniciador de pagamentos ou de consultor financeiro. O público que a marca escolheu são pessoas de vinte a trinta anos que estão começando a organizar a vida financeira e querem continuar no mesmo produto quando as análises ficarem mais sofisticadas. Por isso o nome: Coin mais consciente. Dinheiro compreendido, não apenas somado. E por isso a promessa visual é clareza para cuidar do que é seu.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7. Metade esquerda: eyebrow, título em Newsreader 400 `--sg-text` → #0F1413, lista com marcador neutro (quadrado 6px `--sg-text-3` → #5F6966) e corpo em `--sg-text-2` → #434D4A. Metade direita: um painel (borda 1px `--sg-line` → #E2E5E5, raio 8px, fundo `--sg-surface` → #FFFFFF) com uma tabela de três linhas "Banco A · Cartão B · Corretora C", cada uma com origem e referência diferentes na linha de metadados, ilustrando a fragmentação; sem valores de rentabilidade. Frase de fechamento em Newsreader 550 na base. Ondas decorativas estáticas permitidas em um canto, atrás do texto, nunca atrás do painel.
- Fontes: `docs/produto/visao.html` (contexto de negócio; não assumir papel de banco, iniciador de pagamentos ou consultor), `docs/design/style-guide.html` (público de 20 a 30 anos; nome Coin + consciente; tagline).

## Slide 4 — O que o produto é e o que nunca será
- Tempo: 1:00 (acumulado: 3:00)
- Quem fala: Dev 2, Miguel Candido
- Conteúdo on-slide: eyebrow "Visão"; título "Analítico, individual, com dados fictícios"; coluna "É": "Aplicação analítica web e mobile", "Um tenant = exatamente uma pessoa", "Integra registros manuais, OFX e Pluggy Sandbox", "Dashboard, investimentos, patrimônio líquido e projeções rastreáveis"; coluna "Nunca será": "Banco ou iniciador de pagamentos: sem Pix, transferência real ou ordem", "Consultor: projeções com premissas, horizonte e aviso", "Compartilhado: sem famílias, organizações ou administrador"; coluna "Fica para a evolução SaaS": "Dados reais, staging e produção separados, LGPD, backups, RPO 24h e RTO 8h".
- Fala: A declaração de visão resume: para usuários individuais que precisam consolidar a vida financeira, o Coinciente é uma aplicação analítica, web e mobile, que integra registros manuais, extratos OFX e dados do Pluggy Sandbox para oferecer dashboard, investimentos, patrimônio líquido e projeções rastreáveis. Diferentemente de uma aplicação bancária, o produto não inicia pagamentos nem movimenta fundos. Três limites definem o produto. Primeiro, cada tenant é o espaço financeiro de exatamente uma pessoa: não há contas compartilhadas, famílias, organizações nem administrador. Segundo, o MVP usa somente dados fictícios; dados reais, cobrança, notificações e painel administrativo ficam para a evolução SaaS, que exigirá staging e produção separados, LGPD, backups e metas de recuperação. Terceiro, nenhuma função pode iniciar Pix, transferência real ou ordem; transferências cadastradas são apenas registros contábeis entre contas. E toda projeção vem com premissas, horizonte e aviso de que não é aconselhamento.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; três colunas separadas por linhas de 1px `--sg-line` → #E2E5E5, sem cartões; cabeçalho de cada coluna em rótulo micro `--sg-text-3` → #5F6966; itens em corpo `--sg-text-2` → #434D4A com marcador: coluna "É" com marcador sinal `--sg-signal` → #087A55, coluna "Nunca será" com marcador negativo `--sg-negative` → #B5473F, coluna "Evolução SaaS" com marcador informação `--sg-info` → #2B6F89. Título em Newsreader 400 `--sg-text` → #0F1413. Sem ícones.
- Fontes: `docs/produto/visao.html` (declaração da visão; partes interessadas; escopo; evolução SaaS obrigatória), `docs/produto/prd.html` (RN-001, RN-005, RN-012, RN-017; fora do MVP).

## Slide 5 — Escopo do MVP: 15 histórias em quatro frentes
- Tempo: 0:45 (acumulado: 3:45)
- Quem fala: Dev 2, Miguel Candido
- Conteúdo on-slide: eyebrow "Escopo"; título "Quinze histórias, todas Must"; tabela em quatro grupos: "Centralização e registro: HU-001 autenticar · HU-002 contas · HU-003 receitas, despesas e transferências contábeis · HU-005 categorizar · HU-006 regras pessoais · HU-012 bens, financiamentos e passivos"; "Ingestão: HU-004 importar OFX · HU-007 conectar Pluggy Sandbox · HU-008 sincronizar"; "Análise patrimonial: HU-010 dashboard · HU-009 investimentos · HU-011 alocação · HU-013 patrimônio líquido"; "Projeções: HU-014 determinísticas e não prescritivas"; "Transversal: HU-015 trilhas técnicas de auditoria"; rodapé em metadado: "Fora do MVP: PDF, impostos, alertas, notificações, Stripe, dados reais, painel administrativo".
- Fala: O PRD fecha o MVP em quinze histórias de usuário, todas com prioridade Must, organizadas em quatro frentes. Centralização e registro: autenticação individual, contas manuais, receitas, despesas e transferências contábeis, categorias e regras pessoais, bens, financiamentos e passivos. Ingestão: importação OFX com prévia e deduplicação, conexão e sincronização diária ou manual com o Pluggy Sandbox. Análise patrimonial: dashboard consolidado, posições de investimento, alocação por classe e instituição e cálculo de patrimônio líquido. Projeções: determinísticas, transparentes e não prescritivas. Atravessando tudo, trilhas técnicas de auditoria. Fora do MVP ficam PDF, impostos, alertas, Stripe, dados reais e painel administrativo.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; uma tabela no padrão da seção 5 do guia dentro de um painel (`--sg-surface` → #FFFFFF, borda `--sg-line` → #E2E5E5, raio 8px): cada frente é uma linha de grupo (28px, fundo `--sg-sunken` → #EFF1F1, 12px peso 650 `--sg-text-2` → #434D4A) seguida das histórias em linhas de 40px, código "HU-00x" em metadado tabular `--sg-text-3` → #5F6966 e nome em corpo; coluna "Prioridade" à direita com o texto "Must" em marcador neutro. Rodapé em metadado. Título em Newsreader 400.
- Fontes: `docs/produto/prd.html` (lista de histórias do MVP HU-001 a HU-015; fora do MVP), `docs/produto/visao.html` (visão das frentes do produto).

## Slide 6 — Arquitetura e decisões
- Tempo: 2:00 (acumulado: 5:45)
- Quem fala: Dev 1, Samuel Mota
- Conteúdo on-slide: eyebrow "Arquitetura"; título "Um serviço, oito módulos, isolamento no banco"; diagrama: caixas "Web Next.js (Vercel)" e "Mobile Expo (EAS)" à esquerda, seta "HTTPS REST /api/v1 · OpenAPI" para a caixa central "Backend NestJS (Cloud Run) · Identity · Accounts · Transactions · Ingestion · Investments · Patrimony · Analytics · Audit", e desta para "PostgreSQL no Neon · tenant_id + RLS", "Auth0", "Pluggy Sandbox", "QStash", "Cloudflare R2"; coluna lateral "Decisões": "Modular Clean/Hexagonal pragmática: domínio e aplicação sem NestJS, Prisma, Auth0 ou HTTP", "OpenAPI do backend gera um cliente tipado por repositório; Zod nas bordas", "RLS fail-closed: contexto de tenant local à transação, papéis NOBYPASSRLS, FORCE RLS", "QStash para agendas, jobs longos e retries; jobs só com identificadores", "Fora: Redis, CQRS, Event Sourcing, GraphQL, gRPC, monorepo"; rodapé em metadado: "ADRs de frontend: 002 View Transitions · 003 expo-router · 004 visx + Motion · 005 cores de categoria · Hoje a demonstração roda no Render; Vercel e Cloud Run são a implantação alvo".
- Fala: A arquitetura é modular, Clean e Hexagonal de forma pragmática, implantada inicialmente como um único serviço NestJS em container no Google Cloud Run. Um serviço só, mas com oito módulos de negócio: Identity, Accounts, Transactions, Ingestion, Investments, Patrimony, Analytics e Audit. Cada módulo é dono das suas tabelas e nenhum acessa o repositório interno de outro; a comunicação acontece por interfaces públicas da camada de aplicação. Domínio e aplicação não importam NestJS, Prisma, Auth0 nem HTTP; isso fica nos adapters. Os clientes são dois repositórios independentes: Next.js na Vercel e React Native com Expo. Eles não compartilham componentes nem código; o que compartilham é o contrato OpenAPI, gerado pelo backend sob a rota api v1, do qual cada cliente gera seu próprio cliente tipado. Zod valida nas bordas. A identidade é do Auth0, por OAuth 2 e OpenID Connect; o backend valida o JWT e resolve usuário e tenant. A decisão de segurança mais importante está no ADR de RLS: PostgreSQL no Neon é a fonte de verdade, com schema compartilhado, tenant id ou relação de propriedade em todo registro e Row Level Security forçada. O adapter abre uma transação curta, define o tenant corrente com set config local à transação e só então consulta. Contexto ausente nega acesso; o papel de runtime não pode ignorar RLS. É defesa em profundidade: autorização no NestJS mais política no banco. Trabalho assíncrono, como a sincronização diária, vai pelo QStash com jobs que carregam só identificadores. Arquivos ficam no Cloudflare R2. Ficaram de fora, por decisão, Redis, CQRS, Event Sourcing, GraphQL e monorepo. No frontend, quatro ADRs registram View Transitions na web, expo-router no mobile, gráficos com visx e Motion, e cores fixas por categoria. Hoje a demonstração roda no Render; Vercel e Cloud Run continuam sendo a implantação alvo.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7. Dois terços à esquerda: diagrama conforme a seção 12 do guia (caixas com borda 1px `--sg-line-strong` → #C9CFCE, raio 8px, fundo `--sg-surface` → #FFFFFF, texto Manrope 600 14px `--sg-text` → #0F1413, módulos listados dentro da caixa central em metadado `--sg-text-3` → #5F6966, setas de 1px `--sg-text-3`, rótulos das setas em metadado); a caixa "PostgreSQL · tenant_id + RLS" é o único elemento destacado, com borda `--sg-signal` → #087A55 e barra vertical de 2px no sinal, como o item ativo da navegação. Um terço à direita: lista "Decisões" com marcador neutro e corpo `--sg-text-2` → #434D4A, separada do diagrama por linha vertical de 1px `--sg-line` → #E2E5E5. Rodapé em metadado. Sem ícones de nuvem, sem logotipos de terceiros, sem preenchimento colorido.
- Fontes: `docs/arquitetura/arquitetura.html` (decisões arquiteturais; módulos; camadas; API e validação; decisões do MVP; visão de dados; implantação; fora da arquitetura ativa), `docs/arquitetura/adr-rls-postgresql.html` (contexto local à transação, fail-closed, papéis, FORCE RLS), `docs/arquitetura/modelo-dados-identity-accounts.html` (um tenant, um user), `docs/arquitetura/adr-002-view-transitions-web.html`, `docs/arquitetura/adr-003-navegacao-movimento-mobile.html`, `docs/arquitetura/adr-004-graficos-animacao-web.html`, `docs/arquitetura/adr-005-cores-categoria-rosca.html`, `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` (web publicado no Render; decisão C3).

## Slide 7 — Entregas por sprint
- Tempo: 1:30 (acumulado: 7:15)
- Quem fala: Dev 1, Samuel Mota
- Conteúdo on-slide: eyebrow "Entregas"; título "Da autenticação ao patrimônio"; linha do tempo horizontal com seis marcos: "Sprint 1 · até 10/09/2026 [A CONFIRMAR: período exato] · Auth0, contas manuais, auditoria, isolamento por tenant · implementada e testada, aceite formal pendente"; "Sprint 2 · 11 a 25/09 · receitas, despesas, transferências contábeis, categorias, regras, idempotência"; "Sprint 3 · 25/09 a 09/10 · OFX com prévia, duplicidades e validade de 24 h; conexão Pluggy Sandbox com consentimento, importação inicial e mapeamento de contas"; "Sprint 4 · planejada até 23/10, backend concluído em novembro · sincronização (seis estados, agenda diária 12h), investimentos, alocação, bens e passivos · web com as telas; mobile sem telas da Sprint 4"; "Refatoração do frontend · a partir de 22/10 · Style Guide 1.0 → 2.3, ADRs 002 a 005, tokens de movimento"; "Sprint 5 · em andamento · dashboard em prévia [A CONFIRMAR: período e estado]".
- Fala: Trabalhamos em sprints curtas, cada uma com plano, critérios de aceite e evidências. A Sprint 1 entregou a primeira fatia vertical: login com Auth0, criação, listagem, edição e desativação de contas manuais, auditoria e isolamento por tenant nos três repositórios; o baseline fechou entre oito e dez de setembro. A Sprint 2, de onze a vinte e cinco de setembro, trouxe receitas, despesas e transferências contábeis, categorização com resultado incerto explícito, regras pessoais com precedência determinística, idempotência e auditoria. A Sprint 3, até nove de outubro, trouxe a importação OFX com prévia, mapeamento de conta, duplicidades e prévia válida por vinte e quatro horas, e a conexão Pluggy Sandbox com consentimento, importação inicial e mapeamento explícito de contas. A Sprint 4 foi planejada para fechar em vinte e três de outubro, mas o backend concluiu sincronização, investimentos, alocação e patrimônio apenas em novembro: rotas de sincronização com seis estados e agenda diária, leitura de posições e movimentos com proveniência e frescor, alocação por classe e instituição e cadastro de bens, financiamentos e passivos com histórico. No web existem as telas de investimentos, patrimônio, painel de sincronização e mapeamento de contas; o mobile prioriza a migração para expo-router e ainda não tem as telas da Sprint 4. Em paralelo, a refatoração do frontend levou o Style Guide da versão um à dois ponto três. A Sprint 5, com o dashboard, está em prévia.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; linha do tempo como uma régua horizontal de 1px `--sg-line-strong` → #C9CFCE com seis pontos (círculos de 8px com borda 1,5px `--sg-text` → #0F1413 e fundo `--sg-surface` → #FFFFFF; o último ponto, Sprint 5, preenchido em `--sg-signal` → #087A55 como "último ponto" dos gráficos de linha); acima de cada ponto, rótulo micro com o nome da sprint e metadado com o período; abaixo, lista curta em corpo `--sg-text-2` → #434D4A; estado em marcador (sinal "entregue", atenção "aceite pendente" ou "parcial", informação "em prévia"). Marcos atrasados (Sprint 4) com o período em marcador atenção `--sg-warning` → #9A5D0F. Título em Newsreader 400. Sem barras de progresso coloridas.
- Fontes: `docs/planejamento/sprint-01/Plano_Divisao_Atividades_Sprint_1.html`, `docs/arquitetura/arquitetura.html` (histórico: baseline backend 08/09 e clientes 10/09/2026), `docs/planejamento/sprint-02/Plano_Divisao_Atividades_Sprint_2.html` (período 11 a 25/09/2026; escopo), `docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html` (período 25/09 a 09/10/2026; OFX, 24 h, Pluggy), `docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html` (entrega planejada 23/10/2026), `docs/planejamento/sprint-04/s4-06-dev1-backend-evidencias.md` (rotas HU-008, HU-009, HU-011, HU-012), `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` (telas web; mobile não iniciado), `docs/planejamento/sprint-04/s4-dev2-plano-execucao.md` (prioridade da F5; dashboard em prévia), `docs/planejamento/refatoracao-frontend/Plano_Refatoracao_Frontend.html` (início 22/10/2026), `docs/design/style-guide.html` (histórico de versões até 2.3), `docs/planejamento/plano-recuperacao-dev3.md` (aceite formal pendente, decisão C1).

## Slide 8 — Evidências: o que foi executado
- Tempo: 0:45 (acumulado: 8:00)
- Quem fala: Dev 3, Thiago Marques
- Conteúdo on-slide: eyebrow "Evidências"; título "Executado, não afirmado"; tabela "Área · Verificação · Resultado · Revisão e data": "Backend · suíte completa com PostgreSQL 17 descartável · 55 arquivos, 258 testes aprovados · 23/11/2026"; "Backend · suíte completa após a instrumentação de diagnóstico Pluggy · 57 arquivos, 268 testes · sobre b5826a3, 25/11/2026"; "Backend · migrations e verificadores · 20 migrations; verify-rls e verify-pluggy-sync aprovados · 23 e 25/11/2026"; "Backend · OpenAPI gerada igual à versionada · 33 caminhos · 25/11/2026"; "Web · lint, tipos, testes e build · 754 testes (7cf4602, 23/11) e 880 testes (b51a9f9, 25/11)"; "Mobile · tipos, testes e export Android · 481 testes (23/11) [A CONFIRMAR: 469 na branch F5, diferença não reconciliada]"; linha de metadados: "Fixtures sintéticas · sem Pluggy Sandbox, QStash real ou banco compartilhado · sem teste manual em navegador e sem aceite independente".
- Fala: O que apresentamos como entregue tem evidência executada, e separamos sempre implementação, teste, execução, integração e aceite. Na última rodada local, de vinte e três a vinte e cinco de novembro, o backend passou na suíte completa com PostgreSQL 17 descartável, aplicou as vinte migrations, e os verificadores de RLS e de sincronização passaram; a OpenAPI gerada ficou idêntica à versionada, com trinta e três caminhos. O web passou em lint, tipos, testes e build; o mobile em tipos, testes e export Android. Tudo com fixtures sintéticas: nenhum teste chamou Pluggy Sandbox, QStash real ou banco compartilhado. Os números estão na tela, com a revisão e a data de cada um.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; uma única tabela no padrão da seção 5 (painel `--sg-surface` → #FFFFFF, cabeçalho micro `--sg-text-3` → #5F6966, linhas de 40px, números tabulares à direita em Manrope 600 `--sg-text` → #0F1413, revisão e data em metadado); resultados aprovados com marcador sinal `--sg-signal` → #087A55; a linha do mobile com marcador atenção `--sg-warning` → #9A5D0F pelo [A CONFIRMAR]. Linha de metadados na base. Título em Newsreader 400. Sem gráfico: números em tabela, como manda o guia.
- Fontes: `docs/planejamento/sprint-04/s4-06-validacao-local-2026-11-23.md` (revalidação: 55 arquivos, 258 testes; 20 migrations; verificadores; web 754; mobile 481), `docs/planejamento/sprint-04/s4-06-dev1-backend-evidencias.md` (57 arquivos, 268 testes; OpenAPI 33 caminhos; limites da evidência), `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` (web 880 testes em b51a9f9; mobile 469 na branch F5; L-08).

## Slide 9 — Aprendizados
- Tempo: 1:00 (acumulado: 9:00)
- Quem fala: Dev 3, Thiago Marques
- Conteúdo on-slide: eyebrow "Aprendizados"; título "O que o projeto nos ensinou"; cinco itens numerados: "1 · Contrato antes de tela: o OpenAPI do backend é a fonte; clientes divergem quando não acompanham (conclusão Pluggy: 202 com Idempotency-Key no web, 200 no mobile)"; "2 · Evidência não é afirmação: implementado, testado, executado, integrado e aceito são coisas diferentes; mock não comprova banco, Auth0 ou Pluggy"; "3 · Decisões de produto bloqueiam telas: doze definições do dashboard (D-01 a D-12) com dono antes de qualquer fase"; "4 · Integrações externas são o gargalo: Sandbox, QStash real e Item com consentimento de investimentos sem validação ponta a ponta"; "5 · Design evolui com protótipo: a rosca de gastos, proibida na 2.0, entrou na 2.1 com os valores escritos".
- Fala: Cinco aprendizados. Primeiro: contrato antes de tela. Quando o OpenAPI mudou sem os clientes acompanharem, web e mobile divergiram na conclusão Pluggy, um com duzentos e dois e chave de idempotência, outro com duzentos; reconciliar depois custou mais do que decidir antes. Segundo: evidência não é afirmação. Passamos a distinguir implementado, testado, executado, integrado e aceito, e um mock nunca comprova banco, Auth0 ou Pluggy. Terceiro: decisões de produto bloqueiam telas. O dashboard tem doze definições de cálculo abertas, e nenhuma fase de interface começa sem elas respondidas e com dono. Quarto: integrações externas são o gargalo; o Sandbox, o QStash real e um Item com consentimento de investimentos continuam sem validação ponta a ponta. Quinto: design evolui com protótipo. A rosca de gastos, antes proibida, foi adotada quando a leitura ficou mais rápida, mantendo os valores escritos.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; lista numerada em duas colunas sem cartões, cada item com o número em Manrope 600 20px tabular `--sg-text-3` → #5F6966 (padrão das listas numeradas do site), título do item em Manrope 600 `--sg-text` → #0F1413 e explicação em corpo `--sg-text-2` → #434D4A; itens separados por linhas horizontais de 1px `--sg-line` → #E2E5E5. Ao lado do item 5, uma miniatura da rosca da seção 7 do guia (128px, seis fatias nas cores de categoria 1 a 5 mais "A revisar" hachurada em `--sg-warning` → #9A5D0F, total no centro) com a lista de valores ao lado em metadado. Título em Newsreader 400.
- Fontes: `docs/planejamento/plano-recuperacao-dev3.md` (regra de distinguir implementação, teste, execução, integração, demonstração e aceite; mocks não comprovam; divergência 200 vs 202 e Idempotency-Key), `docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md` (premissas dos clientes sobre a conclusão sem chave), `docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md` (decisões C-01 a C-06 com dono e bloqueios), `docs/planejamento/sprint-05/s5-dev2-dashboard-dados-e-definicoes.md` (D-01 a D-12; nenhuma fase começa sem respostas), `docs/planejamento/sprint-04/s4-06-dev1-backend-evidencias.md` (Sandbox, QStash e Item sem validação ponta a ponta), `docs/arquitetura/adr-005-cores-categoria-rosca.html` (rosca adotada após o protótipo).

## Slide 10 — Bloqueios, riscos e próximos passos
- Tempo: 0:30 (acumulado: 9:30)
- Quem fala: Dev 3, Thiago Marques
- Conteúdo on-slide: eyebrow "Estado atual em 26/11/2026"; título "Bloqueios com dono, próximos passos com ordem"; tabela "Bloqueio · Efeito · Dono": "L-01 · conclusão Pluggy responde 503 no web · sem sincronização nem investimentos com dados reais · Dev 1"; "L-10 · web no Render não carregou Contas, Movimentações e Investimentos em 26/11 · sem ambiente publicado para testar · Dev 1"; "L-07 · mobile sem telas da Sprint 4; login com expo-router pendente de development build · Dev 2"; "Aceite formal das Sprints 1 a 3 · Plano 04 bloqueado, 05 a 09 não iniciados · Dev 3"; lista "Próximos passos": "Sprint 5: definições D-01 a D-12, dashboard, patrimônio líquido (HU-013) e projeções (HU-014)"; "Evolução SaaS: staging e produção, LGPD, backups, RPO 24h e RTO 8h, infraestrutura como código".
- Fala: O estado atual é honesto. Três bloqueios têm dono: a conclusão Pluggy no web responde 503 e precisa de diagnóstico em ambiente autorizado; o ambiente publicado no Render não carregou telas em vinte e seis de novembro; e o mobile ainda não tem as telas da Sprint 4. O aceite formal das Sprints 1 a 3 segue o plano de recuperação. Próximos passos: fechar o dashboard, patrimônio líquido e projeções da Sprint 5.
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; tabela de bloqueios no padrão da seção 5 com a coluna "Bloqueio" em marcador negativo `--sg-negative` → #B5473F para L-01 e L-10, atenção `--sg-warning` → #9A5D0F para L-07 e o aceite formal; coluna "Dono" em metadado. À direita, lista "Próximos passos" com marcador informação `--sg-info` → #2B6F89, separada por linha vertical de 1px `--sg-line` → #E2E5E5. Título em Newsreader 400. Sem vermelho como fundo; a cor só no marcador.
- Fontes: `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` (lacunas L-01, L-07, L-10 com donos), `docs/planejamento/sprint-04/s4-06-dev1-backend-evidencias.md` (L-01 reproduzir em ambiente autorizado), `docs/planejamento/plano-recuperacao-dev3.md` (tabela de progresso: Plano 04 bloqueado, 05 a 09 não iniciados), `docs/planejamento/sprint-05/s5-dev2-dashboard-dados-e-definicoes.md` (D-01 a D-12; HU-013), `docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html` (HU-013, HU-010 e HU-014 propostas para a Sprint 5), `docs/produto/visao.html` (evolução SaaS obrigatória).

## Slide 11 — Demonstração ao vivo
- Tempo: 3:00 (acumulado: 12:30)
- Quem fala: Dev 2, Miguel Candido
- Conteúdo on-slide: eyebrow "Demonstração"; título "Dados fictícios, do login ao patrimônio"; checklist com os passos abaixo e a história de cada um; linha de metadados: "Ambiente: [A CONFIRMAR: backend local em Docker e web em desenvolvimento, ou ambiente publicado] · dados fictícios · nada aqui movimenta dinheiro". Este slide fica na tela enquanto a demonstração roda em outra janela; voltar a ele se algo falhar.
- Fala: Condução, não dimensionada por palavra. Pré-condições (antes da banca): backend local recriado com as rotas atuais e web em modo de desenvolvimento, ou o ambiente publicado se L-10 estiver resolvida [A CONFIRMAR]; flag OVERVIEW_PREVIEW ativa no web; um usuário fictício já cadastrado no Auth0; um arquivo OFX sintético pequeno (abaixo de 4 MiB, que é o limite do web) com pelo menos uma transação duplicada; build mobile no aparelho [A CONFIRMAR]. Passos no web, cerca de 2:10. 1 (0:15) Login com Auth0 e entrada no espaço próprio: "Cada pessoa só acessa o próprio tenant; o backend valida o JWT e o banco aplica RLS" (HU-001). 2 (0:15) Contas: criar uma conta manual com nome, tipo, instituição e saldo inicial com data de referência; mostrar a lista só com as contas próprias (HU-002). 3 (0:25) Movimentações: registrar uma receita, uma despesa e uma transferência entre duas contas próprias; apontar que a transferência gera saída e entrada e que é só registro contábil (HU-003). 4 (0:15) Categorias e regras: atribuir categoria a uma movimentação e criar uma regra pessoal que categoriza a próxima movimentação; apontar que resultado incerto ou não reconhecido fica explícito para revisão e que a pessoa pode corrigir (HU-005, HU-006). 5 (0:25) OFX: enviar o arquivo sintético, mapear a conta de destino, mostrar a prévia com a duplicidade sinalizada e a validade de 24 horas, confirmar e mostrar importados, ignorados e com erro (HU-004). 6 (0:20) Bens e dívidas: criar um bem com tipo, descrição, valor, data de avaliação e fonte; criar um financiamento associado a ele; abrir o histórico de versões (HU-012). 7 (0:10) Investimentos: mostrar o estado vazio com o atalho "Conectar um banco" e explicar que posições reais dependem de uma conexão Pluggy com consentimento de investimentos (HU-009). 8 (0:25) Visão geral, passo fixo: abrir a prévia do dashboard: faixa de números (disponível, entradas e saídas do período), fluxo por mês com a tabela de valores, gastos por categoria em rosca com a lista ao lado e saldos por conta com origem e referência; dizer que as regras de cálculo D-01 a D-12 ainda aguardam Produto e que patrimônio líquido é Etapa 2 (HU-010) [A CONFIRMAR: estado da prévia no dia]. Passos no mobile, cerca de 0:50 [A CONFIRMAR: build disponível]. 9 (0:25) Login no app e lista de contas do mesmo usuário, mostrando que é uma experiência independente com o mesmo contrato OpenAPI (HU-001, HU-002). 10 (0:25) Registrar uma movimentação no app e mostrar que ela aparece no web após atualizar (HU-003). Opcional, somente se houver tempo e Sandbox autorizado: conexão Pluggy no mobile, aprovada no Sandbox em 25/11 (HU-007) [A CONFIRMAR: credenciais e Sandbox no dia]. Plano B se o ambiente falhar: mostrar os mockups da Visão geral e de Fontes de dados do Style Guide e as capturas preparadas [A CONFIRMAR: capturas preparadas antes da banca].
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; checklist em tabela de duas colunas (passo e história) no padrão da seção 5, com a coluna "Passo" em corpo `--sg-text-2` → #434D4A e a história em metadado tabular `--sg-text-3` → #5F6966; os passos opcionais com marcador neutro e a palavra "opcional". À direita, reprodução reduzida do mockup "Visão geral" do Style Guide (faixa de números, barras por mês, rosca com lista, saldos por conta) nos componentes da seção 5 e cores de categoria 1 a 5 da seção 3, como referência do que será mostrado. Linha de metadados na base. Título em Newsreader 400.
- Fontes: `docs/produto/prd.html` (critérios de aceite de HU-001 a HU-007, HU-009, HU-010, HU-012), `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` (roteiro manual de bens e dívidas; estado vazio de investimentos; rotas do web; L-01, L-07, L-10), `docs/planejamento/sprint-04/s4-dev2-plano-execucao.md` (Visão geral em prévia atrás de OVERVIEW_PREVIEW), `docs/planejamento/sprint-05/s5-dev2-dashboard-dados-e-definicoes.md` (blocos do dashboard; D-01 a D-12; Etapa 2), `docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html` (limite de 4 MiB no web; mapeamento de conta antes da prévia; validade de 24 horas), `docs/planejamento/plano-recuperacao-dev3.md` (Pluggy mobile aprovado no Sandbox em 25/11/2026), `docs/design/style-guide.html` (mockups da Visão geral e de Fontes de dados; círculo de cor da categoria).

## Slide 12 — Encerramento
- Tempo: 0:30 (acumulado: 13:00)
- Quem fala: Dev 3, Thiago Marques
- Conteúdo on-slide: assinatura principal; frase em Newsreader: "Clareza para cuidar do que é seu."; três linhas em metadado: "Analítico, individual, dados fictícios · nunca movimenta dinheiro, nunca aconselha"; "Autenticação, contas, movimentações, categorias, OFX, Pluggy, investimentos e patrimônio entregues com evidência executada"; "Bloqueios declarados com dono · próximo passo: Sprint 5"; linha "Obrigado".
- Fala: Para encerrar: o Coinciente é um produto analítico, para uma pessoa, com dados fictícios, que nunca movimenta dinheiro e nunca aconselha. A arquitetura modular com isolamento por tenant no banco sustenta o que já existe e o que vem na evolução SaaS. Entregamos autenticação, contas, movimentações, categorias, OFX, conexão Pluggy, investimentos e patrimônio, com evidência executada e bloqueios declarados. Obrigado pela atenção; estamos à disposição para perguntas.
- Visual: brand-stage igual ao slide 1: fundo Confiança → #10251F, anéis rgba(85, 214, 164, .14), lockup com símbolo e "Coinciente" em #FFFFFF, frase em Newsreader 400 #FFFFFF, três linhas em metadado #a9c6bb; "Obrigado" em Manrope 600 #FFFFFF. Sem gradiente, sem ondas.
- Fontes: `docs/produto/visao.html` (declaração da visão; não movimenta fundos; evolução SaaS), `docs/produto/prd.html` (critérios globais de aceite), `docs/design/style-guide.html` (tagline e lockup).

## Slide 13 — Perguntas da banca
- Tempo: 2:00 (acumulado: 15:00)
- Quem fala: todos; Dev 3, Thiago Marques, modera
- Conteúdo on-slide: título "Perguntas"; abaixo, em metadado, uma linha por documento de referência: "Documento de Visão 1.3 · PRD 1.4 · Arquitetura 1.6 · ADR RLS PostgreSQL 1.0 · Style Guide 2.3 · Planos das Sprints 1 a 4"; assinatura pequena no canto.
- Fala: Condução, não dimensionada por palavra. Thiago abre: "Ficamos à disposição; cada um responde pela sua área." Encaminhamento: perguntas de segurança, isolamento, banco e integrações vão para o Samuel; de interface, clientes e demonstração para o Miguel; de método, testes, evidências e estado do projeto para o Thiago. Respostas preparadas, cada uma com a fonte: (1) "Por que dados fictícios e não reais?" porque o MVP é demonstração acadêmica e dados financeiros reais exigem os controles da evolução SaaS: staging e produção separados, LGPD, backups, RPO 24h e RTO 8h (Visão). (2) "Como garantem que um usuário não vê dados de outro?" autorização no NestJS com contexto de tenant explícito mais RLS no PostgreSQL com contexto local à transação, fail-closed, papéis sem BYPASSRLS e FORCE RLS; testes cobrem leitura e mutação cross-tenant (ADR RLS, PRD RNF-002). (3) "Qual o desempenho?" P90 abaixo de dois segundos com até 10.000 transações é hipótese a validar com dataset acadêmico; nenhum resultado foi medido [A CONFIRMAR] (PRD RNF-006, RNF-007). (4) "Isso é um banco?" não: nenhuma função inicia pagamento, Pix, ordem ou movimentação de fundos; transferências são registros contábeis (PRD RN-005, RN-017). (5) "E a LGPD?" controles LGPD completos tornam-se obrigatórios com dados reais na evolução SaaS; o MVP não processa dados pessoais reais (PRD RNF-015). (6) "O que falta para o MVP?" dashboard, patrimônio líquido e projeções da Sprint 5, as telas mobile da Sprint 4 e o aceite formal das sprints anteriores, com os bloqueios L-01 e L-10 (slide 10). (7) "Por que três repositórios e não um monorepo?" independência de implantação e de ciclo de build de cada cliente; o que é compartilhado é o contrato OpenAPI, não código (Arquitetura). Se o tempo acabar, Thiago encerra: "Agradecemos as perguntas; a documentação completa está no repositório do projeto."
- Visual: tema claro, fundo `--sg-bg` → #F6F7F7; título "Perguntas" em Newsreader 400 grande, centralizado, `--sg-text` → #0F1413; abaixo, a linha de documentos em metadado `--sg-text-3` → #5F6966 separada por " · "; símbolo isolado pequeno no canto; ondas decorativas estáticas permitidas em um canto inferior, atrás do texto. Nada mais.
- Fontes: `docs/produto/visao.html` (evolução SaaS obrigatória; MVP acadêmico), `docs/produto/prd.html` (RNF-002, RNF-006, RNF-007, RNF-015, RN-005, RN-017), `docs/arquitetura/adr-rls-postgresql.html` (contexto local, fail-closed, papéis, FORCE RLS), `docs/arquitetura/arquitetura.html` (três repositórios; contrato OpenAPI compartilhado), `docs/planejamento/sprint-04/s4-06-dev2-evidencias-clientes.md` (L-01, L-07, L-10).
