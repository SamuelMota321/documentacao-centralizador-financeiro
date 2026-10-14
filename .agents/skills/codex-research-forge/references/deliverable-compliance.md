# Deliverable: Compliance Mapping

Research feeding regulatory or framework readiness: mapping obligations to
controls, evidence, gaps, and remediation.

**Caution — read first.** This deliverable type rests on the thinnest
evidence base of the six, and compliance is where unverified or fabricated
citations do the most damage. The generated prompt must enforce primary-text
citation and explicit uncertainty flags, and the delivery must carry the
caution in prompt-assembly.md section 5: the research output is support
material, not legal or audit advice, and requires review by qualified legal
or compliance professionals before anyone acts on it.

## When this type applies

The user must prepare for, assess against, or map a named regulation,
standard, or framework (SOC 2, ISO 27001, LGPD, GDPR, PCI DSS, HIPAA…). If
compliance is only one criterion in a selection, keep the vendor-comparison
or architecture type and fold compliance into its constraints.

## Question bank

- The exact framework or regulation, its version or edition, and the scope
  — required user-stated, no default. For multi-part frameworks, which
  parts apply (for example, which SOC 2 Trust Services Criteria)? (slots 2, 7)
- The systems, processes, and data in scope; the organization profile that
  determines applicability. (slot 7)
- Existing controls or prior audits, if known. (slot 7)
- What the deliverable feeds: readiness assessment, gap analysis, audit
  preparation? (slot 2)
- Audience default: compliance officer and engineering leads. (slot 6)

## Sub-question template

1. The obligations of {framework, version} applicable to {scope}, each
   cited to the primary framework or regulatory text.
2. Typical controls that satisfy each obligation for an organization of the
   stated profile.
3. Evidence artifacts auditors or regulators expect per control.
4. Likely gaps for the stated profile, given the existing controls.
5. Remediation priorities ordered by risk and effort.

## Output skeleton and length

Sections, in order: executive summary; obligation → control → evidence →
gap → remediation mapping (one table or one subsection per obligation
group); prioritized remediation list; open questions needing legal review.
Default length: 2500-3500 words.

## Source preferences

Prefer: the primary regulatory or framework text, official regulator
guidance, major audit-firm readiness material.
Recency default: the current framework version — verify effective dates;
flag guidance older than the version in scope. Avoid compliance-tool vendor
marketing unless clearly labeled as such.

## Fixed clauses

- Cite the primary regulatory or framework text for every obligation.
- Flag every uncertain or unresolved obligation explicitly as needing legal
  review — never assert it.
- The delivery message must carry the compliance caution from
  prompt-assembly.md section 5.
