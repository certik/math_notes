/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.CstarHomomorphism

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

/-! ## Borel measurability implies continuity (multiplicative case)

`cstar_homomorphism.md`, section "Borel measurability implies continuity".  The note's modulus step
"`t ↦ log ‖f t‖` is additive measurable, hence continuous" is the only use of the additive
shortcut; here it is the re-derived `continuous_of_additive_measurable`.  The remaining
sliding-window integration argument is reproduced verbatim from `AutomaticContinuity.lean`. -/

section AutomaticContinuity

variable {𝕜 : Type*} [RCLike 𝕜] [MeasurableSpace 𝕜] [BorelSpace 𝕜]

-- ANCHOR: flow-measurable-mul-continuous
/-- **Automatic continuity for the multiplicative Cauchy equation.** A Borel-measurable
`f : ℝ → 𝕜` (`RCLike 𝕜`) with `f (x + y) = f x * f y` and `f 0 ≠ 0` is continuous.  Re-thread of
`continuous_of_measurable_of_mul`: the modulus continuity uses the re-derived
`continuous_of_additive_measurable`. -/
theorem continuous_of_measurable_of_mul {f : ℝ → 𝕜} (hmeas : Measurable f)
    (hmul : ∀ x y, f (x + y) = f x * f y) (h0 : f 0 ≠ 0) : Continuous f := by
  have hne : ∀ x, f x ≠ 0 := by
    intro x hx
    apply h0
    have hfac : f 0 = f x * f (-x) := by rw [← hmul x (-x), add_neg_cancel]
    rw [hfac, hx, zero_mul]
  set ρ : ℝ → ℝ := fun t => ‖f t‖ with hρdef
  have hρpos : ∀ t, 0 < ρ t := fun t => norm_pos_iff.mpr (hne t)
  have hbadd : ∀ x y, Real.log (ρ (x + y)) = Real.log (ρ x) + Real.log (ρ y) := by
    intro x y
    rw [hρdef]
    simp only [hmul x y, norm_mul,
      Real.log_mul (ne_of_gt (norm_pos_iff.mpr (hne x))) (ne_of_gt (norm_pos_iff.mpr (hne y)))]
  have hbmeas : Measurable fun t => Real.log (ρ t) :=
    Real.measurable_log.comp (continuous_norm.measurable.comp hmeas)
  have hbcont : Continuous fun t => Real.log (ρ t) :=
    continuous_of_additive_measurable (fun t => Real.log (ρ t)) hbadd hbmeas
  have hρcont : Continuous ρ := by
    have hrw : ρ = fun t => Real.exp (Real.log (ρ t)) := by
      funext t; rw [Real.exp_log (hρpos t)]
    rw [hrw]; exact Real.continuous_exp.comp hbcont
  have haesm : AEStronglyMeasurable f volume := hmeas.aestronglyMeasurable
  have hii : ∀ a b : ℝ, IntervalIntegrable f volume a b := by
    intro a b
    rw [intervalIntegrable_iff]
    exact Integrable.mono' (intervalIntegrable_iff.mp (hρcont.intervalIntegrable a b))
      haesm.restrict (ae_of_all _ fun x => (congrFun hρdef x).ge)
  set F : ℝ → 𝕜 := fun y => ∫ t in (0:ℝ)..y, f t with hFdef
  have hFcont : Continuous F := intervalIntegral.continuous_primitive hii 0
  have hExists : ∃ a : ℝ, F a ≠ 0 := by
    by_contra hcon
    simp only [not_exists, not_ne_iff] at hcon
    have hReloc : LocallyIntegrable (fun t => RCLike.re (f t)) volume :=
      hρcont.locallyIntegrable.mono
        (RCLike.continuous_re.measurable.comp hmeas).aestronglyMeasurable
        (ae_of_all _ fun x => by
          rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (hρpos x)]
          exact (RCLike.abs_re_le_norm (f x)).trans_eq (congrFun hρdef x).symm)
    have hImloc : LocallyIntegrable (fun t => RCLike.im (f t)) volume :=
      hρcont.locallyIntegrable.mono
        (RCLike.continuous_im.measurable.comp hmeas).aestronglyMeasurable
        (ae_of_all _ fun x => by
          rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (hρpos x)]
          exact (RCLike.abs_im_le_norm (f x)).trans_eq (congrFun hρdef x).symm)
    have hReprim : ∀ y : ℝ, (∫ t in (0:ℝ)..y, RCLike.re (f t)) = 0 := by
      intro y
      have h := RCLike.reCLM.intervalIntegral_comp_comm (hii 0 y)
      simp only [RCLike.reCLM_apply] at h
      rw [h]
      have hFy : (∫ t in (0:ℝ)..y, f t) = F y := rfl
      rw [hFy, hcon y, RCLike.zero_re]
    have hImprim : ∀ y : ℝ, (∫ t in (0:ℝ)..y, RCLike.im (f t)) = 0 := by
      intro y
      have h := RCLike.imCLM.intervalIntegral_comp_comm (hii 0 y)
      simp only [RCLike.imCLM_apply] at h
      rw [h]
      have hFy : (∫ t in (0:ℝ)..y, f t) = F y := rfl
      rw [hFy, hcon y, RCLike.zero_im]
    have hzeroRe : ∀ᵐ x : ℝ, RCLike.re (f x) = 0 := by
      filter_upwards [LocallyIntegrable.ae_hasDerivAt_integral hReloc] with x hx
      have hd := hx 0
      rw [funext hReprim] at hd
      exact ((hasDerivAt_const x (0:ℝ)).unique hd).symm
    have hzeroIm : ∀ᵐ x : ℝ, RCLike.im (f x) = 0 := by
      filter_upwards [LocallyIntegrable.ae_hasDerivAt_integral hImloc] with x hx
      have hd := hx 0
      rw [funext hImprim] at hd
      exact ((hasDerivAt_const x (0:ℝ)).unique hd).symm
    have hzero : ∀ᵐ x : ℝ, f x = 0 := by
      filter_upwards [hzeroRe, hzeroIm] with x hxre hxim
      exact RCLike.ext (by rw [hxre, RCLike.zero_re]) (by rw [hxim, RCLike.zero_im])
    rw [ae_iff] at hzero
    have huniv : {x : ℝ | ¬ f x = 0} = Set.univ := by
      ext x; simpa using hne x
    rw [huniv, Real.volume_univ] at hzero
    exact ENNReal.top_ne_zero hzero
  obtain ⟨a, ha⟩ := hExists
  have hwindow : ∀ s : ℝ, f s = (F (s + a) - F s) / F a := by
    intro s
    have h2 : (∫ u in (0:ℝ)..a, f (s + u)) = f s * ∫ u in (0:ℝ)..a, f u := by
      have hfun : (fun u => f (s + u)) = fun u => f s * f u := by
        funext u; rw [hmul s u]
      rw [hfun, intervalIntegral.integral_const_mul]
    have hsub : f s * F a = ∫ t in s..(s + a), f t := by
      have hFa : F a = ∫ u in (0:ℝ)..a, f u := rfl
      rw [hFa, ← h2, intervalIntegral.integral_comp_add_left f s, add_zero]
    have hadj : F (s + a) - F s = ∫ t in s..(s + a), f t := by
      have h := intervalIntegral.integral_add_adjacent_intervals (hii 0 s) (hii s (s + a))
      have hFsa : F (s + a) = ∫ t in (0:ℝ)..(s + a), f t := rfl
      have hFs : F s = ∫ t in (0:ℝ)..s, f t := rfl
      rw [hFsa, hFs, ← h]; ring
    rw [eq_div_iff ha, hsub, hadj]
  exact ((((hFcont.comp (continuous_id.add continuous_const)).sub hFcont)).div_const (F a)).congr
    fun s => (hwindow s).symm
