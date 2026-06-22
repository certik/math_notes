#!/usr/bin/env python3
"""Verify Markdown <-> Lean anchor correspondence.

Every `literalinclude` of a `.lean` file in the Markdown notes pulls a region
delimited by `-- ANCHOR: NAME` / `-- ANCHOR_END: NAME` comments. This script
checks that:

  * each `:start-after: ANCHOR: NAME` has a matching `:end-before: ANCHOR_END: NAME`;
  * the referenced `.lean` file exists and contains exactly one balanced
    `-- ANCHOR: NAME` / `-- ANCHOR_END: NAME` pair for that NAME;
  * every anchor defined in a referenced `.lean` file is balanced (every start
    has exactly one end and vice versa).

It exits non-zero (listing every problem) if any check fails, so CI fails fast
when a displayed proof is renamed, removed, or its markers drift out of sync.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

DIRECTIVE_RE = re.compile(r"^\s*```\{literalinclude\}\s+(\S+)\s*$")
FENCE_RE = re.compile(r"^\s*```\s*$")
OPTION_RE = re.compile(r"^\s*:(start-after|end-before):\s*(.*\S)\s*$")
ANCHOR_START_RE = re.compile(r"^\s*--\s*ANCHOR:\s*(\S+)\s*$")
ANCHOR_END_RE = re.compile(r"^\s*--\s*ANCHOR_END:\s*(\S+)\s*$")


def anchor_name(value: str, kind: str) -> str | None:
    """Extract NAME from a `ANCHOR: NAME` / `ANCHOR_END: NAME` option value."""
    prefix = "ANCHOR_END:" if kind == "end" else "ANCHOR:"
    if not value.startswith(prefix):
        return None
    return value[len(prefix):].strip()


def lean_anchor_index(path: Path) -> tuple[dict[str, int], dict[str, int]]:
    starts: dict[str, int] = {}
    ends: dict[str, int] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        m = ANCHOR_START_RE.match(line)
        if m:
            starts[m.group(1)] = starts.get(m.group(1), 0) + 1
        m = ANCHOR_END_RE.match(line)
        if m:
            ends[m.group(1)] = ends.get(m.group(1), 0) + 1
    return starts, ends


def iter_literalincludes(md_path: Path):
    """Yield (line_no, lean_path_str, start_value, end_value) per literalinclude."""
    lines = md_path.read_text(encoding="utf-8").splitlines()
    i = 0
    n = len(lines)
    while i < n:
        m = DIRECTIVE_RE.match(lines[i])
        if not m:
            i += 1
            continue
        target = m.group(1)
        start_val = end_val = None
        j = i + 1
        while j < n and not FENCE_RE.match(lines[j]):
            om = OPTION_RE.match(lines[j])
            if om:
                if om.group(1) == "start-after":
                    start_val = om.group(2)
                else:
                    end_val = om.group(2)
            j += 1
        if target.endswith(".lean"):
            yield i + 1, target, start_val, end_val
        i = j + 1


def main() -> int:
    errors: list[str] = []
    referenced_lean: set[Path] = set()

    for md_path in sorted(ROOT.glob("*.md")):
        for line_no, target, start_val, end_val in iter_literalincludes(md_path):
            where = f"{md_path.name}:{line_no}"
            lean_path = (md_path.parent / target).resolve()
            if not lean_path.exists():
                errors.append(f"{where}: literalinclude target not found: {target}")
                continue
            referenced_lean.add(lean_path)

            if start_val is None or end_val is None:
                errors.append(
                    f"{where}: literalinclude of {target} must set both "
                    f":start-after: and :end-before: (anchor convention)"
                )
                continue

            start_name = anchor_name(start_val, "start")
            end_name = anchor_name(end_val, "end")
            if start_name is None:
                errors.append(f"{where}: :start-after: must be 'ANCHOR: NAME', got '{start_val}'")
                continue
            if end_name is None:
                errors.append(f"{where}: :end-before: must be 'ANCHOR_END: NAME', got '{end_val}'")
                continue
            if start_name != end_name:
                errors.append(
                    f"{where}: anchor mismatch — start '{start_name}' vs end '{end_name}'"
                )
                continue

            starts, ends = lean_anchor_index(lean_path)
            if starts.get(start_name, 0) != 1 or ends.get(start_name, 0) != 1:
                errors.append(
                    f"{where}: anchor '{start_name}' must appear exactly once as "
                    f"'-- ANCHOR: {start_name}' and once as '-- ANCHOR_END: {start_name}' "
                    f"in {target} (found {starts.get(start_name, 0)} start / "
                    f"{ends.get(start_name, 0)} end)"
                )

    for lean_path in sorted(referenced_lean):
        starts, ends = lean_anchor_index(lean_path)
        rel = lean_path.relative_to(ROOT)
        for name, count in starts.items():
            if count != 1:
                errors.append(f"{rel}: '-- ANCHOR: {name}' defined {count} times (expected 1)")
            if ends.get(name, 0) != 1:
                errors.append(f"{rel}: '-- ANCHOR: {name}' has no matching '-- ANCHOR_END: {name}'")
        for name, count in ends.items():
            if name not in starts:
                errors.append(f"{rel}: '-- ANCHOR_END: {name}' has no matching '-- ANCHOR: {name}'")
            elif count != 1:
                errors.append(f"{rel}: '-- ANCHOR_END: {name}' defined {count} times (expected 1)")

    if errors:
        print("Lean anchor check FAILED:\n")
        for e in errors:
            print(f"  - {e}")
        print(f"\n{len(errors)} problem(s) found.")
        return 1

    print("Lean anchor check passed: all Markdown literalinclude anchors resolve.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
