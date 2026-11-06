# Fase 1 — Auditoria e inventário de movimento

- Plano: `Plano_Refatoracao_Frontend.html` (F1)
- Data: 22/10/2026 · Modo: somente leitura (nenhum arquivo de produto alterado)
- Skills: `coinciente-visual-design` (fluxo), `improve-animations` (critérios de auditoria)
- Repositórios: `web-centralizador-financeiro` e `mobile-centralizador-financeiro`

Legenda de evidência (exigida pela `coinciente-visual-design`): **[doc]** documentado no `DESIGN.md`; **[verificado]** conferido no código; **[inferência]** recomendação de design; **[hipótese]** depende de teste em navegador ou aparelho.

## Web

### Visão geral

89 declarações de movimento em 10 arquivos CSS. Não há `ease-in`, `transition: all`, `scale(0)` nem `:hover` fora de `(hover: hover) and (pointer: fine)` **[verificado]**. Curvas fortes em tokens (`--ease-out`, `--ease-in-out`, `--ease-drawer`), menus com origem no gatilho (`--transform-origin` do Base UI), saídas mais rápidas que entradas e movimento reduzido tratado no diálogo **[verificado]**. O movimento do web está, em grande parte, correto.

### Achados

| # | Gravidade | Onde | Achado | Evidência |
|---|---|---|---|---|
| 1 | MÉDIA | `src/app/globals.css:231`; `src/components/ui.module.css:228-238` | Com movimento reduzido, a regra global restringe `transition-property` a `opacity, color, background-color, border-color` com `!important`. Sem `display` na lista, o `.reveal` some de imediato ao receber `hidden`, sem a saída por opacidade. A mesma regra remove o `text-decoration-color` do botão-link (`ui.module.css:174`), que é só cor. Contraria o `DESIGN.md`: "reduzido não é zero". | [verificado] pela semântica do CSS; confirmação no DevTools pendente [hipótese] |
| 2 | BAIXA | `ui.module.css:843-845` e `:978`; `movimentacoes.module.css:251-253`; `page.module.css:99-101` | 160ms, 320ms e 600ms escritos direto, fora dos tokens. Comportamentos documentados [doc]; falta só tokenizar. | [verificado] |
| 3 | BAIXA | `src/app/(app)/shell.module.css:427` | Atalho mobile com `scale(0.94)` ao toque; o restante usa 0,97, valor documentado para botões. | [verificado] |
| 4 | BAIXA | `shell.module.css:483-488` com `globals.css:228` | Sombra dirigida por scroll: sob movimento reduzido, `animation-duration: 0.01ms` provavelmente a torna instantânea. Inofensivo. | [hipótese] |

### Rejeitados (documentados ou corretos)

- Passo concluído com `scale(0.8)`: momento raro documentado [doc].
- Tinta de 1600ms na linha recém-criada via keyframes: dispara uma vez, intencional, com override próprio de movimento reduzido [doc].
- 600ms na prévia da página inicial: superfície de apresentação.
- Diálogo com origem no centro: correto para modal.
- `--index` do controle segmentado no elemento pai: 2–3 filhos, custo desprezível.
- `box-shadow` na transição do botão: repintura apenas em hover/foco.

### Oportunidades

- Bloco recolhível abre sem transição; só a seta gira (`ui.module.css:535`). Usar `::details-content` com `interpolate-size: allow-keywords` como melhoria progressiva [inferência].
- Navegação entre páginas sem transição: crossfade com `<ViewTransition>` (F4) [inferência].

## Mobile

### Visão geral

Nenhuma animação nem biblioteca de movimento. Retorno ao toque por troca de estilo em `Pressable`; navegação por estado local **[verificado]**.

### Achados

| # | Gravidade | Onde | Achado | Evidência |
|---|---|---|---|---|
| M1 | MÉDIA | `App.tsx:35-50`; `src/screens/AccountsScreen.tsx:46` e padrão equivalente nas demais telas | Toda troca de tela é instantânea: seções por `useState` e lista → formulário/OFX/Conectar por `mode`. Não há explicação espacial nem gesto de voltar. Principal justificativa da F5. | [verificado] |
| M2 | MÉDIA | app inteiro | Não há infraestrutura de movimento reduzido (`AccessibilityInfo` ou `useReducedMotion`). Precisa existir antes de qualquer animação. | [verificado] |
| M3 | BAIXA | `src/ui/controls.tsx:99`; `src/ui/screens.tsx:152` e `:238`; `src/ui/fields.tsx:124`; `src/screens/MovementsScreen.tsx:477` | Retorno ao toque inconsistente: botão 0,88 + escala 0,98; linhas 0,7; chips 0,85. Troca instantânea; a volta "estala". Com Reanimated: entrada imediata, volta com spring. | [verificado]; sensação só no aparelho [hipótese] |

### Rejeitado

- `ActivityIndicator` central no Splash (`App.tsx:47`): ocorre antes de existir conteúdo (carregamento de fontes); não fere "sem spinner no meio do conteúdo".

## Registro de decisões (insumo da F2)

| Decisão | Recomendação | Quem decide | Bloqueia |
|---|---|---|---|
| Tokens finais | 160ms aparece na entrada do menu e na saída do diálogo; `--motion-exit` seria enganoso. Proposta: `--motion-feedback` 120, `--motion-hover` 180, `--motion-popover` 160, `--motion-reveal` 240, `--motion-settle` 320, `--motion-intro` 600, `--motion-arrival` 1600. `--duration-*` atuais como aliases na transição. | Miguel e Samuel | F2, F3 |
| Correção do movimento reduzido | Acrescentar `display, text-decoration-color, outline-color` ao `transition-property` de `globals.css:231`. | Equipe | F3 |
| Escopo do `<ViewTransition>` | Só crossfade nesta rodada; morph lista → detalhe hoje se aplicaria apenas à conexão Pluggy. | Equipe | F4 |
| Formulários no mobile | Por tamanho: formulários longos (conta, OFX, Conectar) na pilha com transição nativa; folha inferior só para tarefas curtas (ex.: categorizar). Registrar a mudança no `DESIGN.md` mobile. | Equipe e Developer 2 | F2, F5 |
| Hook do impeccable | Resolvido na F0: removido. | — | Não |
| Coordenação com Developer 2 e S4-06 | Em aberto. F3–F6 não começam antes. | Miguel | F3–F6 |

## Limites

- Navegador e aparelho não foram usados: itens 1, 4 e M3 exigem checagem manual. Para o item 1: DevTools → Rendering → `prefers-reduced-motion: reduce`, abrir e fechar o painel "Registrar movimentação".
- Planos de execução no formato do `improve-animations` não foram gerados; a execução segue os prompts F3–F5 em `prompts/refatoracao-frontend/`.
