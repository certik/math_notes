/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.Analysis.Complex.CoveringMap
import Mathlib.Analysis.Convex.Contractible
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.Analysis.SpecialFunctions.Complex.CircleAddChar
import Mathlib.LinearAlgebra.Basis.VectorSpace
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
import Mathlib.Topology.Homotopy.Lifting
import Mathlib.Topology.Instances.RealVectorSpace
import Mathlib.Topology.Maps.OpenQuotient
import MathNotesLean.AutomaticContinuity

/-!
# Homomorphisms from `ℂˣ` to `ℂˣ`

This file starts the Lean formalization of `cstar_homomorphism.md`.
It covers the additive Cauchy equation, the real multiplicative Cauchy equation, and structural
polar-factor lemmas for homomorphisms `ℂˣ → ℂˣ`.

The continuous `ℂˣ → ℂˣ` classification is proved below. The circle-character step uses Fourier
analysis on `AddCircle`, and the positive radial step uses the covering map
`Complex.exp : ℂ → ℂˣ`. The reduction from the note that Borel-measurable homomorphisms
`ℂˣ → ℂˣ` are automatically continuous is also proved
(`cstar_homomorphism_continuous_of_measurable`); its analytic core, that a measurable homomorphism
`(ℝ, +) → 𝕜ˣ` is continuous, is `MathNotesLean.continuous_of_measurable_of_mul_units` in
`AutomaticContinuity.lean` (proved generally for `RCLike 𝕜`). Hence the boxed formula holds for
every Borel-measurable homomorphism (`cstar_homomorphism_formula_measurable`).
-/

noncomputable section

namespace MathNotesLean

open MeasureTheory

section CauchyAdditive

