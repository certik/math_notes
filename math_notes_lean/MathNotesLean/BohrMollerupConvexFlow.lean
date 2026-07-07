/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib

/-!
# Bohr–Mollerup with convexity instead of log-convexity is **false**

This file accompanies `bohr_mollerup_convex.md`. It asks whether the Bohr–Mollerup characterization
of `Γ` survives if the hypothesis "`log ∘ f` is convex" is weakened to "`f` is convex". It does
**not**: for every `ε > 0` the function

  `fᵥ(x) = Γ(x) · (1 + ε (1 - cos 2πx))`

is a positive solution of the Gamma functional equation with `fᵥ 1 = 1`, is different from `Γ`, and
is **not** log-convex — yet (as proved analytically in the note, and confirmed numerically) it is
**convex** on `(0, ∞)` for small `ε` (e.g. `ε = 1/100`). Hence convexity alone does not single out
`Γ`.

Since `log ∨ f` convex ⟹ `f` convex (for positive `f`), convexity is a *strictly weaker* hypothesis,
so this is exactly the expected failure. Concretely we prove here, with no proof holes:

* `perturb` is `1`-periodic, positive, and equals `1` at `x = 1` (so it preserves everything);
* `f` is positive, obeys `f (x+1) = x f x`, and `f 1 = 1`;
* `ratio_periodic`: **any** solution of the functional equation is `Γ` times a `1`-periodic function
  — the solution space is huge, and only a shape hypothesis can pin down `Γ`;
* `f_ne_Gamma`: `fᵥ ≠ Γ` (already at `x = 1/2`);
* `not_logConvex`: `fᵥ` is not log-convex (else Mathlib's `Real.eq_Gamma_of_log_convex` would force
  `fᵥ = Γ`);
* `convex_hypothesis_insufficient`: the Lean-checkable core, bundling all of the above.

The one ingredient that is **not** machine-checked is the convexity of `fᵥ` itself: it needs
lower bounds on the tri/di-gamma functions (`(log Γ)''(x) ≥ 1/x` and `(log Γ)'(x) → ∞`) that current
Mathlib does not provide. That step is proved on paper and confirmed numerically in the note.
-/

open Real Set

namespace MathNotesLean

namespace BohrMollerupConvexFlow

/-! ### The `1`-periodic factor -/

-- ANCHOR: bmc-perturb
/-- The `1`-periodic factor `1 + ε (1 - cos 2πx)`. It is `≥ 1`, so positive for `ε ≥ 0`; it equals
`1` at every integer; and it has period `1`. Multiplying `Γ` by it therefore keeps positivity, the
functional equation `f (x+1) = x f x`, and the normalization `f 1 = 1`. -/
noncomputable def perturb (ε x : ℝ) : ℝ := 1 + ε * (1 - Real.cos (2 * π * x))

/-- `perturb` has period `1`, since `cos` has period `2π`. -/
theorem perturb_periodic (ε x : ℝ) : perturb ε (x + 1) = perturb ε x := by
  have h : Real.cos (2 * π * (x + 1)) = Real.cos (2 * π * x) := by
    rw [show 2 * π * (x + 1) = 2 * π * x + 2 * π by ring]; exact Real.cos_add_two_pi _
  unfold perturb; rw [h]

/-- `perturb` is positive for `ε ≥ 0`, because `1 - cos ≥ 0`. -/
theorem perturb_pos (hε : 0 ≤ ε) (x : ℝ) : 0 < perturb ε x := by
  have h : 0 ≤ ε * (1 - Real.cos (2 * π * x)) :=
    mul_nonneg hε (by linarith [Real.cos_le_one (2 * π * x)])
  unfold perturb; linarith

/-- `perturb ε 1 = 1`, since `cos 2π = 1`. -/
theorem perturb_one (ε : ℝ) : perturb ε 1 = 1 := by
  have h : Real.cos (2 * π * 1) = 1 := by
    rw [show 2 * π * 1 = 2 * π by ring]; exact Real.cos_two_pi
  unfold perturb; rw [h]; ring
-- ANCHOR_END: bmc-perturb

variable {ε : ℝ}

/-! ### The candidate function and its basic properties -/

-- ANCHOR: bmc-def
/-- The counterexample candidate `fᵥ(x) = Γ(x) · (1 + ε (1 - cos 2πx))`. -/
noncomputable def f (ε x : ℝ) : ℝ := Gamma x * perturb ε x

/-- `fᵥ` is positive on `(0, ∞)` for `ε ≥ 0` (a product of positives). -/
theorem f_pos (hε : 0 ≤ ε) {x : ℝ} (hx : 0 < x) : 0 < f ε x :=
  mul_pos (Gamma_pos_of_pos hx) (perturb_pos hε x)

/-- **Normalization** `fᵥ 1 = 1`, from `Γ 1 = 1` and `perturb ε 1 = 1`. -/
theorem f_one (ε : ℝ) : f ε 1 = 1 := by
  unfold f; rw [Gamma_one, perturb_one]; ring
-- ANCHOR_END: bmc-def

