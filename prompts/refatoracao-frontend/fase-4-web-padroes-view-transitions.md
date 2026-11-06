# Prompt: Frontend Refactor — Phase 4 Web Patterns and View Transitions

- Scenario: development
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and web repositories as workspace roots.
2. Use Plan mode. Run after Phase 3 and after the View Transitions ADR is accepted.
3. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
4. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer for a Next.js App Router product, specializing in accessible components and motion.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro

Read web/AGENTS.md (this Next.js version has breaking changes; read the relevant guide in node_modules/next/dist/docs/ before writing code), node_modules/next/dist/docs/01-app/02-guides/view-transitions.md, web/DESIGN.md, web/UX_PRINCIPLES.md, the View Transitions ADR, and the provenance/live-state sections of docs/design/style-guide.html. Use coinciente-visual-design and animate.

## Task

1. Provenance component: build the approved data stamp (origin, reference date, freshness with text and icon) in src/components/ui.tsx or interactive.tsx, reusing StatusChip, Notice, and existing icons.
2. Synchronization state component: render the approved states (waiting, syncing, completed, failed with recovery). Transitions animate only opacity and icon; numbers never animate.
3. Route crossfade: add <ViewTransition> (import from 'react') at the approved level, src/app/(app)/layout.tsx or app-frame.tsx, keeping the side navigation and page header anchored. Apply the approved scope (crossfade only, or also the list-to-detail morph).
4. Reduced motion for view transitions: keep crossfade opacity, remove displacement, following the guide's "Respecting reduced motion" section.
5. Disclosure height: animate to auto with interpolate-size as progressive enhancement.

## Workflow

1. Read the local Next docs and the current layout files; present the plan with exact code sections per file.
2. Wait for planejamento aprovado, pode implementar.
3. Implement only the approved scope.
4. Validate in the three breakpoints of shell.module.css and report.

## Constraints

- Reuse existing components and tokens before creating new ones; no new dependencies.
- Do not animate financial values or the navigation structure itself.
- Without browser support the interface must work normally without animating.
- Keep components unconnected to Sprint 4 API data unless Developer 2 agreed; use existing types and fixtures.
- Do not edit tests to make them pass. Do not commit.

## Output

Changed files with purpose, screenshots or recordings if available, validation results, and residual risks (for example, Safari differences).

## Acceptance criteria

- The provenance and sync components meet DESIGN_DEFINITION_OF_DONE.md (states, keyboard, accessible labels, contrast).
- Route navigation crossfades in Chromium and degrades silently elsewhere; reduced motion removes displacement.
- Unit tests cover the component state rendering where the repository already tests presentation logic.
- pnpm lint && pnpm typecheck && pnpm test && pnpm build pass; git diff --check is clean.

Begin by reading the local View Transitions guide and src/app/(app)/layout.tsx.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Development; Next.js frontend engineer | template |
| ViewTransition availability | Works in App Router without config (local Next 16.3.4 docs) | approved default — approved plan, section 3 |
| Components and targets | Provenance, sync state, layout, disclosure | approved default — approved plan, F4 |
| No value animation | Numbers never animate | user-stated — web DESIGN.md |
| Approval gate | Exact phrase before edits | user-stated — repository AGENTS.md |
