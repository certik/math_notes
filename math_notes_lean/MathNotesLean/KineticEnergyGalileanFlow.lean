/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.CstarHomomorphismFlow
import MathNotesLean.ScalingFunctionalEquationFlow

/-!
# Kinetic energy is quadratic — flow-faithful development of `kinetic_energy_galilean.md`

The physics of `kinetic_energy_galilean.md` (one symmetric inelastic collision, viewed in a frame
boosted by an arbitrary velocity `b`, with energy balance and frame-invariant heat) produces the
**parallelogram law**

  `E (v + b) + E (v - b) = 2 * E v + 2 * E b`   for all `v, b`.

This file takes that functional equation as the hypothesis and formalizes the note's derivation that
its regular solutions are exactly the quadratics `E v = c v ^ 2`:

* basic consequences `E 0 = 0`, `E (-v) = E v`, and the doubling slice `E (2 v) = 4 E v`
  (`parallelogram_double`), which is exactly the equation of `scaling_functional_equation.md`
  (`parallelogram_isSolution`);
* integer and rational scaling `E (q v) = q ^ 2 E v` (`nat_scaling`, `int_scaling`, `rat_value`),
  the note's Steps 1–2;
* with **continuity**, `E v = E 1 * v ^ 2` by density of `ℚ` (`eq_quadratic_of_continuous`), the
  note's Step 3;
* with mere **measurability**, the same conclusion (`eq_quadratic_of_measurable`), via the
  polarization `polar E x y = (E (x + y) - E (x - y)) / 4`, which is biadditive, so each slice is a
  measurable additive map, hence linear (reusing
  `CstarFlow.cauchy_additive_measurable_linear`);
* the converse `parallelogram_quadratic`, and the Hamel-basis pathology
  `exists_parallelogram_not_quadratic` (a non-measurable, non-quadratic solution `x ↦ a x * x`).
-/

namespace MathNotesLean

namespace KineticEnergyFlow

noncomputable section

variable {E : ℝ → ℝ}

-- ANCHOR: flow-ke-def
/-- The **parallelogram law** (quadratic functional equation): `E (v+b)+E (v-b)=2E v+2E b`.
This is the relation derived in `kinetic_energy_galilean.md` from a symmetric inelastic collision
viewed in an arbitrary inertial frame (boost `b`). -/
def Parallelogram (E : ℝ → ℝ) : Prop := ∀ v b : ℝ, E (v + b) + E (v - b) = 2 * E v + 2 * E b
-- ANCHOR_END: flow-ke-def

/-! ### Basic consequences -/

-- ANCHOR: flow-ke-basic
/-- `E 0 = 0`. -/
theorem parallelogram_zero (h : Parallelogram E) : E 0 = 0 := by
  have h00 := h 0 0
  simp only [add_zero, sub_zero] at h00
  linarith

/-- `E` is even: `E (-x) = E x`. -/
theorem parallelogram_even (h : Parallelogram E) (x : ℝ) : E (-x) = E x := by
  have h0x := h 0 x
  rw [parallelogram_zero h] at h0x
  simp only [zero_add, zero_sub, mul_zero] at h0x
  linarith

/-- The **doubling relation** `E (2 x) = 4 E x` is the `b = x` slice of the parallelogram law.
This is exactly the equation studied in `scaling_functional_equation.md`. -/
theorem parallelogram_double (h : Parallelogram E) (x : ℝ) : E (2 * x) = 4 * E x := by
  have hxx := h x x
  rw [show x + x = 2 * x by ring, show x - x = (0 : ℝ) by ring, parallelogram_zero h] at hxx
  linarith

/-- Every solution of the parallelogram law solves the scaling equation `E (2 v) = 4 E v` of
`scaling_functional_equation.md` on the positive reals. -/
theorem parallelogram_isSolution (h : Parallelogram E) : ScalingFlow.IsSolution E :=
  fun v _ => parallelogram_double h v
-- ANCHOR_END: flow-ke-basic

/-! ### Integer and rational scaling (the note's Steps 1–2) -/

-- ANCHOR: flow-ke-scaling
/-- **Step 1 (integer scaling).** `E (n v) = n ^ 2 E v` for every natural `n`, by the second-order
recurrence `E ((n+1)v) = 2 E (n v) + 2 E v - E ((n-1) v)` coming from the parallelogram law. -/
theorem nat_scaling (h : Parallelogram E) (v : ℝ) (n : ℕ) :
    E ((n : ℝ) * v) = (n : ℝ) ^ 2 * E v := by
  suffices H : ∀ k : ℕ,
      E ((k : ℝ) * v) = (k : ℝ) ^ 2 * E v ∧
        E (((k : ℝ) + 1) * v) = ((k : ℝ) + 1) ^ 2 * E v from (H n).1
  intro k
  induction k with
  | zero => refine ⟨?_, ?_⟩ <;> simp [parallelogram_zero h]
  | succ k ih =>
    obtain ⟨ih1, ih2⟩ := ih
    refine ⟨by rw [show ((k + 1 : ℕ) : ℝ) = (k : ℝ) + 1 by push_cast; ring]; exact ih2, ?_⟩
    have hp := h (((k : ℝ) + 1) * v) v
    rw [show ((k : ℝ) + 1) * v + v = (((k : ℝ) + 1) + 1) * v by ring,
      show ((k : ℝ) + 1) * v - v = (k : ℝ) * v by ring, ih1, ih2] at hp
    rw [show ((k + 1 : ℕ) : ℝ) = (k : ℝ) + 1 by push_cast; ring]
    linear_combination hp

