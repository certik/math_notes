**Theorem (Product Rule for Limits).**  
If $\lim_{x \to a} f(x) = L$ and $\lim_{x \to a} g(x) = M$ (where $L, M \in \mathbb{R}$), then  
$$
\lim_{x \to a} [f(x) g(x)] = LM.
$$

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

**Note:** The same technique works for one-sided limits and for limits at $\pm \infty$ (with appropriate modifications to the definition).
