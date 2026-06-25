# Mathlib footprint of `Limits1Flow.lean`

This note explains the size and contents of the vendored [`Mathlib/`](Mathlib) tree in this
self-contained project: **why ~10 MB of Mathlib source is needed to type-check a five-line
ε–δ proof of the product rule for limits, and what 90 % of Mathlib was left out.**

All figures below were measured directly from this project's `Mathlib/` directory and from a full
Mathlib checkout at the same revision (`v4.32.0-rc1`, 8 191 source files). The vendored set is the
exact source-level import closure of `MathNotesLean/Limits1Flow.lean` (see
[`README.md`](README.md) for how it was computed).

---

## 1. Why is `Mathlib/` still ~10 MB?

Short version: **"the real numbers" is one of the most infrastructure-heavy objects in
mathematics.** Most of the 10 MB is not ℝ itself — it is the algebraic scaffolding ℝ is an
*instance* of, plus the general-purpose tactic engines the proof invokes.

ℝ proper is tiny: `Data/Real/` is **20 KB** (one file) and its Cauchy-sequence completion
`Algebra/Order/CauSeq/` is **52 KB** (two files) — about **72 KB total**. The other ~9.9 MB is
everything ℝ stands on.

### Size by area (817 files, ~10 MB)

| Area | Size | Files | What it is |
| --- | ---: | ---: | --- |
| `Data/` | 2.7 MB | 209 | ℕ/ℤ/ℚ and the collection types `Set` (564 KB), `Finset`/`List`/`Multiset` (~1 MB), `Fin`, `ENNReal` |
| `Algebra/` | 2.4 MB | 208 | the typeclass tower `Mul → Semigroup → Monoid → Group → Ring → Field` + ordered variants |
| `Tactic/` | 2.2 MB | 200 | the proof automation: `ring`, `field_simp`, `linarith`, `positivity`, `norm_num`, `gcongr`, `aesop`, `omega` |
| `Order/` | 1.7 MB | 91 | `Preorder → PartialOrder → LinearOrder`, lattices, filters |
| `Topology/` | 0.7 MB | 25 | metric spaces / neighbourhoods (only for the `Tendsto` faithfulness bridge) |
| `Logic/`, `Lean/`, `Util/`, `Control/`, … | 0.7 MB | 84 | basic logic, `Equiv`, metaprogramming helpers |

### Four reasons "just real numbers" is this big

1. **ℝ sits at the top of a tall tower.** To write `x * y < ε` Mathlib instantiates ℝ as a
   `LinearOrderedField`, so it must first build the entire abstract algebra hierarchy (the 2.4 MB
   `Algebra/`), each layer with its own lemma library. ℝ is a thin cap on top.
2. **ℚ/ℤ/ℕ come along for free — and drag in the collections library.** Building ℝ from Cauchy
   sequences of ℚ pulls in ℚ → ℤ → ℕ and the `Set`/`Finset`/`List`/`Multiset` machinery (~1.5 MB)
   that finite sums and the algebra lemmas rest on.
3. **~2.2 MB is general-purpose tactics, not mathematics.** `ring`, `field_simp`, `linarith`,
   `positivity`, `norm_num` are full metaprograms; you import the *whole* engine even to use it once,
   and the proof uses every one of them.
4. **It is source text, most of which is not active code.** Of **233 676** total lines, ~53 k are
   blank and ~19 k are comments/docstrings. And only **246 of the 817 files actually contribute a
   constant to the proof term** — the other 571 are imported transitively for elaboration
   (instances, notation, tactic glue) but never put a theorem into the final kernel-checked term.

A bespoke, self-contained ℝ-with-limits (custom field, arithmetic `min`/`abs`, no tactic engines)
could be a few hundred KB — but it would give up all of Mathlib's generality and automation.

---

## 2. What was removed (everything *above* basic real analysis)

The vendored set is **817 of Mathlib's 8 191 files**. The other **7 374 files (90 %)** were not
needed. What was dropped is, essentially, *all of modern mathematics above the ℝ foundation*.

### Removed files by top-level area

| Area | Files cut | What it is |
| --- | ---: | --- |
| **Algebra** (advanced) | 1 129 | polynomials, matrices, modules, tensor/exterior/Lie/Clifford algebras, homological algebra — everything past the basic ring/field tower we kept |
| **CategoryTheory** | 1 080 | functors, limits/colimits, abelian categories, sheaves, monads, topos theory |
| **Analysis** (advanced) | 791 | derivatives & calculus (127), normed/Banach spaces (159), special functions exp/log/trig/Γ (101), complex analysis (71), inner-product/Hilbert spaces (52), C\*-algebras (44), Fourier (14), distributions (15) |
| **RingTheory** | 701 | ideals, localization, Noetherian/Dedekind domains, valuations, Witt vectors, class groups |
| **Topology** (advanced) | 646 | general/algebraic topology beyond metric defs, uniform spaces, homotopy |
| **Data** (advanced) | 436 | polynomials, matrices, advanced finite structures |
| **LinearAlgebra** | 361 | bases, dimension, eigenvalues, **determinants**, bilinear/quadratic forms, tensor products |
| **MeasureTheory** | 308 | Lebesgue measure, integration, `Lᵖ` spaces |
| **NumberTheory** | 238 | Fermat, Bernoulli, Chebyshev, Dirichlet characters, cyclotomic fields, class numbers, modular forms |
| **Combinatorics** | 192 | graph theory, Ramsey, simplicial complexes, pigeonhole |
| **GroupTheory** | 161 | Sylow theorems, group actions, cohomology |
| **AlgebraicTopology** | 155 | simplicial sets, homology, model categories |
| **Geometry** | 142 | smooth manifolds, Euclidean geometry, diffeology, ringed spaces |
| **Probability** | 136 | random variables, martingales, conditional expectation |
| **AlgebraicGeometry** | 135 | schemes, sheaves, `Spec`, projective varieties |
| **FieldTheory** (83), **SetTheory** (54), **RepresentationTheory** (40), **Computability** (36), **ModelTheory** (34), **Dynamics** (34), **Condensed** (34), **InformationTheory** (6) | | Galois theory; ordinals/cardinals/forcing; group representations; Turing machines; first-order logic; ergodic theory; condensed mathematics; entropy |

### The picture

Famous results now absent include **Fermat's Last Theorem components, the Riemann ζ-function,
Fourier analysis, Lebesgue integration, smooth manifolds, Hilbert spaces, Galois theory, elliptic
curves, schemes, and the Sylow theorems** — and even **the derivative** (`Analysis/Calculus`,
127 files) and **determinants/eigenvalues** (`LinearAlgebra`).

The product rule for limits needed **none** of `Analysis/Calculus`, `MeasureTheory`,
`LinearAlgebra`, or `CategoryTheory`. The 817 files we kept are purely the **vertical slice** from
logic → ℕ/ℤ/ℚ → algebraic & order typeclasses → ℝ → absolute value / metric defs, plus the tactic
engines. Everything else in Mathlib builds *sideways and upward* from that same spine — which is
why ℝ sits so low in the dependency graph (almost everything imports it) and why our slice is only
10 % of the library. The product rule for limits sits near the **bottom** of the mathematical
universe Mathlib formalizes.

---

*Figures measured at Mathlib `v4.32.0-rc1`. Regenerate the kept/removed split with
`find Mathlib -name '*.lean'` here versus a full Mathlib checkout.*
