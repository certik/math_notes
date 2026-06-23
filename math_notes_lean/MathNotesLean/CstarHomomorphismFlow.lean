/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.CstarHomomorphism
import MathNotesLean.AutomaticContinuity

/-!
# `cstar_homomorphism.md`, derived in the note's own logical order

This file is the *flow-faithful* companion of `MathNotesLean/CstarHomomorphism.lean`.  It
reproduces the construction of `cstar_homomorphism.md` step by step, in the note's order, so
that each named theorem is built from the previous ones rather than from an opaque library
result.

## What is re-derived here (the one place the original takes a Mathlib shortcut)

The whole measurable theory of `cstar_homomorphism.md` rests on a single automatic-continuity
input: *a measurable additive `a : ℝ → ℝ` is continuous*.  The note proves this by hand
(`cstar_homomorphism.md`, "Cauchy's Additive Functional Equation"):

1. the Steinhaus theorem gives a level set of positive measure whose difference set is a
   neighbourhood of `0`, on which `a` is bounded;
2. the integer-scaling estimate `a (n • x) = n • a x` upgrades boundedness near `0` to
   continuity at `0`;
3. additivity propagates continuity at `0` to continuity everywhere; the dense rationals then
   pin down the linear value.

The original `CstarHomomorphism.lean` instead invokes the library black box
`MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`.  Here we re-derive it as
`continuous_of_additive_measurable`, using only the Steinhaus theorem
(`MeasureTheory.Measure.sub_mem_nhds_zero_of_addHaar_pos`) as the cited measure-theoretic input
— exactly the note's "By the Steinhaus theorem" step.  That single re-derivation is substituted
into the two leaves where the black box was used (the additive Cauchy theorem and the modulus
step of the multiplicative automatic-continuity theorem); every downstream theorem is then
re-threaded through it.

## What is reused from `CstarHomomorphism.lean` (standard analysis the note cites, not derives)

The note presents these as standard results, so they are reused verbatim:

