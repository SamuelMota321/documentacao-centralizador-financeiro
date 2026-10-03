# Prompt: Dev 1 Sprint 3 — Phase 4 Pluggy Connection and Consent

- Scenario: development
- Created: 2026-09-28 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode and review the proposed plan before authorizing changes.
3. Run after Phase 1’s Pluggy decisions are approved and available.
4. Before editing, provide the plan and wait for `planejamento aprovado, pode implementar`.
5. Use Pluggy Sandbox only when credentials and external access are explicitly authorized.
6. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer specialized in secure third-party integrations, tenant ownership, and consent-aware APIs.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 3 Phase 4 for S3-05. Verify that required S3-01 Pluggy decisions are approved. Use current official Pluggy documentation for the authentication, connection-token, callback, and revocation behavior that the approved flow requires; do not infer SDK APIs or signatures. If those sources are unavailable, report the limitation before selecting behavior.

Read and follow every applicable AGENTS.md, PRD HU-007/RN-007 through RN-009 and RNF-004/RNF-008, Architecture, RLS ADR, approved contract, and current Accounts and Ingestion module patterns.

## Task

Implement the backend connection and consent lifecycle required by HU-007:

- Keep Pluggy application credentials and API keys on the backend.
- Return only the approved limited connection token to the authenticated client.
- Associate the resulting connection/Item with the authenticated user and tenant.
- Persist only the approved connection reference, status, and consent/scope data.
- Enforce ownership, authorization, audit, and tenant-aware RLS.
- Implement the approved expiry, revocation, and disconnect behavior so that revoked or removed connections cannot start new collection.
- Update OpenAPI for the implemented backend contract.

Accounts owns connection data. Use public module interfaces for cross-module work. Make external Pluggy calls outside tenant-aware database transactions.

## Workflow

1. Verify the approved decisions, existing Accounts model, authentication, tenant context, provider configuration, and current Pluggy documentation.
2. Identify data-model and migration impact, secret handling, external effects, affected files, and rollback considerations.
3. Present the exact plan, security boundaries, API behavior, tests, risks, credentials/configuration needs, and any dependency request.
4. Wait for `planejamento aprovado, pode implementar`.
5. Implement only approved connection and consent behavior.
6. Run focused tests and local checks. Run Sandbox calls only with explicit authorization.
7. Report actual results, including which Sandbox checks ran.

## Constraints

- Do not invent consent scope, connection fields, callback semantics, routes, or local-data retention/deletion behavior.
- Do not store bank credentials, Pluggy application secrets, API keys, or connection tokens as durable connection state.
- Never expose secrets in API responses, logs, fixtures, source code, or client bundles.
- Do not implement recurring daily/manual synchronization from HU-008.
- Do not import investment data from HU-009.
- Do not modify web or mobile source code.
- New dependencies, secret/configuration changes, external Sandbox calls, and database operations require explicit approval in the plan.
- Preserve unrelated changes and never weaken tenant checks or RLS.

## Output

Report changed files, connection and consent states, API/OpenAPI behavior, tests and Sandbox evidence, limitations, and a suggested commit message. Do not create a commit unless separately authorized.

## Acceptance criteria

- A tenant can initiate the approved Sandbox connection flow without receiving application credentials.
- Connection ownership and consent state are persisted according to approved rules and protected against cross-tenant access.
- Expiry, revocation, and removal prevent future collection as required by the approved policy.
- Logs and fixtures contain no secrets or real financial data.
- Run focused unit tests and `npm run db:verify-rls` only with an isolated or authorized local database; use Sandbox only when explicitly authorized. Discover current scripts before running them.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header, How to use, prompt section, and decision-record format | template |
| Scenario and role | Development; senior backend engineer | template |
| Target environment | Codex | user-stated |
| Task and phase split | Five prompts; this phase implements S3-05 connection and consent | user-stated |
| Prerequisites | Approved S3-01 Pluggy decisions | approved default — Sprint 3 plan |
| Repository context | Documentation and backend roots | user-stated paths |
| Stack and patterns | Backend provider and Accounts/Ingestion boundaries | approved default — Architecture and backend repository |
| External source | Verify current official Pluggy docs; no guessed API signatures | approved default — Sprint 3 plan references |
| Edge cases | Tenant link, secret handling, partial/expired/revoked/disconnected connection | approved default — PRD HU-007 and Sprint 3 plan |
| Dependency and external-call policy | Separate approval for dependencies, credentials/configuration, Sandbox calls, and database operations | approved default — Sprint 3 plan and repository instructions |
| Acceptance and checks | Focused tests and isolated RLS verification | approved default — backend scripts and project validation conventions |
| Authorization gate | Exact project phrase before edits | user-provided AGENTS.md |
