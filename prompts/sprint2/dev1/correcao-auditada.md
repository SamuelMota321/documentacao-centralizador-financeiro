# Prompt: Correct Audited Sprint 2 Dev 1 Deliverables

- Scenario: code-change
- Created: 2026-09-26 · Target: Codex · Prompt language: English

## How to use

1. Start a new Codex task with `C:\Users\samue\Documents\GitHub\CFI\backend-centralizador-financeiro` as its workspace and make the sibling documentation repository available at `C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro`.
2. Review the existing worktree state before pasting the prompt. Keep the approved plan and the exact repository authorization gate in force.
3. Paste the prompt below as the first message.

## Prompt

```
<role>
Senior engineer specialized in safe maintenance of backend systems and technical documentation.
</role>

<context>
In the documentation repository, use `auditorias/auditoria-sprint-2-dev-1.md` as the issue inventory. Verify each claim against the approved Sprint 2 plan, normative Transactions specification, Dev 1 phase prompts, backend implementation, and backend consolidation evidence.

The four partially implemented planning items are S2-02, S2-06, S2-08, and S2-09. Work only on Dev 1’s responsibilities: backend domain, persistence, tests, technical integration, and related backend/documentation evidence. S2-09 also includes work assigned to other developers; do not take over or claim completion of those responsibilities.
</context>

<change_request>
Type: Bug fixes and completion of partial Dev 1 deliverables.

Goal: Correct the verified gaps for S2-02, S2-06, S2-08, and Dev 1’s S2-09 technical integration slice, while keeping implementation, tests, migrations, and documentation consistent with approved requirements.

Likely locations:
- Backend repository: category-rule domain, account lifecycle use case/repository, Prisma migrations, relevant tests, and backend consolidation evidence.
- Documentation repository: approved Sprint 2 plan, normative Transactions specification, Dev 1 phase prompts, and the audit report for reference.

Definition of done:
1. Resolve the category-rule account lifecycle gap using behavior the user explicitly approves.
2. Make database constraints enforce the approved `type` condition values and test the persistence boundary.
3. Reproduce and reconcile the reported test totals; update the backend consolidation evidence with accurate commands and results.
4. Complete and document only Dev 1’s backend technical integration and handoffs for S2-09. Do not claim that overall S2-09 is complete while work owned by other developers remains unverified.
5. Provide a change summary, changed-file list, executed checks and results, and evidence-backed status for all four items.
</change_request>

<required_sequence>
1. Read the applicable `AGENTS.md` files in both repositories. Inspect `git status` and relevant diffs before editing; preserve all pre-existing and unfamiliar work.
2. Read the audit report and the referenced approved planning sources. Confirm each finding in the current code and documents; report any material conflict or missing evidence.
3. For the account lifecycle finding, inspect the existing contract, lifecycle behavior, persistence and tests. Present 2–4 viable behavior options, with their contract and migration/test impact, and wait for the user to choose. Do not implement this behavior before that choice.
4. After the user chooses, present a concise repair plan listing the exact intended files, steps, risks, and checks. Follow the repositories’ authorization gate exactly: do not edit until the user sends `planejamento aprovado, pode implementar`.
5. Implement only the approved plan. Add or adjust focused tests for the approved behavior. Use a forward-only migration; do not edit an applied migration.
6. Verify the final diffs and report any unresolved item rather than inferring completion.
</required_sequence>

<issue_guidance>
- For S2-02/S2-06, the approved contract limits a rule condition with field `type` to `income` or `expense`. Ensure PostgreSQL enforces the same invariant as the domain and API, including when writes use the runtime database role.
- For the account lifecycle, consider the approved contract and existing data before proposing options. Possible approaches may include preventing archival while an active rule references the account, changing linked rules during archival, or revising the historical-reference contract. Do not choose among them without the user’s decision.
- For S2-08, rerun the relevant existing suites and reconcile the documented breakdown of 111 unit, 27 integration, 22 E2E, and 4 contract tests with the reported total of 165. Do not fabricate a missing test or count.
- For S2-09, document the Dev 1 backend integration state and precise handoffs. Do not edit web/mobile implementation or client tests, and do not represent another developer’s work as complete.
</issue_guidance>

<constraints>
- Keep changes limited to the approved Dev 1 scope and the four partial items.
- Do not edit the audit report. Do not change the approved Sprint plan or normative specification to make the implementation appear compliant; if a normative change is needed, propose it and wait for approval.
- Do not modify web/mobile source, client tests, or demonstration materials.
- Do not weaken or remove tests to make them pass. Avoid unrelated refactors and new dependencies.
- Do not discard, overwrite, or commit pre-existing work.
- Do not run checks against shared or external databases, deploy, publish, or perform destructive operations. If a database check’s target or effects are unclear, stop and ask.
- If evidence is insufficient or authoritative documents conflict, state that clearly and stop before making a behavior-changing assumption.
</constraints>

<verification>
Inspect the backend package scripts and existing test setup. Run the narrowest relevant domain, persistence, contract, lint, and type checks. Run database-backed checks only when the configured database is isolated and local and the operation is safe. Report each exact command and its actual result; distinguish reproduced results from historical documentation.
</verification>

<output_format>
Provide a concise before/after summary, changed-file list, test/check commands and results, and an evidence-backed status for S2-02, S2-06, S2-08, and Dev 1’s S2-09 slice. Include any remaining handoffs or blockers.
</output_format>
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the paste-the-prompt step come from the skill’s file template | template |
| Scenario | Code change: bug fixes and completion of partial work | user-stated |
| Goal | Correct the four partially implemented planning items above | user-stated |
| Scope | Dev 1 responsibilities only; no web/mobile or demonstration work | user-stated |
| Repositories | Backend and documentation repositories identified in the audit | user-stated through the audit request and follow-up |
| Account lifecycle | Investigate alternatives and wait for the user’s decision before editing | approved default |
| Verification commands | Discover existing scripts and run relevant safe checks | template |
| Authorization gate | Require the exact phrase `planejamento aprovado, pode implementar` after presenting the repair plan | repository instructions supplied by the user |
| Output | Before/after summary, changed files, checks, and remaining handoffs | template |
| Delivery path | `prompts/sprint2/dev1/correcao-auditada.md` | user-stated path, with Markdown extension |

Source legend: **user-stated** — from the user’s request or interview answers; **approved default** — a labeled option the user selected; **template** — standard scenario methodology covered by the user’s approval; **open** — deliberately unresolved and marked in the prompt.


