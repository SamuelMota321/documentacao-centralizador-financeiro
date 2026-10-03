# Prompt: Dev 1 Sprint 3 — Phase 2 OFX Ingestion Foundation

- Scenario: development
- Created: 2026-09-28 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode and review the proposed plan before authorizing changes.
3. Run only after Phase 1 decisions needed by the parser and persistence model are approved and recorded.
4. Before editing, provide the plan and wait for `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer specialized in NestJS, TypeScript, domain modeling, Prisma, and PostgreSQL.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 3 Phase 2 for S3-02. Confirm that Phase 1’s required OFX decisions are approved and available. Do not proceed with behavior whose required decision remains unresolved.

Read and follow every applicable AGENTS.md, the approved S3-01 contract, Sprint 3 plan, PRD HU-004/RN-006, Architecture, RLS ADR, and current backend module and persistence patterns.

## Task

Implement the backend foundation for OFX ingestion using only the approved format, limits, account-association, duplicate, and retention decisions.

Cover the minimum approved foundation:

- Domain and Application boundaries for OFX ingestion.
- Parser and content validation for the approved OFX variants.
- Synthetic fixtures for valid and invalid inputs.
- Persistence structures and forward-only migrations required by the approved ImportRun and ingestion-item lifecycle.
- Public Application ports for any interaction with Accounts or Transactions.
- Tenant ownership, constraints, indexes, authorization, and RLS for Ingestion-owned data.
- Focused unit and persistence tests.

Treat the Architecture’s Ingestion ownership as a boundary. Persist normalized transactions through the owning Transactions module’s approved public interface; do not write another module’s private tables.

## Workflow

1. Verify Phase 1 approvals and current schema, migrations, modules, tests, and database helpers.
2. Identify the exact affected files, migration impact, data lifecycle, and rollback considerations.
3. Present the plan, schema/migration changes, test strategy, risks, and any dependency proposal.
4. Wait for `planejamento aprovado, pode implementar`.
5. Implement only approved foundation behavior.
6. Run focused validation against isolated or local environments only.
7. Report actual results and unresolved environmental limitations.

## Constraints

- Do not implement REST preview/confirmation endpoints; those belong to Phase 3.
- Do not choose OFX encodings, variants, limits, account mapping, duplicate identity, file retention, or async thresholds without an approved decision.
- Do not add dependencies without a separate approved proposal.
- Do not use `db push` instead of versioned migrations or edit an applied migration.
- Do not run migrations or database writes against shared or production environments.
- Do not weaken ownership, authorization, or RLS to make tests pass.
- Do not log full financial payloads, credentials, or personal data.
- Preserve Domain/Application independence from NestJS, Prisma, PostgreSQL, Pluggy, QStash, R2, HTTP, and Zod.
- Use synthetic data and preserve unrelated changes.

## Output

Report the changed files and their responsibilities, migrations, test commands and results, remaining blockers, and a suggested commit message. Do not create a commit unless separately authorized.

## Acceptance criteria

- Parser and validation behavior matches the approved OFX decisions.
- PDF and other unsupported content are rejected before persistence.
- ImportRun and ingestion persistence follow approved ownership and retention rules.
- Transactions are written only through the Transactions module’s public Application boundary.
- Migrations are forward-only and RLS/tenant behavior is verified locally where possible.
- Run current focused unit tests, Prisma validation, and `git diff --check`; use `npm run db:verify-rls` only with an isolated or authorized local database. Discover scripts before running them.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior backend engineer | template |
| Target environment | Codex | user-stated |
| Task and phase split | Five prompts; this phase builds the S3-02 OFX foundation | user-stated |
| Prerequisites | Approved Phase 1 OFX decisions | approved default — S3-01 dependency in Sprint 3 plan |
| Repository context | Documentation and backend roots | user-stated paths |
| Stack and patterns | NestJS, TypeScript, Prisma, PostgreSQL; current module patterns | approved default — Architecture and backend repository |
| Module boundaries | Ingestion owns ingestion; Transactions owns transaction persistence | approved default — Architecture |
| Edge cases | Invalid content, unsupported PDF, ownership, duplicate and retention rules only as approved | approved default — PRD and Sprint 3 open decisions |
| Dependency policy | No new dependency without separate approval | approved default — Sprint 3 plan |
| Acceptance and checks | Parser, persistence, Prisma and isolated RLS checks | approved default — project validation conventions |
| Authorization gate | Exact project phrase before edits | user-provided AGENTS.md |
