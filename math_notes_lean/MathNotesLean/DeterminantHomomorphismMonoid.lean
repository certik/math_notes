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
    (h : ∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n)
    (A : Matrix n n ℂ) : f A = A.det := by
  -- (i) On units, `f = det` via the flow result applied to `Units.map f : GLₙ(ℂ) →* ℂˣ`.
  have hf_unit : ∀ U : (Matrix n n ℂ)ˣ, f (U : Matrix n n ℂ) = (U : Matrix n n ℂ).det := by
    have hg : ∀ x : ℂˣ, (Units.map f) (Flow.scalarGL x) = x ^ Fintype.card n := by
      intro x
      apply Units.ext
      rw [Units.coe_map, Flow.coe_scalarGL, ← Matrix.smul_one_eq_diagonal, ← Units.smul_def,
        h x, Units.val_pow_eq_pow_val]
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
    (h : ∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n) :
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
      ∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n := by
  refine ⟨Matrix.detMonoidHom, fun x => ?_, fun g hg => ?_⟩
  · change ((x : ℂ) • (1 : Matrix n n ℂ)).det = (x : ℂ) ^ Fintype.card n
    rw [Matrix.det_smul, Matrix.det_one, mul_one]
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

/-! ### Capstone: the determinant is the unique (H1)+(H2) function, with `L` as witness

We restate everything over **bare** functions `f : Mₙ(ℂ) → ℂ`, with the two defining properties
written out explicitly — and no `Classical.choice`:

* **(H1)** `f (A * B) = f A * f B` for *all* matrices `A, B` (singular included);
* **(H2)** `f (λ • I) = λⁿ` (the scalar matrix `λ • 1`).

Existence is witnessed by the explicit Leibniz polynomial `Flow.L` (a concrete finite sum, defined
from scratch in the flow file); uniqueness shows every such `f` equals `Flow.L`. This certifies,
beyond any doubt, that the determinant can be *defined* by (H1) and (H2). -/

/-- **(H1) holds for `L`, on all matrices**: `L (A * B) = L A · L B` (via `L = det` and
`Matrix.det_mul`; the flow file proves multiplicativity from scratch on `GLₙ`). -/
theorem leibniz_mul (A B : Matrix n n ℂ) : Flow.L (A * B) = Flow.L A * Flow.L B := by
  simp only [L_eq_det, Matrix.det_mul]

