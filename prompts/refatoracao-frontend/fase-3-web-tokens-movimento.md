# Prompt: Frontend Refactor — Phase 3 Web Motion Token Consolidation

- Scenario: code-change
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and web repositories as workspace roots.
2. Use Plan mode. Run after Phase 2 is approved, on an isolated branch or after S4-06 closes.
3. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
4. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer specializing in CSS architecture and accessible motion.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro

Read web/AGENTS.md, web/DESIGN.md (updated in Phase 2), the Phase 1 report, and the motion sections of docs/design/style-guide.html. Use the coinciente-visual-design and review-animations skills.

## Task

Refactor web motion to the approved semantic tokens without changing intended behavior.

1. Declare the approved semantic motion tokens in src/app/globals.css next to the existing --ease-* and --duration-* tokens. Keep or alias the old names only if the approved plan says so.
2. Replace hard-coded durations with tokens, starting with src/app/page.module.css:99, src/app/(app)/movimentacoes/movimentacoes.module.css:251, and src/components/ui.module.css:843 and :978, plus any others listed in the Phase 1 inventory.
3. If Phase 1 confirmed the .reveal reduced-motion defect, fix it so reduced motion keeps the opacity exit and removes displacement.

## Workflow

1. Confirm the inventory against the current files; present the exact diff per file.
2. Wait for planejamento aprovado, pode implementar.
3. Apply only the approved diff.
4. Validate and report.

## Constraints

- Preserve every visible timing unless the approved plan changes it; a token rename alone must be visually identical.
- Change only globals.css, ui.module.css, page.module.css, movimentacoes.module.css, and any other file explicitly approved.
- Do not add dependencies or touch TypeScript components.
- Do not edit tests to make them pass. Do not commit.

## Output

Changed files with the purpose of each change, before/after token mapping, validation results, and remaining risks.

## Acceptance criteria

- A grep for numeric ms values in transition/animation declarations returns only token definitions or documented exceptions.
- Reduced motion verified manually in the browser (DevTools emulation) for panel, menu, dialog, and recent-row highlight; if not executed, say so.
- pnpm lint && pnpm typecheck && pnpm test && pnpm build pass; git diff --check is clean.

Begin by re-running the motion grep and comparing it with the Phase 1 inventory.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Code change; frontend engineer | template |
| Target files and lines | Verified on 2026-10-22 | approved default — approved plan, F3 |
| Behavior preservation | Rename is visually identical | template — code-change risk clause |
| Validation commands | Web DoD command | user-stated — web DESIGN_DEFINITION_OF_DONE.md |
| Approval gate | Exact phrase before edits | user-stated — repository AGENTS.md |
