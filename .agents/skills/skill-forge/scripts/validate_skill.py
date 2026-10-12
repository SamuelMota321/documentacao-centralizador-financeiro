#!/usr/bin/env python3
"""Validate an Agent Skill directory against the portable spec and quality checklist.

Usage:
    python3 validate_skill.py <skill-dir> [--strict] [--json] [--no-pyyaml]

Exit codes:
    0  no errors (and no warnings under --strict)
    1  findings failed the run
    2  usage or I/O error

Checks are grouped as errors (E...) that block packaging/upload and warnings
(W...) that flag quality problems. Errors encode the portable Agent Skills
spec; warnings encode official best-practice recommendations plus security
heuristics (W111-W115) adapted from published skills-security research.
Stdlib-only: PyYAML is used when available, with a built-in fallback parser
otherwise.

Frontmatter-exclusion and single-SKILL.md logic adapted from Anthropic's
skill-creator (Apache-2.0).
"""

import argparse
import json
import re
import sys
from pathlib import Path

PORTABLE_FIELDS = {"name", "description", "license", "compatibility", "metadata", "allowed-tools"}
RESERVED_NAME_WORDS = ("anthropic", "claude")
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
# Directories never packaged (any depth) and packaged-root exclusions.
EXCLUDED_DIR_PARTS = {"__pycache__", "node_modules", ".git"}
ROOT_EXCLUDED_DIRS = {"evals"}
MAX_NAME = 64
MAX_DESCRIPTION = 1024
MAX_COMPATIBILITY = 500
BODY_LINE_LIMIT = 500
BODY_TOKEN_LIMIT = 5000
REFERENCE_TOC_LINE_THRESHOLD = 100

# --- Security heuristics (W111-W115) ---------------------------------------
# Content patterns that skills-security research flags as high-signal for
# malicious or compromised skills: injection phrasing, download-execute pipes,
# embedded credentials, runtime instruction fetches, obfuscated payloads.
# Heuristics have false positives (a security skill may quote these shapes on
# purpose), so they warn rather than error; the packager's refuse-on-warnings
# default still forces an explicit --force decision. Pattern literals are
# arranged so this file's own source never matches its own patterns.
SECURITY_SCAN_SUFFIXES = {
    ".md", ".markdown", ".txt", ".py", ".sh", ".bash", ".zsh", ".js", ".ts",
    ".rb", ".pl", ".json", ".yaml", ".yml", ".toml", ".cfg", ".ini", ".csv",
    ".html", ".xml",
    "",  # extensionless files are often scripts; binaries fail utf-8 and skip
}
SECURITY_SCAN_MAX_BYTES = 1024 * 1024  # larger files are data, not instructions
SECRET_PLACEHOLDER_WORDS = ("your", "example", "placeholder", "xxxx", "dummy", "sample")

