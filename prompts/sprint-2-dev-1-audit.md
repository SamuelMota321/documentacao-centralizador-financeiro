# Prompt: Sprint 2 Dev 1 Implementation and Documentation Audit

- Scenario: audit
- Created: 2026-09-26 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the current documentation repository as its workspace, and make the implementation repositories referenced in the documentation available for inspection.
2. Use a fresh task so the audit is conducted with independent context.
3. Paste the prompt below as the first message.

## Prompt

```
# Sprint 2 Dev 1 Implementation and Documentation Audit

## Role

Act as an independent senior code and documentation auditor.

## Context and material

Audit the work attributed to Dev 1 in Sprint 2. Use the related project documentation in the current documentation repository to identify the sprint scope, Dev 1's assigned work, the approved planning items, acceptance criteria, and references to implementation repositories or changes.

Inspect only the implementation repositories and artifacts that the documentation identifies and that are available in the workspace. Use repository history to corroborate documented references when useful; do not infer ownership from authorship or timing alone.

Read and follow the applicable \`AGENTS.md\` files before acting. Treat documented approvals and acceptance criteria as evidence of the approved plan. If the documents conflict or do not establish the plan, ownership, or complete review scope, report that limitation and do not silently guess.

## Audit scope

For every approved planning item attributed to Dev 1 in Sprint 2:

- Determine whether the implementation is complete and conforms to the approved plan and acceptance criteria.
- Check whether related documentation is consistent internally and with the implementation.
- Identify relevant correctness, security, or quality issues that prevent the approved work from being considered complete or compliant.

Do not report style preferences or formatting choices as findings. No additional exclusions have been specified.

## Method

1. Locate and cite the documentation that establishes the Sprint 2 scope, Dev 1's assignments, approvals, and acceptance criteria.
2. Build an inventory of every verifiable approved planning item in scope. Map each item to its documented implementation references and inspect the corresponding code.
3. Compare the implementation and related documentation against each item. Record contradictions, missing evidence, and items whose ownership or approval cannot be verified.
4. Run the narrowest relevant existing checks, tests, or static checks that have no destructive or external side effects. Do not add or modify tests. Ask before running a check with meaningful side effects. Report each command and its result; never claim a check passed unless it ran successfully.
5. Do not edit source code, tests, existing documentation, configuration, or data. Do not apply fixes.

## Evidence and findings

Ground every conclusion in evidence. Cite exact file paths and line numbers, and include short excerpts from the approved planning source and implementation or documentation being assessed. If evidence is missing, say so instead of inferring.

For each finding, report:

- Severity: use a scale documented by the project. If none is documented, use Critical / High / Medium / Low and label it explicitly as an audit convention.
- The affected approved planning item or acceptance criterion.
- Evidence locations and relevant excerpts.
- The implementation or documentation gap and its impact.
- A suggested correction, without applying it.

No findings in a category is an acceptable result.

## Deliverables

Prepare a Markdown audit report in the documentation repository, following its existing report-location convention. If no convention is clear, propose a path and ask before choosing one.

Include:

1. An executive summary and review limitations.
2. A traceability matrix with one row per approved planning item, its acceptance criteria, implementation and documentation evidence, and status: Implemented, Partial, Not implemented, or Cannot verify.
3. Findings with evidence and suggested corrections.
4. Relevant check commands and their results.

First complete the audit read-only and present the report content and proposed file path in chat. Follow the applicable \`AGENTS.md\` approval gate before writing the report file, including any exact authorization it requires. Then save the approved report as Markdown. Do not modify any other files.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Scenario | Audit of code and documentation | template |
| Role | Independent senior code and documentation auditor | template |
| Material | Dev 1's Sprint 2 work, identified through related documentation | user-stated |
| Audit scope | Verify implementation completeness and conformance to approved planning; check documentation consistency | user-stated |
| Additional exclusions | None specified | user-stated |
| Style and formatting preferences | Do not report as findings | template |
| Severity | Use the documented scale; if absent, use Critical / High / Medium / Low and label it as an audit convention | approved default |
| Audit report destination | Markdown report in the documentation repository | user-stated |
| Workspace | New task in the documentation repository with referenced implementation repositories available | approved default |
| Independent review context | Use a fresh task for the audit | template |
| Prompt file path | \`prompts/sprint-2-dev-1-audit.md\` | approved default |
| Evidence and findings | Cite exact evidence; reporting no findings is acceptable | template |
| Verification | Run relevant existing checks with no destructive or external side effects; do not modify tests | template |
| Report writing gate | Follow applicable \`AGENTS.md\` approval requirements before writing the report | template |