/-- **(H2) holds for `L`**: `L (λ • I) = λⁿ`. -/
theorem leibniz_scalar (x : ℂˣ) :
    Flow.L (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n := by
  rw [Units.smul_def, Matrix.smul_one_eq_diagonal, Flow.L_diagonal]
  simp [Finset.prod_const, Finset.card_univ]

/--
**Uniqueness.** Any bare function `f : Mₙ(ℂ) → ℂ` satisfying (H1) and (H2) equals the Leibniz
polynomial `L`. (We bundle `f` into a `MonoidHom` — `f 1 = 1` is (H2) at `λ = 1` — and invoke
`monoidHom_eq_det_of_scalar_pow`, then `L = det`.) -/
theorem eq_leibniz_of_mul_of_scalar_pow [Nonempty n]
    (f : Matrix n n ℂ → ℂ)
    (H1 : ∀ A B, f (A * B) = f A * f B)
    (H2 : ∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n)
    (A : Matrix n n ℂ) : f A = Flow.L A := by
  have hf1 : f 1 = 1 := by
    have h := H2 1
    simp only [Units.val_one, one_pow, one_smul] at h
    exact h
  let fHom : Matrix n n ℂ →* ℂ := { toFun := f, map_one' := hf1, map_mul' := H1 }
  have hdet := monoidHom_eq_det_of_scalar_pow fHom (Classical.arbitrary n) H2 A
  rw [L_eq_det]
  exact hdet

/-- Concretely, the uniqueness as the user phrased it: any two functions satisfying (H1) and (H2)
are equal — because each one equals `L`. -/
theorem eq_of_mul_of_scalar_pow [Nonempty n] (f g : Matrix n n ℂ → ℂ)
    (Hf1 : ∀ A B, f (A * B) = f A * f B)
    (Hf2 : ∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n)
    (Hg1 : ∀ A B, g (A * B) = g A * g B)
    (Hg2 : ∀ x : ℂˣ, g (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n) :
    f = g := by
  funext A
  rw [eq_leibniz_of_mul_of_scalar_pow f Hf1 Hf2 A, eq_leibniz_of_mul_of_scalar_pow g Hg1 Hg2 A]

/--
**The determinant defined by (H1) and (H2).** There is a *unique* bare function `f : Mₙ(ℂ) → ℂ`
satisfying (H1) `f(AB) = f(A)f(B)` (all matrices) and (H2) `f(λI) = λⁿ`, and it is the explicit
Leibniz polynomial `Flow.L`. Existence is the concrete formula `L` (no `Classical.choice`),
uniqueness pins every such `f` to it — so this `∃!` *is* a definition of the determinant by its two
multiplicative axioms. -/
theorem leibniz_det_characterization [Nonempty n] :
    ∃! f : Matrix n n ℂ → ℂ,
      (∀ A B, f (A * B) = f A * f B) ∧
        (∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n) := by
  refine ⟨Flow.L, ⟨leibniz_mul, leibniz_scalar⟩, ?_⟩
  rintro g ⟨hg1, hg2⟩
  funext A
  exact eq_leibniz_of_mul_of_scalar_pow g hg1 hg2 A

/--
**The fully explicit form: every (H1)+(H2) function `f` satisfies `f A = L A`.** Both halves are
spelled out with `L` named throughout:

* *existence* — the Leibniz polynomial `L` itself satisfies (H1) `L(AB) = L(A)L(B)` and (H2)
  `L(λI) = λⁿ`;
* *uniqueness* — for **any** `f : Mₙ(ℂ) → ℂ` with (H1) and (H2), and **every** matrix `A`,
  `f A = L A`.

Reading the third clause at `f := L` recovers existence, so this single statement says exactly:
"the unique multiplicative, `λI ↦ λⁿ` function is `L`, pointwise." -/
theorem mul_scalar_pow_characterizes_leibniz [Nonempty n] :
    (∀ A B : Matrix n n ℂ, Flow.L (A * B) = Flow.L A * Flow.L B) ∧
    (∀ x : ℂˣ, Flow.L (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n) ∧
    (∀ f : Matrix n n ℂ → ℂ,
      (∀ A B, f (A * B) = f A * f B) →
      (∀ x : ℂˣ, f (x • (1 : Matrix n n ℂ)) = x ^ Fintype.card n) →
      ∀ A, f A = Flow.L A) :=
  ⟨leibniz_mul, leibniz_scalar, eq_leibniz_of_mul_of_scalar_pow⟩

/-! ### `Fin n` corollaries: the exponent is literally `n`

For the standard `n × n` matrices indexed by `Fin n` — with `n : ℕ` a genuine number — the dimension
`Fintype.card (Fin n)` *is* `n` (`Fintype.card_fin`), so the scalar normalization reads exactly
`f(λ • I) = λⁿ` with the literal exponent `n`. These are direct specializations of the general
results above, self-contained in `n : ℕ` (the abstract index type is replaced by `Fin n`, and
`[NeZero n]`, i.e. `n ≥ 1`, supplies `Nonempty (Fin n)`). -/

section Fin

variable {n : ℕ} [NeZero n]

/--
**(H1) + (H2) ⇒ `f = det` on `Fin n` matrices**, with the scalar normalization written `f(λ•I) = λⁿ`
using the literal exponent `n`. A bare function `f : Mₙ(ℂ) → ℂ` (no bundling) that is multiplicative
on all matrices and sends `λ • I` to `λⁿ` is the determinant. -/
theorem eq_det_of_mul_of_scalar_pow_fin
    (f : Matrix (Fin n) (Fin n) ℂ → ℂ)
    (H1 : ∀ A B, f (A * B) = f A * f B)
    (H2 : ∀ x : ℂˣ, f (x • (1 : Matrix (Fin n) (Fin n) ℂ)) = x ^ n)
    (A : Matrix (Fin n) (Fin n) ℂ) : f A = A.det := by
  have H2' : ∀ x : ℂˣ, f (x • (1 : Matrix (Fin n) (Fin n) ℂ)) = x ^ Fintype.card (Fin n) := by
    simpa [Fintype.card_fin] using H2
  rw [← L_eq_det]
  exact eq_leibniz_of_mul_of_scalar_pow f H1 H2' A

/--
**The determinant on `Fin n` matrices, defined by (H1) and (H2).** There is a *unique* bare function
`f : Matrix (Fin n) (Fin n) ℂ → ℂ` satisfying (H1) `f(AB) = f(A)f(B)` (all matrices) and (H2)
`f(λ•I) = λⁿ`, and it is `Matrix.det`. This is the note's characterization stated for ordinary
`n × n` matrices, with the exponent the literal dimension `n`. -/
theorem det_characterization_fin :
    ∃! f : Matrix (Fin n) (Fin n) ℂ → ℂ,
      (∀ A B, f (A * B) = f A * f B) ∧
        (∀ x : ℂˣ, f (x • (1 : Matrix (Fin n) (Fin n) ℂ)) = x ^ n) := by
  refine ⟨Matrix.det, ⟨fun A B => Matrix.det_mul A B, fun x => ?_⟩, ?_⟩
  · rw [Units.smul_def, Matrix.det_smul, Matrix.det_one, mul_one, Fintype.card_fin]
  · rintro g ⟨hg1, hg2⟩
    funext A
    exact eq_det_of_mul_of_scalar_pow_fin g hg1 hg2 A

end Fin

end MathNotesLean
