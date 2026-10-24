# Engineering Principles

## Core Engineering Principles

* Reuse existing code, patterns, utilities, abstractions, and dependencies before creating new ones.
* Make the smallest change that fully solves the approved requirement.
* Do not add features, abstractions, dependencies, refactors, or cleanup outside the requested and approved scope.
* Keep changes atomic, focused, reviewable, testable, and easy to revert.
* Preserve existing behavior unless the approved requirement explicitly requires changing it.
* Follow the repository's existing architecture, naming, formatting, conventions, and established patterns.
* Prefer simple, readable, explicit solutions over clever, overly generic, or speculative abstractions.
* Apply KISS and YAGNI. Do not design for hypothetical requirements that are not part of the current task.
* Keep functions, classes, modules, and components focused on a clear responsibility.
* Remove code made unused directly by the approved change, but do not perform unrelated cleanup.
* Use meaningful names.
* Avoid comments that merely restate what the code does.
* Comment non-obvious business rules, constraints, invariants, compatibility requirements, or architectural decisions when the code alone cannot communicate them clearly.
* Do not leave commented-out implementation code in the repository.

---

## Architecture and Dependency Boundaries

* Preserve the repository's established architectural boundaries.
* Place logic in the layer or module responsible for that concern.
* Keep domain or Core logic independent from UI frameworks, databases, transport protocols, persistence implementations, infrastructure libraries, and framework-specific concerns unless the repository's established architecture explicitly defines otherwise.
* Dependencies should point toward more stable business rules rather than forcing business rules to depend on implementation details.
* Do not bypass established layers merely because doing so produces a shorter implementation.
* Do not move business logic into controllers, UI components, database adapters, route handlers, or infrastructure code when an appropriate domain or application layer exists.
* Do not introduce a new architectural pattern, layer, service boundary, repository abstraction, event system, queue, cache, persistence mechanism, framework, or integration style unless the existing architecture cannot reasonably satisfy the approved requirement.

* Any new architectural mechanism must be explicitly justified during planning with:
  * the problem it solves;
  * why the existing architecture is insufficient;
  * the added complexity;
  * the affected boundaries;
  * operational consequences;
  * testing implications.

* Prefer extending an established architectural pattern over introducing a competing one.

---

## Type Safety and Error Handling

### TypeScript

* Do not use `any`.
* Prefer explicit types whenever practical.
* Use `unknown` for untrusted or structurally uncertain data and validate or narrow it before use.
* Preserve or improve existing type guarantees when modifying code.
* Do not weaken types merely to satisfy the compiler.

### Errors

* Prefer explicit exceptions, typed errors, discriminated unions, result types, or another repository-established error mechanism over silent failure.
* Avoid ambiguous `null`, `undefined`, boolean flags, or empty values when they cannot clearly communicate failure semantics.
* Preserve established error contracts unless an approved requirement changes them.
* Do not swallow errors without an explicit and justified reason.

---

