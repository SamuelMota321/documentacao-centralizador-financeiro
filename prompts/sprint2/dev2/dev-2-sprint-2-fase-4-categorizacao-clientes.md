# Prompt: Dev 2 Sprint 2 — Phase 4 Categories and Manual Categorization in the Clients (S2-05)

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phase 3 is complete and its handoff is recorded.
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
You are a senior frontend engineer specialized in Next.js and React Native/Expo, CRUD management interfaces, explicit uncertainty states, and accessible selection controls.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 4. Phases 1–3 must be complete. Read their "Execution handoff" sections, especially the Phase 1 answers about whether GET /categories returns archived categories and what PATCH .../category returns for transfer entries.

Read and follow every applicable AGENTS.md. On web, read the relevant Next.js guide before writing routes or Server Actions.

Task

Complete Dev 2's contribution to S2-05 ("Interfaces e estados"): category management and categorization of transactions, independently in each client. Dev 1 owns the backend; Dev 3 validates uncertain and cross-tenant cases.

S2-05 acceptance criteria from the Sprint 2 plan:

- A transaction can receive a permitted category of the same tenant.
- An uncertain or unrecognized result remains explicit.
- The user can correct the category.
- The correction is persisted and reflected in both clients.
- No minimum accuracy is declared without a dataset and executed evidence.
- Cross-tenant attempts are denied without revealing foreign data.

Contract rules to respect (especificacao-transactions.html §9–10, re-verify against OpenAPI):

- Categories are always user-owned (source = user). There are no general or seeded categories in Sprint 2, so a new user starts with an empty category list.
- active categories can be assigned; archived categories remain visible in history but cannot be assigned again. There is no hard delete, only deactivate (archive).
- PATCH /transactions/{id}/category accepts exactly one of: { categoryId } or { categorizationStatus: "uncertain" | "unrecognized" }.
- Manual correction persists categorizationSource = "manual"; a rule-applied category has categorizationSource = "rule". Manual correction wins over a rule.
- Transfer entries use not_applicable and cannot be categorized.
- There is no way to return a transaction to unclassified through the contract.

Build, in each client independently:

1. Category management screen
   - Paginated list with name and status as text ("Ativa" / "Arquivada"); archived categories visually secondary but readable.
   - Create category (name 1–100, trimmed); rename (PATCH name); archive with an explicit confirmation explaining that the category stays in history and can no longer be assigned.
   - Empty state explaining that categories are personal and inviting the user to create the first one.
   - Handle 400 field errors, 404 CATEGORY_NOT_FOUND (neutral), 409 conflicts (for example duplicate name if the backend enforces it — verify; do not assume), 401/403/500.
   - Update the UI only after the API confirms.

2. Categorization status in the movements list (extends Phase 3)
   - Show, as text plus optional icon (never color alone):
     - categorized + manual: category name and "definida por você"
     - categorized + rule: category name and "aplicada por regra"
     - unclassified: "Sem categoria"
     - uncertain: "Categoria incerta"
     - unrecognized: "Não reconhecida"
     - not_applicable (transfers): "Não se aplica" and no action
   - If categoryId points to an archived category, still show its name with "(arquivada)". If the category cannot be resolved, show a neutral fallback, never a raw UUID.

3. Categorize / correct action
   - Available only for income/expense entries with status posted.
   - Offers: choose an active category; mark as "incerta"; mark as "não reconhecida".
   - The category selector lists only active categories, loaded with the Phase 2 pagination helper; if the list is truncated, say so.
   - If there are no active categories, guide the user to create one first (link to the management screen).
   - Handle 409 CATEGORY_ARCHIVED (the category was archived meanwhile: refresh the selector and explain), 404 CATEGORY_NOT_FOUND or TRANSACTION_NOT_FOUND (neutral, refresh list), 409 TRANSACTION_CATEGORIZATION_NOT_ALLOWED (for example a transfer: explain and hide the action), 400, 401, 403, 500.
   - After success, update the row from the returned TransactionView (not from local assumptions).

4. Cross-client reflection
   - Each client re-fetches on focus/navigation (mobile) or revalidates the route (web) so that a correction made on one client is visible on the other after refresh. Do not introduce real-time sync.

5. Honesty rules
   - No text claims automatic categorization accuracy, "inteligência", or percentages.
   - Uncertain and unrecognized states are presented as normal, actionable states, not errors.

Workflow

