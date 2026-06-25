# Product Rule for Limits

:::{note} Lean formalization
This note's $\varepsilon$-$\delta$ proof is formalized in Lean 4 + Mathlib in
[`Limits1Flow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/Limits1Flow.lean),
a flow-faithful development: it defines its **own** $\varepsilon$-$\delta$ limit predicate `Limit` and
proves the product rule from scratch in the same three steps used below, **without** calling Mathlib's
`Filter.Tendsto.mul`. To certify the statement really concerns the limit, it also proves `Limit f a L`
is equivalent to Mathlib's punctured-neighbourhood limit `Tendsto f (𝓝[≠] a) (𝓝 L)`
(`limit_iff_tendsto`); that bridge is never used inside the product-rule proof. Each **Lean proof**
dropdown below splices the corresponding declaration verbatim from the compiled source. Continuous
integration runs `lake build` (which fails on any error or `sorry`), and the file is axiom-clean
(`propext`, `Classical.choice`, `Quot.sound`).
:::

**Theorem (Product Rule for Limits).**  
If $\lim_{x \to a} f(x) = L$ and $\lim_{x \to a} g(x) = M$ (where $L, M \in \mathbb{R}$), then  
$$
\lim_{x \to a} [f(x) g(x)] = LM.
$$

:::{dropdown} Lean: the $\varepsilon$-$\delta$ definition `Limit` and its faithfulness `limit_iff_tendsto`
```{literalinclude} math_notes_lean/MathNotesLean/Limits1Flow.lean
:language: lean
:start-after: ANCHOR: flow-limits-def
:end-before: ANCHOR_END: flow-limits-def
```
```{literalinclude} math_notes_lean/MathNotesLean/Limits1Flow.lean
:language: lean
:start-after: ANCHOR: flow-limits-faithful
:end-before: ANCHOR_END: flow-limits-faithful
```
:::


**Proof (using the $\varepsilon$-$\delta$ definition).**

Let $\varepsilon > 0$ be arbitrary. We must find $\delta > 0$ such that  
$$
0 < |x - a| < \delta \quad \implies \quad |f(x)g(x) - LM| < \varepsilon.
$$

**Step 1: Bound $|f(x)|$ near $a$.**  
Since $\lim_{x \to a} f(x) = L$, there exists $\delta_1 > 0$ such that  
$$
0 < |x - a| < \delta_1 \quad \implies \quad |f(x) - L| < 1.
$$  
Therefore,  
$$
|f(x)| = |f(x) - L + L| \leq |f(x) - L| + |L| < 1 + |L|.
$$  
Let $B := |L| + 1 > 0$. Then $|f(x)| < B$ whenever $0 < |x - a| < \delta_1$.

:::{dropdown} Lean proof: `exists_bound_near` (Step 1 — bounding $|f|$ near $a$)
```{literalinclude} math_notes_lean/MathNotesLean/Limits1Flow.lean
:language: lean
:start-after: ANCHOR: flow-limits-bound
:end-before: ANCHOR_END: flow-limits-bound
```
:::


**Step 2: Control the two terms in the product difference.**  
Rewrite the expression we want to bound:  
$$
|f(x)g(x) - LM| = |f(x)(g(x) - M) + M(f(x) - L)| \leq |f(x)| \cdot |g(x) - M| + |M| \cdot |f(x) - L|.
$$  
We will make each term on the right smaller than $\varepsilon/2$.

- Choose $\delta_2 > 0$ so that $|g(x) - M|$ is small enough:  
  Since $\lim_{x \to a} g(x) = M$, there exists $\delta_2 > 0$ such that  
  $$
  0 < |x - a| < \delta_2 \quad \implies \quad |g(x) - M| < \frac{\varepsilon}{2B}.
  $$  
  Then the first term satisfies  
  $$
  |f(x)| \cdot |g(x) - M| < B \cdot \frac{\varepsilon}{2B} = \frac{\varepsilon}{2}.
  $$

- Choose $\delta_3 > 0$ so that $|f(x) - L|$ is small enough:  
  Since $\lim_{x \to a} f(x) = L$, there exists $\delta_3 > 0$ such that  
  $$
  0 < |x - a| < \delta_3 \quad \implies \quad |f(x) - L| < \frac{\varepsilon}{2(|M| + 1)}.
  $$  
  Then the second term satisfies  
  $$
  |M| \cdot |f(x) - L| < |M| \cdot \frac{\varepsilon}{2(|M| + 1)} = \frac{|M|}{2(|M| + 1)} \varepsilon < \frac{\varepsilon}{2},
  $$  
  because $\frac{|M|}{|M| + 1} < 1$ for any finite real number $M$.

**Step 3: Choose the overall $\delta$.**  
Let  
$$
\delta := \min\{\delta_1, \delta_2, \delta_3\} > 0.
$$  
Now suppose $0 < |x - a| < \delta$. Then all three conditions hold simultaneously:  
- $|f(x)| < B$,  
- $|g(x) - M| < \frac{\varepsilon}{2B}$,  
- $|f(x) - L| < \frac{\varepsilon}{2(|M| + 1)}$.

Therefore,  
$$
|f(x)g(x) - LM| < \frac{\varepsilon}{2} + \frac{\varepsilon}{2} = \varepsilon.
$$

This completes the proof. (The case $M = 0$ is covered automatically, since the second term vanishes or is even smaller.)

:::{dropdown} Lean proof: `limit_mul` (the product rule, Steps 1–3)
```{literalinclude} math_notes_lean/MathNotesLean/Limits1Flow.lean
:language: lean
:start-after: ANCHOR: flow-limits-mul
:end-before: ANCHOR_END: flow-limits-mul
```
:::


**Note:** The same technique works for one-sided limits and for limits at $\pm \infty$ (with appropriate modifications to the definition).
