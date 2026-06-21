/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib

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

/-- Determinant is multiplicative on `GLₙ(ℂ)`. -/
theorem detGL_mul (A B : Matrix.GeneralLinearGroup n ℂ) :
    detGL (A * B) = detGL A * detGL B :=
  map_mul detGL A B

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

/-- The Leibniz formula used by mathlib's determinant. -/
theorem determinant_leibniz_formula (A : Matrix n n ℂ) :
    Matrix.det A = ∑ σ : Equiv.Perm n, Equiv.Perm.sign σ • ∏ i, A (σ i) i :=
  Matrix.det_apply A

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

end GeneralLinear

end MathNotesLean
