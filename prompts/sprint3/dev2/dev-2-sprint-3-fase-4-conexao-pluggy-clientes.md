# Prompt: Dev 2 Sprint 3 — Phase 4 Pluggy Connection in Web and Mobile (S3-06, S3-07)

- Scenario: development
- Created: 2026-10-07 · Target: Codex · Prompt language: English

## How to use

1. Run only after Phase 2 is complete; Phase 3 may run before or in parallel.
2. Open a new Codex task with these repositories as workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only reference)
3. Run `git pull` in all four repositories. Developer 1's S3-05 endpoints are published in the OpenAPI at backend `605cb07` (see "Contract update 2026-10-09" below). Real integration still needs Pluggy Sandbox credentials in the local backend; without them, this phase delivers the flows on mocked fetch against the published contract and records integration as pending.
4. The Pluggy widget dependencies were approved in Phase 1 (`react-pluggy-connect@2.12.0` on web, `react-native-pluggy-connect@1.6.0` on mobile) and are not installed yet.
5. Use Plan mode. Authorize implementation only with the exact phrase: `planejamento aprovado, pode implementar`.
6. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer specialized in secure third-party connection widgets, OAuth redirects and deep links, consent UX, and Next.js and React Native/Expo integration.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro (Next.js)
- /home/miguel/projetos/mobile-centralizador-financeiro (React Native/Expo)
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY reference; never modify)

This is Dev 2 Sprint 3 Phase 4: S3-06 (web) and S3-07 (mobile). Read the "Execution handoff" of Phases 1 and 2 first. Use the current official Pluggy documentation for the Connect widget, connection token, OAuth and deep links, and revocation; do not infer SDK APIs or signatures. If the documentation is unavailable, report it before choosing behavior.

Read and follow every applicable AGENTS.md. On web, read the relevant guide in node_modules/next/dist/docs/ before writing Next.js code. In each client, follow PRODUCT.md, DESIGN.md, UX_PRINCIPLES.md, and DESIGN_DEFINITION_OF_DONE.md.

Published contract (backend 605cb07, openapi/openapi.json; authoritative over the written S3-01 contract)

- POST /api/v1/connections/pluggy/sessions: no body; 201 { connection, connectToken, expiresAt }. Errors 401, 500, 503.
- POST /api/v1/connections/pluggy/completions: JSON { itemId } (uuid from the widget); 200 Connection. Errors 400, 401, 404, 409, 500, 503. No Idempotency-Key and no initial ImportRun (S3-01 said 202 with an initial import).
- GET /api/v1/connections/{connectionId}: 200 Connection. Errors 400, 401, 404, 409, 500.
- POST /api/v1/connections/{connectionId}/disconnect: no body; 200 Connection (revokes consent). Errors 400, 401, 404, 409, 500, 503.
- Connection: id, provider "pluggy", status (pending_authorization, connected, partially_available, expired, revoked, disconnected), consent { id, status (granted, expired, revoked), products[], openFinancePermissionsGranted[], grantedAt, expiresAt, revokedAt }, createdAt, updatedAt.
- Problem Details codes: INVALID_REQUEST, AUTHENTICATION_REQUIRED, IDENTITY_CONTEXT_UNAVAILABLE, CONNECTION_NOT_FOUND, CONNECTION_CONFLICT, INTEGRATION_UNAVAILABLE, INTERNAL_ERROR.
- POST /api/v1/webhooks/pluggy is backend-only; clients never call it.
- Not published: listing connections (no GET /api/v1/connections), the account-mapping operation (PUT .../accounts/{providerAccountId}/mapping), awaiting_account_mapping, and any initial-import status. Do not invent them; mock nothing beyond the published contract.

Copy the backend OpenAPI at 605cb07 into each client's src/lib/api/openapi.snapshot.json, extend contract.test.ts with a Connections block, and update each client's CONTRACT.md (operations Approved, S3-01 divergences, what remains open).

Task

Implement the Pluggy Sandbox connection flow independently in each client:

1. Entry point and navigation exactly as approved in Phase 1.
2. Before opening the widget, explain in plain pt-BR what is being authorized: read access to Sandbox data for this tenant, never moving money, payments, or Pix (RN-017).
3. Request the limited connection token from the backend on each opening. Web: through a Server Action or server code; only the limited token reaches the browser. Mobile: through the authenticated client.
4. Open the approved widget with that token. Pluggy application credentials (CLIENT_ID, CLIENT_SECRET, API key) never exist in client code, environment files, bundles, or logs.
5. On success, send the connection reference to the backend as the contract defines; the backend, not the client, links it to the tenant. Handle widget cancellation, closing, and errors without leaving partial state.
6. Mobile: OAuth return through the approved deep link using the existing `coinciente` scheme; verify whether the approved SDK runs in Expo Go or needs a development build, and report it.
7. Connection detail: status, consent products and permissions (partial availability is explicit), consent expiry, last update (updatedAt), and removal with confirmation (web: ConfirmDialog; mobile: Alert.alert). Removal wording states that new collection stops; do not promise anything about already imported data unless the approved policy says so. The backend has no list route: show only the connection returned by the current flow, never persist connection ids or tokens on the client to fake a list, and record the full "Conexões" list as blocked on Developer 1.
8. Initial import status: not exposed by the published contract. After completion, show the connection status only; record initial import and account mapping (D12, awaiting_account_mapping) as pending S3-08. If the status is pending_authorization after completion, offer a manual "Verificar de novo" via GET, without automatic polling.
9. States: loading, no connections, connecting, cancelled, provider error, expired or revoked consent, partial availability, removal in progress, removal failed, session expired, and network failure with retry.
10. Accessibility as in Phase 3 (labels, focus, targets, color never the only signal).

