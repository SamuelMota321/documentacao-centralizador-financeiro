# Deliverable: Architecture Decision Record (ADR)

Research feeding a recorded decision between technologies or approaches —
"Kafka vs RabbitMQ", "REST vs GraphQL", "build vs buy a component".

## When this type applies

The user must choose between identifiable options and record the decision
with its rationale. If the need is designing a whole system rather than one
decision, use the architecture type; if it is selecting a commercial vendor
on weighted criteria and cost, use the vendor-comparison type.

## Question bank

- The decision to record and its system context: what breaks or stalls if
  it is not made? (slot 2)
- Candidate options: which are on the table? Should the research discover
  additional candidates? Require at least 2 options by default; the user may
  waive this. (slot 3)
- Decision drivers: the forces that decide it — operational burden, cost at
  scale, guarantees, team skills, ecosystem maturity. Ask for the user's
  list. (slots 3, 7)
- Scale and team facts the drivers depend on: throughput, team size, ops
  maturity. (slot 7)
- Audience default: engineering team and architecture reviewers. (slot 6)

## Sub-question template

1. For each candidate option: the characteristics relevant to each stated
   decision driver, with evidence.
2. Direct comparison of the candidates driver by driver, at the stated
   scale.
3. Consequences of adopting each candidate — positive and negative,
   including operational and cost consequences.
4. Documented experiences of comparable teams running each candidate.

## Output skeleton and length

Structure the report as a draft ADR: Title; Status (vocabulary: Proposed /
Accepted / Superseded — a research-fed draft starts as Proposed); Context;
Decision Drivers; Options considered, with explicit rejection reasoning for
every non-chosen option; Decision; Consequences, which must include
negatives.
Default length: 1000-1500 words.

## Source preferences

Prefer: official project and vendor documentation, engineering write-ups
from comparable operations, maintainer communications.
Recency default: sources from the last 2 years; flag older ones.

## Fixed clauses

- Give explicit rejection reasoning for every non-chosen option — the
  rejected-alternatives rationale is the most valuable part of the record.
- The Consequences section must include negative consequences of the
  recommended option.
