# Scenario: Data Science (EDA, statistics, features, modeling, evaluation)

Risk profile: parametric tests applied without assumption checks, data
leakage, misleading point summaries, unfounded confidence. Rigidity: open in
exploration, strict in inference.

## Required slots

| Slot | Ask (in the user's language) | Default when the user cannot answer |
|---|---|---|
| Analytic question / hypothesis | What question should the analysis answer? | none — must be user-stated |
| Data dictionary | Variables: name, type, unit, meaning? | delegation: session reads the data source, builds the dictionary, and confirms it before analyzing |
| Sample, size, quality | Where is the data? Size, missingness, how collected? | delegation: session inspects with head/shape-style summaries and reports before analyzing |
| Method preferences | Required methods or libraries? | session chooses and justifies, subject to the assumption-check clauses |
| Split and leakage handling | Train/validation/test needs? | if modeling: session describes the split and where each transformation is fit, before running; pure inference: not applicable |
| Output form | Notebook or scripts? Interpretation depth? | commented executable code plus prose interpretation; figures saved to files |

## Prompt skeleton

```
<role>Senior data scientist with a strong statistics background.</role>

<data>
Dictionary: {VARIABLE: type, unit, meaning}
Sample (n={K} rows): {SAMPLE OR FILE PATH}
Size/quality: {N rows; % missing; collection notes}
</data>

<objective>{ANALYTIC QUESTION / HYPOTHESIS}</objective>

<method_requirements>
1. Before choosing any test or model, check its assumptions (normality,
   homoscedasticity, independence, balance) and report the results.
2. If assumptions fail, use and justify the alternative (e.g.
   non-parametric).
3. Report effect size and uncertainty (confidence intervals), not only
   p-values.
4. Prevent data leakage: describe the train/validation/test separation and
   where every transformation is fit.
5. Present at least one alternative approach and its trade-off.
</method_requirements>

<output_format>
- Executable {LIBS} code, commented where non-obvious; save figures to files.
- Prose interpretation: what the result means and what it does not mean.
- Explicit limitations and uncertainties.
</output_format>

<epistemics>If the data is insufficient to conclude, say so instead of
inferring.</epistemics>
```

## Standard clauses (provenance: template)

- Assumption checks before test/model selection, with a justified fallback.
- Leakage prevention (split description, transformation fitting).
- At least one alternative approach with its trade-off.
- Interpretation states what the result does not mean; limitations explicit.
- Insufficient-data epistemics clause.

## Assembly notes

- Keep the interpretation-and-limitations requirement even when the user only
  asked for code — the output is a starting point for a data scientist, not a
  replacement for one.
- Session data hygiene inside the prompt: inspect via head/shape-style
  summaries and targeted queries; do not dump large frames or secrets into
  context.
- Unless the study design supports it, the prompt forbids causal claims
  beyond the design.
