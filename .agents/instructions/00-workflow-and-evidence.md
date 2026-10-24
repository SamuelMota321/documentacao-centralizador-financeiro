# Workflow and Evidence

## Model Selection Gate

* Before planning, investigation, implementation, review, debugging, testing, or any other task activity, assess the task's complexity, ambiguity, risk, context size, and reasoning requirements.
* Determine whether the currently selected model and reasoning level are appropriate for the task.
* Prefer the fastest and least expensive model or reasoning level that can reliably complete the task without materially reducing correctness, safety, or implementation quality.
* If another available model or reasoning level would materially improve correctness, reliability, context handling, architectural reasoning, debugging capability, or efficiency, recommend the change before starting the task and briefly explain why.
* Do not recommend changing models when the current model is already appropriate.
* Model selection assessment is read-only and does not count as planning, investigation, or implementation.
* Never claim that a model change occurred unless the environment explicitly confirms it.
* If the environment does not allow the agent to change models directly, recommend the appropriate model or reasoning level to the user instead of assuming the change.
* After the model assessment, continue under the normal investigation, planning, approval, and implementation rules.

### Model Selection Heuristic

Use the following categories as guidance rather than rigid thresholds.

#### Low Complexity

Typical examples:
* Small text or configuration corrections.
* Localized renames.
* Simple styling adjustments.
* Small queries or isolated logic changes.
* Straightforward repository navigation.

Prefer a fast model with low or standard reasoning when it can perform the task reliably.

#### Moderate Complexity

Typical examples:
* Localized bug fixes.
* API endpoint changes.
* Component or service implementation.
* SQL involving multiple joins or business rules.
* Focused refactors.
* Integration with an existing repository pattern.
* Debugging involving several directly related files.

Prefer a balanced model with standard or medium reasoning.

#### High Complexity

Typical examples:
* Architectural decisions.
* Cross-layer or cross-service changes.
* Concurrency or race conditions.
* Security-sensitive changes.
* Performance investigations.
* Complex migrations.
* Large or risky refactors.
* Distributed-system behavior.
* Problems requiring broad repository understanding.

Prefer a strong reasoning model or higher reasoning level.

---

## Investigation and Context Management

* Read only the files required to understand and complete the current task reliably.
* Start with the file, component, module, error, endpoint, or symbol directly referenced by the request.
* Search incrementally.
* Follow direct dependencies first and expand the investigation only when evidence shows additional context is necessary.
* Prefer targeted searches for symbols, references, call sites, imports, types, routes, tests, configuration keys, and related identifiers instead of browsing directories broadly.
* Read only relevant sections of large files when the available tooling supports targeted reads.
* Do not reread files already inspected unless:
  * the file changed;
  * new evidence requires reevaluation;
  * a previously unseen interaction becomes relevant.
* Limit investigation to one likely path at a time and expand only when evidence disproves the current hypothesis.
* Stop investigating once enough evidence exists to produce a reliable plan or complete the approved implementation.
* Prefer repository tools, static analysis, tests, type checkers, linters, logs, and runtime evidence over manually guessing generated behavior.
* Summarize large command outputs, logs, stack traces, and test results instead of reproducing them verbatim.

---

## Requirements and Ambiguity

* Ask questions only when missing information materially blocks a safe, correct, or scope-compliant implementation.
* Ask the minimum number of concise questions required to unblock the task, preferably one at a time.
* Do not ask for information that can be determined safely from the repository, tests, schemas, documentation, configuration, or existing implementation.
* Do not guess business rules, destructive behavior, public contracts, security requirements, or architectural intent when multiple materially different interpretations remain plausible.
* For small, localized, and unambiguous tasks, do not produce unnecessary planning overhead beyond what is required by the Mandatory Approval Gate.

---

## Source of Truth and Conflict Resolution

Treat repository evidence according to its authority and relevance to the current task.

A useful default order is:

1. Explicit current user requirement.
2. Explicitly approved implementation plan.
3. Formal external or repository contracts, including:

   * API specifications;
   * schemas;
   * protocol definitions;
   * architecture decision records;
   * documented invariants;
   * compatibility requirements.
4. Existing tests.
5. Existing implementation.
6. Informal comments, examples, or outdated documentation.

This order is guidance, not permission to silently override contradictions.

* When two authoritative sources materially conflict, identify the conflict instead of silently choosing one.
* Do not change production behavior merely because an implementation differs from an informal example.
* Do not change tests merely because production code currently fails them.

* Explicitly surface conflicts that affect:
  * observable behavior;
  * public interfaces;
  * data compatibility;
  * security;
  * persistence;
  * architecture;
  * approved scope.

---

