/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Integral.IntervalIntegral.LebesgueDifferentiationThm
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.MeasureTheory.Function.LocallyIntegrable
import Mathlib.Analysis.RCLike.Basic

/-!
# Automatic continuity of measurable multiplicative maps on `ℝ`

A Borel-measurable solution of the *multiplicative* Cauchy functional equation on `ℝ` is
automatically continuous. This is the multiplicative companion of the additive automatic-continuity
theorem `MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`.

## Main results

* `MathNotesLean.continuous_of_measurable_of_mul`: if `f : ℝ → 𝕜` (with `RCLike 𝕜`, i.e. `𝕜 = ℝ`
  or `𝕜 = ℂ`) is measurable, satisfies `f (x + y) = f x * f y`, and `f 0 ≠ 0`, then `f` is
  continuous.
* `MathNotesLean.continuous_of_measurable_of_mul_units`: the same for a measurable additive-to-
  multiplicative homomorphism `f : ℝ → 𝕜ˣ` (`f (x + y) = f x * f y`).

## Implementation notes

The modulus `‖f‖` is multiplicative, so `t ↦ log ‖f t‖` is an additive measurable map `ℝ → ℝ`,
hence continuous by `MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`; thus `‖f‖` is
continuous and `f` is locally bounded, so interval integrable. The primitive `F y = ∫₀ʸ f` is
continuous, and the interval form of the Lebesgue differentiation theorem
(`LocallyIntegrable.ae_hasDerivAt_integral`) forces `F a ≠ 0` for some `a` (otherwise `f = 0`
almost everywhere, impossible since `f` never vanishes). The homomorphism property gives the
sliding-window identity `f s · F a = ∫ₛ^{s+a} f = F (s + a) - F s`, so
`f s = (F (s + a) - F s) / F a` is continuous in `s`.

These results are the `ℝ`-domain analytic special case of the classical theorem that a measurable
homomorphism between Polish (or locally compact, second-countable) groups is continuous.
-/

noncomputable section

open MeasureTheory

namespace MathNotesLean

variable {𝕜 : Type*} [RCLike 𝕜] [MeasurableSpace 𝕜] [BorelSpace 𝕜]

-- ANCHOR: measurable-mul-continuous
/--
**Automatic continuity for the multiplicative Cauchy equation.** A Borel-measurable
`f : ℝ → 𝕜` (`RCLike 𝕜`, e.g. `ℝ` or `ℂ`) with `f (x + y) = f x * f y` and `f 0 ≠ 0` is
continuous. This is the multiplicative companion of
`MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`.
-/
theorem continuous_of_measurable_of_mul {f : ℝ → 𝕜} (hmeas : Measurable f)
    (hmul : ∀ x y, f (x + y) = f x * f y) (h0 : f 0 ≠ 0) : Continuous f := by
  -- The hypotheses force `f` to vanish nowhere.
  have hne : ∀ x, f x ≠ 0 := by
    intro x hx
    apply h0
    have hfac : f 0 = f x * f (-x) := by rw [← hmul x (-x), add_neg_cancel]
    rw [hfac, hx, zero_mul]
  -- Modulus continuity via the additive automatic-continuity theorem.
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
    MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable
      (AddMonoidHom.mk' (fun t => Real.log (ρ t)) hbadd) hbmeas
  have hρcont : Continuous ρ := by
    have hrw : ρ = fun t => Real.exp (Real.log (ρ t)) := by
      funext t; rw [Real.exp_log (hρpos t)]
    rw [hrw]; exact Real.continuous_exp.comp hbcont
  -- `f` is interval integrable on every interval, dominated by the continuous modulus.
  have haesm : AEStronglyMeasurable f volume := hmeas.aestronglyMeasurable
  have hii : ∀ a b : ℝ, IntervalIntegrable f volume a b := by
    intro a b
    rw [intervalIntegrable_iff]
    exact Integrable.mono' (intervalIntegrable_iff.mp (hρcont.intervalIntegrable a b))
      haesm.restrict (ae_of_all _ fun x => (congrFun hρdef x).ge)
  -- The primitive of `f` is continuous.
  set F : ℝ → 𝕜 := fun y => ∫ t in (0:ℝ)..y, f t with hFdef
  have hFcont : Continuous F := intervalIntegral.continuous_primitive hii 0
  -- Some window `[0, a]` has nonzero integral, by the Lebesgue differentiation theorem.
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
  -- The sliding-window identity recovers `f` from the continuous primitive.
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
-- ANCHOR_END: measurable-mul-continuous

-- ANCHOR: measurable-mul-units-continuous
/--
**Automatic continuity for measurable homomorphisms `(ℝ, +) → 𝕜ˣ`.** A Borel-measurable
`f : ℝ → 𝕜ˣ` (`RCLike 𝕜`) with `f (x + y) = f x * f y` is continuous. This specializes at `𝕜 = ℂ`
to the automatic continuity of measurable group homomorphisms `(ℝ, +) → ℂ*`.
-/
theorem continuous_of_measurable_of_mul_units {f : ℝ → 𝕜ˣ} (hmeas : Measurable f)
    (hmul : ∀ x y, f (x + y) = f x * f y) : Continuous f := by
  have hval : Measurable fun x => (f x : 𝕜) := (comap_measurable Units.val).comp hmeas
  have hmulval : ∀ x y, ((f (x + y) : 𝕜)) = (f x : 𝕜) * (f y : 𝕜) := by
    intro x y; rw [hmul, Units.val_mul]
  have hcont : Continuous fun x => (f x : 𝕜) :=
    continuous_of_measurable_of_mul hval hmulval (f 0).ne_zero
  rw [Units.continuous_iff]
  exact ⟨hcont, by simpa [Units.inv_eq_val_inv] using hcont.inv₀ fun x => (f x).ne_zero⟩
-- ANCHOR_END: measurable-mul-units-continuous

end MathNotesLean
