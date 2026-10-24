# Validation

## Tests as Behavioral Evidence

* Treat existing tests as strong evidence of the current behavioral contract.
* Prefer changing production code to satisfy valid existing tests when the approved requirement does not change that behavior.
* Do not modify tests merely to make a failing implementation pass.
* Tests may be incorrect, outdated, flaky, overly coupled to implementation details, or inconsistent with a more authoritative contract.

* If a test conflicts with:
  * an explicit approved requirement;
  * an API or schema contract;
  * a documented invariant;
  * verified expected behavior;

  identify the conflict before changing either the test or production code.

* When approved behavior changes, update or add tests that represent the new contract.
* Prefer tests that verify externally meaningful behavior rather than unnecessary implementation details.

---

## Validation Strategy

* Start with the narrowest validation relevant to the changed behavior.
* Expand validation according to the dependency impact, architectural importance, and blast radius of the change.

A typical progression is:
1. Targeted test for the changed behavior.
2. Tests for the changed module or package.
3. Relevant type checks or static analysis.
4. Relevant linting.
5. Tests for directly affected consumers.
6. Broader regression tests when the dependency impact justifies them.

* A localized change does not automatically require the entire repository test suite.
* A change to widely shared code, public contracts, schemas, Core logic, authentication, persistence, infrastructure, or cross-cutting utilities may require broader validation.
* Run only checks that are relevant to establishing confidence in the approved change.
* Do not claim that a command, test, lint, build, migration, or validation passed unless it was actually executed successfully.
* If a validation step cannot be executed, state that clearly and report the resulting residual risk.

---

