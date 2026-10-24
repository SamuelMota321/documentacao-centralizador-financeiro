# Prompt: Dev 3 Sprint 4 — Phase 2: Synchronization, Investments, and Asset Tests

- Scenario: audit
- Created: 2026-10-23 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with `C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro` as the primary workspace and the sibling backend, web, and mobile repositories available.
2. Paste the complete prompt below as the first message.

## Prompt

```text
You are a senior quality engineer carrying out Developer 3's sprint acceptance, contract, isolation, integration, and evidence responsibilities.

Context
Use C:\Users\samue\Documents\GitHub\CFI\documentacao-centralicador-financeiro as the primary workspace. Inspect its sibling repositories backend-centralizador-financeiro, web-centralizador-financeiro, and mobile-centralizador-financeiro as needed. Verify repository identities and read applicable AGENTS.md instructions. Record HEAD and working-tree status; preserve existing changes.

Treat sprint plans and their linked approved requirements, specifications, and decisions as acceptance sources, and current implementation and executed checks as implementation evidence. Flag material conflicts. Historical reports, checkboxes, filenames, and passing mocks alone do not prove completion. Read only relevant files.

Workflow and boundaries
1. Inspect this phase's sources and current implementation. Map requirements to evidence and remaining work.
2. Discover relevant commands from repository scripts and configuration; report the exact commands, prerequisites, side effects, and intended working directories before running them.
3. Present a bounded plan, affected files, acceptance checks, risks, and dependencies. Follow repository approval rules; before any write, wait for the exact authorization: "planejamento aprovado, pode implementar". This prompt does not supply that approval.
4. After approval, change only the listed tests, verification support, documentation, and evidence. Reuse existing tooling. Product-code corrections belong to Developer 1 or Developer 2; report a reproducible handoff instead of changing their code. Contract changes require the responsible owner's decision. Do not weaken tests, skip assertions, change expectations, or replace meaningful integration checks with mocks to make failures disappear.
5. Run the narrowest relevant approved checks. Distinguish passed, failed, skipped, and blocked checks; distinguish mocked behavior from real integration, and application-level isolation from database RLS verification. Never claim an unexecuted check passed.
6. Report files changed, requirement-to-evidence results, actual commands and outcomes, unresolved blockers with owners, and the next handoff. Stop when this phase is verified or its remaining work is explicitly blocked.

Use synthetic data or an authorized Sandbox. Do not expose secrets or financial payloads. Do not alter product code, dependencies, schemas, migrations, infrastructure, deployment settings, or credentials. Destructive or external operations require explicit authorization. Do not send handoffs to others through external tools.

Keep completion status separate from finding severity. Use critical/high/medium/low for supported findings, with file:line or document section, a short exact excerpt, impact, suggested fix, and confidence. For missing work, cite the requirement and inspected implementation locations; do not invent an excerpt of nonexistent code. No findings is acceptable. Say when evidence is insufficient. Revalidate earlier results against current HEAD, reuse valid completed work, and do not invent business rules or pending tasks.

Sprint 4, Phase 2
Read docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html and current approved contracts/decisions. Revalidate Phase 1 prerequisites per feature.

Complete Developer 3's verification for S4-02 through S4-05 and the supported integration criteria. Cover manual and scheduled synchronization, idempotency, concurrent runs on the same connection, controlled retries and failures, observable states, minimal job metadata, and tenant rejection. Derive timing and retry expectations from approved decisions.

Verify investment data that is available, explicit absent/unavailable/stale states, origin/reference/currency/quality where required, and supported movements and fixed-income fields. Check allocation by class/institution with partial data and unclassified positions using approved expected calculations; unresolved denominator, currency, or rounding rules are decision blockers rather than invented expectations.

Verify asset/liability field validation, optional financing-to-asset association, ownership, history, audit, persistence, and cross-tenant denial. Cover relevant independent web/mobile flows and OpenAPI compatibility. Reuse approved test tooling and synthetic data; separate test doubles from authorized real integrations. Add approved missing tests, run the relevant checks, and route product defects to Developer 1 or Developer 2.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill file template | template |
| Deliverables | One master audit prompt and phased Developer 3 execution prompts for Sprints 1–4 | approved default |
| Material | Four CFI repositories and sprint plans, with linked authoritative sources | approved default |
| Audit scope | Planned completion, acceptance, contracts, integration, isolation, and test evidence | approved default |
| Exclusions | Style preferences and improvements outside sprint acceptance | approved default |
| Severity | Critical/high/medium/low, separate from completion status | approved default |
| Developer 3 boundary | Tests, contract validation, integration verification, documentation, and evidence; product fixes routed to owners | approved default |
| Verification commands | Discover from repository scripts and configuration; disclose execution limits | approved default |
| Role and methodology | Evidence-based audit, bounded execution, verification, explicit uncertainty, preservation of existing changes, and stopping conditions | template |
| How-to-use workspace | Fresh task with the documentation repository primary and the three relevant sibling repositories available | template |
| Authorization | Follow applicable AGENTS.md and its exact authorization phrase; prompt approval does not authorize future execution | user-stated |
| Language | English prose, preserving source paths and the required authorization phrase verbatim | template |
| Sprint, developer, and phase | Developer 3, Sprint 4, Phase 2: Synchronization, Investments, and Asset Tests | approved default |
| Phase decomposition | Baseline/acceptance; critical verification; integration/evidence | approved default |
| Phase scope and sources | Scope stated in this prompt is derived from docs/planejamento/sprint-04/Plano_Divisao_Atividades_Sprint_4.html and its relevant linked approved sources; verify current completion at execution time | approved default |
| Specific phase instructions | The phase body, entry conditions, verification subjects, and outputs were reviewed and approved in chat | approved default |
| Prompt destination | prompts/sprint4/dev3/dev-3-sprint-4-fase-2-testes-sincronizacao-investimentos-patrimonio.md | approved default |
| Scenario adaptation | Audit methodology with bounded tests, verification, documentation, and evidence follow-up after repository approval | template |

Source legend: **user-stated** — directly stated by the user; **approved default** — an option or draft explicitly approved by the user; **template** — standard methodology or scaffolding covered by approval; **open** — deliberately left unresolved.
