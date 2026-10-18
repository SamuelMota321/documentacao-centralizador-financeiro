# Prompt: Dev 1 Sprint 4 — Phase 3 Manual Assets and Liabilities (HU-012)

- Scenario: development
- Created: 2026-10-18 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode. Review the data model, files, migration impact, and validation before authorizing changes.
3. Run after Phase 1. This phase is independent of HU-008 and may proceed in parallel with Phase 2 after the baseline decisions are available.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for tenant-owned financial records, persistence, and auditability.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1’s backend responsibility for S4-05 / HU-012. Developer 2 owns web/mobile interfaces; Developer 3 owns acceptance scenarios and cross-tenant evidence. Read applicable AGENTS.md files, the Sprint 4 plan, PRD HU-012 and RN-011/RN-015, Architecture, RLS decisions, and existing account/tenant-owned persistence patterns.

## Task

Implement the approved backend model and API behavior for registering assets, financing, and other liabilities that are not provided by integrations.

The PRD requires:

- Assets to record type, description, estimated value, valuation date, and user-provided source.
- Financing and liabilities to record outstanding balance and applicable data.
- Financing to be associable with an asset.
- Relevant changes to preserve history and audit.

Follow the approved model decisions and repository patterns. The PRD does not define a complete taxonomy or every subtype field. If a product decision changes the data model or client contract, identify options and impact, then stop the dependent work until it is approved.

## Workflow

1. Verify the tenant/account model, applicable audit approach, existing migrations, and current validation scripts.
2. Present a plan with exact domain/API/persistence changes, migration and rollback considerations, affected files, tests, and any open product decisions.
3. Wait for planejamento aprovado, pode implementar.
4. Implement only the approved backend HU-012 scope.
5. Run focused tests and relevant migration/RLS checks against an isolated local environment.
6. Report implementation evidence and a contract handoff to Developer 2.

## Constraints

- Keep domain rules in the responsible domain/application layers; preserve architecture boundaries.
- Enforce authenticated tenant ownership and cross-tenant isolation.
- Keep technical logs minimal and separate them from audit history.
- Do not invent a universal asset/liability taxonomy or fields not required by the PRD or an approved decision.
- Do not modify client source code or implement HU-010/HU-013 net-worth calculations.
- Do not add dependencies, apply migrations to shared/production systems, or change credentials/configuration without explicit approval.
- Preserve unrelated changes and use synthetic data only.

## Output

Provide the approved domain/API behavior, migration and audit effects, changed-file list, validation results, unresolved decisions, and client/testing handoffs. Suggest a commit message; do not commit unless separately authorized.

## Acceptance criteria

- Assets support the PRD-required type, description, estimated value, valuation date, and user-provided source.
- Financing and liabilities store the approved outstanding-balance and applicable data.
- Financing can be associated with an asset under the approved contract.
- Tenant authorization, audit/history, and RLS behavior are verified.
- Tests cover valid and invalid fields, optional asset association, auditability, and cross-tenant denial.
- Run the relevant focused test command. If schema or access-control behavior changes, verify migrations and RLS using the current package scripts and an isolated database. Run git diff --check.

Begin by verifying the existing tenant-owned persistence and audit patterns and identifying any PRD decisions that block the HU-012 contract.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template and prompt language | Prompt header, usage section, English prompt, and decision record | template |
| Scenario and role | Development; senior backend engineer for financial records | template |
| Task and ownership | Dev 1’s backend slice of S4-05/HU-012 | approved default — selected Sprint 4 responsibility split |
| Prerequisites | Phase 1; independent of HU-008 after baseline decisions | approved default — Sprint 4 dependency sequence |
| Stack and patterns | Detect and follow current domain, persistence, tenant, and audit patterns | approved default — backend repository and Architecture |
| Edge cases | Tenant ownership, subtype ambiguity, optional association, history and audit | approved default — PRD HU-012 and Sprint 4 plan |
| Dependency policy | Existing dependencies only unless separately approved | approved default — development scenario |
| Acceptance and checks | Focused tests, migration/RLS checks when affected, git diff --check | approved default — PRD, AGENTS, and backend scripts |
| Output and client boundary | Backend implementation and handoff; no client changes | approved default — Sprint 4 responsibility split |
| Approval gate | Exact phrase before edits | user-stated — supplied AGENTS.md |
