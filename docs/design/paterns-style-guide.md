# Boas práticas para style guides e brandbooks de produtos digitais

## Resumo executivo

A pesquisa indica que **brandbook, diretrizes de identidade visual, design system e style guide de interface são artefatos relacionados, mas não equivalentes**. As fronteiras não são padronizadas: a IBM separa explicitamente Brand Center e Design Language como fundações e Carbon como camada de implementação; a Atlassian descreve seu design system como uma “linguagem de design unificada”; e o GOV.UK mantém estilos, componentes, padrões e um guia editorial em conjuntos conectados, porém distintos. Portanto, as definições deste relatório devem ser entendidas como **distinções operacionais**, e não como uma taxonomia universal. citeturn19view0turn19view1turn18view3turn15view0

Para um produto web e mobile, um style guide realmente acionável precisa ir além de logo, paleta e tipografia. A evidência dos sistemas analisados converge para documentar também **hierarquia e layout, comportamento responsivo, componentes e seus estados, padrões de interação, conteúdo, acessibilidade, iconografia, motion e regras de implementação**. Sistemas maduros acrescentam ainda informações de ciclo de vida, contribuição e mudança. citeturn20view1turn15view0turn16view0turn18view3

A principal implicação para uma futura refatoração é que a documentação deve explicar não só **“o que usar”**, mas também **“para quê, quando, como, com quais restrições e como verificar se a aplicação está correta”**. Isso é particularmente importante para acessibilidade: WCAG 2.2 exige, entre outros pontos, que cor não seja o único meio de transmitir informação, estabelece contraste mínimo para texto, requisitos de reflow e contraste não textual e critérios para alvos de interação. citeturn20view4turn20view5turn20view6

Também emerge uma distinção importante entre **consistência e uniformidade**. O USWDS afirma explicitamente que consistência não significa conformidade e que serviços diferentes podem adaptar soluções a audiências e objetivos distintos; o Shopify Polaris aplica uma linguagem compartilhada em várias superfícies, mas cada superfície disponibiliza um subconjunto próprio de APIs e componentes. Isso sugere que uma boa documentação deve definir o que é invariável na marca e o que pode se adaptar por plataforma e contexto. citeturn20view3turn20view0

**Confiança:** alta nas recomendações de acessibilidade e nos padrões observados em documentação oficial; média nas fronteiras terminológicas entre “brandbook”, “visual identity guidelines” e “interface style guide”, justamente porque organizações usam esses nomes de maneiras diferentes.

## Escopo e definições

Este estudo é **exclusivamente externo**. O style guide atual da aplicação não foi disponibilizado e, portanto, nenhuma conclusão abaixo identifica lacunas, problemas ou mudanças específicas necessárias no material existente.

Neste relatório, **design token** significa uma decisão de design nomeada e reutilizável — por exemplo, um papel semântico como `color.text.danger` em vez de uma cor codificada diretamente. A Atlassian documenta tokens com nomes semânticos desse tipo e também aplica a abordagem a motion, usando nomes que incorporam contexto, tipo e ritmo. citeturn18view3turn14search24 **Pattern**, por sua vez, é usado no sentido de solução para uma tarefa ou interação recorrente; o GOV.UK distingue seus patterns dos componentes, descrevendo os primeiros como orientações para tarefas como preencher formulários ou criar contas. citeturn15view0

**Interpretação:** a melhor forma de pensar nos quatro artefatos é como perspectivas sobre responsabilidades sobrepostas, e não necessariamente como quatro sites, documentos ou repositórios diferentes. A própria diversidade da IBM, GOV.UK e Atlassian demonstra que não existe uma arquitetura documental única implícita nesses termos. citeturn19view0turn19view1turn15view0turn18view3

