# Prompt: Frontend Refactor — Phase 6 Sprint 4 Screens Adopt the System

- Scenario: code-change
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation, web, and mobile repositories as workspace roots.
2. Use Plan mode. Run after Phases 4 and 5 and only after Developer 2 agrees on which Sprint 4 screens change.
3. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
4. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer integrating a design system into existing product screens without changing their data contracts.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro

Read the applicable AGENTS.md files, the Sprint 4 plan (docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html), the refactor plan, Style Guide 1.1, and each client's DESIGN.md. Use coinciente-visual-design.

## Task

Apply the provenance, live-state, and patrimony patterns to the Sprint 4 screens for HU-008 (sync trigger and state), HU-009 (investment positions), HU-011 (allocation), and HU-012 (assets and liabilities), on web and mobile, within the scope agreed with Developer 2.

- HU-008: the sync state component with recovery on failure.
- HU-009: the data stamp on positions; missing, unavailable, and stale fields explicit.
- HU-011: static bars plus a table and a text summary; "não classificado" explicit; no growing-bar animation.
- HU-012: Newsreader for patrimony values only where web/DESIGN.md allows it.

## Workflow

1. Inventory the current Sprint 4 screens and agree the list with Developer 2; present the plan per screen.
2. Wait for planejamento aprovado, pode implementar.
3. Apply only the approved screen changes.
4. Validate and report.

## Constraints

- Do not change API clients, schemas, fixtures that represent the contract, or business rules.
- Do not invent financial metrics, totals, or balances; the dashboard belongs to Sprint 5.
- Do not edit tests to make them pass. Do not commit.

## Output

Per screen: what changed, evidence, validation results, and anything left pending.

## Acceptance criteria

- Each changed screen meets both DESIGN_DEFINITION_OF_DONE.md files, including the new motion and provenance items.
- Web: pnpm lint && pnpm typecheck && pnpm test && pnpm build pass. Mobile: pnpm typecheck && pnpm test pass.
- git diff --check is clean in each repository.

Begin by listing the Sprint 4 screens that exist in each client today.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Code change; frontend integration | template |
| Screens and patterns | HU-008/009/011/012 | approved default — approved plan, F6 |
| Developer 2 coordination | Agreement before changes | approved default — approved plan, risks |
| Contract preservation | No API or business-rule changes | template — code-change risk clause |
| Approval gate | Exact phrase before edits | user-stated — repository AGENTS.md |
