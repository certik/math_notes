"""Verify the MyST site build completes without warnings or errors."""

from __future__ import annotations

import re
import subprocess
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

FORBIDDEN_MARKERS = (
    "Warning:",
    "⚠️",
    "⛔️",
    "Unhandled TEX",
    "Duplicate identifier",
    "implicit heading reference",
    r"Replacing \begin{eqnarray}",
)


class MystBuildTest(unittest.TestCase):
    def test_pixi_build_exits_cleanly_without_warnings(self) -> None:
        result = subprocess.run(
            ["pixi", "r", "build"],
            cwd=REPO_ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
        output = result.stdout + result.stderr

        self.assertEqual(
            result.returncode,
            0,
            f"pixi r build failed with exit code {result.returncode}:\n{output}",
        )
        self.assertRegex(
            output,
            r"Built \d+ pages for project",
            "build output missing the expected success line",
        )

        for marker in FORBIDDEN_MARKERS:
            with self.subTest(marker=marker):
                self.assertNotIn(marker, output)

    def test_myst_yml_excludes_problematic_tex_files(self) -> None:
        myst_yml = (REPO_ROOT / "myst.yml").read_text(encoding="utf-8")
        self.assertIn("ukol5_5.tex", myst_yml)
        self.assertIn("ukol5_6.tex", myst_yml)
        self.assertIn("exclude:", myst_yml)

    def test_determinant_of_tensors_has_explicit_section_labels(self) -> None:
        content = (REPO_ROOT / "determinant_of_tensors.md").read_text(encoding="utf-8")
        labels = re.findall(r"^\(id-\d+-[^)]+\)=$", content, flags=re.MULTILINE)
        self.assertEqual(len(labels), 10)


if __name__ == "__main__":
    unittest.main()