-- ANCHOR: additive-rat
/-- An additive map `ℝ → ℝ` is homogeneous for rational scalars. -/
theorem cauchy_additive_rat_homogeneous (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (q : ℚ) (x : ℝ) :
    a ((q : ℝ) * x) = (q : ℝ) * a x := by
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  simpa [f, smul_eq_mul] using map_ratCast_smul f ℝ ℝ q x
-- ANCHOR_END: additive-rat

-- ANCHOR: additive-linear
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
-- ANCHOR_END: additive-linear

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

-- ANCHOR: additive-counterexample
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
-- ANCHOR_END: additive-counterexample

-- ANCHOR: additive-pathological
/--
**Measurability is essential.** Without a regularity hypothesis, Cauchy's additive equation has
nonlinear solutions: there is an additive map `a : ℝ → ℝ` that is not of the form `a x = c * x` for
any constant `c`. By `cauchy_additive_measurable_linear` any such `a` is necessarily non-measurable.
The construction picks out one coordinate of a Hamel basis of `ℝ` over `ℚ`, so it depends on the
axiom of choice.
-/
theorem exists_additive_not_linear :
    ∃ a : ℝ → ℝ, (∀ x y, a (x + y) = a x + a y) ∧ ¬ ∃ c : ℝ, ∀ x, a x = c * x := by
  classical
  let B : Module.Basis (Module.Basis.ofVectorSpaceIndex ℚ ℝ) ℚ ℝ := Module.Basis.ofVectorSpace ℚ ℝ
  haveI hnt : Nontrivial (Module.Basis.ofVectorSpaceIndex ℚ ℝ) := by
    rw [← Cardinal.one_lt_iff_nontrivial]
    have hmk := B.mk_eq_rank
    rw [Real.rank_rat_real] at hmk
    simp only [Cardinal.lift_id] at hmk
    rw [hmk]
    exact_mod_cast Cardinal.nat_lt_continuum 1
  obtain ⟨i, j, hij⟩ := exists_pair_ne (Module.Basis.ofVectorSpaceIndex ℚ ℝ)
  refine ⟨fun x => ((B.repr x i : ℚ) : ℝ), ?_, ?_⟩
  · intro x y
    simp only [map_add, Finsupp.add_apply, Rat.cast_add]
  · rintro ⟨c, hc⟩
    have hBi : ((B.repr (B i) i : ℚ) : ℝ) = 1 := by
      rw [Module.Basis.repr_self, Finsupp.single_eq_same, Rat.cast_one]
    have hBj : ((B.repr (B j) i : ℚ) : ℝ) = 0 := by
      rw [Module.Basis.repr_self, Finsupp.single_apply, if_neg (Ne.symm hij), Rat.cast_zero]
    have hci : ((B.repr (B i) i : ℚ) : ℝ) = c * B i := hc (B i)
    have hcj : ((B.repr (B j) i : ℚ) : ℝ) = c * B j := hc (B j)
    rw [hBi] at hci
    rw [hBj] at hcj
    have hc0 : c = 0 := by
      rcases mul_eq_zero.mp hcj.symm with h | h
      · exact h
      · exact absurd h (B.ne_zero j)
    rw [hc0, zero_mul] at hci
    exact one_ne_zero hci
-- ANCHOR_END: additive-pathological

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

-- ANCHOR: mult-formula
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
-- ANCHOR_END: mult-formula

/-- An element `a` of a field satisfying `a = a * a` is `0` or `1`. -/
theorem eq_zero_or_eq_one_of_eq_mul_self {F : Type*} [Field F] {a : F} (h : a = a * a) :
    a = 0 ∨ a = 1 := by
  have hfac : a * (a - 1) = 0 := by linear_combination -h
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

-- ANCHOR: mult-classification
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
-- ANCHOR_END: mult-classification

-- ANCHOR: mult-uniqueness
/--
The real polar parametrization `(c, ε) ↦ (x ↦ ε^{[x<0]} |x|^c)` is injective on `ℝˣ`: the exponent
`c ∈ ℝ` (read off at `x = 2`) and the sign `ε` (read off at `x = -1`) are uniquely determined. This
is the real analogue of `cstarFormulaHom_injective`; note `ε` lives in `{±1}`, i.e. the angular
exponent is determined only modulo `2` — `k` and `k+2` give the same sign character.
-/
theorem realSignRpow_injective {c c' ε ε' : ℝ}
    (h : ∀ x : ℝ, x ≠ 0 →
      (if x < 0 then ε else 1) * |x| ^ c = (if x < 0 then ε' else 1) * |x| ^ c') :
    c = c' ∧ ε = ε' := by
  have hc : c = c' := by
    have h2 := h 2 (by norm_num)
    rw [if_neg (by norm_num : ¬(2 : ℝ) < 0), if_neg (by norm_num : ¬(2 : ℝ) < 0),
      one_mul, one_mul, show |(2 : ℝ)| = 2 from by norm_num] at h2
    have hlog := congrArg Real.log h2
    rw [Real.log_rpow (by norm_num), Real.log_rpow (by norm_num)] at hlog
    exact mul_right_cancel₀ (Real.log_pos (by norm_num)).ne' hlog
  have he : ε = ε' := by
    have hm1 := h (-1) (by norm_num)
    rw [if_pos (by norm_num : (-1 : ℝ) < 0), if_pos (by norm_num : (-1 : ℝ) < 0),
      show |(-1 : ℝ)| = 1 from by norm_num, Real.one_rpow, Real.one_rpow, mul_one, mul_one] at hm1
    exact hm1
  exact ⟨hc, he⟩

/--
**Uniqueness for the real classification.** For a measurable multiplicative `m : ℝ → ℝ` with
`m 1 = 1`, the pair `(c, m(-1)) ∈ ℝ × {±1}` in the nondegenerate form
`m x = (if x < 0 then m(-1) else 1) · |x|^c` is *unique*. This is the real counterpart of
`existsUnique_hom_factor_det_cstar`: the radial exponent `c` is unique in `ℝ` and the angular part
is the single sign `m(-1) ∈ {±1}` (the circle exponent `k ∈ ℤ` collapses to `k mod 2`).
-/
theorem existsUnique_cauchy_multiplicative_sign_rpow (m : ℝ → ℝ)
    (hm : ∀ x y : ℝ, m (x * y) = m x * m y) (h1 : m 1 = 1) (hmeas : Measurable m) :
    ∃! cε : ℝ × ℝ, (cε.2 = 1 ∨ cε.2 = -1) ∧
      ∀ x : ℝ, x ≠ 0 → m x = (if x < 0 then cε.2 else 1) * |x| ^ cε.1 := by
  obtain ⟨c, hsign, hform⟩ := cauchy_multiplicative_eq_sign_rpow_on_nonzero m hm h1 hmeas
  refine ⟨(c, m (-1)), ⟨hsign, fun x hx => hform hx⟩, ?_⟩
  rintro ⟨c', ε'⟩ ⟨_, hform'⟩
  have hagree : ∀ x : ℝ, x ≠ 0 →
      (if x < 0 then ε' else 1) * |x| ^ c' = (if x < 0 then m (-1) else 1) * |x| ^ c := by
    intro x hx
    rw [← hform' x hx, ← hform hx]
  obtain ⟨hc, he⟩ := realSignRpow_injective hagree
  simp only [Prod.mk.injEq]
  exact ⟨hc, he⟩
-- ANCHOR_END: mult-uniqueness

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

-- ANCHOR: cstar-polar
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
-- ANCHOR_END: cstar-polar

/-- The positive real path `t ↦ exp t` into `ℂˣ`. -/
def cstarPositivePath (t : ℝ) : ℂˣ :=
  Units.mk0 ((Real.exp t : ℝ) : ℂ) (by
    exact_mod_cast (Real.exp_ne_zero t))

/-- The positive real path `t ↦ exp t` into `ℂˣ` is continuous. -/
theorem continuous_cstarPositivePath : Continuous cstarPositivePath := by
  unfold cstarPositivePath
  rw [Units.continuous_iff]
  refine ⟨?_, ?_⟩
  · exact Complex.continuous_ofReal.comp Real.continuous_exp
  · simpa [Units.inv_eq_val_inv] using
      (Complex.continuous_ofReal.comp Real.continuous_exp).inv₀ fun t => by
        exact Complex.ofReal_ne_zero.mpr (Real.exp_ne_zero t)

/-- The positive real path turns addition into multiplication. -/
theorem cstarPositivePath_add (t u : ℝ) :
    cstarPositivePath (t + u) = cstarPositivePath t * cstarPositivePath u := by
  ext
  simp [cstarPositivePath, Real.exp_add]

/-- Composing a `ℂˣ` homomorphism with `t ↦ exp t` gives an additive-parameter homomorphism. -/
theorem cstar_positive_factor_additive_parameter (g : ℂˣ →* ℂˣ) (t u : ℝ) :
    g (cstarPositivePath (t + u)) = g (cstarPositivePath t) * g (cstarPositivePath u) := by
  rw [cstarPositivePath_add, map_mul]

-- ANCHOR: cstar-positive
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

/-- The map from `ℂˣ` to the nonzero complex subtype used by `Complex.isCoveringMap_exp`. -/
def additiveCstarToNonzero (G : ℝ →+ Additive ℂˣ) : ℝ → {z : ℂ // z ≠ 0} :=
  fun t => ⟨(Additive.toMul (α := ℂˣ) (G t) : ℂ), (Additive.toMul (α := ℂˣ) (G t)).ne_zero⟩

/--
Every continuous additive-parameter homomorphism `ℝ → ℂˣ` has a continuous logarithmic lift
through the complex exponential, normalized to vanish at `0`.
-/
theorem exists_continuous_log_lift_additive_cstar (G : ℝ →+ Additive ℂˣ)
    (hG : Continuous fun t => Additive.toMul (α := ℂˣ) (G t)) :
    ∃ ell : C(ℝ, ℂ), ell 0 = 0 ∧
      (fun z : ℂ => (⟨Complex.exp z, Complex.exp_ne_zero z⟩ : {z : ℂ // z ≠ 0})) ∘ ell =
        additiveCstarToNonzero G := by
  haveI : SimplyConnectedSpace ℝ := SimplyConnectedSpace.ofContractible ℝ
  let f : C(ℝ, {z : ℂ // z ≠ 0}) := {
    toFun := additiveCstarToNonzero G
    continuous_toFun := by
      dsimp [additiveCstarToNonzero]
      apply Continuous.subtype_mk
      exact Units.continuous_val.comp hG }
  have he0 : (fun z : ℂ => (⟨Complex.exp z, Complex.exp_ne_zero z⟩ : {z : ℂ // z ≠ 0})) 0 =
      f 0 := by
    ext
    simp [f, additiveCstarToNonzero]
  rcases Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts f (0 : ℝ) (0 : ℂ) he0 with
    ⟨ell, hell0, _unique⟩
  exact ⟨ell, hell0.1, hell0.2⟩

/-- The normalized continuous logarithmic lift of an additive-parameter homomorphism is additive. -/
theorem continuous_log_lift_additive (G : ℝ →+ Additive ℂˣ)
    (_hG : Continuous fun t => Additive.toMul (α := ℂˣ) (G t))
    {ell : C(ℝ, ℂ)} (hell0 : ell 0 = 0)
    (hell_lift : (fun z : ℂ => (⟨Complex.exp z, Complex.exp_ne_zero z⟩ : {z : ℂ // z ≠ 0})) ∘ ell =
        additiveCstarToNonzero G) :
    ∀ x y : ℝ, ell (x + y) = ell x + ell y := by
  let p : ℂ → {z : ℂ // z ≠ 0} := fun z => ⟨Complex.exp z, Complex.exp_ne_zero z⟩
  let F₁ : ℝ × ℝ → ℂ := fun xy => ell (xy.1 + xy.2)
  let F₂ : ℝ × ℝ → ℂ := fun xy => ell xy.1 + ell xy.2
  have hcont₁ : Continuous F₁ := ell.continuous.comp (continuous_fst.add continuous_snd)
  have hcont₂ : Continuous F₂ :=
    (ell.continuous.comp continuous_fst).add (ell.continuous.comp continuous_snd)
  have hcomp : p ∘ F₁ = p ∘ F₂ := by
    ext xy
    change Complex.exp (ell (xy.1 + xy.2)) = Complex.exp (ell xy.1 + ell xy.2)
    have h₁ := congr_fun hell_lift (xy.1 + xy.2)
    have hx := congr_fun hell_lift xy.1
    have hy := congr_fun hell_lift xy.2
    change (⟨Complex.exp (ell (xy.1 + xy.2)), Complex.exp_ne_zero _⟩ : {z : ℂ // z ≠ 0}) =
      additiveCstarToNonzero G (xy.1 + xy.2) at h₁
    change (⟨Complex.exp (ell xy.1), Complex.exp_ne_zero _⟩ : {z : ℂ // z ≠ 0}) =
      additiveCstarToNonzero G xy.1 at hx
    change (⟨Complex.exp (ell xy.2), Complex.exp_ne_zero _⟩ : {z : ℂ // z ≠ 0}) =
      additiveCstarToNonzero G xy.2 at hy
    have hmul : Additive.toMul (α := ℂˣ) (G (xy.1 + xy.2)) =
        Additive.toMul (α := ℂˣ) (G xy.1) * Additive.toMul (α := ℂˣ) (G xy.2) := by
      rw [map_add]
      rfl
    have hxv : Complex.exp (ell xy.1) = (Additive.toMul (α := ℂˣ) (G xy.1) : ℂ) :=
      congrArg Subtype.val hx
    have hyv : Complex.exp (ell xy.2) = (Additive.toMul (α := ℂˣ) (G xy.2) : ℂ) :=
      congrArg Subtype.val hy
    calc
      Complex.exp (ell (xy.1 + xy.2)) =
          (Additive.toMul (α := ℂˣ) (G (xy.1 + xy.2)) : ℂ) :=
        congrArg Subtype.val h₁
      _ = (Additive.toMul (α := ℂˣ) (G xy.1) : ℂ) *
          (Additive.toMul (α := ℂˣ) (G xy.2) : ℂ) := by
        rw [hmul]
        rfl
      _ = Complex.exp (ell xy.1) * Complex.exp (ell xy.2) := by
        rw [hxv, hyv]
      _ = Complex.exp (ell xy.1 + ell xy.2) := (Complex.exp_add _ _).symm
  have h00 : F₁ (0, 0) = F₂ (0, 0) := by simp [F₁, F₂, hell0]
  have heq := Complex.isCoveringMap_exp.eq_of_comp_eq hcont₁ hcont₂ hcomp (0, 0) h00
  intro x y
  exact congr_fun heq (x, y)

/-- A continuous additive-parameter homomorphism `ℝ → ℂˣ` has the form `t ↦ exp (s t)`. -/
theorem additive_cstar_exp_linear (G : ℝ →+ Additive ℂˣ)
    (hG : Continuous fun t => Additive.toMul (α := ℂˣ) (G t)) :
    ∃ s : ℂ, ∀ t : ℝ,
      (Additive.toMul (G t) : ℂˣ) =
        Units.mk0 (Complex.exp (s * (t : ℂ))) (Complex.exp_ne_zero _) := by
  rcases exists_continuous_log_lift_additive_cstar G hG with ⟨ell, hell0, hell_lift⟩
  have hell_add := continuous_log_lift_additive G hG hell0 hell_lift
  refine real_to_cstar_exp_linear_of_lift G ell hell_add ell.continuous ?_
  intro t
  apply Units.ext
  exact (congrArg Subtype.val (congr_fun hell_lift t)).symm
-- ANCHOR_END: cstar-positive

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

-- ANCHOR: cstar-converse
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
-- ANCHOR_END: cstar-converse

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

/-- A positive real number as a unit of `ℂ`. -/
def posUnit (t : ℝ) (ht : 0 < t) : ℂˣ :=
  Units.mk0 (t : ℂ) (by exact_mod_cast ht.ne')

@[simp] theorem coe_posUnit (t : ℝ) (ht : 0 < t) : (posUnit t ht : ℂ) = t := rfl

theorem norm_posUnit (t : ℝ) (ht : 0 < t) : ‖(posUnit t ht : ℂ)‖ = t := by
  rw [coe_posUnit, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht]

/-- Underlying value of the polar formula. -/
theorem coe_cstarFormulaHom_apply (s : ℂ) (k : ℤ) (w : ℂˣ) :
    ((cstarFormulaHom s k w : ℂˣ) : ℂ)
      = Complex.exp (s * Real.log ‖(w : ℂ)‖) * (cstarCircleUnit w : ℂ) ^ k := by
  change ((cstarNormCPow s w * cstarCircleUnit w ^ k : ℂˣ) : ℂ) = _
  rw [Units.val_mul, coe_cstarNormCPow, Units.val_zpow_eq_zpow_val]

theorem cstarNormUnit_of_norm_one {w : ℂˣ} (hw : ‖(w : ℂ)‖ = 1) : cstarNormUnit w = 1 := by
  apply Units.ext
  simp [cstarNormUnit, hw]

theorem cstarCircleUnit_of_norm_one {w : ℂˣ} (hw : ‖(w : ℂ)‖ = 1) : cstarCircleUnit w = w := by
  apply Units.ext
  have h1 := cstar_norm_mul_circle w
  rw [cstarNormUnit_of_norm_one hw] at h1
  simpa using h1

theorem cstarFormulaHom_apply_of_norm_one (s : ℂ) (k : ℤ) {w : ℂˣ} (hw : ‖(w : ℂ)‖ = 1) :
    cstarFormulaHom s k w = w ^ k := by
  change cstarNormCPow s w * cstarCircleUnit w ^ k = w ^ k
  rw [cstarCircleUnit_of_norm_one hw]
  have : cstarNormCPow s w = 1 := by
    apply Units.ext
    simp [coe_cstarNormCPow, hw]
  rw [this, one_mul]

theorem cstarCircleUnit_posUnit (t : ℝ) (ht : 0 < t) : cstarCircleUnit (posUnit t ht) = 1 := by
  apply Units.ext
  have h1 := cstar_norm_mul_circle (posUnit t ht)
  have hnu : (cstarNormUnit (posUnit t ht) : ℂ) = (t : ℂ) := by
    change ((‖(posUnit t ht : ℂ)‖ : ℝ) : ℂ) = (t : ℂ)
    rw [norm_posUnit t ht]
  rw [hnu, coe_posUnit] at h1
  have ht0 : (t : ℂ) ≠ 0 := by exact_mod_cast ht.ne'
  have := mul_left_cancel₀ ht0 (h1.trans (mul_one (t : ℂ)).symm)
  simpa using this

/--
**Uniqueness of the polar exponents.** The map `(s, k) ↦ (w ↦ |w|^s (w/|w|)^k)` is injective:
the exponents `s ∈ ℂ` and `k ∈ ℤ` are uniquely determined by the homomorphism `ℂˣ → ℂˣ`. The circle
exponent `k` is read off on the unit circle (where `|w| = 1`), and the radial exponent `s` on the
positive reals (where `w/|w| = 1`).
-/
theorem cstarFormulaHom_injective {s₁ s₂ : ℂ} {k₁ k₂ : ℤ}
    (h : cstarFormulaHom s₁ k₁ = cstarFormulaHom s₂ k₂) : s₁ = s₂ ∧ k₁ = k₂ := by
  have hk : k₁ = k₂ := by
    by_contra hne
    have hm : ((k₁ - k₂ : ℤ) : ℝ) ≠ 0 := by exact_mod_cast sub_ne_zero.mpr hne
    set θ : ℝ := Real.pi / ((k₁ - k₂ : ℤ) : ℝ) with hθ
    set w₀ : ℂˣ := Units.mk0 (Complex.exp (↑θ * Complex.I)) (Complex.exp_ne_zero _) with hw0
    have hnorm : ‖(w₀ : ℂ)‖ = 1 := Complex.norm_exp_ofReal_mul_I θ
    have hK : w₀ ^ k₁ = w₀ ^ k₂ := by
      have huni : cstarFormulaHom s₁ k₁ w₀ = cstarFormulaHom s₂ k₂ w₀ := by rw [h]
      rwa [cstarFormulaHom_apply_of_norm_one s₁ k₁ hnorm,
        cstarFormulaHom_apply_of_norm_one s₂ k₂ hnorm] at huni
    have hpow : w₀ ^ (k₁ - k₂) = 1 := by
      rw [sub_eq_add_neg, zpow_add, zpow_neg, hK, mul_inv_cancel]
    have hreal : ((k₁ - k₂ : ℤ) : ℝ) * θ = Real.pi := by
      rw [hθ]; field_simp
    have hval : ((w₀ ^ (k₁ - k₂) : ℂˣ) : ℂ) = -1 := by
      rw [Units.val_zpow_eq_zpow_val, hw0, Units.val_mk0, ← Complex.exp_int_mul]
      have hcast : (↑(k₁ - k₂) : ℂ) * (↑θ * Complex.I) = ↑Real.pi * Complex.I := by
        have : (↑(k₁ - k₂) : ℂ) * ↑θ = ↑Real.pi := by exact_mod_cast hreal
        rw [show (↑(k₁ - k₂) : ℂ) * (↑θ * Complex.I) = ((↑(k₁ - k₂) : ℂ) * ↑θ) * Complex.I from by
          ring, this]
      rw [hcast, Complex.exp_pi_mul_I]
    rw [hpow, Units.val_one] at hval
    norm_num at hval
  have hS : ∀ t : ℝ, 0 < t →
      Complex.exp (s₁ * ↑(Real.log t)) = Complex.exp (s₂ * ↑(Real.log t)) := by
    intro t ht
    have huni : cstarFormulaHom s₁ k₁ (posUnit t ht) = cstarFormulaHom s₂ k₂ (posUnit t ht) := by
      rw [h]
    have := congrArg (fun u : ℂˣ => (u : ℂ)) huni
    rw [coe_cstarFormulaHom_apply, coe_cstarFormulaHom_apply, cstarCircleUnit_posUnit,
      norm_posUnit] at this
    simpa using this
  have hRe : s₁.re = s₂.re := by
    have h1 := hS (Real.exp 1) (Real.exp_pos 1)
    rw [Real.log_exp] at h1
    simp only [Complex.ofReal_one, mul_one] at h1
    have h2 : ‖Complex.exp s₁‖ = ‖Complex.exp s₂‖ := by rw [h1]
    rw [Complex.norm_exp, Complex.norm_exp] at h2
    exact Real.exp_injective h2
  have hIm : s₁.im = s₂.im := by
    by_contra hd
    set d : ℝ := s₁.im - s₂.im with hdval
    have hd0 : d ≠ 0 := sub_ne_zero.mpr hd
    have h1 := hS (Real.exp (Real.pi / d)) (Real.exp_pos _)
    rw [Real.log_exp] at h1
    have h2 : Complex.exp ((s₁ - s₂) * ↑(Real.pi / d)) = 1 := by
      rw [sub_mul, Complex.exp_sub, h1, div_self (Complex.exp_ne_zero _)]
    have hsub : s₁ - s₂ = ↑d * Complex.I := by
      apply Complex.ext
      · simp [Complex.sub_re, hRe]
      · simp [Complex.sub_im, hdval]
    rw [hsub] at h2
    have hd0C : (d : ℂ) ≠ 0 := by exact_mod_cast hd0
    rw [show (↑d * Complex.I) * ↑(Real.pi / d) = ↑Real.pi * Complex.I from by
      push_cast; field_simp] at h2
    rw [Complex.exp_pi_mul_I] at h2
    norm_num at h2
  exact ⟨Complex.ext hRe hIm, hk⟩

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

/-- A circle-valued additive character, viewed as a complex-valued continuous map. -/
def circleValuedContinuousMap {T : ℝ} (ψ : AddChar (AddCircle T) Circle) (hψ : Continuous ψ) :
    C(AddCircle T, ℂ) where
  toFun x := (ψ x : ℂ)
  continuous_toFun := continuous_subtype_val.comp hψ

/-- A continuous circle-valued function on `AddCircle` has a nonzero Fourier coefficient. -/
theorem exists_nonzero_fourierCoeff_circleValued {T : ℝ} [Fact (0 < T)]
    (ψ : AddChar (AddCircle T) Circle) (hψ : Continuous ψ) :
    ∃ n : ℤ, fourierCoeff (circleValuedContinuousMap ψ hψ : AddCircle T → ℂ) n ≠ 0 := by
  by_contra hnone
  push Not at hnone
  let F : C(AddCircle T, ℂ) := circleValuedContinuousMap ψ hψ
  let FLp : MeasureTheory.Lp ℂ 2 AddCircle.haarAddCircle :=
    (ContinuousMap.toLp 2 AddCircle.haarAddCircle ℂ) F
  have hcoeff_l2 : ∀ n : ℤ, fourierCoeff ((FLp : AddCircle T → ℂ)) n = 0 := by
    intro n
    rw [fourierCoeff_toLp]
    exact hnone n
  have hsum := tsum_sq_fourierCoeff (T := T) FLp
  simp_rw [hcoeff_l2, norm_zero, zero_pow (by norm_num : (2 : ℕ) ≠ 0)] at hsum
  have hright :
      (∫ t : AddCircle T, ‖(FLp : AddCircle T → ℂ) t‖ ^ 2 ∂AddCircle.haarAddCircle) = 1 := by
    have hae : (fun t : AddCircle T => (FLp : AddCircle T → ℂ) t)
        =ᵐ[AddCircle.haarAddCircle] fun t => F t :=
      ContinuousMap.coeFn_toAEEqFun AddCircle.haarAddCircle F
    calc
      (∫ t : AddCircle T, ‖(FLp : AddCircle T → ℂ) t‖ ^ 2 ∂AddCircle.haarAddCircle)
          = ∫ t : AddCircle T, ‖F t‖ ^ 2 ∂AddCircle.haarAddCircle := by
            apply integral_congr_ae
            filter_upwards [hae] with t ht
            rw [ht]
      _ = ∫ _t : AddCircle T, (1 : ℝ) ∂AddCircle.haarAddCircle := by
            apply integral_congr_ae
            filter_upwards with t
            simp [F, circleValuedContinuousMap]
      _ = 1 := by simp
  rw [hright] at hsum
  norm_num at hsum

/--
If a continuous additive character has a nonzero `n`-th Fourier coefficient, then it is the
`n`-th Fourier monomial.
-/
theorem fourierCoeff_eigen {T : ℝ} [Fact (0 < T)]
    (ψ : AddChar (AddCircle T) Circle) (hψ : Continuous ψ) {n : ℤ}
    (hn : fourierCoeff (circleValuedContinuousMap ψ hψ : AddCircle T → ℂ) n ≠ 0) :
    ∀ a : AddCircle T, (ψ a : ℂ) = fourier n a := by
  let F : C(AddCircle T, ℂ) := circleValuedContinuousMap ψ hψ
  let c : ℂ := fourierCoeff (F : AddCircle T → ℂ) n
  have hc : c ≠ 0 := hn
  intro a
  have htrans : c = fourier (-n) a * (ψ a : ℂ) * c := by
    calc
      c = ∫ t : AddCircle T, fourier (-n) (t + a) * F (t + a) ∂AddCircle.haarAddCircle := by
        rw [show c = fourierCoeff (F : AddCircle T → ℂ) n by rfl]
        rw [fourierCoeff]
        exact (MeasureTheory.integral_add_right_eq_self (μ := AddCircle.haarAddCircle)
          (fun t : AddCircle T => fourier (-n) t * F t) a).symm
      _ = ∫ t : AddCircle T,
            (fourier (-n) a * (ψ a : ℂ)) * (fourier (-n) t * F t) ∂AddCircle.haarAddCircle := by
        apply integral_congr_ae
        filter_upwards with t
        simp [F, circleValuedContinuousMap, AddChar.map_add_eq_mul, Circle.coe_mul,
          fourier_apply, AddCircle.toCircle_add, mul_comm, mul_left_comm, mul_assoc]
      _ = fourier (-n) a * (ψ a : ℂ) * c := by
        rw [integral_const_mul]
        rfl
  have hfactor : fourier (-n) a * (ψ a : ℂ) = 1 := by
    exact mul_right_cancel₀ hc (by simpa [mul_assoc] using htrans.symm)
  have hpsi : (ψ a : ℂ) = (fourier (-n) a)⁻¹ :=
    eq_inv_of_mul_eq_one_right hfactor
  rw [hpsi]
  have hmul : fourier (-n) a * fourier n a = 1 := by
    rw [← fourier_add]
    simp
  exact inv_eq_of_mul_eq_one_right hmul

/-- Continuous characters of the additive circle are exactly Fourier monomials. -/
theorem continuous_addCircle_char_eq_fourier {T : ℝ} [Fact (0 < T)]
    (ψ : AddChar (AddCircle T) Circle) (hψ : Continuous ψ) :
    ∃ n : ℤ, ∀ a : AddCircle T, (ψ a : ℂ) = fourier n a := by
  obtain ⟨n, hn⟩ := exists_nonzero_fourierCoeff_circleValued ψ hψ
  exact ⟨n, fourierCoeff_eigen ψ hψ hn⟩

/-- The additive character on `AddCircle (2π)` associated to a circle endomorphism. -/
def circleEndomorphismAddChar (h : Circle →* Circle) :
    AddChar (AddCircle (2 * Real.pi)) Circle where
  toFun x := h (AddCircle.toCircle x)
  map_zero_eq_one' := by simp
  map_add_eq_mul' x y := by simp [AddCircle.toCircle_add, map_mul]

/-- The additive-circle character associated to a continuous circle endomorphism is continuous. -/
theorem continuous_circleEndomorphismAddChar (h : Circle →* Circle) (hh : Continuous h) :
    Continuous (circleEndomorphismAddChar h) := by
  dsimp [circleEndomorphismAddChar]
  exact hh.comp AddCircle.continuous_toCircle

-- ANCHOR: cstar-circle-fourier
/--
Every continuous endomorphism of the unit circle has an integer slope in exponential coordinates.
-/
theorem circle_endomorphism_exp_int_slope (h : Circle →* Circle) (hh : Continuous h) :
    ∃ k : ℤ, ∀ t : ℝ, h (Circle.exp t) = Circle.exp ((k : ℝ) * t) := by
  haveI : Fact (0 < 2 * Real.pi) := ⟨by positivity⟩
  have hψcont : Continuous (circleEndomorphismAddChar h) :=
    continuous_circleEndomorphismAddChar h hh
  obtain ⟨k, hk⟩ :=
    continuous_addCircle_char_eq_fourier (circleEndomorphismAddChar h) hψcont
  refine ⟨k, ?_⟩
  intro t
  apply Circle.ext
  rw [Circle.coe_exp]
  have hk' := hk (t : AddCircle (2 * Real.pi))
  convert hk' using 1
  · simp [circleEndomorphismAddChar, AddCircle.toCircle_apply_mk]
  · rw [fourier_coe_apply]
    congr 1
    field_simp [Real.pi_ne_zero]
    push_cast
    ring
-- ANCHOR_END: cstar-circle-fourier

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

-- ANCHOR: cstar-circle
/-- A continuous homomorphism from the unit circle to `ℂˣ` has image in the unit circle. -/
theorem circle_hom_norm_eq_one (g : Circle →* ℂˣ) (hg : Continuous g) (z : Circle) :
    ‖(g z : ℂ)‖ = 1 := by
  have hlog := circle_hom_log_norm_eq_zero g hg z
  have hpos : 0 < ‖(g z : ℂ)‖ := norm_pos_iff.mpr (g z).ne_zero
  have hexp := congrArg Real.exp hlog
  rwa [Real.exp_log hpos, Real.exp_zero] at hexp
-- ANCHOR_END: cstar-circle

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

-- ANCHOR: cstar-circle-char
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
**Continuous characters of the unit circle are exactly the integer power maps.** Every continuous
endomorphism of the circle has the form `z ↦ z ^ k` for some `k : ℤ`. (The converse, that each
`z ↦ z ^ k` is a continuous endomorphism, is `circlePowerContinuousHom`.)
-/
theorem continuous_circle_endomorphism_eq_zpow (h : Circle →* Circle) (hh : Continuous h) :
    ∃ k : ℤ, ∀ z : Circle, h z = z ^ k := by
  obtain ⟨k, hk⟩ := circle_endomorphism_exp_int_slope h hh
  exact ⟨k, circle_endomorphism_eq_zpow_of_exp_lift h k hk⟩

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
-- ANCHOR_END: cstar-circle-char

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

-- ANCHOR: cstar-assembly
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

/--
The C-star formula with the circle factor classified automatically. It remains only to supply the
positive-real radial exponential formula.
-/
theorem cstar_homomorphism_formula_of_radial (g : ℂˣ →* ℂˣ) (hg : Continuous g) (s : ℂ)
    (hradial : ∀ t : ℝ,
      g (cstarPositivePath t) = Units.mk0 (Complex.exp (s * (t : ℂ))) (Complex.exp_ne_zero _)) :
    ∃ k : ℤ, ∀ w : ℂˣ, g w = cstarNormCPow s w * cstarCircleUnit w ^ k := by
  obtain ⟨k, hk⟩ := circle_endomorphism_exp_int_slope
    (circleHomToCircle (g.comp Circle.toUnits) (hg.comp continuous_circle_toUnits))
    (continuous_circleHomToCircle _ _)
  refine ⟨k, ?_⟩
  exact cstar_homomorphism_formula_of_radial_and_circle_lift g hg s k hradial hk

/-- The positive-real factor of a `ℂˣ` homomorphism, as an additive-parameter homomorphism. -/
def cstarPositiveFactorAddHom (g : ℂˣ →* ℂˣ) : ℝ →+ Additive ℂˣ where
  toFun t := Additive.ofMul (g (cstarPositivePath t))
  map_zero' := by
    change Additive.ofMul (g (cstarPositivePath 0)) = Additive.ofMul 1
    congr
    simp [cstarPositivePath]
  map_add' t u := by
    rw [cstarPositivePath_add, map_mul]
    rfl

theorem continuous_cstarPositiveFactorAddHom (g : ℂˣ →* ℂˣ) (hg : Continuous g) :
    Continuous fun t => Additive.toMul (α := ℂˣ) (cstarPositiveFactorAddHom g t) := by
  change Continuous fun t => g (cstarPositivePath t)
  exact hg.comp continuous_cstarPositivePath

/-- Every continuous homomorphism `ℂˣ → ℂˣ` has the classified polar form. -/
theorem cstar_homomorphism_formula_continuous (g : ℂˣ →* ℂˣ) (hg : Continuous g) :
    ∃ s : ℂ, ∃ k : ℤ, ∀ w : ℂˣ, g w = cstarNormCPow s w * cstarCircleUnit w ^ k := by
  obtain ⟨s, hs⟩ := additive_cstar_exp_linear (cstarPositiveFactorAddHom g)
    (continuous_cstarPositiveFactorAddHom g hg)
  obtain ⟨k, hk⟩ := cstar_homomorphism_formula_of_radial g hg s hs
  exact ⟨s, k, hk⟩
-- ANCHOR_END: cstar-assembly

/-! ### Borel-measurable homomorphisms `ℂˣ → ℂˣ` are continuous

The note's remaining ingredient: a Borel-measurable group homomorphism `ℂˣ → ℂˣ` is automatically
continuous, so the continuous classification above already covers the measurable case. The analytic
core is `MathNotesLean.continuous_of_measurable_of_mul_units` (proved in `AutomaticContinuity.lean`,
generally for `RCLike 𝕜`): a measurable homomorphism `(ℝ, +) → 𝕜ˣ` is continuous, via the
sliding-window integration trick `f s · ∫₀ᵃ f = ∫ₛ^{s+a} f`, whose right-hand side is continuous
in `s`. Applying its `𝕜 = ℂ` case to the radial path `t ↦ exp t` and (after pulling back through
the quotient map `Circle.exp`) to the unit circle yields continuity of `g` on both polar factors,
hence everywhere.
-/

/-- A Borel-measurable homomorphism `ℂˣ → ℂˣ` is continuous on the unit circle: the restriction
`z ↦ g (toUnits z)` is continuous. The circle is the continuous quotient of `(ℝ, +)` by
`Circle.exp`, so this reduces to the additive-parameter automatic-continuity theorem. -/
theorem continuous_cstar_on_circle (g : ℂˣ →* ℂˣ) (hg : Measurable g) :
    Continuous fun z : Circle => g (Circle.toUnits z) := by
  have hcont_exp : Continuous Circle.exp := isLocalHomeomorph_circleExp.continuous
  have hquot : Topology.IsQuotientMap Circle.exp :=
    isLocalHomeomorph_circleExp.isOpenMap.isQuotientMap hcont_exp Circle.exp_surjective
  rw [hquot.continuous_iff]
  refine continuous_of_measurable_of_mul_units
    (f := fun t => g (Circle.toUnits (Circle.exp t))) ?_ ?_
  · exact hg.comp (measurable_comap_iff.mpr
      (Units.continuous_val.comp (continuous_circle_toUnits.comp hcont_exp)).measurable)
  · intro t s
    simp only [Circle.exp_add, map_mul]

-- ANCHOR: cstar-measurable
/--
**Automatic continuity.** A Borel-measurable group homomorphism `ℂˣ → ℂˣ` is continuous. The polar
factorization splits `g` into a radial part `t ↦ g (exp t)` and a unit-circle part, each continuous
by `continuous_of_measurable_of_mul_units`.
-/
theorem cstar_homomorphism_continuous_of_measurable (g : ℂˣ →* ℂˣ) (hg : Measurable g) :
    Continuous g := by
  have hrad : Continuous fun w : ℂˣ => g (cstarNormUnit w) := by
    have heq : (fun w : ℂˣ => g (cstarNormUnit w))
        = (fun t : ℝ => g (cstarPositivePath t)) ∘ fun w : ℂˣ => Real.log ‖(w : ℂ)‖ := by
      funext w
      simp only [Function.comp_apply, cstarNormUnit_eq_positivePath_log_norm]
    rw [heq]
    refine Continuous.comp ?_ continuous_log_norm_units
    exact continuous_of_measurable_of_mul_units
      (hg.comp (measurable_comap_iff.mpr
        (Units.continuous_val.comp continuous_cstarPositivePath).measurable))
      (fun t s => by rw [cstarPositivePath_add, map_mul])
  have hcirc : Continuous fun w : ℂˣ => g (cstarCircleUnit w) := by
    have heq : (fun w : ℂˣ => g (cstarCircleUnit w))
        = (fun z : Circle => g (Circle.toUnits z))
          ∘ fun w : ℂˣ => cstarUnitToCircle (cstarCircleUnit w) (norm_cstarCircleUnit w) := by
      funext w
      simp only [Function.comp_apply, cstarUnitToCircle_toUnits]
    rw [heq]
    exact (continuous_cstar_on_circle g hg).comp
      (continuous_cstarCircleUnit_val.subtype_mk _)
  exact (hrad.mul hcirc).congr fun w => (cstar_homomorphism_polar_factorization g w).symm

/--
A Borel-measurable homomorphism `ℂˣ → ℂˣ` has the boxed polar form `g w = |w|^s (w/|w|)^k`. This is
the measurable case of the classification: automatic continuity reduces it to
`cstar_homomorphism_formula_continuous`.
-/
theorem cstar_homomorphism_formula_measurable (g : ℂˣ →* ℂˣ) (hg : Measurable g) :
    ∃ s : ℂ, ∃ k : ℤ, ∀ w : ℂˣ, g w = cstarNormCPow s w * cstarCircleUnit w ^ k :=
  cstar_homomorphism_formula_continuous g (cstar_homomorphism_continuous_of_measurable g hg)
-- ANCHOR_END: cstar-measurable

end CStarHomomorphism

section CauchyMultiplicativeComplex

/-- The unit-circle polar factor `w / |w|`, read off at the level of `ℂ`. -/
theorem coe_cstarCircleUnit (w : ℂˣ) :
    (cstarCircleUnit w : ℂ) = (w : ℂ) / (‖(w : ℂ)‖ : ℂ) := by
  unfold cstarCircleUnit cstarNormUnit
  rfl

-- ANCHOR: mult-complex-classification
/--
**Measurable multiplicative functions `ℂ → ℂ`.** A measurable `m : ℂ → ℂ` satisfying
`m (z * w) = m z * m w` is exactly one of three forms: the constant `0`; the constant `1`; or, in
the nondegenerate case `m 1 = 1` and `m 0 = 0`, the boxed `ℂ*`-homomorphism `z ↦ |z|^s (z / |z|)^k`
(`s ∈ ℂ`, `k ∈ ℤ`) extended by `m 0 = 0`. The nondegenerate branch restricts `m` to a measurable
group homomorphism `ℂ* → ℂ*` and invokes `cstar_homomorphism_formula_measurable`.
-/
theorem cauchy_multiplicative_complex_classification (m : ℂ → ℂ)
    (hm : ∀ z w : ℂ, m (z * w) = m z * m w) (hmeas : Measurable m) :
    (∀ z : ℂ, m z = 0) ∨ (∀ z : ℂ, m z = 1) ∨
      ∃ (s : ℂ) (k : ℤ), m 0 = 0 ∧
        ∀ z : ℂ, z ≠ 0 →
          m z = Complex.exp (s * (Real.log ‖z‖ : ℂ)) * (z / (‖z‖ : ℂ)) ^ k := by
  have h1sq : m 1 = m 1 * m 1 := by simpa using hm 1 1
  rcases eq_zero_or_eq_one_of_eq_mul_self h1sq with h1 | h1
  · exact Or.inl fun z => by simpa [h1] using hm z 1
  · refine Or.inr ?_
    have h0sq : m 0 = m 0 * m 0 := by simpa using hm 0 0
    rcases eq_zero_or_eq_one_of_eq_mul_self h0sq with h0 | h0
    · refine Or.inr ?_
      have hmne : ∀ w : ℂˣ, m (w : ℂ) ≠ 0 := by
        intro w hw
        have h := hm (w : ℂ) ((w : ℂ)⁻¹)
        rw [mul_inv_cancel₀ w.ne_zero, h1, hw, zero_mul] at h
        exact one_ne_zero h
      let M : ℂˣ →* ℂˣ :=
        { toFun := fun w => Units.mk0 (m (w : ℂ)) (hmne w)
          map_one' := by ext; simpa using h1
          map_mul' := fun w z => by ext; simpa using hm (w : ℂ) (z : ℂ) }
      have hMmeas : Measurable M :=
        measurable_comap_iff.mpr (hmeas.comp (comap_measurable Units.val))
      obtain ⟨s, k, hsk⟩ := cstar_homomorphism_formula_measurable M hMmeas
      refine ⟨s, k, h0, fun z hz => ?_⟩
      have hmz : m z = ((M (Units.mk0 z hz) : ℂˣ) : ℂ) := rfl
      rw [hmz, hsk (Units.mk0 z hz), Units.val_mul, coe_cstarNormCPow,
        Units.val_zpow_eq_zpow_val, coe_cstarCircleUnit, Units.val_mk0]
    · exact Or.inl fun z => by simpa [h0] using (hm 0 z).symm
-- ANCHOR_END: mult-complex-classification

end CauchyMultiplicativeComplex

end MathNotesLean
