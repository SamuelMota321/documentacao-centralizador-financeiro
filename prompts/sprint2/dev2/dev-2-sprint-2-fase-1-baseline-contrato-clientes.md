# Prompt: Dev 2 Sprint 2 — Phase 1 Client Baseline and Transactions Contract Alignment

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Sprint 1 was closed for Dev 2 on 2026-09-23 and pushed (web `b9ef81c`, mobile `6a23b89`; handoff in `prompts/sprint1/dev2/dev-2-sprint-1-fase-5-testes-consolidacao.md`). Confirm that both client repositories still match `origin/main`. Mobile manual verification is pending until the Auth0 Native application exists in the backend tenant.
2. Open a new Codex task with these repositories as workspace roots:
   - `/home/miguel/projetos/documentacao-centralizador-financeiro`
   - `/home/miguel/projetos/web-centralizador-financeiro`
   - `/home/miguel/projetos/mobile-centralizador-financeiro`
   - `/home/miguel/projetos/backend-centralizador-financeiro` (read-only reference for the OpenAPI contract)
3. Run `git pull` in all four repositories first. This phase depends on the backend contract at commit `fa9b62a` (`feat(s2): implement categorization and personal rules`) or later.
4. Use Plan mode. Review the proposed plan before authorizing edits.
5. Authorize implementation only with the exact phrase: `planejamento aprovado, pode implementar`.
6. Do not start Phase 2 until this phase's decisions are approved and recorded.
7. Paste the prompt below as the first message.

## Prompt

~~~text
You are a senior frontend engineer and client-contract owner specialized in Next.js (App Router, Server Actions), React Native/Expo, typed REST clients derived from OpenAPI, financial data entry UX, and Zod validation at presentation edges.

Context

Project: Centralizador Financeiro Inteligente (display name: Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro (Next.js)
- /home/miguel/projetos/mobile-centralizador-financeiro (React Native/Expo)
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY reference; never modify)

This is Dev 2 Sprint 2 Phase 1. Sprint 1 is complete. Dev 1 has already implemented S2-01 through S2-03 and the backend side of S2-05/S2-06; the OpenAPI contract for Transactions is materialized in the backend repository.

Your role in Sprint 2 (from Plano_Divisao_Atividades_Sprint_2.html): independent web and mobile experiences, typed clients, forms, validation, and interface states. In S2-01 you own "Fluxos e contrato dos clientes"; in S2-02 you own "Alinhamento dos modelos"; in S2-03 you own "Integração antecipada".

Before proposing anything:

1. Find and follow every applicable AGENTS.md (docs repo, web, mobile). Note that the web AGENTS.md requires reading the relevant guide in node_modules/next/dist/docs/ before writing Next.js code, because this Next.js version has breaking changes.
2. Read at minimum:
   - documentacao-centralizador-financeiro/Plano_Divisao_Atividades_Sprint_2.html
   - documentacao-centralizador-financeiro/especificacao-transactions.html (normative contract, version 1.1)
   - documentacao-centralizador-financeiro/plano-implementacao-transactions.html
   - documentacao-centralizador-financeiro/prd.html (HU-003, HU-005, HU-006, RN-001 to RN-005, RNF-009, RNF-014)
   - documentacao-centralizador-financeiro/arquitetura.html (client independence, API and validation view, test view)
   - documentacao-centralizador-financeiro/style-guide.html
   - backend-centralizador-financeiro/openapi/openapi.json (authoritative contract)
   - In each client: src/lib/api/CONTRACT.md, src/lib/api/openapi.snapshot.json, src/lib/api/http-client.ts, src/lib/api/errors.ts, src/lib/accounts/*, and the existing account screens/routes and auth/session code.
3. Confirm Sprint 1 closure from repository evidence: the Sprint 1 Phase 5 handoff and the pushed commits listed above. If a client repository has diverged from that state, stop and report it instead of building on it. Record the pending mobile Auth0 configuration as an environmental limitation; it does not block implementation.

Task

Close the client-side baseline for Transactions in both clients BEFORE any typed-client or UI implementation. This phase produces decisions and contract documentation; it does not build screens.

Part A — Contract traceability (per client)

Build a traceability matrix from every Transactions operation in the backend OpenAPI to the client flow that will consume it, the phase that will implement it, and the Sprint 2 item (S2-04, S2-05, S2-06). Cover at least:

- POST /api/v1/transactions (income/expense; Idempotency-Key header required)
- GET /api/v1/transactions (page, pageSize; ordering occurredOn DESC, id DESC)
- POST /api/v1/transfers (Idempotency-Key header required; returns TransferView with exactly two entries)
- PATCH /api/v1/transactions/{transactionId}/category (body is oneOf: { categoryId } or { categorizationStatus: "uncertain" | "unrecognized" })
- GET/POST /api/v1/categories, PATCH /api/v1/categories/{categoryId}, POST /api/v1/categories/{categoryId}/deactivate
- GET/POST /api/v1/category-rules, PATCH/DELETE /api/v1/category-rules/{ruleId}, POST .../activate, POST .../deactivate

Part B — Verify the observed contract and report divergences

The following facts were observed in backend openapi/openapi.json at commit fa9b62a. Re-verify each one against the current file; do not trust this list blindly:

- Money is a decimal string with exactly two decimals, strictly positive, pattern ^(?:0\.(?:0[1-9]|[1-9]\d)|[1-9]\d*\.\d{2})$. Never a JSON number.
- occurredOn is a civil date (format: date, YYYY-MM-DD). Future dates are accepted in this phase.
- CreateTransaction: accountId, type (income | expense), amount, occurredOn required; description nullable.
- CreateTransfer: fromAccountId, toAccountId, amount, occurredOn required; description nullable.
- TransactionView includes status (posted | voided), transferId, transferSide (outgoing | incoming | null), categoryId, categorizationStatus (unclassified | categorized | uncertain | unrecognized | not_applicable), categorizationSource (manual | rule | null). tenantId is never exposed.
- CategoryView: name (1–100 chars on create/update), source (user), status (active | archived), archivedAt.
- CategoryRuleView: categoryId, conditionField (description | type | accountId), conditionOperator (equals | contains | starts_with | ends_with), conditionValue (min 1), priority (integer >= 0), status (active | inactive | removed), removedAt. UpdateCategoryRule is partial.
- DELETE /category-rules/{ruleId} is documented as 200 with a JSON body, while especificacao-transactions.html §15 lists "200/204". Treat the OpenAPI as the contract, and record the divergence for Dev 1.
- Pages use items, page, pageSize (max 100), total.
- Problem Details (application/problem+json): type, title, status, code, detail, optional errors[] { path, code, message }; X-Request-Id is a correlation UUID and does not replace Idempotency-Key.
- Codes emitted by the backend Transactions/Accounts modules include: INVALID_REQUEST, AUTHENTICATION_REQUIRED, IDENTITY_CONTEXT_UNAVAILABLE, INTERNAL_ERROR, ACCOUNT_NOT_FOUND, ACCOUNT_ARCHIVED, TRANSACTION_NOT_FOUND, TRANSFER_ACCOUNTS_MUST_DIFFER, TRANSACTION_CATEGORIZATION_NOT_ALLOWED, CATEGORY_NOT_FOUND, CATEGORY_ARCHIVED, CATEGORY_RULE_NOT_FOUND, CATEGORY_RULE_CONFLICT, IDEMPOTENCY_KEY_REUSED, IDEMPOTENCY_KEY_EXPIRED, EMPTY_PATCH, and field-level codes such as INVALID_TYPE, INVALID_VALUE, OUT_OF_RANGE, UNKNOWN_FIELD. Confirm the exact list by searching the backend source; do not invent codes.

Investigate and record, from backend source or a local backend run with fictitious data, the answers to these open questions. When the answer is not determinable, mark it OPEN and name who must decide it (Dev 1 or Dev 3):

1. Does GET /accounts return archived accounts? (Needed to resolve account names in transaction history.)
2. Does GET /categories return archived categories? (They must remain visible in history but not selectable.)
3. Does GET /category-rules return removed rules?
4. Are categorization rules applied on POST /transactions so that the 201 response may already carry categorizationSource = "rule"?
5. What does the backend return when PATCH .../category targets a transfer entry (expected TRANSACTION_CATEGORIZATION_NOT_ALLOWED)?
6. GET /transactions has no filter parameters (account, period, category, type). Confirm. Client-side filtering of a single page is misleading and must not be implemented as if it were a complete filter.
7. There is no GET-by-id for transactions, categories, or rules, no void endpoint, and no way to return a transaction to "unclassified". Confirm.
8. Does the idempotency reservation happen before or after body validation? (It determines whether a key can be reused after a 400.)

Part C — Client decisions to close (propose, justify, and wait for approval)

For each decision, present options, the recommendation, trade-offs, and the dependency impact. Do not install anything in this phase.

1. Idempotency-Key strategy per platform:
   - Where the key is generated (web: inside the Server Action runtime, which is Node and has crypto.randomUUID; or as a hidden form field generated when the form is mounted/reset; mobile: verify whether Hermes on the current React Native version exposes crypto.randomUUID or crypto.getRandomValues; if not, the Expo SDK module expo-crypto is a candidate that requires explicit approval).
   - Lifetime rule. Recommended: one key per submission attempt of an identical payload; reuse it only when retrying the exact same payload after a network failure, timeout, or 5xx; rotate it after success, after any payload change, and after IDEMPOTENCY_KEY_EXPIRED; never reuse a key across users or sessions.
   - UX for IDEMPOTENCY_KEY_REUSED and IDEMPOTENCY_KEY_EXPIRED (409).
2. Money input and display:
   - Accept pt-BR input (for example "1.234,56"), normalize to the contract string ("1234.56") using string operations only; never parseFloat or Number for values that will be sent.
   - Display with pt-BR currency formatting without float drift (for example via integer cents or a verified string-based formatter); confirm engine support (Intl on Hermes) before relying on it.
   - Signs and meaning must be conveyed with text or sign, not only color (Style Guide).
3. Date input: occurredOn must be built from local calendar components, never from toISOString() (UTC shift risk). Decide the input control per platform. On mobile, a native date picker would be a new dependency; propose a validated text input (DD/MM/AAAA converted to YYYY-MM-DD) unless a dependency is justified and approved.
4. Mobile navigation: App.tsx currently switches screens by auth status and local state; there is no navigation library. Sprint 2 adds transactions, transfer, categories, and rules screens. Recommend either extending the existing state-based switching (no dependency) or adopting a navigation library (new dependency, requires approval and a justified modularity gain). Web and mobile must not share navigation or components.
5. Web route map: propose route names in the existing Portuguese convention (for example /movimentacoes, /movimentacoes/nova, /transferencias/nova, /categorias, /regras) and how they are protected by the existing proxy/auth mechanism.
6. Screen inventory and state matrix: for every screen, list the loading, empty, success, error, and disabled/submitting states, and the Problem Details codes it must handle.
7. Client test approach for Sprint 2: Vitest was adopted in both clients in Sprint 1 Phase 5 (`pnpm test`; `*.test.ts` next to the code; `fetch`, Auth0, Next functions, and `expo-secure-store` mocked; no component-test library). Record which new Transactions logic each phase must cover with Vitest (money and date utilities, schemas, Idempotency-Key lifetime, API functions, error mapping, Server Actions, OpenAPI contract). Screens remain covered by manual scripts; adding a component-test or end-to-end library still requires explicit approval.
8. Transfer presentation: always an accounting record ("Registro contábil entre suas contas"), never "enviar", "Pix", "pagar", or wording suggesting real fund movement (RN-005). Define the labels for outgoing/incoming entries.

Part D — Record the baseline

After approval, record the approved decisions without changing runtime behavior:

- Update src/lib/api/CONTRACT.md in each client independently: new coverage table (planned operations and owning phase), contract divergences, open questions with owners, and the approved client decisions relevant to that platform.
- Append an "Execution handoff" section at the end of this prompt file in the docs repository (prompts/sprint2/dev2/dev-2-sprint-2-fase-1-baseline-contrato-clientes.md) summarizing approved decisions, divergences reported to Dev 1, open items for Dev 3, and the next phase boundary.
- Do not edit especificacao-transactions.html or plano-implementacao-transactions.html (Dev 1 owns them). Report divergences instead.

Workflow

1. Run the model-selection assessment required by AGENTS.md.
2. Inspect the minimum required context listed above.
3. Build the traceability matrix (Part A) and the verification table (Part B), marking each item Verified, Divergent, or OPEN.
4. Present the plan with: problem; proposed decisions (Part C) with options and recommendation; exact affected files; exact diffs for CONTRACT.md in each client and for the handoff section; risks; validation commands.
5. Wait for: planejamento aprovado, pode implementar
6. Apply only the approved documentation changes.
7. Run, in each client, the relevant existing checks (web: pnpm lint, pnpm typecheck, and pnpm test; mobile: pnpm typecheck and pnpm test) to confirm nothing was affected, and git diff --check in every changed repository.
8. Report actual results and remaining OPEN items.

Constraints

- Do not modify backend-centralizador-financeiro in any way.
- Do not implement typed clients, screens, routes, or forms in this phase.
- Do not install or propose installing dependencies without a concrete justification; installation is not allowed in this phase.
- Do not create a shared package, monorepo, shared schemas, or shared components between web and mobile.
- Do not invent routes, fields, statuses, codes, or semantics absent from the OpenAPI and the normative specification.
- Do not present client-side filtering or ordering as a security or tenant boundary. Tenant scoping is backend-enforced.
- Use only fictitious data. Never include tokens, Auth0 secrets, or real financial data in documentation, logs, or examples.
- Preserve unrelated user changes.

Output

During planning: the traceability matrix, the verification table, the decision proposals, and exact file diffs. After implementation: cause, changed files, validation actually executed, and remaining risks and OPEN items.

Acceptance criteria

- Every Transactions operation in the OpenAPI is mapped to a client flow, a phase, and an S2 item in both clients.
- Each observed contract fact is marked Verified, Divergent, or OPEN, with evidence.
- Idempotency-Key, money, date, navigation, route, test-approach, and transfer-wording decisions are approved or explicitly OPEN with an owner.
- CONTRACT.md in each client reflects the approved baseline independently.
- Divergences for Dev 1 and open items for Dev 3 are listed in the handoff.
- No runtime code, dependency, or backend file was changed.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Scenario | Development task for Dev 2 Sprint 2 | user-stated |
| Task definition | Dev 2 parts of S2-01 (client flows and contract), S2-02 (model alignment), and S2-03 (early integration), as baseline only | Plano_Divisao_Atividades_Sprint_2.html |
| Starting assumption | Sprint 1 complete; backend Transactions contract materialized at fa9b62a | user-stated + repository evidence |
| Repository paths | /home/miguel/projetos/* (verified clone paths) | repository evidence |
| Backend access | Read-only reference for OpenAPI and emitted codes | Sprint 2 responsibility split |
| Contract facts | Observed in openapi/openapi.json at fa9b62a, to be re-verified | repository evidence |
| Known divergence | DELETE category rule: OpenAPI 200 vs specification "200/204" | repository evidence |
| Test tooling | Vitest adopted in both clients in Sprint 1 Phase 5; no component-test library | repository evidence |
| Sprint 1 state | Closed and pushed (web b9ef81c, mobile 6a23b89); mobile manual verification pending Auth0 Native app | repository evidence |
| Mobile navigation | No navigation library; state-based switching in App.tsx | repository evidence |
| Dependency policy | No installation in this phase | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **user-stated** — supplied by the user; **repository evidence** — verified in the repositories on 2026-09-23; **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.