* the continuous classification `cstar_homomorphism_formula_continuous` and all its inputs —
  the polar split, the positive radial factor through the `Complex.exp` covering map, and the
  circle characters `ζ ↦ ζ ^ k` obtained from Fourier analysis on `AddCircle` (the note: "Continuous
  characters of `S¹` are exactly `ζ ↦ ζ ^ k`"); these depend only on the *continuous* additive
  linearity, never on the measurable shortcut;
* the sliding-window integration argument inside the multiplicative automatic-continuity theorem
  (Lebesgue differentiation + interval integrals); only its modulus step used the shortcut, which
  we replace;
* the auxiliary multiplicative lemmas (`cauchy_multiplicative_pos_of_pos`,
  `cauchy_multiplicative_log_exp_additive`, `cauchy_multiplicative_neg_one_cases`, …) and the
  `ℂˣ → ℂˣ` polar bookkeeping (`cstarNormCPow`, `cstarCircleUnit`, …), none of which touch the
  shortcut.

Unqualified references inside `namespace MathNotesLean.CstarFlow` resolve to the re-derived
`CstarFlow` version when one exists, and otherwise fall through to the reused
`MathNotesLean` version.
-/

open MeasureTheory Pointwise Topology Metric Filter

namespace MathNotesLean

namespace CstarFlow

noncomputable section

/-! ## Cauchy's additive functional equation

`cstar_homomorphism.md`, section "Cauchy's Additive Functional Equation".  The measurable case is
re-derived from the Steinhaus theorem. -/

-- ANCHOR: flow-additive-rat
/-- An additive map `ℝ → ℝ` is homogeneous for rational scalars. -/
theorem cauchy_additive_rat_homogeneous (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (q : ℚ) (x : ℝ) :
    a ((q : ℝ) * x) = (q : ℝ) * a x := by
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  simpa [f, smul_eq_mul] using map_ratCast_smul f ℝ ℝ q x
-- ANCHOR_END: flow-additive-rat

-- ANCHOR: flow-additive-steinhaus
/-- **Step 1 (Steinhaus).** A measurable additive `a : ℝ → ℝ` is bounded on a neighbourhood of
`0`.  The level sets `{x | |a x| ≤ m}` cover `ℝ`, so one has positive measure; by the Steinhaus
theorem its difference set is a neighbourhood of `0`, on which additivity bounds `a` by `2 m`. -/
theorem bounded_nhds_zero_of_additive_measurable (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hmeas : Measurable a) :
    ∃ ε > 0, ∃ M : ℝ, ∀ t : ℝ, |t| < ε → |a t| ≤ M := by
  classical
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  set S : ℕ → Set ℝ := fun m => {x : ℝ | |a x| ≤ (m : ℝ)} with hS
  have hSmeas : ∀ m, MeasurableSet (S m) := fun m => hmeas.abs measurableSet_Iic
  have hcover : ⋃ m, S m = Set.univ := by
    rw [Set.eq_univ_iff_forall]; intro x
    obtain ⟨m, hm⟩ := exists_nat_ge |a x|
    exact Set.mem_iUnion.2 ⟨m, hm⟩
  have hpos : ∃ m, 0 < volume (S m) := by
    by_contra h
    have hall : ∀ m, volume (S m) = 0 := by
      intro m
      by_contra hm
      exact h ⟨m, pos_iff_ne_zero.mpr hm⟩
    have huniv : volume (Set.univ : Set ℝ) = 0 := by
      rw [← hcover]; exact measure_iUnion_null hall
    rw [Real.volume_univ] at huniv
    exact ENNReal.top_ne_zero huniv
  obtain ⟨m, hmpos⟩ := hpos
  have hstein : S m - S m ∈ 𝓝 (0 : ℝ) :=
    MeasureTheory.Measure.sub_mem_nhds_zero_of_addHaar_pos volume (S m) (hSmeas m) hmpos
  obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.1 hstein
  refine ⟨ε, hε, 2 * m, ?_⟩
  intro t ht
  have htmem : t ∈ S m - S m :=
    hball (by simpa [Metric.mem_ball, Real.dist_eq, sub_zero] using ht)
  obtain ⟨u, hu, v, hv, rfl⟩ := htmem
  have hauv : a (u - v) = a u - a v := map_sub f u v
  rw [hauv]
  simp only [S, Set.mem_setOf_eq] at hu hv
  have htri : |a u - a v| ≤ |a u| + |a v| := abs_sub (a u) (a v)
  linarith
-- ANCHOR_END: flow-additive-steinhaus

-- ANCHOR: flow-additive-scaling
/-- **Step 2 (integer scaling).** If `a` is additive and bounded by `M` on `(-ε, ε)`, then near
`0` it obeys the linear bound `|a x| ≤ (4 M / ε) |x|`.  This is the note's `n • x` argument:
choosing `n = ⌊ε / (2 |x|)⌋` makes `|n • x| < ε`, and `a (n • x) = n • a x` gives
`|a x| ≤ M / n`. -/
theorem lipschitzAt_zero_of_bounded (a : ℝ → ℝ) (hadd : ∀ x y, a (x + y) = a x + a y)
    (ε : ℝ) (hε : 0 < ε) (M : ℝ) (hbound : ∀ t, |t| < ε → |a t| ≤ M) :
    ∀ x : ℝ, |x| < ε / 4 → |a x| ≤ (4 * M / ε) * |x| := by
  classical
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  have hmul : ∀ (n : ℕ) (x : ℝ), a ((n : ℝ) * x) = (n : ℝ) * a x := by
    intro n x
    have h : f (n • x) = n • f x := map_nsmul f n x
    simp only [nsmul_eq_mul] at h; exact h
  intro x hx
  rcases eq_or_ne x 0 with hx0 | hx0
  · subst hx0
    have ha0 : a 0 = 0 := map_zero f
    rw [ha0]; simp
  · have hxpos : 0 < |x| := abs_pos.2 hx0
    have h2x : (0 : ℝ) < 2 * |x| := by positivity
    set N : ℕ := ⌊ε / (2 * |x|)⌋₊ with hN
    have hNle : (N : ℝ) ≤ ε / (2 * |x|) := Nat.floor_le (by positivity)
    have hNgt : ε / (2 * |x|) - 1 < (N : ℝ) := Nat.sub_one_lt_floor _
    have h1 : 2 * |x| * (N : ℝ) ≤ ε := by
      rw [le_div_iff₀ h2x] at hNle; nlinarith [hNle]
    have hAux : ε / (2 * |x|) < (N : ℝ) + 1 := by linarith
    have h2b : ε < 2 * |x| * ((N : ℝ) + 1) := by
      rw [div_lt_iff₀ h2x] at hAux; nlinarith [hAux]
    have hX4 : 4 * |x| < ε := by linarith [hx]
    have h2 : ε < 4 * |x| * (N : ℝ) := by nlinarith [h2b, hX4]
    have hNpos : 0 < (N : ℝ) := by nlinarith [h2, hX4, hxpos]
    have hbnd : (N : ℝ) * |a x| ≤ M := by
      have hlt : |(N : ℝ) * x| < ε := by
        rw [abs_mul, Nat.abs_cast]; nlinarith [h1, hxpos]
      have hb := hbound ((N : ℝ) * x) hlt
      rw [hmul N x, abs_mul, Nat.abs_cast] at hb
      exact hb
    have hAxnn : 0 ≤ |a x| := abs_nonneg _
    rw [div_mul_eq_mul_div, le_div_iff₀ hε]
    nlinarith [hbnd, h2, hAxnn, hxpos, mul_nonneg hAxnn (le_of_lt hxpos)]
-- ANCHOR_END: flow-additive-scaling

-- ANCHOR: flow-additive-continuous
/-- **Steps 1–3 combined.** A measurable additive `a : ℝ → ℝ` is continuous.  The Lipschitz bound
at `0` gives continuity at `0`; additivity (`continuous_of_continuousAt_zero`) propagates it
everywhere.  This re-derives `MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable` from the
Steinhaus theorem alone. -/
theorem continuous_of_additive_measurable (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hmeas : Measurable a) : Continuous a := by
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  obtain ⟨ε, hε, M, hbound⟩ := bounded_nhds_zero_of_additive_measurable a hadd hmeas
  have hlip := lipschitzAt_zero_of_bounded a hadd ε hε M hbound
  have ha0 : a 0 = 0 := map_zero f
  have hg : Tendsto (fun x : ℝ => (4 * M / ε) * |x|) (𝓝 0) (𝓝 0) := by
    have : Tendsto (fun x : ℝ => |x|) (𝓝 0) (𝓝 0) := by
      simpa using (continuous_abs.tendsto (0 : ℝ))
    simpa using this.const_mul (4 * M / ε)
  have hev : ∀ᶠ x in 𝓝 (0 : ℝ), ‖a x‖ ≤ (4 * M / ε) * |x| := by
    have hb : Metric.ball (0 : ℝ) (ε / 4) ∈ 𝓝 (0 : ℝ) := Metric.ball_mem_nhds _ (by positivity)
    filter_upwards [hb] with x hxb
    rw [Real.norm_eq_abs]
    exact hlip x (by simpa [Metric.mem_ball, Real.dist_eq, sub_zero] using hxb)
  have htend : Tendsto a (𝓝 0) (𝓝 0) := squeeze_zero_norm' hev hg
  have hcontAt : ContinuousAt a 0 := by rw [ContinuousAt, ha0]; exact htend
  exact continuous_of_continuousAt_zero f hcontAt
-- ANCHOR_END: flow-additive-continuous

-- ANCHOR: flow-additive-linear
/-- **The note's additive theorem, re-derived.** A measurable solution of Cauchy's additive
equation on `ℝ` is linear, `a x = a 1 * x`.  Identical to `cauchy_additive_measurable_linear` in
`CstarHomomorphism.lean`, except continuity comes from `continuous_of_additive_measurable` above
instead of the library black box. -/
theorem cauchy_additive_measurable_linear (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hmeas : Measurable a) :
    ∀ x : ℝ, a x = a 1 * x := by
  let f : ℝ →+ ℝ := AddMonoidHom.mk' a hadd
  have hcont : Continuous f := continuous_of_additive_measurable a hadd hmeas
  intro x
  have hsmul : f (x • (1 : ℝ)) = x • f (1 : ℝ) := map_real_smul f hcont x 1
  simpa [f, smul_eq_mul, mul_comm] using hsmul

/-- Existence form of the measurable additive Cauchy equation. -/
theorem cauchy_additive_measurable_exists (a : ℝ → ℝ)
    (hadd : ∀ x y, a (x + y) = a x + a y) (hmeas : Measurable a) :
    ∃ c : ℝ, ∀ x : ℝ, a x = c * x :=
  ⟨a 1, cauchy_additive_measurable_linear a hadd hmeas⟩
-- ANCHOR_END: flow-additive-linear

/-! ### Measurability is essential: a non-measurable additive map

`cstar_homomorphism.md`, the note following the additive theorem: without measurability Cauchy's
equation has nonlinear (necessarily non-measurable) solutions.  The Hamel-basis construction is
reproduced here; the supporting `rationalAgreementExample` helpers are reused from
`CstarHomomorphism.lean`. -/

-- ANCHOR: flow-additive-counterexample
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
-- ANCHOR_END: flow-additive-counterexample

-- ANCHOR: flow-additive-pathological
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
-- ANCHOR_END: flow-additive-pathological

/-! ## Cauchy's multiplicative functional equation on `ℝ`

`cstar_homomorphism.md`, section "Cauchy's Multiplicative Functional Equation".  The positive part
is reduced to the additive theorem above by `log ∘ m ∘ exp`; the only new dependency is the
re-derived `cauchy_additive_measurable_linear`.  The sign bookkeeping and degenerate cases reuse
the shortcut-free helpers from `CstarHomomorphism.lean`. -/

-- ANCHOR: flow-mult-pos
/-- On positive inputs, a measurable multiplicative real function is a power function.  Re-thread
of `cauchy_multiplicative_eq_rpow_on_pos`: the additive theorem applied to `t ↦ log (m (exp t))`
is the re-derived `cauchy_additive_measurable_linear`. -/
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
-- ANCHOR_END: flow-mult-pos

-- ANCHOR: flow-mult-formula
/-- The nondegenerate measurable real multiplicative Cauchy equation on `ℝˣ`: away from zero the
solution is a power of `|x|`, with the independent sign `m (-1) = ±1`. -/
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
    have hx_eq : x = (-1) * |x| := by rw [abs_of_neg hneg]; ring
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
-- ANCHOR_END: flow-mult-formula

-- ANCHOR: flow-mult-classification
/-- The measurable real multiplicative Cauchy equation: the two degenerate cases `0` and `1`, and
the nondegenerate formula on `ℝˣ` (recording `m 0 = 0`). -/
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
-- ANCHOR_END: flow-mult-classification

/-! ### Uniqueness of the real exponent and sign

`cstar_homomorphism.md`, the uniqueness remark for the real multiplicative formula: the radial
exponent is read off at `x = 2` and the sign at `x = -1`. -/

-- ANCHOR: flow-mult-uniqueness
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
-- ANCHOR_END: flow-mult-uniqueness

/-! ## Borel measurability implies continuity (multiplicative case)

`cstar_homomorphism.md`, section "Borel measurability implies continuity".  The general
`RCLike` automatic-continuity theorems `continuous_of_measurable_of_mul` and
`continuous_of_measurable_of_mul_units` live in `AutomaticContinuity.lean` and are used from
there (their sliding-window integration argument is independent of the additive shortcut). -/

/-! ## The continuous classification `ℂˣ → ℂˣ`

`cstar_homomorphism.md`, the derivation of the boxed formula assuming continuity: the polar split,
the positive radial factor through the `Complex.exp` covering map, the circle factor's modulus, the
circle characters `ζ ↦ ζ ^ k` (Fourier analysis on `AddCircle`, which the note cites as a standard
result), and the final assembly.  Deep helpers not shown as note dropdowns (the `cstar*`
definitions, the continuity lemmas, and the Fourier lemmas) are reused from
`CstarHomomorphism.lean`. -/

-- ANCHOR: flow-cstar-polar
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
-- ANCHOR_END: flow-cstar-polar

-- ANCHOR: flow-cstar-positive
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
-- ANCHOR_END: flow-cstar-positive

-- ANCHOR: flow-cstar-converse
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
-- ANCHOR_END: flow-cstar-converse

-- ANCHOR: flow-cstar-circle-fourier
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
-- ANCHOR_END: flow-cstar-circle-fourier

-- ANCHOR: flow-cstar-circle
/-- A continuous homomorphism from the unit circle to `ℂˣ` has image in the unit circle. -/
theorem circle_hom_norm_eq_one (g : Circle →* ℂˣ) (hg : Continuous g) (z : Circle) :
    ‖(g z : ℂ)‖ = 1 := by
  have hlog := circle_hom_log_norm_eq_zero g hg z
  have hpos : 0 < ‖(g z : ℂ)‖ := norm_pos_iff.mpr (g z).ne_zero
  have hexp := congrArg Real.exp hlog
  rwa [Real.exp_log hpos, Real.exp_zero] at hexp
-- ANCHOR_END: flow-cstar-circle

-- ANCHOR: flow-cstar-circle-char
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
-- ANCHOR_END: flow-cstar-circle-char

-- ANCHOR: flow-cstar-assembly
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
-- ANCHOR_END: flow-cstar-assembly

/-! ## Measurable homomorphisms `ℂˣ → ℂˣ`

`cstar_homomorphism.md`, section "Measurable Homomorphisms `ℂ*→ℂ*`".  The continuous classification
`cstar_homomorphism_formula_continuous` (polar split, positive radial factor, Fourier circle
characters) is reused unchanged; the measurable-to-continuous reduction uses
`continuous_of_measurable_of_mul_units` from `AutomaticContinuity.lean`. -/

/-- A Borel-measurable homomorphism `ℂˣ → ℂˣ` is continuous on the unit circle. -/
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

-- ANCHOR: flow-cstar-measurable
/-- **Automatic continuity.** A Borel-measurable group homomorphism `ℂˣ → ℂˣ` is continuous. The
polar factorization splits `g` into a radial part and a unit-circle part, each continuous by
`continuous_of_measurable_of_mul_units` (from `AutomaticContinuity.lean`). -/
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

/-- A Borel-measurable homomorphism `ℂˣ → ℂˣ` has the boxed polar form `g w = |w|^s (w/|w|)^k`.
Automatic continuity reduces it to the reused `cstar_homomorphism_formula_continuous`. -/
theorem cstar_homomorphism_formula_measurable (g : ℂˣ →* ℂˣ) (hg : Measurable g) :
    ∃ s : ℂ, ∃ k : ℤ, ∀ w : ℂˣ, g w = cstarNormCPow s w * cstarCircleUnit w ^ k :=
  cstar_homomorphism_formula_continuous g (cstar_homomorphism_continuous_of_measurable g hg)
-- ANCHOR_END: flow-cstar-measurable

/-! ## Multiplicative functions on `ℂ`

`cstar_homomorphism.md`, section "Multiplicative Functions on `ℂ`".  The nondegenerate branch
restricts `m` to a measurable `ℂˣ → ℂˣ` and applies the re-threaded
`cstar_homomorphism_formula_measurable`. -/

-- ANCHOR: flow-mult-complex-classification
/-- **Measurable multiplicative functions `ℂ → ℂ`.** A measurable `m : ℂ → ℂ` with
`m (z * w) = m z * m w` is `0`, `1`, or (when `m 1 = 1`, `m 0 = 0`) the boxed `ℂ*`-homomorphism
`z ↦ |z|^s (z / |z|)^k` extended by `m 0 = 0`. -/
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
-- ANCHOR_END: flow-mult-complex-classification

end

end CstarFlow

end MathNotesLean
