# Prompt: Frontend Refactor — Phase 5 Mobile Navigation and Motion Foundation

- Scenario: development
- Created: 2026-10-22 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the documentation and mobile repositories as workspace roots.
2. Use Plan mode. Run after the mobile migration ADR is accepted. Work on a dedicated branch.
3. Run step 1 (spike) as its own approval cycle; continue only after the spike result is approved.
4. Before editing, provide the plan and wait for the exact authorization: planejamento aprovado, pode implementar.
5. Paste the prompt below as the first message.

## Prompt

```text
You are a senior React Native and Expo engineer specializing in navigation, gesture-driven interfaces, and accessible motion.

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro

Read mobile/AGENTS.md, mobile/PRODUCT.md, mobile/DESIGN.md (with the Phase 2 Motion section), mobile/UX_PRINCIPLES.md, the mobile migration ADR, and the Expo SDK 57 documentation for expo-router, native tabs (expo-router/unstable-native-tabs in SDK 57), react-native-reanimated, react-native-gesture-handler, and expo-haptics. Use animate-expo and coinciente-visual-design.

## Current state

App.tsx switches MovementsScreen, AccountsScreen, CategoriesScreen, and RulesScreen through useState; there is no navigation library and no animation library. Authentication uses expo-auth-session through src/auth/AuthContext. Press feedback in src/ui/controls.tsx swaps styles without transition.

## Task

1. Spike: install the dependencies with npx expo install (expo-router and its required peers, react-native-reanimated, react-native-gesture-handler, expo-haptics), confirm versions with npx expo install --check, and verify that the Auth0 sign-in redirect works with expo-router. Report and stop for approval.
2. Migrate src/screens/ to routes: native tabs for Movimentações, Contas, Categorias; stack routes for Regras, OFX import, and Pluggy connect. Preserve every current behavior and screen state.
3. Motion primitives in src/ui/: spring press feedback on Button (controls.tsx), the approved form presentation (bottom sheet or full screen), skeleton-to-content transition, reduced motion through Reanimated's useReducedMotion, and a light haptic only on completed actions.
4. Provenance and sync-state components equivalent to the web patterns, implemented natively (no shared code with web).

## Workflow

1. Inspect the app entry, auth flow, and screens; present the plan for the current step with exact files.
2. Wait for planejamento aprovado, pode implementar.
3. Implement only the approved step.
4. Validate and report; repeat the cycle for the next step.

## Constraints

- Dependencies only as approved in the ADR and plan; no other upgrades.
- Respect dynamic type, safe areas, and 44-point touch targets; never rely on color alone.
- No animated financial values; no looping animations; no haptics on routine taps.
- Keep tokens and credentials out of logs and source. Use synthetic data only.
- Do not edit tests to make them pass. Do not commit.

## Output

Per step: changed files with purpose, dependency versions installed, validation results, what was tested on a device or simulator versus only inspected, and residual risks.

## Acceptance criteria

- Sign-in, sign-out, and every existing flow work after migration.
- Reduced motion removes displacement while keeping opacity changes.
- pnpm typecheck && pnpm test pass; the app starts with expo start; device or simulator testing is reported explicitly, or its absence is stated.
- git diff --check is clean.

Begin by reading App.tsx and src/auth/AuthContext, then plan the spike.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Scenario and role | Development; React Native/Expo engineer | template |
| Refoundation scope | expo-router, Reanimated, Gesture Handler, haptics | user-stated — "Refundação" |
| SDK 57 versions and native tabs path | From Expo changelog and docs, to re-verify | approved default — approved plan, section 3 |
| Spike-first sequencing | Auth redirect validated first | approved default — approved plan, risks |
| No shared code with web | Native implementation | user-stated — PRODUCT.md |
| Approval gate | Exact phrase before edits | user-stated — repository AGENTS.md |
