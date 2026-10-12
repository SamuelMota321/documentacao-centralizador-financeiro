# Review Checklists

For reviewing an existing skill, for the final pre-package pass on a new one,
and as the manual substitute when `scripts/validate_skill.py` cannot run.

## Contents

1. [Machine-checked items](#1-machine-checked-items)
2. [Manual review checklist](#2-manual-review-checklist)
3. [Anti-pattern table](#3-anti-pattern-table)
4. [Review report template](#4-review-report-template)
5. [Security review](#5-security-review)

## 1. Machine-checked items

`scripts/validate_skill.py` checks these; when Python is unavailable, verify
them by hand. Errors block packaging/upload; warnings are quality defects or,
for W111-W115, security suspicions — resolve either before packaging.

| Check | Rule |
|---|---|
| E001 | SKILL.md exists at the skill root |
| E002 | exactly one SKILL.md would be packaged (uploads reject multiples) |
| E003 | file starts with a `---`-delimited YAML frontmatter block |
| E004 | frontmatter parses as a YAML mapping |
| E005 | frontmatter keys ⊆ {name, description, license, compatibility, metadata, allowed-tools} |
| E006 | name: lowercase/digits/single hyphens, ≤64 chars |
| E007 | name equals the folder name |
| E008 | name contains neither "anthropic" nor "claude" |
| E009 | description: non-empty, ≤1024 chars, no angle brackets |
| E010 | compatibility (if present): string ≤500 chars |
| E011 | every relative markdown link in SKILL.md resolves to a real file |
| E012 | linked references at most one directory below the skill root |
| E013 | metadata (if present): map of strings to strings |
| E014 | allowed-tools (if present): string or list of strings |
| W101/W102 | body under 500 lines / ~5,000 tokens |
| W103 | description contains a "use when…" clause |
| W104 | description reads as third person |
| W105 | references over 100 lines have a table of contents |
| W106 | every file in scripts/ is mentioned in the body |
| W107 | no Windows-style paths |
| W108 | license declared in frontmatter |
| W109 | evals/ directory exists |
| W110 | non-stdlib imports in bundled scripts are declared in the body |
| W111 | no phrasing that overrides prior instructions, hides actions from the user, defeats safety mechanisms, or extracts the system prompt |
| W112 | no download command whose output is piped or substituted into a shell or interpreter |
| W113 | no hardcoded credentials (cloud keys, API tokens, private-key blocks, secret-named assignments) |
| W114 | no instructions fetched from a URL at runtime and treated as commands |
| W115 | no long encoded blobs or decode-and-execute chains |
| W116 | no SKILL.md link points at a file the packager excludes from the zip |

## 2. Manual review checklist

Judgment calls no script can make. For each item answer yes/no and note the
evidence; unanswerable counts as no.

Description:
- [ ] States what the skill does AND when to use it, in third person
- [ ] Contains the words a real user would type (extensions, tool names,
      casual phrasings), not only the author's vocabulary
- [ ] Slightly pushy — covers contexts where the user needs it but doesn't
      name it
- [ ] Has a not-for clause excluding the nearest adjacent tasks
- [ ] No triggering information hidden in the body instead

Body:
- [ ] Imperative voice; explains why instead of shouting MUSTs
- [ ] Adds only context the model lacks; no filler or general advice
- [ ] Degrees of freedom match fragility (prose / template / exact command)
- [ ] One default per decision, with an escape hatch — no option menus
- [ ] Concrete input/output examples where format matters
- [ ] Consistent terminology throughout
- [ ] No date-sensitive claims ("currently", "recently", "new")
- [ ] Each reference has a clear "read when…" pointer in the body

Resources:
- [ ] Scripts solve errors themselves and exit nonzero with clear messages
- [ ] No unexplained constants; execute-vs-read stated for each script
- [ ] Dependencies declared (body + `compatibility`); stdlib preferred
- [ ] assets/ contains only files used in the skill's output
- [ ] No credentials, unexpected network calls, or surprising behavior
      relative to what the description promises

Testing:
- [ ] At least 3 eval scenarios with discriminating assertions, at least
      one of them a negative or edge case
- [ ] Results recorded, contamination caveat stated when self-tested

## 3. Anti-pattern table

| Anti-pattern | Detection cue | Fix |
|---|---|---|
| Vague description | "Helps with…", no triggers | Rewrite with the formula in [writing-guide.md](writing-guide.md) §1 |
| Monolithic body | approaching 500 lines | Move bulk to references/ with read-when pointers |
| Deep-nested references | `references/a/b.md` | Flatten to one level |
| Triggering info in body | "Use this skill when…" below the frontmatter | Move to description |
| Fragile script | script errors out and asks the model to cope | Handle the error in the script; exit nonzero with a message |
| Windows paths | `scripts\x.py` | Forward slashes |
| Option menus | "use A or B or C" | One default + escape hatch |
| Rigid all-caps MUSTs | ALWAYS/NEVER without a reason | State the why; drop the caps |
| Non-portable fields on export | any key beyond the six | Remove or keep the skill Claude-Code-only deliberately |
| Assumed packages | bare `import somelib` | Declare it, or rewrite stdlib-only |

## 4. Review report template

```markdown
# Skill review: <name> (<date>)
**Verdict**: ship / fix-then-ship / rework

## Summary
Two or three sentences: what the skill does, overall state.

## Blocking (must fix)
- <E-check or manual item> — evidence — suggested fix

## Warnings (should fix)
- ...

## Suggestions (nice to have)
- ...
```

Order findings by severity; every finding cites its checklist item and
evidence. No findings in a section → write "none".

## 5. Security review

Skills are software running with the agent's privileges: audit one the way
you would audit an unknown dependency, especially a skill you did not write.
The validator's W111-W115 heuristics catch the mechanical patterns; this
checklist covers them by hand plus the judgment calls no regex makes.

For any skill, and non-negotiably for one from a third party (a marketplace,
a contractor, a colleague's zip), before installing or shipping:

- [ ] Every bundled file read in full — SKILL.md, references, scripts,
      assets. An unread file is unaudited code.
- [ ] No phrasing that overrides prior instructions, hides actions from the
      user, defeats safety mechanisms, or extracts the system prompt (W111
      by hand)
- [ ] No download command whose output is piped or substituted into a shell
      or interpreter (W112) — code that runs unreviewed can change after
      audit
- [ ] No hardcoded credentials: cloud keys, API tokens, private-key blocks,
      values assigned to secret-named keys (W113) — secrets come from the
      environment
- [ ] No instructions fetched from a URL at runtime and treated as commands
      (W114) — remote content can change after review
- [ ] No long encoded blobs or decode-and-execute chains (W115) — nothing
      in a skill should need hiding from a reader
- [ ] The description read as an attack surface, not just style: it does not
      overclaim its territory to capture unrelated requests, and it does not
      misrepresent what the bundled files actually do
- [ ] Network access matched against the description: every URL the skill
      touches is one the described job plausibly needs
- [ ] `allowed-tools`, where the target surface honors it, restricted to the
      tools the job needs

Record security findings in the section 4 report under **Blocking** — a
security finding is never merely a suggestion. A validator warning that turns
out deliberate and benign (say, a security skill quoting an attack pattern as
an example) is documented in the report and packaged with `--force`.

Static review has limits: a skill can pass every textual check and still
direct harmful behavior at runtime. Sandboxing and permission enforcement
belong to the runtime environment, not to authoring — flag runtime concerns
to whoever operates the surface instead of trying to encode them here.
