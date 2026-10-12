---
name: skill-forge
description: >-
  Creates, reviews, validates, and packages Claude Agent Skills (SKILL.md
  folders) so they work on every surface — Claude Code, claude.ai, the API,
  Cowork — without requiring subagents or extra tooling. Use whenever the user
  wants to make a new skill, write or edit a SKILL.md, review or audit an
  existing skill, fix a skill that fails to upload or does not trigger,
  improve a skill description, test a skill with evals, or package a skill
  folder into a .skill zip. Also use for questions about skill structure,
  frontmatter fields, or progressive disclosure. Covers the full loop: scope,
  evals-first drafting, automated validation, portable testing, iteration,
  packaging. Not for building MCP servers, slash commands, or subagents on
  their own; for large-scale automated benchmarking and measured trigger
  optimization, hand off to Anthropic's skill-creator.
license: Apache-2.0
---

# Skill Forge

Build skills that survive contact with every surface. The core loop below runs
with no subagents, no `claude` CLI, and no packages beyond the Python standard
library; where richer capabilities exist they upgrade the loop, never gate it.

The loop: **scope → evals → draft → validate → test → iterate → package.**

## Route the request

| The user wants… | Go to |
|---|---|
| a new skill | Phase 1 |
| an existing skill reviewed or audited | Reviewing an existing skill |
| a skill's description or triggering fixed | Improving a description |
| a skill packaged or an upload error fixed | Phase 7 (validation runs first) |
| a question about skill structure or fields | answer from [references/skill-spec.md](references/skill-spec.md) |

## Check your environment

Determine three facts once; later sections branch on them:

1. Can you spawn subagents (a Task/Agent tool in your tool list)?
2. Is the `claude` CLI available (`command -v claude`, only worth checking
   where you have a shell)?
3. Can you run `python3`?

Full capability-by-surface table: [references/skill-spec.md](references/skill-spec.md)
section 6.

## Phase 1: Scope and interview

