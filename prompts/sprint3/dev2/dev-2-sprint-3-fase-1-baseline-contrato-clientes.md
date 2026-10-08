# Prompt: Dev 2 Sprint 3 — Phase 1 Client Baseline and Import/Connection Contract

- Scenario: development
- Created: 2026-10-07 · Target: Codex · Prompt language: English

## How to use

1. Sprint 2 is closed for Dev 2 and pushed (web `5357db1`, mobile `aad46c4`), aligned with the backend contract at `e95d2af`. Commit `docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md` before starting: this prompt uses it as an input.
2. Open a new Codex task with these repositories as workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only reference)
3. Run `git pull` in all four repositories first. Dev 1's matching phase is `prompts/sprint3/dev1/dev-1-sprint-3-fase-1-baseline-contratos-backend.md`; if it has produced an approved contract, this phase consumes it.
4. Use Plan mode. Authorize implementation only with the exact phrase: `planejamento aprovado, pode implementar`.
5. Do not start Phase 2 until this phase's decisions are approved and recorded.
6. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer and client-contract owner specialized in Next.js (App Router, Server Actions), React Native/Expo, file upload over authenticated REST, third-party connection widgets, and typed clients derived from OpenAPI.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro (Next.js)
- /home/miguel/projetos/mobile-centralizador-financeiro (React Native/Expo)
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY reference; never modify)

This is Dev 2 Sprint 3 Phase 1. Sprint 3 scope is HU-004 (OFX import) and HU-007 (Pluggy Sandbox connection with its initial import). HU-008 recurring synchronization and HU-009 investments are out of scope. The approved sprint window is 2026-09-25 to 2026-10-09.

Your role (docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html): independent web and mobile experiences, typed clients, forms, validation, and interface states. In S3-01 (led by Developer 3; Developer 1 defines backend contracts) you confirm the needs of both clients. You own S3-03, S3-04, S3-06, and S3-07 in later phases.

Before proposing anything:

1. Find and follow every applicable AGENTS.md (docs, web, mobile). The web AGENTS.md requires reading the relevant guide in node_modules/next/dist/docs/ before writing Next.js code; for this phase read at least the Server Actions guide and next.config `serverActions.bodySizeLimit`.
2. Read at minimum:
   - docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html
   - docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md (Developer 2's client needs, sent to Developers 1 and 3)
   - docs/produto/prd.html (HU-004, HU-007, RN-006 to RN-009, RNF-004, RNF-009, RNF-014)
   - docs/arquitetura/arquitetura.html ("Representação da importação OFX", Pluggy representation, client independence, QStash/R2 and jobs policy)
   - prompts/sprint3/dev1/*.md (to know what the backend will and will not provide)
   - backend-centralizador-financeiro/openapi/openapi.json (authoritative contract; check whether import or connection routes exist)
   - In each client: AGENTS.md, PRODUCT.md, DESIGN.md, UX_PRINCIPLES.md, DESIGN_DEFINITION_OF_DONE.md, src/lib/api/CONTRACT.md, src/lib/api/openapi.snapshot.json, src/lib/api/http-client.ts, src/lib/api/errors.ts, and the account and transaction screens.
3. Verify the client repositories still match the Sprint 2 closing commits above. If either diverged, stop and report instead of building on it.

Task

Close the client-side baseline for OFX import and Pluggy connection in both clients BEFORE any typed-client or UI implementation. This phase produces decisions and contract documentation; it does not build screens.

Part A — Traceability

Map every HU-004 and HU-007 acceptance criterion to the client flow that will satisfy it, the screen and state that shows it, the phase that will implement it (2 typed clients, 3 OFX, 4 Pluggy, 5 consolidation), and the Sprint 3 item (S3-03, S3-04, S3-06, S3-07, S3-08).

Part B — Contract status

For each item in s3-01-necessidades-dos-clientes.md (size limit, upload format, destination account, preview fields, duplicate rule and inclusion, confirmation/async/result, error codes, Pluggy token/registration/status/removal/deep link, fixtures), record its status with evidence:
- Approved: present in the backend OpenAPI or recorded as approved by Developer 1/Developer 3.
- Proposed: described in a Dev 1 or Dev 3 artifact but not yet approved.
- OPEN: undecided; name who must decide it.
Do not convert a proposal into a decision. If no contract is approved yet, the later phases build against the proposed contract with mocks, and integration waits for the real endpoint.

Part C — Client decisions to close (propose, justify, and wait for approval)

For each decision, present options, a recommendation, trade-offs, and dependency impact. Do not install anything in this phase.

1. Web upload path. The access token never reaches the browser, so the file must pass through the Next server (Server Action or Route Handler). Server Actions default to a 1 MB body limit (configurable through serverActions.bodySizeLimit, which includes multipart overhead). The web is hosted on Vercel, whose functions accept at most 4.5 MB per request. Recommend the path and the bodySizeLimit consistent with the approved or proposed file size.
2. HTTP client support for multipart. Both clients' http-client.ts serialize every body with JSON.stringify. Propose how to send FormData in each client without breaking existing JSON calls (for example, pass FormData through untouched and let the runtime set the multipart boundary).
3. Web navigation and routes. Propose where import and connection live (for example a dedicated route or an entry from Contas), route names in the existing Portuguese convention, and the change to PROTECTED_PREFIXES in src/proxy.ts, which currently lists only /contas, /movimentacoes, /categorias, and /regras.
4. Mobile navigation. src/ui/screens.tsx has four fixed tabs (Section type). Recommend whether import and connection are reached from an existing screen (for example Contas) through FormScreen-style flows, or need a new tab, keeping the tab bar usable.
5. Mobile file selection. No document picker is installed. Evaluate expo-document-picker (or alternatives) for Expo SDK 57; record it as a dependency proposal with justification. Do not install it.
6. Pluggy widgets. Evaluate react-pluggy-connect (web) and react-native-pluggy-connect (mobile) against the current official Pluggy documentation: compatibility with Next 16/React 19 and Expo SDK 57, whether the mobile SDK runs in Expo Go or needs a development build, and the OAuth deep link with the existing `coinciente` scheme. Record each as a dependency proposal. Do not infer SDK APIs.
7. Long-running import. If the contract allows asynchronous processing, define the client polling strategy (interval, backoff, stop conditions, leaving the screen) and what is shown meanwhile.
8. Screen inventory and state matrix. For every new screen in each client, list loading, empty, preview, partial, success, error, expired, cancelled, and submitting states, and the Problem Details codes each must handle, following UX_PRINCIPLES.md and DESIGN.md.
9. Wording. Connecting an account is authorizing read-only data access; never suggest moving money, payments, or Pix (RN-017 and PRODUCT.md). Define labels for consent, connection status, and removal.
10. Test approach. Vitest stays the tool in both clients (no component-test or end-to-end library without approval). Record which logic each phase must cover: file validation, multipart building, schemas, Idempotency-Key reuse on confirmation, error mapping, polling logic, Server Actions, and OpenAPI contract fixtures.

Part D — Record the baseline

After approval, record the approved decisions without changing runtime behavior:

- Update src/lib/api/CONTRACT.md in each client independently: a Sprint 3 section with planned operations and owning phase, contract status from Part B, open questions with owners, and the approved decisions for that platform.
- Append an "Execution handoff" section to this prompt file in the docs repository (prompts/sprint3/dev2/dev-2-sprint-3-fase-1-baseline-contrato-clientes.md) with approved decisions, dependency proposals awaiting approval, items sent to Developer 1 and Developer 3, and the Phase 2 boundary.
- Do not edit the Sprint 3 plan, the PRD, the Architecture, or Developer 1's documents. Report divergences instead.

Workflow

1. Run the model-selection assessment required by AGENTS.md.
2. Inspect the minimum required context listed above.
3. Build the traceability matrix (Part A) and the contract status table (Part B).
4. Present the plan: decisions (Part C) with options and recommendation, exact CONTRACT.md diffs per client and the handoff section, dependency proposals, risks, and validation commands.
5. Wait for: planejamento aprovado, pode implementar
6. Apply only the approved documentation changes.
7. Run the existing checks to confirm nothing changed (web: pnpm lint, pnpm typecheck, pnpm test; mobile: pnpm typecheck, pnpm test) and git diff --check in every changed repository.
8. Report actual results and remaining OPEN items.

Constraints

- Do not modify backend-centralizador-financeiro.
- Do not implement typed clients, screens, routes, Server Actions, or configuration changes in this phase.
- Do not install dependencies; record proposals only.
- Do not share code, schemas, or components between web and mobile.
- Do not invent routes, fields, states, status codes, error codes, limits, duplicate rules, or Pluggy behavior absent from approved sources.
- Never place Pluggy application credentials, API keys, Auth0 secrets, tokens, or real financial data in documentation, logs, fixtures, or examples.
- Preserve unrelated changes.

Output

During planning: traceability matrix, contract status table, decision proposals, dependency proposals, and exact file diffs. After implementation: changed files, validation actually executed, and remaining OPEN items with owners.

Acceptance criteria

- Every HU-004 and HU-007 criterion maps to a client flow, screen state, phase, and S3 item in both clients.
- Every client need is marked Approved, Proposed, or OPEN with evidence and owner.
- Upload path, multipart support, navigation, file selection, Pluggy widgets, polling, state matrix, wording, and test approach are approved or explicitly OPEN.
- CONTRACT.md in each client records the Sprint 3 baseline independently.
- No runtime code, configuration, dependency, or backend file was changed.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior frontend engineer and client-contract owner | template |
| Target environment | Codex | user-stated (same mold as prior Dev 2 prompts) |
| Phase split | Five phases: baseline, typed clients, OFX, Pluggy, consolidation; each covers both clients | user-stated (approved option, 2026-10-07) |
| Missing backend | Build on the approved or proposed contract with mocks; real integration waits for the endpoint; stop if no contract exists | user-stated (approved option, 2026-10-07) |
| Sprint scope and ownership | HU-004 and HU-007; Dev 2 owns S3-03/04/06/07 and confirms client needs in S3-01 | approved default — Sprint 3 plan |
| Repository paths | /home/miguel/projetos/* | repository evidence |
| Baseline commits | web 5357db1, mobile aad46c4, backend e95d2af | repository evidence (2026-10-07) |
| Client needs input | docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md | repository evidence |
| Upload constraints | Server Actions 1 MB default (Next 16.3.4 docs); Vercel 4.5 MB function body limit | repository evidence + vercel.com/docs/functions/limitations |
| HTTP clients | Both serialize bodies with JSON.stringify; no multipart support | repository evidence |
| Web route protection | PROTECTED_PREFIXES in src/proxy.ts | repository evidence |
| Mobile navigation | Four fixed tabs in src/ui/screens.tsx | repository evidence |
| Dependencies | No document picker or Pluggy SDK installed; proposals only in this phase | repository evidence + approved default — Sprint 3 plan |
| Authorization gate | Exact phrase before edits | AGENTS.md |

Source legend: **user-stated** — supplied or chosen by the user; **repository evidence** — verified in the repositories on 2026-10-07; **approved default** — taken from the approved Sprint 3 plan; **template** — standard skill clause.

## Execution handoff

Decisions approved on 2026-10-07 (`planejamento aprovado, pode implementar`):

- Web: file upload goes through a Server Action (not a Route Handler), with
  `serverActions.bodySizeLimit` set to the decided size (proposed `"2mb"`) once Dev 1/Dev 3
  confirm the OFX size limit. Import and connection live under `/contas` (`/contas/importar-ofx`,
  `/contas/conectar`); no new entry in `NAV_GROUPS` (`src/app/(app)/side-nav.tsx`);
  `PROTECTED_PREFIXES` already covers both by prefix.
- Mobile: import and connection open as `FormScreen` from an action in `AccountsScreen`; no new
  tab in `Section` (`src/ui/screens.tsx`).
- Both clients: `apiRequest()` in `src/lib/api/http-client.ts` will detect `body instanceof
  FormData` and send it unmodified (no `JSON.stringify`, no forced `content-type`), preserving
  existing JSON calls.
- Approved dependency proposals (none installed in this phase):
  - Web: `react-pluggy-connect@2.12.0` — `peerDependencies` `react >= 16.10.0` /
    `react-dom >= 16.10.0`, no upper bound; compatible with React 19.2.8.
  - Mobile: `expo-document-picker@57.0.3` — versioned alongside the installed Expo SDK 57
    (`peerDependencies: expo: "*"`), a standard Expo Go module.
  - Mobile: `react-native-pluggy-connect@1.6.0` — `peerDependencies` `react >= 16.12.0`,
    `react-native >= 0.63.4`, `react-native-webview >= 11.6.0`; compatible with RN 0.86.3/React
    19.2.3. Risk: the full OAuth round trip (`oauthRedirectUri` using the existing `coinciente`
    scheme) is only testable end-to-end with a development build — Expo Go cannot register a
    custom scheme for the OAuth return. Sandbox connectors without real OAuth (e.g. "Pluggy Bank"
    with `user-ok`/`password-ok`) remain testable in Expo Go.

Items sent to Developer 1 and Developer 3, still unanswered as of 2026-10-07: OFX maximum size,
destination account rule, duplicate identity rule and whether a flagged item can be included,
preview/result shape, closed list of Problem Details error codes, minimum Pluggy contract
(token/registration/status/removal), Developer 3's synthetic OFX fixtures. See
`docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md`.

Phase 2 boundary: no typed-client, schema, or real `FormData` implementation starts before this
baseline is recorded. Phase 2 consumes exactly the decisions above; every item still marked OPEN
stays an explicit mock and must not be silently turned into a final contract.

No runtime code, configuration, dependency, or backend file was changed in this phase. Only
`src/lib/api/CONTRACT.md` in each client and this prompt file were edited.

### Update 2026-10-08

Developer 1's backend contract (`docs/planejamento/sprint-03/contrato-backend-s3-01.html`, docs
`f851384`) arrived after this handoff and closes most items listed above as unanswered: routes,
OFX variants and encodings, 10 MiB backend limit, destination account chosen at confirmation,
duplicate rule (FITID per account, advisory fallback, duplicates always ignored), import and
connection states, and disconnect behavior. Backend `9887206` adds the OFX domain and persistence
but no controller, so none of these routes is in the OpenAPI yet. Each client's `CONTRACT.md`
"Sprint 3 (planejado)" section was rewritten with this contract and seven questions still open
with Developer 1, the first being that 10 MiB cannot pass through Vercel's 4.5 MB request limit
on web.