_W111_INJECTION = [
    re.compile(r"\b(?:ignore|disregard|forget)\s+(?:all\s+|any\s+|the\s+|your\s+|"
               r"my\s+)?(?:previous|prior|above|earlier)\s+"
               r"(?:instructions?|prompts?|rules)", re.I),
    re.compile(r"\b(?:do\s+not|don'?t|never)\s+(?:tell|inform|warn|alert|notify|"
               r"mention|let)\b[^\n]{0,40}\bthe\s+user", re.I),
    re.compile(r"\bwithout\s+(?:telling|informing|alerting|notifying)\s+the\s+user", re.I),
    re.compile(r"\bwithout\s+the\s+user'?s?\s+(?:knowledge|awareness|consent)", re.I),
    re.compile(r"\b(?:disabl\w*|bypass\w*|circumvent\w*|turn\s+off)\s+"
               r"(?:the\s+|all\s+|any\s+)?(?:safety|guardrails?|content\s+filters?|"
               r"security\s+checks?)", re.I),
    re.compile(r"\b(?:override|replace|reveal|exfiltrate)\s+(?:the\s+|your\s+|"
               r"its\s+)?system\s+prompt", re.I),
]
_W112_PIPE_TO_SHELL = [
    # Prefix words before the interpreter cover sudo/env/flags/paths
    # (e.g. sudo -E bash -, /usr/bin/env bash, /bin/zsh).
    re.compile(r"\b(?:curl|wget)\b[^|\n]*\|\s*(?:[\w./-]+\s+)*(?:[\w./-]*/)?"
               r"(?:ba|z|da)?sh\b"),
    re.compile(r"\b(?:curl|wget)\b[^|\n]*\|\s*(?:[\w./-]+\s+)*(?:[\w./-]*/)?"
               r"(?:python3?|perl|ruby|node)\b"),
    re.compile(r"\b(?:curl|wget)\b[^|\n]*\|\s*source\b"),
    re.compile(r"\b(?:ba|z)?sh\s+-c\s+[\"']?\$\((?:curl|wget)\b"),
    re.compile(r"\b(?:ba|z|da)?sh\s+<\(\s*(?:curl|wget)\b"),
]
_W113_SECRETS = [
    re.compile(r"\bAKIA[0-9A-Z]{16}\b"),
    re.compile(r"\bsk-[A-Za-z0-9_-]{20,}\b"),
    re.compile(r"\bghp_[A-Za-z0-9]{36}\b"),
    re.compile(r"\bgithub_pat_[A-Za-z0-9_]{22,}\b"),
    re.compile(r"\bxox[abprs]-[A-Za-z0-9-]{10,}\b"),
    re.compile(r"-----BEGIN [A-Z ]*PRIVATE KEY-----"),
    # Quoted values under secret-ish keys, JSON-style quoted keys included.
    re.compile(r"[\"']?\b(?:api[_-]?key|secret|token|password|passwd)\b[\"']?"
               r"\s*[:=]\s*[\"'][A-Za-z0-9+/_\-.]{12,}[\"']", re.I),
    # Unquoted env-style assignment of a long value to a secret-ish name.
    re.compile(r"\b\w*(?:secret|token|passwd|password|api[_-]?key)\w*\s*=\s*"
               r"[A-Za-z0-9+/]{20,}\s*$", re.I),
    re.compile(r"\bBearer\s+[A-Za-z0-9_\-.=]{25,}", re.I),
]
_W114_REMOTE_INSTRUCTIONS = [
    re.compile(r"\b(?:fetch|download|retrieve|load|read|get|visit|open|browse|"
               r"curl|wget|webfetch|navigate\s+to|go\s+to)\b[^\n]{0,80}"
               r"\bhttps?://\S+[^\n]{0,80}\b(?:follow|execute|obey|run|apply|do)"
               r"\s+(?:it|its|them|these|those|the|everything|whatever)\b", re.I),
    re.compile(r"\b(?:follow|execute|obey|apply|run)\s+(?:the\s+|any\s+)?"
               r"(?:instructions?|commands?|steps|directives?)\s+(?:at|from|in|on)"
               r"\s+https?://", re.I),
]
_W115_OBFUSCATION = [
    re.compile(r"[A-Za-z0-9+/]{120,}={0,2}"),
    re.compile(r"\b(?:base64\s+(?:-d|-D|--decode)|b64decode|a2b_base64)\b[^\n]*"
               r"(?:\|\s*(?:ba|z)?sh\b|\beval\b|\bexec\b|\bsource\b)"),
    re.compile(r"(?:\beval\b|\bexec\b)[^\n]{0,40}\b(?:base64|b64decode)\b"),
]
SECURITY_CHECKS = (
    ("W111", _W111_INJECTION, "prompt-injection phrasing",
     "skills must not override instructions, hide actions, or defeat safety"),
    ("W112", _W112_PIPE_TO_SHELL, "download piped into an interpreter",
     "remote code executed unreviewed can change behavior after audit"),
    ("W113", _W113_SECRETS, "hardcoded credential",
     "credentials never belong in a skill; read them from the environment"),
    ("W114", _W114_REMOTE_INSTRUCTIONS, "runtime fetch of external instructions",
     "remotely fetched instructions can change after review"),
    ("W115", _W115_OBFUSCATION, "obfuscated payload",
     "encoded blobs and decode-and-execute chains hide behavior from review"),
)


class FrontmatterParseError(Exception):
    pass


