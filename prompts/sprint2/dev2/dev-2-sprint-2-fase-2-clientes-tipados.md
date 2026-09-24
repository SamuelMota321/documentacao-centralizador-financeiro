# Prompt: Dev 2 Sprint 2 — Phase 2 Typed Clients and Shared-Nothing Client Infrastructure

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phase 1 is approved and its handoff is recorded in `prompts/sprint2/dev2/dev-2-sprint-2-fase-1-baseline-contrato-clientes.md`.
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
You are a senior frontend engineer specialized in typed REST clients, Zod presentation-edge validation, idempotent request handling, exact decimal money handling, and independent Next.js and React Native/Expo codebases.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 2. Phase 1 must be complete: read its "Execution handoff" section and follow every approved decision (Idempotency-Key strategy, money and date handling, error-code list, divergences, OPEN items). If a decision this phase needs is still OPEN, stop and report it.

Read and follow every applicable AGENTS.md. On web, read the relevant guide in node_modules/next/dist/docs/ before touching Next.js-specific code.

Task

Complete Dev 2's contribution to S2-02 ("alinhamento dos modelos") and S2-03 ("integração antecipada"): build, in each client independently, the typed data layer that later phases will use. No screens, routes, or forms are built in this phase.

Follow the existing per-module pattern already used by accounts in each client (src/lib/accounts/{api,schema,types}.ts on top of src/lib/api/{http-client,errors,config}.ts). Reproduce the pattern; do not introduce a new architectural layer.

1. Contract snapshot
   - The snapshot was refreshed to backend `fa9b62a` in Sprint 1 Phase 5. Compare src/lib/api/openapi.snapshot.json in each client with backend openapi/openapi.json at the current backend commit; refresh it and record the new hash in CONTRACT.md only if it changed.
   - Extend src/lib/api/contract.test.ts in each client with the Transactions, Categories, and Category-rules operations used by the typed client.
   - Confirm that the Accounts operations did not change incompatibly; if they did, stop and report.

2. Types and response schemas (hand-transcribed; no generator library is approved)
   - Transactions: TransactionView, TransactionPage, CreateTransaction, TransferView (entries tuple of exactly two), CreateTransfer, UpdateTransactionCategory as a discriminated union of { categoryId } and { categorizationStatus: "uncertain" | "unrecognized" }.
   - Categories: CategoryView, CategoryPage, CreateCategory, UpdateCategory.
   - Category rules: CategoryRuleView, CategoryRulePage, CreateCategoryRule, UpdateCategoryRule (partial, at least one field).
   - Keep money as string and dates as string in the types; never convert them to number or Date in the data layer.
   - Validate responses with Zod the same way the accounts module does, so contract drift fails loudly instead of rendering wrong data.

3. Presentation-edge input schemas (Zod)
   - Mirror the OpenAPI constraints exactly: amount pattern, positive value, two decimals; occurredOn as a real civil date; name 1–100 characters; conditionValue min 1; priority integer >= 0; conditionField/conditionOperator combinations allowed by the specification (description: equals, contains, starts_with, ends_with; type: equals with income or expense; accountId: equals with an account UUID).
   - Transfer: fromAccountId must differ from toAccountId (TRANSFER_ACCOUNTS_MUST_DIFFER mirrors this on the server).
   - Input schemas describe form input; they are not domain entities and are not shared between repositories.

4. Money and date utilities (per client, no sharing)
   - A pt-BR input normalizer ("1.234,56" -> "1234.56") implemented with string operations only, rejecting zero, negative values, more than two decimals, and malformed input.
   - A display formatter producing pt-BR BRL text without float drift, following the Phase 1 decision.
   - A civil-date helper that builds YYYY-MM-DD from local calendar components and validates real dates (no 2026-02-30), following the Phase 1 decision.

