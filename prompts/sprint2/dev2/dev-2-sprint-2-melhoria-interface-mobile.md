# Dev 2 Sprint 2 — Extensão: reformulação de interface do mobile

- Cenário: extensão da Sprint 2, depois da Fase 7 e da reformulação de interface do web
- Status: **planejado, aguardando aprovação** (`planejamento aprovado, pode implementar`) — nenhum código foi alterado ainda
- Planejado: 2026-09-25 · Base: commit mobile `144691e` (Fase 7)
- Motivo: paralelamente ao web, o app mobile precisa da mesma passada de reformulação de interface, com correções próprias de plataforma (não é port do web — plataformas, tokens e componentes diferentes; sem código compartilhado)
- Skills consultadas: `animate-expo` e `apple-design` (aplicáveis); `mobile-native` descartada — é para apps web/PWA em navegador, não para Expo/React Native; `impeccable` para o detector e os registros de `PRODUCT.md`/`DESIGN.md`

## Diagnóstico

**Bug de dados, prioridade máxima:**
- `src/screens/AccountsScreen.tsx:46` chama `listAccounts()` sem paginar (busca só a primeira página, 20 contas). A partir da 21ª conta criada, ela existe no backend mas nunca aparece na lista, sem nenhum aviso. `CategoriesScreen` e `RulesScreen` já paginam corretamente (`FlatList` + "Carregar mais"); só Contas ficou para trás.

**Bug de configuração:**
- `app.json` tem `"userInterfaceStyle": "light"`, herdado do scaffold do Expo. Isso trava o app em modo claro para o sistema operacional: `useColorScheme()` nunca recebe `"dark"`, então o tema escuro já implementado em `src/theme.ts` e documentado no `DESIGN.md` nunca ativa em build real.

**Paridade com a reformulação do web, sem dependência nova:**
- Histórico de Movimentações é uma lista plana, sem agrupamento por dia (o `SectionList` nativo do React Native resolve isso com `stickySectionHeadersEnabled`, sem biblioteca).
- Nenhuma tela tem o bloco "Primeiros passos" (conta → movimentação → categoria) que o web ganhou.
- Nenhuma linha nova recebe destaque visual após criar uma movimentação.
- Em `AccountsScreen` (2 botões de texto) e `RulesScreen` (3 botões de texto, `flexWrap: "wrap"`), as ações lado a lado podem quebrar linha de forma estranha com Fonte Dinâmica grande — equivalente mobile, mais brando, do problema resolvido no web com o menu "Mais ações".
- Confirmações destrutivas já usam `Alert.alert` nativo — correto, mantido sem mudança.
- Retorno ao toque já usa `Pressable`/`pressed` nativo — correto, sem necessidade de Reanimated.

## Escopo e dependências

Sem dependências novas no plano principal: tudo é resolvido com `SectionList`, `Modal` e `Animated` do próprio React Native.

- Um componente `ActionSheet` próprio (`Modal` + `Pressable`, ancorado embaixo, respeitando a área segura) substitui os botões de texto que podem quebrar linha em Contas e Regras: uma ação visível (“Editar”) + um botão “Mais” que abre a folha com o restante. Item destrutivo em `negative`. As confirmações continuam no `Alert.alert`, sem mudança.
- **Fora do plano principal, dependência opcional a aprovar separadamente:** `expo-haptics`, para toque tátil ao confirmar ou errar (padrão da skill `animate-expo`). Nada depende dela para funcionar.
- **Não entra:** `react-native-reanimated` / `react-native-gesture-handler`. Nada no plano exige gesto contínuo ou física de mola; usá-las só para isto seria desproporcional.

## Plano de implementação

1. Corrigir a paginação de `AccountsScreen` (mesmo padrão de `CategoriesScreen`/`RulesScreen`).
2. Corrigir `userInterfaceStyle` para `"automatic"` em `app.json`, destravando o tema escuro já implementado.
3. Agrupar o histórico de Movimentações por dia com `SectionList` (cabeçalho fixo "Hoje" / "Ontem" / data por extenso, reimplementado em `src/lib/civil-date.ts`, sem importar do web).
4. Destacar a linha recém-criada após registrar uma movimentação (`Animated.timing` de opacidade/cor, um único disparo, sem gesto).
5. Bloco "Primeiros passos" em Movimentações (conta → movimentação → categoria), com o próximo passo em destaque, some quando os três estiverem feitos.
6. `ActionSheet` em Contas e Regras (ação visível + "Mais ações"); avaliar caso a caso se Categorias (2 botões, não quebra linha na prática) precisa do mesmo tratamento.
7. Resumo de página ("20 de 143") junto do "Carregar mais" nas quatro listas paginadas.
8. Revisão de acessibilidade (alvos de 44pt, Fonte Dinâmica) nos componentes tocados.
9. Atualizar `PRODUCT.md`/`DESIGN.md` do mobile com o que mudar (agrupamento por dia, `ActionSheet`, destaque de linha nova, primeiros passos).
10. Testes novos em Vitest para a lógica pura: agrupamento por dia, data por extenso relativa ("Hoje"/"Ontem"), passos concluídos dos primeiros passos.

## Validação planejada

`pnpm typecheck`, `pnpm test`, `npx expo export --platform android`, detector `impeccable`, `git diff --check`.

**Limitação, sem mudança em relação às fases anteriores:** não há verificação visual automatizada no mobile. O ambiente não tem `react-native-web` instalado, então o truque de captura por Chrome headless usado no web não se aplica aqui. A conferência em aparelho físico ou emulador continua dependendo do usuário, e a evidência de ponta a ponta continua bloqueada até existir a aplicação Native no Auth0 (mesma pendência já registrada nas fases anteriores).

## Como prosseguir

Aguardando a frase `planejamento aprovado, pode implementar` do usuário antes de qualquer alteração no repositório mobile. Após a implementação, esta seção será substituída por um "Execution handoff" com o que foi feito, a validação executada e as mensagens de commit sugeridas, no mesmo padrão dos arquivos de fase.
