# Prompt: Frontend Refactor — Phase 1 Motion Audit and Inventory

- Scenario: audit
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation, web, and mobile repositories as workspace roots.
2. Run after Phase 0 so the animation skills are discoverable.
3. This phase is read-only. It produces findings and a decision register; it changes no files.
4. Paste the prompt below as the first message.

## Prompt

```text
You are a senior design engineer specializing in interface motion, accessibility, and design systems for financial products.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro

Use the coinciente-visual-design skill as the governing workflow. Use improve-animations and review-animations for the web, and animate-expo and find-animation-opportunities for the mobile app. Read the applicable AGENTS.md files, docs/planejamento/refatoracao-frontend/Plano_Refatoracao_Frontend.html, docs/design/style-guide.html, and each repository's PRODUCT.md, DESIGN.md, UX_PRINCIPLES.md, and DESIGN_DEFINITION_OF_DONE.md.

## Starting evidence to re-verify

- Web motion tokens: src/app/globals.css lines 61-66; reduced-motion rule at lines 224-232.
- Durations outside tokens: src/app/page.module.css:99 (600ms), src/app/(app)/movimentacoes/movimentacoes.module.css:251 (320ms), src/components/ui.module.css:843 and :978 (160ms).
- Hypothesis: the global reduced-motion rule restricts transition-property with !important and may cut the display allow-discrete exit of .reveal.
- Mobile: no animation library; press feedback swaps style without transition in src/ui/controls.tsx:45-52; sections switch through useState in App.tsx.

## Task

1. Build a motion inventory for both platforms: file and line, trigger, properties, duration, curve, purpose (cause, state change, spatial relationship, or none), and reduced-motion behavior.
2. Compare the inventory with each DESIGN.md motion rule and record every divergence.
3. Confirm or reject the .reveal hypothesis with the evidence available. If it requires a browser check you cannot run, say so and describe the exact manual check.
4. List motion opportunities and rejections, each with the reason, using the plan's thesis: motion explains origin, reference date, and change; it never decorates or animates financial values.
5. Draft the decision register for: final semantic token values, ViewTransition scope, mobile bottom sheet versus full-screen forms, the impeccable hook, and coordination with Developer 2 and S4-06.

## Constraints

- Read-only: do not modify any file.
- Separate documented context, verified repository behavior, design inference, and hypothesis in every finding.
- Do not present source inspection as device or browser testing.
- No findings in a category is an acceptable result.

## Output

A markdown report with: inventory tables per platform, divergences, the .reveal verdict, accepted and rejected opportunities, and the decision register (item, options, recommendation, owner to decide, blocking or not).

## Acceptance criteria

- Every animation, transition, and keyframe in the web CSS appears in the inventory; verify completeness with a grep for transition, animation, @keyframes, and @starting-style.
- Every mobile Pressable and loading indicator is assessed.
- Each finding cites a file path and line.

Begin by grepping both repositories for motion declarations and reading the design documents.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Audit; design engineer | template |
| Skills used | coinciente-visual-design plus animation skills | user-stated — use Samuel's skill |
| Starting evidence | Lines verified on 2026-10-22 | approved default — approved plan, section 2 |
| Decision register items | Five open decisions | approved default — approved plan, section 8 |
| Read-only rule and epistemics | No edits; no findings is acceptable | template |