5. HTTP infrastructure
   - Extend the existing http-client (without rewriting it) so that callers can send Idempotency-Key and X-Request-Id explicitly per request. The access token remains explicit per request, as it is today.
   - Ensure authenticated responses are never cached across users. On web, verify the fetch caching semantics of the installed Next.js version from its docs and set the request cache mode explicitly if needed.
   - Keep Problem Details parsing in errors.ts; add the Transactions codes confirmed in Phase 1 to PROBLEM_CODES. Do not add unconfirmed codes.
   - Add typed error classes only where a flow needs structured data (for example idempotency conflicts); otherwise reuse ProblemDetailsError.

6. API functions (per module, per client)
   - transactions: listTransactions({ page, pageSize }), createTransaction(input, { accessToken, idempotencyKey }), createTransfer(input, { accessToken, idempotencyKey }), updateTransactionCategory(id, body, { accessToken }).
   - categories: listCategories, createCategory, updateCategory, deactivateCategory.
   - category-rules: listCategoryRules, createCategoryRule, updateCategoryRule, activateCategoryRule, deactivateCategoryRule, removeCategoryRule (DELETE; follow the OpenAPI response of 200 with a body as recorded in Phase 1).
   - Idempotency-Key is required by the type signature for createTransaction and createTransfer so that it cannot be forgotten.
   - Pagination helper for selectors that need "all active categories/accounts": iterate pages up to a documented safety cap and surface a truncation state instead of silently dropping items.

7. Error-to-message mapping (pt-BR, per client)
   - Map each confirmed code to user-facing copy that follows the Style Guide voice (firm, calm, simple, never alarmist), without revealing whether another tenant's resource exists (404 is always "não encontrado ou indisponível").
   - Map field errors (errors[].path) back to form fields.

8. Early integration (S2-03)
   - Against a local backend with fictitious data only, run a scripted or manual smoke of: list transactions; create income; replay the same request with the same Idempotency-Key and confirm that no duplicate is created and the original response is returned; the same key with a different payload returns 409 IDEMPOTENCY_KEY_REUSED; create a transfer and confirm two entries sharing transferId; list categories and rules.
   - Record the evidence (commands, status codes, no tokens) in the handoff. If the local backend or Auth0 test tenant is unavailable, report that limitation; do not claim the integration passed.

9. Update CONTRACT.md in each client: coverage table (operation -> function), snapshot commit, confirmed codes, limitations.

10. Tests (Vitest, existing pattern): add `*.test.ts` next to the new money/date utilities, input and response schemas, Idempotency-Key handling, API functions (with `fetch` stubbed), and error mapping in each client.

Workflow

1. Model-selection assessment (AGENTS.md).
2. Verify the Phase 1 handoff and the current backend OpenAPI.
3. Present a plan per repository: problem, solution, exact files (new and changed), exact code for types, schemas, utilities, http-client diff, API functions, error mapping, risks, and validation commands.
4. Wait for: planejamento aprovado, pode implementar
5. Implement web and mobile separately, in separate commits per repository.
6. Validate: web pnpm lint, pnpm typecheck, pnpm test, and pnpm build; mobile pnpm typecheck, pnpm test, and an Expo export or doctor check; git diff --check. Run the S2-03 smoke if the environment allows.
7. Append an "Execution handoff" section to this prompt file with changed files, evidence, and limitations.
8. Suggest a commit message per repository (Conventional Commits, as in agents.md) without committing unless asked.

Constraints

- Do not modify the backend.
- Do not build screens, routes, forms, or navigation in this phase.
- Do not add a generator library, a data-fetching/cache library, or any other dependency unless it was approved in Phase 1; installation requires explicit approval.
- Do not share code, schemas, or utilities between web and mobile; duplication across repositories is intentional.
- Never convert money to a JavaScript number for transport. Never use toISOString() to build occurredOn.
- Never log tokens, Idempotency-Keys together with payloads, or financial values.
- Do not use any; use unknown and narrow.
- Preserve unrelated user changes.

Output

During planning: exact files and code per repository. After implementation: cause, changed files, validation actually executed, smoke evidence, and remaining risks.

