# Prompt: Dev 2 Sprint 2 — Phase 3 Movements in the Web and Mobile Clients (S2-04)

- Scenario: development
- Created: 2026-09-23 · Target: Codex · Prompt language: English

## How to use

1. Run this phase only after Phases 1 and 2 are complete and their handoffs are recorded.
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
You are a senior frontend engineer specialized in Next.js (App Router, Server Actions, the installed version's conventions) and React Native/Expo, financial data entry UX, idempotent form submission, accessible forms, and explicit interface states.

Context

Project: Centralizador Financeiro Inteligente (Coinciente).

Work with:

- /home/miguel/projetos/documentacao-centralizador-financeiro
- /home/miguel/projetos/web-centralizador-financeiro
- /home/miguel/projetos/mobile-centralizador-financeiro
- /home/miguel/projetos/backend-centralizador-financeiro (READ-ONLY)

This is Dev 2 Sprint 2 Phase 3. Phases 1 and 2 must be complete. Read both "Execution handoff" sections and follow every approved decision (routes, mobile navigation approach, Idempotency-Key lifetime, money/date handling, error mapping).

Read and follow every applicable AGENTS.md. On web, read the relevant guide in node_modules/next/dist/docs/ before writing routes, Server Actions, forms, or cache revalidation.

Task

Complete Dev 2's principal responsibility in S2-04: independent web and mobile flows for registering income, expenses, and accounting transfers, and for listing movements. You are the principal owner; Dev 1 supports the contract and Dev 3 validates.

S2-04 acceptance criteria from the Sprint 2 plan (all mandatory):

- Web and mobile consume their own typed clients.
- Forms validate the fields defined by the contract.
- Loading, success, empty, and error states are explicit.
- Transfers are presented as accounting records, never as bank operations.
- Clients do not accept or retain data belonging to another tenant.
- The interface follows the Style Guide without sharing components between repositories.

Build, in each client independently:

1. Movements list
   - Uses listTransactions with page and pageSize; shows the server ordering (occurredOn DESC, id DESC) without reordering; paginates with total.
   - Each row shows: date (pt-BR), description (or an explicit "Sem descrição"), account name, type label, amount formatted in BRL with sign or text conveying direction (not color alone), and categorization status as text.
   - Transfer entries appear as two rows (outgoing and incoming) with transferSide. Label them with the approved wording (for example "Transferência entre contas — saída" / "— entrada"). Do not merge them unless both entries are on the same page and the approach was approved in Phase 1.
   - Resolve account names from the accounts client. If an account is not found in the list (for example archived and not returned), show a neutral fallback such as "Conta indisponível"; never show raw UUIDs as the primary label.
   - Explicit states: loading (skeleton or indicator), empty ("Nenhuma movimentação registrada" with a call to action), error (retry action, safe message), and partial data (for example accounts failed but transactions loaded).
   - No client-side filters presented as complete filters, since the contract has no filter parameters.

2. Income/expense form
   - Fields: account (only active accounts from the accounts client), type (Receita/Despesa), amount (pt-BR input normalized to the contract string), date (civil date per Phase 1), description (optional).
   - Presentation-edge validation with the Phase 2 Zod schemas; field errors inline and associated with their inputs for accessibility.
   - Submit disabled while submitting; double submission must not produce two requests with different keys.
   - Idempotency-Key per the Phase 1 lifetime rule: same key on retry of the identical payload after a network failure, timeout, or 5xx; new key after success, after the user changes any field, and after IDEMPOTENCY_KEY_EXPIRED.
   - Handle: 400 field errors (map errors[].path), 404 ACCOUNT_NOT_FOUND (neutral message and refresh the account list), 409 ACCOUNT_ARCHIVED, 409 IDEMPOTENCY_KEY_REUSED (explain that the data changed and allow a fresh submission), 409 IDEMPOTENCY_KEY_EXPIRED, 401 (safe re-authentication path), 403 IDENTITY_CONTEXT_UNAVAILABLE, 500 (safe retry).
   - On success, show confirmation, reset the form (new key), and refresh the list only after the API confirms. If the response already carries categorizationSource = "rule", show that the category was applied by a personal rule.

3. Transfer form
   - Fields: origin account, destination account (both active, must differ), amount, date, description.
   - Title and helper text make it explicit that this is an accounting record between the user's own accounts and does not move money (RN-005). Never use the words "enviar dinheiro", "Pix", "pagar", or "transferência bancária".
   - Same Idempotency-Key, submission, and error rules as the income/expense form, plus TRANSFER_ACCOUNTS_MUST_DIFFER.
   - On success, confirm with both entries (outgoing and incoming) from TransferView.

4. Navigation and entry points
   - Web: the routes approved in Phase 1, protected by the existing auth proxy; add navigation entries consistent with the existing layout. Use Server Actions following the pattern in src/app/contas/actions.ts (token obtained server-side with auth0.getAccessToken(); never sent to the browser).
   - Mobile: the navigation approach approved in Phase 1; the access token stays in the existing session mechanism; screens follow the pattern of AccountsScreen/AccountFormScreen.

5. Style Guide
   - Use the existing tokens/theme in each client (for example Confiança #10251F, Consciência #087A55, Clareza #55D6A4, Respiro #F2F6F4), Manrope for UI and tabular numerals for amounts, Newsreader only for titles if already used.
   - Positive/negative meaning is conveyed by text or sign plus color, never color alone. No gradients, no "banco" look, no promises.
   - Web: keyboard accessible, labels bound to inputs, visible focus, responsive. Mobile: touch targets, accessibilityLabel on controls, correct keyboard types (decimal-pad for amount).

Workflow

1. Model-selection assessment (AGENTS.md).
2. Verify Phases 1–2 from repository evidence (typed functions, schemas, utilities exist and are committed).
3. Enumerate edge cases before planning: double tap/click; network drop after the server committed (retry must replay, not duplicate); user edits a field after a failed attempt; session expires mid-form; account archived between loading the form and submitting; only one active account (transfer impossible — explain it); zero accounts (guide the user to create one); amounts such as "0,00", "0,001", "-10", "1.000.000,00", "abc"; dates such as 29/02 in non-leap years; very long descriptions; empty list; last page; page beyond total.
4. Present a plan per repository: screens/routes, component tree, state machine per form (idle -> submitting -> success | invalid | conflict | error), key lifetime handling, exact files, exact code or diffs, risks, validation commands, and a manual verification script.
5. Wait for: planejamento aprovado, pode implementar
6. Implement web and mobile separately.
7. Validate: web pnpm lint, pnpm typecheck, pnpm test, pnpm build; mobile pnpm typecheck, pnpm test; git diff --check. Execute the manual verification script against a local backend with fictitious data, including the idempotent replay and the transfer, and record the observed results.
8. Append an "Execution handoff" section to this prompt file and suggest one commit message per repository.

Constraints

- Do not modify the backend. If the contract blocks a required behavior, stop and report it to Dev 1.
- Do not implement categorization UI, category management, or rules in this phase (Phases 4 and 5).
- Do not add dependencies beyond those approved in Phase 1.
- Do not share components, navigation, styles, or code between repositories.
- Do not mutate the list optimistically before the API confirms creation.
- Do not persist movement data in client storage (localStorage, AsyncStorage, SecureStore) or logs.
- Do not hardcode tenant IDs, account IDs, or test bypasses. Use fictitious data only.
- Preserve unrelated user changes.

Output

During planning: per-repository plan with exact paths and code. After implementation: cause, changed files, validation actually executed, manual verification results, and remaining risks.

Acceptance criteria

- On both clients, a user can register income, expense, and an accounting transfer, and see them in the paginated list.
- All S2-04 acceptance criteria from the Sprint 2 plan are satisfied with evidence.
- Retrying an identical submission never creates a duplicate; a changed payload uses a new key.
- Every confirmed error code relevant to these flows has a safe, specific message and a recovery path.
- Transfer wording never suggests real fund movement.
- Lint, type-check, and build pass in each client or genuine blockers are reported.
~~~

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill template | template |
| Task definition | S2-04 principal owner: web and mobile movements | Plano_Divisao_Atividades_Sprint_2.html |
| Acceptance criteria | Copied from S2-04 in the Sprint 2 plan | Plano_Divisao_Atividades_Sprint_2.html |
| Transfer semantics | Accounting record only; two entries sharing transferId | PRD RN-005 + especificacao-transactions.html §7 |
| Web pattern | Server Actions with server-side token, as in src/app/contas/actions.ts | repository evidence |
| Mobile pattern | AccountsScreen/AccountFormScreen state-based screens | repository evidence |
| Visual rules | Style Guide tokens and meaning not by color alone | style-guide.html |
| Dependency policy | Only what Phase 1 approved | approved default |
| Authorization checkpoint | Exact phrase required before edits | AGENTS.md |

Source legend: **repository evidence** — verified on 2026-09-23; **approved default** — conservative default consistent with prior prompts; **template** — standard skill clause.