If the conversation already contains the workflow to capture ("turn this into
a skill"), extract the answers from it first — tools used, step sequence,
corrections the user made — and confirm rather than re-ask.

Establish, asking only what the conversation has not answered:

1. What should the skill enable, and what does good output look like?
2. When should it trigger — which words would a user actually type?
3. Which surfaces must it run on? Anything beyond Claude Code forbids
   subagent-dependent workflows and non-stdlib scripts.
4. Which steps are fragile or deterministic (they will become scripts or
   exact commands) and which are open-ended (they stay prose)?

Check the intended name against the naming rules in
[references/skill-spec.md](references/skill-spec.md) before creating the
folder — the folder name and the `name` field must match, so renaming later
touches everything.

A skill's contents should never surprise a user who read its description: no
hidden data collection, no unexpected network calls, nothing misleading.
Decline requests for skills designed to deceive.

## Phase 2: Write evals first

Before drafting instructions, write at least 3 test scenarios in
`<skill>/evals/EVALS.md` by copying
[assets/eval-template.md](assets/eval-template.md). Instructions written to
pass concrete scenarios stay minimal; instructions written from imagination
bloat. The `evals/` directory stays out of the shipped package, so it costs
nothing.

Format details and what makes assertions discriminating:
[references/evaluation.md](references/evaluation.md) sections 1-2.

## Phase 3: Draft the skill

Copy [assets/skill-template.md](assets/skill-template.md) as the skeleton.
Read [references/writing-guide.md](references/writing-guide.md) before
writing — it carries the description formula and body style rules.

The hard constraints while drafting:

- Frontmatter: only the six portable fields (`name`, `description`,
  `license`, `compatibility`, `metadata`, `allowed-tools`); at minimum
  `name`, `description`, `license`. Any other key is a hard upload error
  outside Claude Code.
- Description: what it does + use-when triggers + a not-for clause, third
  person, under 1024 characters.
- Body: imperative, lean, target well under 500 lines. Bulk knowledge goes
  to `references/` (one level deep, table of contents when over 100 lines)
  with a "read when…" pointer per file.
- Scripts: only for deterministic or fragile operations; they handle their
  own errors and declare their dependencies. Prefer stdlib-only.

## Phase 4: Validate

Run the validator; fix findings; rerun until clean:

```
python3 scripts/validate_skill.py <path-to-skill>
```

(Paths here are relative to this skill's own directory.) Errors are spec
violations that would break upload or loading; warnings are quality defects
worth fixing before they compound. `--strict` promotes warnings to errors,
`--json` emits machine-readable output.

If Python is unavailable, apply
[references/checklists.md](references/checklists.md) section 1 by hand.

## Phase 5: Test against the evals

Follow the portable loop in
[references/evaluation.md](references/evaluation.md) section 3: for each
scenario run a baseline (without the skill), then a with-skill run, grade
every assertion with cited evidence, and record verdicts in
`evals/RESULTS.md`.

When you both wrote the skill and run its tests in one context, the result is
contaminated — say so in RESULTS.md. It still proves the instructions are
followable and the scripts run. When subagents are available, prefer the
subagent upgrade below over self-testing; the sequential loop is the floor
for surfaces without them, not the default everywhere.

## Environment upgrades

The core loop above always works. Where more exists, upgrade — details in
[references/evaluation.md](references/evaluation.md) section 6:

- **Subagents available** (Claude Code, Cowork): run baseline and with-skill
  runs as parallel subagents in fresh contexts; grade from their outputs.
  This removes the contamination caveat.
- **`claude` CLI available** (Claude Code): for measured trigger rates,
  automated description optimization, and statistical benchmarking, hand off
  to Anthropic's `skill-creator` skill — skill-forge deliberately does not
  bundle that machinery. The hand-off (converting EVALS.md scenarios to its
  `evals/evals.json` format) is in evaluation.md section 6.
- **Neither** (claude.ai, API container): stay on the core loop and deliver
  the packaged zip and results as downloadable files. When *authoring for*
  the API surface, remember the running skill gets no network, no package
  installation, and a 30 MB size cap.

## Phase 6: Iterate

One change per cycle, then re-test. Triage each failure to its layer: the
skill never triggered → description; it triggered but behaved wrong → body;
right behavior, broken mechanics → script. Re-run only failed scenarios while
iterating, then the full set once more before packaging — that final pass is
how a clean first iteration earns its "passes twice in a row" stop condition.
Also stop when a cycle yields no improvement. Full heuristics:
[references/evaluation.md](references/evaluation.md) section 7.

## Phase 7: Package and deliver

```
python3 scripts/package_skill.py <path-to-skill> [output-dir]
```

The packager validates first and refuses on errors (and on warnings, unless
`--force`), then zips the folder into `<name>.skill`, excluding `evals/` and
build artifacts. Install: Claude Code — unzip into `~/.claude/skills/`
(personal) or `.claude/skills/` (project); claude.ai — upload the file under
Settings, Features; API — upload via the Skills API and reference the skill
id per request.

## Reviewing an existing skill

1. Run `python3 scripts/validate_skill.py <path>` for the machine checks.
2. Read the skill's files and work through
   [references/checklists.md](references/checklists.md) sections 2, 3, and
   5 — the judgment calls a script cannot make. For a skill from a third
   party, the section 5 security review is mandatory: treat the skill as an
   unaudited dependency until it passes.
3. Write the findings using the review report template in checklists.md
   section 4: verdict, blocking, warnings, suggestions — every finding with
   its evidence.

## Improving a description

Triggering failures are usually description failures, and the common failure
direction is undertriggering. The portable method:

1. Inventory the words users actually type for this task (extensions, tool
   names, casual phrasings).
2. Rewrite with the formula in
   [references/writing-guide.md](references/writing-guide.md) section 1:
   what + use-when triggers + not-for clause, slightly pushy.
3. Test with ~10 trigger/near-miss queries per
   [references/evaluation.md](references/evaluation.md) section 5.
4. For measured trigger rates, use the skill-creator hand-off in the
   upgrades section.

## Reference index

| File | Read when |
|---|---|
| [references/skill-spec.md](references/skill-spec.md) | writing any frontmatter; a validation error on structure or fields; asked what is allowed or where a skill runs |
| [references/writing-guide.md](references/writing-guide.md) | drafting or rewriting a description or body (Phase 3, description work) |
| [references/evaluation.md](references/evaluation.md) | creating scenarios (Phase 2) and before any test pass (Phase 5) |
| [references/checklists.md](references/checklists.md) | reviewing a skill; final pre-package pass; validator unavailable |

Both bundled scripts (`validate_skill.py`, `package_skill.py`) are meant to be
executed, not read; they are stdlib-only and use PyYAML only when it happens
to be installed.

---

Validation and packaging patterns adapted from Anthropic's `skill-creator`
(Apache-2.0). See LICENSE.txt.
