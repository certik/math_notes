/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.Topology.Instances.RealVectorSpace

/-!
# Homomorphisms from `ℂˣ` to `ℂˣ`

This file starts the Lean formalization of `cstar_homomorphism.md`.
For now it covers only the additive Cauchy equation section.
-/

noncomputable section

namespace MathNotesLean

section CauchyAdditive

/-- An additive map `ℝ → ℝ` is homogeneous for rational scalars. -/
theorem cauchy_additive_rat_homogeneous (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (q : ℚ) (x : ℝ) :
    a ((q : ℝ) * x) = (q : ℝ) * a x := by
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  simpa [f, smul_eq_mul] using map_ratCast_smul f ℝ ℝ q x

/-- A measurable solution of Cauchy's additive equation on `ℝ` is linear. -/
theorem cauchy_additive_measurable_linear (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hmeas : Measurable a) :
    ∀ x : ℝ, a x = a 1 * x := by
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  have hf_meas : Measurable f := hmeas
  have hf_cont : Continuous f :=
    MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable f hf_meas
  intro x
  have hsmul : f (x • (1 : ℝ)) = x • f (1 : ℝ) := map_real_smul f hf_cont x 1
  simpa [f, smul_eq_mul, mul_comm, mul_left_comm, mul_assoc] using hsmul

/-- Existence form of the measurable additive Cauchy equation. -/
theorem cauchy_additive_measurable_exists (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hmeas : Measurable a) :
    ∃ c : ℝ, ∀ x : ℝ, a x = c * x :=
  ⟨a 1, cauchy_additive_measurable_linear a hadd hmeas⟩

end CauchyAdditive

section CauchyMultiplicativeReal

/-- If a multiplicative real function sends `1` to `0`, then it is identically zero. -/
theorem cauchy_multiplicative_zero_of_map_one_eq_zero (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 0) :
    ∀ x : ℝ, m x = 0 := by
  intro x
  have h := hm x 1
  simpa [h1] using h

/-- If a multiplicative real function sends `0` to `1`, then it is identically one. -/
theorem cauchy_multiplicative_one_of_map_zero_eq_one (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h0 : m 0 = 1) :
    ∀ x : ℝ, m x = 1 := by
  intro x
  have h := hm 0 x
  simpa [h0] using h.symm

/-- A multiplicative real function with `m 1 = 1` is nonzero away from zero. -/
theorem cauchy_multiplicative_ne_zero_on_nonzero (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) {x : ℝ}
    (hx : x ≠ 0) :
    m x ≠ 0 := by
  have h := hm x x⁻¹
  have hprod : m x * m x⁻¹ = 1 := by
    simpa [mul_inv_cancel₀ hx, h1] using h.symm
  intro hmx
  simp [hmx] at hprod

/-- For a multiplicative real function with `m 1 = 1`, the value at `-1` squares to one. -/
theorem cauchy_multiplicative_neg_one_sq (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) :
    m (-1) ^ 2 = 1 := by
  have h := hm (-1) (-1)
  simpa [h1, sq] using h.symm

/-- For a multiplicative real function with `m 1 = 1`, the value at `-1` is `±1`. -/
theorem cauchy_multiplicative_neg_one_cases (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) :
    m (-1) = 1 ∨ m (-1) = -1 :=
  sq_eq_one_iff.mp (cauchy_multiplicative_neg_one_sq m hm h1)

/-- On positive inputs, a multiplicative real function with `m 1 = 1` is positive. -/
theorem cauchy_multiplicative_pos_of_pos (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) {x : ℝ}
    (hx : 0 < x) :
    0 < m x := by
  have hne : m x ≠ 0 := cauchy_multiplicative_ne_zero_on_nonzero m hm h1 (ne_of_gt hx)
  have hsquare : Real.sqrt x * Real.sqrt x = x := by
    rw [← sq]
    exact Real.sq_sqrt (le_of_lt hx)
  have hmap : m x = m (Real.sqrt x) * m (Real.sqrt x) := by
    simpa [hsquare] using hm (Real.sqrt x) (Real.sqrt x)
  have hnonneg : 0 ≤ m x := by
    rw [hmap]
    exact mul_self_nonneg _
  exact lt_of_le_of_ne' hnonneg hne

/-- Taking logs after precomposing by `exp` turns the positive multiplicative part additive. -/
theorem cauchy_multiplicative_log_exp_additive (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) :
    ∀ t u : ℝ,
      Real.log (m (Real.exp (t + u))) =
        Real.log (m (Real.exp t)) + Real.log (m (Real.exp u)) := by
  intro t u
  have ht : 0 < m (Real.exp t) := cauchy_multiplicative_pos_of_pos m hm h1 (Real.exp_pos t)
  have hu : 0 < m (Real.exp u) := cauchy_multiplicative_pos_of_pos m hm h1 (Real.exp_pos u)
  calc
    Real.log (m (Real.exp (t + u))) = Real.log (m (Real.exp t * Real.exp u)) := by
      rw [Real.exp_add]
    _ = Real.log (m (Real.exp t) * m (Real.exp u)) := by
      rw [hm]
    _ = Real.log (m (Real.exp t)) + Real.log (m (Real.exp u)) := by
      exact Real.log_mul ht.ne' hu.ne'

/-- On positive inputs, a measurable multiplicative real function is a power function. -/
theorem cauchy_multiplicative_eq_rpow_on_pos (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) (hmeas : Measurable m) :
    ∃ c : ℝ, ∀ {x : ℝ}, 0 < x → m x = x ^ c := by
  let b : ℝ → ℝ := fun t => Real.log (m (Real.exp t))
  have hb_add : ∀ t u : ℝ, b (t + u) = b t + b u :=
    cauchy_multiplicative_log_exp_additive m hm h1
  have hb_meas : Measurable b :=
    Real.measurable_log.comp (hmeas.comp Real.continuous_exp.measurable)
  refine ⟨b 1, ?_⟩
  intro x hx
  have hlin := cauchy_additive_measurable_linear b hb_add hb_meas (Real.log x)
  have hpos_mx : 0 < m x := cauchy_multiplicative_pos_of_pos m hm h1 hx
  have hexp := congrArg Real.exp hlin
  change Real.exp (Real.log (m (Real.exp (Real.log x)))) =
      Real.exp (b 1 * Real.log x) at hexp
  have hlogx : Real.exp (Real.log x) = x := Real.exp_log hx
  rw [hlogx] at hexp
  rw [Real.exp_log hpos_mx] at hexp
  simpa [Real.rpow_def_of_pos hx, mul_comm] using hexp

/--
The nondegenerate measurable real multiplicative Cauchy equation on `ℝˣ`: away from zero the
solution is a power of `|x|`, with the independent sign `m (-1) = ±1`.
-/
theorem cauchy_multiplicative_eq_sign_rpow_on_nonzero (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) (hmeas : Measurable m) :
    ∃ c : ℝ,
      (m (-1) = 1 ∨ m (-1) = -1) ∧
        ∀ {x : ℝ}, x ≠ 0 → m x = (if x < 0 then m (-1) else 1) * |x| ^ c := by
  obtain ⟨c, hc⟩ := cauchy_multiplicative_eq_rpow_on_pos m hm h1 hmeas
  refine ⟨c, cauchy_multiplicative_neg_one_cases m hm h1, ?_⟩
  intro x hx
  by_cases hneg : x < 0
  · have habs_pos : 0 < |x| := abs_pos.mpr hx
    have hx_eq : x = (-1) * |x| := by
      rw [abs_of_neg hneg]
      ring
    calc
      m x = m ((-1) * |x|) := congrArg m hx_eq
      _ = m (-1) * m |x| := hm (-1) |x|
      _ = m (-1) * |x| ^ c := by rw [hc habs_pos]
      _ = (if x < 0 then m (-1) else 1) * |x| ^ c := by simp [hneg]
  · have hx_pos : 0 < x := lt_of_le_of_ne' (not_lt.mp hneg) hx
    have habs : |x| = x := abs_of_nonneg (not_lt.mp hneg)
    calc
      m x = x ^ c := hc hx_pos
      _ = (if x < 0 then m (-1) else 1) * |x| ^ c := by simp [hneg, habs]

/-- A real number satisfying `a = a * a` is `0` or `1`. -/
theorem eq_zero_or_eq_one_of_eq_mul_self {a : ℝ} (h : a = a * a) : a = 0 ∨ a = 1 := by
  have hfac : a * (a - 1) = 0 := by nlinarith
  rcases mul_eq_zero.mp hfac with h0 | h1
  · exact Or.inl h0
  · exact Or.inr (sub_eq_zero.mp h1)

/--
The measurable real multiplicative Cauchy equation consists of two degenerate cases, `0` and `1`,
and the nondegenerate formula on `ℝˣ`.
-/
theorem cauchy_multiplicative_measurable_classification (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (hmeas : Measurable m) :
    (∀ x : ℝ, m x = 0) ∨ (∀ x : ℝ, m x = 1) ∨
      ∃ c : ℝ,
        (m (-1) = 1 ∨ m (-1) = -1) ∧
          ∀ {x : ℝ}, x ≠ 0 → m x = (if x < 0 then m (-1) else 1) * |x| ^ c := by
  have h1sq : m 1 = m 1 * m 1 := by simpa using hm 1 1
  rcases eq_zero_or_eq_one_of_eq_mul_self h1sq with h1 | h1
  · exact Or.inl (cauchy_multiplicative_zero_of_map_one_eq_zero m hm h1)
  · right
    have h0sq : m 0 = m 0 * m 0 := by simpa using hm 0 0
    rcases eq_zero_or_eq_one_of_eq_mul_self h0sq with h0 | h0
    · exact Or.inr (cauchy_multiplicative_eq_sign_rpow_on_nonzero m hm h1 hmeas)
    · exact Or.inl (cauchy_multiplicative_one_of_map_zero_eq_one m hm h0)

end CauchyMultiplicativeReal

section CStarHomomorphism

/-- The positive real radial factor of a nonzero complex number, as a unit of `ℂ`. -/
def cstarNormUnit (w : ℂˣ) : ℂˣ :=
  Units.mk0 ((‖(w : ℂ)‖ : ℝ) : ℂ) (by
    exact_mod_cast (norm_ne_zero_iff.mpr w.ne_zero))

/-- The unit-circle factor `w / |w|` of a nonzero complex number, as a unit of `ℂ`. -/
def cstarCircleUnit (w : ℂˣ) : ℂˣ :=
  w / cstarNormUnit w

/-- The radial and unit-circle factors multiply back to the original element. -/
theorem cstar_norm_mul_circle (w : ℂˣ) :
    (cstarNormUnit w : ℂ) * (cstarCircleUnit w : ℂ) = (w : ℂ) := by
  unfold cstarCircleUnit cstarNormUnit
  simp [div_eq_mul_inv, mul_left_comm]

/-- The second polar factor `w / |w|` has complex norm one. -/
theorem norm_cstarCircleUnit (w : ℂˣ) : ‖(cstarCircleUnit w : ℂ)‖ = 1 := by
  have hden : ‖(w : ℂ)‖ ^ 2 ≠ 0 := pow_ne_zero 2 (norm_ne_zero_iff.mpr w.ne_zero)
  have hsq : ‖(cstarCircleUnit w : ℂ)‖ ^ 2 = (1 : ℝ) ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq]
    unfold cstarCircleUnit cstarNormUnit
    simp [div_eq_mul_inv, Complex.normSq_eq_norm_sq]
  exact (sq_eq_sq_iff_eq_or_eq_neg.mp hsq).resolve_right (by
    intro hneg
    have hnonneg : 0 ≤ ‖(cstarCircleUnit w : ℂ)‖ := norm_nonneg _
    linarith)

/--
Every homomorphism `ℂˣ → ℂˣ` factors across the radial and unit-circle polar factors of its
argument.
-/
theorem cstar_homomorphism_polar_factorization (g : ℂˣ →* ℂˣ) (w : ℂˣ) :
    g w = g (cstarNormUnit w) * g (cstarCircleUnit w) := by
  have hw : w = cstarNormUnit w * cstarCircleUnit w := by
    ext
    exact (cstar_norm_mul_circle w).symm
  exact (congrArg g hw).trans (map_mul g (cstarNormUnit w) (cstarCircleUnit w))

/-- The positive real path `t ↦ exp t` into `ℂˣ`. -/
def cstarPositivePath (t : ℝ) : ℂˣ :=
  Units.mk0 ((Real.exp t : ℝ) : ℂ) (by
    exact_mod_cast (Real.exp_ne_zero t))

/-- The positive real path turns addition into multiplication. -/
theorem cstarPositivePath_add (t u : ℝ) :
    cstarPositivePath (t + u) = cstarPositivePath t * cstarPositivePath u := by
  ext
  simp [cstarPositivePath, Real.exp_add]

/-- Composing a `ℂˣ` homomorphism with `t ↦ exp t` gives an additive-parameter homomorphism. -/
theorem cstar_positive_factor_additive_parameter (g : ℂˣ →* ℂˣ) (t u : ℝ) :
    g (cstarPositivePath (t + u)) = g (cstarPositivePath t) * g (cstarPositivePath u) := by
  rw [cstarPositivePath_add, map_mul]

end CStarHomomorphism

end MathNotesLean