def parse_frontmatter_fallback(text):
    """Parse the constrained YAML subset legal skill frontmatter needs.

    Supports: top-level `key: value` scalars (plain or quoted), block scalars
    (| and > with optional +/- chomping), one nesting level under `metadata:`,
    and lists (inline `[a, b]` or block `- item`). Anything else fails loudly:
    for a validator, rejecting the exotic beats guessing wrong.
    """
    lines = text.split("\n")
    result = {}
    i = 0
    while i < len(lines):
        line = lines[i]
        if not line.strip() or line.lstrip().startswith("#"):
            i += 1
            continue
        if line[0] in (" ", "\t"):
            raise FrontmatterParseError(
                f"line {i + 1}: unexpected indentation ({line.strip()[:40]!r})"
            )
        m = re.match(r"^([A-Za-z0-9_-]+):(.*)$", line)
        if not m:
            raise FrontmatterParseError(f"line {i + 1}: expected 'key: value', got {line[:40]!r}")
        key, rest = m.group(1), m.group(2).strip()
        i += 1
        if re.match(r"^[|>][+-]?$", rest):  # block scalar
            block, i = _read_indented(lines, i)
            joiner = "\n" if rest[0] == "|" else " "
            value = joiner.join(block)
            if not rest.endswith("-"):
                value += "\n"
            result[key] = value
        elif rest.startswith("[") and rest.endswith("]"):
            result[key] = [_unquote(v.strip()) for v in rest[1:-1].split(",") if v.strip()]
        elif rest == "":
            block, i = _read_indented(lines, i)
            if not block:
                result[key] = None
            elif all(b.startswith("- ") or b == "-" for b in block):
                result[key] = [_unquote(b[1:].strip()) for b in block]
            else:
                nested = {}
                for b in block:
                    bm = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", b)
                    if not bm:
                        raise FrontmatterParseError(
                            f"under {key!r}: expected 'key: value', got {b[:40]!r}"
                        )
                    nested[bm.group(1)] = _unquote(bm.group(2).strip())
                result[key] = nested
        else:
            if rest.startswith(("&", "*", "!", "{")):
                raise FrontmatterParseError(
                    f"line {i}: unsupported YAML feature in value {rest[:40]!r}"
                )
            result[key] = _unquote(rest)
    return result


def _read_indented(lines, i):
    """Collect the contiguous indented block starting at lines[i], dedented."""
    block = []
    while i < len(lines):
        line = lines[i]
        if not line.strip():
            if block:
                block.append("")
            i += 1
            continue
        if line[0] not in (" ", "\t"):
            break
        block.append(line.strip())
        i += 1
    while block and block[-1] == "":
        block.pop()
    return block, i


def _unquote(value):
    if len(value) >= 2 and value[0] == value[-1] and value[0] in ("'", '"'):
        return value[1:-1]
    return value


def parse_frontmatter(text, use_pyyaml=True):
    """Parse frontmatter text to a dict. Returns (data, parser_name)."""
    if use_pyyaml:
        try:
            import yaml
        except ImportError:
            pass
        else:
            data = yaml.safe_load(text)
            return data, "pyyaml"
    try:
        return parse_frontmatter_fallback(text), "fallback"
    except FrontmatterParseError as exc:
        raise FrontmatterParseError(
            f"{exc}. The frontmatter uses YAML features the built-in parser does not "
            "support; simplify the frontmatter or install PyYAML."
        ) from exc


def _packaged_skill_mds(skill_dir):
    """SKILL.md files that would end up inside the package."""
    found = []
    for p in skill_dir.rglob("SKILL.md"):
        rel_dirs = p.relative_to(skill_dir).parts[:-1]
        # Dot-directories mirror the packager's dot-name exclusion.
        if any(part in EXCLUDED_DIR_PARTS or part.startswith(".") for part in rel_dirs):
            continue
        if rel_dirs and rel_dirs[0] in ROOT_EXCLUDED_DIRS:
            continue
        found.append(p)
    return found


def _markdown_link_targets(body):
    """Relative link targets from markdown links, minus URLs/anchors/placeholders."""
    targets = []
    for target in re.findall(r"\]\(([^)\s]+)\)", body):
        if re.match(r"^(https?:|mailto:|#)", target):
            continue
        target = target.split("#")[0]
        if not target or any(ch in target for ch in "<>{}*$"):
            continue
        targets.append(target)
    return targets


def _stdlib_modules():
    return getattr(sys, "stdlib_module_names", None)


