# Prompt: Dev 2 Sprint 2 — Phase 6 Client State Isolation and Idempotency Integration (S2-07)

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phases 3–5 are complete and their handoffs are recorded. It can overlap with Dev 1's S2-07 hardening, but it must use the backend contract as merged.
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
You are a senior frontend engineer specialized in client-side security hygiene, session and state isolation in Next.js (server rendering, Server Actions, caching) and React Native/Expo, and idempotent retry behavior under unreliable networks.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 6. Phases 1–5 must be complete. Read all previous "Execution handoff" sections and the Sprint 1 Phase 4 prompt (prompts/sprint1/dev2/dev-2-sprint-1-fase-4-manutencao-isolamento.md), whose isolation guarantees for accounts must now extend to transactions, categories, and rules.

Read and follow every applicable AGENTS.md. On web, read the Next.js docs for the installed version about caching, revalidation, and Server Actions before changing them.

Task

Complete Dev 2's contribution to S2-07 ("Isolamento de estado" / integração). Dev 1 implements backend isolation, idempotency, RLS, and audit; Dev 3 is the principal verifier. Your job is to ensure the clients never mix, leak, or duplicate data, and that they integrate correctly with the backend guarantees.

S2-07 acceptance criteria relevant to the clients (from the Sprint 2 plan):

- Cross-tenant reads and mutations are denied (the client must present this safely and never reveal foreign existence).
- Repeating idempotent commands does not duplicate movements.
- Tokens, secrets, and unnecessary financial payloads do not appear in logs.

Audit and harden, in each client independently:

1. Inventory
   - List every place where transactions, transfers, categories, rules, and accounts are fetched, held in state, cached, revalidated, persisted, or logged (including console calls, error boundaries, analytics, and crash messages).
   - List every place where Idempotency-Keys are generated, stored, reused, or rotated.

2. Session and user-switch isolation
   - On logout and on user switch, all Transactions-related state is cleared: lists, selectors, form drafts, pending Idempotency-Keys, and cached pages.
   - Web: authenticated data is never served from a shared cache; verify fetch cache mode, route segment caching, and revalidation for every Transactions route under the installed Next.js version; the access token never reaches the browser bundle, HTML, or client component props.
   - Mobile: in-memory stores are reset; nothing Transactions-related is written to SecureStore or AsyncStorage; screens remount or reset after logout so that a new user never sees stale rows even briefly.
   - A request that resolves after logout must not repopulate state (ignore or abort responses belonging to a previous session).

3. Idempotency integration
   - Verify the Phase 1 lifetime rule is implemented identically in every movement form on both clients.
   - Simulate: network failure after the server committed (retry must replay the original response, and the UI must show one movement); double tap/click; app backgrounded mid-submit (mobile); page refresh mid-submit (web: document the resulting behavior honestly); key expiry (409 IDEMPOTENCY_KEY_EXPIRED -> new key and explicit user action); key reuse with changed payload (409 IDEMPOTENCY_KEY_REUSED).
   - Keys are never reused across sessions, users, or operations (transaction vs transfer).

4. Uniform denial handling
   - 404 for resources of another tenant and 404 for nonexistent resources render identically.
   - 401 leads to a safe re-authentication path without losing the ability to retry, and without logging the token.
   - 403 IDENTITY_CONTEXT_UNAVAILABLE has a clear, non-technical message.

5. Log and error hygiene
   - Remove or guard any log that contains tokens, Authorization headers, Idempotency-Keys together with payloads, amounts, descriptions, or account names.
   - Error messages shown to users never include stack traces, SQL, internal codes beyond the documented Problem Details code, or another tenant's data.

6. Evidence for Dev 3
   - Produce a concise client-side isolation checklist per repository with the scenario, steps, expected result, and observed result, using two fictitious users (two tenants). Dev 3 will reuse it in S2-08.

Workflow

1. Model-selection assessment (AGENTS.md).
2. Build the inventory (items 1 and 2) from repository evidence before proposing changes.
3. Enumerate findings as: already correct (with evidence), defect, or not verifiable in this environment.
4. Present a plan per repository with the smallest fixes: exact files, exact diffs, risks, validation commands, and the two-user manual script.
5. Wait for: planejamento aprovado, pode implementar
6. Implement web and mobile separately.
7. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test; git diff --check; run the two-user script and the idempotency simulations against a local backend with fictitious data and record the observed results.
8. Append an "Execution handoff" section to this prompt file, including the checklist for Dev 3, and suggest one commit message per repository.

