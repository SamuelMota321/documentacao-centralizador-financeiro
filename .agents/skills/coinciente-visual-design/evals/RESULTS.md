# Results — iteration 2 (2026-10-12)

Mode: isolated baseline and with-skill subagent runs for the four scenarios. The scenario responses for 1–3 were generated before a final description-only refinement; their skill body was unchanged. Scenario 4 and the description trigger check used the final description. Contamination caveat: baseline and with-skill runs used separate contexts and were instructed not to inspect the other run or edit files. Agents shared the workspace. The author graded the outputs; the trigger-query judgment below was done by a separate agent using only the current skill name and description. This is a qualitative evaluation, not a statistical benchmark.

## Scenario assertions

| Scenario / assertion | Baseline | With skill | Evidence |
|---|---|---|---|
| 1.1 — Current repository evidence | PASS | PASS | Baseline cites web `PRODUCT.md`, `DESIGN.md`, `movement-row.tsx`, and `movimentacoes.module.css`; with skill cites the same current product and implementation sources. Neither treats the research report as implementation proof. |
| 1.2 — Guidance, behavior, inference stay distinct | PASS | PASS | Baseline has sections “Orientação documentada”, “Implementação observada”, and “Recomendação — inferência de design”; with skill has “Contexto documentado”, “Comportamento verificado”, and “Recomendação”. |
| 1.3 — Preserve discoverable origin/date; no unauthorized edit | PASS | PASS | Baseline: “A origem pode perder legibilidade por truncamento, e a data não se repete individualmente em cada linha.” With skill: “A linha atual mostra a conta” and the date remains in the sticky group header; it says no files were changed. |
| 2.1 — Identify missing question, metrics, coverage, reference dates | PASS | PASS | Baseline: “que pergunta o dashboard deve responder”, “quais métricas”, “quais fontes, categorias e períodos” and “qual é a data de referência”. With skill lists the question, metric rules, coverage, and reference date. |
| 2.2 — Do not invent financial metrics | PASS | PASS | Baseline says choosing a chart without defined metrics/data is premature; with skill says it will not choose a specific chart before those definitions and names no invented measure. |
| 2.3 — Conditional chart choice and access to values | PASS | PASS | Baseline conditions line/bar/stacked charts on the question and says values should remain accessible in labels or a table. With skill conditions charts on comparison task and recommends a text summary plus a table or underlying values. |
| 2.4 — Distinguish planned dashboard/examples from confirmed data | FAIL | PASS | Baseline output did not cite current product docs or distinguish examples from available dashboard data (confirmed by the baseline agent). With skill: “o dashboard é descrito como uma etapa futura” and “os gráficos de exemplo do guia usam valores fictícios”, with links to `PRODUCT.md` and the Style Guide. |
| 3.1 — Current mobile docs and implementation | PASS | PASS | Baseline cites mobile `PRODUCT.md`, `DESIGN.md`, `AccountsScreen.tsx`, and `controls.tsx`. With skill cites those files and the current screen/control values. |
| 3.2 — State source/unit and unresolved ambiguity | PASS | PASS | Baseline says docs write `px` without clarifying physical, CSS, or logical units. With skill distinguishes documented `44px` from React Native's numeric density-independent dimensions and says the docs do not define equivalence. |
| 3.3 — Do not claim device testing | PASS | PASS | Baseline: “Não houve teste em aparelho nem avaliação física de acessibilidade.” With skill: “não fiz teste de acessibilidade em dispositivo.” |
| 4.1 — Identify non-visual request as out of scope | PASS | PASS | Baseline: “A solicitação é de backend e está fora do escopo de design visual.” With skill: “fora do escopo da skill `coinciente-visual-design`.” |
| 4.2 — No backend/product changes | PASS | PASS | Baseline: “Não alterei arquivos.” With skill: “Não alterei nenhum arquivo.” |

## Description trigger check

Qualitative classification against the final skill name and YAML description only; all ten labels matched the expected labels in `EVALS.md`.

| Query | Expected | Judged | Result |
|---|---|---|---|
| Visually heavy account list | Trigger | Trigger | PASS |
| Web movement hierarchy/date/origin/states | Trigger | Trigger | PASS |
| Coinciente mobile summary sketch | Trigger | Trigger | PASS |
| Generic monthly-expense chart choice in this repository | Trigger | Trigger | PASS |
| Color-only interface states/accessibility | Trigger | Trigger | PASS |
| Backend transfer validation | Do not trigger | Do not trigger | PASS |
| Categorize spending CSV | Do not trigger | Do not trigger | PASS |
| Unit tests for balance calculation | Do not trigger | Do not trigger | PASS |
| Accounts API 500 | Do not trigger | Do not trigger | PASS |
| Build and publish mobile app | Do not trigger | Do not trigger | PASS |

## Validation and limitations

- Skill Forge validator: `python .agents/skills/skill-forge/scripts/validate_skill.py .agents/skills/coinciente-visual-design` — exit code 0; 0 errors; one accepted `W108` warning because the user explicitly chose to omit `license`.
- No product-code, dependency, or product-documentation edits were made. Web and mobile repositories showed no working-tree changes at the status check. The backend repository showed unrelated working-tree changes at the final status check; they were left untouched.
- The mobile evaluation cites React Native's official dimensions documentation to explain its numeric unit semantics. No physical-device test or rendered-browser visual test was performed.
- The evaluations are qualitative responses from isolated agents, not a measured trigger-rate benchmark or automated visual/accessibility test.