---
name: coinciente-visual-design
description: Guides visual design decisions for Coinciente web, mobile, and dashboard work. Use for Coinciente-specific interface design or visual implementation; do not treat research context as verified repository behavior.
---

# Coinciente Visual Design

Use this skill for visual design, interface review, prototyping, and explicitly requested visual implementation for Coinciente. It provides product-specific design direction; it does not authorize code changes by itself.

## Establish the evidence

The design research report is based on a supplied briefing and explicitly did not inspect the repositories. Treat its product baseline as context, not as proof of current screens, tokens, components, dependencies, or behavior. Before making repository-specific claims or implementation recommendations, inspect the relevant current code and the applicable product style guide.

Keep these categories distinct in recommendations:

- **Documented context:** stated by the briefing or a current product document.
- **Design inference:** a reasoned proposal that still needs validation in the product.
- **Hypothesis:** an unverified assumption about usability, data, compatibility, or outcomes.

Do not repeat unresolved citation tokens from the research report as citations. Do not turn its unverified stack or version details into implementation facts.

## Preserve Coinciente's visual identity

Use the current style guide as the source for its **Essence, Brand, Colors and Theme, Typography and Voice, and Accessibility** decisions. Preserve those decisions when proposing visual work. Do not invent a palette, assert unverified font or token names, or treat this skill as a replacement for the guide. A design recommendation alone is not authorization to modify product code.

Strengthen the information hierarchy so primary values and actions are easy to scan while metadata remains secondary but findable. Keep origin and reference date close to the information they qualify. Convey states with text, icon, or shape as well as color. Use progressive disclosure for secondary details, while keeping critical information readily available.

## Respect platform conventions

- **Web:** preserve visible keyboard focus and semantic structure; keep reading order meaningful and ensure status and provenance are available as text. Follow the current web theme and component conventions.
- **Mobile:** respect device safe areas and the current touch-target guidance. The briefing cites targets of at least 44 px; confirm the current style guide's threshold and unit before treating that figure as an implementation criterion. Follow the app's existing grouping and interaction conventions.
- **Both:** do not rely on color alone, and provide accessible text for important information and states.

## Choose charts from the question and data

For a future dashboard, first establish what question the user needs answered and what data, coverage, and reference dates actually exist. Then choose the simplest suitable representation:

- Bars for comparing magnitudes.
- Lines for the same measure across comparable time points.
- 100% stacked bars only for relative composition; they hide absolute totals.
- Donuts only for a few categories when approximate comparison is enough.

For important charts, provide a textual summary and a way to access underlying values. Avoid inventing financial metrics or suggesting precision, completeness, or certainty that the data does not support. Do not use dual Y axes. Do not truncate a bar baseline when bar length represents magnitude.

## Motion and implementation choices

Use motion only when it explains cause, state change, or spatial relationship. Respect reduced-motion preferences. Do not animate routine navigation or financial values. The research report's example timings describe an unverified briefing baseline; check the current product guidance before repeating or applying any timing.

Treat chart libraries named in the report as conditional candidates, not recommendations for the current codebase. First inspect the relevant repository, existing primitives, and actual dashboard requirements. Verify compatibility against current package manifests and authoritative, current documentation before making version-specific claims or proposing a dependency. Prefer the existing implementation when it meets the need; a library does not replace semantic labels, textual summaries, or access to important values.
