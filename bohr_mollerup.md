---
authors:
  - name: Ondřej Čertík
bibliography:
  - references.bib
---
# The Bohr–Mollerup theorem

The [gamma function](https://en.wikipedia.org/wiki/Gamma_function) is defined for
$x>0$ by Euler's integral

```{math}
:label: eq-bm-gamma-def

\Gamma(x)=\int_0^\infty t^{x-1}e^{-t}\,\mathrm{d}t .
```

It extends the factorial, $\Gamma(n)=(n-1)!$, and satisfies $\Gamma(x+1)=x\,\Gamma(x)$.
But infinitely many functions interpolate the factorial. The **Bohr–Mollerup
theorem** [@bohr1922laerebog], given the elegant treatment reproduced here by
Artin [@artin1964gamma], singles out $\Gamma$ by *one* extra qualitative
condition: logarithmic convexity.

**Theorem (Bohr–Mollerup).** *The gamma function is the unique function
$f\colon(0,\infty)\to(0,\infty)$ that simultaneously satisfies*

1. *$f(1)=1$;*
2. *$f(x+1)=x\,f(x)$ for all $x>0$;*
3. *$\log f$ is convex on $(0,\infty)$.*

Here "log-convex" means that $\log\circ f$ is a convex function; equivalently
$f\big(\lambda a+(1-\lambda)b\big)\le f(a)^{\lambda}f(b)^{1-\lambda}$ for
$\lambda\in[0,1]$.

:::{note} Lean formalization
The statements and proofs in this note are formalized in Lean 4 + Mathlib in
[`BohrMollerupFlow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/BohrMollerupFlow.lean),
a flow-faithful development that reproduces the note's steps in order. The three
hypotheses are bundled in a predicate `GammaLike`; the elementary recurrence
identities (Steps 1) are proved from scratch by induction, while the analytic
squeeze of Steps 2–3 — monotonicity of the secant slopes of $\log f$ and the fact
that $\log(n+1)-\log n\to 0$ — is supplied by Mathlib's `Real.BohrMollerup`
development and assembled here into the note's flow. Each **Lean proof** dropdown
below splices the corresponding declaration verbatim from the compiled source, so
the displayed code cannot drift from what is actually checked. Continuous
integration runs `lake build` (which fails on any error or `sorry`), and the file
is axiom-clean (`propext`, `Classical.choice`, `Quot.sound`).

Lean's kernel guarantees each *proof* is correct. Whether a Lean *statement*
faithfully captures the informal claim is a human judgement, so each dropdown is
placed next to the statement it formalizes, for direct comparison.
:::

:::{dropdown} Lean: the three properties `GammaLike` and the theorem `bohr_mollerup`
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-def
:end-before: ANCHOR_END: bm-def
```
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-main
:end-before: ANCHOR_END: bm-main
```
:::

The proof has two halves: **uniqueness** (any $f$ with properties 1–3 is forced to
equal a specific limit, hence equals $\Gamma$) and **existence** ($\Gamma$ itself
has all three properties). The heart of the argument is uniqueness.

(bm-step1)=
## Step 1: the functional equation reproduces the factorials

Assume $f$ satisfies properties 1–3. Property 2 applied repeatedly, with $f(1)=1$,
gives by induction

```{math}
:label: eq-bm-factorial

f(n+1)=n! \qquad (n\in\mathbb{N}),
```

so $f$ interpolates the factorials just like $\Gamma$. More generally, iterating
$f(x+1)=x\,f(x)$ exactly $n$ times yields the product formula

```{math}
:label: eq-bm-prod

f(x+n)=f(x)\,\prod_{m=0}^{n-1}(x+m)=x(x+1)\cdots(x+n-1)\,f(x).
```

The consequence is decisive: {eq}`eq-bm-prod` lets us recover $f(x)$ for *any*
$x>0$ from its values on the unit interval $(0,1]$. So it suffices to pin down $f$
on $(0,1]$.

:::{dropdown} Lean proof: `GammaLike.f_nat` (factorials) and `GammaLike.f_add_nat` (product formula)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-factorial
:end-before: ANCHOR_END: bm-factorial
```
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-prod
:end-before: ANCHOR_END: bm-prod
```
:::

(bm-step2)=
## Step 2: log-convexity sandwiches the values

Fix $x$ with $0<x\le 1$ and write $\varphi:=\log f$, which is convex by property 3.
For $x_1<x_2$ let

$$
S(x_1,x_2)=\frac{\varphi(x_2)-\varphi(x_1)}{x_2-x_1}
$$

be the slope of the secant of $\varphi$ over $[x_1,x_2]$. Convexity is exactly the
statement that $S$ is monotonically increasing in each argument. For an integer
$n\ge 2$ consider the four points $n-1<n<n+x\le n+1$. Monotonicity of the slopes
gives

```{math}
:label: eq-bm-slopes

S(n-1,\,n)\;\le\;S(n,\,n+x)\;\le\;S(n,\,n+1).
```

By {eq}`eq-bm-factorial`, $\varphi(n)=\log\big((n-1)!\big)$ and
$\varphi(n+1)=\log(n!)$, so the outer slopes collapse to logarithms of integers,
$S(n-1,n)=\log(n-1)$ and $S(n,n+1)=\log n$, while the middle slope is
$S(n,n+x)=\big(\varphi(n+x)-\varphi(n)\big)/x$. Multiplying {eq}`eq-bm-slopes` by
$x>0$ and adding $\varphi(n)$ turns it into a **sandwich** of $\varphi(n+x)$
between two lines in $x$:

```{math}
:label: eq-bm-sandwich

\log\big(f(n)\big)+x\log(n-1)\;\le\;\log\big(f(n+x)\big)\;\le\;\log\big(f(n)\big)+x\log n .
```

:::{dropdown} Lean proof: `GammaLike.log_sandwich` (the two-line sandwich)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-sandwich
:end-before: ANCHOR_END: bm-sandwich
```
:::

(bm-step3)=
## Step 3: the Euler–Gauss limit

Now feed the product formula {eq}`eq-bm-prod` into the sandwich
{eq}`eq-bm-sandwich`. Taking logarithms of {eq}`eq-bm-prod`,

$$
\log\big(f(n+x)\big)=\log\big(f(x)\big)+\sum_{m=0}^{n-1}\log(x+m),
$$

and, exponentiating {eq}`eq-bm-sandwich` after substitution and solving for
$f(x)$, one obtains for every $n$ the two-sided bound

```{math}
:label: eq-bm-doublebound

\frac{(n-1)^{x}\,(n-1)!}{x(x+1)\cdots(x+n-1)}\;\le\;f(x)\;\le\;\frac{n^{x}\,n!}{x(x+1)\cdots(x+n)}\cdot\frac{n+x}{n}.
```

Because {eq}`eq-bm-doublebound` holds for *every* $n$, the left- and right-hand
sides may use different indices. Sending $n\to\infty$ and using
$\frac{n+x}{n}\to 1$ (equivalently $\log(n+1)-\log n\to 0$), the two sides converge
to a common value, squeezing $f(x)$ to Gauss's product limit

```{math}
:label: eq-bm-gauss

f(x)=\lim_{n\to\infty}\frac{n^{x}\,n!}{x(x+1)\cdots(x+n)} .
```

It is convenient to record this in logarithmic form. Setting

$$
L_n(x):=x\log n+\log(n!)-\sum_{m=0}^{n}\log(x+m)
$$

(so that $e^{L_n(x)}$ is exactly the fraction in {eq}`eq-bm-gauss`), the squeeze
says $L_n(x)\to\log\big(f(x)\big)$.

:::{dropdown} Lean proof: `GammaLike.logGammaSeq_tendsto` (the squeeze) and `GammaLike.gauss_product` (the Gauss product limit)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-limit
:end-before: ANCHOR_END: bm-limit
```
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-gauss
:end-before: ANCHOR_END: bm-gauss
```
:::

Here `logGammaSeq x n` is Mathlib's name for $L_n(x)$, and the squeeze itself
(monotone secant slopes plus $\log(n+1)-\log n\to 0$) is provided by Mathlib's
`Real.BohrMollerup.tendsto_logGammaSeq`, which the Lean proof above specializes to
our `GammaLike` hypotheses.

(bm-step4)=
## Step 4: uniqueness

The right-hand side of {eq}`eq-bm-gauss` makes **no reference to $f$**: it is a
fixed sequence built from $x$ and the integers. Hence its value is determined by
$x$ alone. So if $f$ and $g$ both satisfy properties 1–3, then for every $x>0$

$$
f(x)=\lim_{n\to\infty}\frac{n^{x}\,n!}{x(x+1)\cdots(x+n)}=g(x),
$$

and the two functions coincide. In particular, since (as we check in Step 5)
$\Gamma$ satisfies properties 1–3, and it too obeys $L_n(x)\to\log\Gamma(x)$, the
uniqueness of limits forces $\log f(x)=\log\Gamma(x)$; as $\log$ is injective on
$(0,\infty)$ and both values are positive, $f(x)=\Gamma(x)$ for all $x>0$.

:::{dropdown} Lean proof: `GammaLike.eq_Gamma` (every admissible function equals Γ) and `GammaLike.unique` (any two agree)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-eq-gamma
:end-before: ANCHOR_END: bm-eq-gamma
```
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-unique
:end-before: ANCHOR_END: bm-unique
```
:::

(bm-step5)=
## Step 5: existence — $\Gamma$ qualifies

Uniqueness would be vacuous without a function that actually meets all three
conditions. The gamma function {eq}`eq-bm-gamma-def` does:

1. **Normalization.** $\Gamma(1)=\int_0^\infty e^{-t}\,\mathrm{d}t=1$.
2. **Functional equation.** Integration by parts gives
   $\Gamma(x+1)=\big[-t^{x}e^{-t}\big]_0^\infty+x\int_0^\infty t^{x-1}e^{-t}\,\mathrm{d}t=x\,\Gamma(x)$.
3. **Log-convexity.** Applying Hölder's inequality to Euler's integral shows
   $\log\Gamma$ is convex on $(0,\infty)$.

Together with positivity of $\Gamma$ on $(0,\infty)$, this establishes existence.

:::{dropdown} Lean proof: `gammaLike_Gamma` (Γ has all three properties)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupFlow.lean
:language: lean
:start-after: ANCHOR: bm-exists
:end-before: ANCHOR_END: bm-exists
```
:::

## Conclusion

Steps 1–4 show that at most one positive function on $(0,\infty)$ can satisfy
properties 1–3, and Step 5 shows $\Gamma$ is such a function. Therefore $\Gamma$ is
the unique function with these properties — the Bohr–Mollerup theorem. The Lean
statement `bohr_mollerup` in the first dropdown packages both halves: $\Gamma$ is
`GammaLike`, and every `GammaLike` function equals $\Gamma$ on $(0,\infty)$.

A pleasant by-product of the proof is the explicit **Gauss product**
{eq}`eq-bm-gauss` for the gamma function, which fell out of the uniqueness argument
without any extra work.

## References

- H. Bohr and J. Mollerup, *Lærebog i matematisk Analyse*, vol. III (1922)
  [@bohr1922laerebog] — the original source.
- E. Artin, *The Gamma Function* [@artin1964gamma] — the standard modern
  treatment, whose argument this note follows.
- [Bohr–Mollerup theorem](https://en.wikipedia.org/wiki/Bohr%E2%80%93Mollerup_theorem)
  on Wikipedia [@wiki:BohrMollerup].
