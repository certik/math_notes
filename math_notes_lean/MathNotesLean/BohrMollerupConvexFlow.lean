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


/-! ## Machine-checked convexity of the counterexample (`ε = 1/100`)

The remainder of this file discharges the one step the note proves by hand: that `fᵥ` is
**convex** on `(0, ∞)` for `ε = 1/100`. It builds the real digamma `ψ = (log Γ)'` and trigamma
`ψ' = (log Γ)''`, proves the trigamma lower bound `ψ'(x) ≥ 1/x`, and assembles convexity via the
`C²` criterion. -/

open Filter Topology

/-! ## Digamma / trigamma infrastructure -/
noncomputable def L (x : ℝ) : ℝ := Real.log (Real.Gamma x)
noncomputable def psi : ℝ → ℝ := deriv L
noncomputable def trig : ℝ → ℝ := deriv psi

theorem contDiffAt2_L {x : ℝ} (hx : 0 < x) : ContDiffAt ℝ 2 L x := by
  have hU : IsOpen {z : ℂ | 0 < z.re} := isOpen_lt continuous_const Complex.continuous_re
  have hmem : (x : ℂ) ∈ {z : ℂ | 0 < z.re} := by simpa using hx
  have hdiffOn : DifferentiableOn ℂ Complex.Gamma {z : ℂ | 0 < z.re} := by
    intro z hz
    refine (Complex.differentiableAt_Gamma z ?_).differentiableWithinAt
    intro m h
    have hre : (0:ℝ) < z.re := hz
    rw [h] at hre
    simp only [Complex.neg_re, Complex.natCast_re] at hre
    have : (0:ℝ) ≤ (m:ℝ) := Nat.cast_nonneg m
    linarith
  have hana : AnalyticAt ℂ Complex.Gamma (x : ℂ) := hdiffOn.analyticAt (hU.mem_nhds hmem)
  have hcd_R : ContDiffAt ℝ 2 Complex.Gamma (x : ℂ) := (hana.contDiffAt).restrict_scalars ℝ
  have hofReal : ContDiffAt ℝ 2 (fun t : ℝ => (t : ℂ)) x := Complex.ofRealCLM.contDiff.contDiffAt
  have hre : ContDiffAt ℝ 2 (fun z : ℂ => z.re) (Complex.Gamma (x:ℂ)) :=
    Complex.reCLM.contDiff.contDiffAt
  have hcomp : ContDiffAt ℝ 2 (fun t : ℝ => (Complex.Gamma (t:ℂ)).re) x :=
    hre.comp x (hcd_R.comp x hofReal)
  have heq : (fun t : ℝ => (Complex.Gamma (t:ℂ)).re) = Real.Gamma := by
    funext t; rw [Complex.Gamma_ofReal]; simp
  rw [heq] at hcomp
  have hlog : ContDiffAt ℝ 2 Real.log (Real.Gamma x) :=
    (Real.contDiffAt_log.2 (Real.Gamma_pos_of_pos hx).ne')
  exact hlog.comp x hcomp

theorem psi_diff {x : ℝ} (hx : 0 < x) : DifferentiableAt ℝ psi x := by
  have hCon : ContDiffOn ℝ 2 L (Ioi 0) := fun y hy => (contDiffAt2_L hy).contDiffWithinAt
  have hderiv : ContDiffOn ℝ 1 (deriv L) (Ioi 0) := hCon.deriv_of_isOpen isOpen_Ioi (by norm_num)
  have hdiffOn : DifferentiableOn ℝ (deriv L) (Ioi 0) := hderiv.differentiableOn (by norm_num)
  exact (hdiffOn x hx).differentiableAt (isOpen_Ioi.mem_nhds hx)

theorem L_diff {x : ℝ} (hx : 0 < x) : DifferentiableAt ℝ L x := by
  have hg : DifferentiableAt ℝ Real.Gamma x :=
    Real.differentiableAt_Gamma (s := x) (fun m h => by
      have hm : (0:ℝ) ≤ (m:ℝ) := Nat.cast_nonneg m
      rw [h] at hx; linarith)
  exact hg.log (Real.Gamma_pos_of_pos hx).ne'

theorem L_hasDeriv {x : ℝ} (hx : 0 < x) : HasDerivAt L (psi x) x := (L_diff hx).hasDerivAt
theorem psi_hasDeriv {x : ℝ} (hx : 0 < x) : HasDerivAt psi (trig x) x := (psi_diff hx).hasDerivAt

theorem psi_rec {x : ℝ} (hx : 0 < x) : psi (x + 1) = psi x + 1 / x := by
  have hx1 : (0:ℝ) < x + 1 := by linarith
  have hc : HasDerivAt (fun t : ℝ => t + 1) 1 x := (hasDerivAt_id x).add_const 1
  have h1 : HasDerivAt (fun t => L (t + 1)) (psi (x+1)) x := by
    simpa [Function.comp_def] using (L_hasDeriv hx1).comp x hc
  have h2 : HasDerivAt (fun t => L t + Real.log t) (psi x + x⁻¹) x :=
    (L_hasDeriv hx).add (Real.hasDerivAt_log hx.ne')
  have heq : (fun t => L (t + 1)) =ᶠ[nhds x] (fun t => L t + Real.log t) := by
    filter_upwards [isOpen_Ioi.mem_nhds hx] with t ht
    have ht0 : (0:ℝ) < t := ht
    simp only [L]
    rw [Real.Gamma_add_one ht0.ne', Real.log_mul ht0.ne' (Real.Gamma_pos_of_pos ht0).ne']; ring
  have hu := h1.unique (heq.hasDerivAt_iff.mpr h2)
  rw [one_div]; exact hu

theorem trig_rec {x : ℝ} (hx : 0 < x) : trig x = trig (x + 1) + 1 / x^2 := by
  have hx1 : (0:ℝ) < x + 1 := by linarith
  have hc : HasDerivAt (fun t : ℝ => t + 1) 1 x := (hasDerivAt_id x).add_const 1
  have h1 : HasDerivAt (fun t => psi (t + 1)) (trig (x+1)) x := by
    simpa [Function.comp_def] using (psi_hasDeriv hx1).comp x hc
  have h2 : HasDerivAt (fun t => psi t + t⁻¹) (trig x + (-(x^2)⁻¹)) x :=
    (psi_hasDeriv hx).add (hasDerivAt_inv hx.ne')
  have heq : (fun t => psi (t + 1)) =ᶠ[nhds x] (fun t => psi t + t⁻¹) := by
    filter_upwards [isOpen_Ioi.mem_nhds hx] with t ht
    have ht0 : (0:ℝ) < t := ht
    rw [psi_rec ht0, one_div]
  have hu := h1.unique (heq.hasDerivAt_iff.mpr h2)
  rw [one_div]; linarith [hu]

theorem accPt_Ioi {y : ℝ} (hy : 0 < y) : AccPt y (𝓟 (Ioi (0:ℝ))) := by
  rw [accPt_principal_iff_nhdsWithin]
  have hsub : Ioi y ⊆ Ioi (0:ℝ) \ {y} := by
    intro z hz
    rw [mem_Ioi] at hz
    rw [Set.mem_sdiff_singleton]
    exact ⟨lt_trans hy hz, hz.ne'⟩
  have hne : (𝓝[Ioi y] y).NeBot := inferInstance
  exact hne.mono (nhdsWithin_mono y hsub)

theorem psi_mono : MonotoneOn psi (Ioi (0:ℝ)) := by
  have hconv : ConvexOn ℝ (Ioi 0) (Real.log ∘ Real.Gamma) := Real.convexOn_log_Gamma
  have hLeq : (Real.log ∘ Real.Gamma) = L := rfl
  rw [hLeq] at hconv
  exact hconv.monotoneOn_deriv (fun x hx => L_diff hx)

theorem trig_nonneg {y : ℝ} (hy : 0 < y) : 0 ≤ trig y :=
  (psi_hasDeriv hy).hasDerivWithinAt.nonneg_of_monotoneOn (accPt_Ioi hy) psi_mono

theorem trig_telescope {x : ℝ} (hx : 0 < x) (n : ℕ) :
    trig x = (∑ k ∈ Finset.range n, 1 / (x + k)^2) + trig (x + n) := by
  induction n with
  | zero => simp
  | succ n ih =>
    have hxn : (0:ℝ) < x + n := by positivity
    rw [Finset.sum_range_succ, ih, trig_rec hxn]
    push_cast; ring

theorem sum_tele {x : ℝ} (n : ℕ) :
    (∑ k ∈ Finset.range n, (1/(x+(k:ℝ)) - 1/(x+(k:ℝ)+1))) = 1/x - 1/(x+n) := by
  induction n with
  | zero => simp
  | succ n ih => rw [Finset.sum_range_succ, ih]; push_cast; ring

-- ANCHOR: bmc-trigamma
/-- **Trigamma lower bound** `(log Γ)''(x) ≥ 1/x` for `x > 0`. This is the one analytic fact the
note proves by hand; here it is machine-checked. From the digamma recurrence `ψ(x+1) = ψ(x) + 1/x`
we differentiate to get the trigamma recurrence `ψ'(x) = ψ'(x+1) + 1/x²`; telescoping and using
`ψ' ≥ 0` (convexity of `log Γ`) gives `ψ'(x) ≥ ∑_{k<n} 1/(x+k)² ≥ 1/x − 1/(x+n)`, and `n → ∞`
yields `ψ'(x) ≥ 1/x`. -/
theorem trig_ge {x : ℝ} (hx : 0 < x) : 1 / x ≤ trig x := by
  have key : ∀ n : ℕ, 1 / x - 1 / (x + n) ≤ trig x := by
    intro n
    have hsum_le : (∑ k ∈ Finset.range n, 1 / (x + (k:ℝ))^2) ≤ trig x := by
      rw [trig_telescope hx n]
      have : (0:ℝ) < x + n := by positivity
      linarith [trig_nonneg this]
    have hlb : 1 / x - 1 / (x + n) ≤ (∑ k ∈ Finset.range n, 1 / (x + (k:ℝ))^2) := by
      calc 1 / x - 1 / (x + n)
          = ∑ k ∈ Finset.range n, (1/(x+(k:ℝ)) - 1/(x+(k:ℝ)+1)) := (sum_tele n).symm
        _ ≤ ∑ k ∈ Finset.range n, 1 / (x + (k:ℝ))^2 := by
            apply Finset.sum_le_sum
            intro k _
            have hxk : (0:ℝ) < x + k := by positivity
            have hxk1 : (0:ℝ) < x + k + 1 := by positivity
            have e : 1/(x+(k:ℝ)) - 1/(x+(k:ℝ)+1) = 1/((x+k)*(x+k+1)) := by
              rw [div_sub_div _ _ (ne_of_gt hxk) (ne_of_gt hxk1), one_mul, mul_one]
              congr 1; ring
            rw [e]
            apply one_div_le_one_div_of_le (by positivity)
            nlinarith [hxk]
    linarith
  have hlim : Tendsto (fun n : ℕ => 1 / x - 1 / (x + n)) atTop (𝓝 (1 / x)) := by
    have hd : Tendsto (fun n : ℕ => x + (n:ℝ)) atTop atTop :=
      tendsto_atTop_add_const_left atTop x tendsto_natCast_atTop_atTop
    have h0 : Tendsto (fun n : ℕ => 1 / (x + (n:ℝ))) atTop (𝓝 0) :=
      (hd.inv_tendsto_atTop).congr (fun n => (one_div _).symm)
    simpa using (tendsto_const_nhds.sub h0)
  exact le_of_tendsto' hlim key
-- ANCHOR_END: bmc-trigamma

/-! ## Perturbation calculus -/
noncomputable def gd (ε x : ℝ) : ℝ := ε * (2 * π) * Real.sin (2 * π * x)
noncomputable def gdd (ε x : ℝ) : ℝ := ε * (2 * π) ^ 2 * Real.cos (2 * π * x)
noncomputable def vd (ε x : ℝ) : ℝ := gd ε x / perturb ε x
noncomputable def vdd (ε x : ℝ) : ℝ := (gdd ε x * perturb ε x - gd ε x ^ 2) / (perturb ε x) ^ 2

theorem perturb_ge_one {ε : ℝ} (hε : 0 ≤ ε) (x : ℝ) : 1 ≤ perturb ε x := by
  have h1 : 0 ≤ 1 - Real.cos (2 * π * x) := by linarith [Real.cos_le_one (2 * π * x)]
  have h2 : 0 ≤ ε * (1 - Real.cos (2 * π * x)) := mul_nonneg hε h1
  unfold perturb; linarith


theorem hasDerivAt_cos2pi (x : ℝ) :
    HasDerivAt (fun x => Real.cos (2 * π * x)) (-(2 * π) * Real.sin (2 * π * x)) x := by
  have hlin : HasDerivAt (fun x : ℝ => 2 * π * x) (2 * π) x := by
    simpa using (hasDerivAt_id x).const_mul (2 * π)
  simpa [Function.comp_def, mul_comm] using (Real.hasDerivAt_cos (2 * π * x)).comp x hlin

theorem hasDerivAt_sin2pi (x : ℝ) :
    HasDerivAt (fun x => Real.sin (2 * π * x)) ((2 * π) * Real.cos (2 * π * x)) x := by
  have hlin : HasDerivAt (fun x : ℝ => 2 * π * x) (2 * π) x := by
    simpa using (hasDerivAt_id x).const_mul (2 * π)
  simpa [Function.comp_def, mul_comm] using (Real.hasDerivAt_sin (2 * π * x)).comp x hlin

theorem hasDerivAt_perturb (ε x : ℝ) : HasDerivAt (perturb ε) (gd ε x) x := by
  have h : HasDerivAt (perturb ε) (ε * (-(-(2 * π) * Real.sin (2 * π * x)))) x :=
    (((hasDerivAt_cos2pi x).const_sub (1 : ℝ)).const_mul ε).const_add (1 : ℝ)
  have he : ε * (-(-(2 * π) * Real.sin (2 * π * x))) = gd ε x := by unfold gd; ring
  rwa [he] at h

theorem hasDerivAt_gd (ε x : ℝ) : HasDerivAt (gd ε) (gdd ε x) x := by
  have h : HasDerivAt (gd ε) (ε * (2 * π) * ((2 * π) * Real.cos (2 * π * x))) x :=
    (hasDerivAt_sin2pi x).const_mul (ε * (2 * π))
  have he : ε * (2 * π) * ((2 * π) * Real.cos (2 * π * x)) = gdd ε x := by unfold gdd; ring
  rwa [he] at h

theorem hasDerivAt_v {ε : ℝ} (hε : 0 ≤ ε) (x : ℝ) :
    HasDerivAt (fun y => Real.log (perturb ε y)) (vd ε x) x :=
  (hasDerivAt_perturb ε x).log (perturb_pos hε x).ne'

theorem hasDerivAt_vd {ε : ℝ} (hε : 0 ≤ ε) (x : ℝ) : HasDerivAt (vd ε) (vdd ε x) x := by
  have h : HasDerivAt (vd ε) ((gdd ε x * perturb ε x - gd ε x * gd ε x) / (perturb ε x) ^ 2) x :=
    (hasDerivAt_gd ε x).div (hasDerivAt_perturb ε x) (perturb_pos hε x).ne'
  have he : (gdd ε x * perturb ε x - gd ε x * gd ε x) / (perturb ε x) ^ 2 = vdd ε x := by
    unfold vdd; ring
  rwa [he] at h

theorem vd_bound {ε : ℝ} (hε : 0 ≤ ε) (x : ℝ) : |vd ε x| ≤ 2 * π * ε := by
  have hgpos := perturb_pos hε x
  have hg1 := perturb_ge_one hε x
  have hnum : |gd ε x| ≤ 2 * π * ε := by
    have hs : |Real.sin (2 * π * x)| ≤ 1 := abs_le.mpr ⟨Real.neg_one_le_sin _, Real.sin_le_one _⟩
    have he : |gd ε x| = ε * (2 * π) * |Real.sin (2 * π * x)| := by
      unfold gd; rw [abs_mul, abs_mul, abs_of_nonneg hε, abs_of_pos (by positivity : (0:ℝ) < 2 * π)]
    rw [he]
    nlinarith [hs, mul_nonneg hε (le_of_lt (by positivity : (0:ℝ) < 2 * π)),
      abs_nonneg (Real.sin (2 * π * x)), Real.pi_pos]
  unfold vd
  rw [abs_div, abs_of_pos hgpos, div_le_iff₀ hgpos]
  nlinarith [hnum, hg1, mul_nonneg (mul_nonneg (by norm_num : (0:ℝ) ≤ 2) Real.pi_pos.le) hε]

theorem vdd_bound {ε : ℝ} (hε : 0 ≤ ε) (x : ℝ) : |vdd ε x| ≤ 4 * π ^ 2 * ε * (1 + ε) := by
  have hgpos := perturb_pos hε x
  have hg1 := perturb_ge_one hε x
  have hgdd : |gdd ε x| ≤ 4 * π ^ 2 * ε := by
    have hc : |Real.cos (2 * π * x)| ≤ 1 := abs_le.mpr ⟨Real.neg_one_le_cos _, Real.cos_le_one _⟩
    have he : |gdd ε x| = 4 * π ^ 2 * ε * |Real.cos (2 * π * x)| := by
      unfold gdd
      rw [abs_mul, abs_of_nonneg (mul_nonneg hε (by positivity : (0:ℝ) ≤ (2 * π) ^ 2))]
      ring_nf
    rw [he]
    nlinarith [hc, mul_nonneg (by positivity : (0:ℝ) ≤ 4 * π ^ 2 * ε)
      (by linarith [hc] : (0:ℝ) ≤ 1 - |Real.cos (2 * π * x)|)]
  have hgd2 : gd ε x ^ 2 ≤ 4 * π ^ 2 * ε ^ 2 := by
    have hs : Real.sin (2 * π * x) ^ 2 ≤ 1 := by
      nlinarith [Real.neg_one_le_sin (2 * π * x), Real.sin_le_one (2 * π * x)]
    have he : gd ε x ^ 2 = 4 * π ^ 2 * ε ^ 2 * Real.sin (2 * π * x) ^ 2 := by unfold gd; ring
    rw [he]
    nlinarith [mul_nonneg (by positivity : (0:ℝ) ≤ 4 * π ^ 2 * ε ^ 2)
      (by linarith [hs] : (0:ℝ) ≤ 1 - Real.sin (2 * π * x) ^ 2)]
  have key : |vdd ε x| ≤ |gdd ε x| + gd ε x ^ 2 := by
    unfold vdd
    rw [abs_div, abs_of_pos (by positivity : (0:ℝ) < (perturb ε x) ^ 2),
      div_le_iff₀ (by positivity : (0:ℝ) < (perturb ε x) ^ 2)]
    have hg2 : (1:ℝ) ≤ (perturb ε x) ^ 2 := by nlinarith [hg1]
    have hgle : perturb ε x ≤ (perturb ε x) ^ 2 := by nlinarith [hg1]
    have htri : |gdd ε x * perturb ε x - gd ε x ^ 2| ≤ |gdd ε x * perturb ε x| + |gd ε x ^ 2| := by
      rw [sub_eq_add_neg]
      exact (abs_add_le _ _).trans_eq (by rw [abs_neg])
    calc |gdd ε x * perturb ε x - gd ε x ^ 2|
        ≤ |gdd ε x * perturb ε x| + |gd ε x ^ 2| := htri
      _ = |gdd ε x| * perturb ε x + gd ε x ^ 2 := by
          rw [abs_mul, abs_of_pos hgpos]
          congr 1
          exact abs_of_nonneg (sq_nonneg (gd ε x))
      _ ≤ (|gdd ε x| + gd ε x ^ 2) * (perturb ε x) ^ 2 := by
          nlinarith [abs_nonneg (gdd ε x), sq_nonneg (gd ε x), hgle, hg2]
  calc |vdd ε x| ≤ |gdd ε x| + gd ε x ^ 2 := key
    _ ≤ 4 * π ^ 2 * ε + 4 * π ^ 2 * ε ^ 2 := by linarith [hgdd, hgd2]
    _ = 4 * π ^ 2 * ε * (1 + ε) := by ring

/-! ## Numerics for ε = 1/100 -/
theorem gamma_ub : Real.eulerMascheroniConstant < 29/50 := by
  have h := Real.eulerMascheroniConstant_lt_eulerMascheroniSeq' 256
  have he : Real.eulerMascheroniSeq' 256 = (harmonic 256 : ℝ) - 8 * Real.log 2 := by
    unfold Real.eulerMascheroniSeq'
    rw [if_neg (by norm_num : ¬((256:ℕ) = 0)),
      show ((256:ℕ):ℝ) = 2^8 by norm_num, Real.log_pow]
    push_cast; ring
  rw [he] at h
  have hl2 : (0.6931471803:ℝ) < Real.log 2 := Real.log_two_gt_d9
  have hH : (harmonic 256 : ℝ) < 6.125177 := by norm_num [harmonic, Finset.sum_range_succ]
  linarith [h, hl2, hH]

theorem C2_le_two_fifths : 4*π^2*(1/100)*(1+1/100) ≤ (2:ℝ)/5 := by
  have hπu : π < 3.141593 := Real.pi_lt_d6
  have hπl : (3.141592:ℝ) < π := Real.pi_gt_d6
  nlinarith [hπu, hπl, Real.pi_pos,
    mul_pos (show (0:ℝ) < 3.141593 - π by linarith)
      (show (0:ℝ) < 3.141593 + π by linarith [Real.pi_pos])]

theorem final_num (hγ : Real.eulerMascheroniConstant < 29 / 50) :
    0 ≤ 8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) - 2*π/100 ∧
    4*π^2*(1/100)*(1+1/100) ≤
      (8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) - 2*π/100)^2 := by
  set A := 8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) - 2*π/100 with hA
  have hl2u : Real.log 2 < 0.6931471808 := Real.log_two_lt_d9
  have hπu : π < 3.141593 := Real.pi_lt_d6
  have hπl : (3.141592:ℝ) < π := Real.pi_gt_d6
  have hA_lb : (127:ℝ)/200 ≤ A := by rw [hA]; nlinarith [hγ, hl2u, hπu]
  have hC2_ub : 4*π^2*(1/100)*(1+1/100) ≤ (399:ℝ)/1000 := by
    nlinarith [hπu, hπl, Real.pi_pos,
    mul_pos (show (0:ℝ) < 3.141593 - π by linarith)
      (show (0:ℝ) < 3.141593 + π by linarith [Real.pi_pos])]
  refine ⟨by linarith [hA_lb], ?_⟩
  calc 4*π^2*(1/100)*(1+1/100) ≤ (399:ℝ)/1000 := hC2_ub
    _ ≤ (127/200)^2 := by norm_num
    _ ≤ A^2 := by nlinarith [hA_lb]

/-! ## The candidate and its derivatives -/
noncomputable def u (ε x : ℝ) : ℝ := L x + Real.log (perturb ε x)
noncomputable def Fst (ε x : ℝ) : ℝ := f ε x * (psi x + vd ε x)
noncomputable def Snd (ε x : ℝ) : ℝ := f ε x * ((psi x + vd ε x)^2 + (trig x + vdd ε x))

theorem f_eq_exp_u {ε x : ℝ} (hx : 0 < x) (hε : 0 ≤ ε) : f ε x = Real.exp (u ε x) := by
  unfold f u L
  rw [Real.exp_add, Real.exp_log (Real.Gamma_pos_of_pos hx), Real.exp_log (perturb_pos hε x)]

theorem hasDerivAt_u {ε : ℝ} (hε : 0 ≤ ε) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (u ε) (psi x + vd ε x) x :=
  (L_hasDeriv hx).add (hasDerivAt_v hε x)

theorem hasDerivAt_f {ε : ℝ} (hε : 0 ≤ ε) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (f ε) (Fst ε x) x := by
  have hexp : HasDerivAt (fun y => Real.exp (u ε y)) (Real.exp (u ε x) * (psi x + vd ε x)) x :=
    (hasDerivAt_u hε hx).exp
  rw [← f_eq_exp_u hx hε] at hexp
  refine (hexp.congr_of_eventuallyEq ?_)
  filter_upwards [isOpen_Ioi.mem_nhds hx] with y hy
  exact f_eq_exp_u hy hε

theorem hasDerivAt_Fst {ε : ℝ} (hε : 0 ≤ ε) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (Fst ε) (Snd ε x) x := by
  have hA : HasDerivAt (fun y => Real.exp (u ε y)) (f ε x * (psi x + vd ε x)) x := by
    have h := (hasDerivAt_u hε hx).exp
    rwa [← f_eq_exp_u hx hε] at h
  have hB : HasDerivAt (fun y => psi y + vd ε y) (trig x + vdd ε x) x :=
    (psi_hasDeriv hx).add (hasDerivAt_vd hε x)
  have hAB := hA.mul hB
  have hval : (f ε x * (psi x + vd ε x)) * (psi x + vd ε x) + Real.exp (u ε x) * (trig x + vdd ε x)
      = Snd ε x := by
    rw [← f_eq_exp_u hx hε]; unfold Snd; ring
  rw [hval] at hAB
  refine (hAB.congr_of_eventuallyEq ?_)
  filter_upwards [isOpen_Ioi.mem_nhds hx] with y hy
  simp only [Pi.mul_apply]
  unfold Fst
  rw [f_eq_exp_u hy hε]

/-! ## psi at 1/2 and 5/2 -/
theorem psi_half : psi (1/2) = -(Real.eulerMascheroniConstant + 2 * Real.log 2) := by
  have hpos : (0:ℝ) < Real.Gamma (1/2) := Real.Gamma_pos_of_pos (by norm_num)
  have hd : HasDerivAt L
      ((-Real.sqrt π * (Real.eulerMascheroniConstant + 2 * Real.log 2)) / Real.Gamma (1/2)) (1/2) :=
    (Real.hasDerivAt_Gamma_one_half).log hpos.ne'
  have hval : psi (1/2) =
      (-Real.sqrt π * (Real.eulerMascheroniConstant + 2 * Real.log 2)) / Real.Gamma (1/2) :=
    hd.deriv
  rw [hval, Real.Gamma_one_half_eq]
  have h0 : Real.sqrt π ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr Real.pi_pos)
  field_simp

