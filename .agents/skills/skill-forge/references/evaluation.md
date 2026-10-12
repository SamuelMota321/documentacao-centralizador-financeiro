# Testing and Iterating on a Skill

The eval-first method, the portable test loop that works on every surface, and
the upgrades available where subagents or the `claude` CLI exist.

## Contents

1. [Why evals come before documentation](#1-why-evals-come-before-documentation)
2. [EVALS.md format](#2-evalsmd-format)
3. [The portable test loop](#3-the-portable-test-loop)
4. [Grading and RESULTS.md](#4-grading-and-resultsmd)
5. [Testing the description (trigger queries)](#5-testing-the-description-trigger-queries)
6. [Environment upgrades and hand-off](#6-environment-upgrades-and-hand-off)
7. [Iteration heuristics](#7-iteration-heuristics)

## 1. Why evals come before documentation

Write test scenarios before writing extensive instructions [official rec].
Instructions written to make concrete scenarios pass stay minimal; instructions
written from imagination accumulate speculative advice that costs context and
may never be exercised. The loop: identify what the model gets wrong without
the skill → encode those gaps as scenarios → write just enough instruction to
pass them → iterate.

At least **3 scenarios** [official rec]; prefer 5 when the output is
objectively verifiable [observed]. Include at least one negative or
edge-case scenario — an input the skill should refuse, hand off, or survive
(malformed file, empty input, out-of-scope request); a suite of happy paths
overstates quality. Skills with objectively verifiable outputs (file
transforms, data extraction, fixed workflows) benefit most from evals;
purely subjective skills (writing style) are better judged by a human review
pass — do not force assertions onto matters of taste.

The baseline is also the ship gate: benchmark studies find many skills add
nothing over a capable model working bare, and a few degrade it while
charging context for the privilege. If the with-skill runs do not clearly
beat the baseline, shrink the skill or do not ship it — and prefer a focused
skill (roughly three modules or fewer) over an exhaustive bundle.

## 2. EVALS.md format

Keep evals in `<skill>/evals/EVALS.md` (the packager excludes `evals/` from
the shipped skill). Copy [assets/eval-template.md](../assets/eval-template.md)
to start. Per scenario:

```markdown
## Scenario 1: <descriptive-name>
- **Prompt**: the task exactly as a real user would type it — concrete,
  with file names and context, not an abstract label.
- **Expected behavior**: what a good run looks like, in one or two sentences.
- **Assertions**: 2-5 checkable statements. Each must be verifiable from the
  run's observable results — output files, exit codes, resulting state
  ("the output file parses as valid YAML", "no commit was created") — not
  vibes ("the output is good").
- **Notes**: input files needed, environment assumptions.
```

Good assertions discriminate: an assertion that would also pass for a wrong
output measures nothing. Prefer "the generated frontmatter contains only
portable fields" over "a SKILL.md file exists".

## 3. The portable test loop

This loop needs no subagents and no CLI — it works on every surface.

For each scenario, in order:

1. **Baseline run** (first iteration only): perform the scenario's prompt
   *without* consulting the skill, in as fresh a context as the surface
   allows. Record what went wrong; those gaps are what the skill must fix.
2. **With-skill run**: follow the skill's own instructions to perform the
   same prompt, as a user session would.
3. **Grade** each assertion (section 4) and record the result.

Honesty caveat — record it in RESULTS.md: when the same context that wrote
the skill also runs the test, the result is contaminated (the tester already
knows the intent). Sequential self-testing is a smoke test — it proves the
instructions are followable and the scripts run — not a benchmark. Where
subagents exist, use the upgrade in section 6 for uncontaminated runs.

## 4. Grading and RESULTS.md

Grading philosophy (adapted from Anthropic's skill-creator grader, which gets
this right):

- **Substance over surface**: an assertion passes only if the content is
  genuinely correct, not because a file with the right name exists.
- **Outcome, not path**: grade what the run produced, not which route
  produced it — unless the procedure is itself the skill's promise.
  Trajectory reading is an iteration tool (section 7), not a grading
  criterion.
- **Burden of proof on the assertion**: unclear or unverifiable → FAIL, with
  a note. No partial credit.
- **Evidence required**: every verdict cites one line of evidence (a quoted
  output fragment, an exit code, a file path that exists).
- **Critique the evals too**: if grading reveals an assertion that any wrong
  output would also pass, fix the eval — a passing grade on a weak assertion
  creates false confidence.

Record results in `evals/RESULTS.md`:

```markdown
# Results — iteration <N> (<date>)
Mode: sequential self-test | subagent runs    Contamination caveat: yes/no

| Scenario | Assertion | Verdict | Evidence |
|---|---|---|---|
| 1 create-basic | frontmatter has only portable fields | PASS | validator exit 0 |
```

## 5. Testing the description (trigger queries)

Fully portable heuristic method — no tooling required:

1. Write ~10 realistic queries: half **should-trigger** (varied phrasings,
   including ones that never name the skill or file type), half
   **should-NOT-trigger**. The valuable negatives are *near-misses* — queries
   sharing keywords with the skill but needing something else. "Write a
   fibonacci function" as a negative for a PDF skill tests nothing.
2. Make queries concrete: file paths, typos, casual phrasing, backstory —
   the way users actually type.
3. For each query, judge against the description alone (not the body): would
   a model holding only name + description load this skill? Borderline calls
   are description defects: missing trigger terms (recall) or a missing
   not-for clause (precision).
4. Fix the description, not the queries; re-judge.

This role-play judgment is a heuristic, not a measurement — real triggering is
stochastic and depends on the full skill roster. For measured trigger rates,
use the automated loop via the hand-off in section 6.

Optional depth: official guidance recommends testing skills across model
tiers (Haiku, Sonnet, Opus) — smaller models need more explicit instructions;
if the skill must serve them, run the loop per model where you can choose one.

## 6. Environment upgrades and hand-off

**If subagents are available** (Claude Code, Cowork): run step 1 and step 2 of
the loop as parallel subagent tasks — one baseline agent (no skill mentioned)
and one with-skill agent per scenario, each writing outputs to its own
directory. Grade from their outputs and transcripts. This removes the
contamination caveat and adds wall-clock parallelism.

**If the `claude` CLI is available** (Claude Code): skill-forge deliberately
does not bundle an automated benchmark runner or description optimizer —
recreating them exceeds what bundled scripts can safely carry. Anthropic's
native `skill-creator` skill ships both: a benchmark pipeline
(`evals/evals.json` format, parallel runs, `aggregate_benchmark`) and a
description-optimization loop (`run_loop.py`: measured trigger rates via
`claude -p`, train/test split, up to 5 iterations). To hand off, convert each
EVALS.md scenario into its `evals/evals.json` shape — `id`, `prompt`,
`expected_output`, `files`, and your assertions as `expectations` strings —
then follow that skill's instructions. This is a declared optional
dependency, not a requirement: everything in sections 1-5 works without it.

**If neither exists** (claude.ai, API container): stay on the portable loop;
deliver results and the packaged zip as downloadable files.

## 7. Iteration heuristics

- **One change per cycle.** Change the description or one body section, then
  re-test; simultaneous changes make regressions unattributable.
- **Triage failures to the right layer**: skill never consulted → description
  problem. Consulted but wrong behavior → body problem. Right behavior, wrong
  mechanics → script problem.
- **Generalize from feedback** — you iterate on 3 scenarios, but the skill
  will run on thousands of prompts. Fix causes ("the instruction assumed the
  file exists"), not instances ("add a rule for scenario 2's filename"). If a
  fix only works for the eval set, it is overfit.
- **Read the trajectory, not just the output**: if runs waste steps on
  something unproductive, delete the instruction causing it — leanness is a
  feature.
- **Bundle repeated work**: if every run writes the same helper script,
  move that script into `scripts/` and point the body at it.
- **Re-run only failed scenarios** while iterating; run the full set once
  before packaging.
- **Stop** when the full set passes twice in a row — a clean first pass
  still gets one confirming full re-run — or when a cycle produces no
  measurable improvement.
