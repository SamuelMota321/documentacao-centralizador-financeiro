# Evaluation results — auditing-and-rewriting-style-guides

Paired qualitative smoke evaluation, 2026-10-12. Each response was generated in a fresh subagent context using only the scenario prompt; the baseline received no skill, and the skill run received this skill. Assertions were applied after generation. This is a small diagnostic set, not a statistical measure. One run per scenario; scenario 3 was rerun after correcting an observed path-invention failure.

| Scenario | Baseline | With skill | Observed difference |
|---|---|---|---|
| evidence-backed-audit-and-rewrite | Fail: inferred mobile behavior and color roles beyond the excerpt; omitted evidence-based priorities and open decisions. | Pass: grounded findings in the excerpt, used an undetermined priority where evidence was insufficient, and marked unsupported tokens/platform details `[OPEN]`. | Clear improvement in evidence boundaries and actionable uncertainty. |
| research-report-is-not-the-product-guide | Pass: recognized that the external report was not the actual product guide and requested product evidence. | Pass: separated report-derived audit criteria from product findings and requested the actual guide. | Both respected scope; skill supplied a more explicit audit framework. |
| sparse-guide-and-accessibility-claim | Initial skill run failed by inventing a guide path and claiming to inspect sections not supplied. After adding an explicit no-path safeguard, a clean rerun reviewed only the quoted statement and passed the scenario assertions. | Corrected run: grounded the finding in the excerpt, marked priority undetermined, proposed non-color cues and `[OPEN]` implementation/test details, and framed WCAG as a relevant reference rather than a compliance verdict. | The evaluation exposed a concrete path-hallucination risk; the instruction was revised and the corrected run passed. |

## Limitations

- The set covers three prompts and one generation per condition, except for the corrective rerun; results are qualitative and may vary by model or prompt.
- A standards reference in an answer does not replace checking applicability, version, and primary-source wording for the target product.
- No actual product implementation or full guide was audited in these evaluations.
