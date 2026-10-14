# Authoring Framework for Digital Style Guides

Use this framework to choose and shape useful guidance. It is a synthesis of `docs/design/paterns-style-guide.md`, an external research report that did not inspect the product’s current guide or implementation. The report’s categories are recommendations, not facts about a particular product. Its internal web citation identifiers are not portable references.

## Contents

- [Choose the document boundary](#choose-the-document-boundary)
- [Choose relevant topics](#choose-relevant-topics)
- [Make rules operational](#make-rules-operational)
- [Keep evidence and certainty visible](#keep-evidence-and-certainty-visible)

## Choose the document boundary

Organizations use “brandbook,” “visual identity guidelines,” “interface style guide,” and “design system” differently. Treat them as responsibilities that can overlap rather than requiring four separate documents. Clarify which decisions the requested guide should govern and who will use it.

## Choose relevant topics

Select topics that matter to the product, audiences, surfaces, and team. Mark irrelevant topics as out of scope rather than filling them speculatively.

| Topic | Useful guidance to consider |
|---|---|
| Scope and principles | Audience, governed surfaces, intended decisions, and principles for cases the guide does not cover. |
| Brand expression | How approved brand attributes appear in product UI; distinguish stable brand signals from decorative use. |
| Color and themes | Semantic roles, hierarchy, states, valid combinations, and theme behavior where applicable. |
| Typography | Approved families and hierarchy, plus supported text resizing behavior. |
| Layout and responsiveness | Grid and spacing relationships and how hierarchy reflows across available space; avoid relying only on fixed screenshots. |
| Components and states | Anatomy, variants, interaction states, content, and relevant programmatic semantics. |
| Patterns and journeys | How components work together to support recurring user tasks. |
| Content and terminology | Voice, labels, instructions, errors, actions, and terminology conventions. |
| Accessibility | Testable requirements for color use, contrast, keyboard, focus, assistive technology, target size, semantics, and verification. Confirm which standards apply. |
| Icons, imagery, illustration, and motion | Style, purpose, sizing, and whether each element is informative or decorative; include motion or gestures only where used. |
| Platform adaptation | What should remain recognizable and what follows the conventions of web, mobile, or a specific operating system. |
| Data visualization | Include when data displays are an important product surface. |
| Lifecycle and maintenance | Owner, status, update history, contribution, and deprecation practices appropriate to team scale. |

## Make rules operational

For each recurring decision, explain:

- **Purpose:** what the rule helps achieve.
- **Context:** where and when it applies.
- **Rule:** what to do, with an approved example when available.
- **Exceptions:** known platform, content, or product constraints.
- **Verification:** how a designer or engineer can check the result.

Prefer semantic roles over unexplained raw values, but only use tokens and values supported by product evidence. Show component states and task examples when they help readers apply the guidance. A consistent system can adapt across surfaces; it need not make every screen identical.

## Keep evidence and certainty visible

- Do not turn examples from IBM, GOV.UK, USWDS, Atlassian, Shopify, or another system into requirements for this product. Their structures demonstrate possible approaches, not universal outcomes.
- Distinguish a documented product decision from an external recommendation, an inference, and an unresolved choice.
- The source report proposes qualitative audit states such as absent, partial, clear, and validated; it explicitly does not claim this is an empirically validated scale. Use such labels only as a communication aid, and say what evidence supports each label.
- For accessibility thresholds or legal/regulatory claims, verify the applicable primary source and version before including exact criteria. If source access is unavailable, mark the item for verification and avoid claiming conformance.
