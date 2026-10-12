# Evals for skill-forge

Dogfood scenarios for skill-forge itself. Excluded from the shipped package.

## Scenario 1: create-new-skill
- **Prompt**: "I keep asking you to write commit messages and you always do it
  slightly differently. can you make me a skill for it? conventional commits
  style, look at the staged diff first"
- **Expected behavior**: Follows Phases 1-7: brief interview, evals/EVALS.md
  with 3 or more scenarios before drafting, a draft from the template with
  portable-fields-only frontmatter, validator run until clean, portable test
  pass recorded with the contamination caveat, packaged .skill produced.
- **Assertions**:
  1. The produced skill's frontmatter contains only portable fields and
     includes name, description, and license.
  2. `validate_skill.py` exits 0 on the produced skill before packaging.
  3. The produced description contains a use-when clause and a not-for clause.
  4. evals/EVALS.md exists for the produced skill with at least 3 scenarios,
     written before the body was finalized.
- **Notes**: needs a git repository with staged changes for the full test;
  the drafting steps run without one.

## Scenario 2: review-existing-skill
- **Prompt**: "here's the skill one of our contractors wrote
  (./vendor-skills/report-gen). before we roll it out to the team can you
  audit it? something feels off, it never seems to fire"
- **Expected behavior**: Routes to "Reviewing an existing skill": validator
  first, then the manual checklist, then a review report with verdict,
  blocking issues, warnings, and suggestions, each finding with evidence. The
  never-fires complaint is triaged as a description problem.
- **Assertions**:
  1. The validator is run before manual review and its findings appear in
     the report.
  2. The report follows the checklists.md section 4 template, findings
     ordered by severity with evidence.
  3. The triggering complaint is addressed via the description method
     (trigger-term inventory, formula rewrite), not by body edits.
- **Notes**: any deliberately flawed fixture skill works as input.

## Scenario 3: package-only
- **Prompt**: "zip up ~/experiments/tone-checker so I can upload it to
  claude.ai — last time I tried it the upload got rejected"
- **Expected behavior**: Routes to Phase 7. Runs the packager, which
  validates first; on validation errors (the likely cause of the rejection),
  reports the exact findings and fixes them (or asks) before producing the
  .skill file; explains the claude.ai install path.
- **Assertions**:
  1. Packaging is refused while validation errors exist, and the specific
     upload-breaking finding (e.g. a non-portable frontmatter key) is named.
  2. After fixes, a .skill zip is produced whose archive root is the skill
     folder name and which excludes evals/ and OS artifacts.
- **Notes**: fixture skill with one non-portable frontmatter field makes the
  rejection reproducible.
