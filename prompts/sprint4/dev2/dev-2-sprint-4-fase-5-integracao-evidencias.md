# Prompt: Dev 2 Sprint 4 — Phase 5: Client Integration and Evidence (S4-06)

- Scenario: audit
- Created: 2026-11-02 · Target: Codex or Claude Code · Prompt language: English

## How to use

1. Open a new task with `/home/miguel/projetos/documentacao-centralizador-financeiro` as the primary workspace and the web, mobile and backend repositories available.
2. Use plan mode and review the plan before authorizing changes.
3. Paste the complete prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer carrying out Developer 2's responsibilities for the independent web (Next.js) and mobile (Expo) clients: typed API clients, screens, forms, validation, interface states, and client contract alignment.

Context
Use /home/miguel/projetos/documentacao-centralizador-financeiro as the primary workspace and the sibling repositories /home/miguel/projetos/web-centralizador-financeiro, /home/miguel/projetos/mobile-centralizador-financeiro and /home/miguel/projetos/backend-centralizador-financeiro (read-only for this role). Read applicable AGENTS.md files and the web/mobile PRODUCT.md, DESIGN.md (Style Guide 2.0), UX_PRINCIPLES.md and DESIGN_DEFINITION_OF_DONE.md. Record HEAD and working-tree status of each repository; preserve existing changes. Web and mobile share no code.

Treat the Sprint 4 plan, PRD 1.4, the S4-01 baseline and its 2026-10-27 addendum (docs/planejamento/sprint-04/s4-01-dev1-backend-baseline-e-decisoes.md) and docs/planejamento/sprint-04/s4-dev2-mapeamento-dados-por-tela.md as sources. Treat the backend OpenAPI at the current backend HEAD as the published contract. Historical reports, fixtures and passing mocks alone do not prove integration.

Workflow and boundaries
1. Inspect this phase's sources and current client code. Map requirements to evidence and remaining work.
2. Discover commands from package scripts (pnpm lint, pnpm typecheck, pnpm test, pnpm build on web; pnpm typecheck, pnpm test and npx expo export --platform android on mobile); state working directories and side effects before running them.
3. Present a bounded plan with affected files, risks, validation and the exact code sections. Before any write, wait for the exact authorization: "planejamento aprovado, pode implementar". This prompt does not supply that approval.
4. After approval, change only client code, client tests and client documentation. Backend, OpenAPI, schema and migration changes belong to Developer 1; report a reproducible handoff instead. Do not invent routes, states, fields, intervals or business rules that the sources do not define; record them as open questions with an owner.
5. Run the narrowest relevant checks. Distinguish passed, failed, skipped and blocked checks, and mocked behavior from real integration. Never claim an unexecuted check passed.
6. Report changed files, requirement-to-evidence results, commands and outcomes, blockers with owners and the next handoff. Stop when the phase is verified or explicitly blocked.

Use synthetic data or an authorized Sandbox. Do not store tokens or financial payloads in the browser, device storage, logs or fixtures. Do not add dependencies without explicit approval. Do not commit unless separately authorized; suggest commit commands with explicit paths.

Sprint 4, Phase 5 — client integration and evidence for S4-06
1. Map each Sprint 4 client acceptance criterion (HU-008, HU-009, HU-011, HU-012) to client code, tests and observed behavior on both platforms.
2. Run the client validation commands on both repositories and record the results.
3. Verify against the running backend with synthetic data or the authorized Sandbox; record what was mocked and what was integrated.
4. Check DESIGN_DEFINITION_OF_DONE.md for every new screen, including reduced motion, provenance and 44pt touch targets on mobile.
5. Produce the handoff to Developer 3 with evidence, gaps and owners. Do not mark criteria accepted without evidence.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Role and boundaries | Developer 2: clients, contract alignment, interface states; backend changes routed to Developer 1 | approved default — Sprint 4 responsibility split |
| Workspace paths | Linux paths of the four repositories on Developer 2's machine | user-stated |
| Sources | Sprint 4 plan, PRD 1.4, S4-01 baseline and addendum, Dev 2 data mapping | approved default |
| Design rules | Style Guide 2.0 and client DESIGN.md | approved default |
| Phase scope | Client evidence for S4-06 | approved default — Sprint 4 plan S4-06 |
| Approval gate | Exact phrase before any write | user-stated — repository AGENTS.md |
| Commit policy | Suggest commands only | user-stated |

Source legend: **user-stated** — directly stated by the user; **approved default** — an option explicitly approved by the user; **template** — standard methodology covered by approval; **open** — deliberately left unresolved.
