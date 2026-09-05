# Prompt Calibration for Codex

Assembly-time rules for turning filled slots into a prompt that performs well
in a Codex workspace task.

## 1. Structure and ordering

- Lead with the outcome the user needs. Use short Markdown sections for
  context, task, constraints, output, acceptance criteria, and verification;
  include only sections that improve the task.
- Refer to repository files by path in backticks instead of pasting their
  contents. Paste only material that does not already exist in the workspace.
- Keep one concern per section and resolve conflicting instructions during
  the interview rather than carrying contradictions into the prompt.
- Include relevant `AGENTS.md` instructions by reference. Do not copy them
  into the prompt or imply that the prompt overrides them.

## 2. Codex workspace specifics

- For multi-file or uncertain work, ask Codex to inspect the minimum relevant
  context and propose a short plan before editing. For a small localized
  change, omit a separate planning phase.
- A prompt cannot change the app's collaboration mode. When Plan mode would
  help, put that recommendation in How to use and tell the user to review the
  plan before switching modes or authorizing implementation.
- Give Codex an executable check and ask it to iterate only within the
  authorized scope. If no command is known, instruct it to discover the
  relevant repository check and report it before running or changing tests.
- Preserve sandbox and approval boundaries. Repository inspection, prompt
  approval, and implementation authorization are distinct; an `AGENTS.md`
  file may require an exact approval phrase.
- Recommend a new task when stale context could bias an audit or materially
  confuse scope. Do not require a fresh task for routine follow-up work.
- Do not assume subagents, plugins, connectors, internet access, or an
  unattended environment. Mention one only when the user selected it and the
  target Codex environment supports it.

## 3. Language calibration

- Use calm, direct language. Avoid unnecessary all-caps emphasis.
- Explain non-obvious constraints when the reason changes how Codex should
  apply them.
- Do not include date-sensitive model or product-version claims.

## 4. Epistemics kit

Standard clauses, used where the scenario file calls for them:

- Insufficient data: "If the available information is insufficient to
  conclude, say so instead of inferring."
- Review out: "It is acceptable and expected to report no findings in a
  category."
- Evidence grounding: "For each claim, cite the exact excerpt (file and
  line); if there is no supporting evidence, do not make the claim."

## 5. Agentic safety block

When the prompt authorizes edits or command execution:

- sequence the work as inspect, plan when warranted, execute, verify;
- require confirmation before destructive, irreversible, external, or
  out-of-scope actions;
- forbid destructive shortcuts used only to make a check pass;
- require Codex to preserve unrelated user changes in a dirty worktree;
- define a stopping condition for repeated failures or missing authority.

## 6. Optional environment note

Only when the user supplied it, add a How-to-use line for Plan mode,
non-interactive execution, internet access, connectors, or allowed commands.
State permissions narrowly; never recommend blanket approval or bypassing the
sandbox.