-- ANCHOR_END: flow-measurable-mul-continuous

-- ANCHOR: flow-measurable-mul-units-continuous
/-- **Automatic continuity for measurable homomorphisms `(ℝ, +) → 𝕜ˣ`.** Re-thread of
`continuous_of_measurable_of_mul_units` on top of the re-derived multiplicative continuity. -/
theorem continuous_of_measurable_of_mul_units {f : ℝ → 𝕜ˣ} (hmeas : Measurable f)
    (hmul : ∀ x y, f (x + y) = f x * f y) : Continuous f := by
  have hval : Measurable fun x => (f x : 𝕜) := (comap_measurable Units.val).comp hmeas
  have hmulval : ∀ x y, ((f (x + y) : 𝕜)) = (f x : 𝕜) * (f y : 𝕜) := by
    intro x y; rw [hmul, Units.val_mul]
  have hcont : Continuous fun x => (f x : 𝕜) :=
    continuous_of_measurable_of_mul hval hmulval (f 0).ne_zero
  rw [Units.continuous_iff]
  exact ⟨hcont, by simpa [Units.inv_eq_val_inv] using hcont.inv₀ fun x => (f x).ne_zero⟩
-- ANCHOR_END: flow-measurable-mul-units-continuous

end AutomaticContinuity

/-! ## Measurable homomorphisms `ℂˣ → ℂˣ`

`cstar_homomorphism.md`, section "Measurable Homomorphisms `ℂ*→ℂ*`".  The continuous classification
`cstar_homomorphism_formula_continuous` (polar split, positive radial factor, Fourier circle
characters) is reused unchanged; only the measurable-to-continuous reduction is re-threaded through
the re-derived `continuous_of_measurable_of_mul_units`. -/

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
polar factorization splits `g` into a radial part and a unit-circle part, each continuous by the
re-derived `continuous_of_measurable_of_mul_units`. -/
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

end CstarFlow

end MathNotesLean
