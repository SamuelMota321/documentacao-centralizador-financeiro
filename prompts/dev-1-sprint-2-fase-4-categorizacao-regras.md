# Prompt: Dev 1 Sprint 2 — Phase 4 Categorization and Personal Rules

- Scenario: development
- Created: 2026-09-20 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with these repositories as workspace roots:
   - C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
   - C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro
2. Use Plan mode. Review the proposed plan before authorizing edits.
3. Run this phase only after S2-01, S2-02, and S2-03 are complete. The S2-04 client contract may be inspected but client code must not be modified.
4. Authorize implementation only with the exact phrase: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior backend engineer specialized in domain modeling, REST APIs, categorization rules, Prisma, PostgreSQL, and tenant-aware application design.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1 Sprint 2 Phase 4. S2-01, S2-02, and S2-03 must already be complete. The client contract from S2-04 may be inspected but must not be modified.

Read and follow every applicable AGENTS.md, the approved Transactions baseline, PRD HU-005/HU-006, Architecture, Prisma schema, migrations, OpenAPI, existing backend patterns, and tests.

Task

Complete Dev 1’s backend contribution to S2-05 and S2-06.

For S2-05, implement:

- Assigning a permitted category to a transaction.
- Manual category correction.
- Explicit uncertain or unrecognized categorization results.
- Persistence and retrieval of the corrected category.
- Same-tenant ownership checks.
- OpenAPI and Problem Details behavior.
- Audit behavior required by the approved contract.

For S2-06, implement:

- Creating personal categorization rules.
- Editing rules.
- Activating and deactivating rules.
- Removing rules according to the approved lifecycle.
- Approved rule conditions and operators only.
- Deterministic precedence and conflict handling.
- Same-tenant ownership across rules, conditions, categories, and transactions.
- OpenAPI, persistence, and audit behavior.

Personal rules must take precedence over general rules only if that general-rule concept exists in the approved S2-01 baseline. Do not create unspecified rule engines or generalized condition systems.

Do not claim a categorization accuracy percentage without an approved dataset and executed evidence.

Workflow

1. Verify all prerequisites and inspect the current implementation.
2. Map every behavior to the approved S2-01 contract and authoritative product requirements.
3. Enumerate ambiguous rule conditions, precedence cases, and cross-tenant cases.
4. Present the exact plan, files, migrations, API changes, tests, risks, and dependency proposals.
5. Wait for:
   planejamento aprovado, pode implementar
6. Implement only the approved scope.
7. Run focused domain, application, persistence, REST, ownership, and contract checks.
8. Report actual results.

Constraints

- Modify only backend and approved technical documentation.
- Do not modify web or mobile source code.
- Do not invent condition operators, rule fields, precedence rules, category lifecycles, routes, or status codes.
- Do not reveal another tenant’s categories, transactions, or rules.
- Do not bypass RLS or application-level ownership checks.
- Do not add an automatic classification algorithm unless explicitly present in the approved baseline.
- Reuse existing dependencies first.
- New dependencies require a written justification and explicit approval before installation.
- Preserve unrelated changes and use fictitious data only.

Acceptance criteria

- A transaction can receive a valid same-tenant category.
- Manual correction persists and is observable through the approved contract.
- Uncertain or unrecognized results remain explicit.
- Rules can be created, edited, activated, deactivated, and removed as approved.
- Rule conflicts resolve deterministically and transparently.
- Cross-tenant access is denied without revealing foreign data.
- Relevant OpenAPI, unit, integration, and REST tests pass or report evidence-based limitations.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 1 Sprint 2 | user-stated |
| Task definition | S2-05 backend categorization and S2-06 personal categorization rules | user-stated through the approved Sprint 2 plan |
| Prerequisites | Approved S2-01 through S2-03 | user-stated through the plan dependencies |
| Repository scope | Backend and documentation repositories | user-stated |
| Client scope | Web/mobile source code is out of scope | user-stated |
| Dependency policy | New dependencies require proposal and approval before installation | user-stated |
| Edge cases | Uncertainty, correction, deterministic conflicts, ownership, and cross-tenant denial | plan and repository contract |
| Acceptance checks | Domain, persistence, REST, OpenAPI, and ownership validation | approved default |
| Authorization checkpoint | Exact phrase required before edits | template plus repository instruction |

Source legend: user-stated means supplied by the user or approved plan; approved default means a repository-grounded default selected for this prompt; template means a standard skill clause.
