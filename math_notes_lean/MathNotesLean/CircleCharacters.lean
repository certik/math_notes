/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.Analysis.SpecialFunctions.Complex.CircleAddChar

/-!
# Continuous characters of the unit circle

The continuous endomorphisms of the unit circle `Circle` are exactly the integer power maps
`z ↦ z ^ k` (`k : ℤ`), and dually the continuous characters of the additive circle `AddCircle T`
are exactly the Fourier monomials. This is the connected-group analogue of Mathlib's Pontryagin
duality for *finite* abelian groups, and is a candidate for upstreaming to Mathlib.

## Main results

* `continuous_circle_endomorphism_eq_zpow` — every continuous `Circle →* Circle` is `z ↦ z ^ k`;
* `circlePowerContinuousHom` — the converse: each `z ↦ z ^ k` is a continuous endomorphism;
* `continuous_addCircle_char_eq_fourier` — continuous characters of `AddCircle T` are Fourier
  monomials `fourier n`;
* `circle_endomorphism_exp_int_slope` — a continuous circle endomorphism has integer slope in
  exponential coordinates.

The file is self-contained over Mathlib (it does not depend on any other file in this project).
`compact_additive_hom_to_real_eq_zero` is a general supporting lemma (a continuous homomorphism from
a compact additive group to `ℝ` is trivial), also a Mathlib-upstreaming candidate.
-/

noncomputable section

open MeasureTheory

namespace MathNotesLean

/-- Power characters of the unit circle. -/
def circlePowerHom (k : ℤ) : Circle →* Circle where
  toFun z := z ^ k
  map_one' := by simp
  map_mul' z w := by rw [mul_zpow]

/-- Power characters of the unit circle, bundled as continuous homomorphisms. -/
def circlePowerContinuousHom (k : ℤ) : ContinuousMonoidHom Circle Circle where
  toMonoidHom := circlePowerHom k
  continuous_toFun := continuous_zpow k

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

end MathNotesLean
