# Math Notes

Notes on mathematics and theoretical physics, written in
[MyST Markdown](https://mystmd.org/), that will eventually go into
[TPR](https://theoretical-physics.com) (the Theoretical Physics Reference). A
growing subset of the notes is accompanied by a machine-checked **Lean 4 +
Mathlib** formalization, so the key proofs are verified by a computer and cannot
silently drift from the prose.

Web version: https://math-notes-e2r.pages.dev/

## Repository layout

| Path | Contents |
| --- | --- |
| `*.md` | The notes themselves (MyST Markdown). |
| `*.py` | Supporting SymPy/NumPy scripts that derive or check formulas used in the notes (rotations, Lorentz/Galilei groups, Wigner, polar decomposition, …). |
| `math_notes_lean/` | The Lean 4 + Mathlib project that formalizes selected notes. |
| `scripts/check_lean_anchors.py` | Validates that every Lean snippet shown in a note points at a real anchor in the Lean sources. |
| `.github/workflows/` | CI: `lean.yml` verifies the formalization; `pages.yml` builds and deploys the web version. |
| `myst.yml`, `pixi.toml`, `references.bib` | MyST site config, [pixi](https://pixi.sh/) task/environment definitions, and the shared bibliography. |
| `_build/` | Generated output (HTML, PDFs); git-ignored. |

The notes cover, among other topics: differential forms and tensors,
determinants and traces of `(0,2)` tensors, Lie groups and Lie algebras and
their bottom-up derivations, the Galilei/Poincaré algebras and the spacetime
metric, statistical mechanics, and Thomas–Fermi–Dirac theory.

## Building the notes (HTML / PDF)

The build environment is managed by [pixi](https://pixi.sh/); the tasks live in
`pixi.toml` (`pixi r` is shorthand for `pixi run`).

Serve the HTML site locally with live preview:

```
pixi r start
```

Build the paper as a PDF using TeX (via `tectonic`):

```
pixi r tex
open _build/exports/paper_tex/paper.pdf
```

Build the paper as a PDF using Typst:

```
pixi r typst
open _build/exports/paper_typst/paper.pdf
```

`pixi r build` runs `myst build` to produce the configured exports under
`_build/`.

## How the Lean formalization works

Two notes currently carry a complete, machine-checked formalization:

- [`cstar_homomorphism.md`](cstar_homomorphism.md) — the classification of
  measurable group homomorphisms $g:\mathbb C^*\to\mathbb C^*$, built up from the
  Cauchy functional equations.
- [`determinant_homomorphism.md`](determinant_homomorphism.md) — every
  homomorphism $f:GL_n(\mathbb C)\to\mathbb C^*$ factors through the determinant.

The Lean code lives in `math_notes_lean/MathNotesLean/`. The root aggregator
`math_notes_lean/MathNotesLean.lean` imports every module, so anything not listed
there is not built by CI.

### Notes ↔ Lean: the anchor mechanism

Each proof shown in a note is pulled **verbatim from the compiled Lean source**,
so the displayed code is exactly what the kernel checks:

- In a `.lean` file, a declaration is wrapped in a `-- ANCHOR: name` /
  `-- ANCHOR_END: name` comment pair.
- In the `.md` note, a MyST `dropdown` contains a `literalinclude` directive
  with `:start-after: ANCHOR: name` / `:end-before: ANCHOR_END: name`, which
  splices in just that region.
- `scripts/check_lean_anchors.py` (the "anchor check") verifies that every such
  reference resolves to exactly one balanced anchor pair, so a renamed or removed
  proof fails CI instead of silently showing stale code.

Lean's kernel guarantees each *proof* is correct; whether a *statement*
faithfully captures the informal claim remains a human judgement, which is why
each dropdown sits next to the statement it formalizes.

### Flow-faithful vs. alternative formalizations

Most formalized notes come in **two** Lean files, capturing two different levels
of confidence:

1. **Claim-truth** — the "standard" file (e.g. `CstarHomomorphism.lean`,
   `DeterminantHomomorphism.lean`) proves each statement using Mathlib results
   directly. It certifies that every claim is *true*, but may take library
   shortcuts the note does not.
2. **Flow-faithfulness** — the companion `*Flow.lean` file (e.g.
   `CstarHomomorphismFlow.lean`, `DeterminantHomomorphismFlow.lean`) re-derives
   every result **in the note's own logical order**, each step reusing the
   previous step rather than an opaque library lemma. This certifies that the
   note's actual *construction* is sound and non-circular.

   For example, `DeterminantHomomorphismFlow.lean` does not use `Matrix.det` at
   all: it defines its own Leibniz polynomial $L=\sum_\sigma \operatorname{sgn}(\sigma)\prod_i A_{i,\sigma(i)}$
   and proves multiplicativity from scratch. `CstarHomomorphismFlow.lean`
   re-derives the "measurable additive map is continuous" step from the
   Steinhaus theorem instead of citing Mathlib's black box.

The Markdown notes are wired to the **flow** files; the standard files are kept
as alternative formalizations. The flow files never depend on the standard
files — they import only Mathlib and other in-project flow/shared modules.

### Lean project files

| File | Role |
| --- | --- |
| `CstarHomomorphism.lean` | Standard formalization of `cstar_homomorphism.md`. |
| `CstarHomomorphismFlow.lean` | Flow-faithful, self-contained version (wired to the note). |
| `DeterminantHomomorphism.lean` | Standard formalization of `determinant_homomorphism.md`. |
| `DeterminantHomomorphismFlow.lean` | Flow-faithful version that avoids `Matrix.det` (wired to the note). |
| `AutomaticContinuity.lean` | Measurable multiplicative maps on `ℝ` are continuous; shared by both notes and a Mathlib-upstreaming candidate. |
| `CircleCharacters.lean` | Continuous characters of the unit circle are integer power maps; a Mathlib-upstreaming candidate. |
| `Basic.lean` | Placeholder. |

### Main results

- `cstar_homomorphism_formula_measurable` — a measurable
  $g:\mathbb C^*\to\mathbb C^*$ has the polar form
  $g(w)=|w|^{s}\,(w/|w|)^{k}$ for some $s\in\mathbb C$, $k\in\mathbb Z$, with the
  pair $(s,k)$ unique (`cstarFormulaHom_injective`).
- `existsUnique_hom_factor_det` — every $f:GL_n(\mathbb C)\to\mathbb C^*$ factors
  **uniquely** through the determinant as $f(A)=g(\det A)$ for a homomorphism
  $g:\mathbb C^*\to\mathbb C^*$; `hom_factor_det_cstar` combines this with the
  classification above.

### Building / verifying the Lean proofs

The toolchain is pinned by `math_notes_lean/lean-toolchain`; with
[`elan`](https://github.com/leanprover/elan) installed it is selected
automatically. From the `math_notes_lean/` directory:

```
lake exe cache get   # download prebuilt Mathlib (first time / after a bump)
lake build           # type-checks every theorem; fails on any error or `sorry`
```

A green `lake build` is the real guarantee that every proof displayed in the
notes type-checks.

### Continuous integration

`.github/workflows/lean.yml` runs on every push and PR:

- the **anchor check** (`scripts/check_lean_anchors.py`) and a grep that forbids
  `sorry` / `admit` in the Lean sources (fast, toolchain-free guards), and
- a full `lake build` of the project.

`.github/workflows/pages.yml` builds the MyST site and deploys it to Cloudflare
Pages (with a preview URL commented on each PR).
