# Deliverable: Vendor Comparison

Research feeding a selection among vendors, platforms, or tools on gating
requirements, weighted criteria, and total cost of ownership.

## When this type applies

The user must pick among commercial or hosted offerings and justify the pick.
If the choice is between open technologies without a purchasing dimension,
the ADR type usually fits better; if the question is whether to invest at
all, use the business-case type.

## Question bank

- What is being selected and which decision it feeds. (slot 2)
- Shortlist: which 3-5 pre-qualified vendors? If the user has none, offer
  the delegation default: the research proposes a shortlist and states its
  pre-qualification reasoning. (slot 3)
- Gating must-haves — required user-stated: the requirements that eliminate
  a vendor outright (compliance, region, SSO, integrations). (slot 7)
- Weighted criteria summing to 100, decided before viewing options. If the
  user cannot supply weights, use the delegation default: the report states
  its proposed weights before scoring. (slots 3, 5)
- TCO horizon (default 3 years) and the scale figures cost depends on:
  hosts, seats, volume. (slot 7)
- Audience default: procurement decision-makers. (slot 6)

## Sub-question template

1. For each shortlisted vendor: capability against each gating must-have,
   pass or fail, with evidence.
2. For each weighted criterion: how the vendors compare, with evidence per
   vendor.
3. Total cost of ownership per vendor over {horizon} at the stated scale:
   licensing, implementation, integration, training, support, renewals.
4. Security and compliance posture of each vendor relevant to {regime}.
5. Vendor viability and roadmap signals; documented customer references.

## Output skeleton and length

Sections, in order: executive summary; gating table (vendor × must-have);
weighted scoring matrix with normalized scores and the weights stated first;
per-vendor TCO table with assumptions; risks; recommendation.
Default length: 2500-3500 words.

## Source preferences

Prefer: vendor primary documentation and official pricing pages, analyst
reports, documented customer references.
Recency default: pricing sources from the last 12 months; everything else
from the last 2 years; flag older ones.

## Fixed clauses

- Every pricing or TCO figure carries a source and a date, and is treated as
  an input to verify, not a settled fact.
- Weights are stated before any scores appear.
