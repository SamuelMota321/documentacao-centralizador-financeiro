# Prompt: Dev 2 Sprint 4 — Phase 3: Assets, Financing and Liabilities in the Clients (HU-012)

- Scenario: development
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

Sprint 4, Phase 3 — HU-012 in web and mobile
Entry condition: Developer 1 has published the approved HU-012 model and API in the backend OpenAPI. If not, stop after the plan and report the blocker.
1. Typed client layer for the published HU-012 routes (types, schemas, API functions, fixtures, contract tests).
2. Screens to register and edit assets (type, description, estimated value, valuation date, source informed by the user) and financing/liabilities (outstanding balance and the applicable data), and to associate financing with an asset, as the PRD and the approved model define.
3. Follow Style Guide 2.0: lists as tables, valuation date and source as the metadata line, explicit empty, loading, error and success states. Do not compute net worth (HU-013 belongs to Sprint 5).
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step | template |
| Role and boundaries | Developer 2: clients, contract alignment, interface states; backend changes routed to Developer 1 | approved default — Sprint 4 responsibility split |
| Workspace paths | Linux paths of the four repositories on Developer 2's machine | user-stated |
| Sources | Sprint 4 plan, PRD 1.4, S4-01 baseline and addendum, Dev 2 data mapping | approved default |
| Design rules | Style Guide 2.0 and client DESIGN.md | approved default |
| Phase scope | HU-012 client registration and editing | approved default — PRD HU-012 |
| Approval gate | Exact phrase before any write | user-stated — repository AGENTS.md |
| Commit policy | Suggest commands only | user-stated |

Source legend: **user-stated** — directly stated by the user; **approved default** — an option explicitly approved by the user; **template** — standard methodology covered by approval; **open** — deliberately left unresolved.
