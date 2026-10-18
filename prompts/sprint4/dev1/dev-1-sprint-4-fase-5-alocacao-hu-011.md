# Prompt: Dev 1 Sprint 4 — Phase 5 Investment Allocation Data (HU-011)

- Scenario: development
- Created: 2026-10-18 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode. Review grouping semantics, source data, API impact, and tests before authorizing changes.
3. Run after Phase 4’s investment model and read API are approved and available.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for accurate portfolio aggregation and explainable financial data contracts.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1’s backend data/grouping contribution to S4-04 / HU-011. Developer 2 owns the web/mobile allocation experience; Developer 3 owns validation of calculations and integration evidence. Read applicable AGENTS.md files, the Sprint 4 plan, PRD HU-011 and RN-010, the approved HU-009 model/API, Architecture, and current backend patterns.

## Task

Provide the approved backend data or grouping contract needed to present investment allocation by asset class and institution.

- Calculate percentages from available investment data under the approved denominator and rounding behavior.
- Support grouping by class and institution.
- Keep positions without a supported classification explicitly unclassified.
- Preserve access to source and reference date.
- Make partial or stale inputs visible according to the approved HU-009 contract.

Inspect whether aggregation belongs in an existing backend domain/application module or whether the approved client contract can use the existing investment response. Do not add an abstraction or endpoint unless needed and approved. If the provider-to-class mapping, calculation denominator, or rounding behavior is not established by an authoritative source, register the decision and stop the affected implementation.

## Workflow

1. Verify Phase 4 outputs and the relevant investment data shape.
2. Present the calculation rules, contract impact, affected files, tests, and any unresolved decision.
3. Wait for planejamento aprovado, pode implementar.
4. Implement only the approved backend contribution to HU-011.
5. Run focused tests with synthetic positions, including partial data and missing classifications.
6. Hand off the API shape and calculation semantics to Developers 2 and 3.

## Constraints

- Do not invent provider asset classes or silently classify unknown positions.
- Do not present percentages as covering data that was unavailable or excluded; state the approved basis.
- Do not modify web/mobile source code or claim their allocation visualizations are complete.
- Do not implement HU-010/HU-013 net worth or dashboard behavior.
- Preserve tenant isolation, authorization, provenance, and reference dates.
- Do not add dependencies, change credentials/configuration, or use real financial data without explicit approval.
- Preserve unrelated changes.

## Output

Provide the approved calculation and grouping semantics, API/OpenAPI changes if approved, changed files, validation results, unresolved decisions, and handoffs. Suggest a commit message; do not commit unless separately authorized.

## Acceptance criteria

- Allocation can be grouped by class and institution using the approved investment data contract.
- Percentages are calculated over the approved available-data basis.
- Unclassified positions remain explicitly unclassified.
- Source and reference date remain accessible.
- Tests cover partial data, unclassified assets, institution grouping, and calculation behavior.
- Run relevant focused tests, typecheck, and OpenAPI validation when affected. Run git diff --check.

Begin by verifying Phase 4’s approved data model and the authoritative calculation rules; stop if classification or denominator semantics are still open.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template and prompt language | Prompt header, usage section, English prompt, and decision record | template |
| Scenario and role | Development; senior backend engineer for portfolio aggregation | template |
| Task and ownership | Dev 1’s backend contribution to S4-04/HU-011 | approved default — selected Sprint 4 responsibility split |
| Prerequisites | Phase 4’s approved investment data model | approved default — Sprint 4 dependency sequence |
| Stack and patterns | Inspect current backend ownership and grouping patterns | approved default — backend repository and Architecture |
| Edge cases | Partial data, unclassified assets, reference dates, denominator ambiguity | approved default — PRD HU-011/RN-010 and Sprint 4 plan |
| Dependency policy | Existing dependencies only unless separately approved | approved default — development scenario |
| Acceptance and checks | Focused calculations, partial-data tests, typecheck/OpenAPI checks | approved default — PRD and backend scripts |
| Client boundary | Backend contract and handoff only; no client edits | approved default — Sprint 4 responsibility split |
| Approval gate | Exact phrase before edits | user-stated — supplied AGENTS.md |