| Artefato | Propósito prático | Público principal | Conteúdo típico | Relação com os demais |
|---|---|---|---|---|
| **Brandbook** | Codificar a identidade ampla da marca e os princípios que devem orientar sua expressão. | Marca, marketing, comunicação, design e, conforme a empresa, produto. | Propósito e princípios da marca, personalidade, linguagem verbal, identidade visual, ativos e regras de uso. **A extensão exata varia por organização.** | É a camada mais ampla de intenção da marca; parte de seu conteúdo pode alimentar identidade visual e decisões de produto. A IBM, por exemplo, posiciona seu Brand Center entre as “Foundations”, separado da implementação do Carbon. citeturn19view0turn19view1 |
| **Diretrizes de identidade visual** | Definir a gramática visual reconhecível da marca. | Brand designers, comunicação, product designers e fornecedores. | Logo, tipografia, cor, grid, fotografia, ilustração, iconografia, motion e aplicações. A IBM Design Language cobre explicitamente essas categorias. citeturn19view1 | Traduz atributos da marca em recursos visuais. Pode ter escopo muito maior que UI, incluindo comunicação, vídeo e materiais físicos. |
| **Interface style guide** | Explicar como a linguagem visual e editorial deve aparecer nas interfaces. | Design de produto, conteúdo e engenharia. | Cor e seus papéis, tipografia, layout, iconografia, estados, conteúdo, exemplos de uso e regras específicas de tela. O GOV.UK, por exemplo, define “styles” para layout, tipografia, cor e imagens e mantém orientação editorial relacionada. citeturn15view0turn16view1 | É uma ponte entre identidade e aplicação digital; pode existir dentro de um design system ou como material complementar. |
| **Design system** | Transformar decisões recorrentes de produto em recursos reutilizáveis para design e implementação. | Design, engenharia, produto, conteúdo e equipes mantenedoras. | Foundations/tokens, componentes, padrões, código, acessibilidade, templates, documentação, releases e, em sistemas maduros, lifecycle/contribuição. Carbon, USWDS e GOV.UK exibem explicitamente várias dessas camadas. citeturn19view0turn20view1turn16view0 | Operacionaliza parte da identidade e das regras de interface. Não substitui necessariamente estratégia de marca ou orientação editorial. |

Há sobreposição real: cor, tipografia, iconografia e motion podem aparecer em todos esses artefatos. A diferença mais útil é a **responsabilidade que cada regra resolve**: identidade responde “como a marca se expressa”; style guidance responde “como isso funciona na interface”; e o design system acrescenta reutilização e implementação sistemática. Essa é uma síntese interpretativa sustentada pela separação observada nos sistemas oficiais, não uma convenção terminológica universal. citeturn19view0turn19view1turn15view0

## Achados organizados pelas perguntas de pesquisa

**Como os quatro artefatos diferem e se complementam?**

O achado central está na tabela anterior: **o nível de operacionalização aumenta da identidade para a implementação**, mas as camadas não precisam ser linearmente separadas. A IBM é um exemplo particularmente explícito: Brand Center e IBM Design Language aparecem sob Foundations, enquanto Carbon aparece sob Implementation; ao mesmo tempo, Carbon declara ser moldado pela IBM Design Language. citeturn19view0turn19view1

O GOV.UK demonstra outro arranjo. Seu design system contém styles, components e patterns, enquanto aponta para um style guide editorial separado. Assim, conteúdo, expressão visual e componentes podem formar um ecossistema coerente sem necessariamente estarem no mesmo artefato. citeturn15view0turn16view1

**Interpretação:** para uma futura auditoria, é mais útil perguntar **“esta responsabilidade está claramente documentada em algum lugar?”** do que exigir que cada categoria tenha um documento próprio.

**Que conteúdo deve estar coberto?**

A tabela abaixo combina práticas recorrentes nas documentações oficiais com requisitos de acessibilidade. “Essencial” significa importante para a maioria dos produtos digitais; “contextual” significa que sua necessidade depende do domínio, das plataformas e da maturidade do sistema.

