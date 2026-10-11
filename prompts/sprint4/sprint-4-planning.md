# Prompt: Sprint 4 Planning Documentation

- Scenario: code-change (documentation-only)
- Created: 2026-10-11 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the finance documentation repository as its workspace. Verify the workspace root before editing.
2. Start in Plan mode. Review the proposed scope and file list, then authorize writing with the exact phrase required by the applicable `AGENTS.md`: `planejamento aprovado, pode implementar`.
3. Paste the prompt below as the first message.

## Prompt

```
# Sprint 4 Planning Documentation

<Role>
Act as a technical documentation engineer working in an existing project repository.
</Role>

<Context>
Use the current workspace. Before any edit, verify that its root is the finance documentation repository intended for this task. If you cannot verify the repository, stop and ask.

Use this repository as the source of truth. Follow its applicable AGENTS.md instructions, including any required approval phrase. Do not assume that the directory name alone proves the repository identity.
</Context>

<Goal>
Create or update the Sprint 4 planning documentation so it follows the repository’s current documentation conventions. Document the sprint plan only; do not implement its deliverables.
</Goal>

<Constraints>
- Inspect the documentation inventory, indexes, and the relevant roadmap, backlog, and prior sprint documents. Read additional files only when needed to establish Sprint 4 scope or the existing documentation pattern.
- Match the established location, naming, language, structure, terminology, and level of detail. Do not introduce a new documentation format or reorganize unrelated documentation.
- Base every Sprint 4 deliverable on evidence in this repository. Cite the source file and heading or line where practical. If the scope is missing, ambiguous, or conflicting, stop before editing and ask for clarification; do not invent deliverables.
- Preserve unrelated user changes. Do not modify implementation code, tests, configuration, dependencies, or documentation unrelated to Sprint 4.
- Do not delete or rename existing files. Ask before any destructive or irreversible action.
- If applicable instructions require approval before writing, present the proposed plan and exact file list, then wait for the required authorization. In this workspace, the required phrase is `planejamento aprovado, pode implementar`.
</Constraints>

<Workflow>
1. Verify the workspace repository and read its applicable AGENTS.md instructions.
2. Identify the documentation pattern using the most relevant prior sprint documents and indexes. Record the evidence that establishes the pattern.
3. Find Sprint 4 scope in the repository’s roadmap, backlog, or other authoritative project documentation. If evidence is insufficient or sources conflict, stop and ask instead of drafting a speculative plan.
4. Present a concise plan listing the proposed Sprint 4 document path, the source evidence for its scope, the sections or structure to follow, and the validation method. Wait for the approval required by AGENTS.md before editing.
5. After approval, create or update only the approved Sprint 4 planning documentation. If the established pattern requires additional files beyond the approved list, stop and request approval for the revised file list.
6. Verify the result against the acceptance criteria and report the evidence.
</Workflow>

<Acceptance Criteria>
- The Sprint 4 planning document is in the location and format supported by the repository’s existing conventions.
- Each stated deliverable is traceable to repository evidence; unresolved or conflicting scope is surfaced rather than guessed.
- No Sprint 4 implementation work or unrelated changes are included.
- Internal links and references added by the change resolve correctly.
- Relevant documentation validation is run and its result is reported.
</Acceptance Criteria>

<Verification>
Discover whether the repository defines a documentation validation command and run the relevant check. If no such check exists, run `git diff --check` and manually review Markdown structure, added links, and consistency with the comparable sprint documents. Do not change tests or unrelated files to make validation pass.
</Verification>

<Final Report>
Report the workspace verified, files created or changed, documentation-pattern evidence, sources supporting Sprint 4 scope, validation performed and results, and any unresolved questions or limitations. Include a suggested commit message.
</Final Report>

Begin by verifying the current workspace and inspecting the relevant repository documentation. Do not write any files until the required approval has been given.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the “paste the prompt” step come from the skill’s file template | template |
| Scenario | Existing-repository change workflow adapted for a documentation-only task | template |
| Goal | Create or update Sprint 4 planning documentation that follows the repository’s current documentation conventions | user-stated |
| Deliverable boundary | Document the Sprint 4 plan without implementing its deliverables | approved default |
| Scope source | Locate scope in the repository roadmap, backlog, or documentation; stop and ask if evidence is missing or conflicting | approved default |
| Workspace | Use the open workspace and verify it is the intended documentation repository before editing | approved default |
| Documentation pattern | Inspect current documentation and follow its conventions | user-stated |
| Prompt file path | `prompts/sprint4/sprint-4-planning.md` | user-stated |
| Approval gate | Follow applicable `AGENTS.md` instructions and use the exact required phrase | user-stated |
| Verification | Discover the repository’s documentation check; otherwise use `git diff --check` and a manual review | template |
| Role and final report | Documentation role and concise evidence-based report | template |
| How-to-use workspace | Start a new task with the documentation repository as the workspace | template |
| How-to-use Plan mode | Review the proposed plan before authorizing writes | template |
| Prompt language | English, as required by the skill | template |

Source legend: **user-stated** — directly stated in the request or answers; **approved default** — a recommended option the user selected; **template** — standard structure or safety clause from the skill; **open** — deliberately left as [OPEN: question].

