# Prompt: Align Vision, PRD, and Architecture with the Approved MVP Direction

- Scenario: code-change
- Created: 2026-09-04 · Target: Codex · Prompt language: English

## How to use

1. Open a new Codex task with `C:\Users\samue\Documents\GitHub\tcc` as its workspace.
2. Use Plan mode for the initial inspection and proposal because this is a coordinated multi-document change. Review the complete proposed changes before authorizing implementation.
3. Paste the prompt below as the first message.

## Prompt

```
Update the product vision, PRD, and software architecture documents so they consistently describe the approved academic MVP and its evolutionary path toward a SaaS product.

## Files and authority

Read and follow the applicable `AGENTS.md` before taking any action.

Use these files:

- `pesquisa-arquitetura.html`: research input only; never modify it.
- `visao.html`: update where product direction, scope, stakeholders, phases, and quality objectives are affected.
- `prd.html`: update affected requirements, actors, user stories, priorities, acceptance criteria, risks, and non-functional requirements.
- `arquitetura.html`: update the technical architecture, components, data, processes, deployment, integrations, security, testing, and evolutionary direction.

The approved decisions in this prompt take precedence over conflicting proposals in `pesquisa-arquitetura.html` and over obsolete decisions in the current documents. The research is advisory evidence, not blanket approval of every proposal.

Do not modify application code, dependencies, configuration, schemas, tests, external assets, or any file other than the three target HTML documents. If an external asset must change, stop and request a revised scope.

## Mandatory approval checkpoint

Do not edit any file during the first phase.

First:

1. Inspect only the relevant sections of the four listed documents.
2. Identify every conflict between the current documents and the approved decisions below.
3. Present a complete implementation plan by target file.
4. Include the rationale, exact affected sections, risks, verification steps, and the exact proposed diff or replacement text.
5. Wait for the explicit authorization required by `AGENTS.md`.

Do not ask the user to reconfirm decisions already recorded below. Ask one concise question only if an unforeseen conflict cannot be resolved without changing an approved decision.

After authorization, implement only the approved document changes and run the approved verification.

## Approved product scope

The product is an analytical personal-finance application for individual users.

Each tenant represents exactly one individual user's financial workspace. Do not add members, invitations, organizations, shared portfolios, family accounts, professional profiles, or a future shared-account roadmap.

The academic MVP uses fictitious data only.

The MVP includes:

- Individual authentication.
- Manual financial-account registration.
- Manual income, expense, and transfer registration.
- Categories and user-defined categorization rules.
- A consolidated financial dashboard.
- OFX statement import with validation, preview, and duplicate handling.
- Pluggy Sandbox integration.
- Automatic daily Pluggy synchronization.
- User-triggered manual synchronization.
- Idempotency and protection against duplicate or overlapping synchronization runs.
- Investment positions and information made available by Pluggy Sandbox.
- Portfolio total, allocation by asset class and institution, positions, quantity or balance, invested amount and result when provided, reference date, investment movements when available, and fixed-income rate, index, and maturity when supplied.
- Explicit indication of missing, unavailable, or stale investment fields.
- Manual registration of assets, financing, and liabilities.
- Net-worth calculation.
- Deterministic net-worth projections based on available history or user-supplied assumptions.
- Clear projection horizon, assumptions, uncertainty notice, and statement that projections are not guarantees or personalized financial advice.
- Technical audit trails for relevant business actions.

The MVP does not include:

- PDF statement parsing. Keep it for SaaS evolution.
- Tax estimates, the “Impostômetro,” or a fiscal module. Tax estimation is only a possible future SaaS capability, not a committed feature.
- Product notifications or financial alerts.
- Product email. Essential account-lifecycle emails managed by Auth0 may remain.
- Stripe or subscription billing.
- Payment initiation, Pix transfers, or any movement of funds. These are permanently outside the product because it is analytical, not a banking application.
- Suspicious-transaction or fraud detection unless separately approved in the future.
- An administrator actor, administrator account, administration API, or administration panel.
- Redis or another distributed cache.
- CQRS or Event Sourcing.
- GraphQL or gRPC.
- Full event-driven orchestration.
- Real customer financial data.

Operational work does not require a custom administration panel. Initially use provider consoles, logs, metrics, versioned scripts, migrations, seeds, and controlled runbooks. A future backoffice is optional and must only be introduced if a demonstrated operational need justifies it.

## Approved solution topology

Use exactly three main repositories:

1. Web application.
2. Mobile application.
3. Backend.

Keep API contracts, database migrations, initial infrastructure and deployment definitions, and security configuration with the backend repository. Do not introduce separate shared-schema, infrastructure, security, or UI repositories.

The applications are independently versioned and deployed:

- Web: Next.js with TypeScript, deployed to Vercel.
- Mobile: React Native with Expo, distributed through Expo/EAS.
- Backend: NestJS with TypeScript, packaged as a container and deployed to Google Cloud Run.

Web and mobile are independent applications. They may share the documented visual identity and the OpenAPI contract, but not source code, UI components, or navigation code. Remove Solito and Tamagui as mandatory architectural decisions.

The MVP has two environments:

- Local development.
- Academic demonstration.

Separate staging and production environments become mandatory when the product evolves into a SaaS.

Each repository has an independent GitHub Actions pipeline. Pull requests run relevant linting, tests, and builds. Deployment to the academic environment occurs only after approval and merge into the main branch.

For the MVP, version only the container definition, deployment configuration, environment-variable examples, and reproducible deployment instructions. Do not require Terraform or OpenTofu in the MVP. Infrastructure as Code becomes mandatory when structuring the SaaS environments.

## Approved backend architecture

Describe the backend as:

“Modular Clean/Hexagonal Architecture, initially deployed as a single serverless NestJS service, with evolutionary extraction of modules and selective adoption of events only when justified by demonstrated needs.”

Do not reduce this description to an unqualified “monolith.” Distinguish deployment topology from internal code architecture.

Use one NestJS deployment for the MVP, organized into these business modules:

- `Identity`: Auth0 identity association, user, and individual tenant.
- `Accounts`: manual and connected financial accounts.
- `Transactions`: income, expenses, transfers, categories, and categorization rules.
- `Ingestion`: OFX import and scheduled or manual Pluggy synchronization.
- `Investments`: positions and investment information.
- `Patrimony`: manually registered assets, financing, and liabilities.
- `Analytics`: dashboards, consolidation, net-worth calculations, and projections.
- `Audit`: relevant business audit trails.

These are logical modules within the same deployable backend.

Each module owns its tables and repository implementations. Modules communicate only through explicit public application interfaces or justified asynchronous events. Do not permit direct access to another module's repositories or internal tables.

Use pragmatic Clean/Hexagonal boundaries:

- Domain: business entities, value objects, rules, and invariants.
- Application: use cases and orchestration.
- Inbound adapters: REST controllers, scheduled-job entry points, and QStash handlers.
- Outbound adapters: Prisma, Auth0, Pluggy, Cloudflare R2, and QStash.

Dependencies point toward the application core and domain. The domain must not import NestJS, Prisma, PostgreSQL, Auth0, Pluggy, QStash, R2, Zod, or OpenAPI concerns.

Create ports only at genuine external or cross-module boundaries. Do not create empty layers, speculative abstractions, placeholder modules, or one interface per class merely to imitate Clean Architecture.

Do not create MVP modules for taxation, billing, notifications, administration, shared accounts, or future AWS services.

## API and validation

Expose a REST API versioned under `/api/v1`.

Maintain OpenAPI as the backend-owned API contract and use it to generate typed clients for web and mobile. No particular client-generator library has been approved; do not invent one in the documents.

Use Zod for runtime validation at backend boundaries. Zod schemas belong to presentation or adapter boundaries and must not become domain entities. Do not restore a cross-repository package of shared Zod schemas.

Use synchronous REST for operations that require an immediate user response. Use asynchronous processing only for genuinely asynchronous or long-running work.

## Data and tenancy

Use Prisma with PostgreSQL hosted on Neon for the MVP.

Prisma is an infrastructure adapter. Business modules depend on repository ports rather than directly on Prisma.

Use a shared PostgreSQL schema for the initial backend. Every tenant-owned record must carry an unambiguous `tenant_id` directly or through an enforced ownership relationship.

Use defense in depth:

- NestJS authenticates and authorizes every request.
- PostgreSQL Row-Level Security protects tenant-owned data.
- Prisma migrations may include reviewed custom SQL required to create and maintain RLS policies.

Do not refer to Supabase Auth, Supabase Storage, Supabase Edge Functions, Supabase Realtime, Supabase-specific RLS tooling, or Supabase database paths as the target architecture.

PostgreSQL remains the source of truth. Do not add Redis in the MVP. Begin with appropriate indexes, pagination, query optimization, and precomputed data only where an approved requirement needs it.

A cache abstraction may be introduced later only if measurements demonstrate a need. Possible future services such as Upstash Redis or Amazon ElastiCache must remain conditional, not planned migrations.

## Authentication and authorization

Use Auth0 for MVP identity through standards-based OAuth 2.0, OpenID Connect, and JWT validation.

Auth0 handles identity. NestJS and PostgreSQL handle authorization, tenant isolation, ownership, and audit rules.

Keep authentication integration standards-first and avoid embedding product authorization rules into Auth0-specific configuration.

Amazon Cognito is only a future alternative to evaluate if AWS consolidation creates a demonstrated benefit. Do not describe migration to Cognito as an approved roadmap commitment.

## Asynchronous work and events

Use Upstash QStash in the MVP for:

- Daily Pluggy Sandbox synchronization.
- Manual synchronization requests.
- Long-running imports.
- Long-running calculations when needed.
- Controlled retries.

Jobs contain identifiers and minimal routing metadata only. They must not contain Pluggy tokens, secrets, or unnecessary financial payloads.

Handlers must be idempotent and protect against duplicate and concurrent execution.

The MVP is not a fully event-driven system and does not use an event bus as its primary communication mechanism. Preserve synchronous transactional processing where appropriate.

Describe the evolutionary AWS mapping accurately:

- EventBridge Scheduler for schedules.
- Amazon SQS for durable job queues.
- EventBridge Event Bus only when real fan-out or multiple independent consumers exist.

Do not describe QStash as mapping exclusively to EventBridge Event Bus.

Future events, service extraction, CQRS, streaming, or broker changes require demonstrated needs such as independent scaling, fault isolation, several consumers, deployment autonomy, or measured bottlenecks. They are not automatic phases or mandatory migrations.

## File storage

Use Cloudflare R2 for MVP object storage. PostgreSQL stores object metadata and references, not file contents.

Amazon S3 is the intended storage direction if the SaaS is later structured on AWS.

Respect approved lifecycle rules for imported files and never expose sensitive object-storage credentials to clients.

## Observability and audit

The MVP uses minimal observability:

- Structured JSON logs from NestJS to standard output and Google Cloud Logging.
- Native Google Cloud Run metrics.
- Business audit records persisted in PostgreSQL.

Technical logs and business audit records are distinct.

Do not log secrets, tokens, complete transaction descriptions, financial payloads, or unnecessary personal data.

Audit records should use minimal metadata such as actor, tenant, action, resource, timestamp, outcome, and request or correlation identifier.

OpenTelemetry, distributed tracing, Grafana, Datadog, ELK, and SIEM are deferred until distributed topology, operational scale, or a demonstrated need justifies them.

## Security and privacy

The MVP baseline includes:

- HTTPS/TLS.
- Auth0 authentication.
- NestJS authorization.
- Tenant isolation.
- PostgreSQL RLS.
- Strict input validation.
- Secrets outside source control.
- No sensitive information in logs.
- Least-privilege access.
- Audit trails for relevant actions.

Advanced controls such as WAF, mandatory MFA, SAST/DAST, SIEM, formal penetration tests, and formal retention policies are required before or during SaaS production according to risk, but are not academic MVP functionality.

Because the MVP uses fictitious data, it has no formal operational RPO/RTO commitment and no custom backup routine.

For SaaS evolution, make the following mandatory:

- RPO of 24 hours.
- RTO of 8 hours.
- Automated backups.
- Restore tests.
- Documented recovery runbooks.
- Full LGPD workflows for access, correction, export, deletion, and consent where applicable.
- Separate staging and production environments.
- Security controls appropriate to real financial data.

## Investment-data evolution

For the academic MVP, use Pluggy Sandbox investment data and explicitly represent provider limitations, reference dates, missing fields, and data quality.

Prepare provider-neutral concepts where appropriate, including:

- source;
- external identifier;
- asset type;
- reference date;
- currency;
- data quality.

Do not couple the domain to a particular market-data provider.

For the first SaaS evolution, plan for:

- Real Pluggy investment positions.
- Official Banco Central do Brasil public APIs for Selic, PTAX, currencies, and reference indicators.
- CVM open data for fund registry and daily fund quotas, acknowledging ETL, CNPJ mapping, and publication lag.
- Official Tesouro Direto price and rate history.

Later SaaS evolution may add licensed B3 market-data distribution for stocks, FIIs, ETFs, and BDRs. Do not recommend scraping or unofficial production sources.

Cryptocurrency coverage is conditional on demonstrated demand.

Defer private fixed-income mark-to-market, COE valuation, options and derivatives, detailed pension valuation, and tax calculation because they require additional data, methodology, licensing, or regulatory maintenance.

## Billing and notifications in SaaS

Stripe subscription billing is outside the MVP and may be introduced only with the SaaS.

Product notifications may be implemented in the SaaS, but product email is not required. Essential authentication and account-lifecycle emails may continue to be handled by Auth0.

Do not conflate subscription billing with movement of user funds. Payment initiation and Pix transfers remain permanently excluded.

## Quality objectives

Treat these as hypotheses or objectives to validate, not guarantees produced by architecture alone:

- Up to 10,000 transactions per user in the defined test dataset.
- P90 response time below two seconds for the defined dashboard scenario.
- 99.5% monthly availability as a SaaS operational target.

Document the test conditions, dataset assumptions, and measurement boundary. Do not claim these objectives have been achieved without executed evidence.

RPO 24 hours and RTO 8 hours are mandatory SaaS recovery objectives, not MVP guarantees.

## Testing direction

Document this backend testing strategy:

- Vitest for unit and integration tests.
- Supertest for critical REST end-to-end tests.
- Unit tests for domain rules and application use cases.
- Integration tests for Prisma and PostgreSQL.
- Explicit tenant-isolation and RLS tests.
- Contract tests for OpenAPI and generated clients.
- Adapter tests using mocks, fakes, or Pluggy Sandbox as appropriate.
- End-to-end tests only for critical user flows.
- An academic dataset with 10,000 transactions to evaluate the latency objective without guaranteeing the result in advance.

Do not prescribe unapproved web or mobile testing libraries.

## Document-specific changes

### `visao.html`

Align the product statement with individual personal-finance analysis.

Remove family, professional, organization, shared-account, and administrator implications.

Clearly separate:

- Academic MVP.
- Mandatory SaaS evolution.
- Optional future capabilities.

Update affected functional scope, stakeholders, quality objectives, constraints, risks, and revision history.

### `prd.html`

Align actors, user stories, priorities, acceptance criteria, business rules, dependencies, and non-functional requirements with the approved scope.

Remove the administrator as a required actor.

Replace Supabase UID paths and Supabase-specific security rules with the approved tenant, NestJS, Auth0, Prisma, PostgreSQL, and RLS model.

Keep OFX in the MVP and move PDF parsing to SaaS.

Keep assets, financing, liabilities, dashboard, and transparent projections in the MVP.

Move tax estimation, alerts, notifications, billing, real market data, and real Pluggy data to their approved phases.

Permanently exclude payment initiation and Pix movement.

Do not add unapproved functionality merely because it appears in the research.

### `arquitetura.html`

Replace the obsolete Serverless Event-Driven monorepo/Supabase design with the approved three-repository topology and Modular Clean/Hexagonal backend architecture.

Update affected architecture views, decision tables, component responsibilities, domain model, process flows, data policies, deployment view, integrations, security, observability, tests, risks, references, diagrams, and revision history.

Make synchronous REST and selective QStash processing explicit.

Show the evolutionary direction without presenting microservices, events, AWS migration, Cognito, Redis, CQRS, Event Sourcing, or an administration panel as inevitable.

Do not claim a technology migration is approved when it is only a future evaluation.

## Presentation constraints

Preserve the documents' established academic identity and existing visual system:

- Page structure.
- Typography.
- Colors.
- Responsive behavior.
- Theme toggle.
- Search.
- Internal navigation.
- Print-oriented presentation.
- Existing accessibility behavior.

Change styles or scripts only when strictly necessary to prevent layout breakage caused by the approved content changes.

Do not rewrite an entire file when targeted content changes are sufficient. Preserve unrelated content and user work.

Update tables and diagrams only where their meaning conflicts with the approved architecture. If a required diagram is stored outside the three authorized HTML files, stop and request expanded scope before editing it.

Update each affected revision-history table with a concise description of the alignment.

## Evidence and epistemic discipline

Separate established requirements, architectural decisions, hypotheses, and conditional future possibilities.

If available information is insufficient to conclude, say so instead of inferring.

Do not propagate unsupported cost, SLA, performance, compliance, encryption, or provider-limit claims from the research as established facts.

When adding or retaining externally verifiable technical claims, prefer the official references already cited by the research. If further verification is necessary but internet access is unavailable, mark the claim as requiring verification instead of inventing a source.

Do not invent library names, provider limits, regulatory guarantees, implementation status, test results, or unapproved roadmap commitments.

## Acceptance criteria

The work is complete only when:

- `pesquisa-arquitetura.html` is unchanged.
- Only the three authorized target documents are modified.
- Vision, PRD, and architecture describe the same academic MVP.
- All three documents consistently distinguish mandatory SaaS evolution from optional future possibilities.
- No required functionality implies shared accounts, organizations, administrators, banking operations, or movement of funds.
- No active target architecture depends on Supabase, a monorepo, Solito, Tamagui, or shared source packages.
- The backend is consistently described as Modular Clean/Hexagonal Architecture in one initial NestJS deployment.
- Event-driven processing is selective rather than the default communication model.
- All approved infrastructure, data, authentication, storage, queueing, security, testing, and investment-data decisions are represented consistently.
- Obsolete user stories, actors, diagrams, tables, references, and deployment descriptions are removed or corrected.
- Revision histories reflect the update.
- Existing theme, search, navigation, accessibility, responsiveness, and academic layout still work.
- No implementation work or unrelated cleanup is introduced.

## Verification

Before editing, discover and report any repository-provided HTML validation or rendering checks. Do not add or change tests without authorization.

After implementation:

1. Validate the structure of all three HTML documents.
2. Test internal navigation, search, and theme switching.
3. Render each document at desktop and mobile viewport sizes.
4. Inspect tables, pagination, diagrams, overflow, clipping, and truncated text.
5. Search all three documents for obsolete or contradictory decisions.
6. Cross-review vision, PRD, and architecture against this prompt.
7. Confirm that `pesquisa-arquitetura.html` is unchanged.
8. Report every command and visual check actually performed; do not claim checks that were not run.

If a relevant check repeatedly fails because of a requirement outside the authorized scope, stop and report the blocker rather than using destructive shortcuts or modifying unrelated files.

## Final response

After authorized implementation and verification, report only:

- The documentation inconsistencies corrected.
- The files changed.
- The validations actually performed and their results.
- Any remaining risks, open verifications, or deviations.
```

