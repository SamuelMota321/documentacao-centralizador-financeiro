# Prompt: Dev 2 Sprint 2 — Phase 7 Client Testing, Integration, and Demonstration (S2-08, S2-09)

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phases 1–6 are complete and their handoffs are recorded.
2. Open a new Codex task with these workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only)
3. `git pull` all four repositories.
4. Use Plan mode. Authorize only with: `planejamento aprovado, pode implementar`.
5. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer responsible for client-side verification, contract compatibility, and release readiness of independent Next.js and React Native/Expo applications.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 7, the last Dev 2 phase of Sprint 2 (sprint closes on 2026-09-25). Phases 1–6 must be complete. Read every previous "Execution handoff" section, the Dev 1 Phase 6 handoff if available (prompts/sprint2/dev1/dev-1-sprint-2-fase-6-testes-consolidacao.md), and the Dev 2 Sprint 1 Phase 5 prompt for the established client verification pattern.

Read and follow every applicable AGENTS.md.

Task

Complete only Dev 2's contributions to S2-08 ("Testes dos clientes") and S2-09 ("Experiência e demonstração"). Dev 3 is the principal owner of S2-08 consolidation; Dev 1 owns backend tests.

Part A — S2-08 client verification

The Sprint 2 plan requires: "OpenAPI and typed clients remain compatible" and "Essential client flows use only test approaches already approved."

1. Test approach
   - Vitest is the client test approach, adopted in both clients in Sprint 1 Phase 5 (`pnpm test`, `*.test.ts` next to the code, HTTP and platform modules mocked). Extend the existing suites and reuse their helpers.
   - Screens and the real Auth0 round trip are not covered by Vitest; they are covered by the demonstration script with recorded results.
   - Adding a component-test or end-to-end library (for example React Testing Library, jest-expo, or Playwright) still requires presenting trade-offs and explicit approval before installation.

2. Coverage targets (Vitest where the logic is testable in Node; scripted/manual with recorded evidence for screens), per client:
   - Money normalizer and formatter: valid pt-BR inputs, zero, negative, three decimals, thousands separators, large values, malformed text; no float drift.
   - Civil date helper: leap years, invalid dates, no UTC shift near midnight.
   - Zod input schemas: every constraint mirrored from the OpenAPI, including transfer accounts must differ and the rule grammar.
   - Response schemas: a fixture per view (TransactionView, TransferView, CategoryView, CategoryRuleView, pages) validated against the snapshot, so contract drift fails loudly.
   - Idempotency-Key lifetime: reuse on identical retry, rotation on change/success/expiry, never across sessions.
   - Problem Details mapping: every confirmed code maps to a safe message; field errors map to fields.
   - Critical flows: create income, create expense, create transfer (two entries), categorize/correct/mark uncertain, rule create/edit/activate/deactivate/remove, and logout/user-switch isolation.

3. Contract compatibility
   - Compare each client's openapi.snapshot.json and transcribed types with the backend openapi/openapi.json at the final Sprint 2 backend commit. Report every difference; update only the client side and only with approval.

Part B — S2-09 consolidation and demonstration

The Sprint 2 plan requires: the complete flow is demonstrable on web and mobile; income, expense, transfer, categorization, and personal rule work end to end; lint, tests, type checks, and relevant builds pass; OpenAPI, migrations, and affected instructions are updated; evidence exposes no secrets or real financial data; only fictitious data is used.

1. Validate each client from its versioned README instructions on a clean checkout: install, environment example, dev run, build (web pnpm build; mobile Expo run and an export or doctor check if available).
2. Update each client README and .env.example only where Sprint 2 changed them (new routes/screens, new variables if any), without real credentials.
3. Write the web and mobile portions of the Sprint 2 demonstration script, using two fictitious users:
   - User A: create two accounts; register an income and an expense; register an accounting transfer and show both entries; create categories; categorize one movement manually; mark one as "incerta"; create two rules with different priorities that match the same description, create a new movement, and show which rule applied and why; deactivate a rule and show that it no longer applies; remove a rule.
   - Retry scenario: submit, simulate a network failure, retry, and show that no duplicate was created.
   - User B: log in on the same device after logout and show that none of User A's data appears.
   - Show the same data on web and mobile after refresh.
   - Every screen uses only fictitious data; no tokens or URLs with secrets appear on screen or in recordings.
4. Produce a concise handoff separating: Dev 2 completed and verified; implemented but unverified; blocked by Dev 1 (contract/backend) or Dev 3 (pipelines, end-to-end, contract tests); environmental limitations.

Workflow

1. Model-selection assessment (AGENTS.md).
2. Build a traceability matrix from every Dev 2 responsibility in S2-01 to S2-09 to repository evidence and executable checks, per client, classified as: implemented and verified; implemented but unverified; missing; blocked.
3. Present a plan per repository: exact test files and fixtures, verification scripts, README/env updates, demonstration script, commands, environment requirements, and expected evidence.
4. Wait for: planejamento aprovado, pode implementar
5. Implement only the approved changes, web and mobile separately.
6. Run: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test, and an Expo export; git diff --check. Execute the demonstration script end to end against a local backend with fictitious data and record the observed results.
7. Fix client defects within the approved scope. Do not change valid tests to make them pass.
8. Append an "Execution handoff" section to this prompt file and suggest one commit message per repository.

Constraints

- Do not modify the backend, backend tests, pipelines owned by Dev 3, or Dev 3's consolidation documents.
- Use the existing Vitest setup; do not install another test library without explicit approval.
- Do not share code, fixtures, or tests between repositories.
- Do not bypass authentication or session isolation to make tests pass; mock at the HTTP boundary only.
- Use fictitious data only; no real Auth0 credentials, tokens, or financial data in tests, fixtures, screenshots, or logs.
- Never claim a check passed without executing it. Report environmental blockers with evidence.
- Preserve unrelated user changes.

Output

During planning: traceability matrix, test-approach decision or options, and per-repository plan. After implementation: changed files, commands and results, demonstration results, remaining failures, environmental limitations, and the Dev 2 handoff.

Acceptance criteria

- Every Dev 2 responsibility from S2-01 to S2-09 is traced to evidence or explicitly classified.
- Money, date, schema, idempotency, and error-mapping logic has reproducible Vitest coverage in each client; screens have scripted verification with recorded results.
- Snapshots and typed clients match the final backend OpenAPI, or differences are reported.
- Each client builds and runs from versioned instructions.
- The demonstration script covers income, expense, transfer, categorization, uncertain state, rule precedence, rule lifecycle, idempotent retry, and two-user isolation on both clients, with observed results.
- Lint, type-check, build, and approved tests pass, or genuine blockers are reported.
- The handoff clearly separates Dev 2 completion from Dev 1 and Dev 3 work.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | Dev 2 parts of S2-08 (client tests) and S2-09 (experience and demonstration) | Plano_Divisao_Atividades_Sprint_2.html |
| Acceptance criteria | Derived from S2-08 and S2-09 in the Sprint 2 plan | Plano_Divisao_Atividades_Sprint_2.html |
| Test tooling | Vitest in both clients since Sprint 1 Phase 5; other test libraries require approval | repository evidence |
| Pattern reference | Dev 2 Sprint 1 Phase 5 verification prompt | prompts/sprint1/dev2/dev-2-sprint-1-fase-5-testes-consolidacao.md |
| Deadline | Sprint closes 2026-09-25 | Plano_Divisao_Atividades_Sprint_2.html |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **repository evidence** — verified on 2026-09-23; **template** — standard skill clause.
