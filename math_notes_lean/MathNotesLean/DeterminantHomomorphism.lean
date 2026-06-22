/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib
import MathNotesLean.CstarHomomorphism

/-!
# Determinant from homomorphism

This file starts the Lean formalization of `determinant_homomorphism.md`.

It records the checked determinant side of the note using mathlib's Leibniz determinant
`Matrix.det`: the determinant homomorphism on `GLₙ(ℂ)`, its values on diagonal matrices and
transvections, and the fact that post-composing it with any homomorphism `ℂˣ → ℂˣ` gives a
homomorphism `GLₙ(ℂ) → ℂˣ`.
-/

noncomputable section

namespace MathNotesLean

open Matrix

section GeneralLinear

variable {n : Type*} [DecidableEq n] [Fintype n]

/-- The determinant homomorphism on `GLₙ(ℂ)`, landing in nonzero complex numbers. -/
def detGL : Matrix.GeneralLinearGroup n ℂ →* ℂˣ :=
  Units.map (Matrix.detMonoidHom : Matrix n n ℂ →* ℂ)

@[simp]
theorem coe_detGL_apply (A : Matrix.GeneralLinearGroup n ℂ) :
    ((detGL A : ℂˣ) : ℂ) = Matrix.det (A : Matrix n n ℂ) :=
  rfl

-- ANCHOR: dethom-leibniz-mult
/-- Determinant is multiplicative on `GLₙ(ℂ)`. -/
theorem detGL_mul (A B : Matrix.GeneralLinearGroup n ℂ) :
    detGL (A * B) = detGL A * detGL B :=
  map_mul detGL A B
-- ANCHOR_END: dethom-leibniz-mult

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

/-- On an invertible diagonal matrix, the determinant is the product of the diagonal entries. -/
theorem detGL_diagonal (d : n → ℂ) (hd : ∀ i, d i ≠ 0) :
    ((detGL (diagonalGL d hd) : ℂˣ) : ℂ) = ∏ i, d i := by
  simp [detGL, diagonalGL, Matrix.det_diagonal]

/-- The determinant of an invertible diagonal matrix, as a unit: the product of the entries. -/
theorem detGL_diagonalGL (d : n → ℂ) (hd : ∀ i, d i ≠ 0) :
    detGL (diagonalGL d hd) = ∏ i, Units.mk0 (d i) (hd i) := by
  apply Units.ext
  rw [detGL_diagonal, Units.coe_prod]
  simp [Units.val_mk0]

/-- Post-composing determinant with a homomorphism `ℂˣ → ℂˣ`. -/
def postcomposeDetGL (g : ℂˣ →* ℂˣ) : Matrix.GeneralLinearGroup n ℂ →* ℂˣ :=
  g.comp detGL

@[simp]
theorem postcomposeDetGL_apply (g : ℂˣ →* ℂˣ) (A : Matrix.GeneralLinearGroup n ℂ) :
    postcomposeDetGL g A = g (detGL A) :=
  rfl

/-- Every `g ∘ det` is a homomorphism `GLₙ(ℂ) → ℂˣ`. -/
theorem postcomposeDetGL_mul (g : ℂˣ →* ℂˣ) (A B : Matrix.GeneralLinearGroup n ℂ) :
    postcomposeDetGL g (A * B) = postcomposeDetGL g A * postcomposeDetGL g B :=
  map_mul (postcomposeDetGL g) A B

/-- The elementary transvection matrix `I + c Eᵢⱼ`, in mathlib's notation. -/
def transvectionMatrix (i j : n) (c : ℂ) : Matrix n n ℂ :=
  Matrix.transvection i j c

/-- A transvection with `i ≠ j` has determinant one. -/
theorem det_transvectionMatrix {i j : n} (hij : i ≠ j) (c : ℂ) :
    Matrix.det (transvectionMatrix i j c) = 1 := by
  simpa [transvectionMatrix] using Matrix.det_transvection_of_ne i j hij c