| Seção | Prioridade | Propósito | Critérios observáveis de qualidade |
|---|---|---|---|
| **Escopo e princípios** | Essencial | Explicar o que a documentação governa e quais decisões orienta. | Diz a quem se destina, quais superfícies cobre e quais princípios usar diante de casos não documentados. USWDS usa princípios explicitamente como lente de avaliação de decisões. citeturn20view1 |
| **Expressão da marca** | Essencial | Conectar identidade corporativa ao produto. | Explica quais elementos são distintivos, quais usos são permitidos e como a marca deve aparecer em UI sem depender apenas do logo. IBM relaciona tipografia, cor, grid, iconografia, fotografia, ilustração e animation à sua linguagem de design. citeturn19view1 |
| **Cor e temas** | Essencial | Definir papéis, hierarquia e estados. | Há papéis semânticos — ação, superfície, texto, sucesso, alerta etc. — e combinações verificadas, inclusive em temas relevantes. A IBM, por exemplo, reserva seu azul central para ações e orienta uso deliberado de outras cores. citeturn19view2 |
| **Tipografia** | Essencial | Definir hierarquia legível e adaptável. | Especifica famílias, estilos, hierarquia e comportamento sob ampliação. Na web, texto deve poder ser redimensionado até **200%** sem perda de conteúdo ou funcionalidade para atender ao critério correspondente de nível AA da WCAG 2.2. citeturn20view4 |
| **Layout, espaçamento e responsividade** | Essencial | Explicar como a composição se adapta ao espaço disponível. | Define relações de grid/espaçamento e comportamento, não apenas mockups fixos. A WCAG 2.2 exige reflow sem perda de informação ou funcionalidade em condições que incluem largura equivalente a **320 CSS px**, salvo exceções definidas. citeturn20view5 |
| **Componentes e estados** | Essencial quando há UI reutilizável | Tornar controles previsíveis em design e código. | Documenta anatomia, variantes e estados relevantes, como foco, erro, loading e disabled, além de nome, papel e valor programáticos quando aplicável. citeturn20view7 |
| **Padrões e jornadas** | Essencial para produtos com tarefas recorrentes | Mostrar como componentes são combinados para resolver tarefas. | Exemplos são orientados por intenção/tarefa, e não apenas por aparência. Essa é a distinção usada pelo GOV.UK entre components e patterns. citeturn15view0 |
| **Conteúdo e terminologia** | Essencial | Manter voz, labels e instruções coerentes. | Define convenções para labels, erros, ações e termos recorrentes. O GOV.UK mantém orientação editorial detalhada e, por exemplo, prefere linguagem neutra em relação ao mecanismo de entrada (“select” em vez de presumir “click”). citeturn16view1 |
| **Acessibilidade** | Essencial | Incorporar requisitos à decisão de design, conteúdo e implementação. | Regras testáveis de contraste, uso de cor, teclado, leitor de tela, foco, tamanho de alvo e semântica; orientação inclui testes, não apenas declaração de conformidade. citeturn20view2turn20view4turn20view6turn20view7 |
| **Iconografia, imagens e ilustração** | Essencial ou contextual conforme o produto | Manter linguagem visual e significado consistentes. | Define estilo, finalidade, sizing e quando o elemento é decorativo versus informativo. IBM documenta separadamente ícones de UI, pictogramas, ilustração e fotografia. citeturn19view1 |
| **Motion e gestos** | Contextual, mas essencial onde usados | Dar significado a transições/interações sem criar dependência inacessível. | Motion possui intenção clara; interações gestuais têm alternativas quando exigidas. A Atlassian usa tokens de motion baseados em intenção, enquanto WCAG 2.2 exige alternativas para certas operações de arrastar. citeturn14search24turn20view6 |
| **Adaptação por plataforma** | Essencial para produtos multiplataforma | Definir o que permanece consistente e o que segue convenções da superfície. | Explicita diferenças entre web/mobile e entre superfícies sem duplicar regras arbitrariamente. Polaris compartilha um framework, porém cada superfície oferece seu próprio subconjunto de componentes. citeturn20view0 |
| **Dados e visualização** | Contextual | Padronizar gráficos quando dados fazem parte significativa do produto. | Especifica cores, legibilidade, semântica e padrões gráficos. Carbon e IBM Design Language incluem data visualization como área explícita. citeturn19view0turn19view1 |
| **Lifecycle e mudanças** | Essencial à manutenção; profundidade depende da escala | Evitar que orientação obsoleta pareça equivalente à orientação estável. | Existe owner, estado, histórico e forma de comunicar mudanças/depreciações. GOV.UK diferencia componentes Trial e Stable e documenta iteração e depreciação. citeturn16view0 |

