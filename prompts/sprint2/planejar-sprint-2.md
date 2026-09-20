# Prompt: Plan Sprint 2

- Scenario: development
- Created: 2026-09-16 · Target: Codex · Prompt language: English

## How to use

1. Open a new local Codex task with `documentacao-centralizador-financeiro` as its workspace and the same project context used by the current task.
2. Keep the task in a read-only planning phase until it presents the proposed Sprint 2 scope, developer allocation, and file changes. Review that proposal before authorizing edits.
3. To authorize the approved file changes, reply with the exact phrase `planejamento aprovado, pode implementar`.
4. Paste the prompt below as the first message.

## Prompt

```
<role>
You are a senior technical lead and sprint planner specializing in repository-driven software delivery and HTML documentation.
</role>

<context>
Workspace: `documentacao-centralizador-financeiro`.

Review all project files in this workspace. Read and follow every applicable repository instruction, including `AGENTS.md`.

The planning period for Sprint 2 is September 11–25, 2026.

Use the following repository evidence as the source of truth:
- The existing Sprint 1 documentation defines the established pattern for dividing work among Developer 1, Developer 2, and Developer 3.
- `style-guide.html` defines the visual base for the new Sprint 2 document.
- Existing equivalent HTML documents define the appropriate destination, naming convention, structure, and navigation pattern for the new document.

Use only dependencies and libraries already present in the project.
</context>

<outcome>
Produce a complete, executable Sprint 2 plan for three developers, then document the approved plan in a new HTML page that follows the application's existing visual and navigation patterns.

This task plans and documents Sprint 2. It must not implement any Sprint 2 product functionality.
</outcome>

<workflow>
Work in two mandatory phases.

Phase 1 — Inspect and plan:

1. Inspect all project files in `documentacao-centralizador-financeiro`.
2. Locate and analyze:
   - the Sprint 1 planning documentation;
   - `style-guide.html`;
   - roadmap, requirements, architecture, feature, backlog, and prior-sprint documentation;
   - equivalent HTML documents that establish naming, placement, page structure, and navigation.
3. Extract every Sprint 2 item that is supported by the documentation.
4. Cite the source file for every extracted requirement, task, constraint, dependency, or priority.
5. Identify missing, ambiguous, stale, or conflicting information. Do not resolve it by inference.
6. Present a proposed Sprint 2 plan containing:
   - sprint objective and scope;
   - prioritized backlog;
   - stories or executable work items;
   - acceptance criteria for every item;
   - estimates using the same method found in Sprint 1;
   - dependencies and required execution order;
   - risks, blockers, and mitigations;
   - assignments to Developer 1, Developer 2, and Developer 3;
   - workload distribution following the Sprint 1 allocation pattern;
   - an execution schedule covering September 11–25, 2026;
   - validation activities;
   - unresolved questions that require user decisions;
   - the proposed path and filename for the new HTML;
   - the exact existing HTML files that require navigation updates.
7. Discuss every item that cannot be grounded in the repository before including it in the sprint.
8. Present the implementation plan required by the repository instructions and stop. Do not edit files until the user replies with the exact authorization:
   `planejamento aprovado, pode implementar`

Phase 2 — Create and verify the documentation:

9. After receiving the exact authorization, create only the approved Sprint 2 HTML document.
10. Reuse the structure and visual conventions established by `style-guide.html`; do not redesign the application's visual language.
11. Update only the equivalent existing HTML files identified and approved in Phase 1, adding the navigation links required to keep the documentation connected.
12. Do not implement the sprint backlog or modify application code.
13. Validate the resulting HTML, navigation links, and browser rendering.
14. Discover and run any relevant repository check that already exists. Report the command and result. Do not add a new dependency solely for validation.
15. Compare the rendered result with `style-guide.html` and correct visual inconsistencies within the approved scope.
16. Stop when all acceptance criteria are satisfied. If completion would require a file, behavior, dependency, or scope not approved in Phase 1, stop and ask for authorization.
</workflow>

<constraints>
- Modify only the new Sprint 2 HTML and the approved equivalent HTML files that need navigation links.
- Do not modify `style-guide.html`.
- Do not add dependencies.
- Do not implement Sprint 2 product features.
- Do not invent requirements, estimates, priorities, assignments, or business rules.
- If available information is insufficient, say so and ask the user instead of inferring.
- Preserve unrelated user changes in the worktree.
- Do not use destructive shortcuts or destructive Git operations.
- Obtain confirmation before any destructive, irreversible, external, or out-of-scope action.
- Keep the change minimal: do not add unrelated features, abstractions, files, formatting changes, or cleanup.
- Do not hardcode content merely to satisfy a check; validation must verify the documented plan and navigation.
</constraints>

<output_format>
Phase 1 response:

1. Evidence reviewed
2. Sprint objective and scope
3. Prioritized backlog
4. Work allocation table for Developer 1, Developer 2, and Developer 3
5. Execution schedule for September 11–25, 2026
6. Dependencies and execution order
7. Risks, blockers, and mitigations
8. Validation plan
9. Unresolved questions
10. Proposed file changes
11. Concise implementation plan
12. Explicit request for the exact authorization phrase

For each work item, include:
- identifier and title;
- description;
- repository source;
- priority;
- estimate using the Sprint 1 method;
- assigned developer;
- dependencies;
- acceptance criteria;
- planned execution window.

Phase 2 completion report:

### Cause
Why the Sprint 2 documentation was needed.

### Changed Files
Each changed file and its purpose.

### Validation
Every validation actually executed and its result.

### Remaining Risks
Unresolved assumptions, documentation gaps, or validation limitations.
</output_format>

<acceptance_criteria>
The task is complete only when:

- Sprint 2 explicitly covers September 11–25, 2026.
- The plan is grounded in the repository documentation, with a source identified for every extracted work item.
- Unsupported or ambiguous content was discussed with the user instead of being inferred.
- Every approved work item has a priority, estimate, owner, dependencies, execution window, and verifiable acceptance criteria.
- Work is divided among Developer 1, Developer 2, and Developer 3 according to the established Sprint 1 pattern.
- No approved work item is left unassigned.
- Dependencies and execution order are internally consistent.
- The new HTML follows the structure and visual language of `style-guide.html`.
- Equivalent HTML documents contain the required navigation links to the Sprint 2 document.
- Navigation to and from the new page works.
- The changed HTML files render successfully in a browser.
- Relevant existing repository checks, if available, pass.
- No Sprint 2 application functionality, unrelated file, or dependency was changed.
</acceptance_criteria>
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Scenario | Development, restricted to planning and documentation | user-stated |
| Role | Senior technical lead and sprint planner | template |
| Working directory | `documentacao-centralizador-financeiro`, using the same project context as the current task | user-stated |
| Material | All project files in the workspace | user-stated |
| Sprint period | September 11–25, 2026 | user-stated |
| Task definition | Produce a complete Sprint 2 plan for three developers and document the approved result as HTML | user-stated |
| Product implementation | Out of scope | user-stated |
| Team allocation | Developer 1, Developer 2, and Developer 3, following the established Sprint 1 pattern | user-stated |
| Planning contents | Prioritized backlog, stories or work items, acceptance criteria, estimates, dependencies, risks, and execution sequence | user-stated |
| Documentation gaps | Discuss them with the user; do not fill them by inference | user-stated |
| Visual reference | `style-guide.html` | user-stated |
| Output path and filename | Discover and follow the existing repository pattern | approved default |
| Navigation | Index the new document from equivalent HTML documents | user-stated |
| Dependency policy | Use only existing dependencies and libraries | user-stated |
| Editable files | The new HTML and approved equivalent HTML files requiring navigation links | user-stated |
| Authorization checkpoint | Wait for `planejamento aprovado, pode implementar` before editing | user-stated |
| Validation | Check HTML and links, render in a browser, compare with the style guide, and run existing repository checks | user-stated |
| Minimal scope and anti-hardcoding | Standard development-scenario clauses | template |
| Agentic safety | Preserve unrelated changes and confirm destructive, irreversible, external, or out-of-scope actions | template |
| Prompt file | `prompts/planejar-sprint-2.md` | user-stated |
| How-to-use: task context | Open a new local Codex task using the current project context | user-stated |
| How-to-use: planning checkpoint | Review the plan before authorizing implementation | template |
| Prompt language | English | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by the final approval; **open** — deliberately left as `[OPEN: question]`.
