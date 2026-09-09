# Prompt: Dev 1 Sprint 1 — Phase 5 Testing and Consolidation

- Scenario: development
- Created: 2026-09-08 · Target: Codex · Prompt language: English

## How to use

1. After phases 1 through 4 are complete, open a new Codex task with `C:\Users\smota\Documents\documentacao-centralizador-financeiro` and `C:\Users\smota\Documents\backend-centralizador-financeiro` available as workspace roots.
2. Use Plan mode to review the proposed implementation plan before authorizing changes.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for verification and technical consolidation of a NestJS, Prisma, and PostgreSQL service.

Context

Project: Centralizador Financeiro Inteligente.

Work with:
- `C:\Users\smota\Documents\documentacao-centralizador-financeiro`
- `C:\Users\smota\Documents\backend-centralizador-financeiro`

This is phase 5. All preceding Dev 1 Sprint 1 phases must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative vision, PRD, architecture, and Sprint 1 documents.
3. Inspect repository evidence for S1-01 through S1-07.
4. Discover the existing package manager, test commands, CI-relevant checks, test patterns, environment requirements, and approved libraries.
5. Inspect only files required to assess and close Dev 1’s S1-08 and S1-09 responsibilities.

Task

Complete only the Dev 1 contributions to S1-08 and S1-09.

For S1-08, ensure focused backend coverage for:

- Domain rules and application use cases using Vitest as documented.
- Prisma/PostgreSQL integration.
- Critical REST behavior using Supertest as documented.
- Authentication and protected-endpoint behavior relevant to Dev 1.
- Account creation, listing, updating, and deactivation/deletion.
- Tenant ownership and application-level authorization.
- PostgreSQL RLS and explicit cross-tenant cases.
- Relevant OpenAPI behavior.

For S1-09:

- Validate the NestJS service.
- Validate migrations and approved local/test PostgreSQL execution.
- Validate REST `/api/v1` behavior and OpenAPI consistency.
- Validate Auth0/JWT backend integration without real credentials.
- Validate authorization and RLS.
- Run the relevant backend lint, type-check, tests, and build.
- Update only directly affected configuration, contract, execution instructions, and Dev 1 evidence.
- Produce a concise technical handoff identifying completed checks, failures, environmental limitations, and remaining dependencies on Dev 2 or Dev 3.

Do not implement web/mobile tests, client flows, pipeline ownership, the complete Sprint demonstration, or Dev 3’s consolidation work.

Workflow

1. Build a traceability matrix from each Dev 1 responsibility in S1-01 through S1-09 to repository evidence and executable checks.
2. Distinguish:
   - implemented and verified;
   - implemented but unverified;
   - missing;
   - blocked by another developer or unavailable environment.
3. Enumerate missing critical cases and propose the smallest test or production changes required.
4. Present a plan with the problem, solution, rationale, exact affected files, exact code or diff, risks, commands, environment requirements, and expected evidence.
5. Wait for:
   `planejamento aprovado, pode implementar`
6. Implement only the approved changes.
7. Execute relevant checks and report actual results. Never claim that an unavailable integration passed.
8. Fix production defects within the approved scope. Do not change valid tests merely to make the suite green.
9. Stop when the Dev 1 acceptance criteria are met or when further work requires new authority, an external dependency, or a revised plan.

Constraints

- Reuse current test utilities, fixtures, factories, containers, and dependencies.
- A documented but missing test dependency may be proposed and installed only after approval.
- Use fictitious data only.
- Do not include real Auth0 credentials, database credentials, tokens, or financial data.
- Do not bypass authentication, tenancy, authorization, RLS, migrations, or integration behavior in order to pass tests.
- Do not perform destructive database operations outside an isolated authorized test environment.
- Preserve unrelated user changes.
- If evidence is insufficient, report that limitation instead of inferring success.
- Keep changes limited to Dev 1 responsibilities and directly affected documentation.

Output

During planning, propose exact paths for focused tests, test support, required production fixes, OpenAPI/configuration updates, execution documentation, and Dev 1 evidence. After execution, report only changed files, commands and results, remaining failures, environmental limitations, and risks.

Acceptance criteria

- Reproducible backend coverage exists for domain/use-case behavior, Prisma/PostgreSQL integration, critical REST behavior, authentication, account lifecycle, tenant isolation, and RLS.
- Cross-tenant access is denied for reads and mutations.
- NestJS service, migrations, PostgreSQL integration, REST API, authorization, and RLS have explicit evidence.
- Relevant lint, type-check, test, and build commands pass, or genuine external blockers are reported with evidence.
- OpenAPI, configuration, and directly affected instructions are current.
- No secrets or real financial data appear in source, fixtures, configuration examples, artifacts, or logs.
- The technical handoff clearly separates Dev 1 completion from remaining Dev 2 and Dev 3 work.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the “paste the prompt” step come from the skill's file template | template |
| Role | Senior backend engineer for verification and technical consolidation of NestJS, Prisma, and PostgreSQL | template + user-stated stack |
| Task definition | Dev 1 contributions to S1-08 and S1-09 | user-stated through referenced Sprint plan |
| Stack and language | Vitest, Supertest, NestJS, Prisma/PostgreSQL, REST/OpenAPI, and RLS; details come from project documentation | user-stated |
| Pattern reference | Discover current test and verification patterns | approved default |
| Dependency policy | Existing or documented libraries; approval before installation | approved default |
| Edge cases | Missing evidence, unavailable environments, authentication, account lifecycle, and cross-tenant behavior | user-stated through Sprint plan + approved default |
| Acceptance criteria | Reproducible backend suite and technical integration evidence | user-stated + approved default |
| Output form | Propose paths from repository conventions | approved default |
| New task | Run after phases 1 through 4 in a separate Codex task | user-stated |
| Plan mode and checkpoint | Review the plan before authorizing the final phase | template + user-stated |
| Epistemics and safety | Report unavailable evidence; no bypasses or destructive database actions | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