Uma regra particularmente importante para cor: WCAG 2.2 estabelece que ela não pode ser o único meio visual de transmitir informação e exige contraste de pelo menos **4,5:1** para texto comum e **3:1** para texto grande, dentro das condições e exceções do critério. Informação visual necessária para identificar componentes e seus estados também está sujeita a contraste não textual de **3:1**. citeturn20view4turn20view5

**Como traduzir a identidade para uma interface reconhecível, consistente, acessível e responsiva?**

| Princípio | Exemplo concreto | Risco mitigado |
|---|---|---|
| **Traduzir valores visuais em papéis de interface, não apenas valores brutos.** | Em vez de documentar apenas “azul X”, especificar quando uma cor exerce o papel de ação principal, link ou destaque. A IBM aplica seu azul central como cor primária de ação; Atlassian expõe tokens como `color.text.danger` e `color.border.success`. citeturn19view2turn18view3 | Uso indiscriminado da paleta, hierarquia inconsistente e divergência entre design e código. |
| **Construir reconhecimento por um conjunto de sinais recorrentes.** | Tipografia, cor, grid, ícones, ilustração e motion podem trabalhar como linguagem conjunta. A IBM documenta esses elementos sob a mesma Design Language e declara que sua filosofia busca distinguir experiências “Designed by IBM”. citeturn19view1 | Dependência excessiva do logo ou aplicação puramente decorativa da marca. |
| **Tratar acessibilidade como restrição da linguagem de marca.** | Um erro em vermelho também recebe texto/ícone/semântica; uma cor de marca que não apresenta contraste adequado não é usada naquela combinação. citeturn20view4turn19view2 | Informação inacessível e identidade visual entrando em conflito com a função da interface. |
| **Buscar continuidade, não identidade pixel a pixel.** | Navegação e hierarquia permanecem familiares entre desktop e mobile, enquanto layout e controles se adaptam. USWDS afirma explicitamente que consistência não é necessariamente conformidade; Shopify mantém Polaris comum enquanto varia componentes por superfície. citeturn20view3turn20view0 | Layout desktop “encolhido” para mobile ou adaptações de plataforma que parecem produtos não relacionados. |
| **Documentar comportamento e estados como parte da marca do produto.** | Botão inclui hover/focus/pressed/disabled/loading, em vez de apenas sua aparência padrão; feedback de sucesso ou erro tem aparência e semântica programática. citeturn20view7 | Telas de exceção e estados interativos se tornarem a principal fonte de inconsistência ou inacessibilidade. |
| **Validar em contextos reais, não apenas em componentes isolados.** | Testar layouts, fluxos críticos, tecnologias assistivas e dispositivos em que o produto realmente opera. USWDS recomenda testar com pessoas reais, ampla variedade de capacidades e considerar continuidade entre dispositivos. citeturn20view1turn20view2turn20view3 | Um componente “correto” isoladamente produzir uma jornada ruim quando combinado com outros elementos. |

**Interpretação:** reconhecer a marca na interface não exige maximizar a quantidade de elementos de marca. O exemplo da IBM é instrutivo: sua documentação diz que os neutros dominam a UI, enquanto o azul central assume um papel funcional específico e cores adicionais são usadas de modo deliberado. A prática demonstra uma maneira de obter assinatura visual por **regras recorrentes**, não por intensidade decorativa. Não há, contudo, evidência nesta pesquisa de que esse modelo específico produza melhores resultados para outras marcas. citeturn19view2

**Que padrões úteis aparecem em sistemas bem documentados?**

