# Prompt: Dev 1 Sprint 4 — Phase 1 Backend Baseline and Pluggy Decisions

- Scenario: development
- Created: 2026-10-18 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and backend repositories as workspace roots.
2. Use Plan mode. Review the exact plan and file list before authorizing any edits.
3. Run this phase first. It covers only Dev 1’s backend contribution to S4-01; Developer 3 owns the overall S4-01 decision consolidation.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Do not call Pluggy or R2 services unless credentials, access, and the external call are explicitly authorized.
6. Paste the prompt below as the first message.

## Prompt

```text
You are a senior backend engineer responsible for tenant-safe financial integrations, backend contracts, and technical traceability.

Work with:

- C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro
- C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro

This is Dev 1’s backend contribution to S4-01, not ownership of the overall activity or Sprint 4. Read applicable AGENTS.md files, the Sprint 4 plan, PRD 1.4, Architecture, the relevant PostgreSQL/RLS decisions, the Sprint 3 plan, and docs/planejamento/sprint-03/s3-01-necessidades-dos-clientes.md when present. Verify current repository state; historical reports are evidence to re-check, not proof of current behavior.

## Task

Establish the backend baseline and identify the decisions required before HU-008 synchronization and HU-009 investment work can proceed.

1. Verify the actual state of the HU-007 backend connection, consent, import, ownership, and provider-availability behavior, including the Sprint 3 dependencies referenced by the Sprint 4 plan.
2. Trace each relevant Sprint 4 backend requirement to its authoritative source, current implementation, tests, and evidence.
3. Create a decision register for unresolved integration and contract questions. For each item record its source, current state, owner to decide, impact, whether it blocks implementation, and next action.
4. Identify safe local validation options and any Sandbox or R2 access needed. Do not expose credentials or financial payloads.
5. Prepare a precise handoff to Developer 3 for S4-01 and Developer 2 for any client-contract dependency. Do not claim their work complete.

If an existing source does not authorize a behavior or data scope, mark it unresolved and stop the dependent implementation until the responsible owner records a decision.

## Workflow

1. Verify both repository roots and read applicable instructions.
2. Inspect only the backend modules, contracts, tests, and Sprint 3 evidence needed to establish the current baseline.
3. Present a traceability matrix, decision register, proposed output paths, affected files, risks, and validation commands.
4. Wait for planejamento aprovado, pode implementar.
5. Update only the approved backend or directly related technical documentation. If the evidence supports no edit, report the findings without creating a speculative document.
6. Run relevant checks and report actual results and limitations.

## Constraints

- Keep the scope to Dev 1’s backend baseline and decision handoff for S4-01.
- Do not implement HU-008 synchronization or HU-009 investment behavior in this phase.
- Do not edit web or mobile source code or claim the overall S4-01 activity is complete.
- Do not invent provider data scope, synchronization states, routes, payloads, retry policy, or persistence rules.
- Do not add dependencies, alter credentials/configuration, make external calls, or run shared/production database operations without explicit approval.
- Preserve unrelated changes and use synthetic data only.

## Output

Provide the traceability matrix, verified backend state, decision register, changed-file list, validation results, blockers, and handoffs. Suggest a commit message; do not commit unless separately authorized.

## Acceptance criteria

- Sprint 3 prerequisites are verified against current backend evidence.
- Every relevant decision has an authoritative source or is explicitly marked unresolved.
- Blocking decisions identify an owner and next action.
- Dev 1’s contribution is distinguished from Developer 2 and Developer 3 responsibilities.
- Run git diff --check if files change. Discover and run a focused backend check only when implementation files change and the environment supports it.

Begin by verifying the workspace roots and inspecting the Sprint 4 plan, applicable instructions, and minimum backend evidence needed for this baseline.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template and prompt language | Prompt header, usage section, English prompt, and decision record | template |
| Scenario and role | Development; senior backend engineer | template |
| Task and ownership | Dev 1’s backend slice of S4-01; overall decision consolidation remains with Dev 3 | approved default — selected Sprint 4 responsibility split |
| Repositories | Documentation and backend workspaces | approved default — current workspace and existing Dev 1 prompt pattern |
| Sprint scope and dependencies | S4-01 and HU-007 prerequisites for HU-008/HU-009 | approved default — Sprint 4 plan and PRD |
| Stack and patterns | Detect and follow current backend stack and module patterns | approved default — development scenario and repository |
| Edge cases | Unverified Sprint 3 state, missing decisions, external service access | approved default — Sprint 4 plan and PRD |
| Dependency policy | Do not add dependencies without explicit approval | approved default — development scenario and repository instructions |
| Acceptance and checks | Traceability, decision register, git diff --check, focused checks if code changes | approved default — Sprint 4 plan and current backend scripts |
| How-to-use workspace and phase order | Documentation/backend roots; this is the first phase | approved default — repository prompt conventions and phase dependencies |
| Approval and external calls | Exact phrase before edits; explicit authorization before external calls | user-stated — supplied AGENTS.md and selected scope |