/-- Every special-linear matrix has determinant one under `detGL`. -/
theorem detGL_specialLinear (A : Matrix.SpecialLinearGroup n ℂ) :
    ((detGL (Matrix.SpecialLinearGroup.toGL A) : ℂˣ) : ℂ) = 1 := by
  simp [detGL, Matrix.SpecialLinearGroup.det_coe A]

/-- Transvections, viewed as elements of `SLₙ(ℂ) ⊂ GLₙ(ℂ)`, have determinant one. -/
theorem detGL_transvection_value {i j : n} (hij : i ≠ j) (c : ℂ) :
    ((detGL (Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij c)) :
      ℂˣ) : ℂ) = 1 :=
  detGL_specialLinear (Matrix.SpecialLinearGroup.transvection hij c)

-- ANCHOR: dethom-leibniz-formula
/-- The Leibniz formula used by mathlib's determinant. -/
theorem determinant_leibniz_formula (A : Matrix n n ℂ) :
    Matrix.det A = ∑ σ : Equiv.Perm n, Equiv.Perm.sign σ • ∏ i, A (σ i) i :=
  Matrix.det_apply A
-- ANCHOR_END: dethom-leibniz-formula

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

/-- The determinant of a one-slot diagonal matrix is its chosen entry. -/
theorem detGL_oneSlotDiagonalGL (i0 : n) (x : ℂˣ) : detGL (oneSlotDiagonalGL i0 x) = x := by
  ext
  simp [oneSlotDiagonalGL]

/-- The one-variable factor read off from a homomorphism on one diagonal slot. -/
def diagonalFactorOfHom (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) : ℂˣ →* ℂˣ where
  toFun x := f (oneSlotDiagonalGL i0 x)
  map_one' := by simp
  map_mul' x y := by rw [oneSlotDiagonalGL_mul i0 x y, map_mul]

/-- A `GLₙ(ℂ)` matrix with determinant one, viewed as an element of `SLₙ(ℂ)`. -/
def specialOfDetOne (A : Matrix.GeneralLinearGroup n ℂ) (hA : detGL A = 1) :
    Matrix.SpecialLinearGroup n ℂ :=
  ⟨(A : Matrix n n ℂ), by
    have h := congrArg Units.val hA
    simpa [detGL] using h⟩

@[simp]
theorem toGL_specialOfDetOne (A : Matrix.GeneralLinearGroup n ℂ) (hA : detGL A = 1) :
    Matrix.SpecialLinearGroup.toGL (specialOfDetOne A hA) = A := by
  ext i j
  rfl

/--
If a homomorphism `GLₙ(ℂ) → ℂˣ` is trivial on `SLₙ(ℂ)`, then it factors through determinant.

