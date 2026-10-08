# Prompt: Dev 2 Sprint 3 — Phase 3 OFX Import in Web and Mobile (S3-03, S3-04)

- Scenario: development
- Created: 2026-10-07 · Target: Codex · Prompt language: English

## How to use

1. Run only after Phase 2 is complete and its "Execution handoff" is recorded.
2. Open a new Codex task with these repositories as workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only reference)
3. Run `git pull` in all four repositories. Real integration needs Developer 1's S3-02 endpoints (`prompts/sprint3/dev1/dev-1-sprint-3-fase-3-fluxo-ofx-previa-confirmacao.md`); without them, this phase delivers the flows on mocks and records integration as pending.
4. If the mobile file picker was not approved in Phase 1, mobile file selection stays blocked; do not install it here without approval.
5. Use Plan mode. Authorize implementation only with the exact phrase: `planejamento aprovado, pode implementar`.
6. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer specialized in Next.js (App Router, Server Actions), React Native/Expo, file upload UX, multi-step review-and-confirm flows, and accessible interface states.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro (Next.js)
- /home/miguel/projetos/mobile-centralizador-financeiro (React Native/Expo)
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY reference; never modify)

This is Dev 2 Sprint 3 Phase 3: S3-03 (web) and S3-04 (mobile). Read the "Execution handoff" of Phases 1 and 2 first; they define the approved decisions, the contract status of each function, and the typed clients to use.

Read and follow every applicable AGENTS.md. On web, read node_modules/next/dist/docs/ for Server Actions, forms, and next.config serverActions before writing code. In each client, follow PRODUCT.md, DESIGN.md, UX_PRINCIPLES.md, and DESIGN_DEFINITION_OF_DONE.md, and reuse existing components before creating new ones.

Task

Implement the OFX import flow independently in each client:

1. Entry point and navigation exactly as approved in Phase 1 (web route plus src/proxy.ts protection; mobile entry and screen pattern).
2. Destination account according to the approved rule (chosen before upload, or suggested in the preview).
3. File selection with client-side type and size checks (usability only; the backend decides). Web: file input inside a form handled by a Server Action, with serverActions.bodySizeLimit set to the approved limit plus multipart overhead. Mobile: the approved document picker only.
4. Preview before any persistence: period, counts (total, new, duplicate, invalid), items with date, signed amount, description, and situation with its reason; paginated if the contract paginates. Duplicates follow the approved rule; allow including flagged items only if approved.
5. Explicit confirmation using the Idempotency-Key rules (same key on any failure; rotate after success or REUSED/EXPIRED). Double submission must not create a second import.
6. Long imports: if the contract is asynchronous, show progress with the approved polling strategy and stop polling when leaving the screen or on terminal states.
7. Result: imported, ignored, and failed counts, failed items with pt-BR reasons, and a path back to Movimentações. Web: highlight created transactions as the existing "recent" behavior does, if the contract returns their ids.
8. States for every step: loading, empty file, invalid file, too large, unsupported type (PDF), preview expired, partial result, network failure with retry keeping the selection, session expired (re-authentication), and disabled/submitting. Errors stay visible near their cause; success uses the existing toast (web) or Notice (mobile).
9. Accessibility: labels, keyboard and focus (web), accessibilityRole/State (mobile), 24 px minimum targets (web) and 44 pt (mobile), color never the only signal.

Integration

- If the real endpoints exist and match the contract, integrate against a local backend with synthetic OFX fixtures and record the evidence.
- If not, deliver on mocks, mark integration as pending in the handoff, and list exactly what must be re-checked when the endpoints arrive.

Tests (Vitest; no component-test library without approval)

- Server Actions (web): validation before calling the API, multipart forwarding, Idempotency-Key reuse and rotation, error mapping, re-authentication.
- Presentation logic (both): counts, duplicate labels, signed amounts, state transitions, polling stop conditions.

Workflow

1. Run the model-selection assessment required by AGENTS.md.
2. Verify Phase 1 and 2 handoffs and the current backend contract.
3. Present the plan per client: screens, files, state matrix, configuration change (bodySizeLimit), dependency use, tests, integration mode (real or mocks), risks, and validation commands.
4. Wait for: planejamento aprovado, pode implementar
5. Implement only the approved scope, one client at a time.
6. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test, npx expo export --platform android; git diff --check; run the visual checks available in the environment and report what still needs a device or browser.
7. Append an "Execution handoff" with screens delivered, integration status, evidence, open items, and validation results.

Constraints

- Do not modify backend-centralizador-financeiro.
- Do not share code or components between web and mobile.
- Do not persist or cache OFX content or previews on the client beyond the screen's lifetime; nothing in SecureStore, AsyncStorage, or browser storage.
- Never send the file directly from the browser to the backend (the token stays server-side).
- Do not invent limits, fields, states, or duplicate rules beyond the approved or proposed contract.
- Do not add dependencies beyond those approved in Phase 1.
- Do not implement Pluggy, HU-008 synchronization, or investments.
- Use only synthetic OFX fixtures; never real statements, tokens, or credentials.
- Preserve unrelated changes and do not weaken existing tests.

Output

Planning: per-client plan and state matrix. After implementation: changed files per client, integration status (real or mocks), validation actually executed, and handoff.

Acceptance criteria

- Both clients go through select, validate, preview, confirm, and result; PDF and invalid files are rejected with clear messages.
- The preview appears before any persistence and shows duplicates according to the approved rule.
- Repeated or double confirmation does not create a second import (proven by tests).
- Long imports show a queryable state if the contract is asynchronous.
- All states in the matrix are implemented and reachable.
- All listed validation commands pass; integration is either evidenced or explicitly pending.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior frontend engineer (upload and review flows) | template |
| Target environment | Codex | user-stated (same mold as prior Dev 2 prompts) |
| Phase split | Phase 3 of 5: OFX import in both clients (S3-03, S3-04) | user-stated (approved option, 2026-10-07) |
| Missing backend | Deliver on mocks when endpoints are absent; record integration as pending | user-stated (approved option, 2026-10-07) |
| Flow steps | Select, validate, preview, duplicates, confirm, result, async status | approved default — PRD HU-004 and Sprint 3 plan |
| Upload limits | Server Actions 1 MB default; Vercel 4.5 MB; token stays server-side | repository evidence + vercel.com/docs/functions/limitations |
| Design references | PRODUCT.md, DESIGN.md, UX_PRINCIPLES.md, DESIGN_DEFINITION_OF_DONE.md per client | repository evidence |
| Existing patterns | Toast and recent-row highlight (web), Notice and FormScreen (mobile), Idempotency-Key rules | repository evidence (Sprint 2) |
| Dependencies | Only those approved in Phase 1 (document picker for mobile) | approved default — Sprint 3 plan |
| Authorization gate | Exact phrase before edits | AGENTS.md |

Source legend: **user-stated** — supplied or chosen by the user; **repository evidence** — verified in the repositories on 2026-10-07; **approved default** — taken from approved project documents; **template** — standard skill clause.
