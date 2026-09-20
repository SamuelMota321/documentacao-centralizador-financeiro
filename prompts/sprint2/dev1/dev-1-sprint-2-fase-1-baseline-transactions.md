# Prompt: Dev 1 Sprint 2 — Phase 1 Transactions Baseline and Contracts

- Scenario: development
- Created: 2026-09-20 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with these repositories as workspace roots:
   - C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
   - C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro
2. Use Plan mode. Review the proposed plan before authorizing edits.
3. Do not start Phase 2 until this phase is complete and its baseline is approved and documented.
4. Authorize implementation only with the exact phrase: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer and technical contract owner specialized in NestJS, domain modeling, REST/OpenAPI, Prisma, and PostgreSQL.

Work with these repositories:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 2 Phase 1. Sprint 1 must already be complete.

Read and follow every applicable AGENTS.md before proposing changes.

Read at minimum:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro\Plano_Divisao_Atividades_Sprint_2.html
- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro\prd.html
- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro\arquitetura.html
- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro\visao.html
- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro\adr-rls-postgresql.html
- Relevant existing backend files, OpenAPI files, Prisma schema, migrations, tests, and Sprint 1 evidence.

Task

Complete Dev 1’s contribution to S2-01: close the baseline and contracts for the Transactions module before feature implementation.

Lead the technical definition of:

- Transaction fields, types, lifecycle, and minimum states.
- Income and expense representation.
- Accounting transfer representation, including atomicity and the two related entries.
- Category source and lifecycle.
- Category-rule conditions, supported operators, precedence, and deterministic conflict resolution.
- Idempotency key, scope, and validity window.
- REST routes, request/response shapes, pagination, status codes, and Problem Details errors.
- Minimum audit information for the new actions.
- Ownership and tenant-boundary rules.
- OpenAPI impact and compatibility requirements for independent web/mobile clients.

The current Sprint 2 documentation explicitly states that these decisions must be closed before S2-02 through S2-06 and that the plan does not presume all details. Do not silently invent unspecified business rules.

Workflow

1. Inspect the minimum relevant repository and documentation context.
2. Build a traceability matrix showing the source of every proposed decision.
3. Identify contradictions, missing decisions, and decisions that require explicit product or architecture approval.
4. Present an implementation plan containing:
   - problem;
   - proposed baseline;
   - rationale;
   - exact affected documentation and backend files;
   - exact contract or code changes;
   - unresolved decisions;
   - risks;
   - validation strategy;
   - any proposed new dependency and why it improves modularity or reduces boilerplate.
5. Do not edit files until the user replies exactly:
   planejamento aprovado, pode implementar
6. After approval, implement only the approved documentation and contract changes.
7. Do not start S2-02 implementation if a required S2-01 decision remains unresolved.
8. Report actual validation results and remaining limitations.

Constraints

- Modify only backend and documentation files approved in the plan.
- Do not modify web or mobile source code.
- Do not implement unrelated features.
- Do not implement OFX, Pluggy, dashboards, investments, patrimony, payments, Pix, or real fund movement.
- Preserve the Clean/Hexagonal boundaries documented by the architecture.
- Domain and Application must not depend on NestJS, Prisma, Zod, HTTP, or PostgreSQL.
- Reuse existing dependencies first.
- A new dependency may be proposed only with a concrete modularity, boilerplate, maintenance, and replication justification; installation requires explicit approval.
- Do not invent routes, fields, statuses, error codes, precedence rules, or financial semantics.
- Preserve unrelated user changes.
- Use only fictitious data and never include secrets or real financial data.

Acceptance criteria

- All decisions required by S2-01 are either approved and documented or explicitly marked unresolved.
- The baseline does not contradict the PRD or Architecture.
- Transfers remain strictly accounting records and cannot initiate real fund movement.
- The contract is sufficiently precise for S2-02 through S2-06.
- Every decision has a traceable source or an explicit approval record.
- OpenAPI and backend implementation boundaries are clear.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 1 Sprint 2 | user-stated |
| Task definition | S2-01 Transactions baseline and contracts | user-stated through the approved Sprint 2 plan |
| Phase split | Multiple phase prompts following the Sprint 1 pattern | user-stated |
| Repository scope | Backend and documentation repositories | user-stated |
| Client scope | Web/mobile source code is out of scope | user-stated |
| Dependency policy | New dependencies may be proposed when they improve modularity or reduce boilerplate, but require approval before installation | user-stated |
| Stack and patterns | Discover and follow the documented repository stack and existing patterns | approved default |
| Edge cases | Enumerate from authoritative documentation and stop on unresolved normative decisions | approved default |
| Acceptance checks | Traceability, approved baseline, contract precision, and validation | approved default |
| Authorization checkpoint | Exact phrase required before edits | template plus repository instruction |

Source legend: user-stated means supplied by the user or approved plan; approved default means a repository-grounded default selected for this prompt; template means a standard skill clause.
