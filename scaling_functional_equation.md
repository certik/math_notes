# The Scaling Functional Equation $E(2v)=4E(v)$

This note classifies all real functions of one positive variable obeying the
self-similarity relation
$$
E(2v)=4E(v),\qquad v>0.
$$
The result is a clean illustration of how *much* — and how *little* — a
regularity hypothesis buys. Iterating the relation and substituting $v=2^t$
reduces it to a periodicity statement, giving the **general solution**
$$
E(v)=v^2\,P(\log_2 v),
$$
with $P$ an **arbitrary** $1$-periodic function. The surprise, compared with
Cauchy's additive equation, is that imposing measurability — or even continuity,
or smoothness — does **not** collapse this family to a single closed form: the
power law $v^2$ is always multiplied by a free log-periodic modulation $P$. The
rigid solutions $E(v)=cv^2$ are exactly the case where $P$ is constant. This is
the phenomenon of *discrete scale invariance*: the equation only ties together
scales differing by a factor of $2$, so a whole periodic "constant of
integration" survives at every level of regularity.

:::{note} Lean formalization
The proofs in this note are formalized in Lean 4 + Mathlib in
[`ScalingFunctionalEquationFlow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean),
which reproduces the note's derivations in order. It is self-contained apart from
Mathlib and a single reused result from
[`CstarHomomorphismFlow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/CstarHomomorphismFlow.lean):
the Hamel-basis solution of Cauchy's equation, used to build the non-measurable
example. Each **Lean proof** dropdown below includes the corresponding
declaration verbatim from the compiled source, so the displayed code cannot drift
from what is actually checked. Continuous integration runs `lake build` (which
fails on any error or `sorry`), so every displayed proof is guaranteed to
type-check.

Lean's kernel guarantees each *proof* is correct. Whether a Lean *statement*
faithfully captures the informal claim is a human judgement, so each dropdown is
placed next to the statement it formalizes, for direct comparison.
:::

(scaling-iteration)=
## Iterating the equation

The equation relates the value of $E$ at $v$ to its value at $2v$. Applying it
repeatedly forward,
$$
E(2^2 v)=4E(2v)=4^2E(v),
$$
and inductively
```{math}
:label: eq-scaling-iterate-nat

E(2^n v)=4^n E(v),\qquad n\in\mathbb N.
```
It also runs backward: replacing $v$ by $v/2$ gives $E(v)=4E(v/2)$, i.e.
$E(v/2)=\tfrac14 E(v)$, and inductively the same formula holds for every integer
exponent,
```{math}
:label: eq-scaling-iterate-int

E(2^n v)=4^n E(v),\qquad n\in\mathbb Z.
```
In particular, $E$ on all of $(0,\infty)$ is completely determined by its
restriction to a single fundamental domain $[1,2)$ for multiplication by $2$:
every $v>0$ is $v=2^n u$ with $n=\lfloor\log_2 v\rfloor$ and $u\in[1,2)$, and then
$E(v)=4^n E(u)$. The values of $E$ on $[1,2)$ are completely free; this already
shows the solution set is enormous.

:::{dropdown} Lean proof: `iterate_nat`, `iterate_int`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-iterate
:end-before: ANCHOR_END: flow-scaling-iterate
```
The forward case is an induction using the equation; the integer case adds the
backward step, recovering $E(2^{n-1}v)$ from $E(2^{n}v)=4E(2^{n-1}v)$.
:::

(scaling-gauge)=
## Reduction to a periodic gauge

To organize the free data, pass to the logarithmic variable. Every $v>0$ is
$v=2^t$ with $t=\log_2 v\in\mathbb R$, so set
$$
F(t)=E(2^t).
$$
Because $2\cdot 2^t=2^{t+1}$, the equation $E(2v)=4E(v)$ becomes
```{math}
:label: eq-scaling-F

F(t+1)=4F(t).
```
This is the discrete analogue of an exponential growth law. Divide out the
expected growth by setting
$$
G(t)=\frac{F(t)}{4^t}=\frac{E(2^t)}{4^t}.
$$
Then {eq}`eq-scaling-F` turns into pure periodicity:
```{math}
:label: eq-scaling-G

