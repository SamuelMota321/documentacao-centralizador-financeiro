# Prompt: Dev 2 Sprint 1 — Phase 2 Client Foundation and Contract Alignment

- Scenario: development
- Created: 2026-09-10 · Target: Codex · Prompt language: English

## How to use

1. After phase 1 is complete, open a new Codex task with the docs repository and the web and mobile client repositories available as workspace roots. Confirm the actual clone paths first; this prompt assumes `/home/miguel/web-centralizador-financeiro` and `/home/miguel/mobile-centralizador-financeiro`.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer specialized in Next.js, React Native/Expo, TypeScript project setup, and consuming typed clients generated from an OpenAPI contract.

Context

Project: Centralizador Financeiro Inteligente, an academic financial-management MVP.

Work with:
- `/home/miguel/documentacao-centralizador-financeiro`
- the web client repository (Next.js)
- the mobile client repository (React Native/Expo)

This is phase 2 of the Dev 2 Sprint 1 work. The Dev 2 portion of S1-01 must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read `visao.html`, `prd.html`, `arquitetura.html`, and `Plano_Divisao_Atividades_Sprint_1.html`.
3. Inspect the minimum relevant web and mobile files and verify the S1-01 prerequisite from repository evidence.
4. Stop and report the missing prerequisite if S1-01 is not complete enough to proceed safely.
5. Detect the existing structure, package manager, scripts, conventions, and patterns in each client repository.
6. Locate the backend-owned OpenAPI contract (versioned file or a running `/api/v1` service) and treat it as the single source of the client field shapes.
7. Treat the documented active technology stack as authoritative.

Task

Complete only the Dev 2 contributions to S1-02 and S1-03.

For S1-02, prepare each client independently:

- The Next.js web application foundation, ready for Auth0 authentication and contract consumption.
- The React Native/Expo mobile application foundation, ready for Auth0 authentication and contract consumption.
- Safe environment configuration for each client (API base URL, Auth0 domain/client identifiers) with example files and no real credentials.
- The typed-client setup that consumes the backend OpenAPI contract, choosing a generator only if the approved plan authorizes it; otherwise propose options and stop.
- Reproducible local execution instructions for each client where Dev 2 changes affect them.

For S1-03, align the client data layer to the contract:

- Map the `users`, `tenants`, `accounts`, and account-related fields exposed by the contract into each client's typed models, without sharing schema-source between repositories.
- Represent account `name`, `type`, `institution`, and `initial balance` fields as defined by the contract.
- Place Zod validation on the presentation edges of each client, mirroring the documented validation rules, without turning Zod schemas into shared domain entities or a shared package.

Do not implement authentication flows, session handling, or account screens scheduled for later phases. Build only the foundation and the contract-aligned typed data layer.

Workflow

1. Inspect the current state of each client and identify completed, missing, or conflicting work.
2. Enumerate the concrete edge cases this phase must handle (missing contract, contract drift, environment gaps).
3. Present an implementation plan per repository containing:
   - problem;
   - proposed solution and rationale;
   - exact affected files;
   - step-by-step changes;
   - the typed-client generation approach and its exact commands;
   - risks;
   - validation and test commands;
   - the exact code or diff to be applied.
4. Do not change files, dependencies, configuration, or scripts until the user replies exactly:
   `planejamento aprovado, pode implementar`
5. After approval, implement only the approved diff, keeping the web and mobile changes separate.
6. Run relevant lint, type-check, build, and client-generation commands discovered from each repository.
7. Iterate only within the authorized scope.

Constraints

- Do not implement login, session, protected areas, or account CRUD screens scheduled for later phases.
- Do not implement Dev 1 or Dev 3 assignments.
- Do not share components, navigation, source code, or schema-source packages between the two clients.
- Reuse existing code, patterns, utilities, and dependencies in each repository.
- A documented but missing dependency may be proposed and installed only after it appears in the approved plan.
- Never place credentials in code, configuration examples, logs, build artifacts, or commits.
- Do not modify the backend or the OpenAPI contract; if the contract is missing or inconsistent, stop and report the exact gap.
- Do not invent contract fields, account types, or numeric semantics not present in the OpenAPI contract or the documentation.
- Preserve unrelated work in a dirty worktree.
- Do not use destructive shortcuts or hardcode behavior for tests.

Output

Propose exact paths during planning. Expected categories include app bootstrap and configuration, the generated/typed API client and its wrapper, environment example files, presentation-edge Zod schemas, and directly affected client documentation. Use each repository's existing layout rather than creating a new structure.

Acceptance criteria

- Another team member can install and run each client locally using versioned instructions and no exposed secret.
- Each client has a typed API layer generated from or aligned to the backend OpenAPI contract, with no shared schema-source between repositories.
- Account `name`, `type`, `institution`, and `initial balance` field shapes and edge validation match the documented rules and the contract.
- Web and mobile remain fully independent.
- Relevant discovered lint, type-check, and build checks pass.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Role | Senior frontend engineer for Next.js, React Native/Expo, TypeScript setup, and OpenAPI typed clients | template + documented stack |
| Task definition | Dev 2 contributions to S1-02 and S1-03 | documented Sprint plan |
| Repository paths | Docs repo plus web and mobile client repos; concrete clone paths to be confirmed | approved default (assumed by naming convention) |
| Contract source | Backend-owned OpenAPI contract, discovered from the repository or a running `/api/v1` | documented architecture |
| Stack and language | Read and follow the active stack in project documentation | documented architecture |
| Pattern reference | Inspect and follow current repository patterns | approved default |
| Dependency policy | Documented dependencies may be proposed and installed after approval; generator library not yet approved | documented architecture + approved default |
| Edge cases | Session enumerates them; missing contract, contract drift, and secrets are explicit | approved default + template |
| Acceptance criteria | Sprint criteria plus discovered executable checks | documented Sprint plan + approved default |
| Output form | Session proposes paths from each current layout | approved default |
| New task | Run after phase 1 in a separate Codex task | template |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template |
| Minimal scope, anti-hardcoding, and safety | Standard development protections | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
