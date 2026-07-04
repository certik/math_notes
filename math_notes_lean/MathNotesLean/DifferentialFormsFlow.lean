/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib

/-!
# Antisymmetric–symmetric contraction vanishes — companion to `01-paper.md`

`01-paper.md` splits the tensor basis `ẽⁱ ⊗ ẽʲ` into its symmetric and antisymmetric parts and
observes that the antisymmetric tensor `A_{ij} = uᵢ vⱼ − uⱼ vᵢ` contracted with the *symmetric*
basis combination `ẽⁱ ⊗ ẽʲ + ẽʲ ⊗ ẽⁱ` gives zero.

This file formalizes the underlying algebraic fact: the **full contraction**

  `∑_{i,j} A i j * S i j`

of an antisymmetric tensor `A` (`A i j = -A j i`) with a symmetric tensor `S` (`S i j = S j i`)
vanishes.  The two rank-2 covariant tensors are represented as functions `ι → ι → R` of their two
indices, with `ι` a finite index set.

The proof is the standard one.  Relabelling the two summation indices and using the antisymmetry of
`A` together with the symmetry of `S` shows that the contraction equals its own negation
(`contract_antisymm_symm_eq_neg`).  This forces it to be zero in any ring where `2` is cancellable,
in particular over `ℝ` (`contract_antisymm_symm`).
-/

namespace MathNotesLean

namespace DifferentialForms

variable {ι : Type*} [Fintype ι] {R : Type*}

-- ANCHOR: contract-vanishes
/-- The **full contraction** `∑_{i,j} A i j * S i j` of two rank-2 covariant tensors `A` and `S`,
each written as a function `ι → ι → R` of its two indices over a finite index set `ι`. -/
def contract [NonUnitalNonAssocSemiring R] (A S : ι → ι → R) : R :=
  ∑ i, ∑ j, A i j * S i j

/-- Contracting an **antisymmetric** tensor `A` (`A i j = -A j i`) with a **symmetric** tensor `S`
(`S i j = S j i`) yields a quantity equal to its own negation.  Relabelling `i ↔ j` in the double
sum turns each term `A i j * S i j` into `A j i * S j i = (-A i j) * (S i j) = -(A i j * S i j)`. -/
theorem contract_antisymm_symm_eq_neg [Ring R] {A S : ι → ι → R}
    (hA : ∀ i j, A i j = -A j i) (hS : ∀ i j, S i j = S j i) :
    contract A S = - contract A S := by
  have reindex : contract A S = ∑ i, ∑ j, A j i * S j i := by
    rw [contract, Finset.sum_comm]
  conv_lhs => rw [reindex]
  rw [contract, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [hA j i, hS j i, neg_mul]

/-- Over `ℝ` (any ring where `2` is cancellable) the contraction of an antisymmetric tensor with a
symmetric tensor is therefore exactly zero, as claimed in `01-paper.md`. -/
theorem contract_antisymm_symm {A S : ι → ι → ℝ}
    (hA : ∀ i j, A i j = -A j i) (hS : ∀ i j, S i j = S j i) :
    contract A S = 0 := by
  have h := contract_antisymm_symm_eq_neg hA hS
  linarith
-- ANCHOR_END: contract-vanishes

end DifferentialForms

end MathNotesLean
