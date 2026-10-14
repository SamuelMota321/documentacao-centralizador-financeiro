---
name: coinciente-visual-design
description: >-
  Guides visual design reviews, proposals, prototypes, and explicitly requested
  UI implementation for Coinciente web, mobile, and dashboards. In this
  repository, use for screens, hierarchy, accessibility, interactions, motion,
  and chart choices even when a request omits Coinciente. Not for backend/API
  logic, financial calculations, transaction categorization, store releases, or
  as authorization to edit product code.
---
# Coinciente Visual Design

Use this skill for Coinciente-specific interface design and visual review. Ground product-specific recommendations in current product guidance and implementation. Treat design proposals as advice until the user explicitly requests implementation.

## Workflow

1. **Establish the task.** Identify the surface, user goal, and information the interface must communicate. Ask only for missing details that materially affect the recommendation.
2. **Inspect current evidence.** Read `docs/design/style-guide.html` for the product's visual identity. For web work, inspect the relevant `../web-centralizador-financeiro/PRODUCT.md`, `DESIGN.md`, and source files. For mobile work, inspect the corresponding files in `../mobile-centralizador-financeiro/`. Follow links in these documents to relevant implementation. If a source is unavailable in the current workspace, say so and do not infer its contents.
3. **Separate evidence from proposals.** Keep these categories distinct in the response:
   - **Documented context:** current product, brand, or accessibility guidance.
   - **Verified repository behavior:** what the inspected implementation currently does.
   - **Design inference:** a recommendation reasoned from that evidence.
   - **Hypothesis or unknown:** an assumption or outcome that needs validation.
   Cite relevant file paths and sections or symbols for product-specific claims. Do not turn an inference into a repository fact.
4. **Preserve Coinciente's identity and product boundaries.** Follow the current Style Guide for its brand, theme, typography, voice, and accessibility rules. Treat platform DESIGN.md files as translations of that guidance; surface any documented exceptions or conflicts. Keep the essential information easy to scan, with source and reference date close to the data they qualify. Keep secondary details findable through progressive disclosure. Show missing, stale, uncertain, and error states explicitly. Do not rely on color alone. Do not introduce bank-like language, promises of return, or investment advice.
5. **Respect each platform.** For web, preserve semantic structure, meaningful reading order, and visible keyboard focus. For mobile, inspect the current safe-area, navigation, keyboard, screen-reader, dynamic-type, and touch-target guidance before recommending changes. Verify the source and unit of any numeric threshold; do not carry values from an old report into implementation criteria without checking them.
6. **Choose visualizations from the question and data.** Establish the question, metric definitions, available data, coverage, and reference dates before choosing a chart. As general chart-design guidance—not a Coinciente-specific requirement—choose the simplest representation that supports the comparison: bars for magnitude, lines for comparable values over time, 100% stacked bars for relative composition when hiding totals is acceptable, and donuts only for a few categories when approximate comparison suffices. For important charts, include a textual summary and access to underlying values. Do not use dual Y axes or truncate a bar baseline when bar length encodes magnitude. Never invent financial measures or imply completeness or certainty the data does not support.
7. **Use motion and implementation patterns deliberately.** Respect the system reduced-motion preference. For web, follow the current product motion guidance, including its limits on animating page navigation and financial values; inspect mobile-specific guidance before carrying detailed motion rules across platforms. Recommend motion only when it explains cause, state change, or spatial relationship. Check current product guidance before repeating timings. Prefer existing components and tokens. Treat libraries and versions named in research as unverified candidates: inspect manifests and verify current authoritative documentation before making version-specific recommendations.
   For web redesign, visual-improvement, and UI-proposal tasks, actively search for current libraries relevant to the requested visual need, such as component, motion, icon, chart, or typography libraries. Compare them with existing components and CSS; check official documentation, maintenance, project compatibility, accessibility, and adoption costs. Present only candidates with a material benefit and cite the sources. For narrow web fixes, search only when the identified need could reasonably benefit from a library. This research does not authorize installing dependencies.
8. **Handle implementation requests under repository rules.** A design recommendation alone does not authorize file changes. When implementation is explicitly requested, inspect the applicable AGENTS.md, present the required plan, and wait for its authorization before editing. In this documentation repository, the required phrase is `planejamento aprovado, pode implementar`. Follow the instructions of the active workspace if the skill is used elsewhere.

## Response shape

For a substantial review or proposal, briefly state the task and surface, then give the evidence and recommendations with the categories above kept distinct. State what remains unknown and what would validate a hypothesis. Keep small requests concise; do not force a full review report when it adds no value. Match the user's language. Write customer-facing Coinciente copy in correct Brazilian Portuguese unless the user asks for another language.

## Sources

- Read `docs/design/style-guide.html` when making claims about Coinciente's visual identity.
- Read the relevant web or mobile PRODUCT.md, DESIGN.md, and implementation files for platform-specific work; the product repository's design document explains any approved deviation from the Style Guide.
- Read `docs/design/coinciente-visual-desing.md` only as research context. It explicitly says it did not inspect the repositories; do not use it as proof of current screens, tokens, dependencies, or behavior, and do not repeat unresolved citation placeholders from it.