-- ANCHOR: bmc-funeq
/-- **The Gamma functional equation is preserved**: `fᵥ (x + 1) = x · fᵥ x` for `x > 0`, because
`Γ (x+1) = x Γ x` and `perturb` has period `1`. -/
theorem f_functional_eq {x : ℝ} (hx : 0 < x) : f ε (x + 1) = x * f ε x := by
  unfold f; rw [Gamma_add_one hx.ne', perturb_periodic]; ring
-- ANCHOR_END: bmc-funeq

-- ANCHOR: bmc-structure
/-- **The solution space of the functional equation.** For *any* `F` obeying `F (y+1) = y F y`, the
ratio `F / Γ` is `1`-periodic; equivalently every solution equals `Γ` times a `1`-periodic function.
So positivity + functional equation + `F 1 = 1` leave an infinite-dimensional family of solutions,
and only a *shape* hypothesis (log-convexity, or — the question here — convexity) can hope to
single out `Γ`. -/
theorem ratio_periodic {F : ℝ → ℝ} (hF : ∀ y, 0 < y → F (y + 1) = y * F y)
    {x : ℝ} (hx : 0 < x) : F (x + 1) / Gamma (x + 1) = F x / Gamma x := by
  have hx' : x ≠ 0 := hx.ne'
  have hg : Gamma x ≠ 0 := (Gamma_pos_of_pos hx).ne'
  rw [hF x hx, Gamma_add_one hx.ne']
  field_simp
-- ANCHOR_END: bmc-structure

/-! ### `fᵥ ≠ Γ` and `fᵥ` is not log-convex -/

-- ANCHOR: bmc-half-ne
/-- The value at `x = 1/2`: `fᵥ(1/2) = Γ(1/2) · (1 + 2ε)`, since `cos π = -1`. -/
theorem f_half (ε : ℝ) : f ε (1 / 2) = Gamma (1 / 2) * (1 + 2 * ε) := by
  have hcos : Real.cos (2 * π * (1 / 2)) = -1 := by
    rw [show 2 * π * (1 / 2) = π by ring]; exact Real.cos_pi
  unfold f perturb; rw [hcos]; ring

/-- For `ε > 0`, `fᵥ` differs from `Γ`: they already disagree at `x = 1/2`, where
`fᵥ(1/2) = (1 + 2ε) Γ(1/2) > Γ(1/2)`. -/
theorem f_ne_Gamma (hε : 0 < ε) : ¬ Set.EqOn (f ε) Gamma (Ioi 0) := by
  intro hEq
  have h : f ε (1 / 2) = Gamma (1 / 2) := hEq (by norm_num : (1 / 2 : ℝ) ∈ Ioi (0 : ℝ))
  rw [f_half] at h
  have hg : 0 < Gamma (1 / 2 : ℝ) := Gamma_pos_of_pos (by norm_num)
  nlinarith [h, mul_pos hg hε]
-- ANCHOR_END: bmc-half-ne

-- ANCHOR: bmc-not-logconvex
/-- **`fᵥ` is not log-convex.** If `log ∘ fᵥ` were convex on `(0, ∞)`, then the log-convex
Bohr–Mollerup theorem `Real.eq_Gamma_of_log_convex` — whose other hypotheses (positivity, the
functional equation, `fᵥ 1 = 1`) we have verified — would force `fᵥ = Γ` on `(0, ∞)`, contradicting
`f_ne_Gamma`. So `fᵥ` lies strictly *below* log-convexity. Together with the convexity of `fᵥ`
(proved analytically in the note), this is exactly why convexity is too weak to characterize `Γ`. -/
theorem not_logConvex (hε : 0 < ε) : ¬ ConvexOn ℝ (Ioi 0) (log ∘ f ε) := by
  intro hconv
  have hEq : Set.EqOn (f ε) Gamma (Ioi 0) :=
    Real.eq_Gamma_of_log_convex hconv (fun {_} hy => f_functional_eq hy)
      (fun {_} hy => f_pos hε.le hy) (f_one ε)
  exact f_ne_Gamma hε hEq
-- ANCHOR_END: bmc-not-logconvex

/-! ### The Lean-checkable core -/

-- ANCHOR: bmc-summary
/-- **Convexity is not sufficient (the machine-checked core).** For every `ε > 0`, `fᵥ` is a
positive solution of the Gamma functional equation with `fᵥ 1 = 1` that is **not** equal to `Γ` and
is **not** log-convex. The note proves analytically (and confirms numerically) that for small `ε`
(e.g. `ε = 1/100`) it is moreover **convex** — so, unlike log-convexity, plain convexity does not
determine `Γ`. -/
theorem convex_hypothesis_insufficient (hε : 0 < ε) :
    (∀ x, 0 < x → 0 < f ε x) ∧
      (∀ x, 0 < x → f ε (x + 1) = x * f ε x) ∧
      f ε 1 = 1 ∧
      ¬ Set.EqOn (f ε) Gamma (Ioi 0) ∧
      ¬ ConvexOn ℝ (Ioi 0) (log ∘ f ε) :=
  ⟨fun _ hx => f_pos hε.le hx, fun _ hx => f_functional_eq hx, f_one ε,
    f_ne_Gamma hε, not_logConvex hε⟩
-- ANCHOR_END: bmc-summary

end BohrMollerupConvexFlow

end MathNotesLean