Constraints

- Do not modify the backend. Report backend gaps to Dev 1 and verification gaps to Dev 3.
- Client-side checks are presentation hygiene, never a security boundary; do not add client-side tenant filtering.
- Do not add dependencies beyond those approved in Phase 1.
- Do not weaken existing Sprint 1 isolation behavior for accounts.
- Do not share code between repositories. Use fictitious data only. Preserve unrelated user changes.
- Never claim a scenario passed without executing it.

Output

During planning: inventory, findings, and per-repository fixes with exact code. After implementation: cause, changed files, validation actually executed, two-user and idempotency results, the Dev 3 checklist, and remaining risks.

Acceptance criteria

- No Transactions-related data, draft, or Idempotency-Key survives logout or user switch on either client.
- Late responses from a previous session cannot repopulate state.
- Authenticated data cannot be served from a shared cache on web; the token never reaches the browser.
- Retry after an ambiguous failure never creates a duplicate movement; changed payloads and expired keys are handled as specified.
- Foreign and nonexistent resources are indistinguishable to the user.
- Logs and user-facing errors contain no tokens, secrets, or unnecessary financial data.
- A reusable two-tenant client isolation checklist exists for Dev 3.
- Lint, type-check, and build pass in each client or genuine blockers are reported.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | S2-07 Dev 2 part: client state isolation and integration | Plano_Divisao_Atividades_Sprint_2.html (matrix: "Isolamento de estado"; S2-07 "integração: Developer 2") |
| Prior guarantees | Sprint 1 Phase 4 client isolation for accounts | prompts/sprint1/dev2/dev-2-sprint-1-fase-4-manutencao-isolamento.md |
| Idempotency | Replay, REUSED, EXPIRED, 24h window, scope tenant + operation + key | especificacao-transactions.html §13 |
| Denial semantics | Cross-tenant is 404 without confirming existence | especificacao-transactions.html §16–17 |
| Dependency policy | Only what Phase 1 approved | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.

## Execution handoff — Phase 6 (2026-09-24)

Executed by Dev 2 after explicit approval, on top of Phase 5 and the date-format fix (not yet committed at execution time). Backend reference: `fa9b62a` (read-only, unchanged).

### Inventory (repository evidence)

| Item | Web | Mobile |
|---|---|---|
| Fetch and hold data | Server Components (`page.tsx` of movimentacoes, contas, categorias, regras) with the token from `auth0.getAccessToken()`; lists live in the rendered payload only | `useState` in each screen (`MovementsScreen`, `AccountsScreen`, `CategoriesScreen`, `RulesScreen`) and form screens |
| Mutations | Server Actions (`actions.ts` per route), token server-side, `revalidatePath` after API confirmation | Direct typed clients; token from `setTokenProvider` in memory |
| Cache | No `use cache`/`unstable_cache`/segment config; `fetch` not cached by default and client cache for dynamic pages 0 s (installed Next 16 docs); **production dynamic pages send `Cache-Control: private, no-cache, no-store, max-age=0, must-revalidate`** (observed with `next start`); now `cache: "no-store"` is forced in `http-client.ts` | Nothing persisted: `SecureStore` holds only `{accessToken, expiresAt}` (`session-store.ts`); no AsyncStorage |
| Logs | No `console`, logger or analytics in `src` | None |
| Error surfaces | `error.tsx` never renders the error message; actions map Problem Details to closed pt-BR messages; `detail` never shown | Same classification helpers; `detail` never shown |
| Idempotency-Key | Generated per page render (`newIdempotencyKey`, `node:crypto`), separate keys for movement and transfer, carried in a hidden field, rotated in the action only after success or `IDEMPOTENCY_KEY_REUSED`/`EXPIRED` | `useState(newIdempotencyKey)` per form screen (`expo-crypto`), same rotation rule, `useRef` guard against double tap |
| Logout / user switch | `/auth/logout` is a full navigation: all browser state (drafts, action states, keys) is discarded | `Root` swaps to `SignInScreen`, unmounting every screen; `tokenProvider` reset to `undefined` |

Backend scopes idempotency records by `(tenant_id, operation, key)`, so keys cannot collide across users or between transaction and transfer.

### Findings

Already correct: every row above; 404 for foreign and nonexistent resources render the same neutral message (backend returns the same code for both); 401 offers a re-login path (web link with `returnTo`, mobile `handleUnauthorized`); 403 `IDENTITY_CONTEXT_UNAVAILABLE` reads "Não foi possível confirmar seu acesso. Entre novamente."; the idempotency lifetime is identical in both movement forms of each client.

