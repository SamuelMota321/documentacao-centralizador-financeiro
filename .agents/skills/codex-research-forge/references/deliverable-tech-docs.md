# Deliverable: Technical Documentation

Research feeding documentation: guides, runbooks, onboarding material,
reference sections.

## When this type applies

The user needs researched material to write or ground documentation — how a
technology is correctly configured, operated, or explained to a defined
audience. If the goal is deciding rather than documenting, use the ADR or
architecture type.

## Question bank

- What the documentation covers and why it is needed now. (slot 2)
- Audience and assumed knowledge — required user-stated, no default: who
  reads it and what can they be assumed to already know? (slot 6)
- Prerequisites the documentation must state: environment, versions,
  access. (slots 3, 7)
- Format: prose guide, task-oriented steps, or reference tables? (slot 5)
- Scope boundaries: what the documentation deliberately does not cover.
  (slot 7)

## Sub-question template

1. Established practices and official guidance for {topic}, at the versions
   in scope.
2. Prerequisites and environment assumptions a reader must satisfy.
3. The task sequences or configuration steps the documentation will teach,
   with a source for each.
4. Known pitfalls, failure modes, and troubleshooting guidance.

## Output skeleton and length

Sections, in order: audience and prerequisites; the structured task or
reference sections chosen in the interview; examples; pitfalls and
troubleshooting.
Default length: 1500-2500 words.

## Source preferences

Prefer: official product documentation, standards documents, maintainer
sources.
Recency default: sources matching the versions in scope; otherwise the last
2 years, flagging older ones.

## Fixed clauses

- Any code or configuration in the report must carry a source or be
  explicitly marked illustrative.
- Where official guidance conflicts across versions, present the conflict
  per version rather than merging silently.
