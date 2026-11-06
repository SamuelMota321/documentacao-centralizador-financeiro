# Prompt: Frontend Refactor — Phase 0 Skill Tooling

- Scenario: execution
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation, web, and mobile repositories as workspace roots.
2. Use Plan mode. Review the exact move list and the hook decision before authorizing changes.
3. Run this phase first. It changes only agent tooling and one documentation reference; it does not touch product code.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

```text
You are a senior developer-experience engineer responsible for agent tooling in a multi-repository academic product.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro

Read the applicable AGENTS.md files and docs/planejamento/refatoracao-frontend/Plano_Refatoracao_Frontend.html (sections 2 and 5) first.

## Context

The animation and UI skills (animate, animate-expo, animation-vocabulary, apple-design, ask-sonner, design-taste-frontend, emil-design-eng, find-animation-opportunities, improve-animations, mobile-native, pick-ui-library, prototype, review-animations, write-swift) sit nested under .agents/skills/UX-UI-FRONTEND/.agents/skills/ in the documentation repository, with symlink copies under .claude/skills and skills/. In that layout Codex likely does not discover them. The untracked .agents/skills/impeccable (about 18 MB) is paired with .codex/hooks.json, which runs the impeccable script after every Edit/Write and on Stop, including in backend tasks. web/UX_PRINCIPLES.md cites skills named ux-critic and visual-audit that do not exist.

## Task

1. Verify the current layout, symlink targets, skills-lock.json, and which skills Codex currently lists.
2. Propose the target layout: each skill at .agents/skills/<name>/SKILL.md in the repository that will use it (web skills in the web repository, Expo skills in the mobile repository, design-review skills where the visual-design workflow runs). Remove the nested copies only after the moved copies are verified.
3. Present options for .codex/hooks.json: keep, restrict to UI repositories, or remove. State the impact of each on backend tasks.
4. Propose the exact wording that replaces the ux-critic/visual-audit reference in web/UX_PRINCIPLES.md, pointing to skills that actually exist.

## Workflow

1. Inspect, then present the plan with the exact file moves, deletions, and edits.
2. Wait for planejamento aprovado, pode implementar.
3. Apply only the approved moves and edits.
4. Verify discovery of each moved skill and report.

## Constraints

- Do not modify product source code, dependencies, or configuration other than the agent tooling files listed above.
- Do not delete anything before its replacement is verified; list every deletion in the plan.
- Do not commit; suggest commit messages per repository.
- If discovery cannot be verified in this environment, say so instead of claiming success.

## Output

Report the final skill layout per repository, the hook decision applied, the UX_PRINCIPLES change, verification evidence, and suggested commit commands with explicit paths.

## Acceptance criteria

- Every skill lives at .agents/skills/<name>/SKILL.md in the repository chosen in the approved plan, with no broken symlinks.
- The hook behavior matches the approved option.
- web/UX_PRINCIPLES.md no longer references nonexistent skills.
- git status in each repository shows only the approved changes; git diff --check is clean.

Begin by listing the current skill directories, symlinks, and hook configuration.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Execution; developer-experience engineer | template |
| Workspace paths | Linux paths of the three repositories | user-stated — local workspace |
| Skill relocation and hook decision | Flatten skills; decide hook fate | approved default — approved plan, F0 |
| UX_PRINCIPLES correction | Replace nonexistent skill references | approved default — approved plan, F0 |
| Approval gate | Exact phrase before edits | user-stated — repository AGENTS.md |
| Commit policy | Suggest commands only | user-stated — user preference |
