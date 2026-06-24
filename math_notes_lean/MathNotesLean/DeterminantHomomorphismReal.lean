/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib

/-!
# Determinant from a homomorphism on *real* matrices

`DeterminantHomomorphismMonoid.lean` proves, over `ℂ`, that a monoid homomorphism
`f : Mₙ(ℂ) →* ℂ` with `f(μI) = μⁿ` equals `det`. Over `ℝ` that is **false** when `n` is even: the
extra solution `f = |det|` also satisfies both hypotheses, because `|det(μI)| = |μ|ⁿ = μⁿ` exactly
when `n` is even. The fix (suggested by the note) is one more algebraic normalization on a
*reflection*:

* **(H1)** `f (A * B) = f A * f B`  (multiplicative on *all* matrices);
* **(H2)** `f (μ • I) = μⁿ`  for every `μ ∈ ℝˣ`  (scalar normalization);
* **(H3)** `f (diagonal (-1 at i₀, 1 elsewhere)) = -1`  (a single reflection has value `-1`).

With (H3), `f = det` for **every** `n` (`monoidHom_eq_det_of_real`). And
`not_characterization_real_even` shows (H3) is genuinely needed: without it the even-`n` statement
fails.

## Why (H3) closes the gap

On `GLₙ(ℝ)`, `f(A) = g(det A)` for a homomorphism `g : ℝˣ → ℝˣ` read off the diagonal. (H2) forces
`g(u)ⁿ = uⁿ`, hence `|g(u)| = |u|`. For `u > 0`, `g(u) = g(√u)² ≥ 0` pins `g(u) = u` with no extra
input; the sign on negatives is the only freedom, and (H3) — which says `g(-1) = -1` — removes it.
So `g = id` and `f = det`, uniformly in `n` (no parity hypothesis).

This file uses Mathlib's `Matrix.det` freely (it is not a flow-faithful development); the `GLₙ`
factorization mirrors the one in `DeterminantHomomorphismFlow.lean` but over `ℝ`.
-/

noncomputable section

namespace MathNotesLean

namespace Real

open Matrix

variable {n : Type*} [DecidableEq n] [Fintype n]

/-- An invertible diagonal real matrix as an element of `GLₙ(ℝ)`. -/
def diagonalGL (d : n → ℝ) (hd : ∀ i, d i ≠ 0) : Matrix.GeneralLinearGroup n ℝ where
  val := Matrix.diagonal d
  inv := Matrix.diagonal fun i => (d i)⁻¹
  val_inv := by
    rw [Matrix.diagonal_mul_diagonal]
    ext i j
    by_cases hij : i = j
    · subst j; simp [Matrix.diagonal, hd]
    · simp [Matrix.diagonal, hij]
  inv_val := by
    rw [Matrix.diagonal_mul_diagonal]
    ext i j
    by_cases hij : i = j
    · subst j; simp [Matrix.diagonal, hd]
    · simp [Matrix.diagonal, hij]

