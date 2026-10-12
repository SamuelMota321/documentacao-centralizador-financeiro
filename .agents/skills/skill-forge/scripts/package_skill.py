#!/usr/bin/env python3
"""Package a validated Agent Skill directory into a distributable .skill zip.

Usage:
    python3 package_skill.py <skill-dir> [output-dir] [--force]

Validation runs first (via validate_skill.py in this directory). Errors always
refuse packaging; warnings refuse too unless --force, because a warning caught
now is cheaper than a rejected upload or an undertriggering skill later.

Exit codes: 0 packaged, 1 validation/zip failure, 2 usage error.

Zip layout and exclusion patterns adapted from Anthropic's skill-creator
(Apache-2.0).
"""

import argparse
import fnmatch
import sys
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from validate_skill import validate_skill  # noqa: E402

EXCLUDE_DIRS = {"__pycache__", "node_modules", ".git"}
ROOT_EXCLUDE_DIRS = {"evals"}
EXCLUDE_FILES = {".DS_Store"}
EXCLUDE_GLOBS = {"*.pyc", "*.skill"}
API_SIZE_LIMIT = 30 * 1024 * 1024  # uncompressed upload cap on the Skills API


def should_exclude(rel_path):
    """rel_path is relative to the skill directory itself."""
    parts = rel_path.parts
    if any(part in EXCLUDE_DIRS for part in parts[:-1]):
        return True
    # Dot-named files and directories (.gitignore, .env, .venv/, a gitlink
    # .git file, ...) are local machinery, never skill content.
    if any(part.startswith(".") for part in parts):
        return True
    if parts and parts[0] in ROOT_EXCLUDE_DIRS:
        return True
    name = rel_path.name
    if name in EXCLUDE_FILES:
        return True
    return any(fnmatch.fnmatch(name, pat) for pat in EXCLUDE_GLOBS)


def package_skill(skill_dir, output_dir=None, force=False):
    skill_dir = Path(skill_dir).resolve()
    if not skill_dir.is_dir():
        print(f"ERROR: not a directory: {skill_dir}", file=sys.stderr)
        return None

    errors, warnings = validate_skill(skill_dir)
    for code, message in errors:
        print(f"ERROR {code} {message}")
    for code, message in warnings:
        print(f"WARNING {code} {message}")
    if errors:
        print("Refusing to package: fix the errors above and rerun.")
        return None
    if warnings and not force:
        print("Refusing to package with warnings: fix them, or rerun with --force.")
        return None

    out_dir = Path(output_dir).resolve() if output_dir else Path.cwd()
    out_dir.mkdir(parents=True, exist_ok=True)
    out_file = out_dir / f"{skill_dir.name}.skill"
    if out_file.exists():
        print(f"Overwriting existing {out_file}")

    total_bytes = 0
    count = 0
    with zipfile.ZipFile(out_file, "w", zipfile.ZIP_DEFLATED) as zf:
        for path in sorted(skill_dir.rglob("*")):
            if not path.is_file():
                continue
            rel = path.relative_to(skill_dir)
            if should_exclude(rel):
                continue
            zf.write(path, Path(skill_dir.name) / rel)
            total_bytes += path.stat().st_size
            count += 1

    print(f"Packaged {count} file(s), {total_bytes / 1024:.1f} KB uncompressed -> {out_file}")
    if total_bytes > API_SIZE_LIMIT:
        print(f"WARNING: uncompressed size exceeds the 30 MB Skills API upload limit")
    return out_file


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("skill_dir", help="path to the skill directory")
    parser.add_argument("output_dir", nargs="?", default=None,
                        help="where to write the .skill file (default: current directory)")
    parser.add_argument("--force", action="store_true",
                        help="package despite validation warnings (errors still refuse)")
    args = parser.parse_args(argv)
    result = package_skill(args.skill_dir, args.output_dir, force=args.force)
    return 0 if result else 1


if __name__ == "__main__":
    sys.exit(main())
