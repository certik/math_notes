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

The second part of the file (`symPart`, `antisymPart`) records the note's splitting of a rank-2
tensor into symmetric and antisymmetric parts, the factor of `2` relating the exterior-derivative
components to the normalized antisymmetrization bracket (`two_mul_antisymPart`), and the resulting
vanishing of the antisymmetric-part / symmetric-part contraction (`contract_antisymPart_symPart`).

The third part (`otimesExpand`, `wedge`, `wedgeExpand`) proves the note's rank-3 claim
`A_{ijk} ẽⁱ⊗ẽʲ⊗ẽᵏ = (1/3!) A_{ijk} ẽⁱ∧ẽʲ∧ẽᵏ` for a fully antisymmetric `A`
(`otimesExpand_eq_smul_wedgeExpand`).
-/

namespace MathNotesLean

namespace DifferentialForms

variable {ι : Type*} {R : Type*}

-- ANCHOR: contract-vanishes
/-- The **full contraction** `∑_{i,j} A i j * S i j` of two rank-2 covariant tensors `A` and `S`,
each written as a function `ι → ι → R` of its two indices over a finite index set `ι`. -/
def contract [Fintype ι] [NonUnitalNonAssocSemiring R] (A S : ι → ι → R) : R :=
  ∑ i, ∑ j, A i j * S i j

/-- Contracting an **antisymmetric** tensor `A` (`A i j = -A j i`) with a **symmetric** tensor `S`
(`S i j = S j i`) yields a quantity equal to its own negation.  Relabelling `i ↔ j` in the double
sum turns each term `A i j * S i j` into `A j i * S j i = (-A i j) * (S i j) = -(A i j * S i j)`. -/
theorem contract_antisymm_symm_eq_neg [Fintype ι] [Ring R] {A S : ι → ι → R}
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
theorem contract_antisymm_symm [Fintype ι] {A S : ι → ι → ℝ}
    (hA : ∀ i j, A i j = -A j i) (hS : ∀ i j, S i j = S j i) :
    contract A S = 0 := by
  have h := contract_antisymm_symm_eq_neg hA hS
  linarith
-- ANCHOR_END: contract-vanishes

/-! ### Symmetric and antisymmetric parts of a rank-2 tensor

`01-paper.md` splits any rank-2 tensor into a symmetric part `A_(ij) = ½(A i j + A j i)` and an
antisymmetric part `A_[ij] = ½(A i j − A j i)`, the latter being the *normalized* antisymmetrization
bracket used throughout the note. Over `ℝ` we record this splitting, check that the two parts are
genuinely symmetric and antisymmetric, and read off the factor of `2` that appears in the note's
1-form computation. -/

-- ANCHOR: sym-antisym
/-- The **symmetric part** `A_(ij) = ½(A i j + A j i)` of a rank-2 tensor over `ℝ`. -/
noncomputable def symPart (A : ι → ι → ℝ) : ι → ι → ℝ := fun i j => (A i j + A j i) / 2

/-- The **antisymmetric part** `A_[ij] = ½(A i j − A j i)` of a rank-2 tensor over `ℝ`; this is the
normalized antisymmetrization bracket used throughout `01-paper.md`. -/
noncomputable def antisymPart (A : ι → ι → ℝ) : ι → ι → ℝ := fun i j => (A i j - A j i) / 2

/-- The symmetric part really is symmetric: `A_(ij) = A_(ji)`. -/
theorem symPart_isSymm (A : ι → ι → ℝ) (i j : ι) : symPart A i j = symPart A j i := by
  unfold symPart; ring

/-- The antisymmetric part really is antisymmetric: `A_[ij] = -A_[ji]`. -/
theorem antisymPart_isAntisymm (A : ι → ι → ℝ) (i j : ι) :
    antisymPart A i j = - antisymPart A j i := by
  unfold antisymPart; ring

/-- Every rank-2 tensor is the sum of its symmetric and antisymmetric parts:
`A i j = A_(ij) + A_[ij]`. -/
theorem symPart_add_antisymPart (A : ι → ι → ℝ) (i j : ι) :
    symPart A i j + antisymPart A i j = A i j := by
  unfold symPart antisymPart; ring