| Exemplo oficial | Padrão observado | Evidência | Cautela na transferência |
|---|---|---|---|
| **IBM Design Language + Carbon** | Separação explícita entre fundamentos de identidade e camada de implementação, com referências entre elas. | IBM posiciona Brand Center/Design Language em Foundations e Carbon em Implementation; Carbon declara ser moldado pela IBM Design Language. citeturn19view0turn19view1 | A estrutura reflete a escala e o ecossistema da IBM; não demonstra que outras empresas precisem da mesma divisão. |
| **GOV.UK Design System** | Separação de styles, components e task patterns; lifecycle explícito para componentes. | Styles cobrem layout/tipografia/cor/imagens, components são reutilizáveis e patterns apoiam tarefas; componentes podem ser Trial ou Stable. citeturn15view0turn16view0 | O contexto é de serviços públicos e possui governança própria; o modelo não deve ser copiado literalmente. |
| **USWDS** | Princípios são usados junto de componentes, patterns, tokens, utilities e templates. | A documentação apresenta essas categorias e diz que os princípios funcionam como lente de avaliação de decisões. citeturn20view1 | Seus requisitos e prioridades refletem serviços federais dos EUA. |
| **Atlassian Design System** | Linguagem unificada combina foundations, accessibility e tokens sem reduzir o sistema a uma biblioteca de componentes. | Atlassian documenta cor, tipografia, iconografia, grid, acessibilidade, tokens e patterns de AI e descreve a experiência como uma linguagem de design unificada. citeturn18view3 | A amplitude reflete um grande portfólio de aplicações; nem toda categoria terá relevância igual para outro produto. |
| **Shopify Polaris** | Fundamentos compartilhados coexistem com regras específicas de cada superfície. | Todas as app surfaces usam Polaris, mas Admin, Checkout, Customer Accounts e POS podem expor subconjuntos diferentes de componentes e APIs. citeturn20view0 | É um modelo particularmente adequado a uma plataforma/ecossistema extensível; não implica que qualquer produto mobile/web precise das mesmas divisões. |

O GOV.UK oferece ainda um exemplo de **propagação de uma mudança de marca para a tecnologia**: sua documentação registra que o refresh da marca iniciado em junho de 2025 foi acompanhado por versões do GOV.UK Frontend para apoiar a atualização dos serviços. Isso é evidência de que mudança de identidade e mudança de implementação podem precisar ser coordenadas; não é evidência de que versionamento específico seja a única forma de fazê-lo. citeturn15view0

**Como transformar estes achados em uma auditoria e refatoração futura?**

A auditoria pode utilizar quatro estados qualitativos — por exemplo, **ausente, parcial, claro e validado** — apenas como instrumento de trabalho; esses estados são uma proposta metodológica deste relatório, não uma escala validada empiricamente.

| Dimensão diagnóstica | Pergunta a fazer quando o guia estiver disponível | Evidência procurada |
|---|---|---|
| **Cobertura** | As decisões recorrentes de web e mobile estão documentadas? | Seções, componentes, patterns, estados e exemplos correspondentes às superfícies reais. |
| **Clareza da regra** | A pessoa consegue decidir o que fazer sem interpretar uma imagem de referência? | Regra, contexto, exceções e exemplos de aplicação. |
| **Expressão da marca** | É claro como os fundamentos visuais se transformam em decisões de UI? | Relações entre identidade, papéis semânticos e exemplos reais. |
| **Acessibilidade** | As regras são verificáveis e consistentes com o padrão aplicável? | Critérios de contraste, teclado, semântica, resize/reflow, targets e procedimentos de teste. citeturn20view4turn20view5turn20view6turn20view7 |
| **Responsividade e plataformas** | O guia explica adaptação ou mostra apenas dimensões fixas? | Regras de reflow, hierarquia, comportamento por viewport/superfície e exceções. |
| **Estados e edge cases** | A documentação cobre mais que o happy path? | Focus, erro, loading, empty, disabled, conteúdo longo e combinações críticas. |
| **Design ↔ implementação** | Conceitos equivalentes recebem papéis equivalentes em design e código? | Tokens, nomes, componentes e referências cruzadas compreensíveis por designers e engenheiros. |
| **Manutenção** | É possível saber o que é vigente, experimental ou obsoleto? | Owner, datas de atualização, lifecycle, changelog e depreciação; GOV.UK é um exemplo documentado desse princípio. citeturn16view0 |

