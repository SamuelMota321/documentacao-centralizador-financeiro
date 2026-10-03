# Prompt: Dev 1 Sprint 3 — Phase 3 OFX Preview, Confirmation, and Results

- Scenario: development
- Created: 2026-09-28 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode and review the proposed plan before authorizing changes.
3. Run after Phases 1 and 2 are complete and their relevant contracts and persistence are verified.
4. Before editing, provide the plan and wait for `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer specialized in authenticated REST APIs, OpenAPI, idempotent workflows, and tenant isolation.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 3 Phase 3 for S3-02. Verify that the approved Phase 1 contract and Phase 2 ingestion foundation exist and match the current code.

Read and follow every applicable AGENTS.md, approved S3-01 decisions, PRD HU-004/RN-006, Architecture, RLS ADR, backend OpenAPI, and existing controller, authentication, error, and test patterns.

## Task

Implement the approved authenticated REST workflow for OFX import:

- Receive and validate the approved file type and size.
- Create or reuse the approved ImportRun state.
- Parse and return a preview before any final transaction persistence.
- Show duplicate items according to the approved rule.
- Confirm the import idempotently.
- Persist through the Transactions public Application boundary.
- Return import status and counts for imported, ignored, and failed items.
- Support status/result queries.
- Implement asynchronous processing only if the approved contract requires it and the QStash/R2 prerequisites are available and authorized.
- Update OpenAPI to match observable backend behavior.

## Workflow

1. Verify prerequisites, existing endpoints, authentication, tenant context, upload handling, and current error conventions.
2. Map each approved contract item to the route, use case, persistence operation, and test.
3. Present the exact implementation plan, endpoint changes, idempotency and duplicate behavior, async impact, affected files, risks, checks, and dependency requests.
4. Wait for `planejamento aprovado, pode implementar`.
5. Implement only the approved workflow.
6. Run focused REST and integration checks, OpenAPI validation, and safe local smoke checks.
7. Report actual commands and results.

## Constraints

- Do not invent route names, request/response fields, status codes, error codes, duplicate identity, idempotency scope, async thresholds, or file-retention rules.
- The preview must precede final persistence.
- Never let a repeated confirmation create duplicate transactions.
- PDF is not accepted in the MVP.
- Keep authentication, tenant ownership, authorization, and RLS enforced.
- Do not place Pluggy, R2, or QStash I/O inside a tenant-aware database transaction.
- Do not include full financial payloads, secrets, or tokens in logs or jobs.
- Do not modify web or mobile source code.
- Do not implement HU-008 recurring synchronization.
- Do not add dependencies or run shared/production database operations without explicit approval.
- Preserve unrelated changes and do not weaken valid tests.

## Output

Report changed files, final API behavior and OpenAPI alignment, test/smoke results, limitations, handoffs, and a suggested commit message. Do not create a commit unless separately authorized.

## Acceptance criteria

- Invalid files and unsupported PDF are rejected before final persistence.
- The preview and duplicate information appear before confirmation.
- Repeated confirmation follows the approved idempotency rule and does not create duplicates.
- Results expose imported, ignored, and failed counts; long-running state is queryable if asynchronous processing was approved.
- REST, tenant-isolation, and OpenAPI checks pass or their blockers are reported.
- Run current REST/E2E tests, OpenAPI generation/check, and `git diff --check`; use only isolated or authorized local services. Discover current scripts before running them.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior backend engineer | template |
| Target environment | Codex | user-stated |
| Task and phase split | Five prompts; this phase implements the S3-02 REST workflow | user-stated |
| Prerequisites | Approved S3-01 contract and completed OFX foundation | approved default — phase sequencing and Sprint 3 plan |
| Repository context | Documentation and backend roots | user-stated paths |
| Stack and patterns | REST/OpenAPI, current NestJS authentication and error patterns | approved default — Architecture and backend repository |
| Edge cases | Preview-before-persist, duplicate/repeat confirmation, invalid file, PDF, tenant isolation, optional long processing | approved default — PRD HU-004 and Sprint 3 plan |
| Dependency policy | Async dependencies require approval and availability | approved default — Sprint 3 plan |
| Acceptance and checks | REST/E2E tests, OpenAPI generation/check, local smoke checks | approved default — backend package scripts and project validation conventions |
| Authorization gate | Exact project phrase before edits | user-provided AGENTS.md |
