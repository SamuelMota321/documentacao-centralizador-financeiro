# Audit Framework for Existing Style Guides

This framework synthesizes `docs/design/paterns-style-guide.md`, an external research report that explicitly did not inspect the product’s current guide or implementation. Use it to choose questions, not to manufacture product findings. Its internal web citation identifiers are not portable references.

## Contents

- [Evidence before conclusions](#evidence-before-conclusions)
- [Audit dimensions](#audit-dimensions)
- [Qualitative status and priority](#qualitative-status-and-priority)
- [Rewrite pattern](#rewrite-pattern)
- [Limits](#limits)

## Evidence before conclusions

Treat the target guide, product artifacts, user-provided decisions, external standards, and your interpretations as distinct evidence classes. A research report may supply audit questions, but does not show that a product follows or violates them. Support each finding with a path, heading, excerpt, or observed product behavior. If no target guide was supplied, request it or provide only a clearly labeled framework.

## Audit dimensions

Review only relevant dimensions and explain why a dimension is out of scope when useful.

| Dimension | Questions and evidence to look for |
|---|---|
| Coverage | Are recurring decisions for actual product surfaces documented? Are needed components, states, patterns, and examples represented? |
| Clarity | Can a reader apply the rule without guessing? Are context, exceptions, examples, and verification described? |
| Brand expression | Does the guide explain how approved brand decisions translate into interface roles, beyond relying on a logo or raw values? |
| Accessibility | Are requirements testable for color use, contrast, keyboard, focus, semantics, assistive technology, target size, and verification? Are the applicable standards identified? |
| Responsiveness and platforms | Does guidance explain reflow and platform adaptation, or show only fixed layouts? Are shared invariants and surface-specific choices clear? |
| Components and edge cases | Are relevant focus, error, loading, empty, disabled, long-content, and other states covered? |
| Design to implementation | Do tokens, component names, and rules map clearly between design and code? Inspect implementation only when supplied or requested. |
| Content and patterns | Are labels, errors, actions, terminology, and recurring task flows addressed where they matter? |
| Maintenance | Can readers tell what is current, experimental, deprecated, owned, or subject to change? |
| Contextual topics | Are imagery, illustration, iconography, motion, gestures, data visualization, or themes relevant to this product? Do not require a topic merely because it appears in another system. |

## Qualitative status and priority

Use `absent`, `partial`, `clear`, and `validated` only as shorthand, accompanied by evidence. These labels are a practical proposal from the source report, not an empirically validated maturity scale. Use `validated` only when an observed review, implementation comparison, or test supports it; documentation alone does not prove the implemented product behaves accordingly.

Prioritize based on supported user impact, reach across surfaces, frequency, and evidence strength. Do not assign numeric scores unless the user provides an established scoring method. State uncertainty and missing evidence instead of hiding them in a priority label.

## Rewrite pattern

Turn a supported finding into a rule containing:

- **Purpose** — the outcome the rule serves.
- **Context** — where and when it applies.
- **Rule** — the behavior or design decision supported by evidence.
- **Exception** — known contextual or platform variation.
- **Verification** — how readers can check the result.

Keep unknown values explicit as `[OPEN: question or decision]`. For example, if a guide says “show errors in red” but supplies no approved error token, do not invent one. Propose that error states use a semantic error role and an additional non-color cue, then mark the token and verification criteria for confirmation.

## Limits

- Terminology and document boundaries vary across organizations. Do not require brandbook, visual guidelines, style guide, and design system to be separate artifacts.
- Examples from IBM, GOV.UK, USWDS, Atlassian, and Shopify show possible structures. They do not establish that another product should copy those structures or will achieve the same results.
- The source report references WCAG 2.2 and other sources through internal citation identifiers. Verify exact, current, numeric, or compliance-related claims against the applicable primary source and version before repeating them. If verification is unavailable, mark the point as unverified.
- A guide audit is not a product accessibility certification. Do not claim legal or regulatory compliance without the proper scope, evidence, and qualified review.