Uma sequência adaptável para a refatoração futura seria:

| Atividade | Propósito |
|---|---|
| **Inventariar o material existente e as superfícies do produto.** | Descobrir o que realmente precisa ser governado, sem pressupor que a estrutura atual esteja certa ou errada. |
| **Mapear o inventário para a matriz diagnóstica.** | Separar ausência de documentação de regras existentes porém difíceis de aplicar. |
| **Comparar documentação com exemplos reais do produto.** | Localizar divergências entre regra declarada, design e implementação; isso só poderá ser feito quando o guia e o produto forem analisados. |
| **Classificar divergências por risco e frequência.** | Dar prioridade a decisões que aparecem repetidamente ou afetam acessibilidade, fluxos críticos e múltiplas plataformas. |
| **Refatorar cada orientação em regra + razão + aplicação + exceção + verificação.** | Transformar páginas descritivas em suporte prático à decisão. Essa estrutura é uma síntese proposta, não um formato universal. |
| **Validar com design, produto e engenharia em casos reais.** | Verificar se pessoas com conhecimentos diferentes chegam a interpretações suficientemente consistentes e se a implementação preserva os requisitos. A ênfase em teste real é compatível com a orientação do USWDS. citeturn20view1turn20view2 |
| **Definir manutenção e lifecycle.** | Fazer com que futuras mudanças de marca, componentes ou plataforma possam ser incorporadas sem deixar regras conflitantes ou silenciosamente obsoletas; GOV.UK demonstra uma implementação possível desse princípio. citeturn16view0turn15view0 |

## Síntese e implicações para a futura refatoração do style guide

A evidência sugere que o objetivo de uma refatoração não deveria ser apenas tornar o guia **mais completo**, mas torná-lo **mais operacional**. Uma página que registra uma paleta é uma referência; uma página que explica os papéis das cores, combinações válidas, comportamento em diferentes superfícies, requisitos de contraste, exemplos e exceções já funciona como instrumento de decisão. Essa distinção aparece na passagem da paleta da IBM para regras específicas de “Color in UI” e também na organização do GOV.UK entre styles, components e patterns. citeturn19view2turn15view0

A segunda implicação é que **a marca deve ser traduzida, não simplesmente transferida**. Os mesmos assets utilizados em comunicação institucional não necessariamente funcionam da mesma maneira em interfaces densas, responsivas e interativas. O ecossistema IBM explicita essa passagem ao ligar Design Language e Carbon, enquanto Shopify mostra que até dentro de uma única linguagem de UI as superfícies podem oferecer capacidades distintas. citeturn19view0turn20view0

A terceira é considerar **acessibilidade como parte da especificação**, e não uma checagem final. Para uma futura auditoria, “temos a cor da marca?” é insuficiente; seria necessário perguntar também onde ela pode ser usada, com que foreground/background, como o mesmo significado aparece sem cor e como estados de componentes são expostos visual e programaticamente. Esses pontos derivam diretamente de WCAG 2.2. citeturn20view4turn20view5turn20view7

A quarta é distinguir **invariantes de marca** de **adaptações de contexto**. USWDS defende continuidade entre plataformas sem exigir conformidade absoluta; Polaris demonstra uma linguagem compartilhada com subsets por superfície. Para uma aplicação web e mobile, uma futura refatoração deveria, portanto, tornar explícito o que deve permanecer reconhecível e o que pode mudar por espaço, input, sistema operacional ou tarefa — mas quais são esses elementos só poderá ser determinado após conhecer a marca e o produto em questão. citeturn20view3turn20view0

