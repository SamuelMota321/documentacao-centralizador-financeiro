# Prompt: Dev 1 Sprint 2 — Phase 5 Idempotency, Isolation, and Audit

- Scenario: development
- Created: 2026-09-20 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with these repositories as workspace roots:
   - C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
   - C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro
2. Use Plan mode. Review the proposed plan before authorizing edits.
3. Run this phase after the approved Dev 1 implementation for S2-01 through S2-06 is available.
4. Authorize implementation only with the exact phrase: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend and database security engineer specialized in NestJS authorization, PostgreSQL RLS, Prisma transactions, idempotency, and audit trails.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 2 Phase 5. The approved Dev 1 portions of S2-01 through S2-06 must already be implemented.

Read and follow every applicable AGENTS.md, the Sprint 2 plan, PRD RN-001 through RN-005 and RN-015, Architecture, adr-rls-postgresql.html, current backend code, migrations, SQL scripts, OpenAPI, and tests.

Task

Complete Dev 1’s implementation contribution to S2-07.

Review and harden all Transactions behavior for:

- Application-level ownership and authorization.
- Cross-tenant read and mutation denial.
- PostgreSQL RLS defense in depth.
- Correct tenant context propagation within short Prisma transactions.
- Fail-closed behavior when tenant context is missing or invalid.
- Idempotent repeated commands without duplicate movements.
- Atomic transfer behavior.
- Audit records for relevant business actions.
- Audit fields: actor, tenant, action, resource, timestamp, result, and request/correlation identifier.
- Separation between technical logs and business audit.
- Absence of tokens, secrets, unnecessary financial payloads, or sensitive data in logs and audit.
- Failure atomicity when audit persistence belongs to the business operation.

Review every relevant query and mutation path. Do not assume that endpoint authentication alone is sufficient.

Workflow

1. Inspect all relevant queries, mutations, repository ports, Prisma adapters, migrations, RLS policies, roles, grants, audit writers, and tests.
2. Build a matrix of operation, application authorization, tenant context, RLS policy, audit behavior, and test evidence.
3. Identify missing or contradictory security behavior.
4. Present the exact implementation plan, SQL/RLS changes, affected files, risks, rollback considerations, and validation commands.
5. Wait for:
   planejamento aprovado, pode implementar
6. Implement only approved changes.
7. Validate application isolation and PostgreSQL isolation independently in an isolated or authorized local test database.
8. Report actual evidence and limitations.

Constraints

- Do not modify web or mobile source code.
- Do not weaken authorization or RLS to make tests pass.
- Do not run destructive SQL, reset a shared database, or alter a remote database without separate authorization.
- Do not use a privileged or bypass-RLS runtime role as evidence of isolation.
- Do not expose whether another tenant’s resource exists.
- Do not invent audit retention, role, policy, or lifecycle semantics absent from the approved architecture.
- Reuse current dependencies first.
- New dependencies require approved justification before installation.
- Preserve unrelated changes and use fictitious data only.

Acceptance criteria

- Cross-tenant reads and mutations are denied at the application and database layers.
- Tenant context cannot leak across pooled connections or transactions.
- Repeated idempotent commands do not duplicate movements.
- Transfers remain atomic.
- Relevant actions produce minimal audit records.
- Failed audit persistence cannot produce a false successful business operation.
- No secrets or unnecessary financial payloads appear in logs or audit.
- Focused application, integration, RLS, and migration checks pass or report genuine blockers.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 1 Sprint 2 | user-stated |
| Task definition | S2-07 idempotency, isolation, RLS, authorization, and audit | user-stated through the approved Sprint 2 plan |
| Prerequisites | Approved Dev 1 implementation for S2-01 through S2-06 | user-stated through the plan dependencies |
| Repository scope | Backend and documentation repositories | user-stated |
| Client scope | Web/mobile source code is out of scope | user-stated |
| Dependency policy | New dependencies require proposal and approval before installation | user-stated |
| Edge cases | Cross-tenant access, pooled connections, missing context, duplicate commands, audit atomicity, and sensitive data minimization | plan and repository contract |
| Acceptance checks | Application, PostgreSQL, migration, and audit evidence | approved default |
| Authorization checkpoint | Exact phrase required before edits | template plus repository instruction |

Source legend: user-stated means supplied by the user or approved plan; approved default means a repository-grounded default selected for this prompt; template means a standard skill clause.
