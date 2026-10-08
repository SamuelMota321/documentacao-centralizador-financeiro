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