1. Model-selection assessment (AGENTS.md).
2. Verify Phases 1–3 from repository evidence.
3. Enumerate edge cases: new user with zero categories; category archived while the selector is open; renaming a category used by many transactions (the list shows the new name after refresh); correcting a rule-applied category; marking uncertain after being categorized; attempting to categorize a transfer entry; 404 for a transaction deleted/voided or belonging to another tenant; name with only spaces; name with 100 and 101 characters; accented names.
4. Present a plan per repository: screens/routes, state machines, exact files, exact code or diffs, risks, validation commands, and a manual verification script.
5. Wait for: planejamento aprovado, pode implementar
6. Implement web and mobile separately.
7. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test; git diff --check. Run the manual verification script against a local backend with fictitious data, including a correction made on web and observed on mobile.
8. Append an "Execution handoff" section to this prompt file and suggest one commit message per repository.

Constraints

- Do not modify the backend. Report contract gaps to Dev 1.
- Do not implement personal rules in this phase (Phase 5).
- Do not create seeded, default, or "general" categories in the client.
- Do not hard delete categories or simulate deletion.
- Do not add dependencies beyond those approved in Phase 1.
- Do not share code between repositories.
- Do not persist categories or transactions in client storage or logs.
- Preserve unrelated user changes. Use fictitious data only.

Output

During planning: per-repository plan with exact paths and code. After implementation: cause, changed files, validation actually executed, manual verification results, and remaining risks.

Acceptance criteria

- All S2-05 acceptance criteria from the Sprint 2 plan are satisfied with evidence in both clients.
- Category create, rename, and archive work with confirmation for archive and UI updates only after API confirmation.
- Every categorization state is visible as text, including uncertain, unrecognized, and not_applicable.
- Manual correction and uncertain/unrecognized marking work and are reflected on both clients after refresh.
- Archived categories remain readable in history and are never offered for assignment.
- Lint, type-check, and build pass in each client or genuine blockers are reported.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | S2-05 Dev 2 part: interfaces and states | Plano_Divisao_Atividades_Sprint_2.html |
| Acceptance criteria | Copied from S2-05 in the Sprint 2 plan | Plano_Divisao_Atividades_Sprint_2.html |
| Category model | User-owned, active/archived, no hard delete, no seed | especificacao-transactions.html §9 |
| Categorization states | unclassified, categorized, uncertain, unrecognized, not_applicable; source manual/rule | especificacao-transactions.html §10 + OpenAPI |
| PATCH body | oneOf categoryId or categorizationStatus uncertain/unrecognized | OpenAPI at fa9b62a |
| Error codes | CATEGORY_NOT_FOUND, CATEGORY_ARCHIVED, TRANSACTION_NOT_FOUND, TRANSACTION_CATEGORIZATION_NOT_ALLOWED | backend source at fa9b62a |
| Dependency policy | Only what Phase 1 approved | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **repository evidence** — verified on 2026-09-23; **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.

## Execution handoff — Phase 4 (2026-09-24)

Executed by Dev 2 after explicit approval, on top of the uncommitted Phases 1–3 working tree. Backend reference: `fa9b62a` (read-only, unchanged).

### Contract findings for Dev 1

1. **Duplicate category name returns 500.** `categories_tenant_name_key` is a unique index on `(tenant_id, name)`, but no adapter maps the violation; the Transactions problem filter falls back to `INTERNAL_ERROR`. Derived from source reading, not from a live request. The uniqueness is exact (case-sensitive) and includes archived categories, so an archived "Mercado" blocks creating a new "Mercado". Suggested: map to 409 with a dedicated code, and decide whether archived names should stay reserved.
2. Renaming an archived category returns 400 `INVALID_REQUEST` without `errors[]` (`InvalidCategoryState`); archiving an already archived category returns 200 (idempotent). Marking a transaction as uncertain/unrecognized clears `categoryId`.
3. The Phase 2 comment "Nomes repetidos sao aceitos" in `lib/categories/types.ts` was wrong and has been corrected in both clients.

### Client decisions

- Both clients check for a duplicate name before create/rename by listing all categories and comparing the normalized name exactly (mirroring the index). If the listing fails for a non-session reason, the request proceeds and a 500 shows a safe message that mentions the likely duplicate.
- UI strings stay unaccented, consistent with Phases 1–3; accent normalization remains a separate pending task.
- Category labels: "{nome} · definida por voce" (manual), "{nome} · aplicada por regra" (rule), "{nome} (arquivada)" for archived, "Categoria indisponivel" when unresolved (never a UUID), "Sem categoria", "Categoria incerta", "Nao reconhecida", "Nao se aplica". No text claims accuracy or "inteligencia".

### Web (`web-centralizador-financeiro`)

