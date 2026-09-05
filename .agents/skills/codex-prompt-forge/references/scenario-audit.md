# Scenario: Audit (review of code, security, performance, data quality)

Risk profile: twin failure modes — false negatives (missed defects) and false
positives (a reviewer told to find gaps will find some even in sound work).
Rigidity: high, with an explicit epistemic out. Frame the session as
high-recall triage feeding human review or static analysis — not as an
oracle.

## Required slots

| Slot | Ask (in the user's language) | Default when the user cannot answer |
|---|---|---|
| Material | What is under review (diff, PR, files, pipeline)? | none — must be user-stated |
| Review scope | Security, performance, code quality, data quality — which? (multiSelect) | security + correctness for code material; data-quality checklist for pipelines |
| Out of scope | What should not be flagged? | style and preference comments are out of scope |
| Severity scale | Which scale for findings? | critical / high / medium / low |
| Output destination | Report in chat or to a file? | findings report in chat |

## Prompt skeleton

```
<role>Senior code reviewer / security engineer.</role>

<material>{FILES OR DIFF UNDER REVIEW}</material>

<scope>Review for: {SELECTED SCOPES}. Out of scope: {EXCLUSIONS}.</scope>

<review_checklist>
- Security: injection (SQL/XSS/command), authn/authz flaws, secrets in code,
  unsafe data handling.
- Performance: complexity, N+1 queries, allocations, I/O inside loops.
- Data quality/pipeline: schema, nulls, duplicates, row-multiplying joins,
  timezone/encoding, idempotency.
</review_checklist>

<epistemics>
- It is acceptable and expected to report no findings in a category.
- Report only findings that affect correctness, security, or the stated
  requirements; do not list preferences.
- For each claim, quote the exact excerpt; without evidence in the material,
  do not make the claim.
</epistemics>

<output_format>
Per finding: [Severity: {SCALE}] | file:line | quoted excerpt | description |
suggested fix. If nothing is found, say so explicitly.
</output_format>
```

Keep only the checklist lines matching the selected scopes.

## Standard clauses (provenance: template)

- Directed taxonomy per scope — raises recall compared with an open "is this
  secure?".
- Permission to find nothing, plus the findings-that-matter filter — the
  mechanism that controls false positives.
- Evidence per finding: severity, file:line, quoted excerpt, suggested fix.

## Assembly notes

- Add to How-to-use: run the audit in a new task that sees only the material
  and criteria, not the reasoning that produced the change — an author
  reviewing its own work is biased.
- If the user is auditing work produced in their current session, make the
  fresh-context recommendation explicit and firm.