Defects fixed:

1. **Mobile — a late 401 from the previous session signed out the new user.** A request of user A still in flight after A logged out and B logged in could call the context's `handleUnauthorized` and clear B's session. Fix: `src/auth/session-epoch.ts` numbers sessions; `AuthContext` advances it on every `applySession`, and each `handleUnauthorized` is bound to the session number it was created in and does nothing once the session changed. Test: `session-epoch.test.ts`.
2. **Web — hardening:** `http-client.ts` forces `cache: "no-store"` (overrides any caller option); test in `http-client.test.ts`.

Documented limitations (not fixed; would require persisting the key in client storage, out of scope):

- **Web, page refresh mid-submit:** the refreshed page renders a new key; if the first request had already been committed, a new submission creates a second movement.
- **Mobile, app killed by the OS mid-submit:** same effect, the key lived only in memory.
- **Mobile, app backgrounded mid-submit:** the form stays mounted and a retry reuses the same key (correct by construction); device verification blocked by the missing Auth0 Native application.
- **Web, two tabs with different users:** an action from the old tab uses the new user's cookie with the old user's ids; the backend answers 404 and the neutral message is shown (safe).

### Validation (executed)

- Web: lint ok; typecheck ok; `pnpm test` 378/378 (23 files); build ok; `git diff --check` clean; production headers observed as above.
- Mobile: typecheck ok; `pnpm test` 293/293 (19 files); Android export ok (903 modules); `git diff --check` clean.

### Client isolation checklist for Dev 3 (two fictitious users, two tenants)

Prerequisite: two fictitious Auth0 users (A and B). Not available at execution time, so the two-user rows are **pending** — never mark them passed without running them.

| # | Scenario | Steps | Expected | Observed |
|---|---|---|---|---|
| 1 | Logout clears data | A creates an account, a category, a rule and two movements; A logs out; B logs in | B sees empty lists, never A's rows, not even briefly | Pending (web and mobile) |
| 2 | Back button after logout | After step 1, B's browser: press Back to A's pages | Pages re-render for B or redirect to login; no A data (pages are `no-store`) | Pending |
| 3 | Foreign resource by id | B categorizes/edits using A's ids (copy an id from A's session via devtools, or replay a request) | Same neutral 404 message as a nonexistent id; no hint that it exists | Pending |
| 4 | Double submit | Double-click / double tap "Registrar" | One movement | OK on web (Phase 3 manual, 2026-09-24); mobile pending |
| 5 | Network drop after commit | Stop backend right after submitting (or cut network), restart, resubmit | One movement (same key replayed) | OK on web (Phase 3 manual); mobile pending |
| 6 | Changed payload, same key | After a failed attempt, change the amount and resubmit | If the first was committed: "Os dados mudaram…" and a new key; otherwise created once | Pending |
| 7 | Expired key | Requires a key older than 24 h (backend fixture) | "Este envio expirou…", new key, explicit resubmit | Not verifiable without a backend fixture (Dev 1/Dev 3) |
| 8 | Session expired mid-form | Let the session expire (or delete the session cookie) and submit | Re-login path shown; no token in UI, logs or URL | Pending |
| 9 | Late response after switch (mobile) | Slow network; start a load as A, log out, log in as B | B stays signed in; no A rows appear | Pending (device blocked) |
| 10 | Logs and errors | Inspect server logs, browser console and error screens during 1–9 | No token, Authorization header, amounts, descriptions or account names; only documented Problem Details codes | No logging in client code (static evidence); runtime check pending |
| 11 | Refresh mid-submit (web) | Submit and refresh before the response | Documented limitation: a second submission may duplicate | Documented, not a pass |

### Gaps

- For Dev 1: none new in this phase; open divergences remain as recorded in Phases 1, 4 and 5.
- For Dev 3: rows 1–3, 6, 8–10 need two fictitious users; mobile rows need the Auth0 Native application; row 7 needs an expired-key fixture.

### Suggested commit messages

- web: `fix(isolamento): forçar no-store nas chamadas autenticadas e documentar o isolamento do cliente`
- mobile: `fix(sessao): ignorar 401 atrasado de sessão anterior ao trocar de usuário`
- documentacao: `docs(dev2S2): registrar handoff da fase 6 e checklist de isolamento para o Dev 3`