G(t+1)=\frac{F(t+1)}{4^{t+1}}=\frac{4F(t)}{4\cdot 4^t}=\frac{F(t)}{4^t}=G(t).
```
So $G$ is an arbitrary function of period $1$ — equivalently, an arbitrary
function on the circle $\mathbb R/\mathbb Z$.

:::{dropdown} Lean proof: `gauge_periodic`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-gauge-periodic
:end-before: ANCHOR_END: flow-scaling-gauge-periodic
```
The Lean `gauge E t` is $G(t)=E(2^t)/4^t$; `gauge_periodic` is exactly
$G(t+1)=G(t)$.
:::

Undoing the substitution is immediate. Using the real logarithm of the positive
number $v$, we have $2^{\log_2 v}=v$ and therefore $4^{\log_2 v}=(2^{\log_2 v})^2=v^2$,
so for every $v>0$
```{math}
:label: eq-scaling-reconstruct

E(v)=v^2\,G(\log_2 v).
```
This is a definitional identity that needs only $v>0$; the content is that $G$ is
$1$-periodic.

:::{dropdown} Lean proof: `eq_sq_mul_gauge`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-reconstruct
:end-before: ANCHOR_END: flow-scaling-reconstruct
```
:::

(scaling-general-solution)=
## The general solution

Combining {eq}`eq-scaling-G` and {eq}`eq-scaling-reconstruct` gives the complete
description of the solutions.

:::{tip} Theorem (general solution)
A function $E:(0,\infty)\to\mathbb R$ satisfies $E(2v)=4E(v)$ for all $v>0$ if and
only if
```{math}
:label: eq-scaling-formula

\boxed{\;E(v)=v^2\,P(\log_2 v),\qquad P(t+1)=P(t)\;}
```
for some $1$-periodic function $P:\mathbb R\to\mathbb R$. The function $P=G$ is
recovered by $P(t)=E(2^t)/4^t$.
:::

The converse direction is a direct computation: if $P$ has period $1$ then
$\log_2(2v)=\log_2 v+1$ gives
$$
(2v)^2 P(\log_2(2v))=4v^2 P(\log_2 v+1)=4v^2P(\log_2 v)=4\bigl[v^2P(\log_2 v)\bigr].
$$

:::{dropdown} Lean proof: `isSolution_of_periodic` (converse) and `isSolution_iff_exists_periodic`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-converse
:end-before: ANCHOR_END: flow-scaling-converse
```
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-iff
:end-before: ANCHOR_END: flow-scaling-iff
```
The `iff` is the boxed classification: `IsSolution E` holds exactly when `E`
agrees on $(0,\infty)$ with $v\mapsto v^2P(\log_2 v)$ for a $1$-periodic `P`.
:::

(scaling-classification)=
## Classification by regularity

Formula {eq}`eq-scaling-formula` sets up a **bijection**
$$
P\ \longleftrightarrow\ E,\qquad E(v)=v^2P(\log_2 v),\qquad P(t)=\frac{E(2^t)}{4^t},
$$
between $1$-periodic functions $P$ and solutions $E$. Both directions are built
from the smooth, smoothly invertible maps $v\mapsto v^2$ and $v\mapsto\log_2 v$ on
$(0,\infty)$ (and $t\mapsto 2^t$, $t\mapsto 4^t$ going back), so **the regularity
of $E$ equals the regularity of $P$**: $E$ is measurable / continuous / smooth iff
$P$ is. The classification is therefore the classification of $1$-periodic
functions of the corresponding regularity, which is the crux of the matter.

(scaling-rigid)=
### Rigid solutions $cv^2$

The constant periodic functions $P\equiv c$ correspond to the **rigid** power-law
solutions
$$
E(v)=cv^2,\qquad c\in\mathbb R.
$$
These always solve the equation ($c(2v)^2=4cv^2$), and conversely the gauge of
$cv^2$ is the constant $c$, so they are exactly the constant-$P$ slice of
{eq}`eq-scaling-formula`.

:::{dropdown} Lean proof: `isSolution_const_mul_sq`, `gauge_const_mul_sq`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-rigid
:end-before: ANCHOR_END: flow-scaling-rigid
```
:::

(scaling-measurable)=
### Measurable and continuous solutions: regularity is not enough

Because regularity transfers across the bijection, the measurable solutions are
**exactly** $E(v)=v^2P(\log_2 v)$ with $P$ a measurable $1$-periodic function, and
the continuous solutions are exactly those with $P$ continuous and $1$-periodic.