-- ANCHOR_END: sym-antisym

-- ANCHOR: two-antisym
/-- The factor of `2` in `01-paper.md`'s 1-form exterior derivative. With the *normalized* bracket
`∂_[i f_j] = ½(∂_i f_j − ∂_j f_i)`, twice the bracket has no residual `½`:
`2 ∂_[i f_j] = ∂_i f_j − ∂_j f_i`. Taking `A i j = ∂_i f_j` this is `2 * antisymPart A i j`. -/
theorem two_mul_antisymPart (A : ι → ι → ℝ) (i j : ι) :
    2 * antisymPart A i j = A i j - A j i := by
  unfold antisymPart; ring
-- ANCHOR_END: two-antisym

-- ANCHOR: contract-parts
/-- Combining the splitting with `contract_antisymm_symm`: over `ℝ`, the full contraction of the
antisymmetric part of any tensor with the symmetric part of any tensor vanishes. -/
theorem contract_antisymPart_symPart [Fintype ι] (A B : ι → ι → ℝ) :
    contract (antisymPart A) (symPart B) = 0 :=
  contract_antisymm_symm (antisymPart_isAntisymm A) (symPart_isSymm B)
-- ANCHOR_END: contract-parts

/-! ### Rank-3: the ⊗-expansion is `1/3!` times the ∧-expansion

`01-paper.md` claims that for a fully antisymmetric rank-3 tensor `A`,

  `A_{ijk} ẽⁱ⊗ẽʲ⊗ẽᵏ = (1/3!) A_{ijk} ẽⁱ∧ẽʲ∧ẽᵏ`.

We model rank-3 covariant tensors over a finite index set `ι` as elements of the free `ℝ`-module on
index triples, `(Fin 3 → ι) → ℝ`, whose basis tensor `ẽ^{p 0}⊗ẽ^{p 1}⊗ẽ^{p 2}` is `Pi.single p 1`.
The wedge `ẽ^{p 0}∧ẽ^{p 1}∧ẽ^{p 2}` is the signed sum over the `3!` permutations of the three slots,
matching the note's definition of `u ∧ v ∧ w`. Full antisymmetry of `A` is
`A (p ∘ σ) = sign σ * A p`; the determinant tensor `A_{ijk} = det(u,v,w)` of the note is one such
`A`.

The proof reindexes the double sum `∑ₚ ∑_σ`: for each fixed permutation `σ`, substituting the
summation triple `p ↦ p ∘ σ` and using antisymmetry turns the wedge term back into the plain
`⊗`-term, so each of the `3!` permutations contributes one copy of the `⊗`-expansion. -/

-- ANCHOR: rank3-defs
/-- Levi-Civita sign of a permutation of the three tensor slots, as a real scalar. -/
def signR (σ : Equiv.Perm (Fin 3)) : ℝ := ((Equiv.Perm.sign σ : ℤ) : ℝ)

/-- The basis tensor `ẽ^{p 0} ⊗ ẽ^{p 1} ⊗ ẽ^{p 2}` in the free `ℝ`-module on index triples. -/
def basisTensor [DecidableEq ι] (p : Fin 3 → ι) : (Fin 3 → ι) → ℝ := Pi.single p 1

/-- The `⊗`-expansion `∑_{i,j,k} A_{ijk} ẽⁱ⊗ẽʲ⊗ẽᵏ` of a rank-3 tensor with coefficients `A`. -/
def otimesExpand [Fintype ι] [DecidableEq ι] (A : (Fin 3 → ι) → ℝ) : (Fin 3 → ι) → ℝ :=
  ∑ p, A p • basisTensor p

/-- The wedge basis tensor `ẽ^{p 0} ∧ ẽ^{p 1} ∧ ẽ^{p 2}`: the signed sum over permutations of the
three slots, matching the note's definition of `u ∧ v ∧ w`. -/
def wedge [DecidableEq ι] (p : Fin 3 → ι) : (Fin 3 → ι) → ℝ :=
  ∑ σ : Equiv.Perm (Fin 3), signR σ • basisTensor (p ∘ ⇑σ)

