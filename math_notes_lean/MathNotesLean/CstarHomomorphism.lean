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
It covers the additive Cauchy equation, the real multiplicative Cauchy equation, and structural
polar-factor lemmas for homomorphisms `ℂˣ → ℂˣ`.

The full topological classification of continuous circle characters is not currently packaged here;
the theorem `cstar_homomorphism_formula_of_radial_and_circle` isolates exactly that remaining
ingredient by taking the radial and circle classifications as hypotheses and proving the final
displayed formula from them.
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

/-- A continuous additive map `ℝ → ℂ` is complex-linear in one real variable. -/
theorem cauchy_additive_continuous_complex_linear (a : ℝ → ℂ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hcont : Continuous a) :
    ∀ x : ℝ, a x = (x : ℂ) * a 1 := by
  let f : ℝ →+ ℂ := AddMonoidHom.mk' a hadd
  intro x
  have hsmul : f (x • (1 : ℝ)) = x • f (1 : ℝ) := map_real_smul f hcont x 1
  simpa [f, smul_eq_mul, mul_comm, mul_left_comm, mul_assoc] using hsmul

/-- A real number is rational if it lies in the image of `ℚ → ℝ`. -/
def IsRatReal (x : ℝ) : Prop :=
  ∃ q : ℚ, (q : ℝ) = x

/--
The function that agrees with `x ↦ c x` on rationals and is zero on irrationals.
It is used in the note to show that having the right rational values is not enough.
-/
noncomputable def rationalAgreementExample (c : ℝ) (x : ℝ) : ℝ := by
  classical
  exact if IsRatReal x then c * x else 0

theorem isRatReal_rat (q : ℚ) : IsRatReal (q : ℝ) :=
  ⟨q, rfl⟩

theorem not_isRatReal_add_rat {α : ℝ} (hα : ¬ IsRatReal α) {q : ℚ} :
    ¬ IsRatReal (α + q) := by
  intro h
  rcases h with ⟨r, hr⟩
  apply hα
  refine ⟨r - q, ?_⟩
  norm_num at hr ⊢
  linarith

theorem rationalAgreementExample_rat (c : ℝ) (q : ℚ) :
    rationalAgreementExample c (q : ℝ) = c * q := by
  classical
  simp [rationalAgreementExample, isRatReal_rat]

theorem rationalAgreementExample_irrational (c : ℝ) {α : ℝ} (hα : ¬ IsRatReal α) :
    rationalAgreementExample c α = 0 := by
  classical
  simp [rationalAgreementExample, hα]

theorem measurableSet_isRatReal : MeasurableSet {x : ℝ | IsRatReal x} := by
  have hset : {x : ℝ | IsRatReal x} = Set.range fun q : ℚ => (q : ℝ) := by
    ext x
    constructor
    · intro hx
      rcases hx with ⟨q, hq⟩
      exact ⟨q, hq⟩
    · intro hx
      rcases hx with ⟨q, hq⟩
      exact ⟨q, hq⟩
  rw [hset]
  exact (Set.countable_range fun q : ℚ => (q : ℝ)).measurableSet

theorem measurable_rationalAgreementExample (c : ℝ) : Measurable (rationalAgreementExample c) := by
  classical
  unfold rationalAgreementExample
  exact Measurable.ite measurableSet_isRatReal (measurable_const.mul measurable_id) measurable_const

/--
If `c ≠ 0`, the rational-agreement example is not additive: adding a nonzero rational to an
irrational gives an explicit failure of Cauchy's equation.
-/
theorem rationalAgreementExample_not_additive {c α : ℝ} {q : ℚ}
    (hc : c ≠ 0) (hq : q ≠ 0) (hα : ¬ IsRatReal α) :
    rationalAgreementExample c (α + q) ≠
      rationalAgreementExample c α + rationalAgreementExample c (q : ℝ) := by
  have hαq : ¬ IsRatReal (α + q) := not_isRatReal_add_rat hα
  rw [rationalAgreementExample_irrational c hαq, rationalAgreementExample_irrational c hα,
    rationalAgreementExample_rat]
  simp only [zero_add]
  exact (mul_ne_zero hc (Rat.cast_ne_zero.mpr hq)).symm

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

