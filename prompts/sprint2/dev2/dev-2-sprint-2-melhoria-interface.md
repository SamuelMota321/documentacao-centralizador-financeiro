# Dev 2 Sprint 2 — Etapa de melhoria da interface (web e mobile)

- Cenário: melhoria de interface entre as Fases 4 e 5
- Executado: 2026-09-24 · Base: commits das Fases 1–4 (web `81f032c`, mobile `b3c63aa`)
- Skills usadas: `impeccable` (modo Operate, piso de qualidade e detector), `emil-design-eng` (acabamento e microinterações); `design-taste-frontend` e `mobile-native` foram consultadas e descartadas por não se aplicarem a interface de produto nem a React Native.

## Motivo

A interface das Fases 1–4 funcionava, mas era genérica e não implementava o Style Guide 1.0: sem estrutura de aplicativo, formulário acima do conteúdo principal, Newsreader em títulos de seção, listas sem colunas, saldo sem formatação em Contas, nenhum ícone, avisos sem semântica, textos sem acento e, no mobile, fonte do sistema, sem tema escuro e sem área segura.

## Decisões do usuário

- Escopo web e mobile juntos; estrutura do Style Guide (web: barra superior + navegação lateral; mobile: cabeçalho com símbolo + abas embaixo).
- Correção de todos os textos para português com acentos.
- Dependências novas aprovadas no mobile: `expo-font`, `@expo-google-fonts/manrope`, `@expo-google-fonts/newsreader`, `react-native-safe-area-context`, `react-native-svg`.

## Registros criados (nos dois clientes)

- `PRODUCT.md`: público, propósito, posicionamento, restrições, compromissos de marca e princípios (fontes: Visão 1.3, PRD 1.4, Style Guide 1.0).
- `DESIGN.md`: tokens claro/escuro, escala tipográfica, raios, componentes e regras, traduzidos do Style Guide. Contrastes medidos: texto secundário 4,63:1 (claro) e 7,9:1 (escuro); verde de ação 5,35:1; borda de campo 3,44:1.

## Web

- Tokens do guia em `globals.css` (temas claro e escuro, `positive`/`negative`/`warning`/`info`, raios 9/13/20px), superfícies do navegador tematizadas (seleção, cursor, rolagem, foco) e `prefers-reduced-motion`.
- Estrutura `src/app/(app)/` (URLs inalteradas): barra superior com a assinatura Coinciente e "dados fictícios"; navegação lateral com ícones e item ativo; link "Pular para o conteúdo"; em telas estreitas a navegação vira faixa horizontal.
- Componentes compartilhados em `src/components/`: símbolo da marca, 14 ícones SVG próprios, cabeçalho de página, aviso com ícone, etiqueta de status (ponto + texto), estado vazio, esqueleto, erro de campo.
- Telas: histórico em colunas (movimentação · categoria · valor à direita), painel de registro aberto pela ação do cabeçalho (`?registrar=1`, sem modal, já aberto quando a lista está vazia); Contas com saldo inicial formatado em BRL e data de referência; Categorias no mesmo padrão; esqueletos de carregamento e estados de erro com recuperação; página inicial como entrada da marca (único uso de Newsreader).
- `src/lib/session.ts` concentra `accessTokenOrNull`/`isAuthFailure`.

## Mobile

- `src/theme.ts`: tokens claro/escuro via `useColorScheme`, pesos da Manrope por arquivo, escala tipográfica e `makeStyles` por esquema de cor.
- `src/ui/`: símbolo e assinatura, ícones SVG, `Button` (primário, secundário, perigo, texto, texto-perigo; 48dp; retorno ao toque), `Notice`, `StatusChip`, `EmptyState`, `SkeletonList`, `Field`/`TextField`/`ChoiceGroup`, `AppScreen` (cabeçalho, título, ação no rodapé, abas embaixo, áreas seguras) e `FormScreen` (tela cheia, fechar no topo, ação fixa acima do teclado, **Voltar do Android fecha o formulário**).
- Todas as telas refeitas sobre esses componentes, sem mudar a lógica das Fases 3–4. A data de referência do saldo em Contas passou a ser digitada em DD/MM/AAAA.
- Fontes importadas por peso: os arquivos do app caíram de 2,4 MB para 504 KB.

## Textos

Script de acentuação aplicado somente dentro de literais de string (comentários, identificadores, slugs de URL e âncoras intactos), revisado em simulação antes de gravar; testes atualizados na mesma passada. Os testes de vocabulário proibido passaram a cobrir também "bancária" e "inteligência".

## Validação executada

- Web: `pnpm lint` ok; `pnpm typecheck` ok; `pnpm test` 313/313 (21 arquivos); `pnpm build` ok; detector `impeccable` sem achados (os avisos de escala e raio foram resolvidos no `DESIGN.md` e nos tokens); `git diff --check` limpo; `next dev`: `/` 200 com a nova entrada, rotas do app 307 → login sem sessão.
- Mobile: `pnpm typecheck` ok; `pnpm test` 265/265 (17 arquivos); `npx expo export --platform android` ok (896 módulos); detector sem achados; `git diff --check` limpo.

## Pendências

- Conferência visual final pelo Dev 2 no navegador (claro e escuro, desktop e celular): não há automação de navegador neste ambiente.
- Verificação do mobile em aparelho continua bloqueada até existir a aplicação Native no Auth0 (tenant `dev-2u6c8lewawdbjx83`).
- `npx expo install --check` aponta `expo-auth-session` 57.0.12 → ~57.0.13 esperado (anterior a esta etapa; não alterado).

## Mensagens de commit sugeridas

- web: `feat(interface): aplicar o Style Guide com estrutura de app, componentes e textos acentuados`
- mobile: `feat(interface): tema claro e escuro, fontes da marca, abas e componentes do Style Guide`
- documentacao: `docs(dev2S2): registrar a etapa de melhoria da interface`
