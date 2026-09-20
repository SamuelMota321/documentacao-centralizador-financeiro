# Prompt: Dev 1 Sprint 1 — Phase 3 Authentication and Accounts

- Scenario: development
- Created: 2026-09-08 · Target: Codex · Prompt language: English

## How to use

1. After phases 1 and 2 are complete, open a new Codex task with `C:\Users\smota\Documents\documentacao-centralizador-financeiro` and `C:\Users\smota\Documents\backend-centralizador-financeiro` available as workspace roots.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer specialized in NestJS authentication, OAuth 2.0/OIDC integration, REST APIs, and tenant-aware persistence.

Context

Project: Centralizador Financeiro Inteligente.

Work with:
- `C:\Users\smota\Documents\documentacao-centralizador-financeiro`
- `C:\Users\smota\Documents\backend-centralizador-financeiro`

This is phase 3. The Dev 1 portions of S1-01 through S1-03 must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative vision, PRD, architecture, and Sprint 1 documents.
3. Verify prerequisite completion from repository evidence.
4. Inspect only the directly relevant Identity, Accounts, authentication, persistence, REST, OpenAPI, and test files.
5. Follow existing patterns and only the active documented technology stack.

Task

Complete only the Dev 1 contributions to S1-04 and S1-05.

For S1-04:

- Validate Auth0-issued JWTs in NestJS using the documented OAuth 2.0/OIDC architecture.
- Associate the external Auth0 identity with the correct local user and tenant through the Identity module.
- Protect the relevant endpoints.
- Ensure missing, malformed, invalid, expired, or otherwise rejected tokens do not grant access.
- Handle an authenticated external identity that has no valid local user/tenant association according to documented behavior.
- Avoid exposing token details, secrets, tenant existence, or sensitive identity information.

For S1-05:

- Implement the documented REST endpoints under `/api/v1` for creating and listing manual financial accounts.
- Implement the domain/application rules, persistence, and tenant-scoped queries.
- Validate account name, type, institution, and initial balance according to authoritative documentation.
- Address possible duplication between manual and connected accounts exactly as documented.
- Keep the OpenAPI contract consistent with implemented behavior.
- Ensure an authenticated user can create and list only accounts belonging to their own tenant.

Do not implement web or mobile authentication/session flows, interfaces, or client state. Those belong to Dev 2. Do not take over Dev 3’s test-consolidation responsibility.

Workflow

1. Inspect current behavior and verify prerequisites.
2. Enumerate edge cases and proposed acceptance tests.
3. Present a plan with the problem, solution, rationale, exact affected files, exact code or diff, risks, contract effects, migration effects if any, and validation commands.
4. Wait for the exact reply:
   `planejamento aprovado, pode implementar`
5. Implement only the approved scope.
6. Run the relevant discovered tests, type checks, lint, build, OpenAPI checks, and safe integration checks.
7. Fix failures only within the approved scope.

Constraints

- Do not invent Auth0 claims, audiences, issuers, identity-provisioning behavior, duplicate-account rules, endpoints, status codes, or account fields.
- If any required behavior is absent or contradictory in the authoritative documentation, identify the exact gap and stop before implementing it.
- Reuse approved dependencies and patterns. Propose any documented but missing dependency before installation.
- Never expose secrets or financial data in code, examples, responses, errors, or logs.
- Enforce tenant ownership in application queries even if later database RLS will provide defense in depth.
- Preserve architectural boundaries and unrelated user changes.
- Do not change tests merely to hide a production defect.
- Do not run destructive migrations or affect a remote/shared environment without separate confirmation.

Output

Use the existing backend layout. During planning, list the exact paths for Identity, authentication adapters/guards, Accounts domain and use cases, REST controllers and DTO validation, persistence adapters, OpenAPI updates, and focused tests. Update documentation only when directly affected.

Acceptance criteria

- Valid authenticated identities resolve to the correct user and tenant.
- Missing, invalid, and expired tokens cannot access protected endpoints.
- Authenticated users can create and list manual accounts through `/api/v1`.
- Account input follows documented validation and duplicate-handling rules.
- Queries return only the authenticated tenant’s accounts.
- OpenAPI matches observable endpoint behavior.
- Relevant discovered checks pass without exposed secrets.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the “paste the prompt” step come from the skill's file template | template |
| Role | Senior backend engineer for NestJS authentication, OAuth 2.0/OIDC, REST, and tenant-aware persistence | template + user-stated stack |
| Task definition | Dev 1 contributions to S1-04 and S1-05 | user-stated through referenced Sprint plan |
| Stack and language | Auth0, OAuth 2.0/OIDC, JWT, NestJS, REST, OpenAPI, and Prisma/PostgreSQL; details come from project documentation | user-stated |
| Pattern reference | Existing Identity, Accounts, API, and test patterns | approved default |
| Dependency policy | Active documented stack only; plan approval before installation | user-stated + approved default |
| Edge cases | Token failures, missing identity mapping, tenancy, and duplicates | user-stated through Sprint plan + approved default |
| Acceptance criteria | Authentication and create/list behavior plus discovered checks | user-stated + approved default |
| Output form | Discover and propose exact paths during planning | approved default |
| New task | Run after phases 1 and 2 in a separate Codex task | user-stated |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template + user-stated |
| Safety clauses | Scope, secrets, dirty-worktree, and destructive-operation protections | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
