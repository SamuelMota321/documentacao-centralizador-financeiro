# Prompt Calibration for Claude Code

Assembly-time rules for turning filled slots into a prompt that performs well
in a Claude Code session.

## 1. Structure and ordering

- Wrap sections in XML tags (`role`, `context`, `task`, `constraints`,
  `output_format`, `acceptance_criteria`, `verification`, plus the scenario's
  own tags). They separate instructions from materials and are reliably
  recognized.
- Long materials (code, data samples, diffs) go at the top; the actionable
  instruction goes at the end — vendor guidance converges on keeping the
  query near the end of long prompts.
- One concern per section, and no contradictions between sections — resolve
  conflicts during the interview, not inside the prompt.

## 2. Claude Code specifics

- Reference repository files with `@path/to/file` instead of pasting their
  contents when the prompt will run inside the repo; paste only materials
  that live outside it.
- For multi-file or uncertain work, open the task with an explore-and-plan
  instruction ("Explore the relevant files and propose a plan before
  implementing") and add a How-to-use line that starting in plan mode fits
  this prompt.
- Give the session an executable check and tell it to run and iterate until
  it passes; without one, "looks done" is the only signal it has.
- For verbose investigation (large searches, log analysis), have the prompt
  suggest delegating that part to a subagent, protecting the context window.
- Advise running the prompt in a fresh session (How-to-use section):
  accumulated context degrades adherence.

## 3. Language calibration

- Normal, calm imperative language. No all-caps MUST/CRITICAL/ALWAYS —
  recent Claude models overtrigger on aggressive emphasis.
- State the why for non-obvious constraints; a session that knows why a rule
  exists applies it to cases the prompt did not enumerate.
- No date-sensitive or model-version claims inside the prompt.

## 4. Epistemics kit

Standard clauses, used where the scenario file calls for them:

- Insufficient data: "If the available information is insufficient to
  conclude, say so instead of inferring."
- Review out: "It is acceptable and expected to report no findings in a
  category."
- Evidence grounding: "For each claim, cite the exact excerpt (file and
  line); if there is no supporting evidence, do not make the claim."

## 5. Agentic safety block

When the prompt drives an agentic session (always for execution, usually for
code-change):

- sequence the loop: explore, plan, execute, verify;
- include: "Ask for confirmation before destructive or irreversible actions
  (deleting files or data, force-pushing); do not use destructive shortcuts
  to make a check pass."

## 6. Optional model/effort note

Only when the user asked for it in the delivery batch: add one How-to-use
line suggesting a stronger model or higher effort for planning- or
judgment-heavy prompts, and the default model for routine execution. Keep it
generic — model aliases and effort dials change fast, so name no versions.
