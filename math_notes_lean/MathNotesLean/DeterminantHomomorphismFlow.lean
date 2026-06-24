/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.CstarHomomorphismFlow

/-!
# Determinant from homomorphism — flow-faithful, self-contained determinant

This file formalizes `determinant_homomorphism.md` following the **note's own logical development**,
and goes one step further than `DeterminantHomomorphism.lean`: it does **not use `Matrix.det` at
all**. We define our *own* Leibniz polynomial `L` and prove every determinant fact we need directly
from the sum, so the development cites **no Mathlib determinant lemma whatsoever** — not `det_mul`,
not even `det_apply`. This certifies that the note's argument is genuinely non-circular: the
determinant and its multiplicativity are constructed and proved here from scratch.

(Note: `Matrix.det` is *defined* in `Determinant.Basic`, which is still transitively imported via
`Transvection.lean` / `Reindex.lean` — no Mathlib transvection/Gaussian-elimination API avoids it.
But that is only a build-graph fact: our logic never references `Matrix.det` or any
determinant lemma. Confirm with `grep "Matrix.det" `: every hit is in a comment.)

## What we prove ourselves about `L`

* `L_one`, `L_diagonal` — the note's identity (a): `L I = 1`, `L (diag d) = ∏ dᵢ` (only `σ = id`
  survives), from the Leibniz sum;
* `L_eq_zero_of_row_eq` — the note's (b) **alternating**: two equal rows ⇒ `L = 0`, via the
  `σ ↦ σ ∘ (i₀ j₀)` involution;
* `L_updateRow_expand` / `L_updateRow_add_smul_self` — (c) **multilinearity** in a row plus the row
  operation `rowᵢ ← rowᵢ + c·rowⱼ` leaving `L` fixed;
* `L_transvection_mul` — `L (Tᵢⱼ(c)·M) = L M`; and from it `L_factorization : L(E·D) = ∏ dᵢ` and
  (Step 4) `detUnit_mul : L(AB) = L A · L B`.

## Mathlib facts used (linear algebra only, **no determinant lemmas**)

