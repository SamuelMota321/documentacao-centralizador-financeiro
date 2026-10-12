# Writing Skills That Work

How to write the description (the triggering surface) and the body (the
instructions). Source classes as in [skill-spec.md](skill-spec.md).

## Contents

1. [Description engineering](#1-description-engineering)
2. [Body style](#2-body-style)
3. [Degrees of freedom](#3-degrees-of-freedom)
4. [Structural patterns](#4-structural-patterns)
5. [Scripts inside skills](#5-scripts-inside-skills)
6. [Anti-pattern quick list](#6-anti-pattern-quick-list)

## 1. Description engineering

The description is the only thing Claude sees when deciding whether to load the
skill, and the documented failure mode is **undertriggering** — skills not used
when they would help. Write for recall first, then carve out precision.
[official rec]

The formula:

```
<What it does — action verbs, concrete objects>
Use when <trigger contexts, including the words a user would actually type>.
Not for <adjacent tasks that should NOT trigger it>.
```

Guidelines, all [official rec] unless noted:

- **Third person.** The description is injected into a system prompt;
  inconsistent point of view hurts discovery. Verb-first action phrasing
  ("Extracts text…", as in official examples) is fine; first or second
  person ("I can…", "helps you…") is not.
- **Include the terms users type**: file extensions (".xlsx"), tool names,
  casual phrasings — not just your own vocabulary for the domain.
- **Be slightly pushy.** Cover contexts where the user needs the skill but
  does not name it. A description that only matches exact naming undertriggers.
- **All triggering information goes here**, never in the body — by the time
  the body loads, triggering already happened.
- **Add a not-for clause** naming the nearest tasks that belong elsewhere.
  [observed in production skills] This is the cheap way to buy precision
  without sacrificing recall.
- Simple one-step tasks may not trigger any skill even with a perfect
  description — Claude only consults skills for tasks it cannot trivially
  handle. Do not fight this by inflating the description.

Worked example:

- Weak: `Helps with spreadsheets.`
- Strong: `Analyzes Excel spreadsheets, creates pivot tables, generates
  charts. Use when analyzing Excel files, spreadsheets, tabular data, or
  .xlsx files. Not for CSV-to-database pipelines or Google Sheets API work.`

To evaluate a description without any tooling, see the trigger-query method in
[evaluation.md](evaluation.md) section 5.

## 2. Body style

All [official rec]:

- **Imperative voice**, addressed to the model doing the task: "Run the
  validator", not "The validator can be run".
- **Explain why, don't shout.** If you catch yourself writing ALWAYS or NEVER
  in all caps, that is a yellow flag: the instruction is either overfit to one
  bad run or missing its rationale. A model that understands why a rule exists
  applies it to cases you did not enumerate.
- **Only add context Claude lacks.** No general programming advice, no
  explanations of common formats. Every line costs context for every task the
  skill triggers on.
- **One default with an escape hatch.** "Use pdfplumber; if it fails on
  scanned pages, fall back to OCR" beats a menu of three equivalent options —
  menus force a decision the skill was supposed to make.
- **Consistent terminology.** Pick one term per concept (eval, not
  eval/test/check interchangeably) and keep it.
- **No date-sensitive claims.** "Currently X is true" rots. State behavior as
  observable ("if X happens, do Y"); if you must document a change, use an
  "old pattern / new pattern" section.

## 3. Degrees of freedom

Match instruction form to how fragile the operation is [official rec]:

| Fragility | Freedom | Form | Example |
|---|---|---|---|
| Open task, many valid approaches | high | prose goals and heuristics | "Interview the user about edge cases" |
| Preferred pattern, some variation OK | medium | pseudocode or a parameterized template | an output-format skeleton |
| Deterministic, easy to get wrong | low | exact script or exact command, with "do not vary this" and the reason | `python3 scripts/validate_skill.py <dir>` |

Giving high freedom to a fragile step produces inconsistent output; giving low
freedom to an open step produces overfit, brittle behavior.

## 4. Structural patterns

All [official rec]:

- **Workflow checklists**: number multi-step processes so progress is
  trackable and steps are not silently skipped.
- **Output-format templates**: when output shape matters, show the exact
  skeleton; when it is flexible, say what must be present and leave the rest.
- **Paired input/output examples**: one concrete before/after teaches more
  than a paragraph of rules.
- **Feedback loops**: for any step with a checker (validator, linter, test),
  instruct: run checker → fix findings → rerun until clean. Deterministic
  checkers beat prose exhortations.

## 5. Scripts inside skills

All [official rec]:

- Bundle a script when the operation is deterministic, repetitive, or fragile
  — code is cheaper, faster, and more reliable than generated tokens for
  sorting, validation, packaging, format conversion.
- **Solve, don't defer**: the script handles its own errors and edge cases
  and exits nonzero with a clear message. A script that half-works and asks
  the model to figure out the rest is worse than no script.
- No unexplained constants; name them or comment the reason.
- **Declare every dependency** beyond the standard library — in the body and
  in `compatibility` — and prefer stdlib-only: the API container cannot
  install packages at runtime.
- Say explicitly whether each script is meant to be **executed** or **read**.
- Name MCP tools fully qualified (`ServerName:tool_name`), and say what to
  do when that server is not connected — never assume it is.
- Forward slashes in all paths.

## 6. Anti-pattern quick list

Vague description · body over 500 lines · references nested deeper than one
level · triggering info in the body · fragile scripts that defer errors ·
Windows-style paths · menus of equivalent options · all-caps MUSTs without
rationale · non-portable frontmatter fields in an exported skill · undeclared
dependencies. Details and fixes: [checklists.md](checklists.md) section 3.