def _looks_placeholder(match_text):
    """Obvious documentation placeholders are not leaked credentials."""
    lowered = match_text.lower()
    return any(word in lowered for word in SECRET_PLACEHOLDER_WORDS)


def _benign_blob(line, match_text):
    """Hex digests, data: URIs, and ssh public keys are common benign blobs."""
    if re.fullmatch(r"[0-9a-fA-F]+", match_text.rstrip("=")):
        return True
    lowered = line.lower()
    return "data:" in lowered or "ssh-" in lowered or "ecdsa-sha2" in lowered


def _link_target_excluded(target):
    """Would the packager drop this (existing) link target from the zip?"""
    parts = Path(target).parts
    if any(part.startswith(".") for part in parts):
        return True
    if any(part in EXCLUDED_DIR_PARTS for part in parts[:-1]):
        return True
    return bool(parts) and parts[0] in ROOT_EXCLUDED_DIRS


def _security_scan_files(skill_dir):
    """Yield (relative_path, text) for packaged text files the heuristics scan.

    Mirrors the packager's exclusions (excluded dirs, root evals/, dot-names):
    content that never ships is not scanned.
    """
    for path in sorted(skill_dir.rglob("*")):
        if not path.is_file():
            continue
        rel = path.relative_to(skill_dir)
        parts = rel.parts
        if any(part.startswith(".") for part in parts):
            continue
        # Directory components only, like the packager: a root FILE named
        # e.g. node_modules ships, so it must be scanned.
        if any(part in EXCLUDED_DIR_PARTS for part in parts[:-1]):
            continue
        if parts[0] in ROOT_EXCLUDED_DIRS:
            continue
        if path.suffix.lower() not in SECURITY_SCAN_SUFFIXES:
            continue
        try:
            if path.stat().st_size > SECURITY_SCAN_MAX_BYTES:
                continue
            yield rel, path.read_text(encoding="utf-8")
        except (OSError, UnicodeDecodeError):
            continue


def _security_warnings(skill_dir):
    """Run the W111-W115 heuristics; at most one warning per check per file."""
    findings = []
    for rel, text in _security_scan_files(skill_dir):
        lines = text.split("\n")
        for code, patterns, label, why in SECURITY_CHECKS:
            hit = None
            for lineno, line in enumerate(lines, 1):
                for pattern in patterns:
                    for match in pattern.finditer(line):
                        text = match.group(0)
                        if code == "W113" and _looks_placeholder(text):
                            continue
                        if code == "W115" and _benign_blob(line, text):
                            continue
                        hit = (lineno, text)
                        break
                    if hit:
                        break
                if hit:
                    break
            if hit:
                lineno, fragment = hit
                if len(fragment) > 60:
                    fragment = fragment[:57] + "..."
                findings.append((code, f"{rel}:{lineno} {label}: {fragment!r} — "
                                       f"{why}. If deliberate and benign, document "
                                       "it in SKILL.md and package with --force"))
    return findings


