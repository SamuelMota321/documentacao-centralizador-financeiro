# Prompt: Dev 1 Sprint 4 — Phase 4 Investment Data and API (HU-009)

- Scenario: development
- Created: 2026-10-18 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode. Review the approved data mapping, API contract, affected files, and checks before authorizing changes.
3. Run after Phase 2’s synchronization contract and behavior are available and approved.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Use Pluggy Sandbox only if credentials, access, and the particular request are explicitly authorized.
6. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for typed investment data, provider integration boundaries, and accurate API behavior.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1’s backend model/API contribution to S4-03 / HU-009. Developer 2 owns the investment experience in web and mobile; Developer 3 owns acceptance criteria, tests, and integration evidence. Read applicable AGENTS.md files, the Sprint 4 plan, PRD HU-009 and RN-010, approved Phase 1 decisions, Phase 2 synchronization contracts, Architecture, and current backend patterns.

## Task

Implement the approved backend representation and read contract for investment positions and related information delivered by the Pluggy Sandbox.

Support the PRD fields when supplied by the approved source: position and portfolio totals, quantity or balance, invested value, result, institution, reference date, available movements, and applicable fixed-income details. Preserve source, external identifier, asset type, reference date, currency, and data quality when applicable.

Represent missing, unavailable, or stale fields explicitly under the approved contract. Do not treat old data as current. Inspect the real provider contract and existing code before choosing mappings. If a field or data type is not available or approved, record the limitation rather than inventing it.

## Workflow

1. Verify Phase 2 completion, approved provider data scope, existing persisted data, and current OpenAPI behavior.
2. Present a traceability matrix, exact data/API changes, affected files, compatibility considerations, tests, and validation commands.
3. Wait for planejamento aprovado, pode implementar.
4. Implement only the approved backend HU-009 model/API scope.
5. Run focused tests with synthetic fixtures; use external Sandbox data only when explicitly authorized.
6. Hand off the API contract and known data limitations to Developer 2 and evidence needs to Developer 3.

## Constraints

- Use existing module ownership and public Application interfaces.
- Do not invent provider fields, asset mappings, units, currencies, timestamps, or quality semantics.
- Do not implement the client interfaces or HU-010/HU-013 calculations.
- Do not silently discard source or reference metadata required by the PRD.
- Do not add dependencies or change credentials/configuration without explicit approval.
- Never log secrets or unnecessary financial payloads. Preserve tenant isolation, authorization, and RLS.
- Preserve unrelated changes and use synthetic fixtures unless external data access was explicitly approved.

## Output

Provide the traceability matrix, implemented data/API contract, changed files, validation results, known data gaps, and handoffs to Developers 2 and 3. Suggest a commit message; do not commit unless separately authorized.

## Acceptance criteria

- Positions and portfolio totals are returned when available under the approved source contract.
- Applicable provider fields and provenance/reference metadata are preserved.
- Missing, unavailable, partial, and stale data are explicit and not presented as current.
- Tests cover complete and partial records, unavailable fields, stale data, and tenant isolation.
- OpenAPI matches the approved behavior.
- Run relevant focused backend tests and verify current lint, typecheck, and OpenAPI scripts when affected. Use only synthetic data unless Sandbox use was explicitly approved.

Begin by verifying the approved Phase 2 data contract and the actual provider fields available in the current implementation; stop if a required mapping decision remains unresolved.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template and prompt language | Prompt header, usage section, English prompt, and decision record | template |
| Scenario and role | Development; senior backend engineer for typed investment data | template |
| Task and ownership | Dev 1’s backend model/API contribution to S4-03/HU-009 | approved default — selected Sprint 4 responsibility split |
| Prerequisites | Approved Phase 2 synchronization contract and data scope | approved default — Sprint 4 dependency sequence |
| Stack and patterns | Detect and follow current backend contracts and module boundaries | approved default — backend repository and Architecture |
| Edge cases | Partial provider fields, missing/stale data, source and reference preservation | approved default — PRD HU-009/RN-010 and Sprint 4 plan |
| Dependency policy | Existing dependencies only unless separately approved | approved default — development scenario |
| Acceptance and checks | Focused tests, OpenAPI alignment, isolation and data-quality cases | approved default — PRD and backend scripts |
| Sandbox permission | Explicit authorization required for external data calls | approved default — existing Dev 1 prompt convention |
| Approval gate | Exact phrase before edits | user-stated — supplied AGENTS.md |
