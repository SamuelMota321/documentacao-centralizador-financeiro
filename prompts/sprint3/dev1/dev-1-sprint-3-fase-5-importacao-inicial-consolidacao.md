# Prompt: Dev 1 Sprint 3 — Phase 5 Initial Import and Backend Consolidation

- Scenario: development
- Created: 2026-09-28 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode and review the proposed plan before authorizing changes.
3. Run after Phase 4 is complete and approved; complete Phase 3 before final cross-flow consolidation.
4. Before editing, provide the plan and wait for `planejamento aprovado, pode implementar`.
5. Use Pluggy Sandbox only when credentials and external access are explicitly authorized.
6. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer responsible for provider data import, resilience, verification, and technical handoff.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 3 Phase 5. It completes Dev 1’s backend implementation slice for S3-05 and backend verification/handoff contribution to S3-08. S3-08 is not owned solely by Dev 1.

Verify that the approved Pluggy data scope, connection model, import contract, S3-02 backend behavior, and relevant client contracts are available. Read and follow every applicable AGENTS.md, PRD HU-007/RN-007 through RN-009, Architecture, RLS ADR, and approved S3-01 decisions.

## Task

Implement the approved initial import required by HU-007:

- Fetch only the data types approved for the initial connection.
- Map account and transaction data through their owning modules’ public Application interfaces.
- Make the initial import idempotent and tenant-isolated.
- Represent availability per approved data type, including partial provider availability.
- Preserve previously persisted valid data when an external request fails.
- Stop future collection after expiry, revocation, or removal according to the approved policy.

Then complete only Dev 1’s S3-08 backend slice:

- Verify backend OpenAPI against observable behavior and the approved client contract.
- Run relevant unit, integration, REST/E2E, migration, RLS, and contract checks.
- Review logs, fixtures, and evidence for secrets and real financial data.
- Prepare concise technical handoffs for Developer 2 (API contract and limitations) and Developer 3 (backend evidence, test results, unresolved cases).
- Clearly separate verified Dev 1 work from work owned by other developers.

## Workflow

1. Verify all prerequisites and current code; do not infer client implementation or overall S3-08 completion.
2. Build a traceability matrix from the approved criteria to backend code, tests, and evidence.
3. Present an exact plan, affected files, test commands, external-service needs, risks, and dependency proposals.
4. Wait for `planejamento aprovado, pode implementar`.
5. Implement only the approved initial-import and backend-consolidation scope.
6. Run the narrowest relevant checks first, then justified backend regression checks.
7. Report every actual command, result, limitation, and handoff.

## Constraints

- Do not infer which Pluggy data types HU-007 permits; HU-009 investments remain out of scope.
- Do not implement daily or manual recurring synchronization from HU-008.
- Do not make external Pluggy calls inside tenant-aware database transactions.
- Do not put tokens, credentials, secrets, or unnecessary financial payloads in jobs or logs.
- Do not bypass authorization, idempotency, tenant ownership, RLS, or audit behavior.
- Use synthetic fixtures; access Sandbox only with explicit authorization.
- Do not modify web or mobile source code or claim another developer’s work is complete.
- Do not add dependencies, change credentials/configuration, or run shared/production database operations without explicit approval.
- Preserve unrelated changes and do not modify valid tests merely to hide defects.

## Output

Provide a Dev 1 traceability matrix, changed-file list, actual validation results, Sandbox evidence or blocker, unresolved decisions, handoffs to Developers 2 and 3, and a suggested commit message. Do not create a commit unless separately authorized.

## Acceptance criteria

- Only approved initial-import data types are fetched and persisted.
- Repeated import does not create duplicates, and cross-tenant access is denied.
- Partial provider results are visible; external failure does not delete previously valid records.
- Expired, revoked, or removed connections cannot begin new collection under the approved policy.
- Backend OpenAPI matches the approved contract and implemented behavior.
- Relevant backend tests, Prisma/migration checks, RLS checks, typecheck, lint, and build pass or report actual blockers.
- Run available focused checks first. The backend currently documents scripts including `npm run test:unit`, `npm run test:integration`, `npm run test:e2e`, `npm run prisma:validate`, `npm run db:verify-migrations`, `npm run db:verify-rls`, `npm run openapi:generate`, `npm run lint`, `npm run typecheck`, and `npm run build`; verify the current package scripts and use isolated or authorized local services only.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior backend engineer | template |
| Target environment | Codex | user-stated |
| Task and phase split | Five prompts; this phase finishes initial import and Dev 1’s backend slice of S3-08 | user-stated |
| Prerequisites | Phase 4 and approved data scope; Phase 3 before cross-flow consolidation | approved default — Sprint 3 plan and dependency sequence |
| Repository context | Documentation and backend roots | user-stated paths |
| Stack and patterns | Existing backend modules, OpenAPI, Prisma, and RLS patterns | approved default — Architecture and backend repository |
| Edge cases | Idempotency, cross-tenant isolation, partial data, external failure, revoked/removed connection | approved default — PRD and Sprint 3 plan |
| Scope exclusions | HU-008 recurring sync, HU-009 investments, and other developers’ work | approved default — Sprint 3 plan |
| Acceptance and checks | Backend unit/integration/E2E, migrations, RLS, OpenAPI, typecheck, lint, build | approved default — backend package scripts and project validation conventions |
| Authorization gate | Exact project phrase before edits | user-provided AGENTS.md |
