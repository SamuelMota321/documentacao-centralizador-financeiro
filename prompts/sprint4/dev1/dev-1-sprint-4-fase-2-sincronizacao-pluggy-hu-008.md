# Prompt: Dev 1 Sprint 4 — Phase 2 Pluggy Synchronization (HU-008)

- Scenario: development
- Created: 2026-10-18 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode. Review the exact plan, files, data scope, and local services before authorizing changes.
3. Run only after Phase 1’s blocking S4-01 decisions and the HU-007 backend prerequisites are verified and approved.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Use Pluggy Sandbox only when credentials, external access, and the specific call are explicitly authorized.
6. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for reliable, tenant-safe provider synchronization.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1’s principal backend responsibility for S4-02 / HU-008. Developer 2 owns the client experiences and Developer 3 owns the principal acceptance scenarios and cross-tenant evidence. Read applicable AGENTS.md files, the Sprint 4 plan, PRD HU-008 and RN-007/RN-014, Architecture, RLS decisions, the approved Phase 1 decision register, and current backend patterns.

## Task

Implement the approved backend behavior for manual and daily Pluggy synchronization.

- Provide a user-requested manual synchronization through the approved backend contract.
- Provide daily scheduled synchronization using an existing approved scheduling pattern.
- Prevent duplicate effects when an execution is repeated.
- Prevent or serialize overlapping executions for the same connection.
- Apply controlled retries and expose a traceable execution state.
- Put only approved identifiers and minimal metadata in jobs.
- Synchronize only the provider data types approved in Phase 1 and the existing HU-007 contract.

Do not choose a route, scheduler, job system, retry policy, or data type without an authoritative existing pattern or approved decision. If the repository cannot meet the requirement without a new mechanism, present its rationale, operational impact, and testing implications for approval before implementation.

## Workflow

1. Verify Phase 1 decisions, HU-007 prerequisites, existing provider calls, module ownership, tenant context, and backend scripts.
2. Present a plan with exact API behavior, affected files, storage/job changes, security boundaries, rollback considerations, and validation commands.
3. Wait for planejamento aprovado, pode implementar.
4. Implement only the approved HU-008 backend slice.
5. Run focused checks first, then justified backend checks. Use isolated local services only.
6. Report actual results, unresolved data types, Sandbox evidence or limitations, and handoffs.

## Constraints

- Preserve module boundaries; use public Application interfaces for cross-module behavior.
- Do not make external Pluggy calls inside tenant-aware database transactions.
- Never place tokens, credentials, or unnecessary financial payloads in jobs, logs, fixtures, or responses.
- Preserve tenant ownership, authorization, idempotency, audit, and RLS behavior.
- Do not modify web/mobile source code or claim their manual trigger/status UI is complete.
- Do not add dependencies, change credentials/configuration, call external services, apply migrations, or use shared/production databases without explicit approval.
- Do not guess unresolved provider availability, retry counts, stale-data behavior, or connection removal semantics.
- Preserve unrelated work and use synthetic fixtures unless Sandbox use was explicitly approved.

## Output

Provide the approved behavior implemented, API/OpenAPI changes, changed files, test and validation results, outstanding blockers, and handoffs to Developers 2 and 3. Suggest a commit message; do not commit unless separately authorized.

## Acceptance criteria

- Daily and manual synchronization use the approved contract.
- Repeated work does not duplicate accounts, transactions, positions, or movements within the approved scope.
- Simultaneous work for one connection is prevented or serialized.
- Retry and execution state are observable under the approved policy.
- Jobs contain only approved minimum identifiers and metadata.
- Relevant focused tests cover idempotency, overlap, retry/failure, and tenant isolation.
- Verify current scripts before running them. At minimum, run the relevant focused test command; run npm run lint, npm run typecheck, and migration/RLS checks when affected and supported by an isolated environment.

Begin by verifying the approved Phase 1 decisions and current HU-007 implementation; stop if a required data-scope or synchronization decision remains open.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template and prompt language | Prompt header, usage section, English prompt, and decision record | template |
| Scenario and role | Development; senior backend engineer for provider synchronization | template |
| Task and ownership | Dev 1’s S4-02/HU-008 backend implementation | approved default — selected Sprint 4 responsibility split |
| Prerequisites | Phase 1 decisions and HU-007 backend readiness | approved default — Sprint 4 plan |
| Stack and patterns | Discover and follow current backend stack, modules, and scheduling patterns | approved default — backend repository |
| Edge cases | Repeated runs, overlap, retries, failures, tenant isolation, partial provider availability | approved default — Sprint 4 plan and PRD HU-008 |
| Dependency policy | Use existing dependencies; propose new mechanisms for approval | approved default — development scenario and Sprint 4 plan |
| Acceptance and checks | Focused tests, lint/typecheck and relevant migration/RLS checks | approved default — PRD, Sprint 4 plan, and backend scripts |
| How-to-use phase order | Run after approved Phase 1; do not assume client implementation is complete | approved default — dependency and ownership tables |
| Sandbox permission | Explicit authorization required for Pluggy calls | approved default — existing Dev 1 prompt convention and repository instructions |
| Approval gate | Exact phrase before edits | user-stated — supplied AGENTS.md |
