/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.DeterminantHomomorphismFlow

/-!
# Determinant from a homomorphism on the *full* matrix monoid

`DeterminantHomomorphismFlow.lean` shows that a group homomorphism `f : GLₙ(ℂ) →* ℂˣ` with the
scalar normalization `f(λI) = λⁿ` equals the determinant **on invertible matrices**
(`Flow.hom_eq_detGL_of_scalar_pow`). This file extends that to **all** matrices, singular ones
included.

## The statement and the (only) extra hypothesis

To even speak of `f` on singular matrices we must enlarge the domain: `f` becomes a **monoid**
homomorphism `f : Mₙ(ℂ) →* ℂ` of the *full* multiplicative monoid of matrices (so `f(AB) = f(A)f(B)`
now also for products with singular matrices), landing in `(ℂ, ·)` rather than `ℂˣ`. This is the
*only* new assumption — and it is purely **algebraic**: no continuity, measurability, or any other
regularity is used.

`monoidHom_eq_det_of_scalar_pow` : if `f : Mₙ(ℂ) →* ℂ` satisfies `f(λI) = λⁿ` for all `λ ∈ ℂ*`, then
`f A = det A` for **every** `A`.

## Why the singular values are forced

On units, `Units.map f : GLₙ(ℂ) →* ℂˣ` and the flow result give `f = det`. For a singular `A`
(`A.det = 0`) we take a kernel vector `v ≠ 0` (`A *ᵥ v = 0`), place it in one column of the identity
to get an invertible `Q := updateCol 1 k v` (so `det Q = vₖ ≠ 0`), making `A·Q` have a zero column.
A zero column `k` absorbs `diag(1,…,2,…,1)` on the right (`f` of that diagonal is `2`), forcing
`f(A·Q) = 0`; and `f Q ≠ 0` because `Q` is a unit. Hence `f A = 0 = det A`.

The argument needs `f D ≠ 1` for some invertible `D` fixing the singular matrix, which is exactly
what multiplicativity *on the whole monoid* supplies. There is no escape from this structural
hypothesis: on `GLₙ` alone, `f` can be any `g ∘ det`, and is simply undefined on singular matrices.

This file *does* use Mathlib's `Matrix.det` (talking about singular matrices intrinsically needs
it), so it is kept separate from the `Matrix.det`-free flow file, which it reuses.
-/

noncomputable section

namespace MathNotesLean

open Matrix

variable {n : Type*} [DecidableEq n] [Fintype n]

