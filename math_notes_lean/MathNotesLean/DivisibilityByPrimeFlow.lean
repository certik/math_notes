/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib

/-!
# Divisibility by any prime — flow-faithful development

This file formalizes `divisibility_by_prime.md`, following the note's own logical order.

To test whether an integer `n` is divisible by a modulus `p`, write `n = 10 * a + b` (so `b` is
the last digit) and form the `2 × 2` determinant

  `|a  b|`
  `|k  1|  =  a - k * b`,

where `k` depends only on `p`.  The claim is that `n` is divisible by `p` **iff** this determinant
is.  Iterating shrinks the number until divisibility is obvious.

The whole method rests on a single algebraic fact.  Choose `k` so that `10 * k + 1` is a multiple
of `p`; concretely, so that `10 * k + 1 = m * p` for some integer `m`.  Then

  `10 * (a - k * b) = (10 * a + b) - (10 * k + 1) * b`,

so modulo `p` the numbers `10 * (a - k * b)` and `10 * a + b` agree, and since `10` is invertible
modulo `p` this transfers to `a - k * b` itself.  The same identity `10 * k + 1 = m * p` is exactly
a Bézout certificate that `10` and `p` are coprime, so no separate hypothesis is needed.

Finding such a `k` is elementary and splits on the last digit of `p`:

* `p` ends in `1`:  `k = ⌊p / 10⌋`,      certificate `10 * k + 1 = 1 * p`;
* `p` ends in `3`:  `k = ⌊7 * p / 10⌋`,  certificate `10 * k + 1 = 7 * p`;
* `p` ends in `7`:  `k = ⌊3 * p / 10⌋`,  certificate `10 * k + 1 = 3 * p`;
* `p` ends in `9`:  `k = ⌊9 * p / 10⌋`,  certificate `10 * k + 1 = 9 * p`.

These are the four last digits for which `p` is coprime to `10`, i.e. exactly the odd primes other
than `5` — the setting of the note.  Primality itself plays no role in the core equivalence; only
coprimality with `10` does, and that is what the last-digit condition guarantees.

Reference: R. A. Watson, *Tests for Divisibility*, The Mathematical Gazette **87** (2003), 493–494;
see also <https://www.johndcook.com/blog/2021/02/17/divisibility-by-any-prime/>.
-/

open Matrix

namespace MathNotesLean

namespace DivisibilityFlow

/-! ### The determinant of the divisibility test -/

-- ANCHOR: flow-div-det
/-- The determinant appearing in the test is `a - k * b`:
`det ![![a, b], ![k, 1]] = a * 1 - b * k = a - k * b`. -/
theorem det_eq (a b k : ℤ) : Matrix.det !![a, b; k, 1] = a - k * b := by
  rw [Matrix.det_fin_two_of]; ring
-- ANCHOR_END: flow-div-det

/-! ### Coprimality is automatic from the certificate -/

-- ANCHOR: flow-div-coprime
/-- The certificate `10 * k + 1 = m * p` is a Bézout identity `(-k) * 10 + m * p = 1`, so it forces
`10` and `p` to be coprime.  Equivalently, this is why the method needs `p` to end in `1, 3, 7, 9`:
those are exactly the last digits for which `p` is coprime to `10`. -/
theorem isCoprime_ten {p k m : ℤ} (hmp : 10 * k + 1 = m * p) : IsCoprime (10 : ℤ) p :=
  ⟨-k, m, by linear_combination -hmp⟩
-- ANCHOR_END: flow-div-coprime

/-! ### The core equivalence -/

-- ANCHOR: flow-div-core
/-- **The heart of the method.**  If `10 * k + 1 = m * p` for some integer `m`, then for all `a b`,
`p` divides `10 * a + b` **iff** `p` divides the determinant `a - k * b`.

The forward direction uses `10 * (a - k * b) = (10 * a + b) - (10 * k + 1) * b` together with
coprimality of `10` and `p` (itself supplied by the certificate); the converse uses the same
identity read backwards and needs no coprimality. -/
theorem dvd_iff {p k m : ℤ} (hmp : 10 * k + 1 = m * p) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ (a - k * b) := by
  have hpk : p ∣ (10 * k + 1) := ⟨m, by linear_combination hmp⟩
  have hcop : IsCoprime p 10 := (isCoprime_ten hmp).symm
  constructor
  · intro hdvd
    have key : 10 * (a - k * b) = (10 * a + b) - (10 * k + 1) * b := by ring
    have h1 : p ∣ 10 * (a - k * b) := by
      rw [key]; exact dvd_sub hdvd (hpk.mul_right b)
    exact hcop.dvd_of_dvd_mul_left h1
  · intro hdvd
    have key : 10 * a + b = 10 * (a - k * b) + (10 * k + 1) * b := by ring
    rw [key]
    exact dvd_add (hdvd.mul_left 10) (hpk.mul_right b)
