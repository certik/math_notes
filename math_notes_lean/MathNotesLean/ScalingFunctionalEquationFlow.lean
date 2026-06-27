/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.CstarHomomorphismFlow

/-!
# The scaling functional equation `E (2 v) = 4 E v` — flow-faithful development

This file formalizes `scaling_functional_equation.md`, following the note's own logical order.

For `E : ℝ → ℝ` we study the equation `E (2 v) = 4 E v` for all `v > 0`.  Iterating gives
`E (2 ^ n v) = 4 ^ n E v` for every integer `n`, so the substitution `v = 2 ^ t` reduces the
equation to `F (t + 1) = 4 F t` with `F t = E (2 ^ t)`, and then `G t = E (2 ^ t) / 4 ^ t` is
`1`-periodic.  Undoing the substitution gives the **general solution**

  `E v = v ^ 2 * P (logb 2 v)`,   `P` an arbitrary `1`-periodic function.

The classification by regularity is then honest about how this equation differs from Cauchy's:

* **No regularity.** `P` is arbitrary; a Hamel basis produces a non-measurable `1`-periodic `P`,
  hence a non-measurable solution (`exists_isSolution_not_measurable`).
* **Measurable / continuous.** Regularity transfers between `E` and `P`
  (`measurable_gauge_of_measurable`, `measurable_solution_of_periodic`), but it does **not**
  collapse the family: there is a *continuous* (indeed smooth) solution that is **not** of the rigid
  form `c v ^ 2` (`cosSolution_*`).  So, unlike Cauchy's additive equation, measurability alone is
  not enough to pin the solution down.
* **Rigid solutions.** `E v = c v ^ 2` are exactly the solutions whose periodic factor `P` is
  constant (`isSolution_const_mul_sq`, `gauge_const_mul_sq`).

