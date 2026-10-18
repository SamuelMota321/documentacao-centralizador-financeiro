# Prompt: Dev 1 Sprint 4 — Phase 6 Backend Integration and Evidence

- Scenario: development
- Created: 2026-10-18 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots. Add web/mobile repositories only if needed for read-only contract review.
2. Use Plan mode. Review the exact verification scope, files, local services, and client read-only boundaries before authorizing edits.
3. Run after Dev 1’s implementation phases are complete. Coordinate with Developers 2 and 3 for current client and cross-sprint evidence.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Do not call Pluggy/R2, apply migrations, or use shared/production systems without explicit authorization.
6. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for integration quality, contract consistency, and evidence-based technical handoffs.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

Web and mobile repositories may be opened for read-only contract review, but are owned by Developer 2 and must not be edited. This is Dev 1’s backend contribution to S4-06; Developer 3 owns overall Sprint evidence consolidation. Read applicable AGENTS.md files, the Sprint 4 plan and definition of done, PRD HU-008/HU-009/HU-011/HU-012, the approved phase decisions, Architecture, and current backend validation scripts.

## Task

Consolidate and verify only Dev 1’s backend contributions across HU-008, HU-009, HU-011, and HU-012.

1. Trace each backend acceptance criterion to current implementation, tests, OpenAPI, migration/RLS evidence, and handoff.
2. Verify the backend contract against available client contract evidence without changing client source.
3. Resolve only in-scope defects already covered by approved decisions. If a new product or architectural decision is required, document the blocker and request approval.
4. Review test fixtures, logs, and reports for secrets and unnecessary real financial data.
5. Prepare precise handoffs to Developer 2 (API behavior and limitations) and Developer 3 (backend test/evidence results and unresolved cases).

## Workflow

1. Verify the current branch and working tree; preserve unrelated changes.
2. Build a requirement-to-code-to-test matrix for the four Dev 1 backend slices.
3. Present the exact plan, affected files, validation commands, risks, and any external/local service needs.
4. Wait for planejamento aprovado, pode implementar.
5. Make only approved backend/documentation changes.
6. Run focused checks, then the relevant full backend suite and smoke checks that are safe in an isolated local environment.
7. Report actual commands and results. Distinguish passed, failed, skipped, pre-existing, and blocked checks.

## Constraints

- Do not claim S4-06 or the Sprint 4 definition of done is complete solely from Dev 1 backend evidence.
- Do not edit web or mobile implementation, tests, or generated client types owned by Developer 2.
- Do not absorb unrelated open audit findings from previous sprints unless they are verified, in scope, and separately approved.
- Do not apply migrations, use shared/production databases, change credentials, or call Sandbox services without explicit approval.
- Do not use git add ., commit, or rewrite history. Suggest a commit message; commit only if separately authorized.
- Preserve tenant isolation, audit, and secret-handling behavior. Preserve unrelated user changes.

## Output

Provide a backend traceability matrix; changed-file list; exact validation commands and results; unresolved blockers and owners; handoffs to Developers 2 and 3; and a suggested commit message. Separate “Dev 1 backend verified” from “overall Sprint 4 verified”.

## Acceptance criteria

- Each Dev 1 backend criterion maps to implementation and executable evidence or an explicit gap.
- OpenAPI and backend behavior match approved decisions.
- Relevant tests, typecheck, lint, build, Prisma validation, migration/RLS verification, and OpenAPI generation/check are run when applicable and supported by the local environment.
- Any skipped check names the reason and its residual risk.
- Integration with web/mobile is reported only to the extent supported by inspected client contracts or developer handoffs.
- No overall sprint completion is claimed without evidence from all owners.

Begin by verifying the current branch, working tree, phase handoffs, and the Dev 1/Dev 2/Dev 3 ownership boundaries in the Sprint 4 plan.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template and prompt language | Prompt header, usage section, English prompt, and decision record | template |
| Scenario and role | Development; senior backend engineer for integration and evidence | template |
| Task and ownership | Dev 1’s backend slice of S4-06; Dev 3 owns overall evidence consolidation | approved default — selected Sprint 4 responsibility split |
| Prerequisites | Dev 1 implementation phases and available cross-owner evidence | approved default — Sprint 4 plan |
| Stack and patterns | Verify current backend contracts, scripts, and architecture | approved default — backend repository and Architecture |
| Edge cases | Missing handoffs, pre-existing failures, blocked checks, stale audit findings | approved default — Sprint 4 plan and implementation-skill validation guidance |
| Dependency policy | No new dependencies or out-of-scope changes | approved default — development scenario and repository instructions |
| Acceptance and checks | Backend regression suite and relevant Prisma/RLS/OpenAPI checks | approved default — Sprint 4 plan and current backend package scripts |
| Client boundary | Client repositories read-only; overall sprint status remains with all owners | approved default — selected responsibility split |
| Approval gate | Exact phrase before edits | user-stated — supplied AGENTS.md |
