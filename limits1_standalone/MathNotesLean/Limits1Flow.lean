/-
Copyright (c) 2026 Ondřej Čertík. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ondřej Čertík
-/
import Mathlib.Topology.MetricSpace.Pseudo.Defs
import Std.Tactic.BVDecide.LRAT.Internal.Clause

/-!
# Product rule for limits — flow-faithful ε–δ development

This file formalizes `limits1.md` following the note's **own** ε–δ argument. We do **not** call
Mathlib's `Filter.Tendsto.mul`; instead we define the ε–δ limit ourselves and prove the product rule
from scratch in the note's three steps:

1. bound `|f|` near `a` by `B = |L| + 1` (`exists_bound_near`);
2. split `|f g - L M| ≤ |f| |g - M| + |M| |f - L|` and make each term `< ε/2`;
3. take `δ = min{δ₁, δ₂, δ₃}` (`limit_mul`).

To certify the *statement* is about the genuine limit (and not a vacuous ad-hoc predicate), we also
prove our ε–δ `Limit` is exactly Mathlib's punctured-neighbourhood limit `Tendsto f (𝓝[≠] a) (𝓝 L)`
(`limit_iff_tendsto`). The product-rule proof itself never uses that bridge.
-/

namespace MathNotesLean

namespace Limits1Flow

open Filter Topology

