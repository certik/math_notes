/-
Copyright (c) 2026 Brian Beckman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Brian Beckman, Ondřej Čertík
-/
import Mathlib

/-!
# SO(3)/SO(2) Metric and Singularity

This file formalizes the 2D quotient metric tensor `g_μν` for the inverted spherical pendulum
in SO(3)/SO(2) pitch (δ) and cone-roll (η) coordinates. It verifies the metric's determinant,
defines its inverse metric, and proves that they multiply to the identity matrix outside the
coordinate singularity (`cos δ ≠ 0`).
-/

namespace MathNotesLean

noncomputable section

namespace ClassicalMechanicsSO3Flow

open Matrix

-- ANCHOR: metric-so3-def
/-- The 2D quotient metric tensor `g_μν` for the inverted spherical pendulum
in SO(3)/SO(2), represented as a diagonal matrix in pitch (δ) and cone-roll (η) coordinates. -/
def metricSO3 (I1 δ : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![I1, 0;
     0, I1 * (Real.cos δ) ^ 2]
-- ANCHOR_END: metric-so3-def

-- ANCHOR: metric-so3-det
/-- The determinant of the 2D metric tensor is `I1^2 * cos^2(δ)`.
This determinant vanishes at `δ = ±π/2` (90 degrees), causing the coordinate singularity. -/
theorem det_metricSO3 (I1 δ : ℝ) :
    (metricSO3 I1 δ).det = I1 ^ 2 * (Real.cos δ) ^ 2 := by
  unfold metricSO3
  rw [Matrix.det_fin_two_of]
  ring
-- ANCHOR_END: metric-so3-det

-- ANCHOR: metric-so3-inv-def
/-- The inverse metric tensor `g^μν` for the inverted spherical pendulum. -/
def invMetricSO3 (I1 δ : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1 / I1, 0;
     0, 1 / (I1 * (Real.cos δ) ^ 2)]
-- ANCHOR_END: metric-so3-inv-def

-- ANCHOR: metric-so3-inv-proof
/-- Verifies that `invMetricSO3` is indeed the matrix inverse of `metricSO3`
when `I1` is non-zero and the pendulum is not at the coordinate singularity (`cos δ ≠ 0`). -/
theorem metricSO3_mul_inv (I1 δ : ℝ) (hI1 : I1 ≠ 0) (hcos : Real.cos δ ≠ 0) :
    metricSO3 I1 δ * invMetricSO3 I1 δ = 1 := by
  unfold metricSO3 invMetricSO3
  ext i j
  fin_cases i <;> fin_cases j
  · simp [Matrix.mul_apply]
    field_simp [hI1]
  · simp [Matrix.mul_apply]
  · simp [Matrix.mul_apply]
  · simp [Matrix.mul_apply]
    have h_mul : I1 * Real.cos δ ^ 2 ≠ 0 := mul_ne_zero hI1 (pow_ne_zero 2 hcos)
    field_simp [h_mul]
-- ANCHOR_END: metric-so3-inv-proof

end ClassicalMechanicsSO3Flow

end

end MathNotesLean
