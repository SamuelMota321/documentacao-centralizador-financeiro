---
name: codex-prompt-forge
description: >-
  Builds specialized, research-backed prompts for Codex workspace tasks through a
  structured user interview. Classifies the task into one of five scenarios —
  new development, data science and analysis, code change (bugfix, refactor,
  legacy), audit or review of code and data, or executing an existing project
  or pipeline — then asks targeted questions until every slot of the
  scenario's prompt template is filled by the user, never inferring missing
  details, and delivers a ready-to-paste English prompt as a markdown file
  plus a chat block. Use when the user asks to build, craft, write, engineer,
  or improve a prompt for a coding or data task, wants a "prompt for" such
  work, or wants to prepare instructions or a spec for a Codex task. Not for creating
  Agent Skills (use skill-creator), writing AGENTS.md or settings configuration,
  prompts targeting other models or general-purpose chatbot use, or performing
  the underlying coding or data task itself.
license: MIT
---

# Codex Prompt Forge

Turns a rough request into a precise, scenario-calibrated prompt for a Codex
task. The user is the single source of truth: every concrete fact in
the delivered prompt traces to a user answer or a user-approved default —
nothing is invented on the user's behalf. The interview runs in the user's
language; the delivered prompt is always English.

## The never-infer rule

Concrete facts — paths, commands, stack, data columns, metrics, constraints,
edge cases, names, numbers — enter the prompt only from (a) the user's request
or interview answers, or (b) an option the user explicitly approved. When the
user cannot answer, present 2–4 research-backed options with one labeled
default and let the user choose; record the choice as an approved default. A
useful default shape is delegation: "instruct the session to discover X from
the repository and confirm it before proceeding". If the user wants a slot
left unanswered, write `[OPEN: question]` into the prompt and note it.
Standard methodology clauses that come from the scenario skeleton (safety
nets, assumption checks, epistemics) are not user facts; disclose them in the
decision record as `template` and cover them with the final approval step.

## Workflow

1. **Extract, then classify.** Mine every fact already present in the user's
   request — confirm interpretations, never re-ask stated facts. Match the
   task to one scenario: `development`, `data-science`, `code-change`,
   `audit`, or `execution`. If it straddles two, ask which.
2. **Load the scenario reference** (table below). It holds the risk profile,
   the required slots with question bank and defaults, the prompt skeleton,
   and the scenario's standard clauses.
3. **Interview** following
   [references/interview-protocol.md](references/interview-protocol.md):
   thematic batches via a structured user-input tool when available (numbered
   questions in chat otherwise), in the user's language, until every required
   slot has a provenance label.
4. **Assemble** the English prompt from the scenario skeleton, applying
   [references/codex-prompt-calibration.md](references/codex-prompt-calibration.md)
   for structure, ordering, and Codex-specific boundaries.
5. **Run the quality gate** below; fix failures before showing the prompt.
6. **Approve and deliver.** Show the full prompt and the decision record; ask
   for approval or adjustments; loop until approved. Then save the file using
   [assets/prompt-file-template.md](assets/prompt-file-template.md) to
   `prompts/{task-slug}.md` under the working directory (or the path the user
   chose) and show the final prompt in chat.

## Quality gate

Check the assembled prompt against each item; fix, don't rationalize:

1. Role stated in one sentence.
2. Long materials at the top; the actionable instruction at the end.
3. Task steps sequential and unambiguous.
4. Constraints explicit, including the scenario's risk clause (minimal scope
   and anti-hardcoding, anti-leakage, test-editing ban, or findings-only —
   whichever the scenario file prescribes).
5. Output format says what to produce, not only what to avoid.
6. Acceptance criteria verifiable, with at least one executable check the
   session can run itself.
7. Epistemics present where the scenario calls for it ("say so if the data is
   insufficient", "no findings is acceptable").
8. If the prompt drives an agentic session: explore, plan, execute, verify —
   and confirmation required before destructive or irreversible actions.
9. Calm, direct language without unnecessary all-caps emphasis.
10. Rigidity matches the scenario's risk profile.
11. Every concrete fact carries provenance in the decision record.
12. The prompt is entirely in English.

## Scenario references

Read exactly one per run, right after classification:

| Scenario | Read |
|---|---|
| New code, features, greenfield work | [references/scenario-development.md](references/scenario-development.md) |
| EDA, statistics, feature engineering, modeling, evaluation | [references/scenario-data-science.md](references/scenario-data-science.md) |
| Bugfix, refactoring, legacy changes | [references/scenario-code-change.md](references/scenario-code-change.md) |
| Review of code, security, performance, data quality | [references/scenario-audit.md](references/scenario-audit.md) |
| Running an existing project, pipeline, or operational task | [references/scenario-execution.md](references/scenario-execution.md) |

Also read [references/interview-protocol.md](references/interview-protocol.md)
before the first interview batch, and
[references/codex-prompt-calibration.md](references/codex-prompt-calibration.md)
before assembling.

## Output

Deliver both, in this order: the saved markdown file (header, how-to-use
section, the prompt in a fenced block, decision record table — the shape is
[assets/prompt-file-template.md](assets/prompt-file-template.md)), then the
prompt shown in chat. The decision record maps every slot to `user-stated`,
`approved default`, `template`, or `open` — it is the audit trail proving
nothing was inferred. The record covers the whole deliverable, not only the
prompt block: the role line and each variable How-to-use line (new task,
Plan mode, checkpoint, or non-interactive permissions) get their own rows, normally
`template`; the file's fixed scaffolding (header metadata and the "paste the
prompt" step) is covered by the standing boilerplate row that ships
pre-filled in the file template. Nothing in the file may lack provenance.

Before saving, read the applicable `AGENTS.md` files. Prompt-content approval
does not override a repository's required authorization phrase or filesystem
boundaries; obtain any additional approval those instructions require.
