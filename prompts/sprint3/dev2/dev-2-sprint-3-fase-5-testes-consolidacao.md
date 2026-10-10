# Prompt: Dev 2 Sprint 3 — Phase 5 Client Isolation, Tests, and Consolidation (S3-08)

- Scenario: development
- Created: 2026-10-07 · Target: Codex · Prompt language: English

## How to use

1. Run after Phases 3 and 4. If either delivered on mocks, this phase still runs and reports the pending integration as a blocker instead of claiming it.
2. Open a new Codex task with these repositories as workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only reference)
3. Run `git pull` in all four repositories. Developer 1's consolidation (`prompts/sprint3/dev1/dev-1-sprint-3-fase-5-importacao-inicial-consolidacao.md`) defines the final backend contract; S3-08 is led by Developer 3.
4. Use Plan mode. Authorize implementation only with the exact phrase: `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer responsible for client test strategy, OpenAPI contract compatibility, session and state isolation, and technical handoff in Next.js and React Native/Expo.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro (Next.js)
- /home/miguel/projetos/mobile-centralizador-financeiro (React Native/Expo)
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY reference; never modify)

This is Dev 2 Sprint 3 Phase 5: Developer 2's contribution to S3-08. S3-08 is led by Developer 3; do not claim the whole activity complete. Read the "Execution handoff" of Phases 1 to 4 first.

Read and follow every applicable AGENTS.md.

Task

1. Final contract alignment
   - Update src/lib/api/openapi.snapshot.json in each client from the current backend and record the backend commit in CONTRACT.md.
   - Reconcile every function marked Proposed in earlier phases with the final contract; adjust types, schemas, and error mapping; record remaining divergences for Developer 1.
   - Extend contract.test.ts: operations exist and require bearer authentication, response fixtures for import and connection views validate against the snapshot and the client schemas, and enum parity for import statuses, item situations, duplicate reasons, and connection statuses.

2. Isolation and state (extending the Sprint 2 guarantees)
   - Logout and user switch clear import previews, pending confirmations, polling, selected files, connection lists, and widget state; a response arriving after logout never repopulates state (mobile SessionEpoch; web no-store and per-request token).
   - Nothing import- or connection-related is written to SecureStore, AsyncStorage, or browser storage.
   - Another tenant's import run or connection receives the same neutral message as a missing one.
   - No connection token, Pluggy credential, OFX content, or financial payload appears in logs, error messages, or test output.

3. Test coverage (Vitest) for gaps found in Phases 2 to 4: confirmation retry without duplication, polling stop conditions, partial results, expired previews, and removal of a connection.

4. Documentation
   - README of each client: Sprint 3 scope, how to run the import and connection flows locally (with mocks and with a local backend), new test table rows, and limitations.
   - Demonstration script prompts/sprint3/dev2/roteiro-demonstracao-sprint-3.md in the same format as prompts/sprint2/dev2/roteiro-demonstracao-sprint-2.md: OFX import (valid, duplicates, invalid, PDF), double confirmation, Pluggy connection (success, cancel, partial, removal), and isolation between two fictitious users, with an empty "Observado" column.

5. Handoff
   - Append an "Execution handoff" to this prompt file with: traceability S3-03, S3-04, S3-06, S3-07, and Developer 2's part of S3-01 and S3-08 to code, tests, and evidence; validation results including a clean checkout of each client; separation into completed and verified, implemented but unverified, blocked by Developer 1, and blocked by Developer 3 or environment; and suggested commit messages.

Workflow

1. Run the model-selection assessment required by AGENTS.md.
2. Verify the backend contract and the Phase 1 to 4 handoffs.
3. Present the plan: contract changes, isolation audit findings, tests, documentation, risks, and validation commands.
4. Wait for: planejamento aprovado, pode implementar
5. Implement only the approved scope.
6. Validate in each client and in a clean checkout of each: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test, npx expo export --platform android; git diff --check.
7. Report actual results and blockers.

Constraints

- Do not modify backend-centralizador-financeiro.
- Do not share code between web and mobile.
- Do not claim integration, Sandbox evidence, or device verification that was not executed.
- Do not weaken or delete tests to make the suite pass.
- Do not add dependencies without approval.
- Use only synthetic and Sandbox data; never tokens, credentials, or real financial data.
- Preserve unrelated changes.

Output

Planning: contract reconciliation, isolation findings, test plan, documentation plan. After implementation: changed files, validation actually executed (including clean checkouts), traceability, blockers, and suggested commit messages without creating commits.

Acceptance criteria

- Both snapshots match the backend commit recorded in CONTRACT.md, and contract tests cover the new operations and enums.
- Logout and user switch leave no import or connection state behind (proven by tests where the logic is testable).
- No secret or financial payload appears in logs, storage, or test output.
- READMEs and the Sprint 3 demonstration script are updated.
- All listed validation commands pass in both clients and in clean checkouts, or the failure is reported with its output.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior frontend engineer (tests, contract, isolation) | template |
| Target environment | Codex | user-stated (same mold as prior Dev 2 prompts) |
| Phase split | Phase 5 of 5: isolation, tests, and consolidation (Dev 2 part of S3-08) | user-stated (approved option, 2026-10-07) |
| Missing backend | Report pending integration as a blocker, never as done | user-stated (approved option, 2026-10-07) |
| Isolation guarantees | SessionEpoch (mobile), no-store and server-side token (web) | repository evidence (Sprint 2 Phase 6) |
| Contract tests | contract.test.ts with fixtures and enum parity | repository evidence (Sprint 2 Phase 7) |
| Demonstration script format | prompts/sprint2/dev2/roteiro-demonstracao-sprint-2.md | repository evidence |
| S3-08 ownership | Led by Developer 3; Developer 2 contributes the client slice | approved default — Sprint 3 plan |
| Authorization gate | Exact phrase before edits | AGENTS.md |

Source legend: **user-stated** — supplied or chosen by the user; **repository evidence** — verified in the repositories on 2026-10-07; **approved default** — taken from approved project documents; **template** — standard skill clause.

## Execution handoff

Executed on 2026-10-10 after `planejamento aprovado, pode implementar`, against the OpenAPI at backend `605cb07` (HEAD of `origin/main`). Developer 1's Phase 5 (initial import and consolidation) was not delivered, so the backend contract did not change after Phase 4. Phase 4 was still uncommitted in web and mobile when this phase ran; `CONTRACT.md` and `contract.test.ts` carry changes from both phases.

### Contract

- Both `openapi.snapshot.json` files are byte-identical to the backend `openapi/openapi.json` at `605cb07`; `CONTRACT.md` records that commit. All seven Sprint 3 operations are Approved; none remained Proposed.
- `contract.test.ts` (both clients) gained fixtures validated against the snapshot and the Zod schemas for the states not covered before: ImportRun `expired` and `failed`, connection `partially_available`, `revoked` and `disconnected`; and parity of the `provider` enum (`pluggy`). The contract has no duplicate-reason enum (only `isDuplicate`), so there is nothing to compare.
- `CONTRACT.md` (both clients): section renamed to "Sprint 3", consolidation note, and "Divergencias e pendencias com o Dev 1 (S3-08)" with nine items (no `expiresAt`; no `awaiting_account_mapping` or mapping operation; no duplicate reasons; no `GET /connections`; no initial import; completion without `Idempotency-Key`; orphan `pending_authorization` connections per cancelled session; no `oauthRedirectUri`; no created transaction ids and no `errorCode` list).

### Isolation audit

- Web: "Sair" is a full navigation to `/auth/logout`, so preview, confirmation, chosen file and widget state are dropped with the page. The Auth0 token is read on the server per Server Action; `apiRequest()` uses `cache: "no-store"`. No `localStorage`, `sessionStorage`, app cookie or `console.*` in production code.
- Mobile: when the session leaves `authenticated`, `Root` (`App.tsx`) renders `SignInScreen` and unmounts every screen, including OFX import and connection. `SessionEpoch` stops a late 401 from ending the next session. SecureStore holds only the Auth0 session; no AsyncStorage; no `console.*` in production code.
- Another tenant's import run or connection: the backend answers 404, and both clients show the same text as for a missing one (tested in the messages tests).
- Outside the app's control, recorded as risk: `react-native-pluggy-connect@1.6.0` keeps WebView cookies on purpose (its source explains that institution OAuth resumes the widget session), so on a shared device an institution session can carry over to the next user; clearing it needs a new native dependency that does not run in Expo Go. The same SDK calls `console.error` with `error.message` when it fails to open an OAuth URL. On web, the Pluggy iframe keeps its own storage on Pluggy's origin.

### Tests added

- Mobile: `confirmKeyAfterFailure()` extracted to `src/screens/ofx-import-logic.ts` and used by `OfxImportScreen`. It keeps the confirmation key after a network failure or expired preview and rotates it only when the backend refuses it (`IDEMPOTENCY_KEY_REUSED` or `_EXPIRED`). Behavior unchanged; 3 new tests. Web already covered this in `importar-ofx/actions.test.ts`.
- Both clients: 5 new contract cases (fixtures above), plus the provider assertion inside an existing case.
- Polling stop conditions: not applicable. Neither client polls; the import status is refreshed manually.
- Partial results, expired previews and connection removal were already covered (presentation and logic tests, Server Action tests, API tests).

### Documentation

- README of each client: Sprint 3 paragraph, new rows in the test and structure tables, and a "Demonstração da Sprint 3" section with how to run with mocks (tests only) or with the local backend (R2 and Pluggy variables in the backend `.env`, each group required as a complete set by the backend environment schema) and known limitations.
- `prompts/sprint3/dev2/roteiro-demonstracao-sprint-3.md`: OFX on web (valid, duplicate on re-import, PDF, empty, over 4 MiB, malformed), double confirmation and resend after failure, Pluggy on web (cancel, Pluggy Bank, check again, reload with `?conexao=`, partial if the Sandbox offers it, removal), mobile, and isolation between A and B (B opening A's `?conexao=` URL). Column "Observado" empty.

### Traceability

| Activity | Code | Tests | Evidence |
|---|---|---|---|
| S3-01 (Dev 2 part) | `src/lib/api/CONTRACT.md` (both) | — | Client needs in `docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md`; divergences listed in `CONTRACT.md` |
| S3-03 web OFX | `src/app/(app)/contas/importar-ofx/`, `src/lib/ingestions/` | `importar-ofx/*.test.ts`, `src/lib/ingestions/*.test.ts`, `contract.test.ts` | Mocked tests; route built; integration blocked by R2 |
| S3-04 mobile OFX | `src/screens/OfxImportScreen.tsx`, `ofx-import-logic.ts`, `src/lib/ingestions/` | `ofx-import-logic.test.ts`, `src/lib/ingestions/*.test.ts`, `contract.test.ts` | Mocked tests; Android export; integration blocked by R2 |
| S3-06 web Pluggy | `src/app/(app)/contas/conectar/`, `src/lib/connections/` | `conectar/*.test.ts`, `src/lib/connections/*.test.ts`, `contract.test.ts` | Mocked tests; secret scan of `.next/static`; Sandbox blocked |
| S3-07 mobile Pluggy | `src/screens/ConnectScreen.tsx`, `connect-logic.ts`, `src/lib/connections/` | `connect-logic.test.ts`, `src/lib/connections/*.test.ts`, `contract.test.ts` | Mocked tests; secret scan of the Android export; Sandbox and device blocked |
| S3-08 (Dev 2 part) | snapshots, `CONTRACT.md`, READMEs, demonstration script | contract fixtures, `confirmKeyAfterFailure` | This handoff; isolation audit above |

### Validation actually executed

- Working tree, web: `pnpm lint`, `pnpm typecheck`, `pnpm build` passed (routes `/contas/importar-ofx` and `/contas/conectar` built); `pnpm test` 613/613 (608 before this phase).
- Working tree, mobile: `pnpm typecheck` and `npx expo export --platform android` passed; `pnpm test` 469/469 (461 before this phase).
- Clean checkout of each client: tracked and untracked non-ignored files copied to a scratch directory (the content that would be committed; Phase 4 and 5 are not committed yet), `.env` copied from `.env.example`, `pnpm install --frozen-lockfile`. Web: lint, typecheck, 613/613 and build passed. Mobile: typecheck, 469/469 and Android export passed.
- Secret and payload scan: no token, `Bearer`, Pluggy or R2 credential, `OFXHEADER` or `<STMTTRN>` in the test output of either client, and no stderr. Web `.next/static`: no match. Web `.next/server`: only the Auth0 SDK reading `AUTH0_CLIENT_SECRET` and a base64 source map of the SDK's `package.json`, as before. Mobile export: one `clientSecret`, the property name of `expo-auth-session`'s `TokenRequest`, as recorded in Phase 4.
- `git diff --check` passed in web, mobile and docs.

### Status

- Completed and verified: contract alignment at `605cb07`; contract, idempotency, state and message tests; isolation audit; READMEs; demonstration script.
- Implemented but unverified: every screen against a real backend, the Sandbox and a device; visual check in a logged-in browser and in Expo Go.
- Blocked by Developer 1: `expiresAt` on the preview; `awaiting_account_mapping` and the account-mapping operation; initial import of a Pluggy connection; `GET /connections`; `oauthRedirectUri`; orphan `pending_authorization` connections; created transaction ids; `errorCode` list. The backend fix for migration `202610090001_s305_pluggy_connections` (enum values split into `202610090000_s305_pluggy_audit_enum_values`) is still uncommitted in the backend.
- Blocked by Developer 3 or environment: rule for a "corresponding" local account (D12) and decision D3; R2 development credentials; Pluggy Sandbox credentials together with the `QSTASH_*` and `PUBLIC_API_BASE_URL` set the backend requires; decision on clearing Pluggy WebView cookies on shared devices.

### Suggested commit messages

- Web: `test(contrato): consolidar contrato da Sprint 3 em 605cb07, fixtures de todos os estados e README (S3-08)`
- Mobile: `test(contrato): consolidar contrato da Sprint 3 em 605cb07, chave da confirmação testável e README (S3-08)`
- Docs: `docs(dev2S3): roteiro de demonstração da Sprint 3 e handoff da Fase 5`
