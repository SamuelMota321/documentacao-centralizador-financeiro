# Prompt: Dev 1 Sprint 2 — Phase 6 Backend Tests and Technical Consolidation

- Scenario: development
- Created: 2026-09-20 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with these repositories as workspace roots:
   - C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
   - C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro
2. Use Plan mode. Review the proposed plan before authorizing edits.
3. Run this phase after the approved Dev 1 implementation for S2-01 through S2-07 is available.
4. Authorize implementation only with the exact phrase: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer responsible for backend verification, contract validation, integration, and technical handoff.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 2 Phase 6. The approved Dev 1 implementation for S2-01 through S2-07 must already be complete.

Read and follow every applicable AGENTS.md, Sprint 2 plan, PRD, Architecture, RLS ADR, current backend implementation, OpenAPI, migrations, tests, and technical documentation.

Task

Complete Dev 1’s contribution to S2-08 and S2-09.

For S2-08, provide backend-focused verification for:

- Domain invariants.
- Application use cases.
- Prisma/PostgreSQL persistence.
- Migrations and constraints.
- REST endpoints using Supertest.
- Authentication and protected endpoint behavior relevant to the backend.
- Tenant ownership and cross-tenant denial.
- PostgreSQL RLS.
- Transfer atomicity.
- Idempotency.
- Categorization and manual correction.
- Personal rule lifecycle and deterministic conflicts.
- Audit behavior.
- OpenAPI consistency.

For S2-09, complete only the technical backend consolidation:

- Validate the backend build and runtime-relevant checks.
- Validate migrations in an isolated or authorized local database.
- Validate OpenAPI generation and consistency.
- Update directly affected backend instructions and technical evidence.
- Produce a handoff for Developer 2 describing the final contract and any client integration limitations.
- Produce a handoff for Developer 3 describing backend evidence, unresolved cases, and test limitations.

Do not implement web/mobile source code, client tests, the complete Sprint demonstration, or Developer 3’s independent consolidation responsibilities.

Workflow

1. Build a traceability matrix from S2-01 through S2-09 to implementation evidence and executable checks.
2. Classify each item as:
   - implemented and verified;
   - implemented but unverified;
   - missing;
   - blocked by environment or another developer.
3. Present the exact test and consolidation plan, affected files, commands, risks, and dependency proposals.
4. Wait for:
   planejamento aprovado, pode implementar
5. Implement only approved test, backend, contract, or documentation changes.
6. Run the narrowest relevant checks first, then broader backend checks.
7. Report every actual command and result.

Use the repository’s existing scripts where applicable, including:

- npm run test:unit
- npm run test:integration
- npm run test:e2e
- npm run prisma:validate
- npm run db:verify-rls
- npm run openapi:generate
- npm run lint
- npm run typecheck
- npm run format:check
- npm run build
- git diff --check

Discover current commands if the repository has changed.

Constraints

- Modify only backend and technical documentation files.
- Do not modify web or mobile source code.
- Use isolated or authorized local databases only.
- Do not claim an integration, migration, RLS, or authentication check passed when the environment prevented execution.
- Do not change valid tests merely to hide a production defect.
- Do not bypass authentication, ownership, RLS, migrations, idempotency, or contract checks.
- Use fictitious data only.
- Do not include secrets, real tokens, credentials, or real financial data in fixtures, logs, or evidence.
- Reuse existing dependencies first.
- New dependencies require a written benefit and explicit approval before installation.
- Preserve unrelated changes.

Acceptance criteria

- Backend unit, integration, REST, migration, RLS, and contract coverage is reproducible.
- Cross-tenant, idempotency, transfer, categorization, rule-conflict, and audit cases have explicit evidence.
- OpenAPI matches backend behavior.
- Relevant lint, type-check, format, build, and test checks pass or have documented environmental blockers.
- Backend documentation and handoffs are current.
- No web/mobile implementation was changed.
- The final report clearly separates Dev 1 completion from Developer 2 and Developer 3 responsibilities.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 1 Sprint 2 | user-stated |
| Task definition | S2-08 backend tests and S2-09 technical integration/consolidation | user-stated through the approved Sprint 2 plan |
| Prerequisites | Approved Dev 1 implementation for S2-01 through S2-07 | user-stated through the plan dependencies |
| Repository scope | Backend and documentation repositories | user-stated |
| Client scope | Web/mobile source code is out of scope | user-stated |
| Dependency policy | New dependencies require proposal and approval before installation | user-stated |
| Edge cases | RLS, cross-tenant access, idempotency, transfers, categorization, rules, audit, and unavailable environments | plan and repository contract |
| Acceptance checks | Existing backend scripts, reproducible evidence, and technical handoffs | repository-grounded default |
| Authorization checkpoint | Exact phrase required before edits | template plus repository instruction |

Source legend: user-stated means supplied by the user or approved plan; approved default means a repository-grounded default selected for this prompt; template means a standard skill clause.