:::{dropdown} Lean proof: regularity transfer `measurable_gauge_of_measurable`, `measurable_solution_of_periodic`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-measurable-transfer
:end-before: ANCHOR_END: flow-scaling-measurable-transfer
```
:::

This is the decisive difference from Cauchy's additive equation. There,
$a(x+y)=a(x)+a(y)$ together with measurability forces the single-parameter family
$a(x)=cx$ (see [Homomorphisms $\mathbb C^*\to\mathbb C^*$](cstar_homomorphism.md)).
Here, **neither measurability nor continuity nor smoothness collapses the
family**: the space of continuous $1$-periodic $P$ is already infinite
dimensional. For a concrete witness, take $P(t)=\cos(2\pi t)$, which gives the
smooth solution
```{math}
:label: eq-scaling-cos

E(v)=v^2\cos(2\pi\log_2 v).
```
It is continuous on $(0,\infty)$ and solves $E(2v)=4E(v)$, yet it is **not** of the
form $cv^2$: at $v=1$ it equals $1$ (forcing $c=1$), while at $v=2^{1/2}$ it equals
$2\cos\pi=-2$ (forcing $c=-1$).

:::{dropdown} Lean proof: `cosSolution_isSolution`, `cosSolution_continuousOn`, `cosSolution_not_rigid`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-continuous-not-rigid
:end-before: ANCHOR_END: flow-scaling-continuous-not-rigid
```
:::

:::{note} Recovering rigidity needs a second, incommensurable scale
What singles out $E(v)=cv^2$ is an extra constraint that kills all nonconstant
periodic $P$. The cleanest is a second scaling law $E(\lambda v)=\lambda^2 E(v)$
for some $\lambda>0$ with $\log_2\lambda$ **irrational**. Then $P$ has the two
incommensurable periods $1$ and $\log_2\lambda$, so its group of periods is dense.
A measurable function with a dense group of periods is almost everywhere constant
(a Steinhaus-type argument), giving $E(v)=cv^2$. Without measurability the
dichotomy of Cauchy's equation reappears: a Hamel basis of $\mathbb R$ over
$\mathbb Q$ produces nonconstant functions with a dense period group, hence
pathological non-rigid solutions. This stronger two-scale statement is not
formalized here.
:::

(scaling-pathological)=
### Non-measurable solutions

Without any regularity, $P$ may be any $1$-periodic function, including
non-measurable ones, which then yield non-measurable solutions $E$. Such $P$
exist only through the axiom of choice. A convenient construction reuses Cauchy's
additive equation: take a non-linear additive map $a_0:\mathbb R\to\mathbb R$
(built from a Hamel basis, hence non-measurable) and normalize it to
$a(x)=a_0(x)-a_0(1)\,x$, so that $a$ is additive with $a(1)=0$. Then $a$ is
$1$-periodic, since $a(t+1)=a(t)+a(1)=a(t)$, and still non-measurable, so
$$
E(v)=v^2\,a(\log_2 v)
$$
is a non-measurable solution of $E(2v)=4E(v)$.

:::{dropdown} Lean proof: `exists_isSolution_not_measurable`
```{literalinclude} math_notes_lean/MathNotesLean/ScalingFunctionalEquationFlow.lean
:language: lean
:start-after: ANCHOR: flow-scaling-pathological
:end-before: ANCHOR_END: flow-scaling-pathological
```
The non-measurability of $a$ comes from the measurable additive theorem
`CstarFlow.cauchy_additive_measurable_linear`: a measurable additive map equals
$a(1)\,x=0$, contradicting non-linearity. Non-measurability of $E$ is then
transported back to $a$ via $a(t)=E(2^t)/4^t$.
`#print axioms exists_isSolution_not_measurable` confirms the expected dependence
on `Classical.choice`.
:::

(scaling-summary)=
## Summary

| Hypothesis on $E$ | Solutions of $E(2v)=4E(v)$, $v>0$ |
| --- | --- |
| none | $E(v)=v^2P(\log_2 v)$, $P$ any $1$-periodic function |
| measurable | $E(v)=v^2P(\log_2 v)$, $P$ measurable $1$-periodic (still infinite-dimensional) |
| continuous | $E(v)=v^2P(\log_2 v)$, $P$ continuous $1$-periodic (e.g. $v^2\cos(2\pi\log_2 v)$) |
| $E=cv^2$ | exactly $P\equiv c$ constant |

The single relation $E(2v)=4E(v)$ fixes the **power** ($v^2$) but leaves a full
log-periodic gauge free; only an additional incommensurable scale, together with
measurability, reduces the answer to the one-parameter family $cv^2$.
