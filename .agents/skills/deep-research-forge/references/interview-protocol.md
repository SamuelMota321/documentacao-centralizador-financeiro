# Interview Protocol

The slot model, batching mechanics, defaults, language rules, and final
approval.

## 1. Slot model

A slot is filled when it holds a value from the user's request, an interview
answer, or a default the user explicitly approved. Do not assemble the
prompt while a required slot is unfilled.

| # | Slot | Default | Notes |
|---|---|---|---|
| 1 | Deliverable type | classified from the request | ask only if it straddles two types |
| 2 | Topic, context, purpose | none — must come from the user | what is researched, why, and the decision or deliverable it feeds |
| 3 | Sub-question decomposition | draft 3-6 sub-questions from the deliverable file's template applied to the topic; the user edits or approves | never ship a single undivided question |
| 4 | Source criteria | deliverable file's prefer-list + the standard avoid-list; "must consult" starts empty | ask for URLs or connected internal sources the research must use |
| 5 | Output format and length | deliverable file's skeleton + its default length | the length target must be a number; report language defaults to English |
| 6 | Audience and assumed knowledge | deliverable file's default | technical documentation has no default — the user must state it |
| 7 | Constraints and recency window | recency default from the deliverable file | constraints must be user-stated for architecture, vendor comparison, and compliance; compliance's framework and version have no default |

Type-specific facts (ADR candidate options, vendor shortlists and criteria
weights, business-case financial assumptions) are not extra slots: the
deliverable file's question bank routes them into slots 3, 5, and 7.

## 2. Extract before asking

Reread the user's request and harvest every stated fact into slots.
Re-asking a stated fact erodes trust; when interpretation is needed ("by
'compare providers' you mean a weighted vendor comparison?"), confirm it in
the first batch instead of re-collecting it.

## 3. Batching

claude.ai chat has no structured question widget, so every batch is a
numbered list in a plain chat message: at most 5 questions, each carrying
its default inline — "(default: …)" — so the user can answer "1: default,
2: …" or simply "all defaults". Prefer two batches; never more than three.
Skip anything extraction already answered.

- **Batch 1 — grounding:** type confirmation (only if ambiguous), gaps in
  topic/context/purpose, audience, constraints, recency window.
- **Batch 2 — shaping:** the drafted sub-question decomposition presented
  for edit or approval, source criteria (must-consult sources? changes to
  the prefer/avoid lists?), and the format + length proposal.
- **Batch 3 — leftovers only.**

## 4. When the user cannot or will not answer

"I don't know" / "you decide" / silence on an essential point is never a
license to guess. Present 2-4 options grounded in the deliverable file, mark
exactly one "(recommended)", and let the user pick — picking is the
approval. If the user insists on skipping a slot, get their explicit
agreement to skip, then cover it inside the prompt with a delegation
instruction (for example: "state your proposed criteria weights before
scoring") — never a placeholder or an open question.

When a user narrows a default (a shorter report than recommended), the
narrowed version wins — do not restore trimmed content during assembly.

## 5. Language

Interview in the language the user is writing in. The assembled prompt is
always English; translate user answers faithfully — do not add content while
translating. If the user wants the finished report in another language,
record that inside the prompt's output section; the prompt itself stays
English.

## 6. Final approval

Show the complete assembled prompt. Ask one question: approve, or adjust
(and what to change). Apply adjustments and re-show until approved. Only
then deliver per the Output section of SKILL.md.
