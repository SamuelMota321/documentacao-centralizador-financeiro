# Prompt: Dev 2 Sprint 1 — Phase 1 Baseline

- Scenario: development
- Created: 2026-09-10 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with `/home/miguel/documentacao-centralizador-financeiro`, the web client repository, and the mobile client repository available as workspace roots. Confirm the actual clone paths before pasting; this prompt assumes `/home/miguel/web-centralizador-financeiro` and `/home/miguel/mobile-centralizador-financeiro`.
2. Use Plan mode to review the proposed implementation plan before authorizing changes. Do not start a later phase until this phase is complete.
3. Paste the prompt below as the first message.

## Prompt

```text
You are a senior frontend engineer specialized in Next.js, React Native/Expo, and consuming OpenAPI-generated typed clients.

Context

Project: Centralizador Financeiro Inteligente, an academic financial-management MVP. Each tenant is exactly one person and only fictitious data is used.

Work with these repositories:
- `/home/miguel/documentacao-centralizador-financeiro`
- the web client repository (Next.js)
- the mobile client repository (React Native/Expo)

Before proposing changes:

1. Find and follow every applicable `AGENTS.md`.
2. Read the authoritative project documentation:
   - `visao.html`
   - `prd.html`
   - `arquitetura.html`
   - `Plano_Divisao_Atividades_Sprint_1.html`
3. Inspect the minimum relevant state of the web and mobile repositories and determine what is already complete.
4. Treat the documented active architecture and technology stack as authoritative. Do not introduce excluded, future, or undocumented technologies.
5. Find and follow the closest existing documentation and client-side patterns.

Task

Complete only the Dev 2 contribution to S1-01, "Approve the baseline and close minimum decisions."

Verify and, where necessary, record:

- That the web (Next.js on Vercel) and mobile (React Native/Expo, distributed via Expo/EAS) applications are independent, with no shared components, navigation, or source code.
- That both clients consume separate typed clients generated from the backend-owned OpenAPI contract under `/api/v1`, with no generator library approved yet and no shared schema-source package.
- The Auth0 OAuth 2.0 / OpenID Connect / JWT boundary as it applies to each client platform.
- Where Zod validation runs on the presentation edges of each client, and that Zod schemas are not shared as a source package between repositories.
- The documented visual identity both clients may follow without sharing source.
- The interfaces and dependencies the Dev 2 baseline must respect from Dev 1 (contract, endpoints, tenancy) and Dev 3 (acceptance criteria, test conventions).
- That excluded technologies and future decisions are not presented as approved.

Do not implement the Dev 1 or Dev 3 assignments. Record only the interfaces and dependencies that the Dev 2 baseline must respect.

Workflow

1. Inspect only the relevant documentation and the current web and mobile repository structure.
2. Compare the documented baseline with the current repository state.
3. Present a concise plan containing:
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
- Make the smallest change that fully records the Dev 2 baseline.
- Do not create a monorepo, a shared schema-source or component package, or an unapproved documentation hierarchy.
- Do not invent client decisions when the documentation is insufficient or contradictory. Report the gap instead.
- Do not add dependencies in this phase unless they are explicitly documented, necessary, included in the approved plan, and authorized.
- Do not use destructive or irreversible operations without separate explicit confirmation.
- Do not hardcode content merely to satisfy a check.

Output

During planning, propose the exact file paths and localized diffs required by each repository's existing structure. After implementation, report only the cause, changed files, validation results, and remaining risks.

Acceptance criteria

- The Dev 2 client baseline is explicit and consistent with the authoritative documentation.
- Web and mobile independence and separate typed-client consumption from the OpenAPI contract are unambiguous.
- Auth0/OIDC, JWT, Zod edge validation, and the shared visual identity have documented client-side positions.
- The baseline stays consistent with REST `/api/v1`, OpenAPI, and the three independent repositories.
- No excluded technology or future decision is represented as approved.
- Relevant documentation and repository checks discovered from the repositories pass.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the "paste the prompt" step come from the skill's file template | template |
| Role | Senior frontend engineer for Next.js, React Native/Expo, and OpenAPI-generated typed clients | template + documented stack |
| Task definition | Dev 2 contribution to S1-01 | documented Sprint plan |
| Repository paths | Docs repo plus web and mobile client repos; concrete clone paths to be confirmed by the user | approved default (assumed by naming convention) |
| Stack and language | Read and follow the active stack in project documentation | documented architecture |
| Pattern reference | Discover the closest existing repository pattern | approved default |
| Dependency policy | Only documented dependencies, proposed before installation | approved default |
| Edge cases | Conflicting or insufficient documentation must be reported | approved default |
| Acceptance criteria | S1-01 completion criteria and relevant discovered checks | documented Sprint plan + approved default |
| Output form | Propose exact paths in the implementation plan | approved default |
| New task | Run in a separate Codex task | template |
| Plan mode and checkpoint | Review the plan before authorizing this phase; do not start the next phase early | template |
| Approval gate and safety clauses | Plan first; wait for exact authorization; preserve unrelated work | repository instruction + template |

Source legend: **user-stated** — verbatim from the user's request or interview answers; **approved default** — labeled option the user explicitly chose; **template** — standard scenario clause covered by final approval; **open** — deliberately left as `[OPEN: question]`.
