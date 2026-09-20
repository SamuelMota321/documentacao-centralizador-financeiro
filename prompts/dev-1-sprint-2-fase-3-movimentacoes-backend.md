# Prompt: Dev 1 Sprint 2 — Phase 3 Backend Movements

- Scenario: development
- Created: 2026-09-20 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with these repositories as workspace roots:
   - C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
   - C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro
2. Use Plan mode. Review the proposed plan before authorizing edits.
3. Run this phase only after S2-01 and S2-02 are complete.
4. Authorize implementation only with the exact phrase: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer specialized in NestJS REST APIs, application use cases, Prisma, PostgreSQL, OpenAPI, and idempotent financial operations.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 2 Phase 3. S2-01 and S2-02 must already be complete.

Read and follow every applicable AGENTS.md and inspect the approved Transactions baseline, existing backend patterns, Prisma schema, migrations, OpenAPI, authentication, tenant context, error handling, and tests.

Task

Complete Dev 1’s contribution to S2-03: implement backend use cases and REST endpoints for manual income, expense, and accounting transfer registration.

Implement only the behavior approved in S2-01:

- Required account, value, date, and transaction-type validation.
- Income registration.
- Expense registration.
- Accounting transfer between two accounts owned by the same tenant.
- Atomic creation of transfer entries.
- Idempotency according to the approved key, scope, and window.
- Tenant ownership checks at the Application and persistence layers.
- Problem Details errors and documented status codes.
- OpenAPI contract updates.
- Focused domain, application, persistence, and REST tests.
- Audit integration when required by the approved audit contract.

Transfers must remain accounting records. They must not initiate bank transfers, Pix, payments, or any real movement of funds.

Workflow

1. Verify prerequisites and identify existing endpoint, authentication, tenant-context, and error-handling patterns.
2. Build a traceability matrix from the approved S2-01 decisions to the implementation.
3. Present the problem, solution, exact affected files, endpoint contract, transaction/migration impact, idempotency behavior, risks, test commands, and proposed dependencies.
4. Wait for:
   planejamento aprovado, pode implementar
5. Implement only the approved plan.
6. Run focused tests, REST tests, type-check, lint, build, OpenAPI generation/checks, and safe database checks.
7. Report actual results and unresolved limitations.

Constraints

- Do not modify web or mobile source code.
- Do not invent endpoint names, fields, status codes, idempotency semantics, or error codes.
- Do not implement categorization or personal rules yet.
- Do not access another module’s private tables or repositories.
- Do not bypass authentication, ownership, RLS, or idempotency.
- Do not expose tokens, secrets, full financial payloads, or another tenant’s existence.
- Do not claim idempotency without testing repeated requests and relevant failure/retry paths.
- Do not perform migrations against shared or remote databases without explicit authorization.
- Reuse existing dependencies first.
- New dependencies require an approved proposal before installation.
- Preserve unrelated changes.

Acceptance criteria

- Valid income and expense requests persist correctly for the authenticated tenant.
- Invalid required fields are rejected according to the approved contract.
- Transfers create consistent entries atomically between accounts of the same tenant.
- Cross-tenant account combinations are denied.
- Repeating the same idempotent operation does not create duplicates.
- No operation moves real funds.
- OpenAPI matches observable REST behavior.
- Relevant unit, integration, and REST tests pass or report genuine environmental blockers.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 1 Sprint 2 | user-stated |
| Task definition | S2-03 backend income, expense, and accounting transfer behavior | user-stated through the approved Sprint 2 plan |
| Prerequisites | Approved S2-01 baseline and completed S2-02 foundation | user-stated through the plan dependencies |
| Repository scope | Backend and documentation repositories | user-stated |
| Client scope | Web/mobile source code is out of scope | user-stated |
| Dependency policy | New dependencies require proposal and approval before installation | user-stated |
| Edge cases | Ownership, atomic transfer, idempotency, validation, and Problem Details | plan and repository contract |
| Acceptance checks | Unit, integration, REST, OpenAPI, and safe database validation | approved default |
| Authorization checkpoint | Exact phrase required before edits | template plus repository instruction |

Source legend: user-stated means supplied by the user or approved plan; approved default means a repository-grounded default selected for this prompt; template means a standard skill clause.