/--
The same classification, with the nondegenerate branch explicitly recording the extension value
`m 0 = 0`.
-/
theorem cauchy_multiplicative_measurable_classification_with_zero (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (hmeas : Measurable m) :
    (∀ x : ℝ, m x = 0) ∨ (∀ x : ℝ, m x = 1) ∨
      ∃ c : ℝ,
        m 0 = 0 ∧ (m (-1) = 1 ∨ m (-1) = -1) ∧
          ∀ {x : ℝ}, x ≠ 0 → m x = (if x < 0 then m (-1) else 1) * |x| ^ c := by
  have h1sq : m 1 = m 1 * m 1 := by simpa using hm 1 1
  rcases eq_zero_or_eq_one_of_eq_mul_self h1sq with h1 | h1
  · exact Or.inl (cauchy_multiplicative_zero_of_map_one_eq_zero m hm h1)
  · right
    have h0sq : m 0 = m 0 * m 0 := by simpa using hm 0 0
    rcases eq_zero_or_eq_one_of_eq_mul_self h0sq with h0 | h0
    · exact Or.inr (by
        obtain ⟨c, hsign, hformula⟩ := cauchy_multiplicative_eq_sign_rpow_on_nonzero m hm h1 hmeas
        exact ⟨c, h0, hsign, hformula⟩)
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

/--
If a continuous additive-parameter homomorphism `ℝ → ℂˣ` has a continuous additive logarithmic
lift, then it has the form `t ↦ exp (s t)`.
-/
theorem real_to_cstar_exp_linear_of_lift (G : ℝ →+ Additive ℂˣ) (ell : ℝ → ℂ)
    (hell_add : ∀ x y, ell (x + y) = ell x + ell y) (hell_cont : Continuous ell)
    (hG : ∀ t,
      (Additive.toMul (G t) : ℂˣ) = Units.mk0 (Complex.exp (ell t)) (Complex.exp_ne_zero _)) :
    ∃ s : ℂ, ∀ t : ℝ,
      (Additive.toMul (G t) : ℂˣ) =
        Units.mk0 (Complex.exp (s * (t : ℂ))) (Complex.exp_ne_zero _) := by
  refine ⟨ell 1, ?_⟩
  intro t
  rw [hG]
  congr 1
  rw [cauchy_additive_continuous_complex_linear ell hell_add hell_cont t]
  ring_nf

/-- The factor `|w|^s` from the `ℂˣ` homomorphism classification, as a unit of `ℂ`. -/
def cstarNormCPow (s : ℂ) (w : ℂˣ) : ℂˣ :=
  Units.mk0 (Complex.exp (s * Real.log ‖(w : ℂ)‖)) (Complex.exp_ne_zero _)

/-- The radial unit `|w|` is the positive path evaluated at `log |w|`. -/
theorem cstarNormUnit_eq_positivePath_log_norm (w : ℂˣ) :
    cstarNormUnit w = cstarPositivePath (Real.log ‖(w : ℂ)‖) := by
  ext
  simp [cstarNormUnit, cstarPositivePath, Real.exp_log (norm_pos_iff.mpr w.ne_zero)]

@[simp]
theorem coe_cstarNormCPow (s : ℂ) (w : ℂˣ) :
    ((cstarNormCPow s w : ℂˣ) : ℂ) = Complex.exp (s * Real.log ‖(w : ℂ)‖) :=
  rfl

@[simp]
theorem cstarNormUnit_one : cstarNormUnit (1 : ℂˣ) = 1 := by
  ext
  simp [cstarNormUnit]

@[simp]
theorem cstarCircleUnit_one : cstarCircleUnit (1 : ℂˣ) = 1 := by
  ext
  simp [cstarCircleUnit, cstarNormUnit]

theorem cstarNormUnit_mul (w z : ℂˣ) :
    cstarNormUnit (w * z) = cstarNormUnit w * cstarNormUnit z := by
  ext
  simp [cstarNormUnit]

theorem cstarCircleUnit_mul (w z : ℂˣ) :
    cstarCircleUnit (w * z) = cstarCircleUnit w * cstarCircleUnit z := by
  ext
  simp [cstarCircleUnit, cstarNormUnit, div_eq_mul_inv]
  ring

@[simp]
theorem cstarNormCPow_one (s : ℂ) : cstarNormCPow s (1 : ℂˣ) = 1 := by
  ext
  simp [cstarNormCPow]

theorem cstarNormCPow_mul (s : ℂ) (w z : ℂˣ) :
    cstarNormCPow s (w * z) = cstarNormCPow s w * cstarNormCPow s z := by
  ext
  simp [cstarNormCPow,
    Real.log_mul (norm_ne_zero_iff.mpr w.ne_zero) (norm_ne_zero_iff.mpr z.ne_zero), mul_add,
    Complex.exp_add]

/--
Every expression `w ↦ |w|^s (w/|w|)^k` defines a multiplicative homomorphism
`ℂˣ → ℂˣ`.
-/
def cstarFormulaHom (s : ℂ) (k : ℤ) : ℂˣ →* ℂˣ where
  toFun w := cstarNormCPow s w * cstarCircleUnit w ^ k
  map_one' := by simp
  map_mul' w z := by
    rw [cstarNormCPow_mul, cstarCircleUnit_mul, mul_zpow]
    ac_rfl

/-- The identity homomorphism corresponds to the parameters `s = 1` and `k = 1`. -/
theorem cstarFormulaHom_one_one : cstarFormulaHom 1 1 = MonoidHom.id ℂˣ := by
  ext w
  change Complex.exp ((1 : ℂ) * ↑(Real.log ‖(w : ℂ)‖)) *
      ↑(cstarCircleUnit w ^ (1 : ℤ)) = (w : ℂ)
  rw [zpow_one]
  change Complex.exp ((1 : ℂ) * ↑(Real.log ‖(w : ℂ)‖)) *
      ((w : ℂ) * ((↑‖(w : ℂ)‖ : ℂ)⁻¹)) = (w : ℂ)
  rw [one_mul]
  rw [← Complex.ofReal_exp, Real.exp_log (norm_pos_iff.mpr w.ne_zero)]
  have hn : ((‖(w : ℂ)‖ : ℝ) : ℂ) ≠ 0 := by
    exact_mod_cast (norm_ne_zero_iff.mpr w.ne_zero)
  field_simp [hn]

theorem continuousAt_log_norm_complex {z : ℂ} (hz : z ≠ 0) :
    ContinuousAt (fun z : ℂ => Real.log ‖z‖) z := by
  change ContinuousAt ((fun r : ℝ => Real.log r) ∘ (fun z : ℂ => ‖z‖)) z
  exact (Real.continuousAt_log (norm_ne_zero_iff.mpr hz)).comp continuous_norm.continuousAt

theorem continuous_log_norm_units : Continuous fun w : ℂˣ => Real.log ‖(w : ℂ)‖ := by
  rw [continuous_iff_continuousAt]
  intro w
  exact (continuousAt_log_norm_complex w.ne_zero).comp Units.continuous_val.continuousAt

theorem continuous_cstarNormCPow_val (s : ℂ) :
    Continuous fun w : ℂˣ => (cstarNormCPow s w : ℂ) := by
  unfold cstarNormCPow
  apply Complex.continuous_exp.comp
  apply Continuous.mul continuous_const
  exact Complex.continuous_ofReal.comp continuous_log_norm_units

theorem continuous_cstarNormCPow (s : ℂ) : Continuous fun w : ℂˣ => cstarNormCPow s w := by
  rw [Units.continuous_iff]
  refine ⟨continuous_cstarNormCPow_val s, ?_⟩
  simpa [Units.inv_eq_val_inv] using
    (continuous_cstarNormCPow_val s).inv₀ fun _ => Complex.exp_ne_zero _

theorem continuous_cstarCircleUnit_val : Continuous fun w : ℂˣ => (cstarCircleUnit w : ℂ) := by
  unfold cstarCircleUnit cstarNormUnit
  change Continuous fun w : ℂˣ => (w : ℂ) / (((‖(w : ℂ)‖ : ℝ) : ℂ))
  apply Continuous.div Units.continuous_val
  · exact Complex.continuous_ofReal.comp (continuous_norm.comp Units.continuous_val)
  · intro w
    exact_mod_cast (norm_ne_zero_iff.mpr w.ne_zero)

theorem continuous_cstarCircleUnit : Continuous fun w : ℂˣ => cstarCircleUnit w := by
  rw [Units.continuous_iff]
  refine ⟨continuous_cstarCircleUnit_val, ?_⟩
  simpa [Units.inv_eq_val_inv] using
    continuous_cstarCircleUnit_val.inv₀ fun w => (cstarCircleUnit w).ne_zero

/-- The displayed formula is a continuous homomorphism `ℂˣ → ℂˣ`. -/
theorem continuous_cstarFormulaHom (s : ℂ) (k : ℤ) :
    Continuous fun w : ℂˣ => cstarFormulaHom s k w := by
  change Continuous fun w : ℂˣ => cstarNormCPow s w * cstarCircleUnit w ^ k
  exact (continuous_cstarNormCPow s).mul (continuous_cstarCircleUnit.zpow k)

/-- The displayed formula, bundled as a continuous monoid homomorphism. -/
def cstarFormulaContinuousHom (s : ℂ) (k : ℤ) : ContinuousMonoidHom ℂˣ ℂˣ where
  toMonoidHom := cstarFormulaHom s k
  continuous_toFun := continuous_cstarFormulaHom s k

/-- Power characters of the unit circle. -/
def circlePowerHom (k : ℤ) : Circle →* Circle where
  toFun z := z ^ k
  map_one' := by simp
  map_mul' z w := by rw [mul_zpow]

/-- Power characters of the unit circle, bundled as continuous homomorphisms. -/
def circlePowerContinuousHom (k : ℤ) : ContinuousMonoidHom Circle Circle where
  toMonoidHom := circlePowerHom k
  continuous_toFun := continuous_zpow k

/-- Convert a circle-valued power character to a `ℂˣ`-valued character. -/
def circlePowerUnitsHom (k : ℤ) : Circle →* ℂˣ :=
  Circle.toUnits.comp (circlePowerHom k)

@[simp]
theorem coe_circlePowerUnitsHom_apply (k : ℤ) (z : Circle) :
    ((circlePowerUnitsHom k z : ℂˣ) : ℂ) = (z : ℂ) ^ k := by
  simp [circlePowerUnitsHom, circlePowerHom]

/-- A continuous homomorphism from a compact additive group to `ℝ` is trivial. -/
theorem compact_additive_hom_to_real_eq_zero {G : Type*} [AddGroup G] [TopologicalSpace G]
    [CompactSpace G] (f : G →+ ℝ) (hf : Continuous f) : ∀ x, f x = 0 := by
  have hb : Bornology.IsBounded (Set.range f) := (isCompact_range hf).isBounded
  rcases Metric.isBounded_iff.mp hb with ⟨C, hC⟩
  intro x
  by_contra hx
  have hpos : 0 < |f x| := abs_pos.mpr hx
  obtain ⟨n, hn⟩ := exists_nat_gt (C / |f x|)
  have hdist := hC (x := f (n • x)) ⟨n • x, rfl⟩ (y := f 0) ⟨0, rfl⟩
  rw [map_nsmul, map_zero, dist_zero_right] at hdist
  have hn' : C < n * |f x| := by
    have := mul_lt_mul_of_pos_right hn hpos
    rwa [div_mul_cancel₀ _ hpos.ne'] at this
  have : (n : ℝ) * |f x| ≤ C := by
    simpa [Real.norm_eq_abs, abs_mul, Nat.abs_cast, nsmul_eq_mul] using hdist
  linarith

/-- The log of the modulus of a continuous circle homomorphism is zero. -/
theorem circle_hom_log_norm_eq_zero (g : Circle →* ℂˣ) (hg : Continuous g) :
    ∀ z : Circle, Real.log ‖(g z : ℂ)‖ = 0 := by
  let f : Additive Circle →+ ℝ := {
    toFun := fun z => Real.log ‖(g (Additive.toMul z) : ℂ)‖
    map_zero' := by simp
    map_add' := by
      intro z w
      change Real.log ‖(g (Additive.toMul (z + w)) : ℂ)‖ =
        Real.log ‖(g (Additive.toMul z) : ℂ)‖ + Real.log ‖(g (Additive.toMul w) : ℂ)‖
      rw [toMul_add, map_mul]
      rw [Units.val_mul, norm_mul]
      exact Real.log_mul (norm_ne_zero_iff.mpr (g (Additive.toMul z)).ne_zero)
        (norm_ne_zero_iff.mpr (g (Additive.toMul w)).ne_zero) }
  have hf : Continuous f := by
    dsimp [f]
    have hbase : Continuous fun z : Circle => Real.log ‖(g z : ℂ)‖ :=
      continuous_log_norm_units.comp hg
    exact hbase.comp continuous_toMul
  intro z
  exact compact_additive_hom_to_real_eq_zero f hf (Additive.ofMul z)

/-- A continuous homomorphism from the unit circle to `ℂˣ` has image in the unit circle. -/
theorem circle_hom_norm_eq_one (g : Circle →* ℂˣ) (hg : Continuous g) (z : Circle) :
    ‖(g z : ℂ)‖ = 1 := by
  have hlog := circle_hom_log_norm_eq_zero g hg z
  have hpos : 0 < ‖(g z : ℂ)‖ := norm_pos_iff.mpr (g z).ne_zero
  have hexp := congrArg Real.exp hlog
  rwa [Real.exp_log hpos, Real.exp_zero] at hexp

/-- A continuous homomorphism from the unit circle to `ℂˣ`, re-codomain-restricted to `Circle`. -/
def circleHomToCircle (g : Circle →* ℂˣ) (hg : Continuous g) : Circle →* Circle where
  toFun z := ⟨(g z : ℂ), by
    change (g z : ℂ) ∈ Metric.sphere 0 1
    rw [mem_sphere_zero_iff_norm]
    exact circle_hom_norm_eq_one g hg z⟩
  map_one' := by ext; simp
  map_mul' z w := by ext; simp [map_mul]

@[simp]
theorem circleHomToCircle_toUnits (g : Circle →* ℂˣ) (hg : Continuous g) (z : Circle) :
    Circle.toUnits (circleHomToCircle g hg z) = g z := by
  ext
  rfl

theorem continuous_circleHomToCircle (g : Circle →* ℂˣ) (hg : Continuous g) :
    Continuous (circleHomToCircle g hg) :=
  Continuous.subtype_mk (Units.continuous_val.comp hg) _

theorem continuous_circle_toUnits : Continuous Circle.toUnits := by
  rw [Units.continuous_iff]
  refine ⟨?_, ?_⟩
  · change Continuous fun z : Circle => (z : ℂ)
    exact continuous_subtype_val
  · change Continuous fun z : Circle => ((z : ℂ))⁻¹
    exact continuous_subtype_val.inv₀ fun z => Circle.coe_ne_zero z

/--
If a circle endomorphism has the exponential-coordinate formula `exp t ↦ exp (k t)`, then it is
the power character `z ↦ z^k`.
-/
theorem circle_endomorphism_eq_zpow_of_exp_lift (h : Circle →* Circle) (k : ℤ)
    (h_exp : ∀ t : ℝ, h (Circle.exp t) = Circle.exp ((k : ℝ) * t)) :
    ∀ z : Circle, h z = z ^ k := by
  intro z
  rcases Circle.exp_surjective z with ⟨t, rfl⟩
  rw [h_exp]
  exact Circle.exp_intCast_mul t k

/--
The same statement for a continuous homomorphism `Circle → ℂˣ`, after restricting its codomain to
`Circle`.
-/
theorem circle_to_cstar_hom_eq_zpow_of_exp_lift (g : Circle →* ℂˣ) (hg : Continuous g) (k : ℤ)
    (h_exp : ∀ t : ℝ, circleHomToCircle g hg (Circle.exp t) = Circle.exp ((k : ℝ) * t)) :
    ∀ z : Circle, g z = Circle.toUnits (z ^ k) := by
  intro z
  rw [← circleHomToCircle_toUnits g hg z]
  congr 1
  exact circle_endomorphism_eq_zpow_of_exp_lift (circleHomToCircle g hg) k h_exp z

/-- A unit complex number, represented as an element of `Circle`. -/
def cstarUnitToCircle (z : ℂˣ) (hz : ‖(z : ℂ)‖ = 1) : Circle :=
  ⟨(z : ℂ), by
    change (z : ℂ) ∈ Metric.sphere 0 1
    rw [mem_sphere_zero_iff_norm]
    exact hz⟩

@[simp]
theorem cstarUnitToCircle_toUnits (z : ℂˣ) (hz : ‖(z : ℂ)‖ = 1) :
    Circle.toUnits (cstarUnitToCircle z hz) = z := by
  ext
  rfl

/--
The final algebraic assembly step in the `ℂˣ` homomorphism formula: once the positive-real factor
has exponent `s` and the circle factor has winding number `k`, the homomorphism has the advertised
polar form.
-/
theorem cstar_homomorphism_formula_of_radial_and_circle (g : ℂˣ →* ℂˣ) (s : ℂ) (k : ℤ)
    (hradial : ∀ t : ℝ,
      g (cstarPositivePath t) = Units.mk0 (Complex.exp (s * (t : ℂ))) (Complex.exp_ne_zero _))
    (hcircle : ∀ z : ℂˣ, ‖(z : ℂ)‖ = 1 → g z = z ^ k) :
    ∀ w : ℂˣ, g w = cstarNormCPow s w * cstarCircleUnit w ^ k := by
  intro w
  rw [cstar_homomorphism_polar_factorization g w]
  rw [cstarNormUnit_eq_positivePath_log_norm, hradial,
    hcircle (cstarCircleUnit w) (norm_cstarCircleUnit w)]
  ext
  simp [cstarNormCPow]

/--
The C-star formula from the radial exponential formula and an integer-slope exponential-coordinate
formula for the circle factor.
-/
theorem cstar_homomorphism_formula_of_radial_and_circle_lift (g : ℂˣ →* ℂˣ) (hg : Continuous g)
    (s : ℂ) (k : ℤ)
    (hradial : ∀ t : ℝ,
      g (cstarPositivePath t) = Units.mk0 (Complex.exp (s * (t : ℂ))) (Complex.exp_ne_zero _))
    (hcircle_exp : ∀ t : ℝ,
      circleHomToCircle (g.comp Circle.toUnits) (hg.comp continuous_circle_toUnits) (Circle.exp t) =
        Circle.exp ((k : ℝ) * t)) :
    ∀ w : ℂˣ, g w = cstarNormCPow s w * cstarCircleUnit w ^ k := by
  apply cstar_homomorphism_formula_of_radial_and_circle g s k hradial
  intro z hz
  have hpow := circle_to_cstar_hom_eq_zpow_of_exp_lift (g.comp Circle.toUnits)
    (hg.comp continuous_circle_toUnits) k hcircle_exp (cstarUnitToCircle z hz)
  change g (Circle.toUnits (cstarUnitToCircle z hz)) =
    Circle.toUnits (cstarUnitToCircle z hz ^ k) at hpow
  rw [cstarUnitToCircle_toUnits] at hpow
  have hright : Circle.toUnits (cstarUnitToCircle z hz ^ k) = z ^ k := by
    rw [map_zpow, cstarUnitToCircle_toUnits]
  rwa [hright] at hpow

end CStarHomomorphism

end MathNotesLean
