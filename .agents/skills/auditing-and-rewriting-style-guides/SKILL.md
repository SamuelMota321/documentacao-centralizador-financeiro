---
name: auditing-and-rewriting-style-guides
description: >-
  Audits existing digital product style guides, grounds findings in source
  evidence, prioritizes gaps, and rewrites requested sections into actionable
  guidance. Use when a user asks to audit, review, improve, or rewrite an
  existing brandbook, UI style guide, design system, or web/mobile design
  guidelines; Portuguese requests such as “auditar” or “reescrever guia de
  estilos” also trigger it. Not for creating a new guide from scratch or
  implementing product UI.
license: MIT
---

# Auditing and Rewriting Style Guides

Evaluate what the supplied guide actually says, compare it with relevant product evidence when available, and make the boundary between findings and proposals explicit. External research can inform the audit method; it cannot establish the state of the product.

## Workflow

1. Confirm which guide, sections, product surfaces, and outcome the user wants reviewed. Treat “brandbook,” “visual identity guidelines,” “interface style guide,” and “design system” as overlapping terms, not a universal taxonomy.
2. Establish the actual audit input before inspecting files. If the user supplies a quoted excerpt without a file path, audit only that excerpt; do not search for a likely guide, infer a path, or claim to have reviewed surrounding sections. If the user supplies a path, inspect that exact path and report if it is missing. Never invent file paths or imply that unprovided materials were reviewed. If the user asks whether documentation matches implementation, inspect the relevant product artifacts or code before making that comparison. Cite only paths, headings, or excerpts you actually observed.
3. Check whether the supplied file is actually the product guide. If it is a research report or general reference, do not present it as evidence of product rules or defects. Explain the distinction and request the target guide; offer to extract a framework if useful.
4. Evaluate relevant dimensions from [references/audit-framework.md](references/audit-framework.md). For each finding, separate observed evidence from interpretation and recommendation. Mark absent, partial, clear, or validated only as qualitative labels; reserve “validated” for guidance supported by an observed check or test.
5. Give every finding a qualitative priority (`high`, `medium`, `low`, or `undetermined`) and a short reason based on evidenced impact, frequency, and evidence strength. Use `undetermined` when the available material cannot support a priority; do not invent numeric scores. Make uncertainty visible. Do not claim an accessibility violation, legal breach, or measured implementation defect without evidence that supports that claim.
6. When rewriting is requested, preserve supported decisions and convert vague guidance into usable rules. In the replacement text, mark every unresolved token, role, platform behavior, exception, or verification criterion inline as `[OPEN: question or decision]`; a general recommendation does not resolve an unknown product choice. Do not invent tokens, brand values, platform behavior, standards results, or governance policy. Keep findings and proposed replacement text distinct.
7. For exact, current, numeric, or compliance-related standards claims, verify the applicable primary source and version when available. Otherwise mark the claim for verification; do not certify compliance.
8. Before editing workspace files, inspect applicable `AGENTS.md` instructions and follow their approval requirements. If direct editing is not authorized, provide the proposed replacement text or diff without changing the source.

## Output format

Adapt detail to the request. Include:

1. **Scope and evidence** — files, sections, surfaces, and supporting materials reviewed.
2. **Summary** — the most consequential supported observations.
3. **Findings** — each with qualitative priority and its reason, evidence, interpretation, and a concrete recommendation. Use `undetermined` when impact or frequency cannot be supported by the available evidence.
4. **Rewritten content** — only when requested; distinguish supported rules from open decisions.
5. **Limits and verification** — missing evidence, standards that need checking, and any checks not performed.

Match the user’s language. No findings is an acceptable result when the evidence supports it.

## Reference

Read [references/audit-framework.md](references/audit-framework.md) when selecting audit dimensions, assigning qualitative statuses, prioritizing findings, or converting a finding into revised guidance.
