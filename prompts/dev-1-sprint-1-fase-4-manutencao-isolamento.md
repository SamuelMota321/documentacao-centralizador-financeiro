# Prompt: Dev 1 Sprint 1 — Phase 4 Maintenance and Isolation

- Scenario: development
- Created: 2026-09-08 · Target: Codex · Prompt language: English

## How to use

1. After phases 1 through 3 are complete, open a new Codex task with `C:\Users\smota\Documents\documentacao-centralizador-financeiro` and `C:\Users\smota\Documents\backend-centralizador-financeiro` available as workspace roots.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend and database engineer specialized in NestJS authorization, PostgreSQL row-level security, and tenant-isolated application design.

Context

Project: Centralizador Financeiro Inteligente.

Work with:
- `C:\Users\smota\Documents\documentacao-centralizador-financeiro`
- `C:\Users\smota\Documents\backend-centralizador-financeiro`

This is phase 4. The Dev 1 portions of S1-01 through S1-05 must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative vision, PRD, architecture, and Sprint 1 documents.
3. Verify the preceding phases from repository evidence.
4. Inspect the minimum relevant authorization, Accounts, Identity, persistence, Prisma, migration, RLS, REST, OpenAPI, audit, and test code.
5. Follow the project’s active documented stack and current repository patterns.

Task

Complete only the Dev 1 contributions to S1-06 and S1-07.

For S1-06:

- Implement account update behavior.
- Implement the documented account deactivation or deletion behavior; do not choose between soft deactivation and hard deletion without documentary authority.
- Enforce authentication, authorization, and ownership.
- Apply the documented validation rules.
- Preserve the applicable audit trail exactly as defined by the project.
- Keep persistence and OpenAPI behavior consistent.

For S1-07:

- Apply NestJS authorization and tenant/property filters to every relevant Identity and Accounts query and mutation.
- Apply PostgreSQL RLS as defense in depth according to the documented tenancy strategy.
- Ensure tenant context is propagated safely to database operations.
- Deny cross-tenant reads, creates, updates, deactivations, and deletions at both the application and database layers where applicable.
- Avoid responses, errors, logs, or timing-sensitive branches that unnecessarily reveal whether another tenant’s resource exists.

Do not implement client confirmation dialogs or web/mobile state handling; those belong to Dev 2. Do not expand into unrelated security hardening or Dev 3’s full validation assignment.

Workflow

1. Verify prerequisite behavior and identify all relevant query and mutation paths.
2. Enumerate ownership, cross-tenant, lifecycle, audit, transaction, and RLS edge cases.
3. Present a plan containing the problem, solution, rationale, affected files, exact diff, SQL/RLS changes, risks, validation strategy, and executable checks.
4. Wait for:
   `planejamento aprovado, pode implementar`
5. Implement only the approved changes.
6. Validate application authorization and database RLS independently in an authorized local or test environment.
7. Run relevant unit, integration, REST, migration, lint, type-check, build, and OpenAPI checks.
8. Iterate only within the approved scope.

Constraints

- Do not infer deactivation versus deletion semantics, audit schema, retention rules, tenant-context mechanism, or authorization response behavior.
- If the documentation does not resolve a required security decision, stop and report the exact decision needed.
- Every relevant repository query and mutation must receive explicit review; do not assume endpoint protection alone is sufficient.
- Do not weaken RLS or application filtering merely to make integration tests pass.
- Do not run destructive SQL or migrations against shared or remote environments without separate confirmation.
- Reuse approved dependencies and existing patterns.
- Preserve architectural boundaries and unrelated changes.
- Do not hardcode tenant identifiers, users, claims, account IDs, or test-specific bypasses.

Output

During planning, identify exact existing paths and localized changes for account use cases, authorization, persistence, Prisma/migrations, RLS SQL, REST/OpenAPI, audit behavior, and focused tests. Do not create new architectural layers unless the documentation and approved plan require them.

Acceptance criteria

- Authorized users can update and deactivate/delete their own accounts according to documented lifecycle semantics.
- Applicable audit information is preserved.
- Attempts against another tenant’s resources are rejected without sensitive disclosure.
- All relevant Identity and Accounts reads and mutations are protected by application authorization/property filtering.
- PostgreSQL RLS provides independent defense in depth.
- Allowed and cross-tenant cases are reproducible in focused tests.
- Relevant discovered checks pass.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the “paste the prompt” step come from the skill's file template | template |
| Role | Senior backend/database engineer for NestJS authorization, PostgreSQL RLS, and tenant isolation | template + user-stated stack |
| Task definition | Dev 1 contributions to S1-06 and S1-07 | user-stated through referenced Sprint plan |
| Stack and language | NestJS authorization, Prisma/PostgreSQL, and RLS; details come from project documentation | user-stated |
| Pattern reference | Discover authorization, lifecycle, and migration patterns | approved default |
| Dependency policy | Active documented stack only | user-stated |
| Edge cases | Ownership, cross-tenant operations, audit, lifecycle, and RLS context | user-stated through Sprint plan + approved default |
| Acceptance criteria | Maintenance, application authorization, and database isolation | user-stated |
| Output form | Propose paths from the existing layout | approved default |
| New task | Run after phases 1 through 3 in a separate Codex task | user-stated |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template + user-stated |
| Safety | No destructive remote SQL, weakened checks, or test bypasses | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
