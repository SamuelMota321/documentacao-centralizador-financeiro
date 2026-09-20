# Prompt: Dev 2 Sprint 1 — Phase 5 Client Testing and Integration

- Scenario: development
- Created: 2026-09-10 · Target: Codex · Prompt language: English

## How to use

1. After phases 1 through 4 are complete, open a new Codex task with the docs repository and the web and mobile client repositories available as workspace roots. Confirm the actual clone paths first; this prompt assumes `/home/miguel/web-centralizador-financeiro` and `/home/miguel/mobile-centralizador-financeiro`.
2. Use Plan mode to review the proposed implementation plan before authorizing changes.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer responsible for the client-side verification and integration of the Next.js and React Native/Expo applications.

Context

Project: Centralizador Financeiro Inteligente.

Work with:
- `/home/miguel/documentacao-centralizador-financeiro`
- the web client repository (Next.js)
- the mobile client repository (React Native/Expo)

This is phase 5. All preceding Dev 2 Sprint 1 phases must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative vision, PRD, architecture, and Sprint 1 documents.
3. Inspect repository evidence for the Dev 2 portions of S1-01 through S1-07.
4. Discover, in each client repository, the existing package manager, test commands, already-approved test tooling and patterns, environment requirements, and CI-relevant checks.
5. Inspect only files required to assess and close Dev 2's S1-08 and S1-09 responsibilities.

Task

Complete only the Dev 2 contributions to S1-08 and S1-09.

For S1-08, ensure focused client coverage for the critical flows, using only the test approach already approved in each repository and introducing no undecided library:

- Auth0 login, protected route/area access, and logout.
- Rejection of access under missing or expired tokens.
- Account creation with presentation-edge validation, including loading, empty, success, and error states.
- Account listing showing only the authenticated user's accounts.
- Account edit and deactivate/delete, including destructive-action confirmation.
- Session and interface state isolation across logout and user switch.
- Uniform handling of access-denied and not-found responses.

For S1-09:

- Validate each client's build and local execution from versioned instructions.
- Validate each client's independent integration with the backend OpenAPI contract and its typed client.
- Validate the Auth0/OIDC flow on each platform without real credentials.
- Run the relevant lint, type-check, tests, and build for each repository and report actual results.
- Update only directly affected client configuration, execution instructions, and Dev 2 evidence.
- Contribute the web and mobile portions of the academic demonstration script.
- Produce a concise handoff identifying completed checks, failures, environmental limitations, and remaining dependencies on Dev 1 (backend, contract) and Dev 3 (pipelines, end-to-end, contract tests).

Do not implement backend tests, backend fixes, pipeline ownership, contract-test consolidation, or Dev 3's overall consolidation work.

Workflow

1. Build a traceability matrix from each Dev 2 responsibility in S1-01 through S1-09 to repository evidence and executable checks, per client.
2. Distinguish: implemented and verified; implemented but unverified; missing; blocked by another developer or an unavailable environment.
3. Enumerate missing critical cases and propose the smallest test or client-code changes required.
4. Present a plan per repository with the problem, solution, rationale, exact affected files, exact code or diff, risks, commands, environment requirements, and expected evidence.
5. Wait for:
   `planejamento aprovado, pode implementar`
6. Implement only the approved changes, keeping web and mobile changes separate.
7. Execute relevant checks and report actual results. Never claim that an unavailable integration passed.
8. Fix client defects within the approved scope. Do not change valid tests merely to make a suite green.
9. Stop when the Dev 2 acceptance criteria are met or when further work requires new authority, an external dependency, or a revised plan.

Constraints

- Reuse the current test utilities, fixtures, mocks, and dependencies in each repository; do not introduce an undecided testing library.
- A documented but missing test dependency may be proposed and installed only after approval.
- Use fictitious data only.
- Do not include real Auth0 credentials, tokens, API URLs with secrets, or financial data in tests, fixtures, or configuration examples.
- Do not bypass authentication, session isolation, or contract integration to make tests pass.
- Do not share components, navigation, source code, or test code between the two clients.
- Preserve unrelated user changes.
- If evidence is insufficient, report that limitation instead of inferring success.
- Keep changes limited to Dev 2 responsibilities and directly affected documentation.

Output

During planning, propose exact paths per repository for focused tests, test support and mocks, required client fixes, configuration and execution-instruction updates, the demonstration-script contribution, and Dev 2 evidence. After execution, report only changed files, commands and results, remaining failures, environmental limitations, and risks.

Acceptance criteria

- Reproducible client coverage exists in each repository for authentication, protected access, account create/list/edit/deactivate, state isolation, and error handling.
- Each client builds and runs from versioned instructions and integrates independently with the OpenAPI contract.
- The Auth0/OIDC flow is validated on each platform without real credentials.
- Relevant lint, type-check, test, and build commands pass, or genuine external blockers are reported with evidence.
- No secrets or real financial data appear in source, fixtures, configuration examples, bundles, or logs.
- The handoff clearly separates Dev 2 completion from remaining Dev 1 and Dev 3 work, and the demonstration script covers the web and mobile flows.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Role | Senior frontend engineer for client-side verification and integration of Next.js and React Native/Expo | template + documented stack |
| Task definition | Dev 2 contributions to S1-08 and S1-09 | documented Sprint plan |
| Repository paths | Docs repo plus web and mobile client repos; concrete clone paths to be confirmed | approved default (assumed by naming convention) |
| Stack and language | Next.js, React Native/Expo, Auth0/OIDC, REST `/api/v1` and OpenAPI typed clients; test tooling as already approved per repository | documented architecture + documented Sprint plan |
| Pattern reference | Discover current test and verification patterns in each client | approved default |
| Dependency policy | Existing or documented libraries only; approval before installation; no undecided testing library | documented Sprint plan + approved default |
| Edge cases | Missing evidence, unavailable environments, token rejection, account lifecycle, state isolation, error handling | documented Sprint plan + approved default |
| Acceptance criteria | Reproducible client suites, independent contract integration, and the demonstration-script contribution | documented Sprint plan + approved default |
| Output form | Propose paths from each repository's conventions | approved default |
| New task | Run after phases 1 through 4 in a separate Codex task | template |
| Plan mode and checkpoint | Review the plan before authorizing the final phase | template |
| Epistemics and safety | Report unavailable evidence; no bypasses; no shared source or test code between clients | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
