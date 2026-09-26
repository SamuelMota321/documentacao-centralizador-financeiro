# Prompt: Dev 2 Sprint 2 — Phase 5 Personal Categorization Rules in the Clients (S2-06)

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phase 4 is complete and its handoff is recorded.
2. Open a new Codex task with these workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only)
3. `git pull` all four repositories.
4. Use Plan mode. Authorize only with: `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer specialized in Next.js and React Native/Expo, rule-builder interfaces with constrained grammars, lifecycle management UX, and transparent explanation of deterministic precedence.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 5. Phases 1–4 must be complete. Read their "Execution handoff" sections, especially the Phase 1 answers about whether GET /category-rules returns removed rules, whether rules are applied on POST /transactions, and the DELETE response divergence (OpenAPI 200 with body vs specification "200/204").

Read and follow every applicable AGENTS.md. On web, read the relevant Next.js guide before writing routes or Server Actions.

Task

Complete Dev 2's contribution to S2-06 ("Gestão de regras nos clientes"): create, edit, activate, deactivate, and remove personal categorization rules, independently in each client. Dev 1 owns domain/API/precedence; Dev 3 owns conflict validation.

S2-06 acceptance criteria from the Sprint 2 plan:

- Rule, condition, and category belong to the same tenant.
- Personal rules prevail over general rules if those exist in the approved baseline (they do not in Sprint 2; do not show a "general rules" concept).
- Conflicts follow deterministic and informed precedence.
- Rules can be created, edited, activated, deactivated, and removed.
- Changes affect only the authenticated tenant.
- Clients present states and failures consistent with the contract.

Contract rules to respect (especificacao-transactions.html §11–12, re-verify against OpenAPI):

- Exactly one condition per rule. Allowed combinations only:
  - conditionField = description with operator equals, contains, starts_with, or ends_with; value is text, compared case-insensitively after the backend's normalization.
  - conditionField = type with operator equals; value is income or expense.
  - conditionField = accountId with operator equals; value is an account UUID of the same tenant.
- No multiple conditions, OR, numeric operators, regex, or free expressions.
- priority is an integer >= 0. Higher priority wins; ties are broken by createdAt ascending, then id ascending. The list is ordered priority DESC, createdAt ASC, id ASC.
- Lifecycle: active participates in evaluation; inactive does not; removed cannot be reactivated.
- Manual correction beats a rule. Changing a rule does not reprocess existing transactions; rules apply when new movements are created.
- The target category must be active and of the same tenant.

Build, in each client independently:

1. Rules list
   - Shows the server order (do not reorder). Each row reads as a sentence in pt-BR, for example: "Se a descrição contém “mercado” → Alimentação · prioridade 10 · Ativa".
   - Status as text: "Ativa", "Inativa", "Removida". Removed rules (if returned) are read-only and visually secondary, per the Phase 1 decision.
   - A short, permanent explanation of precedence: higher priority wins; on a tie, the older rule wins; manual choices always prevail; rules apply only to new movements and do not change past ones.
   - Empty state explaining what a personal rule is, with a call to action. If there are no active categories, guide the user to create a category first.

2. Rule form (create and edit)
   - Step 1: field (Descrição / Tipo / Conta). Step 2: operator filtered by field (description: "é igual a", "contém", "começa com", "termina com"; type and account: only "é igual a"). Step 3: value control that depends on the field: text input for description; Receita/Despesa selector for type; active-account selector for accountId (never a raw UUID text input). Step 4: target category (active only). Step 5: priority (integer >= 0, with a helper explaining higher wins).
   - Changing the field resets incompatible operator/value choices.
   - Presentation-edge Zod validation per Phase 2; field errors mapped from errors[].path.
   - Edit uses PATCH with only changed fields; an unchanged submit is prevented client-side (the backend returns EMPTY_PATCH otherwise).
   - Handle 400, 404 CATEGORY_RULE_NOT_FOUND / CATEGORY_NOT_FOUND / ACCOUNT_NOT_FOUND (neutral), 409 CATEGORY_ARCHIVED, 409 CATEGORY_RULE_CONFLICT (show the backend detail safely and explain the precedence rule), 401, 403, 500.

3. Lifecycle actions
   - Activate / Deactivate as explicit actions with immediate feedback after API confirmation.
   - Remove with a confirmation stating that a removed rule cannot be reactivated. Treat the DELETE response per the OpenAPI (200 with the removed rule) and tolerate 204 only if Phase 1 recorded that the backend actually returns it.
   - Actions not allowed for the current status are hidden or disabled with an explanation (for example, no activate for removed).
   - The UI updates only after the API confirms.

4. Link with movements (Phases 3–4)
   - When a new movement comes back with categorizationSource = "rule", the movements list already shows "aplicada por regra" (Phase 4). Do not add retroactive "apply to existing" actions; the contract does not support reprocessing.

5. Honesty rules
   - Do not claim accuracy, intelligence, or automatic learning.

Workflow

1. Model-selection assessment (AGENTS.md).
2. Verify Phases 1–4 from repository evidence.
3. Enumerate edge cases: two active rules matching the same description with different priorities; equal priorities (older wins); rule targeting a category archived later; rule on an account archived later; editing a removed rule (must be blocked); switching field from description to type with an old text value; priority "-1", "1.5", "", very large numbers; description value with only spaces or accents; deactivate then create a movement (rule must not apply); remove then try to activate.
4. Present a plan per repository: screens/routes, form state machine, exact files, exact code or diffs, risks, validation commands, and a manual verification script that includes a precedence scenario proven by creating a new movement.
5. Wait for: planejamento aprovado, pode implementar
6. Implement web and mobile separately.
7. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test; git diff --check. Run the manual verification script against a local backend with fictitious data and record which rule was applied in each precedence scenario.
8. Append an "Execution handoff" section to this prompt file and suggest one commit message per repository.

Constraints

- Do not modify the backend. Report contract gaps to Dev 1.
- Do not implement evaluation or precedence logic in the client; the client only explains the documented rule and shows backend results.
- Do not offer operators, fields, or combinations outside the approved grammar.
- Do not add a "general rules" concept, retroactive reprocessing, or bulk actions.
- Do not add dependencies beyond those approved in Phase 1.
- Do not share code between repositories. Do not persist rules in client storage or logs.
- Preserve unrelated user changes. Use fictitious data only.

Output

During planning: per-repository plan with exact paths and code. After implementation: cause, changed files, validation actually executed, manual verification results (including precedence), and remaining risks.

Acceptance criteria

- All S2-06 acceptance criteria from the Sprint 2 plan are satisfied with evidence in both clients.
- Only the approved condition grammar can be built; account values are chosen from a selector.
- Create, edit, activate, deactivate, and remove work, with confirmation for remove and correct handling of the removed state.
- Precedence is explained in the interface and verified with a manual scenario.
- CATEGORY_RULE_CONFLICT and other confirmed codes are handled safely.
- Lint, type-check, and build pass in each client or genuine blockers are reported.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | S2-06 Dev 2 part: rule management in the clients | Plano_Divisao_Atividades_Sprint_2.html |
| Acceptance criteria | Copied from S2-06 in the Sprint 2 plan | Plano_Divisao_Atividades_Sprint_2.html |
| Condition grammar | One condition; description 4 operators; type/accountId equals | especificacao-transactions.html §11 + OpenAPI |
| Precedence | priority DESC, createdAt ASC, id ASC; manual beats rule; no reprocessing | especificacao-transactions.html §12 |
| DELETE response | OpenAPI documents 200 with body; specification says 200/204 | repository evidence (divergence) |
| Dependency policy | Only what Phase 1 approved | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **repository evidence** — verified on 2026-09-23; **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.

## Execution handoff — Phase 5 (2026-09-24)

Executed by Dev 2 after explicit approval, on top of the interface improvement stage (web `33874ee`, mobile `7cad35b`). Backend reference: `fa9b62a` (read-only, unchanged). UI follows each client's `DESIGN.md`.

### Contract findings for Dev 1 (source reading, not live requests)

1. **Priority has no upper bound.** `category_rules.priority` is `INTEGER` and neither the inbound schema nor the domain limits it; values above 2,147,483,647 should fail as 500. Both clients now cap at `MAX_RULE_PRIORITY` in `lib/category-rules/schema.ts` until the contract validates it.
2. **A rule may target an archived account.** Creation rejects only a missing account (and with `CATEGORY_NOT_FOUND`, already reported in Phase 1). Clients offer only active accounts.
3. **`EMPTY_PATCH` does not exist.** An empty PATCH returns 400 `INVALID_REQUEST`; clients never send one (Save is disabled until something changes, and the server action re-checks).
4. `CATEGORY_RULE_CONFLICT` is the removed-rule error (edit/activate/deactivate); removing an already removed rule returns 200. There is no precedence-conflict error: precedence is resolved at evaluation.

### Web (`web-centralizador-financeiro`)

- `/regras` protected (`proxy.ts`), "Regras" in the side navigation, `IconRules`.
- `src/app/(app)/regras/`: `page.tsx` (server order, `?pagina=`, permanent precedence notice, partial-data and no-active-category states, panel opened by "Nova regra"), `rule-fields.tsx` (Quando → Comparação filtered by field → value control per field: text, Receita/Despesa or active-account select, never a UUID input → active category → priority; changing the field resets incompatible choices; live sentence preview), `rule-create-panel.tsx`, `rule-item.tsx` (sentence, status as text, actions per status, remove confirmation, edit with Save disabled until dirty), `actions.ts`, `notices.ts`, `rule-logic.ts`, loading/error/CSS, tests.

### Mobile (`mobile-centralizador-financeiro`)

- Fourth tab "Regras"; `RulesScreen` (precedence notice, grouped list, load more, pull-to-refresh, foreground refresh, activate/deactivate after API confirmation, remove via `Alert`) and `RuleFormScreen` (`FormScreen`, choice groups, `number-pad` priority, live preview, Android Back cancels); `rule-logic.ts` with `classifyRuleError`, tests.

### Validation (executed)

- Web: lint ok; typecheck ok; `pnpm test` 356/356 (23 files); build ok (`/regras`); detector 0 findings; `git diff --check` clean.
- Mobile: typecheck ok; `pnpm test` 292/292 (18 files); Android export ok (902 modules); detector 0 findings; `git diff --check` clean.
- Local stack up: API `localhost:3100` (401 without token), web `/regras` 307 → login without session.

### Manual verification — web (2026-09-24, executed by Dev 2)

Dev 2 ran the script below against the local backend and reported every step as passing, including the four precedence scenarios (Feira → Alimentação on tie → Feira → Sem categoria) and the unchanged manual correction. Observation raised: date inputs rendered as MM/DD/AAAA in the browser (native `<input type="date">` follows the browser language); handled as a follow-up fix.

**Follow-up fix (2026-09-24, approved):** the web date fields (movement/transfer "Data" and account "Data de referência do saldo") are now text inputs in DD/MM/AAAA with a typing mask (`maskBrazilianDate`) and numeric keyboard; Server Actions convert with `parseBrazilianDate` (rejects non-existent dates) and show "Informe uma data válida no formato DD/MM/AAAA." on failure. The native `<input type="date">` was dropped because it follows the browser language, not the page's `lang`. `CONTRACT.md` and `DESIGN.md` updated. Validation: lint, typecheck, `pnpm test` 377/377, build ok, `git diff --check` clean. Mobile already used DD/MM/AAAA text fields.

Script:

Precedence proven with new movements (fictitious data); record the category each movement received:

1. Categories "Alimentação" and "Feira".
2. Rule A: descrição contém "mercado" → Alimentação, prioridade 10.
3. Rule B: descrição começa com "mercado bairro" → Feira, prioridade 20.
4. Expense "Mercado Bairro centro" → expected **Feira** (B has higher priority).
5. Edit B to prioridade 10; new identical expense → expected **Alimentação** (tie, A is older).
6. Deactivate A; new expense → expected **Feira**.
7. Deactivate B; new expense → expected **Sem categoria**.
8. A manual correction made before step 5 stays unchanged afterwards (no reprocessing).
9. Remove B → "Removida", read-only, no actions.
10. Rule by Tipo and by Conta (account chosen from the selector).
11. Priorities `-1`, `1.5`, empty and `2147483648` rejected inline.
12. Switching Quando from Descrição to Tipo resets the comparison to "é igual a" and clears the value.

Mobile manual verification remains blocked until the Auth0 Native application exists in tenant `dev-2u6c8lewawdbjx83`.

### Suggested commit messages

- web: `feat(regras): criar, editar, ativar, desativar e remover regras pessoais com precedência explicada`
- mobile: `feat(regras): aba de regras pessoais com formulário guiado e ciclo de vida`
- documentacao: `docs(dev2S2): registrar handoff da fase 5 do Dev 2`
