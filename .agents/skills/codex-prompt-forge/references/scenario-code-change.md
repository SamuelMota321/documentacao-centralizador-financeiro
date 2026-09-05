# Scenario: Code Change (bugfix, refactoring, legacy)

Risk profile: regression is the dominant risk; scope creep ("improving"
unrequested code) is secondary. Rigidity: high — creativity does not belong
in legacy changes.

## Required slots

| Slot | Ask (in the user's language) | Default when the user cannot answer |
|---|---|---|
| Change type | Bug fix or refactor? | none — usually evident from the request; confirm if mixed |
| Symptom / goal | Observable symptom (bug) or structural goal (refactor)? | none — must be user-stated |
| Likely location | Where does the user suspect it lives? | delegation: session locates it and reports evidence before changing anything |
| Definition of done | What observable behavior means fixed/done? | none — must be user-stated |
| Test command | How are tests run? | delegation: session discovers the test setup and confirms it before writing tests |
| Scope boundaries | What must not be touched? | only the involved module; adjacent code stays untouched |

## Prompt skeleton

```
<role>Senior engineer specialized in safe maintenance and refactoring.</role>

<legacy_code>`{FILE OR MODULE}`</legacy_code>

<change_request>
Type: {BUG | REFACTOR}
Symptom/goal: {SYMPTOM OR GOAL}
Likely location: {LOCATION}
Definition of done: {OBSERVABLE BEHAVIOR}
</change_request>

<safety_net>
1. First, add a focused characterization test when it is needed to capture
   current behavior — for a bug, reproduce the problem with a failing test.
   Run the relevant check and report the result.
2. Do not weaken or remove existing tests to make the change pass. Update an
   existing assertion only when the approved behavior changed, and explain
   why it became obsolete.
</safety_net>

<constraints>
- Change only what is necessary; one problem at a time; do not refactor
  adjacent code.
- No destructive shortcuts (skipping hooks, discarding unfamiliar files).
</constraints>

<output_format>Before/after diff plus an explanation of each change and
why.</output_format>

<verification>Run the focused checks with {TEST COMMAND}; run broader checks
when proportionate to the regression risk, and report any unverified area.</verification>
```

## Standard clauses (provenance: template)

- Characterization/failing-test-first safety net, output shown.
- Ban on weakening or removing existing tests to hide a regression.
- Minimal scope, one problem (one smell) at a time.
- Diff-plus-explanation output.
- Risk-proportionate regression checks.

## Assembly notes

- For refactors spanning many sites, scope the prompt to one smell; a
  "refactor everything" prompt over-reaches and produces unreviewed changes.
- Add to How-to-use: commit before running the prompt, as a checkpoint to
  return to if the change goes wrong.
