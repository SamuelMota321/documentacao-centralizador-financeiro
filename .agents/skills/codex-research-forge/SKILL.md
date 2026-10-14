---
name: codex-research-forge
description: >-
  Builds an English prompt for ChatGPT Deep Research from a rough research
  need through a structured interview in the user's language. Use for
  architecture studies, ADRs, technical documentation, vendor comparisons,
  business cases, compliance mappings, or other research briefs. Not for
  coding or data-work prompts, creating Agent Skills, or performing the
  research itself.
license: MIT
---

# Codex Research Forge

Turns a rough research need into a precise, deliverable-calibrated English
prompt for ChatGPT Deep Research. This skill runs in Codex; its finished
prompt is intended for a new ChatGPT chat with Deep Research selected. The
user is the single source of truth: every concrete fact in the delivered
prompt comes from the user's request, an interview answer, or a default the
user explicitly approved. The interview runs in the user's language; the
delivered prompt is always English.

## The never-infer rule

Concrete facts — topics, constraints, vendor names, criteria and weights,
scale figures, recency windows, length targets — enter the prompt only from
(a) the user's request or interview answers, or (b) an option the user
explicitly approved. When the user cannot answer, present 2-4 options
grounded in the relevant deliverable reference, mark one "(recommended)",
and let the user pick — picking is the approval. Never leave a bracketed
placeholder or open question inside the prompt: a placeholder pasted into a
research run reproduces the vague-request failure mode the prompt exists to
prevent. The research-prompt analog of an open slot is a delegation
instruction ("state your proposed criteria weights before scoring, so the
reader can confirm them"), which keeps the request well-formed.

## Request, not machinery

The prompt shapes the research request and directs ChatGPT Deep Research to
investigate it; it does not configure the service or describe internal
execution. Do not mention models, effort levels, thinking settings, subagent
counts, source counts, or run-duration budgets in the generated prompt or in
your explanations to the user. Keep the prompt focused on the decision,
questions, evidence, and report the user needs.

## Hold the role

This skill builds the research request; it does not produce researched
answers. If the user asks to skip the prompt and answer the research question
yourself, do not improvise a researched-looking answer or a recommendation
from memory — an unsourced verdict is exactly the outcome this workflow
exists to prevent. Explain, in the user's language, that the deliverable is
a ready-to-paste brief for a new ChatGPT chat with Deep Research selected.
If Deep Research is unavailable, say so and do not silently substitute
ordinary web search.

## Workflow

1. **Extract.** Mine every fact already present in the user's request into
   slots. Confirm interpretations in the first batch; never re-ask a stated
   fact.
2. **Classify.** Classify the need using the table below. If it straddles two
   deliverable types, ask which one to use. If none fits, offer a general
   research brief or the closest type and let the user choose. If the user
   brought an existing prompt to improve, first diagnose its gaps against
   the quality gate, name them, and then run this same loop to fill the missing
   slots.
3. **Read** [references/interview-protocol.md](references/interview-protocol.md)
   and exactly one matching deliverable reference.
4. **Interview** in the user's language using numbered lists in plain chat,
   following the batching rules in the protocol, until every required slot
   is filled by a user answer or an approved default.
5. **Assemble.** Read [references/prompt-assembly.md](references/prompt-assembly.md)
   and build the English prompt from its skeleton.
6. **Run the quality gate** below; fix failures before showing the prompt.
7. **Approve and deliver.** Show the complete prompt; ask for approval or
   adjustments; loop until approved. Then deliver per Output below.

## Quality gate

Check the assembled prompt against each item; fix failures before delivery:

1. Opens by directing ChatGPT Deep Research to investigate the request and
   cite the sources it relies on.
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
11. The usage note directs the user to a new ChatGPT chat with Deep Research
    selected; it does not suggest ordinary web search as an automatic
    substitute.
12. The prompt says nothing about models, effort, thinking, subagent counts,
    source counts, or run duration.
13. Every concrete fact is user-stated or an approved default; the prompt is
    entirely English; calm imperative language, no all-caps emphasis.

## Deliverable-type references

Read exactly one reference per run, right after classification:

| Deliverable | Read |
|---|---|
| Solution or system architecture study | [references/deliverable-architecture.md](references/deliverable-architecture.md) |
| Architecture decision record (ADR), technology choice | [references/deliverable-adr.md](references/deliverable-adr.md) |
| Technical documentation (guides, runbooks, references) | [references/deliverable-tech-docs.md](references/deliverable-tech-docs.md) |
| Vendor, platform, or tool comparison | [references/deliverable-vendor-comparison.md](references/deliverable-vendor-comparison.md) |
| Business case, investment justification | [references/deliverable-business-case.md](references/deliverable-business-case.md) |
| Compliance mapping, regulatory readiness | [references/deliverable-compliance.md](references/deliverable-compliance.md) — weakest evidence base of the six; relay its caution at delivery |
| General research brief, when no existing type fits | [references/deliverable-general-research.md](references/deliverable-general-research.md) |

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