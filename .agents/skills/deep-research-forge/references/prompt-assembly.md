# Prompt Assembly

The skeleton of the generated research prompt, the assembly rules, the
do-not-add list, and the delivery texts.

## Contents

1. [The skeleton](#1-the-skeleton)
2. [Assembly rules](#2-assembly-rules)
3. [The length rule](#3-the-length-rule)
4. [Do not add](#4-do-not-add)
5. [Delivery texts](#5-delivery-texts)

## 1. The skeleton

Assemble the English prompt in exactly this order. Curly braces are fill-in
points; omit only the lines marked omissible.

```
Please use the research tool to investigate the following request.

# {Deliverable type}: {short title}

## Context and purpose
{2-5 sentences: the situation, why the research matters, and the decision or
project deliverable it feeds.}
Audience: {audience} — {assumed knowledge}.

## Research questions
Answer every question below. For each one, meet its objective, produce its
output shape, follow its source guidance, and stay inside its boundaries.

1. {Sub-question}
   - Objective: {what a complete answer establishes}
   - Output: {table / list / paragraphs, with the fields required}
   - Sources: {question-specific guidance — omissible when the global
     criteria suffice}
   - Boundaries: {what this question does not cover}
2. {… 3-6 sub-questions total}

## Source criteria
- Prefer: {the deliverable file's prefer-list, plus user additions}.
- Avoid: SEO listicles, content farms, undated or unattributed posts, and
  secondhand summaries when the primary source is reachable.
- Recency: prefer sources from {window}; flag any older source relied on.
- Must consult: {user-supplied URLs or named connected internal sources},
  fetching them directly. {omissible when the user supplied none}

## Output format and length
Structure the report as: {the deliverable file's section skeleton, in order,
as adjusted by the user}.
Include: {the deliverable file's required tables or mappings}.
Write the report in {language — default English}.
Target length: {explicit number, words or pages}.

## Evidence rules
- Cite a source for every claim that is not common knowledge and for every
  number; state the assumptions behind any estimate.
- Where evidence is missing or sources conflict, say so explicitly and mark
  the item unresolved rather than choosing silently.
{Compliance type only:}
- Cite the primary regulatory or framework text for every obligation, and
  mark any uncertain conclusion as needing review by qualified legal
  counsel.
```

## 2. Assembly rules

- 3-6 sub-questions. Each must be answerable and bounded; if one reads as
  "research X", split or scope it until it does not.
- Keep the Avoid line even when the user said nothing about sources — it is
  part of the source-criteria default the user approved.
- The deliverable file's fixed clauses (for example: pricing figures carry
  sources and dates; rejection reasoning for non-chosen options) go into the
  section the file names — do not drop them during user edits unless the
  user explicitly removes them.
- Delegation instructions for skipped slots go inside the section that owns
  the slot (weights → Output format; candidate discovery → the relevant
  research question).
- Titles, section names, and all prose in the prompt are English regardless
  of the interview language.

## 3. The length rule

State an explicit numeric length target — words or pages — in every prompt.
Effort settings control thinking volume, not visible response length; the
documented way to control a report's length is to ask for it in the prompt.
Never write "comprehensive" or "as long as needed" in place of a number.

## 4. Do not add

Never place in the generated prompt:

- model, effort, or thinking instructions;
- subagent counts, source counts, or run-duration budgets;
- "double-check everything" re-verification clauses;
- any request for Claude to reveal or echo its raw reasoning or chain of
  thought;
- bracketed placeholders or open questions.

The first two describe machinery the request does not control; the rest are
documented ways to degrade a run.

## 5. Delivery texts

Translate all three into the user's language at delivery; the prompt block
itself stays English.

**Usage note** (always):

> Paste this prompt into a claude.ai chat with Research enabled — the "+"
> button in the chat interface, then "Research"; a visible indicator
> confirms it — and web search turned on. Expect the run to take minutes,
> not seconds.

**Post-run verification checklist** (always). Items 1-4 go in every
delivery. Items 5 and 6 are conditional: include item 5 only for vendor
comparisons and business cases, item 6 only for compliance — and drop the
type label when including one. A checklist item aimed at a deliverable type
the user is not producing is noise.

1. Spot-check several claims against their cited sources.
2. Open the citations: does each one resolve, and does it support the claim
   it backs?
3. Tick every research question from the prompt against the report —
   anything missing or covered only superficially?
4. Check that the source mix leans on primary, authoritative material
   rather than SEO listicles.
5. (Vendor comparison and business case only) Confirm every figure carries
   a source and stated assumptions.
6. (Compliance only) Route the result through qualified legal or compliance
   review before acting on it.

**Compliance caution** (compliance runs only, after the checklist):

> This research output supports compliance work; it is not legal or audit
> advice. Have qualified legal or compliance professionals review it before
> acting on it.