Basic matrix/permutation/`Finset` algebra (`Matrix.transvection`, `updateRow`, `diagonal`,
`Equiv.Perm.sign`, `Equiv.swap`, `Finset.sum_involution`, `Equiv.prod_comp`, …); the
`GLₙ`/`SLₙ`/swap-matrix wrappers; `Matrix.isUnit_diagonal` (to get `dᵢ ≠ 0` from invertibility,
*without* `isUnit_iff_isUnit_det`); and the Gaussian-elimination generation lemma
`Matrix.Pivot.exists_list_transvec_mul_diagonal_mul_list_transvec` (the note's Step 1).
-/

noncomputable section

namespace MathNotesLean

namespace Flow

open Matrix

open CstarFlow

section GeneralLinear

variable {n : Type*} [DecidableEq n] [Fintype n]

/-- An invertible diagonal matrix as an element of `GLₙ(ℂ)`. -/
def diagonalGL (d : n → ℂ) (hd : ∀ i, d i ≠ 0) : Matrix.GeneralLinearGroup n ℂ where
  val := Matrix.diagonal d
  inv := Matrix.diagonal fun i => (d i)⁻¹
  val_inv := by
    rw [Matrix.diagonal_mul_diagonal]
    ext i j
    by_cases hij : i = j
    · subst j
      simp [Matrix.diagonal, hd]
    · simp [Matrix.diagonal, hij]
  inv_val := by
    rw [Matrix.diagonal_mul_diagonal]
    ext i j
    by_cases hij : i = j
    · subst j
      simp [Matrix.diagonal, hd]
    · simp [Matrix.diagonal, hij]

@[simp]
theorem coe_diagonalGL (d : n → ℂ) (hd : ∀ i, d i ≠ 0) :
    ((diagonalGL d hd : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ) = Matrix.diagonal d :=
  rfl

/-- Diagonal `GLₙ(ℂ)` matrix with `x` in one chosen slot and `1` elsewhere. -/
def oneSlotDiagonalGL (i0 : n) (x : ℂˣ) : Matrix.GeneralLinearGroup n ℂ :=
  diagonalGL (fun i => if i = i0 then (x : ℂ) else 1) (by
    intro i
    by_cases hi : i = i0
    · simp [hi, x.ne_zero]
    · simp [hi])

/-- Multiplication of one-slot diagonal matrices follows multiplication in the chosen slot. -/
theorem oneSlotDiagonalGL_mul (i0 : n) (x y : ℂˣ) :
    oneSlotDiagonalGL i0 (x * y) = oneSlotDiagonalGL i0 x * oneSlotDiagonalGL i0 y := by
  apply Units.ext
  change Matrix.diagonal (fun i => if i = i0 then ((x * y : ℂˣ) : ℂ) else 1) =
    Matrix.diagonal (fun i => if i = i0 then (x : ℂ) else 1) *
      Matrix.diagonal (fun i => if i = i0 then (y : ℂ) else 1)
  rw [Matrix.diagonal_mul_diagonal]
  ext i j
  by_cases hij : i = j
  · subst j
    by_cases hi : i = i0 <;> simp [Matrix.diagonal, hi]
  · by_cases hi : i = i0 <;> by_cases hj : j = i0 <;> simp [Matrix.diagonal, hij, hi, hj]

@[simp]
theorem oneSlotDiagonalGL_one (i0 : n) : oneSlotDiagonalGL i0 1 = 1 := by
  ext i j
  simp [oneSlotDiagonalGL, diagonalGL]

/-- The one-variable factor read off from a homomorphism on one diagonal slot. -/
def diagonalFactorOfHom (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) : ℂˣ →* ℂˣ where
  toFun x := f (oneSlotDiagonalGL i0 x)
  map_one' := by simp
  map_mul' x y := by rw [oneSlotDiagonalGL_mul i0 x y, map_mul]

-- ANCHOR: flow-dethom-conjugation
/-- **Step 1 (`f(I) = 1`).** A homomorphism `GLₙ(ℂ) → ℂˣ` sends the identity matrix to `1`. -/
theorem hom_one_eq_one (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) : f 1 = 1 :=
  map_one f

/--
**Step 1 (conjugation invariance).** A homomorphism `GLₙ(ℂ) → ℂˣ` is invariant under conjugation,
because its target `ℂˣ` is commutative: `f (P A P⁻¹) = f A`.
-/
theorem hom_conj_eq (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (P A : Matrix.GeneralLinearGroup n ℂ) : f (P * A * P⁻¹) = f A := by
  rw [map_mul, map_mul, map_inv, mul_comm (f P) (f A), mul_assoc, mul_inv_cancel, mul_one]
-- ANCHOR_END: flow-dethom-conjugation

/-- A transvection `I + c Eᵢⱼ` (with `i ≠ j`) as an element of `GLₙ(ℂ)`. -/
def transvectionGL {i j : n} (hij : i ≠ j) (c : ℂ) : Matrix.GeneralLinearGroup n ℂ :=
  Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij c)

@[simp]
theorem coe_transvectionGL {i j : n} (hij : i ≠ j) (c : ℂ) :
    ((transvectionGL hij c : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.transvection i j c := by
  rw [transvectionGL]
  rfl

-- ANCHOR: flow-dethom-diag-conj
/--
**Step 2 (diagonal conjugation).** Conjugating a transvection by an invertible diagonal matrix
rescales the off-diagonal entry: `D Tᵢⱼ(c) D⁻¹ = Tᵢⱼ((dᵢ/dⱼ) c)`.
-/
theorem diagonal_conj_transvection (d : n → ℂ) (hd : ∀ k, d k ≠ 0) {i j : n} (hij : i ≠ j)
    (c : ℂ) :
    Matrix.diagonal d * Matrix.transvection i j c * Matrix.diagonal (fun k => (d k)⁻¹)
      = Matrix.transvection i j (d i * (d j)⁻¹ * c) := by
  ext k l
  rw [Matrix.mul_diagonal, Matrix.diagonal_mul]
  simp only [Matrix.transvection, Matrix.add_apply, Matrix.one_apply, Matrix.single_apply]
  by_cases h1 : k = l
  · by_cases h2 : i = k ∧ j = l
    · exact absurd (h2.1.trans (h1.trans h2.2.symm)) hij
    · simp only [if_pos h1, if_neg h2, add_zero, mul_one]
      rw [h1]; exact mul_inv_cancel₀ (hd l)
  · by_cases h2 : i = k ∧ j = l
    · simp only [if_neg h1, if_pos h2, zero_add]
      obtain ⟨rfl, rfl⟩ := h2
      ring
    · simp only [if_neg h1, if_neg h2, mul_zero, zero_mul, add_zero]
-- ANCHOR_END: flow-dethom-diag-conj

@[simp]
theorem coe_diagonalGL_inv (d : n → ℂ) (hd : ∀ i, d i ≠ 0) :
    (((diagonalGL d hd)⁻¹ : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.diagonal (fun i => (d i)⁻¹) :=
  rfl

-- ANCHOR: flow-dethom-transvection-value
/--
**Step 2 (transvections have trivial image).** Any homomorphism `GLₙ(ℂ) → ℂˣ` sends every
transvection to `1`. Conjugating `Tᵢⱼ(c)` by `diag(2 at i, 1 else)` doubles the parameter
(`D Tᵢⱼ(c) D⁻¹ = Tᵢⱼ(2c) = Tᵢⱼ(c)²`), so by conjugation invariance `f(Tᵢⱼ(c))² = f(Tᵢⱼ(c))`, and a
value of `ℂˣ` with `t² = t` is `1`.
-/
theorem hom_transvection_eq_one (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) {i j : n} (hij : i ≠ j)
    (c : ℂ) : f (transvectionGL hij c) = 1 := by
  set d : n → ℂ := fun k => if k = i then 2 else 1 with hd_def
  have hd : ∀ k, d k ≠ 0 := fun k => by by_cases hk : k = i <;> simp [hd_def, hk]
  have hdi : d i = 2 := by simp [hd_def]
  have hdj : d j = 1 := by simp only [hd_def]; rw [if_neg (Ne.symm hij)]
  have hadd : transvectionGL hij (c + c) = transvectionGL hij c * transvectionGL hij c := by
    change Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij (c + c))
      = Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij c)
        * Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij c)
    rw [Matrix.SpecialLinearGroup.transvection_add, map_mul]
  have hconj : diagonalGL d hd * transvectionGL hij c * (diagonalGL d hd)⁻¹
      = transvectionGL hij (c + c) := by
    apply Units.ext
    simp only [Units.val_mul, coe_diagonalGL, coe_transvectionGL, coe_diagonalGL_inv]
    rw [diagonal_conj_transvection d hd hij c, hdi, hdj]
    congr 1
    rw [inv_one, mul_one]
    ring
  have ht2 : f (transvectionGL hij c) * f (transvectionGL hij c) = f (transvectionGL hij c) := by
    rw [← map_mul, ← hadd, ← hconj, hom_conj_eq]
  have ht1 : f (transvectionGL hij c) * f (transvectionGL hij c)
      = f (transvectionGL hij c) * 1 := by rw [mul_one]; exact ht2
  exact mul_left_cancel ht1
-- ANCHOR_END: flow-dethom-transvection-value

/-- The underlying matrix of a one-slot diagonal `GLₙ(ℂ)` element. -/
@[simp]
theorem coe_oneSlotDiagonalGL (i0 : n) (x : ℂˣ) :
    ((oneSlotDiagonalGL i0 x : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.diagonal (fun k => if k = i0 then (x : ℂ) else 1) :=
  rfl

/-- Conjugating a diagonal matrix by a swap matrix permutes its diagonal entries. -/
theorem swap_conj_diagonal (d : n → ℂ) (i0 i : n) :
    Matrix.swap ℂ i0 i * Matrix.diagonal d * Matrix.swap ℂ i0 i
      = Matrix.diagonal (fun k => d (Equiv.swap i0 i k)) := by
  change (Equiv.swap i0 i).toPEquiv.toMatrix * Matrix.diagonal d
      * (Equiv.swap i0 i).toPEquiv.toMatrix = _
  rw [PEquiv.toMatrix_toPEquiv_mul, PEquiv.mul_toMatrix_toPEquiv,
    Matrix.submatrix_submatrix, Function.comp_id, Function.id_comp,
    Equiv.symm_swap, Matrix.submatrix_diagonal_equiv]
  rfl

/--
**Step 3 (position invariance).** The value of a homomorphism `f` on a one-slot diagonal matrix
does not depend on which slot carries the entry: `f(oneSlotDiagonalGL i x) = f(oneSlotDiagonalGL i0
x)`. The swap matrix `Pᵢ` conjugates one to the other, and `f` is conjugation invariant.
-/
theorem hom_oneSlotDiagonalGL_pos_invariant (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (i0 i : n) (x : ℂˣ) :
    f (oneSlotDiagonalGL i x) = f (oneSlotDiagonalGL i0 x) := by
  have key : Matrix.GeneralLinearGroup.swap ℂ i0 i * oneSlotDiagonalGL i0 x
      * (Matrix.GeneralLinearGroup.swap ℂ i0 i)⁻¹ = oneSlotDiagonalGL i x := by
    apply Units.ext
    have hv : ((Matrix.GeneralLinearGroup.swap ℂ i0 i : Matrix.GeneralLinearGroup n ℂ)
        : Matrix n n ℂ) = Matrix.swap ℂ i0 i := rfl
    have hi : (((Matrix.GeneralLinearGroup.swap ℂ i0 i)⁻¹ : Matrix.GeneralLinearGroup n ℂ)
        : Matrix n n ℂ) = Matrix.swap ℂ i0 i := rfl
    simp only [Units.val_mul, coe_oneSlotDiagonalGL, hv, hi]
    rw [swap_conj_diagonal]
    congr 1
    funext k
    by_cases hk : k = i
    · subst hk
      simp [Equiv.swap_apply_right]
    · have hne : Equiv.swap i0 i k ≠ i0 := by
        intro h
        exact hk ((Equiv.swap i0 i).injective (by rw [h, Equiv.swap_apply_right]))
      simp [hk, hne]
  rw [← key, hom_conj_eq]

/-- The diagonal `GLₙ(ℂ)` matrix carrying the entries of `D` on the slots in `s`, and `1`
elsewhere. -/
def diagOnGL (D : n → ℂ) (hD : ∀ i, D i ≠ 0) (s : Finset n) :
    Matrix.GeneralLinearGroup n ℂ :=
  diagonalGL (fun j => if j ∈ s then D j else 1) (fun j => by
    by_cases h : j ∈ s <;> simp [h, hD j])

@[simp]
theorem coe_diagOnGL (D : n → ℂ) (hD : ∀ i, D i ≠ 0) (s : Finset n) :
    ((diagOnGL D hD s : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.diagonal (fun j => if j ∈ s then D j else 1) :=
  rfl

@[simp]
theorem diagOnGL_univ (D : n → ℂ) (hD : ∀ i, D i ≠ 0) :
    diagOnGL D hD Finset.univ = diagonalGL D hD := by
  apply Units.ext
  simp [coe_diagOnGL, coe_diagonalGL]

theorem diagOnGL_empty (D : n → ℂ) (hD : ∀ i, D i ≠ 0) : diagOnGL D hD ∅ = 1 := by
  apply Units.ext
  simp [coe_diagOnGL]

/-- Inserting a slot multiplies in the corresponding one-slot diagonal factor. -/
theorem diagOnGL_insert (D : n → ℂ) (hD : ∀ i, D i ≠ 0) {a : n} {s : Finset n} (ha : a ∉ s) :
    diagOnGL D hD (insert a s)
      = oneSlotDiagonalGL a (Units.mk0 (D a) (hD a)) * diagOnGL D hD s := by
  apply Units.ext
  rw [Units.val_mul, coe_oneSlotDiagonalGL, coe_diagOnGL, coe_diagOnGL,
    Matrix.diagonal_mul_diagonal]
  congr 1
  funext j
  simp only [Units.val_mk0, Finset.mem_insert]
  by_cases hja : j = a
  · subst hja
    simp [ha]
  · by_cases hjs : j ∈ s <;> simp [hja, hjs]

/--
**Step 3 (product over the diagonal, finset form).** A homomorphism `f` evaluated on the diagonal
matrix supported on the slots `s` is the product over `s` of the one-slot factor
`g = diagonalFactorOfHom i0 f`.
-/
theorem hom_diagOnGL_eq (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (D : n → ℂ) (hD : ∀ i, D i ≠ 0) (s : Finset n) :
    f (diagOnGL D hD s)
      = ∏ j ∈ s, diagonalFactorOfHom i0 f (Units.mk0 (D j) (hD j)) := by
  refine Finset.induction_on s ?_ (fun a s ha ih => ?_)
  · rw [diagOnGL_empty, map_one, Finset.prod_empty]
  · rw [diagOnGL_insert D hD ha, map_mul, Finset.prod_insert ha, ih]
    congr 1
    rw [hom_oneSlotDiagonalGL_pos_invariant f i0 a (Units.mk0 (D a) (hD a))]
    rfl

-- ANCHOR: flow-dethom-diagonal-product
/--
**Step 3 (product over the diagonal).** Evaluating a homomorphism `f` on a diagonal matrix gives the
product over the slots of the single-slot factor `g = diagonalFactorOfHom i0 f`, equivalently `g`
applied to the product of the diagonal entries: `f(diag D) = ∏ⱼ g(Dⱼ) = g(∏ⱼ Dⱼ)`.
-/
theorem hom_diagonalGL_eq (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (D : n → ℂ) (hD : ∀ i, D i ≠ 0) :
    f (diagonalGL D hD)
      = diagonalFactorOfHom i0 f (∏ j : n, Units.mk0 (D j) (hD j)) := by
  rw [← diagOnGL_univ D hD, hom_diagOnGL_eq f i0 D hD Finset.univ,
    ← map_prod (diagonalFactorOfHom i0 f)]
-- ANCHOR_END: flow-dethom-diagonal-product

/-- A `TransvectionStruct` as an element of `GLₙ(ℂ)`. -/
def transvecStructGL (t : Matrix.TransvectionStruct n ℂ) : Matrix.GeneralLinearGroup n ℂ :=
  transvectionGL t.hij t.c

@[simp]
theorem coe_transvecStructGL (t : Matrix.TransvectionStruct n ℂ) :
    ((transvecStructGL t : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ) = t.toMatrix := by
  rw [transvecStructGL, coe_transvectionGL]
  rfl

theorem hom_transvecStructGL_eq_one (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (t : Matrix.TransvectionStruct n ℂ) : f (transvecStructGL t) = 1 :=
  hom_transvection_eq_one f t.hij t.c

/-- The underlying matrix of a `GLₙ(ℂ)` product of transvections is the product of the transvection
matrices. -/
theorem coe_prod_transvecStructGL (L : List (Matrix.TransvectionStruct n ℂ)) :
    (((L.map transvecStructGL).prod : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = (L.map Matrix.TransvectionStruct.toMatrix).prod := by
  induction L with
  | nil => simp
  | cons t L ih =>
    simp only [List.map_cons, List.prod_cons, Units.val_mul, coe_transvecStructGL, ih]

/-- A homomorphism `f : GLₙ(ℂ) → ℂˣ` kills every product of transvections. -/
theorem hom_prod_transvecStructGL_eq_one (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (L : List (Matrix.TransvectionStruct n ℂ)) : f (L.map transvecStructGL).prod = 1 := by
  induction L with
  | nil => simp
  | cons t L ih =>
    simp only [List.map_cons, List.prod_cons, map_mul, hom_transvecStructGL_eq_one, ih, one_mul]

/-- The transvection obtained by conjugating `t` by an invertible diagonal `D`: it has the same
positions `i, j` and the rescaled parameter `(dᵢ/dⱼ) · c`. -/
def conjDiagStruct (D : n → ℂ) (t : Matrix.TransvectionStruct n ℂ) :
    Matrix.TransvectionStruct n ℂ :=
  ⟨t.i, t.j, t.hij, D t.i * (D t.j)⁻¹ * t.c⟩

/-- Conjugating a transvection (as a `GLₙ(ℂ)` element) by an invertible diagonal yields the
conjugated transvection. -/
theorem conjGL_transvecStructGL (D : n → ℂ) (hD : ∀ i, D i ≠ 0)
    (t : Matrix.TransvectionStruct n ℂ) :
    diagonalGL D hD * transvecStructGL t * (diagonalGL D hD)⁻¹
      = transvecStructGL (conjDiagStruct D t) := by
  apply Units.ext
  rw [Units.val_mul, Units.val_mul, coe_diagonalGL, coe_transvecStructGL, coe_diagonalGL_inv,
    coe_transvecStructGL]
  simp only [Matrix.TransvectionStruct.toMatrix, conjDiagStruct]
  rw [diagonal_conj_transvection D hD t.hij t.c]

/-- Conjugating a product of transvections by an invertible diagonal conjugates it term by term. -/
theorem conjGL_prod (D : n → ℂ) (hD : ∀ i, D i ≠ 0)
    (L : List (Matrix.TransvectionStruct n ℂ)) :
    diagonalGL D hD * (L.map transvecStructGL).prod * (diagonalGL D hD)⁻¹
      = ((L.map (conjDiagStruct D)).map transvecStructGL).prod := by
  induction L with
  | nil => simp
  | cons t L ih =>
    rw [List.map_cons, List.prod_cons, List.map_cons, List.map_cons, List.prod_cons,
      ← conjGL_transvecStructGL D hD t, ← ih]
    group

-- ANCHOR: flow-dethom-g-hom
/--
`eq-dethom-g-homomorphism`. The one-variable factor `g = diagonalFactorOfHom i0 f` is a
homomorphism `ℂˣ → ℂˣ`: `g(xy) = g(x) g(y)`.
-/
theorem diagonalFactorOfHom_mul (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (x y : ℂˣ) :
    diagonalFactorOfHom i0 f (x * y)
      = diagonalFactorOfHom i0 f x * diagonalFactorOfHom i0 f y :=
  map_mul _ x y
-- ANCHOR_END: flow-dethom-g-hom

-- ANCHOR: flow-dethom-diagonal-slot
/--
`eq-dethom-diagonal-slot`. The value of `f` on a single populated diagonal slot is exactly the
one-variable factor `g`: `f(diag(1,…,x at i,…,1)) = g(x)`.
-/
theorem hom_oneSlotDiagonalGL_eq_g (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 i : n) (x : ℂˣ) :
    f (oneSlotDiagonalGL i x) = diagonalFactorOfHom i0 f x :=
  hom_oneSlotDiagonalGL_pos_invariant f i0 i x
-- ANCHOR_END: flow-dethom-diagonal-slot

/-! ### Our own Leibniz determinant `L`

To make the determinant side **fully self-contained**, we define our own Leibniz polynomial `L` and
prove its needed properties directly from the sum — citing *no* Mathlib determinant lemma (not even
`det_apply`). The note's identity (a), the alternating property (b), multilinearity (c), and the
row-operation invariance are all re-derived here. `Matrix.det` is never used. -/

/-- The Leibniz determinant, defined by us as `∑_σ sgn(σ) ∏ᵢ Aᵢ,σ(i)`. -/
def L (A : Matrix n n ℂ) : ℂ :=
  ∑ σ : Equiv.Perm n, ((Equiv.Perm.sign σ : ℤ) : ℂ) * ∏ i, A i (σ i)

-- ANCHOR: flow-dethom-leibniz-formula
/-- `L` is, by definition, the Leibniz polynomial in the note's index convention `Aᵢ,σ(i)`. -/
theorem determinant_leibniz_formula (A : Matrix n n ℂ) :
    L A = ∑ σ : Equiv.Perm n, ((Equiv.Perm.sign σ : ℤ) : ℂ) * ∏ i, A i (σ i) :=
  rfl
-- ANCHOR_END: flow-dethom-leibniz-formula

omit [DecidableEq n] [Fintype n] in
/-- A permutation that is not the identity moves some point. -/
theorem exists_ne_of_ne_one {σ : Equiv.Perm n} (h : σ ≠ 1) : ∃ x, σ x ≠ x := by
  by_contra hc
  simp only [not_exists, not_not] at hc
  exact h (Equiv.ext hc)

/-- `eq-dethom`-(a): `L I = 1` (only the identity permutation survives). -/
theorem L_one : L (1 : Matrix n n ℂ) = 1 := by
  rw [L, Finset.sum_eq_single (1 : Equiv.Perm n)]
  · have hp : (∏ i, (1 : Matrix n n ℂ) i ((1 : Equiv.Perm n) i)) = 1 :=
      Finset.prod_eq_one (fun i _ => Matrix.one_apply_eq i)
    rw [hp]; simp
  · intro σ _ hσ
    obtain ⟨x, hx⟩ := exists_ne_of_ne_one hσ
    rw [Finset.prod_eq_zero (Finset.mem_univ x) (by rw [Matrix.one_apply, if_neg (Ne.symm hx)]),
      mul_zero]
  · intro h; exact absurd (Finset.mem_univ _) h

/-- `eq-dethom`-(a): `L (diag d) = ∏ᵢ dᵢ` (only the identity permutation survives). -/
theorem L_diagonal (d : n → ℂ) : L (Matrix.diagonal d) = ∏ i, d i := by
  rw [L, Finset.sum_eq_single (1 : Equiv.Perm n)]
  · have hp : (∏ i, (Matrix.diagonal d) i ((1 : Equiv.Perm n) i)) = ∏ i, d i :=
      Finset.prod_congr rfl (fun i _ => Matrix.diagonal_apply_eq d i)
    rw [hp]; simp
  · intro σ _ hσ
    obtain ⟨x, hx⟩ := exists_ne_of_ne_one hσ
    rw [Finset.prod_eq_zero (Finset.mem_univ x)
      (by rw [Matrix.diagonal_apply, if_neg (Ne.symm hx)]), mul_zero]
  · intro h; exact absurd (Finset.mem_univ _) h

/-- `eq-dethom`-(b) **alternating**: if two rows of `A` coincide then `L A = 0`. Proved by the
`σ ↦ σ ∘ (i₀ j₀)` pairing, where each pair of terms has equal products and opposite signs. -/
theorem L_eq_zero_of_row_eq {A : Matrix n n ℂ} {i₀ j₀ : n} (hij : i₀ ≠ j₀)
    (hrow : A i₀ = A j₀) : L A = 0 := by
  rw [L]
  apply Finset.sum_involution (fun σ _ => σ * Equiv.swap i₀ j₀)
  · intro σ _
    have hprod : ∏ i, A i ((σ * Equiv.swap i₀ j₀) i) = ∏ i, A i (σ i) := by
      have step1 : ∏ i, A i (σ (Equiv.swap i₀ j₀ i)) = ∏ i, A (Equiv.swap i₀ j₀ i) (σ i) := by
        rw [← Equiv.prod_comp (Equiv.swap i₀ j₀) (fun i => A i (σ (Equiv.swap i₀ j₀ i)))]
        exact Finset.prod_congr rfl (fun i _ => by rw [Equiv.swap_apply_self])
      change ∏ i, A i (σ (Equiv.swap i₀ j₀ i)) = ∏ i, A i (σ i)
      rw [step1]
      refine Finset.prod_congr rfl (fun i _ => ?_)
      have hA : A (Equiv.swap i₀ j₀ i) = A i := by
        rcases eq_or_ne i i₀ with hi | hi
        · subst hi; rw [Equiv.swap_apply_left]; exact hrow.symm
        · rcases eq_or_ne i j₀ with hj | hj
          · subst hj; rw [Equiv.swap_apply_right]; exact hrow
          · rw [Equiv.swap_apply_of_ne_of_ne hi hj]
      rw [hA]
    have hsign : ((Equiv.Perm.sign (σ * Equiv.swap i₀ j₀) : ℤ) : ℂ)
        = - ((Equiv.Perm.sign σ : ℤ) : ℂ) := by
      rw [map_mul, Equiv.Perm.sign_swap hij]; push_cast; ring
    rw [hsign, hprod]; ring
  · intro σ _ _ h
    have hswap : Equiv.swap i₀ j₀ = 1 := mul_left_cancel (a := σ) (by rw [h, mul_one])
    have h2 : Equiv.swap i₀ j₀ i₀ = i₀ := by rw [hswap]; rfl
    rw [Equiv.swap_apply_left] at h2
    exact hij h2.symm
  · intro σ _; exact Finset.mem_univ _
  · intro σ _; rw [mul_assoc, Equiv.swap_mul_self, mul_one]

/-- Expanding `L` along row `i`: factor out the (unique) entry in row `i`. -/
theorem L_updateRow_expand (A : Matrix n n ℂ) (i : n) (w : n → ℂ) :
    L (A.updateRow i w) = ∑ σ : Equiv.Perm n, ((Equiv.Perm.sign σ : ℤ) : ℂ) *
      (w (σ i) * ∏ k ∈ Finset.univ.erase i, A k (σ k)) := by
  rw [L]
  refine Finset.sum_congr rfl (fun σ _ => ?_)
  congr 1
  rw [← Finset.mul_prod_erase Finset.univ (fun k => (A.updateRow i w) k (σ k)) (Finset.mem_univ i),
    Matrix.updateRow_self]
  congr 1
  exact Finset.prod_congr rfl (fun k hk => by rw [Matrix.updateRow_ne (Finset.ne_of_mem_erase hk)])

/-- `eq-dethom`-(b)+(c): the row operation `rowᵢ ← rowᵢ + c·rowⱼ` (`i ≠ j`) leaves `L` unchanged.
This is multilinearity (split the row) plus the alternating property (the extra term has two equal
rows). -/
theorem L_updateRow_add_smul_self (A : Matrix n n ℂ) {i j : n} (hij : i ≠ j) (c : ℂ) :
    L (A.updateRow i (A i + c • A j)) = L A := by
  have hz : L (A.updateRow i (A j)) = 0 := by
    apply L_eq_zero_of_row_eq hij
    rw [Matrix.updateRow_self, Matrix.updateRow_ne (Ne.symm hij)]
  have hLA : L A = ∑ σ : Equiv.Perm n, ((Equiv.Perm.sign σ : ℤ) : ℂ) *
      (A i (σ i) * ∏ k ∈ Finset.univ.erase i, A k (σ k)) := by
    rw [L]
    exact Finset.sum_congr rfl (fun σ _ => by
      rw [Finset.mul_prod_erase Finset.univ (fun k => A k (σ k)) (Finset.mem_univ i)])
  rw [L_updateRow_expand]
  have key : (∑ σ : Equiv.Perm n, ((Equiv.Perm.sign σ : ℤ) : ℂ) *
        ((A i + c • A j) (σ i) * ∏ k ∈ Finset.univ.erase i, A k (σ k)))
      = L A + c * L (A.updateRow i (A j)) := by
    rw [hLA, L_updateRow_expand, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl (fun σ _ => ?_)
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    ring
  rw [key, hz, mul_zero, add_zero]

/-- **(note (b)+(c)).** Left-multiplying by a transvection (a row operation) does not change `L`:
`L(Tᵢⱼ(c) · M) = L M`. -/
theorem L_transvection_mul {i j : n} (hij : i ≠ j) (c : ℂ) (M : Matrix n n ℂ) :
    L (Matrix.transvection i j c * M) = L M := by
  have hrow : Matrix.transvection i j c * M = M.updateRow i (M i + c • M j) := by
    ext a b
    rcases eq_or_ne a i with ha | ha
    · subst ha
      rw [Matrix.transvection_mul_apply_same, Matrix.updateRow_self]
      simp [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    · rw [Matrix.updateRow_ne ha]
      simp [Matrix.transvection, Matrix.add_mul, ha]
  rw [hrow, L_updateRow_add_smul_self M hij c]


/-- `L((product of transvections) · M) = L M`, by peeling transvections one at a time. -/
theorem L_transvecList_mul (ts : List (Matrix.TransvectionStruct n ℂ)) (M : Matrix n n ℂ) :
    L ((ts.map Matrix.TransvectionStruct.toMatrix).prod * M) = L M := by
  induction ts with
  | nil => simp
  | cons t ts ih =>
    rw [List.map_cons, List.prod_cons, Matrix.mul_assoc]
    simp only [Matrix.TransvectionStruct.toMatrix]
    rw [L_transvection_mul t.hij t.c, ih]

-- ANCHOR: flow-dethom-leibniz-factorization
/-- **`eq-dethom-leibniz-factorization` (derived).** The determinant of a transvection–diagonal
factorization is the product of the diagonal entries. -/
theorem L_factorization (ts : List (Matrix.TransvectionStruct n ℂ)) (D : n → ℂ) :
    L ((ts.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal D)
      = ∏ i, D i := by
  rw [L_transvecList_mul, L_diagonal]
-- ANCHOR_END: flow-dethom-leibniz-factorization

-- ANCHOR: flow-dethom-generation
/--
`eq-dethom-transvection-diagonal-factorization`. **Generation.** Every `A ∈ GLₙ(ℂ)` factors as
`A = E · D` with `E` a product of transvections and `D` invertible diagonal. The nonvanishing of the
`dᵢ` is obtained *without* the determinant: `diagonal D` is a product of invertible matrices, hence
a unit, so its entries are units (`Matrix.isUnit_diagonal`). -/
theorem exists_transvec_diagonal_factorization (A : Matrix.GeneralLinearGroup n ℂ) :
    ∃ (E : List (Matrix.TransvectionStruct n ℂ)) (D : n → ℂ) (hD : ∀ i, D i ≠ 0),
      A = (E.map transvecStructGL).prod * diagonalGL D hD := by
  obtain ⟨L, L', D, hLDL'⟩ :=
    Matrix.Pivot.exists_list_transvec_mul_diagonal_mul_list_transvec (A : Matrix n n ℂ)
  set P := (L.map transvecStructGL).prod with hPdef
  set Q := (L'.map transvecStructGL).prod with hQdef
  have hPco : (↑P : Matrix n n ℂ) = (L.map Matrix.TransvectionStruct.toMatrix).prod := by
    rw [hPdef]; exact coe_prod_transvecStructGL L
  have hQco : (↑Q : Matrix n n ℂ) = (L'.map Matrix.TransvectionStruct.toMatrix).prod := by
    rw [hQdef]; exact coe_prod_transvecStructGL L'
  have hAeq : (A : Matrix n n ℂ) = (P : Matrix n n ℂ) * Matrix.diagonal D * (Q : Matrix n n ℂ) := by
    rw [hPco, hQco]; exact hLDL'
  have hPinv : (↑(P⁻¹) : Matrix n n ℂ) * (P : Matrix n n ℂ) = 1 := by
    rw [← Units.val_mul, inv_mul_cancel, Units.val_one]
  have hQinv : (Q : Matrix n n ℂ) * (↑(Q⁻¹) : Matrix n n ℂ) = 1 := by
    rw [← Units.val_mul, mul_inv_cancel, Units.val_one]
  have hDeq : (↑(P⁻¹ * A * Q⁻¹) : Matrix n n ℂ) = Matrix.diagonal D := by
    rw [Units.val_mul, Units.val_mul, hAeq]
    calc (↑(P⁻¹) : Matrix n n ℂ) * ((P : Matrix n n ℂ) * Matrix.diagonal D * (Q : Matrix n n ℂ))
          * (↑(Q⁻¹) : Matrix n n ℂ)
        = ((↑(P⁻¹) : Matrix n n ℂ) * (P : Matrix n n ℂ)) * Matrix.diagonal D
            * ((Q : Matrix n n ℂ) * (↑(Q⁻¹) : Matrix n n ℂ)) := by simp only [Matrix.mul_assoc]
      _ = Matrix.diagonal D := by rw [hPinv, hQinv, Matrix.one_mul, Matrix.mul_one]
  have hDunit : IsUnit (Matrix.diagonal D) := hDeq ▸ (P⁻¹ * A * Q⁻¹).isUnit
  have hD : ∀ i, D i ≠ 0 := by
    intro i
    have hu := Matrix.isUnit_diagonal.mp hDunit
    rw [Pi.isUnit_iff] at hu
    exact (hu i).ne_zero
  have hAtwo : A = P * diagonalGL D hD * Q := by
    apply Units.ext
    rw [Units.val_mul, Units.val_mul, hPco, coe_diagonalGL, hQco]
    exact hLDL'
  refine ⟨L ++ L'.map (conjDiagStruct D), D, hD, ?_⟩
  rw [List.map_append, List.prod_append, ← conjGL_prod D hD L', hAtwo, hPdef, hQdef]
  group
-- ANCHOR_END: flow-dethom-generation

/-- The determinant of a `GLₙ(ℂ)` element is nonzero — derived from the factorization
`A = E · D` and `∏ dᵢ ≠ 0`, with no appeal to `det_mul` or `isUnit_iff_isUnit_det`. -/
theorem det_ne_zero (A : Matrix.GeneralLinearGroup n ℂ) :
    L (A : Matrix n n ℂ) ≠ 0 := by
  obtain ⟨E, D, hD, hA⟩ := exists_transvec_diagonal_factorization A
  have hAm : (A : Matrix n n ℂ)
      = (E.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal D := by
    rw [hA, Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL]
  rw [hAm, L_factorization]
  exact Finset.prod_ne_zero_iff.mpr (fun i _ => hD i)

/-- The determinant of a `GLₙ(ℂ)` element, as a unit of `ℂ` (i.e. an element of `ℂ*`). -/
def detUnit (A : Matrix.GeneralLinearGroup n ℂ) : ℂˣ :=
  Units.mk0 (L (A : Matrix n n ℂ)) (det_ne_zero A)

@[simp] theorem coe_detUnit (A : Matrix.GeneralLinearGroup n ℂ) :
    (detUnit A : ℂ) = L (A : Matrix n n ℂ) := rfl

theorem detUnit_one : detUnit (1 : Matrix.GeneralLinearGroup n ℂ) = 1 := by
  apply Units.ext
  simp [detUnit, Units.val_one, L_one]

/--
**§3 well-definedness.** For *any* transvection–diagonal factorization `A = E · D`, the diagonal
product equals `det A`. Since the single-valued `L` is what computes it, the product does not depend
on the chosen factorization (the note's point 3). -/
theorem detUnit_eq_prod_of_factorization (A : Matrix.GeneralLinearGroup n ℂ)
    (E : List (Matrix.TransvectionStruct n ℂ)) (D : n → ℂ) (hD : ∀ i, D i ≠ 0)
    (hA : A = (E.map transvecStructGL).prod * diagonalGL D hD) :
    detUnit A = ∏ j, Units.mk0 (D j) (hD j) := by
  apply Units.ext
  rw [coe_detUnit, Units.coe_prod]
  have hco : (A : Matrix n n ℂ)
      = (E.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal D := by
    rw [hA, Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL]
  rw [hco, L_factorization]
  simp [Units.val_mk0]

/-- Matrix-level diagonal conjugation of a transvection product (the coercion of `conjGL_prod`). -/
theorem coe_conjGL_prod (D : n → ℂ) (hD : ∀ i, D i ≠ 0)
    (L : List (Matrix.TransvectionStruct n ℂ)) :
    Matrix.diagonal D * (L.map Matrix.TransvectionStruct.toMatrix).prod
        * Matrix.diagonal (fun i => (D i)⁻¹)
      = ((L.map (conjDiagStruct D)).map Matrix.TransvectionStruct.toMatrix).prod := by
  have h := congrArg Units.val (conjGL_prod D hD L)
  rw [Units.val_mul, Units.val_mul, coe_diagonalGL, coe_prod_transvecStructGL,
    coe_diagonalGL_inv, coe_prod_transvecStructGL] at h
  exact h

/--
**`eq-dethom-leibniz-multiplicativity` (Step 4, derived).** The determinant is multiplicative on
`GLₙ(ℂ)`. Following the note: factor `A = E_A D_A`, `B = E_B D_B`; then
`AB = E_A (D_A E_B D_A⁻¹) D_A D_B` is again a transvection–diagonal factorization with diagonal
`D_A D_B`, so `det(AB) = ∏ (aᵢbᵢ) = (∏ aᵢ)(∏ bᵢ) = det A · det B`. **No `det_mul` is used.** -/
theorem detUnit_mul (A B : Matrix.GeneralLinearGroup n ℂ) :
    detUnit (A * B) = detUnit A * detUnit B := by
  obtain ⟨LA, DA, hDA, hA⟩ := exists_transvec_diagonal_factorization A
  obtain ⟨LB, DB, hDB, hB⟩ := exists_transvec_diagonal_factorization B
  have hAm : (A : Matrix n n ℂ)
      = (LA.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal DA := by
    rw [hA, Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL]
  have hBm : (B : Matrix n n ℂ)
      = (LB.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal DB := by
    rw [hB, Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL]
  have hdetA : L (A : Matrix n n ℂ) = ∏ i, DA i := by rw [hAm, L_factorization]
  have hdetB : L (B : Matrix n n ℂ) = ∏ i, DB i := by rw [hBm, L_factorization]
  have hdd : Matrix.diagonal (fun i => (DA i)⁻¹) * Matrix.diagonal DA = 1 := by
    rw [Matrix.diagonal_mul_diagonal]
    have h1 : (fun i => (DA i)⁻¹ * DA i) = (1 : n → ℂ) :=
      funext fun i => inv_mul_cancel₀ (hDA i)
    rw [h1]
    exact Matrix.diagonal_one
  have key : (LA.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal DA
        * ((LB.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal DB)
      = (LA.map Matrix.TransvectionStruct.toMatrix).prod
          * (Matrix.diagonal DA * (LB.map Matrix.TransvectionStruct.toMatrix).prod
              * Matrix.diagonal (fun i => (DA i)⁻¹))
          * (Matrix.diagonal DA * Matrix.diagonal DB) := by
    have e : (LA.map Matrix.TransvectionStruct.toMatrix).prod
          * (Matrix.diagonal DA * (LB.map Matrix.TransvectionStruct.toMatrix).prod
              * Matrix.diagonal (fun i => (DA i)⁻¹))
          * (Matrix.diagonal DA * Matrix.diagonal DB)
        = (LA.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal DA
            * (LB.map Matrix.TransvectionStruct.toMatrix).prod
            * (Matrix.diagonal (fun i => (DA i)⁻¹) * Matrix.diagonal DA)
            * Matrix.diagonal DB := by simp only [Matrix.mul_assoc]
    rw [e, hdd, Matrix.mul_one]
    simp only [Matrix.mul_assoc]
  apply Units.ext
  rw [Units.val_mul, coe_detUnit, coe_detUnit, coe_detUnit]
  have hABm : (↑(A * B) : Matrix n n ℂ)
      = ((LA ++ LB.map (conjDiagStruct DA)).map Matrix.TransvectionStruct.toMatrix).prod
          * Matrix.diagonal (fun i => DA i * DB i) := by
    rw [Units.val_mul, hAm, hBm, key, coe_conjGL_prod DA hDA LB, Matrix.diagonal_mul_diagonal,
      List.map_append, List.prod_append]
  rw [hABm, L_factorization, hdetA, hdetB, Finset.prod_mul_distrib]

/-- **The determinant homomorphism** `GLₙ(ℂ) →* ℂˣ`, with multiplicativity **derived** (Step 4),
not imported from Mathlib's `det_mul`. -/
def detGL : Matrix.GeneralLinearGroup n ℂ →* ℂˣ where
  toFun := detUnit
  map_one' := detUnit_one
  map_mul' := detUnit_mul

@[simp] theorem coe_detGL (A : Matrix.GeneralLinearGroup n ℂ) :
    (detGL A : ℂ) = L (A : Matrix n n ℂ) := rfl

-- ANCHOR: flow-dethom-leibniz-mult
/-- `eq-dethom-leibniz-multiplicativity`, packaged: `det(AB) = det A · det B`. -/
theorem detGL_mul (A B : Matrix.GeneralLinearGroup n ℂ) :
    detGL (A * B) = detGL A * detGL B :=
  map_mul detGL A B
-- ANCHOR_END: flow-dethom-leibniz-mult

theorem detGL_oneSlotDiagonalGL (i0 : n) (x : ℂˣ) : detGL (oneSlotDiagonalGL i0 x) = x := by
  apply Units.ext
  rw [coe_detGL, coe_oneSlotDiagonalGL, L_diagonal]
  simp

-- ANCHOR: flow-dethom-factorization
/--
**Factorization theorem `f = g ∘ det`** (the note's Step 5, derived directly). Every homomorphism
`f : GLₙ(ℂ) → ℂˣ` factors as `f(A) = f(E)·f(D) = 1·g(∏ dᵢ) = g(det A)` along a factorization
`A = E·D`, with `g = diagonalFactorOfHom i0 f`. -/
theorem hom_factor_det (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (A : Matrix.GeneralLinearGroup n ℂ) :
    f A = diagonalFactorOfHom i0 f (detGL A) := by
  obtain ⟨E, D, hD, hA⟩ := exists_transvec_diagonal_factorization A
  rw [hA, map_mul, hom_prod_transvecStructGL_eq_one, one_mul, hom_diagonalGL_eq f i0 D hD]
  congr 1
  apply Units.ext
  rw [coe_detGL]
  have hco : (↑((E.map transvecStructGL).prod * diagonalGL D hD) : Matrix n n ℂ)
      = (E.map Matrix.TransvectionStruct.toMatrix).prod * Matrix.diagonal D := by
    rw [Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL]
  rw [hco, L_factorization, Units.coe_prod]
  simp [Units.val_mk0]

/-- The boxed statement in existential form: `f = g ∘ det` for some homomorphism `g : ℂˣ → ℂˣ`. -/
theorem exists_hom_factor_det (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n) :
    ∃ g : ℂˣ →* ℂˣ, ∀ A : Matrix.GeneralLinearGroup n ℂ, f A = g (detGL A) :=
  ⟨diagonalFactorOfHom i0 f, hom_factor_det f i0⟩

/-- The factor `g` is unique (the determinant is surjective onto `ℂˣ`). -/
theorem existsUnique_hom_factor_det (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n) :
    ∃! g : ℂˣ →* ℂˣ, ∀ A : Matrix.GeneralLinearGroup n ℂ, f A = g (detGL A) := by
  refine ⟨diagonalFactorOfHom i0 f, hom_factor_det f i0, ?_⟩
  intro g hg
  refine MonoidHom.ext fun w => ?_
  have hA := hg (oneSlotDiagonalGL i0 w)
  rw [hom_factor_det f i0, detGL_oneSlotDiagonalGL] at hA
  exact hA.symm
-- ANCHOR_END: flow-dethom-factorization

-- ANCHOR: flow-dethom-uniqueness
/-- **Uniqueness.** Two homomorphisms agreeing on the diagonal slots agree everywhere. -/
theorem hom_eq_of_eq_on_oneSlot (i0 : n) (f₁ f₂ : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (h : ∀ x, f₁ (oneSlotDiagonalGL i0 x) = f₂ (oneSlotDiagonalGL i0 x))
    (A : Matrix.GeneralLinearGroup n ℂ) : f₁ A = f₂ A := by
  rw [hom_factor_det f₁ i0, hom_factor_det f₂ i0]
  exact h (detGL A)

/-- **Characterization of the determinant.** A homomorphism normalized so that `g = id` is `det`. -/
theorem hom_eq_detGL_of_normalized (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (h : ∀ x, f (oneSlotDiagonalGL i0 x) = x) (A : Matrix.GeneralLinearGroup n ℂ) :
    f A = detGL A := by
  rw [hom_factor_det f i0]
  exact h (detGL A)
-- ANCHOR_END: flow-dethom-uniqueness

-- ANCHOR: flow-dethom-postcompose
/-- Post-composing determinant with a homomorphism `ℂˣ → ℂˣ`. -/
def postcomposeDetGL (g : ℂˣ →* ℂˣ) : Matrix.GeneralLinearGroup n ℂ →* ℂˣ :=
  g.comp detGL

@[simp] theorem postcomposeDetGL_apply (g : ℂˣ →* ℂˣ) (A : Matrix.GeneralLinearGroup n ℂ) :
    postcomposeDetGL g A = g (detGL A) := rfl

/-- **Converse.** Every `g ∘ det` is a homomorphism `GLₙ(ℂ) → ℂˣ`. -/
theorem postcomposeDetGL_mul (g : ℂˣ →* ℂˣ) (A B : Matrix.GeneralLinearGroup n ℂ) :
    postcomposeDetGL g (A * B) = postcomposeDetGL g A * postcomposeDetGL g B :=
  map_mul (postcomposeDetGL g) A B
-- ANCHOR_END: flow-dethom-postcompose

-- ANCHOR: flow-dethom-converse
/-- Every homomorphism is some `g ∘ det`; together with the converse, these are exactly all of
them. -/
theorem hom_eq_postcomposeDetGL (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) :
    f = postcomposeDetGL (diagonalFactorOfHom i0 f) := by
  ext A
  rw [postcomposeDetGL_apply, hom_factor_det f i0]
-- ANCHOR_END: flow-dethom-converse

-- ANCHOR: flow-dethom-cstar
/-- The determinant's own factor is the identity (`det` is `s = 1`, `k = 1`). -/
theorem diagonalFactorOfHom_detGL (i0 : n) :
    diagonalFactorOfHom i0 detGL = MonoidHom.id ℂˣ := by
  ext x
  simp [diagonalFactorOfHom, detGL_oneSlotDiagonalGL]

/--
**Link to `ℂ* → ℂ*` classification.** If the one-variable factor `g = diagonalFactorOfHom i0 f`
is Borel measurable (in particular if it is continuous), then `f` has the closed form
`f(A) = |det A|ˢ · (det A / |det A|)ᵏ` for some `s ∈ ℂ`, `k ∈ ℤ`, by the flow-faithful
classification `CstarFlow.cstar_homomorphism_formula_measurable`. The determinant itself is the
case `s = 1`, `k = 1` (`diagonalFactorOfHom_detGL`).
-/
theorem hom_factor_det_cstar (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (hg : Measurable (diagonalFactorOfHom i0 f)) :
    ∃ s : ℂ, ∃ k : ℤ, ∀ A : Matrix.GeneralLinearGroup n ℂ,
      f A = cstarNormCPow s (detGL A) * cstarCircleUnit (detGL A) ^ k := by
  obtain ⟨s, k, hsk⟩ := cstar_homomorphism_formula_measurable (diagonalFactorOfHom i0 f) hg
  exact ⟨s, k, fun A => by rw [hom_factor_det f i0, hsk]⟩

/-- **Link to the `ℂ* → ℂ*` classification.** If `g` is measurable, `f(A) = |det A|ˢ (det A/|det
A|)ᵏ` with `(s, k)` unique. -/
theorem existsUnique_hom_factor_det_cstar (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (hg : Measurable (diagonalFactorOfHom i0 f)) :
    ∃! sk : ℂ × ℤ, ∀ A : Matrix.GeneralLinearGroup n ℂ,
      f A = cstarNormCPow sk.1 (detGL A) * cstarCircleUnit (detGL A) ^ sk.2 := by
  obtain ⟨s, k, hsk⟩ := cstar_homomorphism_formula_measurable (diagonalFactorOfHom i0 f) hg
  refine ⟨(s, k), fun A => by rw [hom_factor_det f i0, hsk], ?_⟩
  rintro ⟨s', k'⟩ hf'
  have hg' : ∀ w : ℂˣ, diagonalFactorOfHom i0 f w = cstarFormulaHom s' k' w := by
    intro w
    have hw := hf' (oneSlotDiagonalGL i0 w)
    rw [hom_factor_det f i0, detGL_oneSlotDiagonalGL] at hw
    exact hw
  have hkey : cstarFormulaHom s k = cstarFormulaHom s' k' := by
    refine MonoidHom.ext fun w => ?_
    rw [← hg' w]
    exact (hsk w).symm
  obtain ⟨hs, hk⟩ := cstarFormulaHom_injective hkey
  simp only [Prod.mk.injEq]
  exact ⟨hs.symm, hk.symm⟩
-- ANCHOR_END: flow-dethom-cstar

/-! ### Singling out the determinant by the normalization `f(λI) = λⁿ`

The factor `g = diagonalFactorOfHom i0 f` is free, so `f = g ∘ det` is the determinant exactly when
`g = id`. The measurability route above pins `g` to the polar family and selects `det` at
`s = 1, k = 1`. Here is a second, purely **algebraic** criterion that forces `g = id` with *no*
regularity assumption: requiring `f(λI) = λⁿ` on the scalar matrices.

We record the value of an arbitrary homomorphism on a scalar matrix `λI` (Step 3 gives
`f(λI) = g(λⁿ)`), note the determinant realizes the normalization (`det(λI) = λⁿ`, the `g = id`
case), and finally show the normalization forces `g = id`. The only new ingredient is that
`λ ↦ λⁿ` is surjective on `ℂ*`, because `ℂ` is algebraically closed. -/

/-- The scalar matrix `λI` (here `x I`) as an element of `GLₙ(ℂ)`. -/
def scalarGL (x : ℂˣ) : Matrix.GeneralLinearGroup n ℂ :=
  diagonalGL (fun _ => (x : ℂ)) (fun _ => x.ne_zero)

@[simp]
theorem coe_scalarGL (x : ℂˣ) :
    ((scalarGL x : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.diagonal (fun _ => (x : ℂ)) :=
  rfl

-- ANCHOR: flow-dethom-scalar
/--
**`eq-dethom-scalar` (from multiplicativity alone).** Evaluating any homomorphism `f` on the scalar
matrix `λI` gives `g(λⁿ)`, where `g = diagonalFactorOfHom i0 f` and `n = Fintype.card n`: by Step 3
(`eq-dethom-diagonal-product`), `f(λI) = g(∏ᵢ λ) = g(λⁿ)`. -/
theorem hom_scalarGL_eq (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n) (x : ℂˣ) :
    f (scalarGL x) = diagonalFactorOfHom i0 f (x ^ Fintype.card n) := by
  rw [scalarGL, hom_diagonalGL_eq f i0 (fun _ => (x : ℂ)) (fun _ => x.ne_zero)]
  congr 1
  simp [Finset.prod_const, Finset.card_univ, Units.mk0_val]

/-- The determinant realizes the normalization (it is the `g = id` case): `det(λI) = λⁿ`, directly
from the Leibniz identity `L(diag d) = ∏ᵢ dᵢ`. -/
theorem detGL_scalarGL (x : ℂˣ) :
    detGL (scalarGL x : Matrix.GeneralLinearGroup n ℂ) = x ^ Fintype.card n := by
  apply Units.ext
  rw [coe_detGL, coe_scalarGL, L_diagonal]
  simp [Finset.prod_const, Finset.card_univ, Units.val_pow_eq_pow_val]
-- ANCHOR_END: flow-dethom-scalar

/-- The `N`-th power map is **surjective** on `ℂ*` for `N ≥ 1`: every unit `w` has an `N`-th root,
since `ℂ` is algebraically closed (`IsAlgClosed.exists_pow_nat_eq`) and any such root is nonzero. -/
theorem exists_unit_pow_eq (N : ℕ) (hN : 0 < N) (w : ℂˣ) :
    ∃ z : ℂˣ, z ^ N = w := by
  obtain ⟨z, hz⟩ := IsAlgClosed.exists_pow_nat_eq (w : ℂ) hN
  have hz0 : z ≠ 0 := by
    rintro rfl
    rw [zero_pow hN.ne'] at hz
    exact w.ne_zero hz.symm
  refine ⟨Units.mk0 z hz0, ?_⟩
  apply Units.ext
  rw [Units.val_pow_eq_pow_val, Units.val_mk0]
  exact hz

-- ANCHOR: flow-dethom-scalar-normalization
/--
**The normalization forces `g = id`.** If `f(λI) = λⁿ` for every `λ ∈ ℂ*`, then the one-variable
factor `g = diagonalFactorOfHom i0 f` is the identity: by `eq-dethom-scalar`, `g(λⁿ) = λⁿ` for all
`λ`, and since `λ ↦ λⁿ` is surjective on `ℂ*`, every `w` is some `λⁿ`, so `g(w) = g(λⁿ) = λⁿ = w`.
**No continuity or measurability is used.** -/
theorem diagonalFactorOfHom_eq_id_of_scalar_pow [Nonempty n]
    (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (h : ∀ x : ℂˣ, f (scalarGL x) = x ^ Fintype.card n) :
    diagonalFactorOfHom i0 f = MonoidHom.id ℂˣ := by
  refine MonoidHom.ext fun w => ?_
  obtain ⟨z, hz⟩ := exists_unit_pow_eq (Fintype.card n) Fintype.card_pos w
  have hx := h z
  rw [hom_scalarGL_eq f i0 z, hz] at hx
  rw [MonoidHom.id_apply]
  exact hx

/--
**Determinant from the scalar normalization.** A homomorphism with `f(λI) = λⁿ` on every scalar
matrix *is* the determinant: `f(A) = det A` for all `A ∈ GLₙ(ℂ)` — derived purely algebraically,
with no continuity, measurability, or other regularity assumption. -/
theorem hom_eq_detGL_of_scalar_pow [Nonempty n]
    (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (h : ∀ x : ℂˣ, f (scalarGL x) = x ^ Fintype.card n)
    (A : Matrix.GeneralLinearGroup n ℂ) : f A = detGL A := by
  rw [hom_factor_det f i0, diagonalFactorOfHom_eq_id_of_scalar_pow f i0 h, MonoidHom.id_apply]
-- ANCHOR_END: flow-dethom-scalar-normalization

end GeneralLinear

end Flow

end MathNotesLean
