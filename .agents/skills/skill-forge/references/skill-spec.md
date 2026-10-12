# Agent Skill Specification Essentials

Normative rules for skill structure and frontmatter. Each rule is tagged with its
source class: **[spec]** = official specification (violations break uploads or
loading), **[official rec]** = official recommendation (violations hurt quality,
not validity), **[observed]** = pattern verified in production skills.

## Contents

1. [The six portable frontmatter fields](#1-the-six-portable-frontmatter-fields)
2. [Naming rules](#2-naming-rules)
3. [Description limits](#3-description-limits)
4. [Directory layout and size limits](#4-directory-layout-and-size-limits)
5. [Progressive disclosure](#5-progressive-disclosure)
6. [Surface portability matrix](#6-surface-portability-matrix)

## 1. The six portable frontmatter fields

Outside Claude Code (claude.ai zip upload, Skills API, packaging), exactly six
frontmatter fields are accepted. **Any other key is a hard upload error**, not a
warning. [spec]

| Field | Required | Constraints |
|---|---|---|
| `name` | yes | see [Naming rules](#2-naming-rules) |
| `description` | yes | see [Description limits](#3-description-limits) |
| `license` | no | string (SPDX id or free text) |
| `compatibility` | no | string, max 500 chars — environment requirements |
| `metadata` | no | map of string keys to string values |
| `allowed-tools` | no | space/comma-separated string or YAML list; **experimental** — support varies by implementation |

Claude Code accepts extra fields (`disable-model-invocation`, `user-invocable`,
`model`, `effort`, `context`, `agent`, and others) [spec, Claude Code extension].
Use them only in skills that will never leave a Claude Code filesystem; a skill
meant for export must stay within the six portable fields.

Declare a `license` even though it is optional — a skill is software people
install, and an undeclared license blocks reuse. [observed]

## 2. Naming rules

All [spec]:

- Max 64 characters; only lowercase letters, digits, and hyphens (`[a-z0-9-]`).
- Must equal the skill's folder name exactly.
- Must not contain the reserved words "anthropic" or "claude", or XML tags.

Beyond the hard rules, prefer a gerund-style name describing the activity
(`processing-pdfs`, `analyzing-spreadsheets`) over vague names (`helper`,
`utils`). [official rec]

## 3. Description limits

- Non-empty, max 1024 characters, no angle brackets (`<`/`>`). [spec]
- Must state both **what the skill does and when to use it** — it is the only
  signal Claude has when deciding whether to load the skill. [spec]
- Content guidance (third person, trigger terms, use-when and not-for clauses)
  lives in [writing-guide.md](writing-guide.md).

## 4. Directory layout and size limits

```
skill-name/
├── SKILL.md        required: frontmatter + instructions
├── scripts/        executable code for deterministic or fragile operations
├── references/     docs loaded into context only when needed
└── assets/         files used in the skill's OUTPUT (templates, fonts, icons)
```

- Exactly **one SKILL.md per package**: the Skills API and claude.ai reject
  uploads containing more than one (only Claude Code's filesystem loads nested
  skills). [observed — enforced by upload validation]
- SKILL.md body: keep under 500 lines and roughly 5,000 tokens. This is a
  recommendation, not a hard limit — but a body near the limit has no room to
  grow, so target well under it. [official rec]
- References one level deep from SKILL.md (e.g. `references/topic.md`, never
  `references/sub/topic.md`): deeper nesting makes models read files partially.
  [official rec]
- Reference files longer than 100 lines get a table of contents at the top, so
  a model can jump instead of scanning. [official rec]
- Use forward slashes in every path. [official rec]

## 5. Progressive disclosure

Skills load in three levels; put content at the cheapest level that works:

1. **Metadata** (`name` + `description`) — always in context, roughly 100
   tokens per skill. This is the triggering surface.
2. **SKILL.md body** — loaded only when the skill triggers. Workflow and
   decisions live here.
3. **References and scripts** — read or executed only when needed. Bulk
   knowledge and deterministic operations live here; scripts contribute only
   their *output* to context, never their code. There is no context penalty
   for bundled content that is not used. [spec/official rec]

Corollary: anything only needed sometimes belongs in a reference with a clear
"read this when…" pointer, not in the body.

## 6. Surface portability matrix

What each surface provides to a *running* skill. [spec — official surface docs]

| Capability | Claude Code | claude.ai | Skills API container | Cowork |
|---|---|---|---|---|
| Skill installation | filesystem (`~/.claude/skills/`, `.claude/skills/`) | zip upload in Settings | `/v1/skills` upload, referenced per request | filesystem |
| Subagents (parallel runs) | yes | **no** | **no** | yes |
| `claude` CLI (`claude -p`) | yes | **no** | **no** | only if present in the VM |
| Network access | yes (user's machine) | varies with user/admin config | **none** | varies |
| Install packages at runtime | yes | varies | **no** — bundle or use stdlib | varies |
| Browser / display | yes | no display for generated pages | no | no — hand files to the user instead |
| Size/count limits | — | — | 30 MB uncompressed per upload, 8 skills per request | — |

Authoring consequences:

- A skill whose core loop needs subagents or the `claude` CLI works fully only
  on Claude Code (and sometimes Cowork). Keep the core sequential and
  tool-free; treat subagents and CLI as upgrades.
- A skill targeting the API container must be stdlib-only (or bundle its
  dependencies) and must not fetch anything at runtime.
- Skills do not sync between surfaces; each surface is installed separately.
