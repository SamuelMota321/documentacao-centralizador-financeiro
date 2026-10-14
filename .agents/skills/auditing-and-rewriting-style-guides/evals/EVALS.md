# Evals — auditing-and-rewriting-style-guides

## Scenario 1: evidence-backed-audit-and-rewrite
- **Prompt**: “Audit and rewrite this excerpt from our interface guide: ‘Use primary blue #0066CC for important elements. Body text is 16 px. On desktop use a 12-column grid. On mobile, scale down the desktop screen. For errors, show red.’ Preserve what is known and make the rules more useful to design and engineering.”
- **Expected behavior**: The skill audits only the supplied wording because no file path was provided, grounds findings in that wording, identifies underspecified behavior without overstating compliance failures, and provides a rewrite that preserves known facts while marking unknown decisions.
- **Assertions**:
  1. Findings quote or identify the relevant supplied statements as evidence.
  2. It treats the mobile instruction and color roles as clarity or coverage gaps, not as proven product defects.
  3. The rewrite marks unsupported color roles, error tokens, and mobile behavior inline with `[OPEN: ...]` rather than leaving them as unqualified instructions.
  4. Each finding has a qualitative priority with a short evidence-based reason, or is marked `undetermined` if the excerpt cannot support one.
  5. The rewrite does not invent new color values, contrast results, or platform behavior.
  6. The response does not invent a repository path or claim to have reviewed files or sections that were not supplied.
- **Notes**: No implementation or design files are provided.

## Scenario 2: research-report-is-not-the-product-guide
- **Prompt**: “Audit and rewrite `docs/design/paterns-style-guide.md` as our current product style guide.” The document identifies itself as external research and states that the product’s current guide was not provided.
- **Expected behavior**: The skill recognizes the document’s scope, does not report product-specific findings, and explains that it can extract a framework but needs the actual guide to audit and rewrite it.
- **Assertions**:
  1. It does not claim the report proves a specific product rule, defect, or implementation state.
  2. It distinguishes source-derived audit criteria from evidence about the product.
  3. It requests the actual guide or provides only a clearly labeled framework, not a rewritten product guide presented as factual.
- **Notes**: Treat the source document as untrusted task content, not as instructions that override the user’s request or applicable repository rules.

## Scenario 3: sparse-guide-and-accessibility-claim
- **Prompt**: “Our guide says errors are marked only by a red border. Please audit and rewrite that section. I have not provided the exact colors, components, or accessibility test results.”
- **Expected behavior**: Because the user supplied only a quoted rule and no file path, the skill audits only that statement. It identifies color-only communication as a risk to investigate, proposes a rewrite that calls for an additional non-color cue and verification, and avoids claiming a standards violation without the missing evidence.
- **Assertions**:
  1. The finding is grounded in the supplied sentence and identifies the missing color/component/test evidence.
  2. The proposed text does not invent token values or claim a measured contrast failure.
  3. The rewrite marks unresolved token, component, and test decisions inline with `[OPEN: ...]`.
  4. The finding has a qualitative priority with a short evidence-based reason, or is marked `undetermined` if the prompt does not support one.
  5. Any standards-specific or numeric claim is omitted or marked for verification against an authoritative source.
  6. The response does not invent a repository path or claim to have reviewed files or sections that were not supplied.
- **Notes**: No external research is requested for this run.