theorem psi_5half :
    psi (5/2) = 8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) := by
  have h1 := psi_rec (show (0:ℝ) < 1/2 by norm_num)
  have h2 := psi_rec (show (0:ℝ) < 3/2 by norm_num)
  rw [show (1/2 + 1 : ℝ) = 3/2 by norm_num] at h1
  rw [show (3/2 + 1 : ℝ) = 5/2 by norm_num] at h2
  rw [psi_half] at h1
  rw [h1] at h2
  rw [h2]; norm_num; ring

/-! ## The key sign inequality and convexity -/
theorem Q_nonneg {x : ℝ} (hx : 0 < x) :
    0 ≤ (psi x + vd (1/100) x)^2 + (trig x + vdd (1/100) x) := by
  have hε : (0:ℝ) ≤ 1/100 := by norm_num
  have hvd : |vd (1/100) x| ≤ 2 * π * (1/100) := vd_bound hε x
  have hvdd : |vdd (1/100) x| ≤ 4 * π ^ 2 * (1/100) * (1 + 1/100) := vdd_bound hε x
  have hvd' : -(2 * π * (1/100)) ≤ vd (1/100) x := (abs_le.mp hvd).1
  have hvdd' : -(4 * π ^ 2 * (1/100) * (1 + 1/100)) ≤ vdd (1/100) x := (abs_le.mp hvdd).1
  rcases le_total x (5/2) with hxle | hxge
  · -- Region A : 0 < x ≤ 5/2
    have htrig : 1/x ≤ trig x := trig_ge hx
    have hinv : (2:ℝ)/5 ≤ 1/x := by
      have h : 1/(5/2 : ℝ) ≤ 1/x := one_div_le_one_div_of_le hx hxle
      rwa [show (1/(5/2:ℝ)) = 2/5 by norm_num] at h
    have hC2 : 4 * π ^ 2 * (1/100) * (1 + 1/100) ≤ 2/5 := C2_le_two_fifths
    nlinarith [sq_nonneg (psi x + vd (1/100) x), htrig, hvdd', hinv, hC2]
  · -- Region B : 5/2 ≤ x
    have hmono : psi (5/2) ≤ psi x :=
      psi_mono (by norm_num : (5/2:ℝ) ∈ Ioi 0) (mem_Ioi.mpr hx) hxge
    have h5 : psi (5/2) = 8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) := psi_5half
    have hfin := final_num gamma_ub
    have hlb : 8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) - 2*π/100
        ≤ psi x + vd (1/100) x := by
      nlinarith [hmono, h5, hvd']
    have hsq : 4*π^2*(1/100)*(1+1/100) ≤ (psi x + vd (1/100) x)^2 := by
      calc 4*π^2*(1/100)*(1+1/100)
          ≤ (8/3 - (Real.eulerMascheroniConstant + 2 * Real.log 2) - 2*π/100)^2 := hfin.2
        _ ≤ (psi x + vd (1/100) x)^2 := by nlinarith [hlb, hfin.1]
    nlinarith [hsq, trig_nonneg hx, hvdd']

-- ANCHOR: bmc-convex
/-- **The counterexample is convex** for `ε = 1/100`. Writing `f = exp u` with `u = log Γ + log g`,
convexity is `u'' + (u')² ≥ 0`. On `(0, 5/2]` the trigamma bound gives `u'' ≥ 1/x − C₂ ≥ 0`
(Region A); on `[5/2, ∞)` the digamma value `ψ(5/2) = 8/3 − γ − 2 log 2` and monotonicity give
`(u')² ≥ C₂ ≥ −u''` (Region B). Here `C₁ = 2πε`, `C₂ = 4π²ε(1+ε)`. -/
theorem f_convex : ConvexOn ℝ (Ioi 0) (f (1/100)) := by
  have hε : (0:ℝ) ≤ 1/100 := by norm_num
  refine convexOn_of_hasDerivWithinAt2_nonneg (convex_Ioi 0) ?_
    (f' := Fst (1/100)) (f'' := Snd (1/100)) ?_ ?_ ?_
  · exact fun x hx => (hasDerivAt_f hε hx).continuousAt.continuousWithinAt
  · intro x hx
    rw [interior_Ioi] at hx
    exact (hasDerivAt_f hε hx).hasDerivWithinAt
  · intro x hx
    rw [interior_Ioi] at hx
    exact (hasDerivAt_Fst hε hx).hasDerivWithinAt
  · intro x hx
    rw [interior_Ioi] at hx
    unfold Snd
    exact mul_nonneg (f_pos hε hx).le (Q_nonneg hx)
-- ANCHOR_END: bmc-convex

-- ANCHOR: bmc-convex-summary
/-- **The counterexample satisfies every hypothesis of the (false) "convex Bohr–Mollerup"
theorem, yet is not `Γ`.** For `ε = 1/100`, `fᵥ` is positive on `(0, ∞)`, obeys the Gamma
functional equation `fᵥ(x+1) = x·fᵥ(x)`, is normalized `fᵥ 1 = 1`, is **convex** on `(0, ∞)`,
and is **not** log-convex — hence `fᵥ ≠ Γ`. So replacing "log-convex" by "convex" in
Bohr–Mollerup is false: convexity, normalization and the functional equation do **not** pin
down `Γ`. Every conjunct here is machine-checked (including the previously hand-proved
convexity). -/
theorem convexity_hypotheses_hold :
    (∀ x, 0 < x → 0 < f (1/100) x) ∧
      (∀ x, 0 < x → f (1/100) (x + 1) = x * f (1/100) x) ∧
      f (1/100) 1 = 1 ∧
      ConvexOn ℝ (Ioi 0) (f (1/100)) ∧
      ¬ Set.EqOn (f (1/100)) Gamma (Ioi 0) ∧
      ¬ ConvexOn ℝ (Ioi 0) (log ∘ f (1/100)) :=
  ⟨fun _ hx => f_pos (by norm_num) hx, fun _ hx => f_functional_eq hx, f_one _,
    f_convex, f_ne_Gamma (by norm_num), not_logConvex (by norm_num)⟩
-- ANCHOR_END: bmc-convex-summary


end BohrMollerupConvexFlow

end MathNotesLean