Integration

- With approved endpoints and an authorized Sandbox, run the flow end to end with Sandbox test data and record the evidence (no secrets, no real data).
- Without them, deliver on mocks, mark integration as pending, and list what must be re-checked.
- Inspect the built web bundle and the mobile export for Pluggy secrets and record the result.

Tests (Vitest)

- Token request and connection registration (Server Actions on web; API functions on mobile): error mapping, re-authentication, no secrets in requests or state.
- Presentation logic: connection status labels, partial availability, removal flow states, polling stop conditions.

Workflow

1. Run the model-selection assessment required by AGENTS.md.
2. Verify Phase 1 and 2 handoffs, dependency approvals, the backend contract, and the current Pluggy documentation.
3. Present the plan per client: screens, files, widget integration, deep link configuration (mobile), state matrix, tests, integration mode (Sandbox or mocks), secret inspection, risks, and validation commands.
4. Wait for: planejamento aprovado, pode implementar
5. Install only approved dependencies; implement only the approved scope, one client at a time.
6. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test, npx expo export --platform android; git diff --check; secret inspection of build outputs.
7. Append an "Execution handoff" with screens delivered, integration status, Sandbox evidence or blocker, secret-inspection result, and validation results.

Constraints

- Do not modify backend-centralizador-financeiro.
- Do not share code or components between web and mobile.
- Never store Pluggy credentials, API keys, or connection tokens as durable client state (no SecureStore, AsyncStorage, or browser storage).
- The client never decides tenant ownership of a connection.
- Do not implement HU-008 daily or manual synchronization or HU-009 investments.
- Do not add dependencies beyond those approved in Phase 1; follow `npx expo install` for Expo-managed packages.
- Do not call the Pluggy Sandbox without explicit authorization.
- Use only Sandbox and synthetic data; never real credentials or financial data.
- Preserve unrelated changes and do not weaken existing tests.

Output

Planning: per-client plan, state matrix, and dependency use. After implementation: changed files per client, integration and Sandbox status, secret-inspection result, validation actually executed, and handoff.

Acceptance criteria

- Both clients open the approved widget using only the limited token from the backend.
- No Pluggy application credential appears in client code, configuration, bundles, or logs (inspection recorded).
- Success, cancellation, error, expired or revoked consent, and partial availability are shown explicitly.
- Removal asks for confirmation and states that new collection stops.
- Mobile OAuth return works through the approved deep link, or the blocker is documented.
- All listed validation commands pass; integration is either evidenced or explicitly pending.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior frontend engineer (third-party connection) | template |
| Target environment | Codex | user-stated (same mold as prior Dev 2 prompts) |
| Phase split | Phase 4 of 5: Pluggy connection in both clients (S3-06, S3-07) | user-stated (approved option, 2026-10-07) |
| Missing backend | Deliver on mocks when endpoints are absent; record integration as pending | user-stated (approved option, 2026-10-07) |
| Secret boundary | Application credentials only on the backend; client receives a limited token | approved default — Sprint 3 plan and PRD RNF-004 |
| Scope limits | HU-008 and HU-009 out of scope | approved default — Sprint 3 plan |
| Mobile deep link | Existing `coinciente` scheme in app.json | repository evidence (2026-10-07) |
| SDKs | react-pluggy-connect@2.12.0 (web), react-native-pluggy-connect@1.6.0 (mobile) | Phase 1 handoff (approved, not installed) |
| Backend contract | OpenAPI at backend 605cb07; no list, mapping, or initial-import operation | repository evidence (2026-10-09) |
| Confirmation patterns | ConfirmDialog (web), Alert.alert (mobile) | repository evidence (Sprint 2) |
| Authorization gate | Exact phrase before edits | AGENTS.md |

Source legend: **user-stated** — supplied or chosen by the user; **repository evidence** — verified in the repositories on 2026-10-07; **approved default** — taken from approved project documents; **template** — standard skill clause.

## Contract update 2026-10-09

Backend `605cb07` (`feat(accounts): add Pluggy connection consent lifecycle`) published S3-05 in `openapi/openapi.json`: sessions, completions, connection detail, disconnect, and the backend-only Pluggy webhook. The OFX operations did not change. The prompt above now embeds the published contract.

Divergences from the written S3-01 contract. Developer 1 is not reachable now, so the questions are recorded in `docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md` (section 11) and Phase 4 proceeds on these assumptions, replacing them when Developer 1 answers:

- No route to list a tenant's connections. Without it, a client cannot show existing connections after a reload. Assumption: no list route; show only the current flow's connection.
- Completions answers 200 and starts no initial ImportRun (S3-01: 202 with an initial import). Initial import, account mapping (D12) and `awaiting_account_mapping` stay with S3-08.
- Completions takes no `Idempotency-Key` (S3-01 required one). Assumption: resending the same `itemId` after a network failure is safe, so retry resends it.

Still open: Pluggy Sandbox credentials (`PLUGGY_CLIENT_ID`, `PLUGGY_CLIENT_SECRET`) in the local backend; Developer 3's rule for a "corresponding" local account (D12); R2 development credentials for OFX.
