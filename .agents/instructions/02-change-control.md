# Change Control

## Scope and Change Control

* Modify only the files and behavior necessary for the approved requirement.
* Do not perform opportunistic refactors.
* Do not combine functional changes with unrelated formatting, cleanup, dependency upgrades, or architectural restructuring.
* Do not rewrite an entire file when a localized change is sufficient.
* Avoid multiple implementation alternatives once a safe and appropriate approach is established.
* If the requested approach is unsafe, architecturally incompatible, or infeasible, explain the issue and propose the smallest viable alternative.
* Once acceptance criteria are met and validation is sufficient for the change's risk and blast radius, stop.

---

## Destructive and High-Risk Operations

Treat the following as high-risk operations:
* database writes against shared or production environments;
* destructive migrations;
* schema deletion or irreversible transformation;
* data deletion;
* infrastructure changes;
* deployments;
* production configuration changes;
* credential or secret changes;
* permission or access-control changes;
* dependency upgrades with material compatibility impact;
* force pushes or destructive Git operations;
* external API actions with irreversible effects.
* Do not execute a high-risk or destructive operation unless it is explicitly included in the approved implementation plan.
* Prefer reversible and idempotent operations when possible.
* When an operation has meaningful rollback requirements, include the rollback strategy in the plan.
* Never imply that a destructive operation is safe solely because the command itself succeeds.

---

## Ponytail plan audit

For any task that proposes code changes, load and apply the `ponytail` skill before presenting the plan. Audit reuse, scope, affected callers and tests, validation, and security or data-loss risks; report material findings in the plan. If the skill is unavailable, say so and apply these checks directly. This audit does not authorize implementation or replace the exact approval required below.

## Mandatory Approval Gate

### Read-Only Phase

* Never modify code, files, dependencies, configurations, schemas, tests, data, infrastructure, or external systems before explicit approval.
* Before implementation, inspect only the context required to produce a reliable plan.
* Planning, investigation, analysis, code examples, proposed code, and proposed diffs are read-only activities and do not authorize file changes.

### Required Plan

Before implementation, present a concise but complete implementation plan containing:
* problem or root cause;
* proposed solution;
* rationale;
* affected files;
* step-by-step changes;
* architectural impact, when relevant;
* risks;
* validation strategy;
* exact code, patch, or diff to be applied when practical.

For large changes, the proposed diff may be represented by precise code sections or file-level modifications when a literal full diff would create unnecessary noise.

### Authorization

Wait for the exact authorization:

`planejamento aprovado, pode implementar`

Do not treat responses such as:
* `ok`
* `certo`
* `continue`
* `pode seguir`
* `parece bom`
* `entendi`

or similar messages as implementation approval.

### Implementation

After approval:
* Implement only the approved scope, files, behavior, and steps.
* Do not repeat the full plan before implementation.
* Do not include unrelated refactors, cleanup, features, abstractions, or dependency changes.
* If implementation reveals that a material change to the approved plan is required, stop before making that change and request approval for the revised plan.

A material change includes changes to:
* scope;
* observable behavior;
* architecture;
* affected files outside the approved set;
* dependencies;
* public interfaces;
* schemas;
* persistence;
* security;
* tests representing a changed behavioral contract;
* high-risk operations.

Mechanical or non-semantic changes inside approved files generally do not require reapproval, including:
* formatter output;
* import ordering;
* equivalent whitespace changes;
* generated syntax adjustments required by repository tooling.

---

## Implementation Discipline

* Implement the approved solution directly.
* Prefer localized edits.
* Preserve nearby conventions.
* Avoid speculative improvements.
* Keep newly introduced functions and modules no broader than required.
* Do not output unchanged code or full files unless requested.
* Do not introduce TODOs for work that is required to satisfy the approved acceptance criteria.
* Do not leave the repository in an intentionally intermediate state unless the approved plan explicitly defines incremental steps.

---

