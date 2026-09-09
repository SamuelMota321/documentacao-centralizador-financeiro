# Prompt: Dev 1 Sprint 1 — Phase 2 Foundation and Modeling

- Scenario: development
- Created: 2026-09-08 · Target: Codex · Prompt language: English

## How to use

1. After phase 1 is complete, open a new Codex task with `C:\Users\smota\Documents\documentacao-centralizador-financeiro` and `C:\Users\smota\Documents\backend-centralizador-financeiro` available as workspace roots.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer specialized in NestJS, Clean/Hexagonal Architecture, Prisma, and PostgreSQL.

Context

Project: Centralizador Financeiro Inteligente, an academic financial-management MVP.

Work with:
- `C:\Users\smota\Documents\documentacao-centralizador-financeiro`
- `C:\Users\smota\Documents\backend-centralizador-financeiro`

This is phase 2 of the Dev 1 Sprint 1 work. S1-01 must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read `visao.html`, `prd.html`, `arquitetura.html`, and `Plano_Divisao_Atividades_Sprint_1.html`.
3. Inspect the minimum relevant backend files and verify the S1-01 prerequisite from repository evidence.
4. Stop and report the missing prerequisite if S1-01 is not complete enough to proceed safely.
5. Detect the existing structure, package manager, commands, conventions, and patterns.
6. Treat the documented active technology stack as authoritative.

Task

Complete only the Dev 1 contributions to S1-02 and S1-03.

For S1-02, configure or complete:

- The NestJS service foundation.
- Prisma integration.
- Neon/PostgreSQL connectivity using safe environment configuration.
- The migration workflow.
- The approved container setup.
- Safe environment-variable examples without real credentials.
- The initial REST API structure under `/api/v1`.
- Reproducible local execution instructions where Dev 1 changes affect them.

For S1-03, model:

- `users`;
- `tenants`;
- `identity_links`;
- `accounts`;
- the Identity and Accounts module boundaries;
- direct `tenant_id` ownership or another mandatory and verifiable ownership relationship explicitly allowed by the architecture;
- account name, type, institution, and initial-balance validation;
- Prisma migrations;
- reviewed SQL for RLS where the documented architecture requires it.

Keep domain and application code independent of NestJS, Prisma, HTTP, and database details. Put validation at the documented boundaries and follow the project’s approved validation technology.

Workflow

1. Inspect the current implementation and identify completed, missing, or conflicting work.
2. Enumerate the concrete edge cases that the phase must handle.
3. Present an implementation plan containing:
   - problem;
   - proposed solution and rationale;
   - exact affected files;
   - step-by-step changes;
   - exact schema and migration diff;
   - risks;
   - validation and test commands;
   - the exact code or diff to be applied.
4. Do not change files, dependencies, schemas, migrations, configuration, or tests until the user replies exactly:
   `planejamento aprovado, pode implementar`
5. After approval, implement only the approved diff.
6. Run relevant lint, type-check, build, migration-validation, and test commands discovered from the repository.
7. Iterate only within the authorized scope.

Constraints

- Do not implement authentication flows or account CRUD endpoints scheduled for later phases.
- Do not implement Dev 2 or Dev 3 assignments.
- Reuse existing code, patterns, utilities, and dependencies.
- A documented but missing dependency may be proposed and installed only after it appears in the approved plan.
- Never place credentials in code, configuration examples, logs, build artifacts, or commits.
- Do not connect to, migrate, reset, or modify a shared or remote database without separate explicit authorization.
- Do not invent undocumented fields, account types, numeric semantics, RLS policies, or ownership rules. If documentation is insufficient, stop and identify the exact gap.
- Preserve unrelated work in a dirty worktree.
- Do not use destructive shortcuts or hardcode behavior for tests.

Output

Propose exact paths during planning. Expected categories include backend bootstrap/configuration, domain and application modules, Prisma schema and migrations, adapters, safe configuration examples, and directly affected documentation. Use the existing repository layout rather than creating a new structure.

Acceptance criteria

- Another team member can execute the affected Sprint components locally using versioned instructions and no exposed secret.
- NestJS, Prisma, PostgreSQL, migrations, container configuration, environment handling, and `/api/v1` foundations follow the documented architecture.
- Identity and Accounts contain consistent models for users, tenants, identity links, and accounts.
- Ownership is mandatory and verifiable.
- Name, type, institution, and initial-balance validation follow documented rules.
- Migrations and required RLS SQL are consistent and reproducible in an authorized local or test environment.
- Relevant discovered checks pass.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the “paste the prompt” step come from the skill's file template | template |
| Role | Senior backend engineer for NestJS, Clean/Hexagonal Architecture, Prisma, and PostgreSQL | template + user-stated stack |
| Task definition | Dev 1 contributions to S1-02 and S1-03 | user-stated through referenced Sprint plan |
| Stack and language | Read and follow the active stack in project documentation | user-stated |
| Pattern reference | Inspect and follow current repository patterns | approved default |
| Dependency policy | Documented dependencies may be proposed and installed after approval | approved default |
| Edge cases | Session enumerates them; secrets, missing prerequisites, and unsafe databases are explicit | approved default + template |
| Acceptance criteria | Sprint criteria plus discovered executable checks | user-stated + approved default |
| Output form | Session proposes paths from the current layout | approved default |
| New task | Run after phase 1 in a separate Codex task | user-stated |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template + user-stated |
| Minimal scope, anti-hardcoding, and safety | Standard development protections | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
