# Evaluation results — writing-digital-style-guides

Paired qualitative smoke evaluation, 2026-10-12. Each response was generated in a fresh subagent context using only the scenario prompt; the baseline received no skill, and the skill run received this skill. Assertions were applied after generation. This is a small diagnostic set, not a statistical measure. One run per scenario.

| Scenario | Baseline | With skill | Observed difference |
|---|---|---|---|
| create-from-product-facts | Mostly useful; did not consistently distinguish proposed interpretations from approved facts or make unresolved exceptions actionable. | Pass: separated shared and platform guidance, kept unapproved design values open, and gave proposed rules with application/verification and `[OPEN]` exceptions. | Skill made provenance and unresolved decisions easier to apply. |
| insufficient-product-context | Fail: supplied concrete colors, font, type sizes, and spacing values as proposed defaults despite missing product inputs. | Pass: used an outline with `[OPEN]` fields and asked for missing high-impact context without inventing values. | Clear improvement: avoided plausible but unsupported product decisions. |
| research-report-as-reference | Pass on core scope: did not present the external report as product evidence. | Pass: explicitly separated report-derived recommendations from product facts and left product decisions open. | Both avoided the central error; skill output made source boundaries more operational. |

## Limitations

- The set covers three prompts and one generation per condition; results are qualitative and may vary by model or prompt.
- Passing these scenarios does not establish general correctness of style-guide content or accessibility compliance.
- Standards claims and product-specific facts still require source verification in the actual task.
