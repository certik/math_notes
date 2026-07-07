/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib

/-!
# The Bohr–Mollerup theorem — flow-faithful development

This file formalizes `bohr_mollerup.md`, following the note's own logical order, which is Artin's
presentation of the theorem (see the Wikipedia article
<https://en.wikipedia.org/wiki/Bohr%E2%80%93Mollerup_theorem>).

The theorem characterizes the Gamma function `Γ` on the positive reals as the **unique** function
`f : (0, ∞) → ℝ` that is positive, log-convex, satisfies the functional equation
`f (x + 1) = x·f x`, and is normalized by `f 1 = 1`.

We bundle the three characterizing properties in the predicate `GammaLike` and then reproduce the
note's steps:

1. the functional equation forces `f (n + 1) = n!` and, more generally,
   `f (x + n) = f x · ∏_{m<n} (x + m)` (`GammaLike.f_nat`, `GammaLike.f_add_nat`, proved from
   scratch by induction);
2. log-convexity traps `log (f (n + x))` between two lines in `x` (`GammaLike.log_sandwich`);
3. the resulting squeeze shows the Euler/Gauss sequence
   `logGammaSeq x n = x·log n + log n! − ∑_{m≤n} log (x + m)` converges to `log (f x)`
   (`GammaLike.logGammaSeq_tendsto`);
4. since that limit does not depend on `f`, any two admissible functions agree, and each equals `Γ`
   (`GammaLike.eq_Gamma`, `GammaLike.unique`); the explicit Gauss product limit is
   `GammaLike.gauss_product`;
5. finally `Γ` itself is `GammaLike` (`gammaLike_Gamma`), giving the full characterization
   (`bohr_mollerup`).

The genuinely analytic squeeze — monotonicity of the secant slopes of `log ∘ f`, and the fact that
`log (n+1) − log n → 0` — is supplied by Mathlib's `Real.BohrMollerup` development
(`Mathlib/Analysis/SpecialFunctions/Gamma/BohrMollerup.lean`), which this file assembles into the
note's flow. The elementary recurrence identities of step 1 are proved here from scratch.
-/

open Filter Topology Set

open scoped Nat

namespace MathNotesLean

namespace BohrMollerupFlow

/-! ### The three characterizing properties -/

-- ANCHOR: bm-def
/-- The three Bohr–Mollerup hypotheses on a function `f : ℝ → ℝ`, packaged as a predicate:
`f` is positive and log-convex on `(0, ∞)`, satisfies `f (x + 1) = x · f x`, and `f 1 = 1`.
The theorem below says `Real.Gamma` is the unique such function. -/
structure GammaLike (f : ℝ → ℝ) : Prop where
  /-- `f` is positive on the positive reals. -/
  pos : ∀ x, 0 < x → 0 < f x
  /-- The Gamma functional equation `f (x + 1) = x · f x`. -/
  functional_eq : ∀ x, 0 < x → f (x + 1) = x * f x
  /-- `log ∘ f` is convex on the positive reals (i.e. `f` is log-convex). -/
  log_convex : ConvexOn ℝ (Ioi 0) (Real.log ∘ f)
  /-- Normalization `f 1 = 1`. -/
  one : f 1 = 1
-- ANCHOR_END: bm-def

variable {f g : ℝ → ℝ} {x : ℝ} {n : ℕ}

/-- Taking `log` of the functional equation turns it into the *additive* recurrence
`log (f (y + 1)) = log (f y) + log y`, the form used by Mathlib's Bohr–Mollerup lemmas. -/
theorem GammaLike.log_comp_feq (hf : GammaLike f) :
    ∀ {y : ℝ}, 0 < y → (Real.log ∘ f) (y + 1) = (Real.log ∘ f) y + Real.log y := by
  intro y hy
  simp only [Function.comp_apply]
  rw [hf.functional_eq y hy, Real.log_mul hy.ne' (hf.pos y hy).ne']
  ring

/-! ### Step 1: the functional equation reproduces the factorials -/

-- ANCHOR: bm-factorial
/-- **The functional equation forces the factorials.** From `f (x + 1) = x · f x` and `f 1 = 1`,
induction gives `f (n + 1) = n !` for every natural number `n`; in particular `f` interpolates the
factorials, `f n = (n − 1)!`. -/
theorem GammaLike.f_nat (hf : GammaLike f) (n : ℕ) : f (n + 1) = n ! := by
  induction n with
  | zero => simpa using hf.one
  | succ k ih =>
    have hk : (0 : ℝ) < (k : ℝ) + 1 := by positivity
    have hrec := hf.functional_eq ((k : ℝ) + 1) hk
    rw [Nat.cast_succ, hrec, ih, Nat.factorial_succ]
    push_cast
    ring
-- ANCHOR_END: bm-factorial

-- ANCHOR: bm-prod
/-- **The functional equation as a product.** Iterating `f (x + 1) = x · f x` `n` times gives
`f (x + n) = f x · x (x + 1) ⋯ (x + n − 1)`, i.e. `f (x + n) = f x · ∏_{m < n} (x + m)`. Knowing `f`
on `(0, 1]` therefore determines it everywhere on `(0, ∞)`. -/
theorem GammaLike.f_add_nat (hf : GammaLike f) (hx : 0 < x) (n : ℕ) :
    f (x + n) = f x * ∏ m ∈ Finset.range n, (x + m) := by
  induction n with
  | zero => simp
  | succ k ih =>
    have hxk : 0 < x + (k : ℝ) := by positivity
    have hrec := hf.functional_eq (x + (k : ℝ)) hxk
    have hcast : x + ((k : ℕ) + 1 : ℕ) = (x + (k : ℝ)) + 1 := by push_cast; ring
    rw [hcast, hrec, ih, Finset.prod_range_succ]
    ring
-- ANCHOR_END: bm-prod

/-! ### Step 2: log-convexity sandwiches `log (f (n + x))` between two lines -/

-- ANCHOR: bm-sandwich
/-- **The log-convexity sandwich.** For `0 < x ≤ 1` and `n ≥ 2`, convexity of `log ∘ f` forces the
secant slopes of `log ∘ f` to be monotone, which traps `log (f (n + x))` between the two lines in
`x` through the lattice values of `log ∘ f`:
`log (f n) + x·log (n − 1) ≤ log (f (n + x)) ≤ log (f n) + x·log n`. -/
theorem GammaLike.log_sandwich (hf : GammaLike f) (hn : 2 ≤ n) (hx : 0 < x) (hx' : x ≤ 1) :
    Real.log (f n) + x * Real.log ((n : ℝ) - 1) ≤ Real.log (f (n + x)) ∧
      Real.log (f (n + x)) ≤ Real.log (f n) + x * Real.log n := by
  refine ⟨?_, ?_⟩
  · simpa [Function.comp_apply] using
      Real.BohrMollerup.f_add_nat_ge hf.log_convex hf.log_comp_feq hn hx
  · simpa [Function.comp_apply] using
      Real.BohrMollerup.f_add_nat_le hf.log_convex hf.log_comp_feq (by omega : n ≠ 0) hx hx'
-- ANCHOR_END: bm-sandwich

/-! ### Step 3: the Euler/Gauss limit formula -/

-- ANCHOR: bm-limit
/-- **The Euler/Gauss limit formula for `f`.** Exponentiating and letting `n → ∞` in the sandwich of
step 2 squeezes the Gauss sequence
`logGammaSeq x n = x·log n + log n! − ∑_{m ≤ n} log (x + m)` (the logarithm of
`nˣ · n! / (x (x+1) ⋯ (x+n))`) to `log (f x)`. Because the limit does not depend on `f`, this is the
uniqueness engine of the theorem. -/
theorem GammaLike.logGammaSeq_tendsto (hf : GammaLike f) (hx : 0 < x) :
    Tendsto (Real.BohrMollerup.logGammaSeq x) atTop (𝓝 (Real.log (f x))) := by
  have h := Real.BohrMollerup.tendsto_logGammaSeq hf.log_convex hf.log_comp_feq hx
  simpa only [Function.comp_apply, hf.one, Real.log_one, sub_zero] using h
-- ANCHOR_END: bm-limit

/-! ### Step 4: uniqueness -/

-- ANCHOR: bm-eq-gamma
/-- **Uniqueness (each admissible `f` equals `Γ`).** Both `f` and `Real.Gamma` make `logGammaSeq x`
converge — to `log (f x)` and to `log (Γ x)` respectively — so those logs are equal by uniqueness of
limits, and injectivity of `log` on the positive reals gives `f x = Γ x` for all `x > 0`. -/
theorem GammaLike.eq_Gamma (hf : GammaLike f) : EqOn f Real.Gamma (Ioi 0) := by
  intro x hx
  have hx0 : 0 < x := hx
  have hlog : Real.log (f x) = Real.log (Real.Gamma x) :=
    tendsto_nhds_unique (hf.logGammaSeq_tendsto hx0) (Real.BohrMollerup.tendsto_log_gamma hx0)
  exact Real.log_injOn_pos (hf.pos x hx0) (Real.Gamma_pos_of_pos hx0) hlog
-- ANCHOR_END: bm-eq-gamma

-- ANCHOR: bm-unique
/-- Any two functions with the three Bohr–Mollerup properties agree on `(0, ∞)`. -/
theorem GammaLike.unique (hf : GammaLike f) (hg : GammaLike g) : EqOn f g (Ioi 0) :=
  fun _ hx => (hf.eq_Gamma hx).trans (hg.eq_Gamma hx).symm
-- ANCHOR_END: bm-unique

-- ANCHOR: bm-gauss
/-- **The explicit Gauss product.** Unwinding step 3, the value of any admissible `f` is Gauss's
product limit `f x = limₙ nˣ · n! / (x (x+1) ⋯ (x+n))`. -/
theorem GammaLike.gauss_product (hf : GammaLike f) (hx : 0 < x) :
    Tendsto (fun n : ℕ => (n : ℝ) ^ x * (n ! : ℝ) / ∏ j ∈ Finset.range (n + 1), (x + j))
      atTop (𝓝 (f x)) := by
  have h := Real.GammaSeq_tendsto_Gamma x
  rw [← hf.eq_Gamma hx] at h
  exact h
-- ANCHOR_END: bm-gauss

/-! ### Step 5: existence — `Real.Gamma` is admissible -/

-- ANCHOR: bm-exists
/-- **Existence.** `Real.Gamma` satisfies the three properties: it is positive
(`Real.Gamma_pos_of_pos`), obeys `Γ (x + 1) = x · Γ x` (`Real.Gamma_add_one`), is log-convex
(`Real.convexOn_log_Gamma`), and is normalized `Γ 1 = 1` (`Real.Gamma_one`). -/
theorem gammaLike_Gamma : GammaLike Real.Gamma where
  pos := fun _ hx => Real.Gamma_pos_of_pos hx
  functional_eq := fun _ hx => Real.Gamma_add_one hx.ne'
  log_convex := Real.convexOn_log_Gamma
  one := Real.Gamma_one
-- ANCHOR_END: bm-exists

/-! ### The Bohr–Mollerup theorem -/

-- ANCHOR: bm-main
/-- **The Bohr–Mollerup theorem.** `Real.Gamma` is `GammaLike`, and it is the *unique* `GammaLike`
function: every function that is positive and log-convex on `(0, ∞)`, satisfies
`f (x + 1) = x · f x`, and has `f 1 = 1`, coincides with `Real.Gamma` on `(0, ∞)`. -/
theorem bohr_mollerup :
    GammaLike Real.Gamma ∧ ∀ f, GammaLike f → EqOn f Real.Gamma (Ioi 0) :=
  ⟨gammaLike_Gamma, fun _ hf => hf.eq_Gamma⟩
-- ANCHOR_END: bm-main

end BohrMollerupFlow

end MathNotesLean
