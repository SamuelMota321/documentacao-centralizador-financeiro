# Prompt: Frontend Refactor — Phase 7 Evidence and Accessibility Report

- Scenario: audit
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation, web, and mobile repositories as workspace roots.
2. Run after the code phases. The audit itself is read-only; writing the final report to the documentation repository needs separate approval.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior accessibility and design-quality reviewer for web and mobile financial interfaces.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro

Read the refactor plan (section 9, definition of done), Style Guide 1.1, both DESIGN.md and DESIGN_DEFINITION_OF_DONE.md files, and the reports from Phases 1 to 6. Use coinciente-visual-design and review-animations.

## Task

1. Check each definition-of-done item of the refactor plan against the current repositories and record pass, fail, or not verified, with evidence.
2. Re-run the motion grep and confirm no duration or curve exists outside the documented tokens.
3. For every motion, confirm reduced-motion behavior from source and list the manual or device checks still required.
4. Confirm that no financial value animates and no state relies on color alone.
5. Run the validation commands of each client repository and record the results.

## Constraints

- Read-only. Do not fix findings; list them.
- Separate measured or executed evidence from source inspection; do not claim device testing that was not performed.
- No findings in a category is an acceptable result.

## Output

A markdown report: definition-of-done checklist with evidence, open findings ranked by severity, validation command results, and the list of checks pending on real devices. Propose its destination in docs/planejamento/refatoracao-frontend/ for separate approval.

## Acceptance criteria

- Every definition-of-done item has a status and evidence.
- Web: pnpm lint && pnpm typecheck && pnpm test && pnpm build executed and reported. Mobile: pnpm typecheck && pnpm test executed and reported.

Begin by reading the definition of done and re-running the motion grep in the web repository.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Audit; accessibility reviewer | template |
| Checklist source | Plan section 9 | approved default — approved plan, F7 |
| Read-only and epistemics | Findings only; no findings is acceptable | template — audit risk clause |
| Validation commands | Client DoD commands | user-stated — DESIGN_DEFINITION_OF_DONE.md |
