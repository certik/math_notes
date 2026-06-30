# Math Notes

Notes on mathematics and theoretical physics, written in
[MyST Markdown](https://mystmd.org/) and accompanied, where useful, by
machine-checked **Lean 4 + Mathlib** formalizations. The goal is a literate
workflow: prose explains the mathematics, Lean verifies the crucial claims, and
the website presents both in one readable document.

Web version: https://math-notes-e2r.pages.dev/

## What this repository contains

| Path | Contents |
| --- | --- |
| `*.md` | The notes themselves, written in MyST Markdown. |
| `*.py` | Supporting SymPy/NumPy scripts that derive or check formulas used in the notes. |
| `math_notes_lean/` | The Lean 4 + Mathlib project that formalizes selected notes. |
| `scripts/check_lean_anchors.py` | Checks that every Lean snippet included in Markdown points at a real Lean source anchor. |
| `tests/test_myst_build.py` | Smoke test for the MyST build and a few repository-specific document checks. |
| `.github/workflows/` | CI for Lean verification and Cloudflare Pages deployment. |
| `myst.yml` | MyST project and website configuration. |
| `pixi.toml`, `pixi.lock` | Reproducible MyST/PDF build environment. |
| `package.json`, `package-lock.json` | CI-only Cloudflare Wrangler dependency, locked for deployment. |
| `references.bib` | Shared bibliography. |
| `_build/`, `node_modules/`, `math_notes_lean/.lake/` | Generated or downloaded files; these are git-ignored. |

The notes cover differential forms and tensors, determinants and traces of
`(0,2)` tensors, Lie groups and Lie algebras, Galilei/Poincare algebras,
spacetime metrics, statistical mechanics, kinetic energy, scaling functional
equations, and determinant homomorphisms.

## Prerequisites

Install these tools once on your machine:

1. **Git** for cloning and pushing the repository.
2. **pixi** for the MyST/Typst/TeX build environment. Use the installer from
   <https://pixi.sh/latest/>. On macOS or Linux:

   ```sh
   curl -fsSL https://pixi.sh/install.sh | bash
   ```

   On Windows, use the PowerShell installer shown in the pixi documentation.
   Restart the terminal afterward and check:

   ```sh
   pixi --version
   ```

3. **elan** for Lean. Install it from
   <https://github.com/leanprover/elan>. On macOS or Linux:

   ```sh
   curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
   ```

   On Windows, download and run `elan-init.exe` from the elan releases page.
   Restart the terminal afterward and check:

   ```sh
   lean --version
   lake --version
   ```

4. **A Lean-aware editor** is strongly recommended. VS Code with the
   `leanprover.lean4` extension is the usual setup. Open the repository root, then
   open Lean files under `math_notes_lean/MathNotesLean/`.

You do not need to install MyST, Typst, or Tectonic separately; pixi installs the
versions pinned in `pixi.toml` and `pixi.lock`.

## First-time setup

Clone the repository and enter it:

```sh
git clone https://github.com/certik/math_notes.git
cd math_notes
```

Create the pixi environment:

```sh
pixi install
```

Verify the Lean formalization:

```sh
cd math_notes_lean
lake build
cd ..
```

`lake build` is the essential command. It downloads dependencies as needed and
then type-checks the project. If the first build would otherwise compile a large
part of Mathlib locally, you can speed it up by running `lake exe cache get`
before `lake build` to download prebuilt Mathlib artifacts.

Build the MyST project:

```sh
pixi r build
```

At this point the repository is fully set up: the notes build, the Lean code
type-checks, and generated output is under `_build/`.

## Building and previewing the website

For live local editing, run:

```sh
pixi r start
```

MyST prints the local preview URL, usually `http://localhost:3000`. Keep this
server running while editing Markdown or Lean snippets; the browser preview will
refresh as files change.

To build the static HTML website exactly as the deployment workflow does:

```sh
pixi run -- myst build --html
```

The generated site is written to:

```text
_build/html/
```

For the default project build, including the configured exports, run:

```sh
pixi r build
```

PDF-related tasks are also defined in `pixi.toml`:

```sh
pixi r tex      # build the paper TeX export and compile it with tectonic
pixi r texdet   # build 02-determinant.md as TeX and compile it with tectonic
pixi r typst    # build Typst exports
```

## Reproducing the determinant construction

The determinant construction with the Lean-backed, literate presentation is in:

| File | Role |
| --- | --- |
| `determinant_homomorphism.md` | MyST note that presents the construction step by step. |
| `math_notes_lean/MathNotesLean/DeterminantHomomorphismFlow.lean` | Flow-faithful Lean proof following the note's logical order. |
| `math_notes_lean/MathNotesLean/CstarHomomorphismFlow.lean` | The reused classification of homomorphisms `C* -> C*`. |

To reproduce it locally:

```sh
pixi r start
```

Open `determinant_homomorphism.md` in the browser preview. The Lean dropdowns in
that page are inserted verbatim from `DeterminantHomomorphismFlow.lean`, using
the MyST `literalinclude` directive.

To verify just the determinant-flow module while working on it:

```sh
cd math_notes_lean
lake build MathNotesLean.DeterminantHomomorphismFlow
cd ..
```

To verify that every Markdown snippet still points at a valid Lean anchor:

```sh
python3 scripts/check_lean_anchors.py
```

To rebuild the website after changing the note:

```sh
pixi run -- myst build --html
```

## Writing notes in the literate Lean style

A Lean-backed note has two synchronized parts:

1. A MyST Markdown file, such as `determinant_homomorphism.md`.
2. A Lean file under `math_notes_lean/MathNotesLean/`, usually named
   `SomethingFlow.lean` when it is intended to follow the prose proof order.

In the Lean file, wrap each declaration that should appear in the note with a
balanced anchor pair:

```lean
-- ANCHOR: my-step-name
theorem my_step_name : True := by
  trivial
-- ANCHOR_END: my-step-name
```

In the Markdown note, include that exact checked Lean code with:

````md
:::{dropdown} Lean proof: `my_step_name`
```{literalinclude} math_notes_lean/MathNotesLean/MyFileFlow.lean
:language: lean
:start-after: ANCHOR: my-step-name
:end-before: ANCHOR_END: my-step-name
```
:::
````

After adding a new Lean file, import it from
`math_notes_lean/MathNotesLean.lean`. CI builds this aggregator, so a file that
is not imported there is not part of the checked project.

Use this loop while writing:

```sh
cd math_notes_lean
lake build MathNotesLean.MyFileFlow
cd ..
python3 scripts/check_lean_anchors.py
pixi r start
```

Lean's kernel checks the formal proof. The surrounding prose and the exact
correspondence between an informal claim and its Lean statement remain part of
the author's responsibility, which is why snippets should be placed next to the
statements they formalize.

## Lean project details

The Lean toolchain is pinned by:

```text
math_notes_lean/lean-toolchain
```

The Mathlib dependency is pinned in:

```text
math_notes_lean/lakefile.toml
math_notes_lean/lake-manifest.json
```

Current formalized notes include:

| Note | Main Lean file |
| --- | --- |
| `cstar_homomorphism.md` | `CstarHomomorphismFlow.lean` |
| `determinant_homomorphism.md` | `DeterminantHomomorphismFlow.lean` |
| `limits1.md` | `Limits1Flow.lean` |
| `scaling_functional_equation.md` | `ScalingFunctionalEquationFlow.lean` |
| `kinetic_energy_galilean.md` | `KineticEnergyGalileanFlow.lean` |

Additional supporting or alternative formalizations live in the same directory:
`AutomaticContinuity.lean`, `CircleCharacters.lean`,
`CstarHomomorphism.lean`, `DeterminantHomomorphism.lean`,
`DeterminantHomomorphismMonoid.lean`, and
`DeterminantHomomorphismReal.lean`.

The full Lean check is:

```sh
cd math_notes_lean
lake build
cd ..
```

The fast repository guard for Lean snippets is:

```sh
python3 scripts/check_lean_anchors.py
```

CI also rejects `sorry`, `admit`, and `sorryAx` in
`math_notes_lean/MathNotesLean/`.

## MyST project details

The website is configured in `myst.yml`. The current site uses the MyST
`book-theme` template. Individual notes may define frontmatter at the top of the
file, for example:

```yaml
---
date: 2025-01-15
authors:
  - name: Ondřej Čertík
exports:
  - format: docx
  - format: pdf
  - format: tex
  - format: typst
bibliography:
  - references.bib
---
```

Useful MyST features used in this repository include:

| Feature | Example |
| --- | --- |
| Cross-referenced equations | ```` ```{math}` with `:label:` ```` |
| Internal references | `{eq}` and Markdown links to explicit labels |
| Admonitions | `:::{note}`, `:::{tip}` |
| Collapsible proof blocks | `:::{dropdown}` |
| Lean source inclusion | ```` ```{literalinclude} ... ```` |
| Bibliography | `references.bib` plus note frontmatter |

When a raw TeX file or other file should not be parsed as a MyST page, list it
under `project.exclude` in `myst.yml`.

## Keeping a checkout up to date

Update an existing clone from GitHub:

```sh
git pull --ff-only
pixi install
cd math_notes_lean
lake build
cd ..
pixi r build
```

Run `pixi install` after changes to `pixi.toml` or `pixi.lock`. Run
`lake build` after changes to `math_notes_lean/lean-toolchain`,
`math_notes_lean/lakefile.toml`, or `math_notes_lean/lake-manifest.json`. If
that build starts compiling Mathlib from source, stop it and run
`lake exe cache get` first.

To intentionally update Lean or Mathlib:

1. Edit `math_notes_lean/lean-toolchain` and the Mathlib revision in
   `math_notes_lean/lakefile.toml`.
2. From `math_notes_lean/`, run `lake update`.
3. Run `lake build`.
4. If the build starts compiling Mathlib from source, run `lake exe cache get`
   and then rerun `lake build`.
5. Commit the updated `lake-manifest.json` together with the toolchain/dependency
   change.

To intentionally update the MyST build environment, edit `pixi.toml`, run:

```sh
pixi update
pixi r build
```

and commit the resulting `pixi.lock`.

To update the CI-only Wrangler dependency used for Cloudflare deployment:

```sh
npm install --save-dev wrangler@<version>
```

Commit both `package.json` and `package-lock.json`.

## Validating changes before publishing

For Markdown-only changes:

```sh
pixi r build
```

For Lean-backed notes:

```sh
python3 scripts/check_lean_anchors.py
cd math_notes_lean
lake build
cd ..
pixi r build
```

For the repository smoke test:

```sh
python3 -m unittest tests/test_myst_build.py
```

Generated files should stay out of commits unless they are intentionally tracked
outputs already present in the repository. In particular, do not commit `_build/`,
`node_modules/`, or `math_notes_lean/.lake/`.

## Publishing through GitHub and Cloudflare Pages

Normal contribution flow:

```sh
git status
git checkout -b my-note-branch
git add <changed-files>
git commit -m "Add my note"
git push origin my-note-branch
```

Then open a pull request on GitHub, or use:

```sh
gh pr create --fill
```

Two GitHub Actions workflows run on pushes and pull requests targeting `main`:

| Workflow | What it does |
| --- | --- |
| `.github/workflows/lean.yml` | Runs the anchor check, rejects proof holes, and runs `lake build`. |
| `.github/workflows/pages.yml` | Builds `_build/html` with MyST and deploys it to Cloudflare Pages. |

For pull requests in the main repository, the Pages workflow deploys a preview
branch named `pr-<number>` and comments the preview URL on the PR. When changes
land on `main`, the same workflow deploys the production site:

```text
https://math-notes-e2r.pages.dev/
```

For a fork or a new deployment target, configure a Cloudflare Pages project and
add these GitHub repository secrets:

```text
CLOUDFLARE_API_TOKEN
CLOUDFLARE_ACCOUNT_ID
```

The token must be allowed to deploy the Cloudflare Pages project named
`math-notes`, or the `--project-name` value in `.github/workflows/pages.yml`
must be changed to match the new project.

### Hosting a fork on GitHub Pages instead

GitHub Pages is the simplest option for a personal fork because it does not need
Cloudflare credentials. In a fork, either delete `.github/workflows/pages.yml` or
replace it with a GitHub Pages workflow so the Cloudflare deployment does not
run without secrets.

In the fork's GitHub settings, go to **Settings -> Pages** and set **Build and
deployment -> Source** to **GitHub Actions**. Then add this workflow as
`.github/workflows/github-pages.yml`:

```yaml
name: Deploy site to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: github-pages-${{ github.ref }}
  cancel-in-progress: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd  # v6.0.2

      - name: Setup pixi
        uses: prefix-dev/setup-pixi@a0af7a228712d6121d37aba47adf55c1332c9c2e  # v0.9.4
        with:
          pixi-version: v0.68.0
          cache: true

      - name: Build static HTML site
        env:
          BASE_URL: /${{ github.event.repository.name }}
        run: pixi run -- myst build --html

      - name: Setup GitHub Pages
        uses: actions/configure-pages@983d7736d9b0ae728b81ab479565c72886d7745b  # v5.0.0

      - name: Upload site artifact
        uses: actions/upload-pages-artifact@7b1f4a764d45c48632c6b24a0339c27f5614fb0b  # v4.0.0
        with:
          path: _build/html

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@5a55b947eeacb612c1156a4a8c71a250d4913a78  # v4.0.5
```

For a fork named `math_notes`, the site will be published at:

```text
https://<github-username>.github.io/math_notes/
```

If the fork is renamed, GitHub Pages uses the new repository name in the URL and
the workflow above adjusts `BASE_URL` automatically. If the site is hosted at a
domain root instead, such as `https://<github-username>.github.io/` from a
repository named `<github-username>.github.io` or from a custom domain, remove
the `BASE_URL` environment variable from the build step.

The existing `.github/workflows/lean.yml` workflow can stay unchanged in a fork;
it verifies the Lean sources independently of where the website is hosted.

## Troubleshooting

If `pixi` is not found, restart the terminal and confirm that the pixi install
directory is on `PATH`.

If `lake build` is slow the first time because it is compiling Mathlib, interrupt
it and run `lake exe cache get`; that command downloads prebuilt Mathlib
artifacts when they are available.

If a Lean snippet disappears from a note or the anchor check fails, check that the
anchor names in the Markdown exactly match the `-- ANCHOR:` and
`-- ANCHOR_END:` names in the Lean source.

If the website build fails after adding a file, check the file's frontmatter,
labels, literal includes, and whether it should be excluded in `myst.yml`.