- `src/proxy.ts`/`proxy.test.ts`: `/categorias` protected. `src/app/app-nav.tsx`: "Categorias" link.
- `src/lib/session.ts`: `accessTokenOrNull` and `isAuthFailure`, now shared by the movements and categories Server Actions (extracted from the Phase 3 actions).
- `src/app/categorias/`: `page.tsx` (paginated list, status as text, empty state, notices), `actions.ts` (create, rename, archive with duplicate check; rename/archive redirect with a closed-list notice; revalidates `/categorias` and `/movimentacoes`), `category-form.tsx`, `category-item.tsx` (inline rename; archive confirmation explaining history is kept), `category-names.ts`, `notices.ts`, `reauth-link.tsx`, `loading.tsx`, `error.tsx`, `categorias.module.css`, tests.
- `src/app/movimentacoes/`: `page.tsx` loads all categories (active and archived) alongside accounts and transactions, with a partial-data notice; rows keyed by `id:updatedAt`; `presentation.ts` (`categorizationLabel` with categories, `canCategorize`); `categorize-control.tsx` (only income/expense `posted`; active categories only; "Aplicar categoria", "Marcar como incerta", "Marcar como nao reconhecida"; link to `/categorias` when none active; truncation notice); `actions.ts` `categorizeTransactionAction` (CATEGORY_ARCHIVED, CATEGORY_NOT_FOUND, TRANSACTION_NOT_FOUND and TRANSACTION_CATEGORIZATION_NOT_ALLOWED explain and revalidate; 401/403 re-login; 400/500 safe message). The row is re-rendered from the server's TransactionView after revalidation.

### Mobile (`mobile-centralizador-financeiro`)

- `SectionTabs.tsx`/`App.tsx`: "Categorias" section.
- `CategoriesScreen.tsx` (paginated list with "Carregar mais", pull-to-refresh, archive confirmation via `Alert`), `CategoryFormScreen.tsx` (create/rename; full-list duplicate check at submit), `CategorizeScreen.tsx` (active categories only; on success the row is replaced by the returned TransactionView; stale cases return to the list with a notice and reload).
- `MovementsScreen.tsx`: loads categories, shows the new labels, "Categorizar"/"Corrigir categoria" action outside the grouped accessibility element; `use-foreground-refresh.ts` reloads movements and categories when the app returns to the foreground (cross-client reflection without real-time sync).
- `category-logic.ts` and `movement-presentation.ts` (`categorizationLabel`, `canCategorize`, `replaceItem`) covered by Vitest.

### Validation (executed)

- Web: `pnpm lint` passed; `pnpm typecheck` passed; `pnpm test` 307/307 (21 files); `pnpm build` passed (`/categorias` dynamic route).
- Mobile: `pnpm typecheck` passed; `pnpm test` 259/259 (17 files); `npx expo export --platform android` bundled.
- `git diff --check` clean in both clients.
- `next dev` smoke: `/` 200; `/categorias` without session 307 → `/auth/login`.

### Manual verification — web (2026-09-24)

Run by Dev 2 in the browser against the local backend (Docker Desktop: API on `localhost:3100`, PostgreSQL on `localhost:55432`) with fictitious data. Dev 2 reported the script as passing. **Log corroboration is partial:** the web server log for this run shows one category created (`createCategoryAction`) and one categorization (`categorizeTransactionAction`), with no server errors; rename, archive, duplicate-name and archived-in-another-tab steps do not appear in it and rest on Dev 2's report only.

| # | Scenario | Result |
|---|---|---|
| 1 | Empty categories state; "Criar uma categoria" link in the categorize panel | Reported OK |
| 2 | Duplicate "Mercado" rejected without request; " mercado " accepted | Reported OK |
| 3 | Only spaces and 101 characters rejected; 100 characters and accented name accepted | Reported OK |
| 4 | Categorize, correct, mark uncertain, mark not recognized | Reported OK; one categorization in the log |
| 5 | Rename shows the new name in movements | Reported OK |
| 6 | Archived category shows "(arquivada)" and is not offered | Reported OK |
| 7 | Category archived in another tab while the panel is open | Reported OK |
| 8 | Transfers show "Nao se aplica" and no action | Reported OK |
| 9 | Correction on web observed on mobile | **Blocked** — Auth0 Native application missing in tenant `dev-2u6c8lewawdbjx83` |

### Suggested commit messages

- web: `feat(categorias): gerenciar categorias e categorizar movimentacoes com estados explicitos`
- mobile: `feat(categorias): telas de categorias e categorizacao de movimentacoes`
- documentacao: `docs(dev2S2): registrar handoff da fase 4 do Dev 2`