-- ANCHOR_END: flow-div-core

-- ANCHOR: flow-div-det-form
/-- The core equivalence phrased with the literal determinant: `p ∣ 10 * a + b` iff `p` divides
`det ![![a, b], ![k, 1]]`. -/
theorem dvd_iff_dvd_det {p k m : ℤ} (hmp : 10 * k + 1 = m * p) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ Matrix.det !![a, b; k, 1] := by
  rw [det_eq]; exact dvd_iff hmp a b
-- ANCHOR_END: flow-div-det-form

/-! ### Finding `k` from the last digit of `p` -/

-- ANCHOR: flow-div-k-cases
/-- If `p` ends in `1`, then `k = ⌊p / 10⌋` satisfies the certificate `10 * k + 1 = 1 * p`. -/
theorem k_digit_one {p : ℤ} (hp : p % 10 = 1) : 10 * (p / 10) + 1 = 1 * p := by omega

/-- If `p` ends in `3`, then `k = ⌊7 * p / 10⌋` satisfies the certificate `10 * k + 1 = 7 * p`. -/
theorem k_digit_three {p : ℤ} (hp : p % 10 = 3) : 10 * (7 * p / 10) + 1 = 7 * p := by omega

/-- If `p` ends in `7`, then `k = ⌊3 * p / 10⌋` satisfies the certificate `10 * k + 1 = 3 * p`. -/
theorem k_digit_seven {p : ℤ} (hp : p % 10 = 7) : 10 * (3 * p / 10) + 1 = 3 * p := by omega

/-- If `p` ends in `9`, then `k = ⌊9 * p / 10⌋` satisfies the certificate `10 * k + 1 = 9 * p`. -/
theorem k_digit_nine {p : ℤ} (hp : p % 10 = 9) : 10 * (9 * p / 10) + 1 = 9 * p := by omega
-- ANCHOR_END: flow-div-k-cases

/-! ### The four ready-to-use divisibility tests -/

-- ANCHOR: flow-div-tests
/-- Divisibility test for a `p` ending in `1`. -/
theorem test_digit_one {p : ℤ} (hp : p % 10 = 1) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ (a - (p / 10) * b) :=
  dvd_iff (k_digit_one hp) a b

/-- Divisibility test for a `p` ending in `3`. -/
theorem test_digit_three {p : ℤ} (hp : p % 10 = 3) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ (a - (7 * p / 10) * b) :=
  dvd_iff (k_digit_three hp) a b

/-- Divisibility test for a `p` ending in `7`. -/
theorem test_digit_seven {p : ℤ} (hp : p % 10 = 7) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ (a - (3 * p / 10) * b) :=
  dvd_iff (k_digit_seven hp) a b

/-- Divisibility test for a `p` ending in `9`. -/
theorem test_digit_nine {p : ℤ} (hp : p % 10 = 9) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ (a - (9 * p / 10) * b) :=
  dvd_iff (k_digit_nine hp) a b
-- ANCHOR_END: flow-div-tests

/-! ### The main theorem: one statement for all four cases -/

-- ANCHOR: flow-div-main
/-- The number `k` used in the test, as a function of `p` alone.  It depends only on the last digit
of `p`, following the table: the multiplier `m ∈ {1, 7, 3, 9}` is the inverse of that digit modulo
`10`, and `k = ⌊m * p / 10⌋`. -/
def kFor (p : ℤ) : ℤ :=
  if p % 10 = 1 then p / 10          -- m = 1
  else if p % 10 = 3 then 7 * p / 10 -- m = 7
  else if p % 10 = 7 then 3 * p / 10 -- m = 3
  else 9 * p / 10                    -- m = 9

/-- **Main theorem (divisibility test).**  Let `p` be an integer whose last digit is `1, 3, 7`, or
`9` — for a prime, exactly every prime other than `2` and `5`.  Writing `n = 10 * a + b`, the number
`p` divides `n` **if and only if** `p` divides the determinant

  `| a       b |`
  `| kFor p  1 |  =  a - (kFor p) * b`. -/