## Decision record

| Slot | Value | Source |
|---|---|---|
| File template boilerplate | Header metadata and paste instructions | template |
| Scenario | Coordinated code-change/documentation-alignment task | approved default |
| Research authority | Research is read-only and advisory; every implemented decision requires approval | user-stated |
| Target documents | `visao.html`, `prd.html`, and `arquitetura.html` | user-stated |
| Repository topology | Exactly three main repositories: web, mobile, and backend | user-stated |
| Backend | NestJS with TypeScript | user-stated |
| Internal architecture | Modular Clean/Hexagonal Architecture with pragmatic ports and adapters | approved default |
| Initial deployment topology | One NestJS service; selective extraction only after demonstrated need | approved default |
| Domain modules | Identity, Accounts, Transactions, Ingestion, Investments, Patrimony, Analytics, and Audit | approved default |
| Module ownership | Private tables and repositories; communication through public application interfaces or justified events | approved default |
| Persistence | Prisma as an infrastructure adapter with Neon PostgreSQL | user-stated |
| Tenancy | One tenant per individual user; no sharing roadmap | user-stated |
| Isolation | NestJS authorization plus PostgreSQL RLS using reviewed SQL migrations | approved default |
| API | REST under `/api/v1` with backend-owned OpenAPI and generated typed clients | approved default |
| Boundary validation | Zod without cross-repository source sharing | approved default |
| Web | Next.js and TypeScript on Vercel | approved default |
| Mobile | React Native and Expo/EAS | approved default |
| UI sharing | No Solito, Tamagui, shared navigation, or shared component source | approved default |
| MVP backend hosting | Google Cloud Run | approved default |
| MVP object storage | Cloudflare R2; metadata in PostgreSQL | approved default |
| MVP identity | Auth0 through OAuth 2.0/OIDC/JWT | approved default |
| Async MVP | QStash for scheduled and long-running jobs | approved default |
| Pluggy MVP | Sandbox with automatic daily and manual idempotent synchronization | user-stated |
| Investment evolution | Pluggy real data, official BCB/CVM/Tesouro sources, and later licensed B3 data | approved default |
| Redis | Not used in the MVP; conditional future adoption based on measurements | user-stated |
| Academic data | Fictitious data only | user-stated |
| MVP imports | OFX included; PDF deferred to SaaS | approved default |
| MVP patrimony | Manual assets, financing, and liabilities included | user-stated |
| MVP projections | Deterministic, transparent, and non-advisory | approved default |
| Tax estimates | Possible SaaS feature, outside the initial version | user-stated |
| Notifications | Possible SaaS feature; no product email requirement | user-stated |
| Billing | Stripe only in SaaS | user-stated |
| Money movement | Pix and payment initiation permanently excluded | user-stated |
| Administration | No mandatory administrator actor, account, API, or panel at any phase | user-stated |
| Observability | JSON logs, Cloud Run metrics, and PostgreSQL audit records | approved default |
| MVP recovery | No formal RPO/RTO commitment or custom backup routine | user-stated |
| SaaS recovery | Mandatory RPO 24h, RTO 8h, backups, restore tests, and runbooks | user-stated |
| Environments | Local and academic demonstration in MVP; staging and production mandatory for SaaS | approved default |
| CI/CD | Independent GitHub Actions pipelines with PR checks and post-merge deployment | approved default |
| Infrastructure as Code | Deferred from MVP; mandatory when structuring SaaS | approved default |
| Backend tests | Vitest, Supertest, integration, contract, isolation, and critical E2E coverage | approved default |
| Quality objectives | 10,000 transactions, P90 below two seconds, and 99.5% SaaS availability are objectives to validate | approved default |
| SaaS cloud direction | AWS may structure the future SaaS; only explicitly approved mappings are committed | user-stated |
| Future AWS async mapping | EventBridge Scheduler, SQS, and EventBridge Event Bus only for real fan-out | approved default |
| Auth evolution | Cognito is an option to evaluate, not a planned migration | approved default |
| Document presentation | Preserve the existing visual, responsive, accessible, searchable, and print-oriented structure | approved default |
| Verification | Structural, functional, visual, overflow, contradiction, and cross-document checks | approved default |
| Save path | `prompts/update-architecture-documents.md` | approved default |