-- ANCHOR: flow-limits-def
/-- The note's ε–δ definition of `lim_{x→a} f(x) = L`. The hypothesis `0 < |x - a|` is the note's
`0 < |x - a|`, i.e. the deleted/punctured limit that ignores the value (if any) at `x = a`. -/
def Limit (f : ℝ → ℝ) (a L : ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, 0 < |x - a| → |x - a| < δ → |f x - L| < ε
-- ANCHOR_END: flow-limits-def

variable {f g : ℝ → ℝ} {a L M : ℝ}

-- ANCHOR: flow-limits-faithful
/-- The note's ε–δ limit is **exactly** Mathlib's punctured-neighbourhood limit
`Tendsto f (𝓝[≠] a) (𝓝 L)`, so the results below concern the genuine limit. -/
theorem limit_iff_tendsto : Limit f a L ↔ Tendsto f (𝓝[≠] a) (𝓝 L) := by
  rw [Metric.tendsto_nhdsWithin_nhds]
  constructor
  · intro h ε hε
    obtain ⟨δ, hδ, hx⟩ := h ε hε
    refine ⟨δ, hδ, fun x hxmem hxδ => ?_⟩
    rw [Real.dist_eq] at hxδ ⊢
    have hx0 : 0 < |x - a| :=
      abs_pos.mpr (sub_ne_zero.mpr (Set.mem_compl_singleton_iff.mp hxmem))
    exact hx x hx0 hxδ
  · intro h ε hε
    obtain ⟨δ, hδ, hx⟩ := h ε hε
    refine ⟨δ, hδ, fun x hx0 hxδ => ?_⟩
    have hxmem : x ∈ ({a}ᶜ : Set ℝ) :=
      Set.mem_compl_singleton_iff.mpr (sub_ne_zero.mp (abs_pos.mp hx0))
    have := hx hxmem (by rw [Real.dist_eq]; exact hxδ)
    rwa [Real.dist_eq] at this
-- ANCHOR_END: flow-limits-faithful

-- ANCHOR: flow-limits-bound
/-- **Step 1.** A function with limit `L` at `a` is bounded by `|L| + 1` near `a`: taking `ε = 1`
gives `δ₁` with `|f x - L| < 1`, hence `|f x| ≤ |f x - L| + |L| < |L| + 1`. -/
theorem exists_bound_near (hf : Limit f a L) :
    ∃ δ₁ > 0, ∀ x, 0 < |x - a| → |x - a| < δ₁ → |f x| < |L| + 1 := by
  obtain ⟨δ₁, hδ₁, hx⟩ := hf 1 one_pos
  refine ⟨δ₁, hδ₁, fun x hx0 hxδ => ?_⟩
  have h1 : |f x - L| < 1 := hx x hx0 hxδ
  calc |f x| = |(f x - L) + L| := by congr 1; ring
    _ ≤ |f x - L| + |L| := abs_add_le _ _
    _ < 1 + |L| := by linarith
    _ = |L| + 1 := by ring
-- ANCHOR_END: flow-limits-bound

-- ANCHOR: flow-limits-mul
/-- **Product rule for limits.** If `lim f = L` and `lim g = M` at `a`, then `lim (f·g) = L·M`.
Proved straight from the ε–δ definition as in the note: bound `|f|` by `B = |L| + 1`, force each of
the two terms below `ε/2`, and take `δ = min{δ₁, δ₂, δ₃}`. -/
theorem limit_mul (hf : Limit f a L) (hg : Limit g a M) :
    Limit (fun x => f x * g x) a (L * M) := by
  intro ε hε
  -- Step 1: bound |f| by B = |L| + 1.
  obtain ⟨δ₁, hδ₁, hbound⟩ := exists_bound_near hf
  set B : ℝ := |L| + 1 with hB
  have hBpos : 0 < B := by positivity
  -- Step 2: control each term: |g - M| < ε/(2B) and |f - L| < ε/(2(|M|+1)).
  obtain ⟨δ₂, hδ₂, hg2⟩ := hg (ε / (2 * B)) (by positivity)
  obtain ⟨δ₃, hδ₃, hf3⟩ := hf (ε / (2 * (|M| + 1))) (by positivity)
  -- Step 3: choose δ = min{δ₁, δ₂, δ₃}.
  refine ⟨min δ₁ (min δ₂ δ₃), by positivity, fun x hx0 hxδ => ?_⟩
  have hx1 : |x - a| < δ₁ := lt_of_lt_of_le hxδ (min_le_left _ _)
  have hx2 : |x - a| < δ₂ := lt_of_lt_of_le hxδ ((min_le_right _ _).trans (min_le_left _ _))
  have hx3 : |x - a| < δ₃ := lt_of_lt_of_le hxδ ((min_le_right _ _).trans (min_le_right _ _))
  have hfb : |f x| < B := hbound x hx0 hx1
  have hgm : |g x - M| < ε / (2 * B) := hg2 x hx0 hx2
  have hfl : |f x - L| < ε / (2 * (|M| + 1)) := hf3 x hx0 hx3
  -- term 1: |f x| · |g x - M| < ε/2.
  have ht1 : |f x| * |g x - M| < ε / 2 := by
    calc |f x| * |g x - M| ≤ B * |g x - M| := by gcongr
      _ < B * (ε / (2 * B)) := by gcongr
      _ = ε / 2 := by field_simp
  -- term 2: |M| · |f x - L| ≤ ε/2.
  have ht2 : |M| * |f x - L| ≤ ε / 2 := by
    have step : |M| * |f x - L| ≤ (|M| + 1) * (ε / (2 * (|M| + 1))) :=
      mul_le_mul (by linarith [abs_nonneg M]) hfl.le (abs_nonneg _) (by positivity)
    calc |M| * |f x - L| ≤ (|M| + 1) * (ε / (2 * (|M| + 1))) := step
      _ = ε / 2 := by field_simp
  -- combine via the triangle inequality.
  have hsplit : f x * g x - L * M = f x * (g x - M) + M * (f x - L) := by ring
  calc |(fun x => f x * g x) x - L * M|
      = |f x * (g x - M) + M * (f x - L)| := by simp only [hsplit]
    _ ≤ |f x * (g x - M)| + |M * (f x - L)| := abs_add_le _ _
    _ = |f x| * |g x - M| + |M| * |f x - L| := by rw [abs_mul, abs_mul]
    _ < ε := by linarith
-- ANCHOR_END: flow-limits-mul

end Limits1Flow

end MathNotesLean
