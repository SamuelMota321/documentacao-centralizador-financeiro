# Prompt: Update the Sprint 1 Activity Allocation Plan

- Scenario: execution
- Created: 2026-09-04 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with `C:\Users\samue\Documents\GitHub\tcc` as its workspace.
2. Paste the prompt below as the first message, review the proposed implementation plan, and authorize edits only with the exact phrase required by the repository.
3. Do not grant permissions beyond the files and checks identified in the approved implementation plan.

## Prompt

```text
You are a documentation-focused frontend engineer responsible for updating an existing sprint activity plan and integrating it into the repository’s documentation.

## Workspace and materials

Work in:

`C:\Users\samue\Documents\GitHub\tcc`

Primary content sources:

- Vision: `C:\Users\samue\Documents\GitHub\tcc\visao.html`
- PRD: `C:\Users\samue\Documents\GitHub\tcc\prd.html`
- Architecture: `C:\Users\samue\Documents\GitHub\tcc\arquitetura.html`
- Existing plan used as the structural and content baseline: `C:\Users\samue\Documents\GitHub\tcc\Plano_Divisao_Atividades_Sprint_1_3_Desenvolvedores.pdf`

Required new document:

`C:\Users\samue\Documents\GitHub\tcc\Plano_Divisao_Atividades_Sprint_1.html`

Read and follow every applicable `AGENTS.md` before proposing or making changes.

## Required outcome

Create `Plano_Divisao_Atividades_Sprint_1.html` as the updated Sprint 1 activity allocation plan.

The document must:

- Reflect the current decisions documented in the vision, PRD, and architecture.
- Preserve the sprint objective exactly.
- Preserve the existing number and order of phases exactly.
- Keep exactly three developers.
- Adapt activities, responsibilities, dependencies, deliverables, and completion criteria to the current documented decisions.
- Use the same visual language as the existing application and its HTML documentation.
- Be indexed alongside the vision, PRD, and architecture documents under the label `Sprint 1`.
- Preserve the existing PDF unchanged.

## Workflow

### 1. Inspect

Inspect only the context required for this task:

1. Read the applicable `AGENTS.md`.
2. Read the existing PDF and identify:
   - The exact sprint objective.
   - The number and order of phases.
   - The three-developer structure.
   - Existing activities, responsibilities, dependencies, deliverables, and completion criteria.
3. Read `visao.html`, `prd.html`, and `arquitetura.html`.
4. Locate the existing documentation index or navigation that exposes those three documents.
5. Inspect the minimum application and documentation styles necessary to reproduce the established visual language.

Do not perform broad repository exploration.

From the updated documentation, extract only decisions that materially affect the activity allocation plan. Ground each proposed adaptation in evidence from a source file and its relevant section or heading.

Distinguish documented facts from interpretations. If evidence is insufficient, say so instead of inferring.

### 2. Reconcile

Compare the existing plan with the current vision, PRD, and architecture.

Produce a traceability analysis containing:

- The documented decision.
- Its source file and section.
- The affected phase or activity.
- The current plan content.
- The proposed adaptation.
- The reason the adaptation is required.
- Confirmation that the sprint objective, phase count, phase order, and three-developer structure remain unchanged.

Do not introduce requirements, activities, technologies, architectural decisions, or scope absent from the supplied materials.

If the vision, PRD, and architecture conflict materially, stop and report the conflict with evidence. Do not invent a resolution.

### 3. Define the visual implementation

Identify the application’s established visual patterns, including only what is relevant to the document:

- Color tokens.
- Typography.
- Spacing and layout.
- Cards, sections, badges, tables, navigation, and status treatments.
- Responsive behavior.
- Light or dark theme behavior, when already established.

Reuse existing patterns and assets where practical. Do not create a separate visual identity, add a new design system, or modify application styles.

The HTML must remain readable, navigable, and visually consistent at desktop and mobile widths.

### 4. Plan and request authorization

Before modifying or creating files, present:

- The exact sprint objective to preserve.
- The detected phase count and order.
- Confirmation that the plan has exactly three developers.
- The traceability analysis.
- The visual patterns that will be reused and their source locations.
- The exact index or navigation file that must be changed.
- The complete list of files to be created or modified.
- A section-by-section outline of the proposed HTML.
- The verification procedure and exact checks or commands to be used.

Do not modify any file until the user replies with this exact authorization:

`planejamento aprovado, pode implementar`

Responses such as “ok”, “continue”, or “looks good” do not authorize implementation.

If implementation would require a file or change not listed in the approved plan, stop and request approval for a revised plan.

### 5. Implement

After receiving the exact authorization:

- Create `Plano_Divisao_Atividades_Sprint_1.html`.
- Update only the minimum existing index or navigation file required to expose it.
- Add the document alongside the vision, PRD, and architecture entries with the visible label `Sprint 1`.
- Preserve the existing PDF unchanged.
- Preserve the sprint objective, phase count, phase order, and three-developer structure.
- Keep ownership, workloads, dependencies, sequencing, deliverables, and completion criteria internally consistent.
- Follow the repository’s existing HTML, CSS, accessibility, naming, and formatting conventions.
- Reuse existing code, styles, components, and assets before adding document-specific equivalents.
- Do not modify application styles or perform unrelated cleanup.
- Preserve unrelated user changes in a dirty worktree.

### 6. Verify

Use executable and inspectable evidence rather than relying on appearance alone.

At minimum:

- Confirm that `Plano_Divisao_Atividades_Sprint_1.html` exists at the required path.
- Run the relevant repository checks discovered during inspection.
- Open or render the document and visually inspect it at representative desktop and mobile widths.
- Verify that navigation and internal links work.
- Verify semantic heading order and basic keyboard accessibility.
- Check for overflow, clipping, overlap, unreadable contrast, broken characters, missing content, and layout regressions.
- Confirm that the sprint objective matches the PDF exactly.
- Confirm that the phase count and order match the PDF exactly.
- Confirm that exactly three developers remain.
- Confirm that every substantive adaptation is traceable to the vision, PRD, or architecture.
- Confirm that the entry is indexed as `Sprint 1`.
- Confirm that the existing PDF is unchanged.
- Confirm that only the approved new HTML and index/navigation files changed.

If a verification step fails, capture the evidence, diagnose the cause, and report it. Apply a fix only when it stays within the approved files and plan. Otherwise, stop and request authorization.

## Safety boundaries

- Ask for confirmation before destructive, irreversible, external, or out-of-scope actions.
- Do not use destructive shortcuts to make checks pass.
- Do not overwrite or delete the existing PDF.
- Do not modify source documentation or application styling.
- Do not add dependencies unless a revised plan is explicitly approved.
- Do not write outside the project.
- Never print secrets or dump complete source documents unnecessarily.
- Stop when information or authority is insufficient.

## Acceptance criteria

The task is complete only when:

1. `Plano_Divisao_Atividades_Sprint_1.html` exists at the repository root.
2. The sprint objective is unchanged from the PDF.
3. The number and order of phases are unchanged.
4. The plan assigns work to exactly three developers.
5. Activities, responsibilities, dependencies, deliverables, and completion criteria reflect the current documented decisions.
6. Every substantive adaptation has source evidence.
7. The document follows the application’s established visual language.
8. The document works at desktop and mobile widths without visual defects.
9. The existing documentation navigation exposes it as `Sprint 1`.
10. The existing PDF remains unchanged.
11. Only the approved new HTML and index/navigation files are changed.
12. All relevant verification checks pass.

## Final report

Report only:

- Files created or modified.
- The preserved sprint objective, phase count, and developer count.
- A concise summary of adaptations with source evidence.
- The visual patterns reused.
- Verification commands and results.
- Any unresolved conflict or remaining risk.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill's file template | template |
| Scenario | Controlled execution of an existing documentation update | template |
| Role | Documentation-focused frontend engineer | template |
| Working directory | `C:\Users\samue\Documents\GitHub\tcc` | user-stated |
| Current sources | `visao.html`, `prd.html`, and `arquitetura.html` at the supplied paths | user-stated |
| Reference plan | Existing PDF, preserved without modification | user-stated / approved default |
| New artifact | `Plano_Divisao_Atividades_Sprint_1.html` at the repository root | user-stated |
| Fixed invariants | Same sprint objective, same phase count and order, and exactly three developers | user-stated |
| Adaptable content | Activities, responsibilities, dependencies, deliverables, and completion criteria | approved default |
| Visual direction | Match the existing application and HTML documentation | user-stated |
| Documentation indexing | Place alongside vision, PRD, and architecture under the visible label `Sprint 1` | user-stated |
| Index file | Discover it in the repository and identify it before implementation | approved default |
| Change boundary | New HTML plus the minimum approved index or navigation file | approved default |
| Approval checkpoint | Require `planejamento aprovado, pode implementar` before editing | user-stated |
| Conflict policy | Stop and report evidence without inventing a resolution | approved default |
| Success signals | Repository checks, desktop/mobile visual inspection, content checks, and navigation checks | template |
| Failure policy | Capture evidence, diagnose, and stop when a fix exceeds the approved scope | approved default |
| Final report | Files, invariants, adaptations, evidence, visual patterns, checks, and risks | approved default |
| Safety boundaries | No PDF overwrite, source-document changes, application-style changes, new dependencies, or out-of-project writes | template |
| How-to-use: new task | Start a new Codex task in the supplied workspace | template |
| How-to-use: checkpoint | Review the plan and use the repository's exact authorization phrase | template |
| How-to-use: permissions | Grant only the narrowly required file and command permissions | template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — a labeled option explicitly chosen by the user; **template** — a standard methodology or safety clause covered by final approval; **open** — deliberately left as an unresolved question.