@[simp]
theorem coe_diagonalGL (d : n → ℝ) (hd : ∀ i, d i ≠ 0) :
    ((diagonalGL d hd : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ) = Matrix.diagonal d :=
  rfl

@[simp]
theorem coe_diagonalGL_inv (d : n → ℝ) (hd : ∀ i, d i ≠ 0) :
    (((diagonalGL d hd)⁻¹ : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ)
      = Matrix.diagonal (fun i => (d i)⁻¹) :=
  rfl

/-- Diagonal `GLₙ(ℝ)` matrix with `x` in one chosen slot and `1` elsewhere. -/
def oneSlotDiagonalGL (i0 : n) (x : ℝˣ) : Matrix.GeneralLinearGroup n ℝ :=
  diagonalGL (fun i => if i = i0 then (x : ℝ) else 1) (by
    intro i; by_cases hi : i = i0
    · simp [hi, x.ne_zero]
    · simp [hi])

@[simp]
theorem coe_oneSlotDiagonalGL (i0 : n) (x : ℝˣ) :
    ((oneSlotDiagonalGL i0 x : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ)
      = Matrix.diagonal (fun k => if k = i0 then (x : ℝ) else 1) :=
  rfl

theorem oneSlotDiagonalGL_mul (i0 : n) (x y : ℝˣ) :
    oneSlotDiagonalGL i0 (x * y) = oneSlotDiagonalGL i0 x * oneSlotDiagonalGL i0 y := by
  apply Units.ext
  change Matrix.diagonal (fun i => if i = i0 then ((x * y : ℝˣ) : ℝ) else 1) =
    Matrix.diagonal (fun i => if i = i0 then (x : ℝ) else 1) *
      Matrix.diagonal (fun i => if i = i0 then (y : ℝ) else 1)
  rw [Matrix.diagonal_mul_diagonal]
  ext i j
  by_cases hij : i = j
  · subst j; by_cases hi : i = i0 <;> simp [Matrix.diagonal, hi]
  · by_cases hi : i = i0 <;> by_cases hj : j = i0 <;> simp [Matrix.diagonal, hij, hi, hj]

@[simp]
theorem oneSlotDiagonalGL_one (i0 : n) : oneSlotDiagonalGL i0 1 = 1 := by
  ext i j; simp [oneSlotDiagonalGL, diagonalGL]

/-- The one-variable factor read off from a homomorphism on one diagonal slot. -/
def diagonalFactorOfHom (i0 : n) (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) : ℝˣ →* ℝˣ where
  toFun x := F (oneSlotDiagonalGL i0 x)
  map_one' := by simp
  map_mul' x y := by rw [oneSlotDiagonalGL_mul i0 x y, map_mul]

/-- **Step 1 (conjugation invariance).** -/
theorem hom_conj_eq (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ)
    (P A : Matrix.GeneralLinearGroup n ℝ) : F (P * A * P⁻¹) = F A := by
  rw [map_mul, map_mul, map_inv, mul_comm (F P) (F A), mul_assoc, mul_inv_cancel, mul_one]

/-- A transvection `I + c Eᵢⱼ` (with `i ≠ j`) as an element of `GLₙ(ℝ)`. -/
def transvectionGL {i j : n} (hij : i ≠ j) (c : ℝ) : Matrix.GeneralLinearGroup n ℝ :=
  Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij c)

@[simp]
theorem coe_transvectionGL {i j : n} (hij : i ≠ j) (c : ℝ) :
    ((transvectionGL hij c : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ)
      = Matrix.transvection i j c := by
  rw [transvectionGL]; rfl

/-- **Step 2 (diagonal conjugation).** `D Tᵢⱼ(c) D⁻¹ = Tᵢⱼ((dᵢ/dⱼ) c)`. -/
theorem diagonal_conj_transvection (d : n → ℝ) (hd : ∀ k, d k ≠ 0) {i j : n} (hij : i ≠ j)
    (c : ℝ) :
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
      obtain ⟨rfl, rfl⟩ := h2; ring
    · simp only [if_neg h1, if_neg h2, mul_zero, zero_mul, add_zero]

/-- **Step 2 (transvections have trivial image).** -/
theorem hom_transvection_eq_one (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) {i j : n} (hij : i ≠ j)
    (c : ℝ) : F (transvectionGL hij c) = 1 := by
  set d : n → ℝ := fun k => if k = i then 2 else 1 with hd_def
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
    rw [inv_one, mul_one]; ring
  have ht2 : F (transvectionGL hij c) * F (transvectionGL hij c) = F (transvectionGL hij c) := by
    rw [← map_mul, ← hadd, ← hconj, hom_conj_eq]
  have ht1 : F (transvectionGL hij c) * F (transvectionGL hij c)
      = F (transvectionGL hij c) * 1 := by rw [mul_one]; exact ht2
  exact mul_left_cancel ht1

/-- A `TransvectionStruct` as an element of `GLₙ(ℝ)`. -/
def transvecStructGL (t : Matrix.TransvectionStruct n ℝ) : Matrix.GeneralLinearGroup n ℝ :=
  transvectionGL t.hij t.c

@[simp]
theorem coe_transvecStructGL (t : Matrix.TransvectionStruct n ℝ) :
    ((transvecStructGL t : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ) = t.toMatrix := by
  rw [transvecStructGL, coe_transvectionGL]; rfl

theorem hom_transvecStructGL_eq_one (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ)
    (t : Matrix.TransvectionStruct n ℝ) : F (transvecStructGL t) = 1 :=
  hom_transvection_eq_one F t.hij t.c

theorem coe_prod_transvecStructGL (L : List (Matrix.TransvectionStruct n ℝ)) :
    (((L.map transvecStructGL).prod : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ)
      = (L.map Matrix.TransvectionStruct.toMatrix).prod := by
  induction L with
  | nil => simp
  | cons t L ih =>
    simp only [List.map_cons, List.prod_cons, Units.val_mul, coe_transvecStructGL, ih]

theorem hom_prod_transvecStructGL_eq_one (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ)
    (L : List (Matrix.TransvectionStruct n ℝ)) : F (L.map transvecStructGL).prod = 1 := by
  induction L with
  | nil => simp
  | cons t L ih =>
    simp only [List.map_cons, List.prod_cons, map_mul, hom_transvecStructGL_eq_one, ih, one_mul]

/-- The transvection obtained by conjugating `t` by an invertible diagonal `D`. -/
def conjDiagStruct (D : n → ℝ) (t : Matrix.TransvectionStruct n ℝ) :
    Matrix.TransvectionStruct n ℝ :=
  ⟨t.i, t.j, t.hij, D t.i * (D t.j)⁻¹ * t.c⟩

theorem conjGL_transvecStructGL (D : n → ℝ) (hD : ∀ i, D i ≠ 0)
    (t : Matrix.TransvectionStruct n ℝ) :
    diagonalGL D hD * transvecStructGL t * (diagonalGL D hD)⁻¹
      = transvecStructGL (conjDiagStruct D t) := by
  apply Units.ext
  rw [Units.val_mul, Units.val_mul, coe_diagonalGL, coe_transvecStructGL, coe_diagonalGL_inv,
    coe_transvecStructGL]
  simp only [Matrix.TransvectionStruct.toMatrix, conjDiagStruct]
  rw [diagonal_conj_transvection D hD t.hij t.c]

theorem conjGL_prod (D : n → ℝ) (hD : ∀ i, D i ≠ 0)
    (L : List (Matrix.TransvectionStruct n ℝ)) :
    diagonalGL D hD * (L.map transvecStructGL).prod * (diagonalGL D hD)⁻¹
      = ((L.map (conjDiagStruct D)).map transvecStructGL).prod := by
  induction L with
  | nil => simp
  | cons t L ih =>
    rw [List.map_cons, List.prod_cons, List.map_cons, List.map_cons, List.prod_cons,
      ← conjGL_transvecStructGL D hD t, ← ih]
    group

/-- Conjugating a diagonal matrix by a swap matrix permutes its diagonal entries. -/
theorem swap_conj_diagonal (d : n → ℝ) (i0 i : n) :
    Matrix.swap ℝ i0 i * Matrix.diagonal d * Matrix.swap ℝ i0 i
      = Matrix.diagonal (fun k => d (Equiv.swap i0 i k)) := by
  change (Equiv.swap i0 i).toPEquiv.toMatrix * Matrix.diagonal d
      * (Equiv.swap i0 i).toPEquiv.toMatrix = _
  rw [PEquiv.toMatrix_toPEquiv_mul, PEquiv.mul_toMatrix_toPEquiv,
    Matrix.submatrix_submatrix, Function.comp_id, Function.id_comp,
    Equiv.symm_swap, Matrix.submatrix_diagonal_equiv]
  rfl

/-- **Step 3 (position invariance).** -/
theorem hom_oneSlotDiagonalGL_pos_invariant (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ)
    (i0 i : n) (x : ℝˣ) :
    F (oneSlotDiagonalGL i x) = F (oneSlotDiagonalGL i0 x) := by
  have key : Matrix.GeneralLinearGroup.swap ℝ i0 i * oneSlotDiagonalGL i0 x
      * (Matrix.GeneralLinearGroup.swap ℝ i0 i)⁻¹ = oneSlotDiagonalGL i x := by
    apply Units.ext
    have hv : ((Matrix.GeneralLinearGroup.swap ℝ i0 i : Matrix.GeneralLinearGroup n ℝ)
        : Matrix n n ℝ) = Matrix.swap ℝ i0 i := rfl
    have hi : (((Matrix.GeneralLinearGroup.swap ℝ i0 i)⁻¹ : Matrix.GeneralLinearGroup n ℝ)
        : Matrix n n ℝ) = Matrix.swap ℝ i0 i := rfl
    simp only [Units.val_mul, coe_oneSlotDiagonalGL, hv, hi]
    rw [swap_conj_diagonal]
    congr 1
    funext k
    by_cases hk : k = i
    · subst hk; simp [Equiv.swap_apply_right]
    · have hne : Equiv.swap i0 i k ≠ i0 := by
        intro h
        exact hk ((Equiv.swap i0 i).injective (by rw [h, Equiv.swap_apply_right]))
      simp [hk, hne]
  rw [← key, hom_conj_eq]

/-- The diagonal `GLₙ(ℝ)` matrix with the entries of `D` on the slots in `s`, and `1` elsewhere. -/
def diagOnGL (D : n → ℝ) (hD : ∀ i, D i ≠ 0) (s : Finset n) :
    Matrix.GeneralLinearGroup n ℝ :=
  diagonalGL (fun j => if j ∈ s then D j else 1) (fun j => by
    by_cases h : j ∈ s <;> simp [h, hD j])

@[simp]
theorem coe_diagOnGL (D : n → ℝ) (hD : ∀ i, D i ≠ 0) (s : Finset n) :
    ((diagOnGL D hD s : Matrix.GeneralLinearGroup n ℝ) : Matrix n n ℝ)
      = Matrix.diagonal (fun j => if j ∈ s then D j else 1) :=
  rfl

@[simp]
theorem diagOnGL_univ (D : n → ℝ) (hD : ∀ i, D i ≠ 0) :
    diagOnGL D hD Finset.univ = diagonalGL D hD := by
  apply Units.ext; simp [coe_diagOnGL, coe_diagonalGL]

theorem diagOnGL_empty (D : n → ℝ) (hD : ∀ i, D i ≠ 0) : diagOnGL D hD ∅ = 1 := by
  apply Units.ext; simp [coe_diagOnGL]

theorem diagOnGL_insert (D : n → ℝ) (hD : ∀ i, D i ≠ 0) {a : n} {s : Finset n} (ha : a ∉ s) :
    diagOnGL D hD (insert a s)
      = oneSlotDiagonalGL a (Units.mk0 (D a) (hD a)) * diagOnGL D hD s := by
  apply Units.ext
  rw [Units.val_mul, coe_oneSlotDiagonalGL, coe_diagOnGL, coe_diagOnGL,
    Matrix.diagonal_mul_diagonal]
  congr 1
  funext j
  simp only [Units.val_mk0, Finset.mem_insert]
  by_cases hja : j = a
  · subst hja; simp [ha]
  · by_cases hjs : j ∈ s <;> simp [hja, hjs]

theorem hom_diagOnGL_eq (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) (i0 : n)
    (D : n → ℝ) (hD : ∀ i, D i ≠ 0) (s : Finset n) :
    F (diagOnGL D hD s)
      = ∏ j ∈ s, diagonalFactorOfHom i0 F (Units.mk0 (D j) (hD j)) := by
  refine Finset.induction_on s ?_ (fun a s ha ih => ?_)
  · rw [diagOnGL_empty, map_one, Finset.prod_empty]
  · rw [diagOnGL_insert D hD ha, map_mul, Finset.prod_insert ha, ih]
    congr 1
    rw [hom_oneSlotDiagonalGL_pos_invariant F i0 a (Units.mk0 (D a) (hD a))]
    rfl

/-- **Step 3 (product over the diagonal).** `f(diag D) = g(∏ⱼ Dⱼ)`. -/
theorem hom_diagonalGL_eq (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) (i0 : n)
    (D : n → ℝ) (hD : ∀ i, D i ≠ 0) :
    F (diagonalGL D hD) = diagonalFactorOfHom i0 F (∏ j : n, Units.mk0 (D j) (hD j)) := by
  rw [← diagOnGL_univ D hD, hom_diagOnGL_eq F i0 D hD Finset.univ,
    ← map_prod (diagonalFactorOfHom i0 F)]

/-! ### The determinant side (Mathlib) -/

/-- The determinant as a homomorphism `GLₙ(ℝ) →* ℝˣ`. -/
def detGL : Matrix.GeneralLinearGroup n ℝ →* ℝˣ :=
  Units.map (Matrix.detMonoidHom : Matrix n n ℝ →* ℝ)

@[simp] theorem coe_detGL (A : Matrix.GeneralLinearGroup n ℝ) :
    (detGL A : ℝ) = (A : Matrix n n ℝ).det := rfl

theorem detGL_transvecStructGL (t : Matrix.TransvectionStruct n ℝ) :
    detGL (transvecStructGL t) = 1 := by
  apply Units.ext
  rw [coe_detGL, coe_transvecStructGL, Units.val_one, t.det]

theorem detGL_prod_transvec (L : List (Matrix.TransvectionStruct n ℝ)) :
    detGL (L.map transvecStructGL).prod = 1 := by
  induction L with
  | nil => simp
  | cons t L ih => simp only [List.map_cons, List.prod_cons, map_mul, detGL_transvecStructGL, ih,
      one_mul]

theorem detGL_diagonalGL (D : n → ℝ) (hD : ∀ i, D i ≠ 0) :
    detGL (diagonalGL D hD) = ∏ i, Units.mk0 (D i) (hD i) := by
  apply Units.ext
  rw [coe_detGL, coe_diagonalGL, Matrix.det_diagonal, Units.coe_prod]
  simp [Units.val_mk0]

theorem detGL_oneSlotDiagonalGL (i0 : n) (x : ℝˣ) : detGL (oneSlotDiagonalGL i0 x) = x := by
  apply Units.ext
  rw [coe_detGL, coe_oneSlotDiagonalGL, Matrix.det_diagonal]
  rw [Finset.prod_eq_single i0 (fun b _ hb => by simp [hb]) (by simp)]
  simp

/-- **Generation.** Every `A ∈ GLₙ(ℝ)` factors as `E · D`, `E` a product of transvections, `D`
invertible diagonal. -/
theorem exists_transvec_diagonal_factorization (A : Matrix.GeneralLinearGroup n ℝ) :
    ∃ (E : List (Matrix.TransvectionStruct n ℝ)) (D : n → ℝ) (hD : ∀ i, D i ≠ 0),
      A = (E.map transvecStructGL).prod * diagonalGL D hD := by
  obtain ⟨L, L', D, hLDL'⟩ :=
    Matrix.Pivot.exists_list_transvec_mul_diagonal_mul_list_transvec (A : Matrix n n ℝ)
  set P := (L.map transvecStructGL).prod with hPdef
  set Q := (L'.map transvecStructGL).prod with hQdef
  have hPco : (↑P : Matrix n n ℝ) = (L.map Matrix.TransvectionStruct.toMatrix).prod := by
    rw [hPdef]; exact coe_prod_transvecStructGL L
  have hQco : (↑Q : Matrix n n ℝ) = (L'.map Matrix.TransvectionStruct.toMatrix).prod := by
    rw [hQdef]; exact coe_prod_transvecStructGL L'
  have hAeq : (A : Matrix n n ℝ) = (P : Matrix n n ℝ) * Matrix.diagonal D * (Q : Matrix n n ℝ) := by
    rw [hPco, hQco]; exact hLDL'
  have hPinv : (↑(P⁻¹) : Matrix n n ℝ) * (P : Matrix n n ℝ) = 1 := by
    rw [← Units.val_mul, inv_mul_cancel, Units.val_one]
  have hQinv : (Q : Matrix n n ℝ) * (↑(Q⁻¹) : Matrix n n ℝ) = 1 := by
    rw [← Units.val_mul, mul_inv_cancel, Units.val_one]
  have hDeq : (↑(P⁻¹ * A * Q⁻¹) : Matrix n n ℝ) = Matrix.diagonal D := by
    rw [Units.val_mul, Units.val_mul, hAeq]
    calc (↑(P⁻¹) : Matrix n n ℝ) * ((P : Matrix n n ℝ) * Matrix.diagonal D * (Q : Matrix n n ℝ))
          * (↑(Q⁻¹) : Matrix n n ℝ)
        = ((↑(P⁻¹) : Matrix n n ℝ) * (P : Matrix n n ℝ)) * Matrix.diagonal D
            * ((Q : Matrix n n ℝ) * (↑(Q⁻¹) : Matrix n n ℝ)) := by simp only [Matrix.mul_assoc]
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

/-- **Factorization theorem.** Every homomorphism `F : GLₙ(ℝ) → ℝˣ` factors as `F(A) = g(det A)`. -/
theorem hom_factor_det (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) (i0 : n)
    (A : Matrix.GeneralLinearGroup n ℝ) :
    F A = diagonalFactorOfHom i0 F (detGL A) := by
  obtain ⟨E, D, hD, hA⟩ := exists_transvec_diagonal_factorization A
  rw [hA, map_mul, hom_prod_transvecStructGL_eq_one, one_mul, hom_diagonalGL_eq F i0 D hD]
  congr 1
  rw [map_mul, detGL_prod_transvec, one_mul, detGL_diagonalGL]

/-! ### `g = id` from the scalar normalization (H2) and the reflection (H3) -/

/-- From (H2): the one-slot factor satisfies `g(u)ⁿ = uⁿ`. -/
theorem diagonalFactorOfHom_pow [Nonempty n] (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) (i0 : n)
    (h2 : ∀ u : ℝˣ, F (diagonalGL (fun _ => (u : ℝ)) (fun _ => u.ne_zero)) = u ^ Fintype.card n)
    (u : ℝˣ) : (diagonalFactorOfHom i0 F u) ^ Fintype.card n = u ^ Fintype.card n := by
  have h := hom_diagonalGL_eq F i0 (fun _ => (u : ℝ)) (fun _ => u.ne_zero)
  rw [h2 u] at h
  have hp : (∏ _j : n, Units.mk0 ((u : ℝ)) (u.ne_zero)) = u ^ Fintype.card n := by
    rw [Finset.prod_const, Finset.card_univ]; congr 1; exact Units.mk0_val u u.ne_zero
  rw [hp, map_pow] at h
  exact h.symm

/--
**`g = id` (uniformly in `n`).** The one-slot factor `g = diagonalFactorOfHom i0 F` is the identity,
given (H2) (`g(u)ⁿ = uⁿ`, hence `|g(u)| = |u|`; for `u > 0`, `g(u) = g(√u)² ≥ 0` forces `g(u) = u`)
and (H3) (`g(-1) = -1`, fixing the sign on negatives). **No parity hypothesis is needed.** -/
theorem diagonalFactorOfHom_eq_id [Nonempty n] (F : Matrix.GeneralLinearGroup n ℝ →* ℝˣ) (i0 : n)
    (h2 : ∀ u : ℝˣ, F (diagonalGL (fun _ => (u : ℝ)) (fun _ => u.ne_zero)) = u ^ Fintype.card n)
    (h3 : F (oneSlotDiagonalGL i0 (-1)) = -1) :
    diagonalFactorOfHom i0 F = MonoidHom.id ℝˣ := by
  set g := diagonalFactorOfHom i0 F with hgdef
  have hgm1 : g (-1) = -1 := h3
  have gabs : ∀ u : ℝˣ, |((g u : ℝˣ) : ℝ)| = |(u : ℝ)| := by
    intro u
    have h := congrArg Units.val (diagonalFactorOfHom_pow F i0 h2 u)
    rw [Units.val_pow_eq_pow_val, Units.val_pow_eq_pow_val] at h
    have := congrArg (|·|) h
    rwa [abs_pow, abs_pow,
      pow_left_inj₀ (abs_nonneg _) (abs_nonneg _) Fintype.card_ne_zero] at this
  have hpos : ∀ u : ℝˣ, 0 < (u : ℝ) → g u = u := by
    intro u hu
    have hsqrt : Real.sqrt (u : ℝ) ≠ 0 := by positivity
    set v : ℝˣ := Units.mk0 (Real.sqrt (u : ℝ)) hsqrt with hv
    have hvv : v * v = u := by
      apply Units.ext
      simp only [Units.val_mul, hv, Units.val_mk0]
      exact Real.mul_self_sqrt hu.le
    have hgvv : g u = g v * g v := by rw [← hvv, map_mul]
    have hnn : 0 ≤ (g u : ℝ) := by rw [hgvv, Units.val_mul]; exact mul_self_nonneg _
    have habs := gabs u
    rw [abs_of_nonneg hnn, abs_of_pos hu] at habs
    exact Units.ext habs
  refine MonoidHom.ext fun u => ?_
  rw [MonoidHom.id_apply]
  rcases lt_trichotomy (u : ℝ) 0 with hu | hu | hu
  · have hw : 0 < (((-1 : ℝˣ) * u : ℝˣ) : ℝ) := by
      simp only [Units.val_mul, Units.val_neg, Units.val_one]; linarith
    have hgw := hpos ((-1 : ℝˣ) * u) hw
    rw [map_mul, hgm1] at hgw
    exact mul_left_cancel hgw
  · exact absurd hu u.ne_zero
  · exact hpos u hu

/-! ### Main real theorem -/

/--
**Determinant from a real full-monoid homomorphism (all `n`).** A monoid homomorphism
`f : Mₙ(ℝ) →* ℝ` that is multiplicative on *all* real matrices, with (H2) `f(μ • I) = μⁿ` for every
`μ ∈ ℝˣ` and (H3) `f(diag(-1 at i₀, 1 else)) = -1`, equals the determinant: `f A = det A` for every
`A`. No regularity and no parity assumption — (H3) (a single reflection has value `-1`) is exactly
what excludes the even-`n` solution `|det|`. -/
theorem monoidHom_eq_det_of_real [Nonempty n] (f : Matrix n n ℝ →* ℝ) (i0 : n)
    (H2 : ∀ μ : ℝˣ, f (μ • 1) = (μ : ℝ) ^ Fintype.card n)
    (H3 : f (Matrix.diagonal (fun i => if i = i0 then (-1 : ℝ) else 1)) = -1)
    (A : Matrix n n ℝ) : f A = A.det := by
  set F := Units.map f with hF
  -- Read off the `F`-level normalizations (H2), (H3).
  have h2F : ∀ u : ℝˣ,
      F (diagonalGL (fun _ => (u : ℝ)) (fun _ => u.ne_zero)) = u ^ Fintype.card n := by
    intro u
    apply Units.ext
    rw [hF, Units.coe_map, coe_diagonalGL, Units.val_pow_eq_pow_val,
      ← Matrix.smul_one_eq_diagonal]
    exact H2 u
  have h3F : F (oneSlotDiagonalGL i0 (-1)) = -1 := by
    apply Units.ext
    rw [hF, Units.coe_map, coe_oneSlotDiagonalGL]
    simp only [Units.val_neg, Units.val_one]
    exact H3
  have gid := diagonalFactorOfHom_eq_id F i0 h2F h3F
  -- `f = det` on units.
  have hf_unit : ∀ U : (Matrix n n ℝ)ˣ, f (U : Matrix n n ℝ) = (U : Matrix n n ℝ).det := by
    intro U
    have hfac := hom_factor_det F i0 U
    rw [gid, MonoidHom.id_apply] at hfac
    have := congrArg Units.val hfac
    rwa [hF, Units.coe_map, coe_detGL] at this
  -- `f = 0` on any matrix with a zero column.
  have hf_zero_col : ∀ (M : Matrix n n ℝ) (k : n), (∀ i, M i k = 0) → f M = 0 := by
    intro M k hcol
    set d : n → ℝ := fun i => if i = k then 2 else 1 with hd_def
    have hprod : (∏ i : n, d i) = 2 := by
      have hps := Finset.prod_eq_single (s := (Finset.univ : Finset n)) (f := d) k
        (fun b _ hb => by simp [hd_def, hb]) (fun hk' => absurd (Finset.mem_univ k) hk')
      rw [hps]; simp [hd_def]
    have hdiag_unit : IsUnit (Matrix.diagonal d) := by
      rw [Matrix.isUnit_iff_isUnit_det, Matrix.det_diagonal, isUnit_iff_ne_zero, hprod]; norm_num
    have hf_diag : f (Matrix.diagonal d) = 2 := by
      obtain ⟨U, hU⟩ := hdiag_unit
      rw [← hU, hf_unit U, hU, Matrix.det_diagonal, hprod]
    have hMd : M * Matrix.diagonal d = M := by
      ext i j; rw [Matrix.mul_diagonal]
      rcases eq_or_ne j k with hj | hj
      · subst hj; simp [hcol i]
      · simp [hd_def, hj]
    have hkey : f M = f M * 2 := by conv_lhs => rw [← hMd]; rw [map_mul, hf_diag]
    linear_combination -hkey
  -- Conclude.
  by_cases hA : IsUnit A
  · obtain ⟨U, rfl⟩ := hA; exact hf_unit U
  · have hdet0 : A.det = 0 := by
      by_contra hne
      exact hA ((Matrix.isUnit_iff_isUnit_det A).mpr (isUnit_iff_ne_zero.mpr hne))
    obtain ⟨v, hv, hAv⟩ := (Matrix.exists_mulVec_eq_zero_iff (M := A)).mpr hdet0
    obtain ⟨k, hk⟩ : ∃ k, v k ≠ 0 := Function.ne_iff.mp hv
    set Q : Matrix n n ℝ := Matrix.updateCol 1 k v with hQ_def
    have hQdet : Q.det = v k := by
      have hsum : (fun l => ∑ i, v i • (1 : Matrix n n ℝ) l i) = v := by
        funext l; simp [Matrix.one_apply]
      have hds := Matrix.det_updateCol_sum (1 : Matrix n n ℝ) k v
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
    have hfQ : f Q ≠ 0 := by
      obtain ⟨U, hU⟩ := hQ_unit
      rw [← hU, hf_unit U, hU, hQdet]; exact hk
    have hzero : f A * f Q = 0 := by rw [← map_mul]; exact hfAQ
    rw [hdet0]
    exact (mul_eq_zero.mp hzero).resolve_right hfQ

/-! ### (H3) is necessary: for even `n`, `|det|` is a second solution -/

/-- `|det|` packaged as a monoid homomorphism `Mₙ(ℝ) →* ℝ` (it is multiplicative). -/
def absDetHom : Matrix n n ℝ →* ℝ where
  toFun A := |A.det|
  map_one' := by simp
  map_mul' A B := by rw [Matrix.det_mul, abs_mul]

/--
**(H3) is genuinely needed.** For **even** `n`, dropping (H3) breaks the characterization: a
homomorphism (namely `|det|`) satisfies (H1) and (H2) yet is not `det`. So the even-`n` statement
with only (H1) and (H2) is false — exactly the `|det|` loophole that (H3) closes. -/
-- ANCHOR: dethom-real-counterexample
theorem not_characterization_real_even [Nonempty n] (hn : Even (Fintype.card n)) :
    ¬ ∀ (f : Matrix n n ℝ →* ℝ),
        (∀ μ : ℝˣ, f (μ • 1) = (μ : ℝ) ^ Fintype.card n) → ∀ A, f A = A.det
-- ANCHOR_END: dethom-real-counterexample
    := by
  intro H
  have hH2 : ∀ μ : ℝˣ,
      (absDetHom : Matrix n n ℝ →* ℝ) (μ • 1) = (μ : ℝ) ^ Fintype.card n := by
    intro μ
    change |((μ • (1 : Matrix n n ℝ)).det)| = (μ : ℝ) ^ Fintype.card n
    rw [Units.smul_def, Matrix.det_smul, Matrix.det_one, mul_one]
    exact abs_of_nonneg (hn.pow_nonneg _)
  have key := H absDetHom hH2
  -- evaluate at a reflection: det = -1 but `|det| = 1`
  set d : n → ℝ := Function.update (fun _ => (1 : ℝ)) (Classical.arbitrary n) (-1) with hd
  have hdet : (Matrix.diagonal d).det = -1 := by
    rw [Matrix.det_diagonal, Finset.prod_update_of_mem (Finset.mem_univ _)]; simp
  have hbad := key (Matrix.diagonal d)
  rw [show (absDetHom (Matrix.diagonal d)) = |(Matrix.diagonal d).det| from rfl, hdet] at hbad
  norm_num at hbad

/-! ### `Fin n` corollary: the exponent is literally `n`, with (H1), (H2), (H3) spelled out -/

section Fin

/--
**Determinant from (H1), (H2), (H3) on `Fin n` matrices.** A bare function
`f : Matrix (Fin n) (Fin n) ℝ → ℝ` with

* **(H1)** `f (A * B) = f A * f B`  (multiplicative on all matrices),
* **(H2)** `f (μ • 1) = μⁿ`  for every `μ ∈ ℝˣ`  (scalar normalization),
* **(H3)** `f (diag(-1, 1, …, 1)) = -1`  (the reflection at slot `0` has value `-1`),

equals the determinant: `f A = det A` for every `A`. The dimension `n : ℕ` is a parameter of the
theorem itself and the exponent is the literal `n`. (H3) is what makes this hold for **every** `n`,
including even `n` where it would otherwise fail (`not_characterization_real_even`). -/
-- ANCHOR: dethom-real-fin
theorem eq_det_of_mul_of_scalar_pow_of_reflection_fin {n : ℕ} [NeZero n]
    (f : Matrix (Fin n) (Fin n) ℝ → ℝ)
    (H1 : ∀ A B, f (A * B) = f A * f B)
    (H2 : ∀ μ : ℝˣ, f (μ • 1) = μ ^ n)
    (H3 : f (Matrix.diagonal (fun i => if i = 0 then -1 else 1)) = -1) :
    ∀ A, f A = A.det
-- ANCHOR_END: dethom-real-fin
    := by
  intro A
  have hf1 : f 1 = 1 := by
    have h := H2 1
    simp only [Units.val_one, one_pow, one_smul] at h
    exact h
  let fHom : Matrix (Fin n) (Fin n) ℝ →* ℝ := { toFun := f, map_one' := hf1, map_mul' := H1 }
  have H2' : ∀ μ : ℝˣ, fHom (μ • 1) = (μ : ℝ) ^ Fintype.card (Fin n) := by
    intro μ; rw [Fintype.card_fin]; exact H2 μ
  have H3' : fHom (Matrix.diagonal (fun i => if i = (0 : Fin n) then (-1 : ℝ) else 1)) = -1 := H3
  exact monoidHom_eq_det_of_real fHom 0 H2' H3' A

end Fin

end Real

end MathNotesLean
