/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
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

end MathNotesLean
