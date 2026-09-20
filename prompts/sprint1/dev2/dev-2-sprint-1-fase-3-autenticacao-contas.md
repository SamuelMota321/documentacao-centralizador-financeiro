# Prompt: Dev 2 Sprint 1 — Phase 3 Authentication and Account Screens

- Scenario: development
- Created: 2026-09-10 · Target: Codex · Prompt language: English

## How to use

1. After phases 1 and 2 are complete, open a new Codex task with the docs repository and the web and mobile client repositories available as workspace roots. Confirm the actual clone paths first; this prompt assumes `/home/miguel/web-centralizador-financeiro` and `/home/miguel/mobile-centralizador-financeiro`.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer specialized in Next.js and React Native/Expo, Auth0 OAuth 2.0/OIDC integration on each platform, and interface state management.

Context

Project: Centralizador Financeiro Inteligente.

Work with:
- `/home/miguel/documentacao-centralizador-financeiro`
- the web client repository (Next.js)
- the mobile client repository (React Native/Expo)

This is phase 3. The Dev 2 portions of S1-01 through S1-03 must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative vision, PRD, architecture, and Sprint 1 documents.
3. Verify prerequisite completion from repository evidence.
4. Inspect only the directly relevant authentication, session, routing/navigation, typed-client, and account-screen files in each client.
5. Follow existing patterns and only the active documented technology stack.
6. Coordinate with the backend Dev 1 contract: JWT validation, protected `/api/v1` endpoints, and identity/tenant association are backend responsibilities; the clients obtain and attach tokens and consume the contract.

Task

Complete only the Dev 2 contributions to S1-04 and S1-05, implemented independently in each client.

For S1-04:

- Implement Auth0 login through OAuth 2.0 / OpenID Connect for each platform (web redirect flow on Next.js; the platform-appropriate flow on Expo).
- Establish and store the session and the access token securely per platform, and attach the token to backend requests.
- Implement protected routes (web) and protected areas (mobile), with redirects for unauthenticated access.
- Implement logout, clearing session and token, and returning the user to a public area.
- Ensure that missing, expired, or rejected tokens result in no access to protected areas and a safe re-authentication path.
- Do not expose tokens, secrets, or identity details in logs, URLs, storage accessible to other origins, or error messages.

For S1-05:

- Implement the create-account and list-accounts flows in each client against the `/api/v1` endpoints defined by the OpenAPI contract.
- Validate account `name`, `type`, `institution`, and `initial balance` on the presentation edge with Zod, mirroring the documented rules, and surface server validation errors.
- Handle loading, empty, success, and error states for both flows.
- Display only the accounts returned for the authenticated user; do not implement client-side tenant filtering as a substitute for backend scoping.
- Reflect the documented handling of possible duplication between manual and connected accounts as surfaced by the contract.

Do not implement backend JWT validation, identity/tenant provisioning, persistence, or endpoint logic; those belong to Dev 1. Do not take over Dev 3's test-consolidation responsibility.

Workflow

1. Inspect current behavior in each client and verify prerequisites.
2. Enumerate edge cases and proposed acceptance checks (unauthenticated access, expired token mid-session, network failure, empty list, validation failure).
3. Present a plan per repository with the problem, solution, rationale, exact affected files, exact code or diff, risks, contract dependencies, and validation commands.
4. Wait for the exact reply:
   `planejamento aprovado, pode implementar`
5. Implement only the approved scope, keeping web and mobile changes separate.
6. Run the relevant discovered tests, type checks, lint, and build for each repository, plus a manual or scripted check of the auth and account flows against a real or mocked backend.
7. Fix failures only within the approved scope.

Constraints

- Do not invent Auth0 domains, client IDs, audiences, callback URLs, endpoints, status codes, or account fields; take them from documentation, safe configuration, or the OpenAPI contract.
- If any required behavior is absent or contradictory in the authoritative documentation or the contract, identify the exact gap and stop before implementing it.
- Reuse approved dependencies and patterns in each repository. Propose any documented but missing dependency before installation, and do not introduce an undecided library.
- Never expose secrets, tokens, or financial data in code, examples, responses, errors, logs, bundles, or URLs.
- Do not share components, navigation, or source code between the two clients.
- Rely on backend tenant scoping; client filtering is presentation only, never a security boundary.
- Preserve architectural boundaries and unrelated user changes.
- Do not change tests merely to hide a defect.

Output

Use each existing client layout. During planning, list the exact paths for the Auth0 integration, session/token storage, route/area guards, redirect and logout handling, the account create and list screens, presentation-edge validation, and focused tests. Update client documentation only when directly affected.

Acceptance criteria

- A user can log in with Auth0, reach only their own protected area, and log out on both clients.
- Missing or expired tokens cannot access protected areas and lead to a safe re-authentication path.
- A user can create an account and see only their own accounts through `/api/v1` on both clients.
- Account input follows documented validation and duplicate-handling rules, with loading, empty, success, and error states handled.
- No tokens, secrets, or financial data appear in code, logs, URLs, bundles, or error messages.
- Relevant discovered lint, type-check, test, and build checks pass for each repository.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Role | Senior frontend engineer for Next.js, React Native/Expo, Auth0 OAuth 2.0/OIDC per platform, and interface state | template + documented stack |
| Task definition | Dev 2 contributions to S1-04 and S1-05 | documented Sprint plan |
| Repository paths | Docs repo plus web and mobile client repos; concrete clone paths to be confirmed | approved default (assumed by naming convention) |
| Stack and language | Auth0, OAuth 2.0/OIDC, JWT, Next.js, React Native/Expo, REST `/api/v1`, Zod; details from project documentation and the contract | documented architecture |
| Pattern reference | Existing auth, navigation, typed-client, and screen patterns in each client | approved default |
| Dependency policy | Active documented stack only; plan approval before installation; no undecided library | documented architecture + approved default |
| Edge cases | Token failures, unauthenticated access, network errors, empty and invalid states, duplicates | documented Sprint plan + approved default |
| Acceptance criteria | Login/logout, protected access, and create/list behavior on both clients plus discovered checks | documented Sprint plan + approved default |
| Output form | Discover and propose exact paths during planning | approved default |
| New task | Run after phases 1 and 2 in a separate Codex task | template |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template |
| Safety clauses | Scope, secrets, dirty-worktree, and no-shared-source protections | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
