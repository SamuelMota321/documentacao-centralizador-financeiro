# Delivery

## Completion Criteria

A task is complete when:
* the approved requirement is implemented;
* acceptance criteria are satisfied;
* architectural boundaries remain valid;
* relevant validation has passed or unresolved validation limitations are reported;
* no known implementation work remains inside the approved scope.

Once these conditions are met, stop.
Do not continue with optional improvements unless the user explicitly requests another task.

---

## Final Response

After implementation, report only information useful for review.

Include:

### Cause
The root cause or reason for the change, when applicable.

### Changed Files
The files changed and the purpose of each change.

### Validation
The tests, type checks, linters, builds, or other validations actually executed and their results.

### Remaining Risks
Known limitations, validation gaps, assumptions, migration concerns, or residual risks.
Do not:
* restate the original request;
* repeat the approved plan;
* reproduce large diffs;
* output unchanged code;
* include long explanations unless specifically requested.

### Commit
Make a commit suggestion for implemented work