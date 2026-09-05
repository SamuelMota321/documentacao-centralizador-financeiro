# Prompt: {TITLE}

- Scenario: {development | data-science | code-change | audit | execution}
- Created: {YYYY-MM-DD} · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with {WORKING DIRECTORY OR REPO} as its workspace.
2. {Optional lines per calibration rules: Plan mode suggestion,
   checkpoint note, fresh-reviewer note, non-interactive permissions note.}
3. Paste the prompt below as the first message.

## Prompt

```
{ASSEMBLED PROMPT}
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| {slot} | {value} | {user-stated / approved default / template / open} |

Source legend: **user-stated** — verbatim from the user's request or
interview answers; **approved default** — labeled option the user explicitly
chose; **template** — standard scenario clause covered by the final approval;
**open** — deliberately left as [OPEN: question].