theorem divisibility_test {p : ℤ}
    (hp : p % 10 = 1 ∨ p % 10 = 3 ∨ p % 10 = 7 ∨ p % 10 = 9) (a b : ℤ) :
    p ∣ (10 * a + b) ↔ p ∣ Matrix.det !![a, b; kFor p, 1] := by
  have hcert : ∃ m : ℤ, 10 * kFor p + 1 = m * p := by
    unfold kFor
    split_ifs with h1 h3 h7
    · exact ⟨1, by omega⟩
    · exact ⟨7, by omega⟩
    · exact ⟨3, by omega⟩
    · exact ⟨9, by omega⟩
  obtain ⟨m, hm⟩ := hcert
  exact dvd_iff_dvd_det hm a b
-- ANCHOR_END: flow-div-main

/-! ### The worked examples from the note -/

-- ANCHOR: flow-div-example
/-- `31` ends in `1`, so `k = 3` (certificate `10 * 3 + 1 = 1 * 31`).  The method reduces `2759`
to `0`: `|275 9; 3 1| = 248`, then `|24 8; 3 1| = 0`. -/
theorem reduce_2759 : (31 : ℤ) ∣ 2759 ↔ (31 : ℤ) ∣ 0 := by
  rw [show (2759 : ℤ) = 10 * 275 + 9 by norm_num,
      dvd_iff (show (10 : ℤ) * 3 + 1 = 1 * 31 by norm_num) 275 9,
      show (275 : ℤ) - 3 * 9 = 10 * 24 + 8 by norm_num,
      dvd_iff (show (10 : ℤ) * 3 + 1 = 1 * 31 by norm_num) 24 8,
      show (24 : ℤ) - 3 * 8 = 0 by norm_num]

/-- Hence `31 ∣ 2759`. -/
theorem dvd_2759 : (31 : ℤ) ∣ 2759 := reduce_2759.mpr (dvd_zero 31)

/-- `37` ends in `7`, so `k = ⌊3 · 37 / 10⌋ = 11` (certificate `10 * 11 + 1 = 3 * 37`).  The method
reduces `3293` to `-37`: `|329 3; 11 1| = 296`, then `|29 6; 11 1| = -37`. -/
theorem reduce_3293 : (37 : ℤ) ∣ 3293 ↔ (37 : ℤ) ∣ (-37) := by
  rw [show (3293 : ℤ) = 10 * 329 + 3 by norm_num,
      dvd_iff (show (10 : ℤ) * 11 + 1 = 3 * 37 by norm_num) 329 3,
      show (329 : ℤ) - 11 * 3 = 10 * 29 + 6 by norm_num,
      dvd_iff (show (10 : ℤ) * 11 + 1 = 3 * 37 by norm_num) 29 6,
      show (29 : ℤ) - 11 * 6 = -37 by norm_num]

/-- Hence `37 ∣ 3293` (the sign of the last determinant is irrelevant to divisibility). -/
theorem dvd_3293 : (37 : ℤ) ∣ 3293 := reduce_3293.mpr ⟨-1, by norm_num⟩

/-- `61` ends in `1`, so `k = 6` (certificate `10 * 6 + 1 = 1 * 61`).  The method reduces `75273`
to `33`: `7509`, then `696`, then `33`. -/
theorem reduce_75273 : (61 : ℤ) ∣ 75273 ↔ (61 : ℤ) ∣ 33 := by
  rw [show (75273 : ℤ) = 10 * 7527 + 3 by norm_num,
      dvd_iff (show (10 : ℤ) * 6 + 1 = 1 * 61 by norm_num) 7527 3,
      show (7527 : ℤ) - 6 * 3 = 10 * 750 + 9 by norm_num,
      dvd_iff (show (10 : ℤ) * 6 + 1 = 1 * 61 by norm_num) 750 9,
      show (750 : ℤ) - 6 * 9 = 10 * 69 + 6 by norm_num,
      dvd_iff (show (10 : ℤ) * 6 + 1 = 1 * 61 by norm_num) 69 6,
      show (69 : ℤ) - 6 * 6 = 33 by norm_num]

/-- Since `61 ∤ 33`, the number `75273` is **not** divisible by `61`. -/
theorem not_dvd_75273 : ¬ (61 : ℤ) ∣ 75273 := by rw [reduce_75273]; omega
-- ANCHOR_END: flow-div-example

end DivisibilityFlow

end MathNotesLean