/-- **Step 1 (integer scaling), over `ℤ`.** `E (m v) = m ^ 2 E v` for every integer `m`. -/
theorem int_scaling (h : Parallelogram E) (m : ℤ) (v : ℝ) :
    E ((m : ℝ) * v) = (m : ℝ) ^ 2 * E v := by
  obtain ⟨n, rfl | rfl⟩ := Int.eq_nat_or_neg m
  · exact_mod_cast nat_scaling h v n
  · push_cast
    rw [show -(n : ℝ) * v = -((n : ℝ) * v) by ring, parallelogram_even h, nat_scaling h v n]
    ring

/-- `E (1 / n) = E 1 * (1 / n) ^ 2`, the reciprocal case of rational scaling. -/
theorem inv_value (h : Parallelogram E) (n : ℕ) (hn : n ≠ 0) :
    E ((n : ℝ)⁻¹) = E 1 * ((n : ℝ)⁻¹) ^ 2 := by
  have hn' : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  have hns := nat_scaling h ((n : ℝ)⁻¹) n
  rw [mul_inv_cancel₀ hn'] at hns
  have h2 : E ((n : ℝ)⁻¹) = E 1 * ((n : ℝ) ^ 2)⁻¹ := by
    rw [hns, mul_comm ((n : ℝ) ^ 2) (E ((n : ℝ)⁻¹)), mul_assoc,
      mul_inv_cancel₀ (pow_ne_zero 2 hn'), mul_one]
  rw [h2, inv_pow]

/-- **Step 2 (rational scaling).** `E q = E 1 * q ^ 2` for every rational `q`. -/
theorem rat_value (h : Parallelogram E) (q : ℚ) : E (q : ℝ) = E 1 * (q : ℝ) ^ 2 := by
  rw [Rat.cast_def, div_eq_mul_inv, int_scaling h q.num ((q.den : ℝ)⁻¹),
    inv_value h q.den q.den_nz]
  ring
-- ANCHOR_END: flow-ke-scaling

/-! ### Continuity forces the quadratic (the note's Step 3) -/

-- ANCHOR: flow-ke-continuous
/-- **The note's Step 3.** A *continuous* solution of the parallelogram law is the quadratic
`E v = E 1 * v ^ 2`: it agrees with `E 1 * v ^ 2` on the dense set `ℚ` by `rat_value`, and both
sides are continuous. -/
theorem eq_quadratic_of_continuous (h : Parallelogram E) (hc : Continuous E) (x : ℝ) :
    E x = E 1 * x ^ 2 := by
  have hE : E = fun x => E 1 * x ^ 2 := by
    apply Rat.denseRange_cast.equalizer hc (continuous_const.mul (continuous_pow 2))
    funext q
    exact rat_value h q
  exact congrFun hE x
-- ANCHOR_END: flow-ke-continuous

/-! ### Measurability forces the quadratic (the note's regularity section) -/

/-- The **polarization** of `E`: `polar E x y = (E (x+y) - E (x-y)) / 4`. For a solution of the
parallelogram law this is a symmetric biadditive form with `polar E x x = E x`. -/
def polar (E : ℝ → ℝ) (x y : ℝ) : ℝ := (E (x + y) - E (x - y)) / 4

-- ANCHOR: flow-ke-polar
/-- `polar E x x = E x` (the diagonal recovers `E`). -/
theorem polar_self (h : Parallelogram E) (x : ℝ) : polar E x x = E x := by
  simp only [polar]
  rw [show x + x = 2 * x by ring, parallelogram_double h, show x - x = (0 : ℝ) by ring,
    parallelogram_zero h]
  ring

/-- `polar E 0 y = 0`. -/
theorem polar_zero_left (h : Parallelogram E) (y : ℝ) : polar E 0 y = 0 := by
  have hy : E (0 - y) = E y := by rw [zero_sub]; exact parallelogram_even h y
  simp only [polar, zero_add, hy, sub_self, zero_div]

/-- **Jensen's identity for the polarization** (from the parallelogram law applied twice):
`polar E (x+x') y + polar E (x-x') y = 2 * polar E x y`. -/
theorem polar_jensen (h : Parallelogram E) (x x' y : ℝ) :
    polar E (x + x') y + polar E (x - x') y = 2 * polar E x y := by
  have hA := h (x + y) x'
  rw [show x + y + x' = x + x' + y by ring, show x + y - x' = x - x' + y by ring] at hA
  have hB := h (x - y) x'
  rw [show x - y + x' = x + x' - y by ring, show x - y - x' = x - x' - y by ring] at hB
  simp only [polar]
  linarith [hA, hB]

/-- **Additivity of the polarization in the first slot.** This is Jensen's identity together with
`polar E 0 y = 0`. -/
theorem polar_add_left (h : Parallelogram E) (x x' y : ℝ) :
    polar E (x + x') y = polar E x y + polar E x' y := by
  have hj := polar_jensen h ((x + x') / 2) ((x - x') / 2) y
  rw [show (x + x') / 2 + (x - x') / 2 = x by ring,
    show (x + x') / 2 - (x - x') / 2 = x' by ring] at hj
  have hh := polar_jensen h ((x + x') / 2) ((x + x') / 2) y
  rw [show (x + x') / 2 + (x + x') / 2 = x + x' by ring,
    show (x + x') / 2 - (x + x') / 2 = (0 : ℝ) by ring, polar_zero_left h] at hh
  linarith [hj, hh]

/-- The polarization is symmetric: `polar E x y = polar E y x` (from evenness). -/
theorem polar_symm (h : Parallelogram E) (x y : ℝ) : polar E x y = polar E y x := by
  simp only [polar]
  rw [add_comm y x, show y - x = -(x - y) by ring, parallelogram_even h]

/-- If `E` is measurable, so is each slice `x ↦ polar E x y`. -/
theorem polar_measurable (hm : Measurable E) (y : ℝ) : Measurable (fun x => polar E x y) := by
  simp only [polar]
  exact ((hm.comp (measurable_id.add_const y)).sub
    (hm.comp (measurable_id.sub_const y))).div_const 4

/-- **Linearity of the polarization in the first slot, for measurable `E`.** Each slice is a
measurable additive map `ℝ → ℝ`, hence linear by `CstarFlow.cauchy_additive_measurable_linear`. -/
theorem polar_linear_left (h : Parallelogram E) (hm : Measurable E) (x y : ℝ) :
    polar E x y = polar E 1 y * x := by
  have hlin := CstarFlow.cauchy_additive_measurable_linear (fun t => polar E t y)
    (fun a b => polar_add_left h a b y) (polar_measurable hm y)
  simpa using hlin x
-- ANCHOR_END: flow-ke-polar

-- ANCHOR: flow-ke-measurable
/-- **Measurability forces the quadratic.** A measurable solution of the parallelogram law is
`E v = E 1 * v ^ 2`. From `polar E x x = E x` and bilinearity,
`E x = polar E x x = (polar E 1 1) * x ^ 2 = E 1 * x ^ 2`. -/
theorem eq_quadratic_of_measurable (h : Parallelogram E) (hm : Measurable E) (x : ℝ) :
    E x = E 1 * x ^ 2 := by
  have hxx : E x = polar E x x := (polar_self h x).symm
  have h1 : polar E x x = polar E 1 x * x := polar_linear_left h hm x x
  have h2 : polar E 1 x = E 1 * x := by
    rw [polar_symm h 1 x, polar_linear_left h hm x 1, polar_self h 1]
  rw [hxx, h1, h2]; ring
-- ANCHOR_END: flow-ke-measurable

/-! ### Converse and the non-measurable pathology -/

-- ANCHOR: flow-ke-converse
/-- **Converse.** Every quadratic `E v = c v ^ 2` satisfies the parallelogram law. -/
theorem parallelogram_quadratic (c : ℝ) : Parallelogram (fun x => c * x ^ 2) := by
  intro v b
  simp only []
  ring
-- ANCHOR_END: flow-ke-converse

-- ANCHOR: flow-ke-pathological
/-- **Without regularity the parallelogram law has non-quadratic solutions.** If `a : ℝ → ℝ` is a
non-linear additive map (a Hamel-basis solution of Cauchy's equation,
`CstarFlow.exists_additive_not_linear`), then `E x = a x * x` satisfies the parallelogram law but is
not of the form `c x ^ 2`. Such an `E` is non-measurable (else it would be quadratic by
`eq_quadratic_of_measurable`); the construction depends on the axiom of choice. -/
theorem exists_parallelogram_not_quadratic :
    ∃ E : ℝ → ℝ, Parallelogram E ∧ ¬ ∃ c : ℝ, ∀ x, E x = c * x ^ 2 := by
  obtain ⟨a, hadd, hnl⟩ := CstarFlow.exists_additive_not_linear
  have ha0 : a 0 = 0 := by have := hadd 0 0; simp only [add_zero] at this; linarith
  refine ⟨fun x => a x * x, ?_, ?_⟩
  · intro v b
    simp only []
    have hsub : a (v - b) = a v - a b := by
      have := hadd (v - b) b
      rw [sub_add_cancel] at this
      linarith
    rw [hadd v b, hsub]; ring
  · rintro ⟨c, hc⟩
    apply hnl
    refine ⟨c, fun x => ?_⟩
    rcases eq_or_ne x 0 with rfl | hx
    · simp [ha0]
    · have hcx : a x * x = c * x * x := by have := hc x; simp only at this; rw [this]; ring
      exact mul_right_cancel₀ hx hcx
-- ANCHOR_END: flow-ke-pathological

end

end KineticEnergyFlow

end MathNotesLean