In the note, triviality on `SLₙ(ℂ)` is obtained from transvections plus the generation argument.
This theorem records the final algebraic factorization step.
-/
theorem factor_of_trivial_on_specialLinear (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (hSL : ∀ S : Matrix.SpecialLinearGroup n ℂ, f (Matrix.SpecialLinearGroup.toGL S) = 1)
    (A : Matrix.GeneralLinearGroup n ℂ) :
    f A = diagonalFactorOfHom i0 f (detGL A) := by
  let D := oneSlotDiagonalGL i0 (detGL A)
  let S : Matrix.GeneralLinearGroup n ℂ := D⁻¹ * A
  have hdetS : detGL S = 1 := by
    simp [S, D, detGL_oneSlotDiagonalGL]
  have hSgl : Matrix.SpecialLinearGroup.toGL (specialOfDetOne S hdetS) = S :=
    toGL_specialOfDetOne S hdetS
  have hS : f S = 1 := by
    rw [← hSgl]
    exact hSL (specialOfDetOne S hdetS)
  have hA : A = D * S := by simp [S, D]
  calc
    f A = f (D * S) := by rw [hA]
    _ = f D * f S := map_mul f D S
    _ = f D := by simp [hS]
    _ = diagonalFactorOfHom i0 f (detGL A) := rfl

-- ANCHOR: dethom-conjugation
/--
**Step 1 (conjugation invariance).** A homomorphism `GLₙ(ℂ) → ℂˣ` is invariant under conjugation,
because its target `ℂˣ` is commutative: `f (P A P⁻¹) = f A`.
-/
theorem hom_conj_eq (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (P A : Matrix.GeneralLinearGroup n ℂ) : f (P * A * P⁻¹) = f A := by
  rw [map_mul, map_mul, map_inv, mul_comm (f P) (f A), mul_assoc, mul_inv_cancel, mul_one]
-- ANCHOR_END: dethom-conjugation

/-- A transvection `I + c Eᵢⱼ` (with `i ≠ j`) as an element of `GLₙ(ℂ)`. -/
def transvectionGL {i j : n} (hij : i ≠ j) (c : ℂ) : Matrix.GeneralLinearGroup n ℂ :=
  Matrix.SpecialLinearGroup.toGL (Matrix.SpecialLinearGroup.transvection hij c)

@[simp]
theorem coe_transvectionGL {i j : n} (hij : i ≠ j) (c : ℂ) :
    ((transvectionGL hij c : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.transvection i j c := by
  rw [transvectionGL]
  rfl

/--
**Step 2 (diagonal conjugation).** Conjugating a transvection by an invertible diagonal matrix
rescales the off-diagonal entry: `D Tᵢⱼ(c) D⁻¹ = Tᵢⱼ((dᵢ/dⱼ) c)`.
-/
-- ANCHOR: dethom-diag-conj
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
-- ANCHOR_END: dethom-diag-conj

@[simp]
theorem coe_diagonalGL_inv (d : n → ℂ) (hd : ∀ i, d i ≠ 0) :
    (((diagonalGL d hd)⁻¹ : Matrix.GeneralLinearGroup n ℂ) : Matrix n n ℂ)
      = Matrix.diagonal (fun i => (d i)⁻¹) :=
  rfl

-- ANCHOR: dethom-transvection-value
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
-- ANCHOR_END: dethom-transvection-value

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

-- ANCHOR: dethom-diagonal-product
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
-- ANCHOR_END: dethom-diagonal-product

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

-- ANCHOR: dethom-generation
/--
`eq-dethom-transvection-diagonal-factorization`. **Transvections and diagonal matrices generate
`GLₙ(ℂ)`.** Every `A ∈ GLₙ(ℂ)` factors as `A = E · D` with `E` a product of transvections and `D`
an invertible diagonal matrix. (Obtained from mathlib's two-sided transvection normal form by
conjugating the right-hand transvections through the diagonal, using the Step 2 formula.)
-/
theorem exists_transvec_diagonal_factorization (A : Matrix.GeneralLinearGroup n ℂ) :
    ∃ (E : List (Matrix.TransvectionStruct n ℂ)) (D : n → ℂ) (hD : ∀ i, D i ≠ 0),
      A = (E.map transvecStructGL).prod * diagonalGL D hD := by
  obtain ⟨L, L', D, hLDL'⟩ :=
    Matrix.Pivot.exists_list_transvec_mul_diagonal_mul_list_transvec (A : Matrix n n ℂ)
  have hdetA : (A : Matrix n n ℂ).det ≠ 0 := by
    rw [← coe_detGL_apply]
    exact (detGL A).ne_zero
  have hprod : ∏ i, D i = (A : Matrix n n ℂ).det := by
    have hdet := congrArg Matrix.det hLDL'
    rw [Matrix.det_mul, Matrix.det_mul, Matrix.TransvectionStruct.det_toMatrix_prod,
      Matrix.TransvectionStruct.det_toMatrix_prod, Matrix.det_diagonal] at hdet
    simpa using hdet.symm
  have hD : ∀ i, D i ≠ 0 := by
    intro i
    refine Finset.prod_ne_zero_iff.mp ?_ i (Finset.mem_univ i)
    rw [hprod]; exact hdetA
  have hAtwo : A
      = (L.map transvecStructGL).prod * diagonalGL D hD * (L'.map transvecStructGL).prod := by
    apply Units.ext
    rw [Units.val_mul, Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL,
      coe_prod_transvecStructGL]
    exact hLDL'
  refine ⟨L ++ L'.map (conjDiagStruct D), D, hD, ?_⟩
  rw [List.map_append, List.prod_append, ← conjGL_prod D hD L', hAtwo]
  group
-- ANCHOR_END: dethom-generation

/--
**Generation, and triviality on `SLₙ(ℂ)`.** Transvections and diagonal matrices generate
`GLₙ(ℂ)` (the transvection–diagonal decomposition `eq-dethom-transvection-diagonal-factorization`).
Combined with `f(Tᵢⱼ(c)) = 1` (`eq-dethom-transvection-value`),
`f(diag D) = g(∏ Dⱼ)` (`eq-dethom-diagonal-product`), and `∏ Dⱼ = det = 1`, any homomorphism
`f : GLₙ(ℂ) → ℂˣ` is trivial on `SLₙ(ℂ)`.
-/
theorem hom_special_eq_one (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (S : Matrix.SpecialLinearGroup n ℂ) : f (Matrix.SpecialLinearGroup.toGL S) = 1 := by
  obtain ⟨L, L', D, hLDL'⟩ :=
    Matrix.Pivot.exists_list_transvec_mul_diagonal_mul_list_transvec (S : Matrix n n ℂ)
  have hprod : ∏ i, D i = 1 := by
    have hdet := congrArg Matrix.det hLDL'
    rw [Matrix.SpecialLinearGroup.det_coe, Matrix.det_mul, Matrix.det_mul,
      Matrix.TransvectionStruct.det_toMatrix_prod,
      Matrix.TransvectionStruct.det_toMatrix_prod, Matrix.det_diagonal] at hdet
    simpa using hdet.symm
  have hD : ∀ i, D i ≠ 0 := by
    intro i
    refine Finset.prod_ne_zero_iff.mp ?_ i (Finset.mem_univ i)
    rw [hprod]; exact one_ne_zero
  have hGL : Matrix.SpecialLinearGroup.toGL S
      = (L.map transvecStructGL).prod * diagonalGL D hD * (L'.map transvecStructGL).prod := by
    apply Units.ext
    rw [Units.val_mul, Units.val_mul, coe_prod_transvecStructGL, coe_diagonalGL,
      coe_prod_transvecStructGL]
    exact hLDL'
  rw [hGL, map_mul, map_mul, hom_prod_transvecStructGL_eq_one,
    hom_prod_transvecStructGL_eq_one, mul_one, one_mul, hom_diagonalGL_eq f i0 D hD]
  have hone : (∏ j, Units.mk0 (D j) (hD j)) = 1 := by
    apply Units.ext
    rw [Units.coe_prod]
    simp only [Units.val_mk0, Units.val_one]
    exact hprod
  rw [hone, map_one]

-- ANCHOR: dethom-factorization
/--
**Factorization theorem `f = g ∘ det`.** Every homomorphism `f : GLₙ(ℂ) → ℂˣ` factors through the
determinant: `f(A) = g(det A)`, where `g = diagonalFactorOfHom i0 f` is the one-variable
homomorphism `ℂˣ → ℂˣ` read off from `f` on a single diagonal slot. This is the boxed equation
`f(A) = g(L(A))` of the note, with the single-valued Leibniz determinant `L = Matrix.det`.
-/
theorem hom_factor_det (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (A : Matrix.GeneralLinearGroup n ℂ) :
    f A = diagonalFactorOfHom i0 f (detGL A) :=
  factor_of_trivial_on_specialLinear i0 f (hom_special_eq_one f i0) A

/--
The note's boxed statement in existential form: every homomorphism `f : GLₙ(ℂ) → ℂˣ` equals
`g ∘ det` **for some** group homomorphism `g : ℂˣ → ℂˣ` (here `ℂˣ = ℂ*`). The witness is the
explicit one-variable factor `g = diagonalFactorOfHom i0 f`.
-/
theorem exists_hom_factor_det (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n) :
    ∃ g : ℂˣ →* ℂˣ, ∀ A : Matrix.GeneralLinearGroup n ℂ, f A = g (detGL A) :=
  ⟨diagonalFactorOfHom i0 f, hom_factor_det f i0⟩

/--
**Uniqueness of the factor `g`.** Given `f`, the homomorphism `g : ℂˣ → ℂˣ` with `f = g ∘ det` is
*unique*: since the determinant is surjective onto `ℂˣ` (every unit `w` is `det(diag(w,1,…,1))`),
any two factors agree on all of `ℂˣ`. The unique factor is `g = diagonalFactorOfHom i0 f`.
-/
theorem existsUnique_hom_factor_det (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n) :
    ∃! g : ℂˣ →* ℂˣ, ∀ A : Matrix.GeneralLinearGroup n ℂ, f A = g (detGL A) := by
  refine ⟨diagonalFactorOfHom i0 f, hom_factor_det f i0, ?_⟩
  intro g hg
  refine MonoidHom.ext fun w => ?_
  have hA := hg (oneSlotDiagonalGL i0 w)
  rw [detGL_oneSlotDiagonalGL] at hA
  exact hA.symm
-- ANCHOR_END: dethom-factorization

-- ANCHOR: dethom-g-hom
/--
`eq-dethom-g-homomorphism`. The one-variable factor `g = diagonalFactorOfHom i0 f` is a
homomorphism `ℂˣ → ℂˣ`: `g(xy) = g(x) g(y)`.
-/
theorem diagonalFactorOfHom_mul (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (x y : ℂˣ) :
    diagonalFactorOfHom i0 f (x * y)
      = diagonalFactorOfHom i0 f x * diagonalFactorOfHom i0 f y :=
  map_mul _ x y
-- ANCHOR_END: dethom-g-hom

-- ANCHOR: dethom-diagonal-slot
/--
`eq-dethom-diagonal-slot`. The value of `f` on a single populated diagonal slot is exactly the
one-variable factor `g`: `f(diag(1,…,x at i,…,1)) = g(x)`.
-/
theorem hom_oneSlotDiagonalGL_eq_g (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 i : n) (x : ℂˣ) :
    f (oneSlotDiagonalGL i x) = diagonalFactorOfHom i0 f x :=
  hom_oneSlotDiagonalGL_pos_invariant f i0 i x
-- ANCHOR_END: dethom-diagonal-slot

-- ANCHOR: dethom-uniqueness
/--
**Uniqueness.** Two homomorphisms `GLₙ(ℂ) → ℂˣ` that agree on the diagonal matrices
`diag(x,1,…,1)` agree on all of `GLₙ(ℂ)`: a homomorphism has no freedom beyond its values on
diagonal matrices.
-/
theorem hom_eq_of_eq_on_oneSlot (i0 : n) (f₁ f₂ : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (h : ∀ x, f₁ (oneSlotDiagonalGL i0 x) = f₂ (oneSlotDiagonalGL i0 x))
    (A : Matrix.GeneralLinearGroup n ℂ) : f₁ A = f₂ A := by
  rw [hom_factor_det f₁ i0, hom_factor_det f₂ i0]
  exact h (detGL A)

/--
**Characterization of the determinant.** `detGL` is the unique homomorphism `GLₙ(ℂ) → ℂˣ` whose
value on every invertible diagonal matrix is the product of its diagonal entries: any homomorphism
normalized so that `g = id` (`f(diag(x,1,…,1)) = x`) equals the determinant.
-/
theorem hom_eq_detGL_of_normalized (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ)
    (h : ∀ x, f (oneSlotDiagonalGL i0 x) = x) (A : Matrix.GeneralLinearGroup n ℂ) :
    f A = detGL A := by
  rw [hom_factor_det f i0]
  exact h (detGL A)
-- ANCHOR_END: dethom-uniqueness

-- ANCHOR: dethom-leibniz-factorization
/--
`eq-dethom-leibniz-factorization`. Fed a transvection–diagonal factorization `A = E · D`, the
determinant peels off the transvections (each has determinant `1`) and returns the product of the
diagonal entries: `det(E · D) = ∏ⱼ Dⱼ`. (Here `det` is the single-valued Leibniz determinant
`Matrix.det`, and `eq-dethom-leibniz-multiplicativity` is `detGL_mul`.)
-/
theorem detGL_factorization (E : List (Matrix.TransvectionStruct n ℂ)) (D : n → ℂ)
    (hD : ∀ i, D i ≠ 0) :
    detGL ((E.map transvecStructGL).prod * diagonalGL D hD) = ∏ j, Units.mk0 (D j) (hD j) := by
  rw [map_mul, hom_prod_transvecStructGL_eq_one detGL E, one_mul, detGL_diagonalGL]
-- ANCHOR_END: dethom-leibniz-factorization

-- ANCHOR: dethom-converse
/--
**Converse / characterization of all homomorphisms.** Every homomorphism `f : GLₙ(ℂ) → ℂˣ` is the
post-composition of the determinant with the homomorphism `g = diagonalFactorOfHom i0 f`, and
conversely `postcomposeDetGL g = g ∘ det` is a homomorphism for every `g : ℂˣ → ℂˣ`
(`postcomposeDetGL`). Hence the homomorphisms `GLₙ(ℂ) → ℂˣ` are exactly the `g ∘ det`.
-/
theorem hom_eq_postcomposeDetGL (i0 : n) (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) :
    f = postcomposeDetGL (diagonalFactorOfHom i0 f) := by
  ext A
  rw [postcomposeDetGL_apply, hom_factor_det f i0]
-- ANCHOR_END: dethom-converse

-- ANCHOR: dethom-cstar
/-- The determinant's own one-variable factor is the identity, i.e. `det` corresponds to the polar
exponents `s = 1`, `k = 1` (`cstarFormulaHom 1 1 = id`). -/
theorem diagonalFactorOfHom_detGL (i0 : n) :
    diagonalFactorOfHom i0 detGL = MonoidHom.id ℂˣ := by
  ext x
  simp [diagonalFactorOfHom, detGL_oneSlotDiagonalGL]

/--
**Link to `ℂ* → ℂ*` classification.** If the one-variable factor `g = diagonalFactorOfHom i0 f` is
Borel measurable (in particular if it is continuous), then `f` has the closed form
`f(A) = |det A|ˢ · (det A / |det A|)ᵏ` for some `s ∈ ℂ`, `k ∈ ℤ`, by the classification of
measurable homomorphisms `ℂ* → ℂ*`. The determinant itself is the case `s = 1`, `k = 1`
(`diagonalFactorOfHom_detGL`).
-/
theorem hom_factor_det_cstar (f : Matrix.GeneralLinearGroup n ℂ →* ℂˣ) (i0 : n)
    (hg : Measurable (diagonalFactorOfHom i0 f)) :
    ∃ s : ℂ, ∃ k : ℤ, ∀ A : Matrix.GeneralLinearGroup n ℂ,
      f A = cstarNormCPow s (detGL A) * cstarCircleUnit (detGL A) ^ k := by
  obtain ⟨s, k, hsk⟩ := cstar_homomorphism_formula_measurable (diagonalFactorOfHom i0 f) hg
  exact ⟨s, k, fun A => by rw [hom_factor_det f i0, hsk]⟩
-- ANCHOR_END: dethom-cstar

end GeneralLinear

end MathNotesLean
