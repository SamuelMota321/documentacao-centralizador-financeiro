# Prompt: Dev 2 Sprint 1 — Phase 4 Account Maintenance and Client Isolation

- Scenario: development
- Created: 2026-09-10 · Target: Codex · Prompt language: English

## How to use

1. After phases 1 through 3 are complete, open a new Codex task with the docs repository and the web and mobile client repositories available as workspace roots. Confirm the actual clone paths first; this prompt assumes `/home/miguel/web-centralizador-financeiro` and `/home/miguel/mobile-centralizador-financeiro`.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer specialized in Next.js and React Native/Expo, destructive-action UX, and session and interface state isolation.

Context

Project: Centralizador Financeiro Inteligente.

Work with:
- `/home/miguel/documentacao-centralizador-financeiro`
- the web client repository (Next.js)
- the mobile client repository (React Native/Expo)

This is phase 4. The Dev 2 portions of S1-01 through S1-05 must already be complete.

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative vision, PRD, architecture, and Sprint 1 documents.
3. Verify the preceding phases from repository evidence.
4. Inspect the minimum relevant account screens, forms, state management, session handling, typed-client, and error-handling code in each client.
5. Follow the project's active documented stack and current repository patterns.
6. Treat account update and deactivation/deletion semantics, and access-denied response behavior, as defined by the OpenAPI contract and the documentation; do not choose between soft deactivation and hard deletion without documentary authority.

Task

Complete only the Dev 2 contributions to S1-06 and S1-07, implemented independently in each client.

For S1-06:

- Implement the edit-account flow against the `/api/v1` endpoints defined by the contract, with presentation-edge validation of `name`, `type`, `institution`, and initial balance as documented.
- Implement the deactivate-or-delete action exactly as defined by the contract, with an explicit confirmation step for the destructive action.
- Update the interface state only after the API response confirms the change, and handle loading, success, and error states.
- Surface server validation and authorization errors without exposing sensitive detail.

For S1-07:

- Prevent data and state from mixing between sessions and users in each client: clear cached account data, queries, and stores on logout and on user switch.
- Handle access-denied and not-found responses from the backend uniformly, without revealing whether another tenant's resource exists.
- Ensure that no account data persists in client storage, caches, or logs after logout.
- Treat all tenant scoping as backend-enforced; client behavior is presentation only and never a security boundary.

Do not implement backend authorization, ownership checks, RLS, audit trails, or persistence; those belong to Dev 1. Do not expand into Dev 3's full validation and cross-tenant test assignment.

Workflow

1. Verify prerequisite behavior and identify every account read, mutation, and cached-state path in each client.
2. Enumerate edge cases: destructive-action cancel and confirm, stale state after error, logout mid-operation, user switch, access-denied and not-found responses.
3. Present a plan per repository with the problem, solution, rationale, affected files, exact diff, risks, contract dependencies, and validation commands.
4. Wait for:
   `planejamento aprovado, pode implementar`
5. Implement only the approved changes, keeping web and mobile changes separate.
6. Run relevant lint, type-check, test, and build checks for each repository, plus a manual or scripted check of edit, deactivate/delete, logout, and access-denied handling.
7. Iterate only within the approved scope.

Constraints

- Do not infer deactivation-versus-deletion semantics, confirmation copy requirements, or access-denied response behavior; take them from the contract and documentation, and stop and report if unresolved.
- Do not optimistically mutate interface state before the API confirms a destructive change.
- Do not leave account data in client storage, caches, or logs after logout.
- Reuse approved dependencies and existing patterns; do not introduce an undecided library.
- Do not share components, navigation, or source code between the two clients.
- Preserve architectural boundaries and unrelated changes.
- Do not hardcode tenant identifiers, account IDs, users, or test-specific bypasses.
- Never expose secrets, tokens, or financial data in code, responses, errors, logs, or bundles.

Output

Use each existing client layout. During planning, identify exact paths for the edit flow, the destructive-action confirmation, state and cache invalidation on logout and user switch, uniform error handling, and focused tests. Do not create new architectural layers unless the documentation and approved plan require them.

Acceptance criteria

- A user can edit and deactivate/delete their own accounts on both clients, with confirmation for the destructive action and state updated only after the API response.
- Server validation and authorization errors are surfaced without sensitive disclosure.
- No account data or session state carries over between users or survives logout in client storage, caches, or logs.
- Access-denied and not-found responses are handled uniformly and do not reveal another tenant's resource existence.
- Relevant discovered lint, type-check, test, and build checks pass for each repository.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Role | Senior frontend engineer for Next.js, React Native/Expo, destructive-action UX, and session/state isolation | template + documented stack |
| Task definition | Dev 2 contributions to S1-06 and S1-07 | documented Sprint plan |
| Repository paths | Docs repo plus web and mobile client repos; concrete clone paths to be confirmed | approved default (assumed by naming convention) |
| Stack and language | Next.js, React Native/Expo, REST `/api/v1`, Zod; lifecycle and error semantics from the contract and documentation | documented architecture |
| Pattern reference | Discover edit, confirmation, and state-management patterns in each client | approved default |
| Dependency policy | Active documented stack only; no undecided library | documented architecture |
| Edge cases | Destructive-action cancel/confirm, stale state, logout mid-operation, user switch, access-denied and not-found | documented Sprint plan + approved default |
| Acceptance criteria | Edit and deactivate/delete flows, confirmation, and client isolation | documented Sprint plan |
| Output form | Propose paths from each existing layout | approved default |
| New task | Run after phases 1 through 3 in a separate Codex task | template |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template |
| Safety | No optimistic destructive mutations, residual data after logout, shared source, or test bypasses | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
