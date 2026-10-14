# Evals — writing-digital-style-guides

## Scenario 1: create-from-product-facts
- **Prompt**: “Draft a first version of a style guide for a budgeting product used on web and mobile. The product team supplied this approved context: the brand is calm and practical; the only approved color token is `color.action.primary`; the app supports desktop web, mobile web, and native iOS. We have no approved font, spacing scale, or contrast combinations yet. Make the guide useful to design and engineering.”
- **Expected behavior**: The skill creates an actionable first draft from supplied facts, distinguishes shared rules from platform-specific guidance, and leaves unapproved values open rather than inventing them.
- **Assertions**:
  1. The draft distinguishes shared guidance from at least one platform-specific consideration.
  2. It does not invent a font, numeric spacing scale, or color value.
  3. Any new interpretation of “calm and practical” is labeled as proposed rather than presented as approved brand policy.
  4. At least one concrete proposed rule includes its purpose and a way to apply or verify it, and marks an unresolved exception with `[OPEN: ...]`.
- **Notes**: No repository or external product files are assumed.

## Scenario 2: insufficient-product-context
- **Prompt**: “Create a complete style guide for my finance app. I have not provided the brand, target users, supported platforms, or any existing design decisions.”
- **Expected behavior**: The skill does not fabricate a brand system or supply unapproved example values as defaults. It asks only high-impact questions or provides a clearly marked scaffold with open fields.
- **Assertions**:
  1. No concrete brand colors, font names, typography scales, or spacing values are invented, even if labeled as unapproved defaults.
  2. Missing information is identified as questions or explicit open fields.
  3. A provided scaffold marks unresolved product decisions inline with `[OPEN: ...]`, rather than listing unqualified guide topics as if they were product guidance.
  4. The response still provides a useful next step, such as a guide outline or a short question set.
- **Notes**: The user has not supplied source material.

## Scenario 3: research-report-as-reference
- **Prompt**: “Use `docs/design/paterns-style-guide.md` to write our product’s style guide.” The referenced document is an external research report that explicitly says it did not inspect the product or its current guide.
- **Expected behavior**: The skill uses the report as a source of adaptable topics and methods, states that product facts are missing, and does not portray the research report as an approved product specification.
- **Assertions**:
  1. The response does not claim the research report establishes this product’s brand, components, or current defects.
  2. It separates report-derived recommendations from product facts that still need confirmation.
  3. It asks for the minimum product-specific evidence needed or drafts only a clearly marked scaffold.
- **Notes**: The source report’s internal web citation identifiers are not portable links.
