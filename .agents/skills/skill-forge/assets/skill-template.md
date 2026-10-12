# Copyable SKILL.md skeleton. Replace every <placeholder>; delete sections
# that do not apply and these leading comment lines. Frontmatter uses only
# portable fields — anything else breaks upload outside Claude Code.
---
name: <skill-name>
description: >-
  <What it does — action verbs, concrete objects.> Use when <trigger
  contexts, including the words a user would actually type: file
  extensions, tool names, casual phrasings>. Not for <nearest adjacent
  tasks that should not trigger this skill>.
license: <SPDX id, e.g. Apache-2.0>
---

# <Skill Title>

<One paragraph: what this skill accomplishes and the overall approach.>

## Workflow

1. <First step — imperative voice.>
2. <Next step. For fragile or deterministic steps, give the exact command
   and say why it should not be varied.>
3. <Validation step: run the checker, fix findings, rerun until clean.>

## Output format

<Exact template if the shape matters; otherwise state what must be present
and leave the rest free. Delete if not applicable.>

**Example** — Input: <realistic input> → Output: <expected output>

## References

<One line per reference file, with its read-when trigger:>
Read [references/<topic>.md](references/<topic>.md) when <situation>.

## Scripts

<For each bundled script: execute or read?, exact invocation, dependencies:>
Run `python3 scripts/<script>.py <args>` to <purpose>. Stdlib-only.
