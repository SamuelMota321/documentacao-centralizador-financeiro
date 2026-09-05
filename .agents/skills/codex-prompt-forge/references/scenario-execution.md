# Scenario: Execution (run an existing project, pipeline, or operational task)

Risk profile: silent failure ("looks done"), improvised destructive fixes,
secrets or bulk data leaking into context. Rigidity: high on safety and
verification, medium elsewhere.

## Required slots

| Slot | Ask (in the user's language) | Default when the user cannot answer |
|---|---|---|
| What to run | Exact commands or entry points, in order? | none — must be user-stated |
| Working directory & environment | Run from where? Env vars and prerequisites (names only, never secret values)? | delegation: session verifies prerequisites and reports what is missing before running |
| Success signal | How does the user know it worked (exit codes, checks, expected outputs)? | exit code 0 per command; optionally delegate proposing deeper checks to the session |
| Failure policy | On failure: stop and report, or diagnose and attempt a fix? | stop, capture output, diagnose, report — no fixes without approval |
| Report format | What should the final report contain? | what ran, per-step result, failures with evidence, suggested next actions |
| Safety boundaries | Anything that must never happen? | no destructive actions without confirmation; no writes outside the project |

## Prompt skeleton

```
<role>Operations-minded engineer running a known project carefully.</role>

<context>
Working directory: {DIR}
Prerequisites: {ENV VAR NAMES, SERVICES, CREDENTIAL LOCATIONS — never secret
values}
</context>

<task>
Run the following in order, verifying each step before the next:
1. {COMMAND 1} — success: {SIGNAL}
2. {COMMAND 2} — success: {SIGNAL}
</task>

<constraints>
- Success is the executable signal, not appearance; do not proceed past a
  failed check.
- On failure: {FAILURE POLICY}.
- Ask for confirmation before destructive or irreversible actions (deleting
  data, force-pushing, dropping tables); never print secret values.
- Inspect large data via summaries (head, shape, targeted queries); do not
  dump large outputs into context.
</constraints>

<report>
End with: what ran, each step's result with evidence (exit codes, check
output), failures with captured output, and suggested next actions.
</report>
```

## Standard clauses (provenance: template)

- Executable success signal per step; "looks done" is not a signal.
- Stop-and-report failure default; fixes only with approval.
- Destructive-action confirmation, secrets hygiene, data-dump hygiene.
- Final report shape.

## Assembly notes

- If the prompt will run non-interactively (CI, cron, or `codex exec`), add
  to How-to-use: grant only the required tools and commands rather than
  bypassing approvals or the sandbox.
- For recurring runs, suggest keeping the delivered file as the canonical
  runbook, updated through a new codex-prompt-forge pass when the pipeline
  changes.
