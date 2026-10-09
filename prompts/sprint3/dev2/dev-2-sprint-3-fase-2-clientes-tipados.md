# Prompt: Dev 2 Sprint 3 — Phase 2 Typed Clients for Import and Connection

- Scenario: development
- Created: 2026-10-07 · Target: Codex · Prompt language: English

## How to use

1. Run only after Phase 1 is approved and its "Execution handoff" is recorded in `prompts/sprint3/dev2/dev-2-sprint-3-fase-1-baseline-contrato-clientes.md`.
2. Open a new Codex task with these repositories as workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only reference)
3. Run `git pull` in all four repositories. If Developer 1 has published import or connection routes in `openapi/openapi.json`, this phase targets them; otherwise it targets the contract recorded as proposed in Phase 1.
4. Use Plan mode. Authorize implementation only with the exact phrase: `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer specialized in typed REST clients, runtime validation with Zod, multipart file upload, and idempotent client workflows in Next.js and React Native/Expo.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro (Next.js)
- /home/miguel/projetos/mobile-centralizador-financeiro (React Native/Expo)
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY reference; never modify)

This is Dev 2 Sprint 3 Phase 2. Phase 1 recorded the client baseline, the contract status (Approved, Proposed, or OPEN), and the client decisions. Read its "Execution handoff" first and treat it as the boundary for this phase.

Read and follow every applicable AGENTS.md. On web, read the relevant guide in node_modules/next/dist/docs/ before writing Next.js code.

Task

Implement, independently in each client, the typed data layer for OFX import and Pluggy connection. No screens in this phase.

1. Contract source
   - If the backend OpenAPI contains the routes: update src/lib/api/openapi.snapshot.json from the backend, record the backend commit in CONTRACT.md, and treat the snapshot as authoritative.
   - If it does not: implement against the contract recorded as Proposed in Phase 1, mark every new type and function with that status in CONTRACT.md, and keep the code easy to adjust when the real contract arrives.
   - If an item needed by a function is OPEN, do not implement that function; report it.

2. HTTP client
   - Extend src/lib/api/http-client.ts in each client so a FormData body is sent as-is (no JSON.stringify, no forced Content-Type; the runtime sets the multipart boundary), keeping every existing JSON call unchanged.
   - Web: requests stay server-side; the access token never reaches the browser.
   - Mobile: send the file as React Native expects in FormData; do not add a dependency for it.

3. Types, schemas, and API functions (per approved or proposed contract)
   - Import: upload/preview, preview page (if paginated), confirmation with Idempotency-Key, status/result query.
   - Connection: connection token request, connection registration after the widget, list, status, and removal.
   - Edge Zod schemas for responses, using the existing money (decimal string), civil date, and pagination helpers; never use Number or parseFloat for amounts.
   - Error codes added to src/lib/api/errors.ts and mapped to pt-BR messages; the backend `detail` is never shown.

4. Client-side file validation (OFX)
   - Type and size checks matching the approved limits, as a usability aid only; the backend remains authoritative.

5. Idempotency
   - Reuse the existing Idempotency-Key rules for confirmation: same key on any failure; rotate only after success or IDEMPOTENCY_KEY_REUSED/EXPIRED.

6. Tests (Vitest)
   - FormData pass-through and unchanged JSON behavior in http-client.
   - Schemas with synthetic fixtures (valid, invalid, duplicate, partial availability).
   - API functions with mocked fetch: path, method, headers, Idempotency-Key, error mapping.
   - File validation and Idempotency-Key lifetime for confirmation.
   - Contract tests: if the snapshot has the routes, extend contract.test.ts (operations exist, fixtures validate against the snapshot and the client schemas, enum parity); if not, keep fixtures marked Proposed.

Workflow

1. Run the model-selection assessment required by AGENTS.md.
2. Verify the Phase 1 handoff and whether the backend contract changed since then.
3. Present the plan: contract source chosen, exact files per client, schema and function list, http-client change, tests, risks, and validation commands.
4. Wait for: planejamento aprovado, pode implementar
5. Implement only the approved scope, client by client.
6. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test, npx expo export --platform android; git diff --check in every changed repository.
7. Append an "Execution handoff" to this prompt file with: contract status per function, files, tests added, validation results, and what Phase 3 and Phase 4 can rely on.

Constraints

- Do not build screens, routes, navigation, or Server Actions in this phase.
- Do not modify backend-centralizador-financeiro.
- Do not share code, schemas, or fixtures between web and mobile; each client keeps its own copy.
- Do not invent fields, routes, states, or error codes beyond the approved or proposed contract.
- Do not add dependencies without approval; this phase should not need any.
- Do not weaken or delete existing tests to make new ones pass.
- Use only synthetic data; never include tokens, Pluggy credentials, or real financial data.
- Preserve unrelated changes.

Output

Planning: contract source, file list per client, function and schema list, tests, risks. After implementation: changed files, contract status per function, validation actually executed, and handoff.

Acceptance criteria

- Both clients send multipart uploads through http-client while all existing JSON calls keep working (proven by tests).
- Every implemented function matches the approved or proposed contract and is marked accordingly in CONTRACT.md.
- Amounts and dates use the existing string and civil-date helpers; no Number or parseFloat on values sent or displayed.
- Confirmation reuses Idempotency-Key according to the existing rules (proven by tests).
- All listed validation commands pass in both clients.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior frontend engineer (typed clients) | template |
| Target environment | Codex | user-stated (same mold as prior Dev 2 prompts) |
| Phase split | Phase 2 of 5: typed data layer for both clients, no screens | user-stated (approved option, 2026-10-07) |
| Missing backend | Use the proposed contract with mocks when routes are absent; stop on OPEN items | user-stated (approved option, 2026-10-07) |
| HTTP clients | Both currently JSON.stringify every body | repository evidence (2026-10-07) |
| Existing helpers | Money string helpers, civil dates, pagination, Idempotency-Key rotation | repository evidence (Sprint 2) |
| Test tooling | Vitest in both clients; contract.test.ts with fixtures and enum parity | repository evidence |
| Client independence | No shared code between web and mobile | approved default — Architecture and Sprint 3 plan |
| Validation commands | Same commands used in Sprint 2 phases | repository evidence |
| Authorization gate | Exact phrase before edits | AGENTS.md |

Source legend: **user-stated** — supplied or chosen by the user; **repository evidence** — verified in the repositories on 2026-10-07; **approved default** — taken from approved project documents; **template** — standard skill clause.

## Execution handoff

Executed on 2026-10-08 after `planejamento aprovado, pode implementar`.

Contract source: Developer 1's S3-01 backend contract (`docs/planejamento/sprint-03/contrato-backend-s3-01.html`, docs `f851384`). Backend `9887206` has the OFX domain and persistence but no controller, so the routes are not in `openapi/openapi.json` and the snapshot was not updated. Routes and states are Approved in that contract; response field names are Proposed, taken from the backend domain (`ImportRunSnapshot`, `IngestionItemState`), with `items` assumed for the rows.

### Status per function (same in both clients, separate code)

| Function | Route | Status |
|---|---|---|
| `apiRequest()` with `FormData` | — | Done; JSON calls unchanged |
| `createOfxPreview()` | `POST /ingestions/ofx/previews` | Route Approved; response Proposed; sends `Idempotency-Key` (question 5 open) |
| `confirmImport()` | `POST /ingestions/{importRunId}/confirmations` | Route Approved; response Proposed |
| `getImportRun()` | `GET /ingestions/{importRunId}` | Route Approved; response Proposed |
| `checkOfxFile()` | — | Empty, PDF and size; web 4 MiB (Vercel), mobile 10 MiB (backend) |
| `ingestionErrorMessage()` | — | Known codes first, then HTTP status; Problem Details `code` values still OPEN |
| Pluggy functions | `connections/...` | Not implemented: field names OPEN (question 7) |

### Files

- Web: `src/lib/api/http-client.ts`, `src/lib/api/http-client.test.ts`, `src/lib/transactions/schema.ts` (`AMOUNT` exported), `src/lib/ingestions/` (`types`, `schema`, `api`, `messages`, `file-validation`, `fixtures` and four test files), `src/lib/api/CONTRACT.md`.
- Mobile: the same set; `src/lib/api/http-client.test.ts` is new. The file goes into `FormData` as `{ uri, name, type }`; `type` is omitted when the picker does not report it.
- No dependency, screen, route, Server Action, configuration, or backend change. `errors.ts`, `idempotency.ts` and `contract.test.ts` unchanged.

### Validation actually executed

- Web: `pnpm lint` passed; `pnpm typecheck` passed; `pnpm test` 522/522 (499 before plus 23 new); `pnpm build` passed.
- Mobile: `pnpm typecheck` passed; `pnpm test` 400/400 (376 before plus 24 new); `npx expo export --platform android` passed.
- `git diff --check` passed in web, mobile and documentation, including the new files.

### What Phases 3 and 4 can rely on

- Phase 3 can build the OFX screens on `createOfxPreview`, `confirmImport`, `getImportRun`, `checkOfxFile`, `ingestionErrorMessage` and the fixtures. Screen design must assume duplicates appear only in the result (question 2), and polling stops at the terminal states `completed`, `completed_with_errors`, `failed` and `expired`. Web needs `serverActions.bodySizeLimit` (above 4 MiB plus multipart overhead) when its Server Action is added. Mobile needs `expo-document-picker` installed.
- Phase 4 has routes and connection/consent states only; its data layer must be added once Developer 1 names the `sessions` and `completions` fields. The account-mapping step (D12) is a new screen not in the original plan.
- Open with Developer 1: the seven questions recorded in each client's `CONTRACT.md` "Pendente com o Dev 1".

### Update 2026-10-09 — alignment with the published OpenAPI

Backend `2c416cd` published the three OFX routes in `openapi/openapi.json`. The diff against the clients' snapshot was purely additive (three new paths; no consumed operation changed), so `src/lib/api/openapi.snapshot.json` in both clients is now a copy of the backend file at `2c416cd`, and the OpenAPI is authoritative over the written S3-01 contract.

Changes, independent in each client:

- `createOfxPreview()` now takes `{ file, destinationAccountId }` and sends both in the multipart body. The published route requires the destination account with the file; the previous version would have received 400.
- `ingestions/types.ts` and `schema.ts` mirror the OpenAPI: `isDuplicate` added to items; `warnings` is an open string list; `destinationAccountId` required; `variant`, `fileSizeBytes`, `terminalAt`, `retentionExpiresAt`, `createdAt` and `updatedAt` added; `awaiting_account_mapping` removed until the backend publishes it. `OFX_WARNINGS` became the single constant `EXTERNAL_ID_MISSING`.
- `ingestionErrorMessage()` gained the 503 message. The backend answers file and state errors as `INVALID_REQUEST` distinguished by HTTP status, which matches the existing status-based mapping.
- `contract.test.ts` gained an Ingestions block: bearer, required `Idempotency-Key` on preview and confirmation, multipart and confirmation fields, exact ImportRun and item fields, enum parity, and fixtures validated against the snapshot and the client schemas.
- Fixtures now follow the OpenAPI shape, including a preview duplicate.
- `CONTRACT.md` header points to `backend @ 2c416cd`; the Sprint 3 section marks the OFX operations Approved and lists what remains open.

Validation actually executed on 2026-10-09: web `pnpm lint`, `pnpm typecheck` and `pnpm build` passed, `pnpm test` 533/533; mobile `pnpm typecheck` and `npx expo export --platform android` passed, `pnpm test` 412/412; `git diff --check` passed in web, mobile and documentation.

Still open: `expiresAt` (24-hour preview validity, decided in S3-08, not yet in the OpenAPI); the S3-08 account-mapping operation and `awaiting_account_mapping`; the whole Pluggy contract (S3-05); R2 development credentials, without which the local backend answers the preview with 503.

Phase 3 can now build the OFX screens against the published contract: choose the account and the file, show the preview with duplicates (`isDuplicate`) and the `external_id_missing` warning, confirm, and show the result.

### Update 2026-10-09 — Pluggy contract published

Backend `605cb07` published the S3-05 connection routes (sessions, completions, connection detail, disconnect). This closes "the whole Pluggy contract (S3-05)" listed above as open, except for listing connections, initial import and account mapping, which are not published. The Phase 4 data layer is built on this contract in Phase 4 itself, together with the snapshot update to `605cb07`; see the "Contract update 2026-10-09" section of the Phase 4 prompt.
