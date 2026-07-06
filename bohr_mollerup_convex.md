---
authors:
  - name: Ondřej Čertík
bibliography:
  - references.bib
---
# Does convexity suffice in Bohr–Mollerup?

The [Bohr–Mollerup theorem](./bohr_mollerup.md) characterizes the gamma function as the unique
positive function $f$ on $(0,\infty)$ with $f(1)=1$, $f(x+1)=x\,f(x)$, and **$\log f$ convex**
(log-convex). A natural question:

> **Question.** If we keep $f(1)=1$ and $f(x+1)=x\,f(x)$ but weaken "log-convex" to merely
> **convex**, is $\Gamma$ still the unique solution?

**Answer: no.** Convexity is *not* enough. Since a positive log-convex function is automatically
convex — $f=\exp(\log f)$ and $\exp$ is convex increasing — replacing log-convexity by convexity is a
*strictly weaker* hypothesis, so we should expect extra solutions, and indeed there are. This note
exhibits an explicit one and proves it works.

:::{note} Lean formalization
The Lean-checkable core is formalized in Lean 4 + Mathlib in
[`BohrMollerupConvexFlow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean).
For every $\varepsilon>0$ it proves, sorry-free, that the function below is a positive solution of the
functional equation with $f(1)=1$, is **not** equal to $\Gamma$, and is **not** log-convex — so it
lives in the gap between "convex" and "log-convex". Continuous integration runs `lake build` (which
fails on any error or `sorry`), and the file is axiom-clean (`propext`, `Classical.choice`,
`Quot.sound`).

The single step that is **not** machine-checked is the *convexity* of the counterexample: it rests on
lower bounds for the di- and tri-gamma functions ($(\log\Gamma)''(x)\ge 1/x$ and
$(\log\Gamma)'(x)\to\infty$) that current Mathlib does not provide. That step is proved by hand in
[§4](#bmc-convex) and confirmed numerically in [§5](#bmc-numerics).
:::

(bmc-space)=
## 1. Why the functional equation alone determines almost nothing

Fix any solution $f>0$ of $f(x+1)=x\,f(x)$ and compare it with $\Gamma$. Since
$\Gamma(x+1)=x\,\Gamma(x)$ as well, the ratio $g:=f/\Gamma$ satisfies

```{math}
:label: eq-bmc-periodic

g(x+1)=\frac{f(x+1)}{\Gamma(x+1)}=\frac{x\,f(x)}{x\,\Gamma(x)}=\frac{f(x)}{\Gamma(x)}=g(x).
```

So **every** solution has the form $f=\Gamma\cdot g$ with $g$ an arbitrary $1$-periodic positive
function; normalization forces only $g(1)=1$. The solution set is therefore infinite-dimensional. A
*shape* hypothesis is what collapses it: log-convexity forces $g\equiv 1$ (a convex periodic function
is constant), giving $f=\Gamma$. The question is whether plain convexity is a strong enough shape
hypothesis. It is not.

:::{dropdown} Lean proof: `ratio_periodic` (every solution is $\Gamma$ times a $1$-periodic function)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-structure
:end-before: ANCHOR_END: bmc-structure
```
:::

(bmc-counterexample)=
## 2. The counterexample

For a small parameter $\varepsilon>0$ define the $1$-periodic factor and the candidate function

```{math}
:label: eq-bmc-def

g_\varepsilon(x)=1+\varepsilon\bigl(1-\cos 2\pi x\bigr),
\qquad
f_\varepsilon(x)=\Gamma(x)\,g_\varepsilon(x).
```

Because $0\le 1-\cos 2\pi x\le 2$, we have $g_\varepsilon\ge 1>0$, and $g_\varepsilon$ has period $1$
with $g_\varepsilon(n)=1$ at every integer (as $\cos 2\pi n=1$). Hence, exactly as in
[§1](#bmc-space):

- **Positivity:** $f_\varepsilon(x)=\Gamma(x)\,g_\varepsilon(x)>0$ for $x>0$.
- **Functional equation:** $f_\varepsilon(x+1)=\Gamma(x+1)\,g_\varepsilon(x+1)=x\,\Gamma(x)\,g_\varepsilon(x)=x\,f_\varepsilon(x)$.
- **Normalization:** $f_\varepsilon(1)=\Gamma(1)\,g_\varepsilon(1)=1$.

These three are elementary and fully machine-checked.

:::{dropdown} Lean: the periodic factor `perturb` (periodic, positive, $=1$ at integers)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-perturb
:end-before: ANCHOR_END: bmc-perturb
```
:::

:::{dropdown} Lean: `f`, its positivity `f_pos`, normalization `f_one`, and the functional equation `f_functional_eq`
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-def
:end-before: ANCHOR_END: bmc-def
```
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-funeq
:end-before: ANCHOR_END: bmc-funeq
```
:::

The convex counterexample is, to the eye, indistinguishable from $\Gamma$:

:::{figure} figures/bohr_mollerup_convex_scalings.png
:label: fig-bmc-scalings
:alt: Gamma and f_epsilon plotted on linear, semilogx, semilogy, and log-log axes
:width: 100%

$\Gamma$ (black) and the convex counterexample $f_{0.01}$ (blue) coincide to the eye in all four
scalings; a larger, non-convex $f_{0.20}$ (red) exposes the periodic ripple. The ripple is a
few-percent *relative* modulation: swamped by factorial growth on the linear axes, but clearly
visible on the **logarithmic** axes (bottom row), where multiplicative structure becomes additive.
:::

(bmc-gap)=
## 3. It differs from $\Gamma$, and it is not log-convex

At the half-integer, $\cos\pi=-1$, so

```{math}
:label: eq-bmc-half

f_\varepsilon\!\left(\tfrac12\right)=\Gamma\!\left(\tfrac12\right)\bigl(1+2\varepsilon\bigr)>\Gamma\!\left(\tfrac12\right),
```

hence $f_\varepsilon\neq\Gamma$ whenever $\varepsilon>0$. Moreover $f_\varepsilon$ is **not**
log-convex: if $\log\circ f_\varepsilon$ were convex on $(0,\infty)$, then the log-convex
Bohr–Mollerup theorem (Mathlib's `Real.eq_Gamma_of_log_convex`) — whose remaining hypotheses we
verified in [§2](#bmc-counterexample) — would force $f_\varepsilon=\Gamma$, contradicting
{eq}`eq-bmc-half`. So $f_\varepsilon$ sits strictly *below* log-convexity. Once we show in
[§4](#bmc-convex) that it is nevertheless *convex*, the failure of the convex-hypothesis theorem is
complete.

:::{dropdown} Lean proof: `f_half`, `f_ne_Gamma` ($f_\varepsilon\neq\Gamma$), and `not_logConvex`
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-half-ne
:end-before: ANCHOR_END: bmc-half-ne
```
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-not-logconvex
:end-before: ANCHOR_END: bmc-not-logconvex
```
:::

(bmc-convex)=
## 4. It is convex (for small $\varepsilon$)

This is the crux. Write $u:=\log f_\varepsilon=\log\Gamma+v$ with $v:=\log g_\varepsilon$. Since
$f_\varepsilon=e^{u}>0$,

```{math}
:label: eq-bmc-fpp

f_\varepsilon''=e^{u}\bigl(u''+(u')^2\bigr),
\qquad\text{so}\qquad
f_\varepsilon\text{ convex}\iff u''+(u')^2\ge 0 .
```

Let $\psi:=(\log\Gamma)'$ (digamma) and $\psi':=(\log\Gamma)''$ (trigamma), so that $u'=\psi+v'$ and
$u''=\psi'+v''$. We use two standard facts about $\Gamma$:

```{math}
:label: eq-bmc-trigamma

\psi'(x)=\sum_{n\ge 0}\frac{1}{(x+n)^2}\;\ge\;\int_0^\infty\frac{\mathrm dt}{(x+t)^2}=\frac1x
\qquad(x>0),
```

because $t\mapsto (x+t)^{-2}$ is positive and decreasing, and

```{math}
:label: eq-bmc-digamma

\psi(x+1)=\psi(x)+\tfrac1x,\quad \psi\text{ increasing}
\;\Longrightarrow\;
\psi(n)=-\gamma+\sum_{k=1}^{n-1}\tfrac1k\to\infty,\ \text{so}\ \psi(x)\to\infty .
```

**Bounds on the perturbation.** With $w:=\varepsilon(1-\cos 2\pi x)\in[0,2\varepsilon]$ we have
$w'=2\pi\varepsilon\sin 2\pi x$ and $w''=4\pi^2\varepsilon\cos 2\pi x$, and since $g_\varepsilon=1+w\ge 1$,

```{math}
:label: eq-bmc-vbounds

|v'|=\left|\frac{w'}{1+w}\right|\le 2\pi\varepsilon=:C_1,
\qquad
|v''|=\left|\frac{w''(1+w)-(w')^2}{(1+w)^2}\right|\le |w''|+|w'|^2\le 4\pi^2\varepsilon(1+\varepsilon)=:C_2 .
```

Both $C_1,C_2=O(\varepsilon)$. Now split $(0,\infty)$ into two overlapping regions.

**Region A: $0<x\le 1/C_2$.** Here {eq}`eq-bmc-trigamma` gives $\psi'(x)\ge 1/x\ge C_2$, so
$u''=\psi'+v''\ge C_2-C_2=0$. Together with $(u')^2\ge 0$ this yields $u''+(u')^2\ge 0$.

**Region B: $x\ge X_1$,** where $X_1$ is chosen (using {eq}`eq-bmc-digamma`) so large that
$\psi(x)\ge \sqrt{C_2}+C_1$ for all $x\ge X_1$. Then $u'=\psi+v'\ge\sqrt{C_2}+C_1-C_1=\sqrt{C_2}\ge 0$,
so $(u')^2\ge C_2$, while $u''=\psi'+v''\ge 0-C_2=-C_2$ (as $\psi'>0$). Hence
$u''+(u')^2\ge -C_2+C_2=0$.

**Coverage.** As $\varepsilon\to 0$ we have $C_1,C_2\to 0$, so $1/C_2\to\infty$ while
$\sqrt{C_2}+C_1\to 0$ pushes $X_1$ down to the unique zero $x^\ast\approx 1.4616$ of $\psi$. Thus for
all sufficiently small $\varepsilon>0$ we have $X_1\le 1/C_2$, the two regions cover $(0,\infty)$,
and $u''+(u')^2\ge 0$ everywhere. By {eq}`eq-bmc-fpp`, $f_\varepsilon$ is **convex**. $\qquad\blacksquare$

For the concrete value $\varepsilon=\tfrac{1}{100}$ the constants already close:
$C_2=4\pi^2(0.01)(1.01)\approx 0.399$, so $1/C_2\approx 2.51$, while $\sqrt{C_2}+C_1\approx 0.69$ is
reached by $\psi$ already at $x\approx 2.49\le 2.51$. The next section confirms this numerically.

:::{tip} Why log-convexity is different
In Region B the perturbation's downward curvature $v''<0$ can exceed the tiny trigamma value
$\psi'(x)\approx 1/x$, so $u''=(\log f_\varepsilon)''$ genuinely goes **negative** there: $\log
f_\varepsilon$ is *not* convex. Convexity of $f_\varepsilon$ survives only because the first-order term
$(u')^2=(\log f_\varepsilon)'^2$ — which log-convexity ignores — grows like $(\log x)^2$ and absorbs
the deficit. This is precisely the slack that log-convexity forbids and convexity permits.
:::

(bmc-numerics)=
## 5. Numerical confirmation

Sampling $f_\varepsilon''$ on a fine grid over $x\in(0,60]$ (second differences, step $2\times10^{-5}$)
gives the minimum of $f_\varepsilon''$:

| $\varepsilon$ | $\min f_\varepsilon''$ | convex? |
| --- | --- | --- |
| $0.010$ | $+0.48$ | yes |
| $0.020$ | $+0.15$ | yes |
| $0.025$ | $-0.013$ | no |
| $0.030$ | $-0.21$ | no |
| $0.040$ | $-0.74$ | no |

So $f_\varepsilon$ is convex for $\varepsilon\lesssim 0.02$ and loses convexity around
$\varepsilon\approx 0.025$ — failing first in the tail, exactly where Region B is tightest. The
headline value $\varepsilon=\tfrac1{100}$ sits comfortably inside the convex range
($\min f_\varepsilon''\approx 0.48$). The trigamma bound {eq}`eq-bmc-trigamma`, $\psi'(x)\ge 1/x$, was
also checked pointwise and holds with room to spare.

(bmc-seeing)=
## 6. Why log-convexity? Fitting exponential data without wiggles

Step back to what we are really doing: interpolating the factorials, i.e. fitting the points
$(n,(n-1)!)$. These grow *exponentially*, so the natural canvas for them is the **semilogy plot**,
where the points become $(n,\log (n-1)!)$. By Stirling, $\log (n-1)! \approx n\log n - n$, so on that
canvas they lie on a gently curving, almost straight line. A faithful interpolation should have no
wiggles on *either* canvas — not on the ordinary linear plot, and not on this natural log plot.

These are two genuinely different requirements. The ripple $g_\varepsilon=1+\varepsilon(1-\cos 2\pi
x)$ is a *relative* (multiplicative) modulation of a few percent: against factorial growth it is
invisible on the linear axis but plainly visible on the log axis, where multiplicative structure
becomes additive ([](#fig-bmc-scalings)). And the two "no wiggle" demands are exactly the two notions
of convexity:

- **No wiggle on the linear plot $=$ $f$ convex $=$ $f'$ monotone.** This forbids the derivative from
  ever decreasing (the obvious S-shaped wiggle). It is necessary, but *not* sufficient: $f_{0.01}$ is
  convex yet still carries the ripple, because $\Gamma$'s curvature is strong enough to keep $f'$
  increasing while a small oscillation rides along.
- **No wiggle on the log plot $=$ $f$ log-convex $=$ $(\log f)'=f'/f$ monotone.** The *relative* growth
  rate is the natural quantity for a multiplicatively-defined object — the functional equation
  multiplies by $x$. Here $f_{0.01}$ fails: $(\log f_{0.01})'$ visibly turns over.

The two derivative tests side by side make this concrete: in $f'$ the convex $f_{0.01}$ stays
monotone (only the non-convex $f_{0.20}$ dips), whereas in the log-derivative $f'/f$ the tiny $2\%$
ripple of $f_{0.01}$ is amplified to a clearly non-monotone wobble.

:::{figure} figures/bohr_mollerup_convex_derivs.png
:label: fig-bmc-derivs
:alt: values versus derivatives of f_0.01 and f_0.20, with a zoom of the log-derivative
:width: 100%

Values (left) versus derivatives (right) for $f_{0.01}$ (blue) and $f_{0.20}$ (red). The convex
ripple is invisible in the values. In the ordinary derivative $f'$ (top right) $f_{0.01}$ stays
monotone — no wiggle, i.e. convex — while $f_{0.20}$ dips. In the log-derivative $(\log f)'=f'/f$
(bottom right, with zoom) $f_{0.01}$ visibly wiggles and turns over: it is *not* log-convex.
:::

Because log-convex $\Rightarrow$ convex (for positive $f$, since $f=\exp(\log f)$ and $\exp$ is convex
increasing), **no wiggle on the log plot automatically implies no wiggle on the linear plot** — it is
the strictly stronger, and therefore decisive, requirement. That single demand — a smooth fit on the
natural (log) canvas for exponential data — is exactly the log-convexity hypothesis, and by
[Bohr–Mollerup](./bohr_mollerup.md) it pins down $\Gamma$ uniquely, whereas plain convexity does not.

## 7. What is proved where

The bundled Lean statement `convex_hypothesis_insufficient` collects the machine-checked facts: for
every $\varepsilon>0$, the function $f_\varepsilon$ is positive on $(0,\infty)$, satisfies
$f_\varepsilon(x+1)=x\,f_\varepsilon(x)$ and $f_\varepsilon(1)=1$, is not equal to $\Gamma$, and is not
log-convex.

:::{dropdown} Lean: `convex_hypothesis_insufficient` (the machine-checked core)
```{literalinclude} math_notes_lean/MathNotesLean/BohrMollerupConvexFlow.lean
:language: lean
:start-after: ANCHOR: bmc-summary
:end-before: ANCHOR_END: bmc-summary
```
:::

The remaining fact — that $f_\varepsilon$ is *convex* for small $\varepsilon$ — is proved
analytically in [§4](#bmc-convex) and confirmed numerically in [§5](#bmc-numerics). Machine-checking
it in Lean would require developing di-/tri-gamma bounds ($(\log\Gamma)''(x)\ge 1/x$ and
$(\log\Gamma)'(x)\to\infty$) and the $C^2$ convexity criterion for $\Gamma$, none of which are
currently in Mathlib.

## Conclusion

Convexity does **not** replace log-convexity in the Bohr–Mollerup theorem: for every small
$\varepsilon>0$ the function $f_\varepsilon(x)=\Gamma(x)\bigl(1+\varepsilon(1-\cos 2\pi x)\bigr)$ is a
convex, positive solution of $f(x+1)=x\,f(x)$ with $f(1)=1$ that is different from $\Gamma$. The
log-convexity hypothesis of the [original theorem](./bohr_mollerup.md) is therefore essential — it is
exactly strong enough to eliminate the periodic perturbations that plain convexity tolerates.

## References

- The companion note [The Bohr–Mollerup theorem](./bohr_mollerup.md) proves the log-convex version.
- E. Artin, *The Gamma Function* [@artin1964gamma], discusses the role of log-convexity.
- [Bohr–Mollerup theorem](https://en.wikipedia.org/wiki/Bohr%E2%80%93Mollerup_theorem) on Wikipedia
  [@wiki:BohrMollerup].
