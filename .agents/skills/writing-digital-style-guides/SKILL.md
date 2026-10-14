---
name: writing-digital-style-guides
description: >-
  Creates practical style guides for digital products, translating verified
  product and brand decisions into usable design and implementation guidance.
  Use when a user asks to create, write, develop, or structure a digital style
  guide, UI guidelines, a product design language, or a brandbook for web or
  mobile; Portuguese requests such as “criar guia de estilos” also trigger it.
  Not for auditing or rewriting an existing guide, or implementing product UI.
license: MIT
---

# Writing Digital Style Guides

Create a guide that helps its intended readers make and verify product decisions. Use the bundled framework as a menu of relevant topics, not a mandatory checklist or a substitute for product evidence.

## Workflow

1. Establish the guide’s audience, purpose, product surfaces, and requested deliverable. Treat “brandbook,” “interface style guide,” and “design system” as overlapping terms whose boundaries vary by organization; clarify scope when it affects the deliverable.
2. Read the supplied product and brand materials that bear on the request. Separate user-approved facts, repository evidence, external standards or research, and unresolved decisions. A reference document can inform the method without proving facts about the product.
3. Identify only the missing decisions that materially affect the guide. Ask concise questions when answers are needed. If the user wants progress without those answers, draft a scaffold and mark each unknown as `[OPEN: question or decision]`; do not invent brand values, tokens, platform behavior, ownership, or policy.
4. Select relevant sections from [references/authoring-framework.md](references/authoring-framework.md). Adapt the structure to the product and surfaces; do not force every topic into a separate document or section.
5. Write each important rule so a reader can act on it. Include its purpose, where it applies, the rule or example, exceptions where known, and a way to verify it. Distinguish shared principles from platform-specific adaptations. Separate approved decisions from your proposed interpretation of broad brand traits; label the latter **Proposed** and never let them read as approved policy.
6. Treat accessibility as part of the specification. For exact, current, or numeric standards claims, verify the applicable primary standard and criterion when an authoritative source is available. Otherwise mark the claim for verification; do not claim compliance from prose alone.
7. Review the draft for unsupported facts, contradictory rules, unresolved placeholders presented as decisions, and guidance that cannot be applied or checked. Report open decisions separately.
8. Before editing workspace files, inspect applicable `AGENTS.md` instructions and follow their approval requirements. Otherwise present the draft in the requested format.

## Output

Include the guide or requested section, its intended audience and surfaces, and any material open decisions. Use `[OPEN: ...]` inline for unresolved values or choices; a generic recommendation does not resolve an unknown product decision. When helpful, add a short decision record distinguishing supplied facts, verified evidence, external guidance, and open items. Match the user’s language.

## Reference

Read [references/authoring-framework.md](references/authoring-framework.md) when selecting guide topics, writing operational rules, or deciding how to adapt brand guidance to digital interfaces.
