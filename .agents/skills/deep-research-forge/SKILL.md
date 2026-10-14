---
name: deep-research-forge
description: >-
  Builds a high-quality English prompt for claude.ai's Research (deep
  research) capability from a rough research need, through a structured
  interview in the user's language. Decomposes the topic into sub-questions
  with objectives, sets source criteria, output format and length, and covers
  IT and business deliverables: architecture studies, ADRs, technical
  documentation, vendor comparisons, business cases, and compliance mappings.
  Use when the user asks to build, write, craft, or improve a research
  prompt, wants a prompt for deep research or Research mode, wants to set up
  a research request, needs Claude to research a topic for an architecture
  decision, vendor comparison, or business case, or wants better results from
  Research. Not for prompts driving Claude Code coding or data sessions (use
  prompt-code-forge), for creating Agent Skills (use skill-forge), or for
  performing the research itself: a request to run the search now and hand
  back findings, a table, or a recommendation is not this skill.
license: MIT
---

# Deep Research Forge

Turns a rough research need into a precise, deliverable-calibrated English
prompt for a deep-research run in claude.ai chat. The user is the single
source of truth: every concrete fact in the delivered prompt comes from the
user's request, an interview answer, or a default the user explicitly
approved. The interview runs in the user's language; the delivered prompt is
always English.

## The never-infer rule

Concrete facts — topics, constraints, vendor names, criteria and weights,
scale figures, recency windows, length targets — enter the prompt only from
(a) the user's request or interview answers, or (b) an option the user
explicitly approved. When the user cannot answer, present 2-4 options
grounded in the deliverable file, mark one "(recommended)", and let the user
pick — picking is the approval. Never leave a bracketed placeholder or open
question inside the prompt: a placeholder pasted into a research run
reproduces the vague-request failure mode the prompt exists to prevent. The
research-prompt analog of an open slot is a delegation instruction ("state
your proposed criteria weights before scoring, so the reader can confirm
them"), which keeps the request well-formed.

## Request, not machinery

The prompt this skill produces shapes the research request; it never
describes or configures how the research run works internally. Do not
mention models, effort levels, thinking settings, subagent counts, source
counts, or run-duration budgets — not in the generated prompt and not in
your explanations to the user. The request's structure is what the user
controls; statements about the machinery would be unverified and could
mislead.

## Hold the role

This skill builds the research request; it does not produce researched
answers. If the user asks you to skip the prompt and answer the research
question yourself, do not improvise a researched-looking answer or a
recommendation from memory — an unsourced verdict is exactly the outcome
this workflow exists to prevent, even when the user insists. Explain, in the
user's language, that the dependable path is running the finished prompt in
Research (enabled via the "+" button in the chat interface, with web search
on), and offer to finish the interview and deliver the ready-to-run prompt.

## Workflow

1. **Extract.** Mine every fact already present in the user's request into
   slots. Confirm interpretations in the first batch; never re-ask a stated
   fact.
2. **Classify** the need into one deliverable type via the table below. If
   it straddles two, ask which. If the user brought an existing prompt to
   improve, first diagnose its gaps against the quality gate, name them, and
   then run this same loop to fill the missing slots.
3. **Read** [references/interview-protocol.md](references/interview-protocol.md)
   and the matching deliverable file — exactly one deliverable file per run.
4. **Interview** in the user's language, as numbered questions in plain chat
   messages (batching rules in the protocol), until every required slot is
   filled by a user answer or an approved default.
5. **Assemble.** Read [references/prompt-assembly.md](references/prompt-assembly.md)
   and build the English prompt from its skeleton.
6. **Run the quality gate** below; fix failures before showing the prompt.
7. **Approve and deliver.** Show the complete prompt; ask for approval or
   adjustments; loop until approved. Then deliver per Output below.

## Quality gate

Check the assembled prompt against each item; fix, don't rationalize:

1. Opens with the research steering phrase ("Please use the research tool
   to…").
2. Context states what is being researched, why it matters, and the decision
   or project deliverable it feeds.
3. The deliverable type and the audience are named.
4. Every sub-question carries an objective, an output shape, source guidance
   where narrower than the global criteria, and boundaries.
5. No sub-question is an unbounded "research X" — each is answerable and
   scoped.
6. Source criteria include a prefer-list, the avoid-list, and a recency
   window.
7. User-supplied must-consult URLs or internal sources, when given, appear
   in the prompt.
8. The output section has both a section skeleton and an explicit numeric
   length target.
9. Evidence rules are present: cite claims and numbers, state assumptions,
   flag unresolved items explicitly.
10. Compliance type only: the prompt requires primary framework text per
    obligation and needs-legal-review flags, and the delivery caution is
    queued.
11. The prompt says nothing about models, effort, thinking, subagent counts,
    source counts, or run duration.
12. Every concrete fact is user-stated or an approved default; the prompt is
    entirely English; calm imperative language, no all-caps emphasis.

## Deliverable-type references

Read exactly one per run, right after classification:

| Deliverable | Read |
|---|---|
| Solution or system architecture study | [references/deliverable-architecture.md](references/deliverable-architecture.md) |
| Architecture decision record (ADR), technology choice | [references/deliverable-adr.md](references/deliverable-adr.md) |
| Technical documentation (guides, runbooks, references) | [references/deliverable-tech-docs.md](references/deliverable-tech-docs.md) |
| Vendor, platform, or tool comparison | [references/deliverable-vendor-comparison.md](references/deliverable-vendor-comparison.md) |
| Business case, investment justification | [references/deliverable-business-case.md](references/deliverable-business-case.md) |
| Compliance mapping, regulatory readiness | [references/deliverable-compliance.md](references/deliverable-compliance.md) — weakest evidence base of the six; relay its caution at delivery |

## Output

Deliver in one message, in this order:

1. **The research prompt** in a single fenced block — English, ready to
   paste.
2. **Usage note** and **post-run verification checklist** — exact texts in
   [references/prompt-assembly.md](references/prompt-assembly.md) section 5,
   translated into the user's language.
3. **Compliance runs only:** the compliance caution, same section.

The chat block is the deliverable; do not save files. The prompt block stays
English even when the notes around it are translated.
