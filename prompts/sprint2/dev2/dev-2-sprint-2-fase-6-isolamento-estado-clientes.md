# Prompt: Dev 2 Sprint 2 — Phase 6 Client State Isolation and Idempotency Integration (S2-07)

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phases 3–5 are complete and their handoffs are recorded. It can overlap with Dev 1's S2-07 hardening, but it must use the backend contract as merged.
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
You are a senior frontend engineer specialized in client-side security hygiene, session and state isolation in Next.js (server rendering, Server Actions, caching) and React Native/Expo, and idempotent retry behavior under unreliable networks.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 6. Phases 1–5 must be complete. Read all previous "Execution handoff" sections and the Sprint 1 Phase 4 prompt (prompts/sprint1/dev2/dev-2-sprint-1-fase-4-manutencao-isolamento.md), whose isolation guarantees for accounts must now extend to transactions, categories, and rules.

Read and follow every applicable AGENTS.md. On web, read the Next.js docs for the installed version about caching, revalidation, and Server Actions before changing them.

Task

Complete Dev 2's contribution to S2-07 ("Isolamento de estado" / integração). Dev 1 implements backend isolation, idempotency, RLS, and audit; Dev 3 is the principal verifier. Your job is to ensure the clients never mix, leak, or duplicate data, and that they integrate correctly with the backend guarantees.

S2-07 acceptance criteria relevant to the clients (from the Sprint 2 plan):

- Cross-tenant reads and mutations are denied (the client must present this safely and never reveal foreign existence).
- Repeating idempotent commands does not duplicate movements.
- Tokens, secrets, and unnecessary financial payloads do not appear in logs.

Audit and harden, in each client independently:

1. Inventory
   - List every place where transactions, transfers, categories, rules, and accounts are fetched, held in state, cached, revalidated, persisted, or logged (including console calls, error boundaries, analytics, and crash messages).
   - List every place where Idempotency-Keys are generated, stored, reused, or rotated.

2. Session and user-switch isolation
   - On logout and on user switch, all Transactions-related state is cleared: lists, selectors, form drafts, pending Idempotency-Keys, and cached pages.
   - Web: authenticated data is never served from a shared cache; verify fetch cache mode, route segment caching, and revalidation for every Transactions route under the installed Next.js version; the access token never reaches the browser bundle, HTML, or client component props.
   - Mobile: in-memory stores are reset; nothing Transactions-related is written to SecureStore or AsyncStorage; screens remount or reset after logout so that a new user never sees stale rows even briefly.
   - A request that resolves after logout must not repopulate state (ignore or abort responses belonging to a previous session).

3. Idempotency integration
   - Verify the Phase 1 lifetime rule is implemented identically in every movement form on both clients.
   - Simulate: network failure after the server committed (retry must replay the original response, and the UI must show one movement); double tap/click; app backgrounded mid-submit (mobile); page refresh mid-submit (web: document the resulting behavior honestly); key expiry (409 IDEMPOTENCY_KEY_EXPIRED -> new key and explicit user action); key reuse with changed payload (409 IDEMPOTENCY_KEY_REUSED).
   - Keys are never reused across sessions, users, or operations (transaction vs transfer).

4. Uniform denial handling
   - 404 for resources of another tenant and 404 for nonexistent resources render identically.
   - 401 leads to a safe re-authentication path without losing the ability to retry, and without logging the token.
   - 403 IDENTITY_CONTEXT_UNAVAILABLE has a clear, non-technical message.

5. Log and error hygiene
   - Remove or guard any log that contains tokens, Authorization headers, Idempotency-Keys together with payloads, amounts, descriptions, or account names.
   - Error messages shown to users never include stack traces, SQL, internal codes beyond the documented Problem Details code, or another tenant's data.

6. Evidence for Dev 3
   - Produce a concise client-side isolation checklist per repository with the scenario, steps, expected result, and observed result, using two fictitious users (two tenants). Dev 3 will reuse it in S2-08.

Workflow

1. Model-selection assessment (AGENTS.md).
2. Build the inventory (items 1 and 2) from repository evidence before proposing changes.
3. Enumerate findings as: already correct (with evidence), defect, or not verifiable in this environment.
4. Present a plan per repository with the smallest fixes: exact files, exact diffs, risks, validation commands, and the two-user manual script.
5. Wait for: planejamento aprovado, pode implementar
6. Implement web and mobile separately.
7. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test; git diff --check; run the two-user script and the idempotency simulations against a local backend with fictitious data and record the observed results.
8. Append an "Execution handoff" section to this prompt file, including the checklist for Dev 3, and suggest one commit message per repository.

Constraints

- Do not modify the backend. Report backend gaps to Dev 1 and verification gaps to Dev 3.
- Client-side checks are presentation hygiene, never a security boundary; do not add client-side tenant filtering.
- Do not add dependencies beyond those approved in Phase 1.
- Do not weaken existing Sprint 1 isolation behavior for accounts.
- Do not share code between repositories. Use fictitious data only. Preserve unrelated user changes.
- Never claim a scenario passed without executing it.

Output

During planning: inventory, findings, and per-repository fixes with exact code. After implementation: cause, changed files, validation actually executed, two-user and idempotency results, the Dev 3 checklist, and remaining risks.

Acceptance criteria

- No Transactions-related data, draft, or Idempotency-Key survives logout or user switch on either client.
- Late responses from a previous session cannot repopulate state.
- Authenticated data cannot be served from a shared cache on web; the token never reaches the browser.
- Retry after an ambiguous failure never creates a duplicate movement; changed payloads and expired keys are handled as specified.
- Foreign and nonexistent resources are indistinguishable to the user.
- Logs and user-facing errors contain no tokens, secrets, or unnecessary financial data.
- A reusable two-tenant client isolation checklist exists for Dev 3.
- Lint, type-check, and build pass in each client or genuine blockers are reported.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | S2-07 Dev 2 part: client state isolation and integration | Plano_Divisao_Atividades_Sprint_2.html (matrix: "Isolamento de estado"; S2-07 "integração: Developer 2") |
| Prior guarantees | Sprint 1 Phase 4 client isolation for accounts | prompts/sprint1/dev2/dev-2-sprint-1-fase-4-manutencao-isolamento.md |
| Idempotency | Replay, REUSED, EXPIRED, 24h window, scope tenant + operation + key | especificacao-transactions.html §13 |
| Denial semantics | Cross-tenant is 404 without confirming existence | especificacao-transactions.html §16–17 |
| Dependency policy | Only what Phase 1 approved | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.
