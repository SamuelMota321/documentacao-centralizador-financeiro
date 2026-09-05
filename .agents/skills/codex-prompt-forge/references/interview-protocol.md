# Interview Protocol

How to run the interview: the slot model, batching mechanics, defaults,
language rules, and final approval.

## 1. Slot model and provenance

Every scenario file defines required slots. A slot is filled when it has a
value and exactly one provenance label:

- `user-stated` — verbatim from the request or an interview answer.
- `approved default` — a labeled option the user explicitly chose.
- `template` — a standard clause from the scenario skeleton, disclosed in the
  decision record and covered by the final approval.
- `open` — the user chose to leave it; it appears in the prompt as
  `[OPEN: question]`.

Do not assemble the prompt while a required slot lacks provenance.

## 2. Extract before asking

Reread the user's request and harvest every stated fact into slots as
`user-stated`. Re-asking a stated fact erodes trust; when interpretation is
needed ("by 'tests' you mean pytest?"), confirm it in the first batch instead
of re-collecting it.

## 3. Batching

Group questions thematically, in this order, skipping batches already
satisfied by extraction:

1. Scenario confirmation (only if ambiguous) + core task definition and
   definition of done.
2. Context and materials: repository, files, patterns to follow, data
   dictionary and sample.
3. Constraints and scope: dependencies, boundaries, what must not be touched.
4. Verification and acceptance: executable checks, commands, criteria.
5. Delivery: save path (default `prompts/{task-slug}.md`), intended Codex
   environment, and any permission or non-interactive constraints.

Use a structured user-input tool when one is available in the current mode —
up to 4 questions per call, options carrying a "(Recommended)" label where
the scenario file provides a default, and multi-select for non-exclusive
choices. Otherwise, ask the same batch as a numbered list in chat and wait
for the reply. Prefer 2–3 batches total; continue only while required slots
remain unfilled.

## 4. When the user cannot or will not answer

"I don't know" / "you decide" / silence on an essential point is never a
license to guess. Present 2–4 options grounded in the scenario file, mark one
"(Recommended)", and let the user pick — picking is the approval. Delegation
defaults ("have the session discover X from the repository and confirm it
before proceeding") are often the honest choice when the fact lives in the
repo rather than in the user's head. If the user explicitly wants the slot
left open, record `open` and place `[OPEN: question]` in the prompt.

When a user narrows a default (for example, choosing a shorter report over
the fuller recommended one), the narrowed version wins — do not restore
trimmed content during assembly.

## 5. Language

Interview in the language the user is writing in. The assembled prompt, the
saved file, and the decision record values are English; translate user
answers faithfully — do not add content while translating.

## 6. Final approval

Show the complete assembled prompt and the decision record. Ask one question:
approve, or adjust (and what to change). Apply adjustments and re-show until
approved — approval is what covers the `template` clauses. Before saving,
read applicable `AGENTS.md` files and obtain any exact authorization they
require. Only then save and deliver.