Por fim, a documentação deve ser tratada como um **artefato vivo**. GOV.UK publica releases, estados de lifecycle, processo de iteração e depreciação e conecta mudanças de marca a atualizações do frontend; Carbon apresenta evolução ativa do sistema e mecanismos de contribuição. Esses casos sustentam a necessidade de pensar em manutenção, embora não determinem qual processo de governança seria adequado para esta equipe. citeturn16view0turn15view0turn19view0

## Lacunas de evidência e questões em aberto

A maior incerteza é **terminológica**. Não há, entre as fontes analisadas, uma definição normativa universal que imponha fronteiras entre brandbook, visual identity guidelines, design language, UI style guide e design system. As distinções deste relatório são, portanto, uma síntese operacional de como sistemas oficiais distribuem responsabilidades. citeturn19view0turn19view1turn18view3turn15view0

A segunda limitação é que as principais fontes são **documentação normativa e exemplos de prática**, não estudos causais comparando empresas com e sem determinado tipo de guia. Assim, é bem sustentado afirmar que IBM, GOV.UK, Atlassian, USWDS e Shopify documentam esses padrões; não seria sustentado concluir apenas dessas fontes que uma estrutura particular aumenta produtividade, reconhecimento da marca ou conversão em uma porcentagem específica. A pesquisa deliberadamente evita esse salto causal.

A cobertura também é mais forte em **web e sistemas multiplataforma** do que em especificidades de implementação nativa para iOS e Android. Um exemplo relevante é o Human Interface Guidelines da Apple, que trata Dynamic Type como mecanismo de ajuste de tamanho de texto no ecossistema Apple; uma auditoria real de aplicativo nativo deveria complementar WCAG com as orientações oficiais das plataformas efetivamente suportadas. citeturn8search2

Por fim, permanecem necessariamente abertas questões que só podem ser respondidas com evidência interna: quais superfícies o produto mantém, quais elementos constituem sua assinatura visual, onde designers e engenheiros hoje encontram ambiguidade, quais padrões são mais frequentes, quais requisitos regulatórios se aplicam e onde a implementação atual diverge da documentação. **Nenhuma dessas lacunas foi diagnosticada neste estudo**, porque o guia e o produto não foram analisados.

## Fontes

A base principal foi formada por documentação primária e vigente de organizações que mantêm sistemas digitais de grande escala. O **W3C WCAG 2.2** foi utilizado como referência normativa para cor, contraste, redimensionamento de texto, reflow, contraste não textual, interação e semântica de componentes. citeturn20view4turn20view5turn20view6turn20view7

O **U.S. Web Design System (USWDS)** foi usado para princípios de decisão, acessibilidade, pesquisa com usuários, continuidade entre dispositivos e a distinção explícita entre consistência e conformidade. citeturn20view1turn20view2turn20view3

O **GOV.UK Design System** forneceu evidência para a distinção entre styles, components e patterns, integração com orientação editorial, manutenção, lifecycle e propagação de um refresh de marca para versões do frontend. A documentação consultada estava atualizada com releases de 2026. citeturn15view0turn16view0turn16view1

A **IBM Design Language e o Carbon Design System** foram especialmente úteis para observar a relação explícita entre brand foundations, linguagem visual e implementação em produto, além de regras concretas para cor, tipografia, grid, iconografia, fotografia, ilustração, motion e visualização de dados. A página principal da IBM Design Language registra atualização em outubro de 2026. citeturn19view0turn19view1turn19view2

O **Atlassian Design System** foi utilizado como exemplo de linguagem unificada que integra foundations, accessibility e semantic tokens, inclusive tokens de motion orientados por intenção. citeturn18view3turn14search24

O **Shopify Polaris** forneceu o exemplo mais claro de consistência multiplataforma sem equivalência total entre superfícies: um framework comum é utilizado na plataforma, mas diferentes superfícies expõem subconjuntos próprios de componentes e APIs. citeturn20view0

A documentação de **Apple Human Interface Guidelines** foi consultada pontualmente para o exemplo de tipografia adaptável via Dynamic Type; ela é complementar, e não a base principal das conclusões gerais do relatório. citeturn8search2