The non-measurable pathology reuses `MathNotesLean.CstarFlow.exists_additive_not_linear`
(the additive Hamel-basis solution of Cauchy's equation) and
`MathNotesLean.CstarFlow.cauchy_additive_measurable_linear`.
-/

open MeasureTheory

namespace MathNotesLean

namespace ScalingFlow

noncomputable section

-- ANCHOR: flow-scaling-def
/-- `E` solves the scaling functional equation `E (2 v) = 4 E v` on the positive reals. -/
def IsSolution (E : ℝ → ℝ) : Prop := ∀ v : ℝ, 0 < v → E (2 * v) = 4 * E v

/-- The periodic *gauge* factor of a function `E`: in the substitution `v = 2 ^ t` it is
`G t = E (2 ^ t) / 4 ^ t`.  For a solution this is `1`-periodic (`gauge_periodic`). -/
def gauge (E : ℝ → ℝ) (t : ℝ) : ℝ := E ((2 : ℝ) ^ t) / (4 : ℝ) ^ t
-- ANCHOR_END: flow-scaling-def

/-! ### Two `rpow` helpers -/

/-- `4 ^ t = (2 ^ t) ^ 2` for real exponents. -/
theorem four_rpow_eq (t : ℝ) : (4 : ℝ) ^ t = ((2 : ℝ) ^ t) ^ 2 := by
  have h : (4 : ℝ) = 2 * 2 := by norm_num
  rw [h, Real.mul_rpow (by norm_num) (by norm_num)]; ring

/-- `4 ^ (logb 2 v) = v ^ 2` for `v > 0`. -/
theorem four_rpow_logb {v : ℝ} (hv : 0 < v) : (4 : ℝ) ^ Real.logb 2 v = v ^ 2 := by
  rw [four_rpow_eq, Real.rpow_logb (by norm_num) (by norm_num) hv]

/-- `t ↦ b ^ t` is continuous for `b > 0`. -/
theorem continuous_rpow_base {b : ℝ} (hb : 0 < b) : Continuous (fun t : ℝ => b ^ t) := by
  have : (fun t : ℝ => b ^ t) = fun t => Real.exp (Real.log b * t) := by
    funext t; rw [Real.rpow_def_of_pos hb]
  rw [this]
  exact Real.continuous_exp.comp (continuous_const.mul continuous_id)

/-! ### Iteration -/

-- ANCHOR: flow-scaling-iterate
/-- **Iterating forward.** `E (2 ^ n v) = 4 ^ n E v` for every natural `n`. -/
theorem iterate_nat {E : ℝ → ℝ} (h : IsSolution E) (n : ℕ) {v : ℝ} (hv : 0 < v) :
    E ((2 : ℝ) ^ n * v) = (4 : ℝ) ^ n * E v := by
  induction n with
  | zero => simp
  | succ n ih =>
    have hpos : 0 < (2 : ℝ) ^ n * v := by positivity
    have hstep : E (2 * ((2 : ℝ) ^ n * v)) = 4 * E ((2 : ℝ) ^ n * v) := h _ hpos
    have hrw : (2 : ℝ) ^ (n + 1) * v = 2 * ((2 : ℝ) ^ n * v) := by ring
    rw [hrw, hstep, ih]; ring

/-- **Iterating in both directions.** `E (2 ^ n v) = 4 ^ n E v` for every integer `n`. -/
theorem iterate_int {E : ℝ → ℝ} (h : IsSolution E) (n : ℤ) {v : ℝ} (hv : 0 < v) :
    E ((2 : ℝ) ^ n * v) = (4 : ℝ) ^ n * E v := by
  induction n using Int.induction_on with
  | zero => simp
  | succ n ih =>
    have hpos : 0 < (2 : ℝ) ^ (n : ℤ) * v := by positivity
    have hstep : E (2 * ((2 : ℝ) ^ (n : ℤ) * v)) = 4 * E ((2 : ℝ) ^ (n : ℤ) * v) := h _ hpos
    have e2 : (2 : ℝ) ^ ((n : ℤ) + 1) = (2 : ℝ) ^ (n : ℤ) * 2 := by
      rw [zpow_add₀ (by norm_num : (2 : ℝ) ≠ 0), zpow_one]
    have e4 : (4 : ℝ) ^ ((n : ℤ) + 1) = (4 : ℝ) ^ (n : ℤ) * 4 := by
      rw [zpow_add₀ (by norm_num : (4 : ℝ) ≠ 0), zpow_one]
    rw [e2, e4]
    have harg : (2 : ℝ) ^ (n : ℤ) * 2 * v = 2 * ((2 : ℝ) ^ (n : ℤ) * v) := by ring
    rw [harg, hstep, ih]; ring
  | pred n ih =>
    have hpos : 0 < (2 : ℝ) ^ (-(n : ℤ) - 1) * v := by positivity
    have hstep : E (2 * ((2 : ℝ) ^ (-(n : ℤ) - 1) * v)) = 4 * E ((2 : ℝ) ^ (-(n : ℤ) - 1) * v) :=
      h _ hpos
    have e2 : (2 : ℝ) ^ (-(n : ℤ)) = 2 * (2 : ℝ) ^ (-(n : ℤ) - 1) := by
      rw [zpow_sub₀ (by norm_num : (2 : ℝ) ≠ 0), zpow_one]; ring
    have e4 : (4 : ℝ) ^ (-(n : ℤ)) = 4 * (4 : ℝ) ^ (-(n : ℤ) - 1) := by
      rw [zpow_sub₀ (by norm_num : (4 : ℝ) ≠ 0), zpow_one]; ring
    have hmul : 2 * ((2 : ℝ) ^ (-(n : ℤ) - 1) * v) = (2 : ℝ) ^ (-(n : ℤ)) * v := by
      rw [e2]; ring
    rw [hmul, ih, e4] at hstep
    linear_combination (-1 / 4 : ℝ) * hstep
-- ANCHOR_END: flow-scaling-iterate

/-! ### General solution: the gauge is `1`-periodic -/

-- ANCHOR: flow-scaling-gauge-periodic
/-- **The heart of the reduction.** For a solution `E`, the gauge `G t = E (2 ^ t) / 4 ^ t` is
`1`-periodic: `G (t + 1) = G t`.  This is `F (t + 1) = 4 F t` divided by `4 ^ (t + 1)`. -/
theorem gauge_periodic {E : ℝ → ℝ} (h : IsSolution E) : Function.Periodic (gauge E) 1 := by
  intro t
  have h2 : (0 : ℝ) < (2 : ℝ) ^ t := Real.rpow_pos_of_pos (by norm_num) t
  have h4 : (0 : ℝ) < (4 : ℝ) ^ t := Real.rpow_pos_of_pos (by norm_num) t
  have hnum : E ((2 : ℝ) ^ (t + 1)) = 4 * E ((2 : ℝ) ^ t) := by
    have he : (2 : ℝ) ^ (t + 1) = 2 * (2 : ℝ) ^ t := by
      rw [Real.rpow_add (by norm_num), Real.rpow_one]; ring
    rw [he, h ((2 : ℝ) ^ t) h2]
  have hden : (4 : ℝ) ^ (t + 1) = 4 * (4 : ℝ) ^ t := by
    rw [Real.rpow_add (by norm_num), Real.rpow_one]; ring
  simp only [gauge, hnum, hden]
  field_simp
-- ANCHOR_END: flow-scaling-gauge-periodic

-- ANCHOR: flow-scaling-reconstruct
/-- **Reconstruction.** For *any* `E` and any `v > 0`, `E v = v ^ 2 * G (logb 2 v)` where
`G = gauge E`.  This is a definitional identity (`2 ^ (logb 2 v) = v`, `4 ^ (logb 2 v) = v ^ 2`),
needing only `v > 0`; combined with `gauge_periodic` it yields the general solution. -/
theorem eq_sq_mul_gauge {E : ℝ → ℝ} {v : ℝ} (hv : 0 < v) :
    E v = v ^ 2 * gauge E (Real.logb 2 v) := by
  have h2 : (2 : ℝ) ^ Real.logb 2 v = v := Real.rpow_logb (by norm_num) (by norm_num) hv
  have h4 : (4 : ℝ) ^ Real.logb 2 v = v ^ 2 := four_rpow_logb hv
  have hv2 : v ^ 2 ≠ 0 := by positivity
  simp only [gauge, h2, h4]
  field_simp
-- ANCHOR_END: flow-scaling-reconstruct

/-! ### Converse and the characterization -/

-- ANCHOR: flow-scaling-converse
/-- **Converse.** For any `1`-periodic `P`, the map `v ↦ v ^ 2 * P (logb 2 v)` is a solution. -/
theorem isSolution_of_periodic (P : ℝ → ℝ) (hP : Function.Periodic P 1) :
    IsSolution (fun v => v ^ 2 * P (Real.logb 2 v)) := by
  intro v hv
  have hlog : Real.logb 2 (2 * v) = Real.logb 2 v + 1 := by
    rw [Real.logb_mul (by norm_num) hv.ne', Real.logb_self_eq_one (by norm_num)]; ring
  simp only [hlog, hP (Real.logb 2 v)]
  ring
-- ANCHOR_END: flow-scaling-converse

-- ANCHOR: flow-scaling-iff
/-- **General solution (characterization).** `E` solves `E (2 v) = 4 E v` on `(0, ∞)` **iff**
there is a `1`-periodic `P` with `E v = v ^ 2 * P (logb 2 v)` for all `v > 0`. -/
theorem isSolution_iff_exists_periodic {E : ℝ → ℝ} :
    IsSolution E ↔
      ∃ P : ℝ → ℝ, Function.Periodic P 1 ∧
        Set.EqOn E (fun v => v ^ 2 * P (Real.logb 2 v)) (Set.Ioi 0) := by
  constructor
  · intro h
    exact ⟨gauge E, gauge_periodic h, fun v hv => eq_sq_mul_gauge hv⟩
  · rintro ⟨P, hP, hEq⟩ v hv
    have hv2 : (0 : ℝ) < 2 * v := by positivity
    have key := isSolution_of_periodic P hP v hv
    rw [hEq (show v ∈ Set.Ioi 0 from hv), hEq (show 2 * v ∈ Set.Ioi 0 from hv2)]
    exact key
-- ANCHOR_END: flow-scaling-iff

/-! ### Rigid solutions `c v ^ 2` -/

-- ANCHOR: flow-scaling-rigid
/-- The rigid family `E v = c v ^ 2` solves the equation (this is the constant-gauge case). -/
theorem isSolution_const_mul_sq (c : ℝ) : IsSolution (fun v => c * v ^ 2) := by
  intro v hv; ring

/-- The gauge of a rigid solution `c v ^ 2` is the constant `c`: rigid solutions are exactly the
constant-`P` case of the general solution. -/
theorem gauge_const_mul_sq (c : ℝ) (t : ℝ) : gauge (fun v => c * v ^ 2) t = c := by
  have hne : ((2 : ℝ) ^ t) ^ 2 ≠ 0 := by positivity
  simp only [gauge, four_rpow_eq]
  field_simp
-- ANCHOR_END: flow-scaling-rigid

/-! ### Regularity transfers between `E` and its gauge `P` -/

-- ANCHOR: flow-scaling-measurable-transfer
/-- If a solution `E` is measurable, so is its gauge `P = G`. -/
theorem measurable_gauge_of_measurable {E : ℝ → ℝ} (hE : Measurable E) :
    Measurable (gauge E) := by
  have h2 : Measurable (fun t : ℝ => (2 : ℝ) ^ t) := (continuous_rpow_base (by norm_num)).measurable
  have h4 : Measurable (fun t : ℝ => (4 : ℝ) ^ t) := (continuous_rpow_base (by norm_num)).measurable
  unfold gauge
  exact (hE.comp h2).div h4

/-- If `P` is measurable, so is the solution `v ↦ v ^ 2 * P (logb 2 v)`. -/
theorem measurable_solution_of_periodic {P : ℝ → ℝ} (hP : Measurable P) :
    Measurable (fun v => v ^ 2 * P (Real.logb 2 v)) := by
  have hlog : Measurable (fun v : ℝ => Real.logb 2 v) := by
    simp only [Real.logb]; exact Real.measurable_log.div_const _
  exact (continuous_pow 2).measurable.mul (hP.comp hlog)
-- ANCHOR_END: flow-scaling-measurable-transfer

/-! ### A continuous (smooth) solution that is **not** rigid -/

/-- The smooth solution `Ecos v = v ^ 2 * cos (2π logb 2 v)`, built from the `1`-periodic
`P t = cos (2π t)`. -/
def cosSolution (v : ℝ) : ℝ := v ^ 2 * Real.cos (2 * Real.pi * Real.logb 2 v)

/-- `t ↦ cos (2π t)` is `1`-periodic. -/
theorem cos_two_pi_periodic : Function.Periodic (fun t => Real.cos (2 * Real.pi * t)) 1 := by
  intro t
  have he : 2 * Real.pi * (t + 1) = 2 * Real.pi * t + 2 * Real.pi := by ring
  simp only [he, Real.cos_add_two_pi]

-- ANCHOR: flow-scaling-continuous-not-rigid
/-- `cosSolution` solves the equation. -/
theorem cosSolution_isSolution : IsSolution cosSolution :=
  isSolution_of_periodic _ cos_two_pi_periodic

/-- `cosSolution` is continuous on `(0, ∞)` (in fact smooth). -/
theorem cosSolution_continuousOn : ContinuousOn cosSolution (Set.Ioi 0) := by
  have hlog : ContinuousOn (fun v : ℝ => Real.logb 2 v) (Set.Ioi 0) := by
    apply Real.continuousOn_logb.mono
    intro x hx
    simp only [Set.mem_compl_iff, Set.mem_singleton_iff]
    exact (Set.mem_Ioi.mp hx).ne'
  have hcos : ContinuousOn (fun v : ℝ => Real.cos (2 * Real.pi * Real.logb 2 v)) (Set.Ioi 0) :=
    Real.continuous_cos.comp_continuousOn (continuousOn_const.mul hlog)
  exact (continuous_pow 2).continuousOn.mul hcos

/-- **Regularity is not enough.** `cosSolution` is continuous but is **not** of the rigid form
`c v ^ 2`: evaluating at `v = 1` forces `c = 1`, and at `v = 2 ^ (1/2)` forces `c = -1`. -/
theorem cosSolution_not_rigid : ¬ ∃ c : ℝ, ∀ v : ℝ, 0 < v → cosSolution v = c * v ^ 2 := by
  rintro ⟨c, hc⟩
  -- v = 1 forces c = 1
  have e1 : cosSolution 1 = c * 1 ^ 2 := hc 1 (by norm_num)
  have hc1 : c = 1 := by
    have : cosSolution 1 = 1 := by simp [cosSolution, Real.logb_one]
    rw [this] at e1; linarith
  -- v = 2 ^ (1/2) forces c = -1
  have hpos : (0 : ℝ) < (2 : ℝ) ^ ((1 : ℝ) / 2) := Real.rpow_pos_of_pos (by norm_num) _
  have e2 : cosSolution ((2 : ℝ) ^ ((1 : ℝ) / 2)) = c * ((2 : ℝ) ^ ((1 : ℝ) / 2)) ^ 2 := hc _ hpos
  have hsq : ((2 : ℝ) ^ ((1 : ℝ) / 2)) ^ 2 = 2 := by
    rw [pow_two, ← Real.rpow_add (by norm_num : (0 : ℝ) < 2),
      show (1 : ℝ) / 2 + 1 / 2 = 1 by norm_num, Real.rpow_one]
  have hval : cosSolution ((2 : ℝ) ^ ((1 : ℝ) / 2)) = -2 := by
    have hlog : Real.logb 2 ((2 : ℝ) ^ ((1 : ℝ) / 2)) = 1 / 2 :=
      Real.logb_rpow (by norm_num) (by norm_num)
    have hcos : Real.cos (2 * Real.pi * (1 / 2)) = -1 := by
      rw [show 2 * Real.pi * (1 / 2) = Real.pi by ring, Real.cos_pi]
    simp only [cosSolution, hlog, hsq, hcos]; ring
  rw [hval, hc1, hsq] at e2
  norm_num at e2
-- ANCHOR_END: flow-scaling-continuous-not-rigid

/-! ### A non-measurable solution (Hamel basis, axiom of choice) -/

-- ANCHOR: flow-scaling-pathological
/-- **Without regularity the equation has non-measurable solutions.** There is a solution `E`
of `E (2 v) = 4 E v` that is not Lebesgue measurable.  The periodic factor is a non-linear additive
solution `a` of Cauchy's equation normalized so that `a 1 = 0` (hence `1`-periodic); such an `a`
exists by `CstarFlow.exists_additive_not_linear`, depends on a Hamel basis of `ℝ` over `ℚ`, and is
non-measurable by `CstarFlow.cauchy_additive_measurable_linear`. -/
theorem exists_isSolution_not_measurable :
    ∃ E : ℝ → ℝ, IsSolution E ∧ ¬ Measurable E := by
  classical
  obtain ⟨a0, hadd0, hnl0⟩ := CstarFlow.exists_additive_not_linear
  -- normalize the additive function so that it vanishes at `1`
  set a : ℝ → ℝ := fun x => a0 x - a0 1 * x with ha
  have hadd : ∀ x y, a (x + y) = a x + a y := by
    intro x y; simp only [ha]; rw [hadd0 x y]; ring
  have ha1 : a 1 = 0 := by simp [ha]
  have hnl : ¬ ∃ c, ∀ x, a x = c * x := by
    rintro ⟨c, hc⟩
    refine hnl0 ⟨c + a0 1, fun x => ?_⟩
    have hx := hc x; simp only [ha] at hx; linear_combination hx
  -- `a` is `1`-periodic and non-measurable
  have hper : Function.Periodic a 1 := by
    intro t; rw [hadd t 1, ha1, add_zero]
  have hnmeas : ¬ Measurable a := by
    intro hmeas
    exact hnl ⟨a 1, CstarFlow.cauchy_additive_measurable_linear a hadd hmeas⟩
  -- the corresponding solution is non-measurable
  refine ⟨fun v => v ^ 2 * a (Real.logb 2 v), isSolution_of_periodic a hper, ?_⟩
  intro hEmeas
  apply hnmeas
  have h2 : Measurable (fun t : ℝ => (2 : ℝ) ^ t) := (continuous_rpow_base (by norm_num)).measurable
  have h4 : Measurable (fun t : ℝ => (4 : ℝ) ^ t) := (continuous_rpow_base (by norm_num)).measurable
  have hcomp : Measurable
      (fun t : ℝ => ((2 : ℝ) ^ t) ^ 2 * a (Real.logb 2 ((2 : ℝ) ^ t)) / (4 : ℝ) ^ t) :=
    (hEmeas.comp h2).div h4
  have hgoal :
      (fun t : ℝ => ((2 : ℝ) ^ t) ^ 2 * a (Real.logb 2 ((2 : ℝ) ^ t)) / (4 : ℝ) ^ t) = a := by
    funext t
    have hlog : Real.logb 2 ((2 : ℝ) ^ t) = t := Real.logb_rpow (by norm_num) (by norm_num)
    have hne : ((2 : ℝ) ^ t) ^ 2 ≠ 0 := by positivity
    rw [hlog, four_rpow_eq t, mul_comm (((2 : ℝ) ^ t) ^ 2) (a t), mul_div_assoc, div_self hne,
      mul_one]
  rwa [hgoal] at hcomp
-- ANCHOR_END: flow-scaling-pathological

end

end ScalingFlow

end MathNotesLean