Acceptance criteria

- Both clients expose independent, typed, Zod-validated functions for every Transactions, Categories, and Category-rules operation in the OpenAPI.
- The snapshot and CONTRACT.md reference the current backend commit.
- Idempotency-Key is mandatory at the type level for movement creation and follows the approved lifetime rule.
- Money and dates are exact strings end to end; utilities reject invalid input.
- Confirmed Problem Details codes map to safe pt-BR messages and field errors.
- Authenticated responses cannot be cached across users.
- Lint, type-check, and build pass in each client or genuine blockers are reported.
- The S2-03 early-integration smoke has recorded evidence or a documented environmental limitation.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | Dev 2 parts of S2-02 (model alignment) and S2-03 (early integration) | Plano_Divisao_Atividades_Sprint_2.html |
| Pattern reference | Existing src/lib/accounts + src/lib/api pattern in each client | repository evidence |
| Snapshot | Already at backend fa9b62a since Sprint 1 Phase 5; refresh only if the backend changed | repository evidence |
| Generator | No generator library approved; hand transcription | CONTRACT.md + especificacao-transactions.html §20 |
| Idempotency | Header required on POST /transactions and /transfers; 24h window; REUSED/EXPIRED conflicts | especificacao-transactions.html §13 + OpenAPI |
| Money and dates | Decimal strings; civil dates | especificacao-transactions.html §4 |
| Dependency policy | Only what Phase 1 approved | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **repository evidence** — verified on 2026-09-23; **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.

## Execution handoff — Phase 2 (2026-09-23)

Executed together with Phase 1 after explicit approval. No screens, routes, or navigation were changed.

### Implemented (independent copies in each client)

- `src/lib/transactions/{types,schema,api,messages}.ts`: list, create income/expense, create transfer, update categorization. Movement creation requires `idempotencyKey` at the type level; transfer input rejects equal accounts (case-insensitive); response schemas validate every field and the two-entry transfer tuple.
- `src/lib/categories/{types,schema,api}.ts` and `src/lib/category-rules/{types,schema,api}.ts`: full lifecycle; the rule schema enforces the approved grammar (`type`/`accountId` only `equals`, `type` value income/expense, `accountId` UUID, priority integer >= 0).
- `src/lib/money.ts`, `src/lib/civil-date.ts` (mobile also `parseBrazilianDate`), `src/lib/idempotency.ts`, `src/lib/api/pagination.ts` (`listAllPages` with truncation flag), `src/lib/api/problem-error.ts`.
- `http-client.ts`: new `idempotencyKey` option (header `Idempotency-Key`); `errors.ts`: 9 new codes.
- Web `package.json`: `typecheck` runs `next typegen && tsc --noEmit` (clean-checkout fix approved before this phase).
- Mobile `package.json`: `expo-crypto ~57.0.3` declared as a direct dependency. It was already installed transitively by `expo-auth-session`; pnpm 12 wrote the importer entry without its `expo` peer, so the lockfile entry was pointed to the existing `57.0.3(expo@57.0.22)` resolution and validated with `pnpm install --frozen-lockfile`.
- `contract.test.ts` extended to the 14 Transactions operations (bearer, Idempotency-Key header, view fields, request bodies, transfer tuple, DELETE 200).

### Validation

- Web: `pnpm lint` passed; `pnpm typecheck` passed; `pnpm test` 214/214 (17 files); `pnpm build` passed.
- Mobile: `pnpm typecheck` passed; `pnpm test` 195/195 (14 files); `npx expo export --platform android` bundled (726 modules; the new modules are not imported by screens yet).
- `git diff --check` clean in both clients.

### Limitations

- The S2-03 early-integration smoke against the running backend was not executed: it requires a real Auth0 access token, which is not handled outside the clients. It moves to the Phase 3 manual script (web first; mobile pending Auth0).
- Snapshot unchanged (`fa9b62a`); no backend commit after it.