def validate_skill(skill_dir, use_pyyaml=True):
    """Run all checks. Returns (errors, warnings) as lists of (code, message)."""
    errors, warnings = [], []
    skill_dir = Path(skill_dir)
    skill_md = skill_dir / "SKILL.md"

    # E001 SKILL.md exists at the skill root
    if not skill_md.is_file():
        errors.append(("E001", f"SKILL.md not found at {skill_md}"))
        return errors, warnings

    # E002 exactly one SKILL.md would be packaged (uploads reject multiples)
    extra = [
        str(p.relative_to(skill_dir))
        for p in _packaged_skill_mds(skill_dir)
        if p.resolve() != skill_md.resolve()
    ]
    if extra:
        errors.append(
            ("E002", "package would contain more than one SKILL.md; uploads accept "
                     f"exactly one. Extra: {', '.join(sorted(extra))}")
        )

    content = skill_md.read_text(encoding="utf-8")

    # E003 frontmatter block delimited by --- at the very start
    fm_match = re.match(r"^---\s*\n(.*?)\n---\s*(?:\n|$)", content, re.DOTALL)
    if not fm_match:
        errors.append(("E003", "SKILL.md must start with a '---'-delimited YAML frontmatter block"))
        return errors, warnings
    fm_text = fm_match.group(1)
    body = content[fm_match.end():]

    # E004 frontmatter parses to a mapping
    try:
        fm, parser = parse_frontmatter(fm_text, use_pyyaml=use_pyyaml)
    except FrontmatterParseError as exc:
        errors.append(("E004", f"frontmatter did not parse: {exc}"))
        return errors, warnings
    except Exception as exc:  # PyYAML errors
        errors.append(("E004", f"frontmatter did not parse: {exc}"))
        return errors, warnings
    if not isinstance(fm, dict):
        errors.append(("E004", f"frontmatter must be a YAML mapping, got {type(fm).__name__}"))
        return errors, warnings

    # E005 only the six portable fields survive export
    unexpected = set(fm) - PORTABLE_FIELDS
    if unexpected:
        errors.append(
            ("E005", f"non-portable frontmatter key(s): {', '.join(sorted(unexpected))}. "
                     f"Uploads outside Claude Code accept only: {', '.join(sorted(PORTABLE_FIELDS))}")
        )

    # E006-E008 name rules
    name = fm.get("name")
    if not isinstance(name, str) or not name.strip():
        errors.append(("E006", "frontmatter must contain a non-empty string 'name'"))
    else:
        name = name.strip()
        if not NAME_RE.match(name):
            errors.append(("E006", f"name {name!r} must match ^[a-z0-9]+(-[a-z0-9]+)*$ "
                                   "(lowercase, digits, single hyphens)"))
        if len(name) > MAX_NAME:
            errors.append(("E006", f"name is {len(name)} chars; max is {MAX_NAME}"))
        if name != skill_dir.resolve().name:
            errors.append(("E007", f"name {name!r} must equal the folder name "
                                   f"{skill_dir.resolve().name!r}"))
        hits = [w for w in RESERVED_NAME_WORDS if w in name]
        if hits:
            errors.append(("E008", f"name contains reserved word(s): {', '.join(hits)}"))

    # E009 description rules
    desc = fm.get("description")
    if not isinstance(desc, str) or not desc.strip():
        errors.append(("E009", "frontmatter must contain a non-empty string 'description'"))
        desc = ""
    else:
        desc = desc.strip()
        if len(desc) > MAX_DESCRIPTION:
            errors.append(("E009", f"description is {len(desc)} chars; max is {MAX_DESCRIPTION}"))
        if "<" in desc or ">" in desc:
            errors.append(("E009", "description must not contain angle brackets"))

    # E010 compatibility rules
    compat = fm.get("compatibility")
    if compat is not None:
        if not isinstance(compat, str):
            errors.append(("E010", f"compatibility must be a string, got {type(compat).__name__}"))
        elif len(compat) > MAX_COMPATIBILITY:
            errors.append(("E010", f"compatibility is {len(compat)} chars; max is {MAX_COMPATIBILITY}"))

    # E013 metadata is a string-to-string map
    meta = fm.get("metadata")
    if meta is not None:
        if not isinstance(meta, dict) or not all(
            isinstance(k, str) and isinstance(v, str) for k, v in meta.items()
        ):
            errors.append(("E013", "metadata must be a map of string keys to string values"))

    # E014 allowed-tools is a string or list of strings
    tools = fm.get("allowed-tools")
    if tools is not None and not (
        isinstance(tools, str)
        or (isinstance(tools, list) and all(isinstance(t, str) for t in tools))
    ):
        errors.append(("E014", "allowed-tools must be a string or a list of strings"))

    # E011/E012 internal links resolve, one level deep; W116 flags links whose
    # target exists on disk but never reaches the shipped zip.
    for target in _markdown_link_targets(body):
        resolved = (skill_dir / target)
        if not resolved.exists():
            errors.append(("E011", f"SKILL.md links to missing file: {target}"))
            continue
        if target.endswith(".md") and len(Path(target).parts) > 2:
            errors.append(("E012", f"reference nested deeper than one level: {target} "
                                   "(keep references one directory below the skill root)"))
        if _link_target_excluded(target):
            warnings.append(("W116", f"SKILL.md links to {target}, but the packager "
                                     "excludes that path from the shipped zip; the "
                                     "installed skill would carry a dangling link"))

    # --- Warnings ---
    body_lines = body.split("\n")
    if len(body_lines) >= BODY_LINE_LIMIT:
        warnings.append(("W101", f"body is {len(body_lines)} lines; recommended limit is "
                                 f"{BODY_LINE_LIMIT}. Move detail into references/"))
    est_tokens = len(body) // 4
    if est_tokens > BODY_TOKEN_LIMIT:
        warnings.append(("W102", f"body is ~{est_tokens} tokens (len/4 estimate); recommended "
                                 f"limit is {BODY_TOKEN_LIMIT}"))

    if desc and not re.search(r"\buse (when|whenever|this|it|for)\b", desc, re.IGNORECASE):
        warnings.append(("W103", "description has no 'use when...' clause; triggering info "
                                 "belongs in the description"))
    if desc and re.search(r"\b(I can|I will|I'll|helps you|lets you|you can use)\b", desc):
        warnings.append(("W104", "description looks first/second person; write it in third person"))

    ref_dir = skill_dir / "references"
    if ref_dir.is_dir():
        for ref in sorted(ref_dir.glob("*.md")):
            ref_lines = ref.read_text(encoding="utf-8").split("\n")
            if len(ref_lines) <= REFERENCE_TOC_LINE_THRESHOLD:
                continue
            head = "\n".join(ref_lines[:30]).lower()
            if "contents" not in head and head.count("](#") < 3:
                warnings.append(("W105", f"{ref.relative_to(skill_dir)} is {len(ref_lines)} lines "
                                         "with no table of contents in its first 30 lines"))

    scripts_dir = skill_dir / "scripts"
    if scripts_dir.is_dir():
        local_modules = {p.stem for p in scripts_dir.glob("*.py")}
        for script in sorted(scripts_dir.iterdir()):
            if script.is_file() and script.name not in ("__init__.py",) and script.name not in body:
                warnings.append(("W106", f"scripts/{script.name} is never mentioned in the "
                                         "SKILL.md body; say when to run (or read) it"))
        stdlib = _stdlib_modules()
        if stdlib:
            content_lower = content.lower()
            for script in sorted(scripts_dir.glob("*.py")):
                for imp in re.findall(r"^\s*(?:import|from)\s+([A-Za-z0-9_]+)",
                                      script.read_text(encoding="utf-8"), re.MULTILINE):
                    if imp in stdlib or imp in local_modules:
                        continue
                    # Case-insensitive: a body declaring "PyYAML" covers `import yaml`.
                    if imp.lower() not in content_lower:
                        warnings.append(("W110", f"scripts/{script.name} imports non-stdlib "
                                                 f"{imp!r} but SKILL.md never declares that "
                                                 "dependency"))

    if re.search(r"[A-Za-z]:\\|\w\\\w+\.(?:py|md|sh|js|json)", body):
        warnings.append(("W107", "body contains Windows-style path(s); use forward slashes"))

    if "license" not in fm:
        warnings.append(("W108", "no 'license' field in frontmatter"))
    if not (skill_dir / "evals").is_dir():
        warnings.append(("W109", "no evals/ directory; write test scenarios before "
                                 "(or while) writing the skill"))

    warnings.extend(_security_warnings(skill_dir))

    return errors, warnings


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("skill_dir", help="path to the skill directory")
    parser.add_argument("--strict", action="store_true", help="treat warnings as errors")
    parser.add_argument("--json", action="store_true", dest="as_json", help="emit JSON")
    parser.add_argument("--no-pyyaml", action="store_true",
                        help="force the built-in fallback parser (for testing it)")
    args = parser.parse_args(argv)

    skill_dir = Path(args.skill_dir)
    if not skill_dir.is_dir():
        print(f"ERROR: not a directory: {skill_dir}", file=sys.stderr)
        return 2

    try:
        errors, warnings = validate_skill(skill_dir, use_pyyaml=not args.no_pyyaml)
    except OSError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2

    ok = not errors and not (args.strict and warnings)
    if args.as_json:
        print(json.dumps({
            "ok": ok,
            "errors": [{"code": c, "message": m} for c, m in errors],
            "warnings": [{"code": c, "message": m} for c, m in warnings],
        }, indent=2))
    else:
        for code, message in errors:
            print(f"ERROR {code} {message}")
        for code, message in warnings:
            print(f"WARNING {code} {message}")
        print(f"Summary: {len(errors)} error(s), {len(warnings)} warning(s)")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