/-- The flow file's self-contained Leibniz polynomial `Flow.L` coincides with Mathlib's
`Matrix.det` (a one-off bridge so we can state the full-monoid result with `Matrix.det`). -/
theorem L_eq_det (M : Matrix n n ℂ) : Flow.L M = M.det := by
  rw [Flow.determinant_leibniz_formula, ← Matrix.det_transpose, Matrix.det_apply']
  refine Finset.sum_congr rfl fun σ _ => ?_
  rfl

/--
**Determinant from a full-monoid homomorphism.** If `f : Mₙ(ℂ) →* ℂ` is multiplicative on *all*
matrices (a monoid homomorphism) and satisfies the scalar normalization `f(λI) = λⁿ`, then
`f A = det A` for **every** `A ∈ Mₙ(ℂ)`, singular matrices included — derived with no regularity
assumption, using only multiplicativity on the whole monoid (which forces `f = 0` on singular
matrices) and the existence of `n`-th roots in `ℂ`. -/
theorem monoidHom_eq_det_of_scalar_pow [Nonempty n]
    (f : Matrix n n ℂ →* ℂ) (i0 : n)
    (h : ∀ x : ℂˣ, f (Matrix.diagonal fun _ => (x : ℂ)) = (x : ℂ) ^ Fintype.card n)
    (A : Matrix n n ℂ) : f A = A.det := by
  -- (i) On units, `f = det` via the flow result applied to `Units.map f : GLₙ(ℂ) →* ℂˣ`.
  have hf_unit : ∀ U : (Matrix n n ℂ)ˣ, f (U : Matrix n n ℂ) = (U : Matrix n n ℂ).det := by
    have hg : ∀ x : ℂˣ, (Units.map f) (Flow.scalarGL x) = x ^ Fintype.card n := by
      intro x
      apply Units.ext
      rw [Units.coe_map, Flow.coe_scalarGL, h x, Units.val_pow_eq_pow_val]
    intro U
    have hmain := Flow.hom_eq_detGL_of_scalar_pow (Units.map f) i0 hg U
    have hco := congrArg Units.val hmain
    rwa [Units.coe_map, Flow.coe_detGL, L_eq_det] at hco
  -- (ii) `f = 0` on any matrix with a zero column.
  have hf_zero_col : ∀ (M : Matrix n n ℂ) (k : n), (∀ i, M i k = 0) → f M = 0 := by
    intro M k hcol
    set d : n → ℂ := fun i => if i = k then 2 else 1 with hd_def
    have hprod : (∏ i : n, d i) = 2 := by
      have hps := Finset.prod_eq_single (s := (Finset.univ : Finset n)) (f := d) k
        (fun b _ hb => by simp [hd_def, hb]) (fun hk' => absurd (Finset.mem_univ k) hk')
      rw [hps]; simp [hd_def]
    have hdiag_unit : IsUnit (Matrix.diagonal d) := by
      rw [Matrix.isUnit_iff_isUnit_det, Matrix.det_diagonal, isUnit_iff_ne_zero, hprod]
      norm_num
    have hf_diag : f (Matrix.diagonal d) = 2 := by
      obtain ⟨U, hU⟩ := hdiag_unit
      rw [← hU, hf_unit U, hU, Matrix.det_diagonal, hprod]
    have hMd : M * Matrix.diagonal d = M := by
      ext i j
      rw [Matrix.mul_diagonal]
      rcases eq_or_ne j k with hj | hj
      · subst hj; simp [hcol i]
      · simp [hd_def, hj]
    have hkey : f M = f M * 2 := by
      conv_lhs => rw [← hMd]
      rw [map_mul, hf_diag]
    linear_combination -hkey
  -- (iii) Conclude: units handled by (i), singular matrices by (ii).
  by_cases hA : IsUnit A
  · obtain ⟨U, rfl⟩ := hA
    exact hf_unit U
  · have hdet0 : A.det = 0 := by
      by_contra hne
      exact hA ((Matrix.isUnit_iff_isUnit_det A).mpr (isUnit_iff_ne_zero.mpr hne))
    obtain ⟨v, hv, hAv⟩ := (Matrix.exists_mulVec_eq_zero_iff (M := A)).mpr hdet0
    obtain ⟨k, hk⟩ : ∃ k, v k ≠ 0 := Function.ne_iff.mp hv
    set Q : Matrix n n ℂ := Matrix.updateCol 1 k v with hQ_def
    have hQdet : Q.det = v k := by
      have hsum : (fun l => ∑ i, v i • (1 : Matrix n n ℂ) l i) = v := by
        funext l; simp [Matrix.one_apply]
      have hds := Matrix.det_updateCol_sum (1 : Matrix n n ℂ) k v
      rw [hsum] at hds
      rw [hQ_def, hds, Matrix.det_one, smul_eq_mul, mul_one]
    have hQ_unit : IsUnit Q :=
      (Matrix.isUnit_iff_isUnit_det Q).mpr (isUnit_iff_ne_zero.mpr (by rw [hQdet]; exact hk))
    have hAQcol : ∀ i, (A * Q) i k = 0 := by
      intro i
      have hsum : (∑ l, A i l * v l) = 0 := congrFun hAv i
      rw [Matrix.mul_apply]
      rw [show (∑ l, A i l * Q l k) = ∑ l, A i l * v l from
        Finset.sum_congr rfl fun l _ => by rw [hQ_def, Matrix.updateCol_self]]
      exact hsum
    have hfAQ : f (A * Q) = 0 := hf_zero_col (A * Q) k hAQcol
    have hfQ : f Q ≠ 0 := (hQ_unit.map f).ne_zero
    have hzero : f A * f Q = 0 := by rw [← map_mul]; exact hfAQ
    rw [hdet0]
    exact (mul_eq_zero.mp hzero).resolve_right hfQ

/-- The bundled form of `monoidHom_eq_det_of_scalar_pow`: such an `f` *is* `Matrix.detMonoidHom`. -/
theorem eq_detMonoidHom_of_scalar_pow [Nonempty n]
    (f : Matrix n n ℂ →* ℂ) (i0 : n)
    (h : ∀ x : ℂˣ, f (Matrix.diagonal fun _ => (x : ℂ)) = (x : ℂ) ^ Fintype.card n) :
    f = Matrix.detMonoidHom :=
  MonoidHom.ext (monoidHom_eq_det_of_scalar_pow f i0 h)

/--
**Existence *and* uniqueness — a definition-grade characterization.** Over `ℂ` there is a *unique*
monoid homomorphism `f : Mₙ(ℂ) →* ℂ` satisfying the scalar normalization `f(λI) = λⁿ`. Existence is
witnessed by the determinant (`Matrix.detMonoidHom`); uniqueness is
`monoidHom_eq_det_of_scalar_pow`. This `∃!` is exactly what licenses an *axiomatic definition* of
the determinant on `ℂ`: "the determinant is the unique multiplicative map on matrices sending `λI`
to `λⁿ`." -/
theorem existsUnique_monoidHom_scalar_pow [Nonempty n] :
    ∃! f : Matrix n n ℂ →* ℂ,
      ∀ x : ℂˣ, f (Matrix.diagonal fun _ => (x : ℂ)) = (x : ℂ) ^ Fintype.card n := by
  refine ⟨Matrix.detMonoidHom, fun x => ?_, fun g hg => ?_⟩
  · change (Matrix.diagonal fun _ => (x : ℂ)).det = (x : ℂ) ^ Fintype.card n
    rw [Matrix.det_diagonal]
    simp [Finset.prod_const, Finset.card_univ]
  · exact eq_detMonoidHom_of_scalar_pow g (Classical.arbitrary n) hg

/--
The determinant on `ℂ`, *defined* purely by its characterization: the unique monoid homomorphism
`Mₙ(ℂ) →* ℂ` sending `λI` to `λⁿ`, with no reference to any determinant formula. (Its
well-definedness rests on the existence half of `existsUnique_monoidHom_scalar_pow`, witnessed by
the Leibniz determinant — one cannot escape constructing *some* determinant to supply existence.) -/
def detByScalarPow [Nonempty n] : Matrix n n ℂ →* ℂ :=
  existsUnique_monoidHom_scalar_pow.choose

/-- The characterization-defined determinant coincides with Mathlib's `Matrix.detMonoidHom`. -/
theorem detByScalarPow_eq [Nonempty n] :
    (detByScalarPow : Matrix n n ℂ →* ℂ) = Matrix.detMonoidHom :=
  eq_detMonoidHom_of_scalar_pow _ (Classical.arbitrary n)
    existsUnique_monoidHom_scalar_pow.choose_spec.1

/-- ...and hence agrees pointwise with `Matrix.det`. -/
@[simp] theorem detByScalarPow_apply [Nonempty n] (A : Matrix n n ℂ) :
    detByScalarPow A = A.det := by
  rw [detByScalarPow_eq]; rfl

end MathNotesLean
