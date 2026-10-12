# Results — iteration 1 (build session)

Mode: Scenario 1 executed by an independent fresh-context subagent following
SKILL.md literally (uncontaminated by authorship). Scenario 3's core behavior
exercised via script fixtures. Scenario 2 not yet executed end-to-end.
Contamination caveat: no for Scenario 1 (independent executor); fixture
evidence for Scenario 3 gathered by the author.

| Scenario | Assertion | Verdict | Evidence |
|---|---|---|---|
| 1 create-new-skill | frontmatter only portable fields, incl. name/description/license | PASS | commit-haiku frontmatter: name, description, license, compatibility; validator exit 0 |
| 1 create-new-skill | validator exits 0 before packaging | PASS | `validate_skill.py --strict` exit 0, twice (post-draft, pre-package) |
| 1 create-new-skill | description has use-when and not-for clauses | PASS | "Use when the user asks for a commit haiku… Not for conventional commit messages…" |
| 1 create-new-skill | EVALS.md with ≥3 scenarios written before body finalized | PASS | evals-first order followed; 3 scenarios; 9/9 assertions graded with evidence |
| 3 package-only | packaging refused while errors exist, finding named | PASS | fixture `bad-field`: "ERROR E005 non-portable frontmatter key(s): version… Refusing to package"; exit 1 |
| 3 package-only | .skill zip rooted at folder name, evals/ and OS artifacts excluded | PASS | `unzip -l`: root `commit-haiku/`, only SKILL.md inside; skill-forge package: 10 files, no evals/, no __pycache__ |
| 2 review-existing-skill | (all three assertions) | NOT RUN | pending a real review request; validator+checklist components individually tested |

Frictions found by the independent executor (4) were fixed in this iteration:
upgrade-preference wording (Phase 5), stop-rule for a clean first pass
(Phase 6 + evaluation.md §7), "output alone" vs observable-results evidence
(evaluation.md §2 + eval-template), eval-template preamble deletion note.
Full run report: build workspace `analysis/fase6-validacao.md` §5.
