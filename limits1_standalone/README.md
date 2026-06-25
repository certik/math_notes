# `limits1_standalone` — self-contained Lean build of `Limits1Flow.lean`

This directory is a standalone Lean 4 project whose **only** purpose is to type-check
[`MathNotesLean/Limits1Flow.lean`](MathNotesLean/Limits1Flow.lean) (the flow-faithful ε–δ proof of
the product rule for limits, see [`../limits1.md`](../limits1.md)).

Unlike the main [`math_notes_lean/`](../math_notes_lean) project, it does **not** depend on the
`mathlib` package. Instead, every Mathlib `.lean` file that `Limits1Flow.lean` transitively needs has
been **vendored** into [`Mathlib/`](Mathlib) (817 files) and is compiled from source. The only
external `require`s are the upstream tactic/util packages those vendored files import — Batteries,
Aesop, Qq, ProofWidgets, ImportGraph, Plausible, LeanSearchClient — pinned to the same revisions as
the main project. Lean core (`Init` / `Lean` / `Std`) comes from the toolchain and needs no require.

The vendored Mathlib sources are Apache-2.0 licensed; their license is kept verbatim in
[`Mathlib/LICENSE`](Mathlib/LICENSE).

## Building

The toolchain is pinned by [`lean-toolchain`](lean-toolchain) (selected automatically by `elan`).

```
lake build
```

`lake` fetches the seven dependency packages from the manifest, builds the vendored `Mathlib/`
subtree, then `Limits1Flow.lean`. A green build type-checks the proof; the development is
axiom-clean (`propext`, `Classical.choice`, `Quot.sound`) and `sorry`-free.

## How the vendored file set was determined

The minimal imports of `Limits1Flow.lean` were found with Mathlib's `#import_bumps` linter
(`Mathlib.Topology.MetricSpace.Pseudo.Defs`, plus `Std.Tactic.BVDecide.LRAT.Internal.Clause` from
Lean core). `Mathlib/` is exactly the set of files `lake` compiles to satisfy that import — no more,
no less. The target file is identical to the original except its `import Mathlib` umbrella is
replaced by those two precise imports.
