# Prompt: Sprint 3 Cross-Repository Planning

- Scenario: development
- Created: 2026-09-28 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with the CFI workspace and all four sibling repositories available; use the documentation repository as the primary workspace.
2. Paste the prompt below as the first message.

## Prompt

```
<role>
You are a senior technical product planner preparing a repository-grounded Sprint 3 implementation plan for a four-repository software project.
</role>

<goal>
Create a complete Sprint 3 plan that states what must be implemented for the sprint to be considered complete. This is a planning-only task: do not implement any software changes.
</goal>

<context>
The approved Sprint 3 dates are 2026-09-25 through 2026-10-09.

The explicitly approved feature scope is:
1. OFX import.
2. Open Finance connection through Pluggy.

The sprint covers these four repositories in the CFI workspace:
- backend-centralizador-financeiro
- web-centralizador-financeiro
- mobile-centralizador-financeiro
- documentacao-centralicador-financeiro

Inspect all four repositories, but include work in a repository only when it is necessary to deliver the two approved features or their required integration, validation, or documentation.

The activities must be divided among Developer 1, Developer 2, and Developer 3 according to the established responsibility model in:
`docs/planejamento/sprint-02/Plano_Divisao_Atividades_Sprint_2.html`

Use that document as the role and planning-format reference:
- Developer 1: backend, domain, application, persistence, REST/OpenAPI, authorization, idempotency, audit, and row-level security.
- Developer 2: independent web and mobile experiences, typed clients, forms, validation, and interface states.
- Developer 3: acceptance criteria, tests, contracts, isolation, integration, documentation, and evidence.

Read and follow all applicable `AGENTS.md` files. Treat the user's explicit Sprint 3 decisions in this prompt as authoritative. Older Sprint 2 exclusions of OFX or Pluggy apply only to Sprint 2 and must not remove either feature from Sprint 3 scope.
</context>

<task>
1. Establish the current baseline by inspecting the current Git status and HEAD in all four repositories. Preserve any pre-existing user changes.
2. Read the relevant product requirements, architecture and API contracts, existing Sprint 1 and Sprint 2 planning documents, and the code paths related to OFX and Pluggy. Search only as broadly as needed to identify the work required in each repository.
3. Separate verified existing behavior from missing work. Ground claims in repository evidence, with file paths and line references or document sections.
4. Decompose the approved scope into ordered, reviewable activities. For every activity, specify:
   - a unique Sprint 3 task ID and a concise title;
   - the primary developer and any supporting or reviewing developers;
   - the repository or repositories involved;
   - the intended outcome and bounded work;
   - dependencies and handoffs;
   - a relative P/M/G estimate, following the established sprint-plan convention;
   - a proposed date window within the approved sprint, clearly marked as an estimate rather than a commitment when team capacity is unknown;
   - observable acceptance criteria and the evidence or checks that would verify them;
   - risks, external prerequisites, and unresolved decisions.
5. Make ownership explicit across the four repositories. Keep primary responsibility consistent with the established Developer 1, 2, and 3 roles, and show cross-developer handoffs where work depends on another role.
6. Define sprint-level completion criteria and a traceability matrix showing how every approved feature maps to its tasks, repositories, acceptance criteria, and verification evidence.
7. Create exactly one HTML planning document in the documentation repository. Do not create accompanying Markdown, JSON, or other planning files.
</task>

<constraints>
- Planning only. Do not modify code, tests, package manifests or lockfiles, schemas, migrations, configuration, infrastructure, credentials, external accounts, or other repositories' files.
- The sole authorized write is the one Sprint 3 HTML planning document specified below. Do not edit an existing document, shared CSS, assets, or the documentation index.
- Do not add unrelated product scope. Work not directly required for OFX import or the Pluggy Open Finance connection is out of scope. If a prerequisite is necessary, tie it explicitly to one of those features and cite the evidence.
- Do not invent business rules, supported file variants, Pluggy endpoints or SDK behavior, synchronization behavior, API contracts, security guarantees, or acceptance criteria. Derive them from authoritative project sources. When evidence is missing or sources conflict, mark the issue as an open decision instead of silently choosing.
- If current Pluggy behavior must be verified and internet access is available, consult official Pluggy documentation and cite the exact source. Do not invoke external APIs or use credentials.
- Do not install or authorize new dependencies. If a new dependency appears necessary, record it as a pending decision with its purpose and evidence.
- Do not assume weekend work or team capacity. Proposed sequencing and dates must be labeled clearly when they are estimates.
- Do not run product tests or claim implementation validation. The plan may list relevant commands and test scenarios for the developers to run during implementation.
</constraints>

<output>
Create:
`docs/planejamento/sprint-03/Plano_Divisao_Atividades_Sprint_3.html`

Write the document in Brazilian Portuguese and follow the structure and visual conventions of the Sprint 2 HTML plan. Reuse existing documentation assets and relative links; do not modify those assets.

Include:
- sprint objective, dates, approved scope, and explicit exclusions;
- current repository baseline and evidence;
- Developer 1, 2, and 3 responsibilities;
- ordered activities with owners, repositories, dependencies, estimates, proposed date windows, acceptance criteria, and verification evidence;
- cross-repository handoffs and integration sequence;
- risks, blockers, external prerequisites, and pending decisions;
- sprint definition of done and feature-to-task traceability;
- references to the project documents and code evidence used.

Do not update navigation or create any second file.
</output>

<acceptance_criteria>
The task is complete when:
- the single specified HTML file exists and contains the complete Sprint 3 plan;
- both approved features are covered by repository-grounded work items and verifiable completion criteria;
- each work item has a primary developer, repository assignment, dependencies, acceptance criteria, and verification evidence;
- assignments follow the established developer responsibility model or explicitly identify evidence-based exceptions;
- out-of-scope work and unresolved decisions are clearly distinguished;
- unsupported assumptions are not presented as approved facts;
- the three product repositories remain unchanged, and the documentation repository changes only by adding the specified HTML file.
</acceptance_criteria>

<verification>
Before and after writing, inspect `git status --short --branch` in all four repositories. Preserve and report any pre-existing changes. Confirm that the only new or changed file caused by this task is the specified HTML document.

Verify that the HTML file exists, has the expected Brazilian Portuguese HTML structure, and that its local links resolve. Run `git diff --check` where applicable. Do not install a validator or run product tests.
</verification>
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and the instruction to paste the prompt come from the skill's file template | template |
| Task definition | Produce a complete Sprint 3 implementation plan as one HTML document, without implementing software | user-stated |
| Sprint dates | 2026-09-25 through 2026-10-09 | user-stated |
| Feature scope | OFX import and Open Finance connection through Pluggy | user-stated |
| Repository scope | Backend, web, mobile, and documentation repositories | user-stated |
| Team split | Activities must be divided among Developer 1, Developer 2, and Developer 3 | user-stated |
| Developer role mapping and planning format | Follow the existing Sprint 2 plan and its responsibility model | approved default |
| Dependency policy | Do not add or install dependencies; record any required new dependency as a pending decision | user-stated |
| Prompt workspace | Make all four sibling repositories available and use the documentation repository as primary | approved default |
| HTML output path and language | Follow the existing Sprint 2 planning-document convention; write one Brazilian Portuguese HTML file | approved default |
| Stack and repository patterns | Discover them from the current repositories and record relevant evidence | template |
| Edge cases and missing acceptance details | Derive only from authoritative project evidence; label unknowns as open decisions | template |
| Scope limits and evidence requirements | Keep scope minimal, avoid invented APIs or business rules, and ground claims in repository evidence | template |
| Planning-only verification | Check the generated document and repository status; do not run product tests or change product repositories | user-stated / template |

Source legend: **user-stated** — from the user's request or interview answers; **approved default** — an explicitly selected option; **template** — a standard clause from the prompt skill, covered by the user's final approval.
