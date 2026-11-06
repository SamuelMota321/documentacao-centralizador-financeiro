# Prompt: Frontend Refactor — Phase 2 Style Guide 1.1 and Design Documentation

- Scenario: development
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation, web, and mobile repositories as workspace roots.
2. Use Plan mode. Run after Phase 1; paste its decision register and record which decisions are approved.
3. This phase changes documentation only. It can run in parallel with Sprint 4 closure.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

```text
You are a senior design-systems writer who turns brand guidance into operational, testable rules for web and mobile product teams.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro

Use the coinciente-visual-design skill. Read the applicable AGENTS.md files, docs/planejamento/refatoracao-frontend/Plano_Refatoracao_Frontend.html (section 4 defines the five pillars), docs/design/style-guide.html with assets/styles.css, docs/design/paterns-style-guide.md (invariants versus platform adaptations), the Phase 1 report, and each repository's PRODUCT.md, DESIGN.md, UX_PRINCIPLES.md, and DESIGN_DEFINITION_OF_DONE.md.

## Task

1. Add to docs/design/style-guide.html, following its existing structure and styles, a "Movimento" section with cross-platform invariants: purpose-only motion; what never moves (financial values, repeated actions); reduced motion keeps opacity and color and removes displacement; exits faster than entries; semantic token names.
2. Add a "Proveniência e estados ao vivo" section: the data stamp (origin manual/OFX/Pluggy, reference date, freshness current/stale/unavailable, always with text and icon) and the synchronization state machine (waiting, syncing, completed, failed with recovery).
3. Mark the guide version as 1.1 where the guide declares its version.
4. Write two ADRs in the documentation repository's existing ADR location and format: View Transitions in the web app; mobile migration to expo-router with Reanimated, Gesture Handler, and expo-haptics. Each covers problem, decision, alternatives, consequences, and validation.
5. Update web/DESIGN.md: semantic tokens table, choreography table including route crossfade ("navigation uses only crossfade"), and the new patterns.
6. Add a Motion section to mobile/DESIGN.md as a platform adaptation, not a copy of the web.
7. Update UX_PRINCIPLES.md and DESIGN_DEFINITION_OF_DONE.md in both client repositories with motion, provenance, and live-state items.

## Workflow

1. Locate the ADR convention and the guide's version marker; present the plan with exact sections and file list.
2. Wait for planejamento aprovado, pode implementar.
3. Edit only the approved documents.
4. Check internal links and HTML validity; run git diff --check in each repository.

## Constraints

- Do not change colors, typography, logo rules, or voice from Style Guide 1.0.
- Use only decisions approved in the Phase 1 register; leave unapproved items marked as pending.
- Write all product documentation in correct Brazilian Portuguese with accents.
- Do not modify product source code or dependencies. Do not commit.

## Output

List of changed documents with a summary per document, pending decisions left marked, validation results, and suggested commit commands with explicit paths.

## Acceptance criteria

- The style guide contains both new sections and declares version 1.1.
- Both ADRs exist and follow the repository convention.
- web/DESIGN.md and mobile/DESIGN.md reference the same semantic token names.
- Each DESIGN_DEFINITION_OF_DONE.md has at least one reduced-motion item and one provenance item.
- git diff --check is clean in all three repositories.

Begin by reading the style guide structure and locating the ADR convention.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Development; design-systems writer | template |
| Sections and pillars | Movement, provenance, live states, Style Guide 1.1 | approved default — approved plan, F2 and section 4 |
| Brand preservation | No change to colors, type, logo, voice | user-stated — "evoluir sem trocar marca" |
| Language | Product docs in pt-BR | user-stated — PRODUCT.md |
| Approval gate | Exact phrase before edits | user-stated — repository AGENTS.md |
