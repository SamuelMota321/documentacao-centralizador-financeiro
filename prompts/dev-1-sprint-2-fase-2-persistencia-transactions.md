# Prompt: Dev 1 Sprint 2 — Phase 2 Transactions Persistence and RLS Foundation

- Scenario: development
- Created: 2026-09-20 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with these repositories as workspace roots:
   - C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
   - C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro
2. Use Plan mode. Review the proposed plan before authorizing edits.
3. Run this phase only after S2-01 is approved, documented, and available in the repository.
4. Authorize implementation only with the exact phrase: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer specialized in NestJS, Clean/Hexagonal Architecture, Prisma, PostgreSQL, migrations, and tenant isolation.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 2 Phase 2. S2-01 must be complete, approved, and documented.

Read and follow every applicable AGENTS.md.

Read the approved S2-01 baseline and the authoritative PRD, Architecture, RLS ADR, Sprint 2 plan, existing Prisma schema, migrations, OpenAPI, backend modules, tests, and execution instructions.

Task

Complete Dev 1’s contribution to S2-02: model the Transactions module and its tenant-aware persistence.

Implement only the approved Transactions foundation:

- Domain entities, value objects, invariants, and typed errors.
- Application use-case boundaries and repository ports.
- Transactions, categories, and category_rules persistence structures.
- Prisma schema changes.
- Versioned migrations.
- Required constraints, indexes, foreign keys, and enum values.
- Tenant ownership and property relationships.
- PostgreSQL RLS policies and grants required by the approved tenancy design.
- Tenant context propagation using the existing approved transaction mechanism.
- Mapping between Prisma models and domain models.
- Backend OpenAPI schemas or contract foundations required by the approved baseline.
- Focused unit and persistence tests.

Preserve these architectural constraints:

- Domain and Application cannot import NestJS, Prisma, Zod, HTTP, PostgreSQL, or infrastructure types.
- Prisma remains an outbound adapter.
- Transactions owns its tables and repositories.
- Cross-module access must use public Application interfaces or approved ports.
- Every protected record must have direct tenant ownership or a mandatory verifiable ownership relationship.
- Application-level authorization and PostgreSQL RLS are both required.

Workflow

1. Verify the S2-01 prerequisite from repository evidence.
2. Inspect current schema, migrations, roles, policies, transaction helpers, and test utilities.
3. Identify all affected files and possible migration risks.
4. Present the exact implementation plan, schema diff, SQL/RLS diff, test plan, commands, and dependency proposals.
5. Wait for:
   planejamento aprovado, pode implementar
6. Implement only the approved changes.
7. Validate with isolated or local environments only.
8. Report actual results and environmental limitations.

Constraints

- Do not implement movement endpoints, categorization flows, or client features yet.
- Do not modify web or mobile source code.
- Do not edit an already-applied migration; use a new forward migration.
- Do not use db push as a replacement for versioned migrations.
- Do not run destructive or shared-database operations without separate explicit authorization.
- RLS must fail closed when tenant context is absent or invalid.
- Do not weaken RLS, ownership filters, or constraints to make tests pass.
- Reuse current dependencies first.
- New dependencies require proposal, justification, and explicit approval before installation.
- Do not hardcode tenants, users, account IDs, or test-specific bypasses.
- Preserve unrelated work.

Acceptance criteria

- Transactions, categories, and category_rules belong to the Transactions module.
- Persistence is tenant-aware and structurally protected.
- Domain and Application remain infrastructure-independent.
- Migrations are reproducible and forward-only.
- Constraints and indexes enforce the approved invariants.
- RLS and tenant context follow the approved ADR.
- Focused unit and persistence tests cover valid ownership, missing ownership, invalid data, and cross-tenant denial.
- OpenAPI foundations can be consumed independently by web and mobile clients.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 1 Sprint 2 | user-stated |
| Task definition | S2-02 Transactions domain, persistence, migrations, constraints, indexes, and RLS foundation | user-stated through the approved Sprint 2 plan |
| Prerequisite | Approved and documented S2-01 baseline | user-stated through the plan dependency |
| Repository scope | Backend and documentation repositories | user-stated |
| Client scope | Web/mobile source code is out of scope | user-stated |
| Dependency policy | New dependencies require proposal and approval before installation | user-stated |
| Architecture | Existing Clean/Hexagonal, Prisma, PostgreSQL, and RLS patterns | repository-grounded default |
| Acceptance checks | Schema, migration, RLS, ownership, and focused tests | approved default |
| Authorization checkpoint | Exact phrase required before edits | template plus repository instruction |

Source legend: user-stated means supplied by the user or approved plan; approved default means a repository-grounded default selected for this prompt; template means a standard skill clause.
