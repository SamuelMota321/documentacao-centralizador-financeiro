# Deliverable: Architecture Study

Research feeding a solution or system architecture: designing a system,
choosing a topology or platform approach, planning a migration.

## When this type applies

The user needs to design or restructure a system, evaluate architecture
patterns or approaches, or study how a capability should be built — and the
research output informs an architecture document or proposal. If the choice
is between a small set of named options, prefer the ADR type instead.

## Question bank

Route answers into the numbered slots of the interview protocol.

- Business goals and system context: what does the system do, for whom, and
  what is driving the change? (slot 2)
- Quality attributes with targets: latency, availability, scale, cost
  ceilings — ask for numbers where the user has them. (slots 3, 7)
- Constraints — required user-stated: existing stack, compliance regime,
  data residency, organizational limits. (slot 7)
- Which views the deliverable needs: component, data, integration, security.
  (slot 5)
- Audience default: engineering team and architecture reviewers. (slot 6)

## Sub-question template

Draft from this pattern, applied to the topic; drop what does not fit:

1. Candidate architecture patterns or approaches for {topic}, with
   trade-offs against the stated quality attributes.
2. How each candidate meets each quality-attribute target, with evidence.
3. Integration with the existing stack ({stack}): interfaces, migration
   path, coexistence.
4. Security and compliance implications of each candidate under {regime}.
5. Cost profile of each candidate at the stated scale.
6. Risks of the leading candidate and their mitigations.

## Output skeleton and length

Sections, in order: context and requirements recap; candidate options with
trade-offs; component and data views (described in text); integration
points; security considerations; recommendation with rationale.
Default length: 2000-3000 words.

## Source preferences

Prefer: vendor primary documentation, standards bodies, official reference
architectures, engineering write-ups from comparable operations.
Recency default: sources from the last 2 years; flag older ones.

## Fixed clauses

- Evaluate candidates against the stated quality attributes and constraints,
  not popularity or tool names.
- State explicitly where a quality-attribute target cannot be verified from
  sources.
