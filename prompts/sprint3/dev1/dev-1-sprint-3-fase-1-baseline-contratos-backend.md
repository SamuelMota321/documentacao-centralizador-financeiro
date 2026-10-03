# Prompt: Dev 1 Sprint 3 — Phase 1 Backend Baseline and Contracts

- Scenario: development
- Created: 2026-09-28 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories listed below as workspace roots.
2. Use Plan mode and review the proposed plan before authorizing changes.
3. Run this phase before the other Dev 1 Sprint 3 implementation phases.
4. Before editing, provide the plan and wait for the exact authorization: `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer responsible for API contracts, architecture boundaries, and technical traceability.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 3 Phase 1. Verify the current repository state and Sprint 1/Sprint 2 prerequisites; do not rely solely on historical status recorded in planning documents.

Read and follow every applicable AGENTS.md, including the Sprint 3 plan, PRD, Architecture, PostgreSQL RLS ADR, current backend OpenAPI, and existing backend module patterns.

## Task

Complete only Dev 1’s backend-contract contribution to S3-01. S3-01 is led by Developer 3, and this prompt does not authorize claiming the entire activity complete.

Create a traceable backend baseline for:

- HU-004 OFX preview, confirmation, import status, and result.
- HU-007 Pluggy connection and the initial import required by that story.
- The backend-owned API and persistence boundaries between Accounts, Ingestion, and Transactions.
- Authentication, tenant ownership, authorization, idempotency, RLS, and audit implications.

For each decision, identify its authoritative source. Explicitly list unresolved decisions, impact, owner to confirm, and whether they block implementation. Do not silently choose OFX variants or encodings, size limits, destination-account rules, duplicate identity, re-import behavior, async threshold, ImportRun/file retention, Pluggy data scope, consent fields, or local-data deletion policy.

Propose API contracts for review, but fix names and formats only when approved. If a required product or architecture decision is missing, present concrete options and tradeoffs, then stop the dependent work until an authorized decision is recorded.

## Workflow

1. Inspect the minimum relevant documentation and backend implementation; verify paths and patterns still exist.
2. Build a traceability matrix from HU-004, HU-007, RN-006 through RN-009, RNF-002, RNF-004, and RNF-008 to the proposed backend contract.
3. Identify contradictions, unsupported assumptions, dependencies, and decisions that block S3-02 or S3-05.
4. Present the exact plan, proposed contract changes, files, risks, validation commands, and any dependency request.
5. Wait for `planejamento aprovado, pode implementar` before changing files.
6. Implement only approved backend contract and documentation changes. Keep unresolved decisions explicitly unresolved.
7. Report the Dev 1 slice separately from Developer 2 and Developer 3 responsibilities.

## Constraints

- Limit implementation to the backend contract and directly related technical documentation.
- Do not modify web or mobile source code.
- Do not implement OFX processing or Pluggy integration in this phase.
- Do not include HU-008 recurring synchronization or HU-009 investments.
- Preserve the Clean/Hexagonal boundaries and module ownership documented in Architecture.
- Do not invent routes, payload fields, states, status codes, duplicate rules, retention rules, or consent semantics.
- New dependencies require an explicit proposal and approval before installation.
- Preserve unrelated changes and use synthetic data only.

## Output

Provide the traceability matrix, approved contract changes, unresolved-decision register, changed-file list, validation results, and handoffs or blockers. Suggest a commit message; do not create a commit unless separately authorized.

## Acceptance criteria

- Every proposed backend decision has a source or is clearly marked unresolved.
- OpenAPI is changed only for decisions that have been approved.
- Contract behavior supports independent web and mobile clients without modifying either client.
- HU-008 and HU-009 remain outside scope.
- Run the current OpenAPI generation/check and `git diff --check` when available; discover current scripts before using them.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior backend engineer | template |
| Target environment | Codex | user-stated |
| Task and phase split | Five prompts; this phase covers Dev 1’s S3-01 backend-contract slice | user-stated |
| Sprint scope and ownership | S3-01 Dev 3 lead; Dev 1 defines backend contracts; HU-004 and HU-007 scope | approved default — Sprint 3 plan and PRD |
| Repository context | Documentation and backend roots; verify current state | user-stated paths and approved default |
| Stack and patterns | NestJS, TypeScript, Prisma, PostgreSQL, OpenAPI; follow current backend patterns | approved default — Architecture and backend repository |
| Open decisions | OFX and Pluggy uncertainties listed in the prompt | approved default — Sprint 3 plan |
| Dependency policy | Propose and obtain approval before adding a dependency | approved default — Sprint 3 plan and repository instructions |
| Acceptance and checks | Traceability, approved OpenAPI changes, OpenAPI check, `git diff --check` | approved default — project validation conventions |
| Authorization gate | Exact project phrase before edits | user-provided AGENTS.md |
