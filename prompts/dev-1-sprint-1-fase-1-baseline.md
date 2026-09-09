# Prompt: Dev 1 Sprint 1 — Phase 1 Baseline

- Scenario: development
- Created: 2026-09-08 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with `C:\Users\smota\Documents\documentacao-centralizador-financeiro` and `C:\Users\smota\Documents\backend-centralizador-financeiro` available as workspace roots.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior software engineer specialized in technical architecture and NestJS backend design.

Context

Project: Centralizador Financeiro Inteligente, an academic financial-management MVP.

Work with these repositories:
- `C:\Users\smota\Documents\documentacao-centralizador-financeiro`
- `C:\Users\smota\Documents\backend-centralizador-financeiro`

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative project documentation:
   - `visao.html`
   - `prd.html`
   - `arquitetura.html`
   - `Plano_Divisao_Atividades_Sprint_1.html`
3. Inspect the minimum relevant repository state and determine what is already complete.
4. Treat the documented active architecture and technology stack as authoritative. Do not introduce excluded, future, or undocumented technologies.
5. Find and follow the closest existing documentation and backend patterns.

Task

Complete only the Dev 1 contribution to S1-01, “Approve the baseline and close minimum decisions.”

Verify and, where necessary, document:

- The Clean/Hexagonal boundaries of the NestJS backend.
- The responsibilities and boundaries of the Identity and Accounts modules.
- The role and architectural placement of Prisma.
- Neon/PostgreSQL persistence boundaries.
- PostgreSQL row-level security responsibilities.
- Independence of the domain and application layers from frameworks, databases, HTTP, and infrastructure.
- Consistency with the three-repository arrangement, REST under `/api/v1`, OpenAPI, Auth0, persistence, tenancy, validation, and testing.
- That excluded technologies and future decisions are not presented as approved.

Do not implement the Dev 2 or Dev 3 assignments. Record only the interfaces and dependencies that the Dev 1 baseline must respect.

Workflow

1. Inspect only the relevant documentation and backend structure.
2. Compare the documented baseline with the current repository state.
3. Present a concise implementation plan containing:
   - the problem;
   - proposed solution and rationale;
   - exact affected files;
   - step-by-step changes;
   - risks;
   - validation commands;
   - the exact code or diff to be applied.
4. Do not modify any file until the user replies exactly:
   `planejamento aprovado, pode implementar`
5. After approval, apply only the approved changes.
6. Run the relevant repository checks and report their actual results.

Constraints

- Preserve existing user changes and unrelated work.
- Make the smallest change that fully records the Dev 1 baseline.
- Do not create a monorepo, shared schema-source package, or unapproved documentation hierarchy.
- Do not invent architectural decisions when the documentation is insufficient or contradictory. Report the gap instead.
- Do not add dependencies in this phase unless they are explicitly documented, necessary, included in the approved plan, and authorized.
- Do not use destructive or irreversible operations without separate explicit confirmation.
- Do not hardcode content merely to satisfy a check.

Output

During planning, propose the exact file paths and localized diffs required by the repository’s existing structure. After implementation, report only the cause, changed files, validation results, and remaining risks.

Acceptance criteria

- The Dev 1 backend baseline is explicit and consistent across the authoritative documentation.
- Clean/Hexagonal boundaries and the Identity and Accounts responsibilities are unambiguous.
- Prisma, Neon/PostgreSQL, tenancy, authorization, and RLS have documented architectural positions.
- The baseline remains consistent with REST `/api/v1`, OpenAPI, Auth0, validation, testing, and the three independent repositories.
- No excluded technology or future decision is represented as approved.
- Relevant documentation checks discovered from the repository pass.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the “paste the prompt” step come from the skill's file template | template |
| Role | Senior engineer for technical architecture and NestJS backend design | template + user-stated stack |
| Task definition | Dev 1 contribution to S1-01 | user-stated through referenced Sprint plan |
| Stack and language | Read and follow the active stack in project documentation | user-stated |
| Pattern reference | Discover the closest existing repository pattern | approved default |
| Dependency policy | Only documented dependencies, proposed before installation | approved default |
| Edge cases | Conflicting or insufficient documentation must be reported | approved default |
| Acceptance criteria | S1-01 completion criteria and relevant discovered checks | user-stated + approved default |
| Output form | Propose exact paths in the implementation plan | approved default |
| New task | Run in a separate Codex task | user-stated |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template + user-stated |
| Approval gate and safety clauses | Plan first; wait for exact authorization; preserve unrelated work | repository instruction + template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