/-- The `∧`-expansion `∑_{i,j,k} A_{ijk} ẽⁱ∧ẽʲ∧ẽᵏ`. -/
def wedgeExpand [Fintype ι] [DecidableEq ι] (A : (Fin 3 → ι) → ℝ) : (Fin 3 → ι) → ℝ :=
  ∑ p, A p • wedge p
-- ANCHOR_END: rank3-defs

/-- Precomposition by `σ` as an equivalence of the triple-index type. -/
def precomp (σ : Equiv.Perm (Fin 3)) : (Fin 3 → ι) ≃ (Fin 3 → ι) where
  toFun p := p ∘ ⇑σ
  invFun q := q ∘ ⇑σ.symm
  left_inv p := by funext t; simp
  right_inv q := by funext t; simp

/-- Reindexing lemma: the `∧`-expansion equals `3! = card (Perm (Fin 3))` copies of the
`⊗`-expansion. For each permutation `σ`, substituting `p ↦ p ∘ σ` and using antisymmetry rewrites
the wedge term into the plain `⊗`-term. -/
theorem wedgeExpand_eq_card_smul [Fintype ι] [DecidableEq ι] (A : (Fin 3 → ι) → ℝ)
    (hA : ∀ (p : Fin 3 → ι) (σ : Equiv.Perm (Fin 3)), A (p ∘ ⇑σ) = signR σ * A p) :
    wedgeExpand A = (Fintype.card (Equiv.Perm (Fin 3))) • otimesExpand A := by
  have key : ∀ σ : Equiv.Perm (Fin 3),
      (∑ p, A p • (signR σ • basisTensor (p ∘ ⇑σ))) = otimesExpand A := by
    intro σ
    rw [otimesExpand]
    refine Fintype.sum_equiv (precomp σ) _ _ (fun p => ?_)
    show A p • (signR σ • basisTensor (p ∘ ⇑σ))
        = A (precomp σ p) • basisTensor (precomp σ p)
    have hp : precomp σ p = p ∘ ⇑σ := rfl
    rw [hp, hA p σ, smul_smul, mul_comm]
  have hstep : wedgeExpand A
      = ∑ σ : Equiv.Perm (Fin 3), (∑ p, A p • (signR σ • basisTensor (p ∘ ⇑σ))) := by
    rw [wedgeExpand]
    simp only [wedge, Finset.smul_sum]
    rw [Finset.sum_comm]
  rw [hstep]
  simp only [key]
  rw [Finset.sum_const, Finset.card_univ]

-- ANCHOR: rank3-main
/-- **The rank-3 claim of `01-paper.md`.** For a fully antisymmetric rank-3 tensor `A`
(`A (p ∘ σ) = sign σ * A p`), the `⊗`-expansion equals `1/3!` times the `∧`-expansion:
`A_{ijk} ẽⁱ⊗ẽʲ⊗ẽᵏ = (1/3!) A_{ijk} ẽⁱ∧ẽʲ∧ẽᵏ`. -/
theorem otimesExpand_eq_smul_wedgeExpand [Fintype ι] [DecidableEq ι] (A : (Fin 3 → ι) → ℝ)
    (hA : ∀ (p : Fin 3 → ι) (σ : Equiv.Perm (Fin 3)), A (p ∘ ⇑σ) = signR σ * A p) :
    otimesExpand A = (1 / 6 : ℝ) • wedgeExpand A := by
  have hcard : Fintype.card (Equiv.Perm (Fin 3)) = 6 := by
    rw [Fintype.card_perm, Fintype.card_fin]; rfl
  have h6 : wedgeExpand A = (6 : ℝ) • otimesExpand A := by
    rw [wedgeExpand_eq_card_smul A hA, hcard, ← Nat.cast_smul_eq_nsmul ℝ]
    norm_num
  rw [h6, smul_smul]
  norm_num
-- ANCHOR_END: rank3-main

end DifferentialForms

end MathNotesLean
