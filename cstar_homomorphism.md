# Homomorphisms from C-star to C-star

This note collects the Cauchy functional equations used when a determinant
argument leaves a one-variable group homomorphism
$$
g:\mathbb C^*\to\mathbb C^*,
\qquad
g(zw)=g(z)g(w).
$$
Without regularity assumptions such homomorphisms can be highly nonconstructive.
With continuity, or even Borel measurability, they have one simple form.

:::{note} Lean formalization
The proofs in this note are formalized in Lean 4 + Mathlib in
[`CstarHomomorphism.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/CstarHomomorphism.lean),
together with the general automatic-continuity lemmas in
[`AutomaticContinuity.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/AutomaticContinuity.lean).
Each **Lean proof** dropdown below includes the corresponding declaration
verbatim from the compiled source, so the displayed code cannot drift from what
is actually checked. Continuous integration runs `lake build` (which fails on any
error or `sorry`), so every displayed proof is guaranteed to type-check.

Lean's kernel guarantees each *proof* is correct. Whether a Lean *statement*
faithfully captures the informal claim is a human judgement, so each dropdown is
placed next to the statement it formalizes, for direct comparison.
:::

(cauchy-additive)=
## Cauchy's Additive Functional Equation

Cauchy's functional equation (@wiki:CauchyFunctionalEquation) usually means the
additive equation
```{math}
:label: eq-cauchy-additive

a(x+y)=a(x)+a(y).
```
There are other related equations, such as Cauchy's multiplicative functional
equation in the next section.

For an integer $n>0$,
$$
a(nx)
=a(\underbrace{x+x+\dots+x}_{n})
=\underbrace{a(x)+a(x)+\dots+a(x)}_{n}
=na(x).
$$
Also $a(0)=a(0)+a(0)$, so $a(0)=0$, and
$$
0=a(0)=a(x-x)=a(x)+a(-x),
$$
so $a(-x)=-a(x)$. Thus $a(nx)=na(x)$ for all integers $n$.

By substituting $y=nx$, we get $a(y)=na(y/n)$, hence
$$
a(y/n)={1\over n}a(y).
$$
Combining multiplication and division by integers gives, for any rational
$q=p/n$,
$$
a(qx)=a\left({p\over n}x\right)
=p\,a\left({x\over n}\right)
={p\over n}a(x)
=q\,a(x).
$$
Setting $x=1$, every additive solution satisfies
$$
a(q)=q\,a(1)=cq
$$
for rational $q$, where $c=a(1)$.

:::{dropdown} Lean proof: `cauchy_additive_rat_homogeneous`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: additive-rat
:end-before: ANCHOR_END: additive-rat
```
:::

:::{note}
The condition $a(q)=cq$ on rational numbers is not enough by itself. For
example, the measurable function
$$
a(x)=
\begin{cases}
cx, & x\in\mathbb Q,\\
0, & x\notin\mathbb Q,
\end{cases}
$$
has the correct values on $\mathbb Q$, but it is not additive unless $c=0$.
Indeed, if $q\in\mathbb Q$ is nonzero and $\alpha\notin\mathbb Q$, then
$\alpha+q\notin\mathbb Q$, so
$$
a(\alpha+q)=0
\qquad\text{but}\qquad
a(\alpha)+a(q)=cq.
$$
Thus the additive hypothesis is essential, in addition to measurability.
:::

:::{dropdown} Lean proof: `rationalAgreementExample_not_additive`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: additive-counterexample
:end-before: ANCHOR_END: additive-counterexample
```
The function is also measurable (`measurable_rationalAgreementExample`) and agrees
with `c·x` on the rationals (`rationalAgreementExample_rat`), matching the note.
:::

:::{tip} Theorem
If $a:\mathbb R\to\mathbb R$ is additive and measurable, then
$$
a(x)=cx,\qquad c=a(1).
$$
:::

:::{note} Proof
Let $b(x)=a(x)-a(1)x$. Then $b$ is additive, measurable, and $b(q)=0$ for
all rational $q$. It is enough to prove that $b=0$.

Since
$$
[-1,1]=\bigcup_{m=1}^{\infty}\{x\in[-1,1]: |b(x)|\le m\},
$$
one of these measurable sets has positive measure. Let
$$
E=\{x\in[-1,1]: |b(x)|\le m\}
$$
be such a set. By the Steinhaus theorem, the difference set
$$
E-E=\{u-v:u,v\in E\}
$$
contains an open interval around $0$: there is $\epsilon>0$ such that
$(-\epsilon,\epsilon)\subset E-E$. Thus, if $|t|<\epsilon$, then $t=u-v$ for some
$u,v\in E$. By additivity,
$$
b(t)=b(u-v)=b(u)-b(v),
$$
so
$$
|b(t)|\le |b(u)|+|b(v)|\le 2m.
$$
Therefore $b$ is bounded on an interval around $0$. Taking
$\delta=\epsilon/2$ and $M=2m$, we have
$$
|b(t)|\le M
\qquad\text{whenever}\qquad
|t|\le\delta.
$$
Additivity then implies continuity at $0$. Indeed, let $x_j\to0$. For
$x_j\ne0$, choose, for all large $j$,
$$
n_j=\left\lfloor {\delta\over 2|x_j|}\right\rfloor.
$$
Then $n_j\to\infty$ and $|n_jx_j|\le\delta$, so $n_jx_j$ lies in the interval
where $b$ is bounded. Since $b$ is additive,
$$
b(n_jx_j)=n_jb(x_j),
$$
and therefore
$$
|b(x_j)|={|b(n_jx_j)|\over n_j}\to0.
$$
The last limit follows from $|b(n_jx_j)|\le M$ and $n_j\to\infty$. Hence
$b$ is continuous at $0$.

An additive function continuous at $0$ is continuous everywhere. To see this,
fix $x_0\in\mathbb R$ and let $x\to x_0$. Then $x-x_0\to0$, and additivity
gives
$$
b(x)-b(x_0)=b(x-x_0).
$$
Since $b$ is continuous at $0$, the right-hand side tends to $0$. Therefore
$b(x)\to b(x_0)$, so $b$ is continuous at $x_0$. Since $x_0$ was arbitrary,
$b$ is continuous everywhere. Since $b$ vanishes on the dense set $\mathbb Q$,
continuity gives $b(x)=0$ for every real $x$.
:::

:::{dropdown} Lean proof: `cauchy_additive_measurable_linear` (and `cauchy_additive_measurable_exists`)
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: additive-linear
:end-before: ANCHOR_END: additive-linear
```
Mathlib supplies the Steinhaus/measurable-implies-continuous step as
`MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`, which is the
content of the boundedness-and-continuity argument written out above.
:::

:::{note}
Measurability is essential. Without it, Cauchy's additive equation {eq}`eq-cauchy-additive` has
*nonlinear* solutions: additive functions $a:\mathbb R\to\mathbb R$ that are not of the form
$a(x)=cx$ for any constant $c$ (formalized below). Any such $a$ is necessarily non-measurable, by
the theorem above. The construction takes a single coordinate of a Hamel basis of $\mathbb R$ over
$\mathbb Q$, and therefore depends on the axiom of choice. Classically one can say more — there are
infinitely many such solutions and their graphs are dense in $\mathbb R^2$ — but only their
existence is formalized here.
:::

:::{dropdown} Lean proof: `exists_additive_not_linear`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: additive-pathological
:end-before: ANCHOR_END: additive-pathological
```
The Hamel basis is `Module.Basis.ofVectorSpace ℚ ℝ`; `Real.rank_rat_real` (rank `= 𝔠 > 1`) provides
two distinct basis indices, and the additive-but-nonlinear map is the coordinate at one of them.
`#print axioms exists_additive_not_linear` confirms the expected dependence on `Classical.choice`.
:::

(cauchy-multiplicative-real)=
## Cauchy's Multiplicative Functional Equation

Cauchy's multiplicative functional equation is
```{math}
:label: eq-cauchy-multiplicative-real

m(xy)=m(x)m(y).
```

For a real-valued measurable function on $\mathbb R$, the nonzero,
nonconstant-one solutions are most cleanly written on $\mathbb R^*$ by the
single formula
```{math}
:label: eq-real-multiplicative-one-formula

m(x)=\operatorname{sgn}(x)^\epsilon |x|^c,
\qquad x\in\mathbb R^*,
\qquad \epsilon\in\{0,1\},\quad c\in\mathbb R.
```
They extend to $\mathbb R$ by setting $m(0)=0$. In addition, there are the
two degenerate solutions $m\equiv0$ and $m\equiv1$ on all of $\mathbb R$.

Here is the derivation. If $m\not\equiv0$, then $m(1)=1$. On positive
numbers, $m(x)>0$, because $x=(\sqrt x)^2$ and $m(x)=m(\sqrt x)^2$, and
also $m(x)\ne0$, because $m(x)m(x^{-1})=m(1)=1$. Define
$$
b(t)=\log m(e^t).
$$
Then
$$
b(t+u)=\log m(e^{t+u})
=\log m(e^t e^u)
=\log(m(e^t)m(e^u))
=b(t)+b(u).
$$
If $m$ is measurable, then $b$ is measurable, so by the additive theorem
$$
b(t)=ct,
$$
and therefore
$$
m(x)=x^c,\qquad x>0.
$$
Finally, $m(-1)^2=m(1)=1$, so $m(-1)=1$ or $m(-1)=-1$. Hence
$$
m(x)=m(\operatorname{sgn}(x))m(|x|)
=\operatorname{sgn}(x)^\epsilon |x|^c,
\qquad x\in\mathbb R^*,
$$
with $\epsilon=0$ in the even case and $\epsilon=1$ in the odd case.

:::{dropdown} Lean proof: `cauchy_multiplicative_eq_sign_rpow_on_nonzero`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: mult-formula
:end-before: ANCHOR_END: mult-formula
```
The supporting steps `m(x)>0` on positives, `m(-1)²=1`, and `b(t)=log m(eᵗ)`
additive are `cauchy_multiplicative_pos_of_pos`, `cauchy_multiplicative_neg_one_sq`,
and `cauchy_multiplicative_log_exp_additive`.
:::

(cstar-homomorphism-formula)=
## Measurable Homomorphisms $\mathbb C^*\to\mathbb C^*$

Let $g:\mathbb C^*\to\mathbb C^*$ be a group homomorphism. If $g$ is
continuous, or merely Borel measurable, then
```{math}
:label: eq-cstar-homomorphism-formula

\boxed{\;
g(w)=|w|^s\left({w\over |w|}\right)^k,
\qquad s\in\mathbb C,\quad k\in\mathbb Z.
\;}
```
Here $|w|^s=\exp(s\log |w|)$, using the real logarithm of the positive number
$|w|$, so there is no branch choice.

Conversely, every formula in {eq}`eq-cstar-homomorphism-formula` defines a
continuous homomorphism $\mathbb C^*\to\mathbb C^*$.

:::{dropdown} Lean proof: `cstarFormulaHom` is a homomorphism (continuity: `cstarFormulaContinuousHom`)
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-converse
:end-before: ANCHOR_END: cstar-converse
```
Continuity of this formula is `continuous_cstarFormulaHom`, bundled as the
`ContinuousMonoidHom` named `cstarFormulaContinuousHom`; the special case
`cstarFormulaHom 1 1 = id` is `cstarFormulaHom_one_one`.
:::

:::{note} Derivation
A Borel measurable homomorphism between these locally compact groups is
automatically continuous (proved below in
[](#cstar-automatic-continuity)), so it suffices to classify continuous
homomorphisms. Every $w\in\mathbb C^*$ decomposes uniquely as
$$
w=r\zeta,\qquad r=|w|\in\mathbb R_{>0},\qquad \zeta={w\over |w|}\in S^1.
$$
Since these two factors commute,
$$
g(w)=g(r)g(\zeta).
$$

For the positive factor, set $G(t)=g(e^t)$. This is a continuous homomorphism
$(\mathbb R,+)\to\mathbb C^*$. Because $\mathbb R$ is simply connected, it
lifts through the exponential map to an additive continuous function
$\ell:\mathbb R\to\mathbb C$ with
$$
G(t)=\exp(\ell(t)).
$$
Thus $\ell(t)=st$ for some $s\in\mathbb C$, and
$$
g(r)=r^s.
$$

For the unit-circle factor, the image of $S^1$ is compact. Its modulus is a
compact subgroup of $\mathbb R_{>0}$, hence trivial, so $g(S^1)\subset S^1$.
Continuous characters of $S^1$ are exactly
$$
\zeta\mapsto \zeta^k,\qquad k\in\mathbb Z.
$$
Therefore
$$
g(\zeta)=\zeta^k.
$$
Multiplying the positive and unit-circle parts gives
{eq}`eq-cstar-homomorphism-formula`.
:::

The Lean formalization of this derivation is split into the steps below.

:::{dropdown} Lean: polar split `g(w) = g(|w|)·g(w/|w|)` — `cstar_homomorphism_polar_factorization`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-polar
:end-before: ANCHOR_END: cstar-polar
```
:::

:::{dropdown} Lean: positive factor `g(eᵗ) = exp(s·t)` — `real_to_cstar_exp_linear_of_lift`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-positive
:end-before: ANCHOR_END: cstar-positive
```
This takes the additive logarithmic lift `ell` as a hypothesis (the "ℝ is simply
connected, so it lifts through exp" step) and concludes the exponent form; the
linear part `ℓ(t)=s·t` is `cauchy_additive_continuous_complex_linear`.
:::

:::{dropdown} Lean: the circle factor has modulus one, `g(S¹) ⊆ S¹` — `circle_hom_norm_eq_one`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-circle
:end-before: ANCHOR_END: cstar-circle
```
The "compact subgroup of `ℝ_{>0}` is trivial" argument is
`compact_additive_hom_to_real_eq_zero`, applied via `circle_hom_log_norm_eq_zero`.
:::

:::{dropdown} Lean: continuous circle characters are `ζ ↦ ζᵏ` — `continuous_circle_endomorphism_eq_zpow`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-circle-char
:end-before: ANCHOR_END: cstar-circle-char
```
`continuous_circle_endomorphism_eq_zpow` is the unconditional statement, combining the integer-slope
result below with `circle_endomorphism_eq_zpow_of_exp_lift` (which turns the exponential-coordinate
formula `exp t ↦ exp (k·t)` into `z ↦ zᵏ`); `circle_to_cstar_hom_eq_zpow_of_exp_lift` is the
`Circle → ℂˣ` variant used by the assembly. The converse `ζ ↦ ζᵏ` direction is
`circlePowerContinuousHom`.
:::

:::{dropdown} Lean: continuous circle characters have integer slope — `circle_endomorphism_exp_int_slope`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-circle-fourier
:end-before: ANCHOR_END: cstar-circle-fourier
```
This is the analytic heart of "continuous characters of $S^1$ are $\zeta\mapsto\zeta^k$":
the character is identified with a nonzero Fourier mode on the additive circle. The
supporting Fourier lemmas are `circleValuedContinuousMap`,
`exists_nonzero_fourierCoeff_circleValued`, `fourierCoeff_eigen`, and
`continuous_addCircle_char_eq_fourier`.
:::

:::{tip} Status of the Lean classification
The classification is proved end-to-end in Lean for **both** the continuous and the
Borel-measurable case. The circle character input uses Fourier analysis on the additive
circle (`circle_endomorphism_exp_int_slope`), the positive radial input uses the covering
map `Complex.exp : ℂ → ℂˣ` (`additive_cstar_exp_linear`), and the "merely Borel measurable
⇒ continuous" reduction is `cstar_homomorphism_continuous_of_measurable`. Continuous
integration runs `lake build`, which fails on any error or `sorry`, so every displayed proof
is guaranteed to type-check.
:::

:::{dropdown} Lean: final assembly into the boxed formula — `cstar_homomorphism_formula_continuous`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-assembly
:end-before: ANCHOR_END: cstar-assembly
```
Three layers are shown: `cstar_homomorphism_formula_of_radial_and_circle` assembles
the boxed formula from both factor classifications; `..._lift` discharges the circle
factor from its exponential-coordinate slope; and `cstar_homomorphism_formula_of_radial`
classifies the circle automatically (via `circle_endomorphism_exp_int_slope`), so only
the radial hypothesis `hradial` remains.
:::

(cstar-automatic-continuity)=
### Borel measurability implies continuity

The boxed formula was derived assuming continuity, but the same conclusion holds for any
**Borel measurable** homomorphism, because such a homomorphism is automatically continuous.

The analytic heart is automatic continuity for the one-parameter factors
$(\mathbb R,+)\to\mathbb C^*$. Let $f:\mathbb R\to\mathbb C^*$ be measurable with
$f(t+s)=f(t)f(s)$, and write $\Phi(t)=f(t)\in\mathbb C$.

* **Modulus.** $\rho(t)=|\Phi(t)|$ satisfies $\rho(t+s)=\rho(t)\rho(s)$, so
  $t\mapsto\log\rho(t)$ is additive and measurable, hence linear by the additive measurable
  Cauchy theorem; thus $\rho(t)=e^{ct}$ is continuous. In particular $\Phi$ is locally
  bounded, so it is integrable on every bounded interval.
* **Phase, by the integration trick.** The primitive
  $F(y)=\int_0^y\Phi$ is continuous. The Lebesgue differentiation theorem forces
  $F(a)\neq0$ for some $a$ (otherwise $\Phi=0$ almost everywhere, impossible since
  $\Phi$ never vanishes). The homomorphism property gives the sliding-window identity
  $$
  \Phi(s)\,F(a)=\int_0^a\Phi(s+u)\,du=\int_s^{s+a}\Phi=F(s+a)-F(s),
  $$
  so $\Phi(s)=\dfrac{F(s+a)-F(s)}{F(a)}$ is continuous in $s$. Hence $f$ is continuous.

Applying this to the radial path $t\mapsto g(e^t)$ and, after pulling back through the
covering quotient map $\mathtt{Circle.exp}:\mathbb R\to S^1$, to the unit circle, both polar
factors of $g$ are continuous, so $g$ is continuous everywhere.

This automatic-continuity step is proved in
[`AutomaticContinuity.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/AutomaticContinuity.lean)
not just for $\mathbb C$ but for any field with `RCLike 𝕜` (so for both $\mathbb R$ and
$\mathbb C$): it is the multiplicative companion of Mathlib's additive automatic-continuity
theorem `MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`.

:::{dropdown} Lean: measurable multiplicative `ℝ → 𝕜` is continuous — `continuous_of_measurable_of_mul`
```{literalinclude} math_notes_lean/MathNotesLean/AutomaticContinuity.lean
:language: lean
:start-after: ANCHOR: measurable-mul-continuous
:end-before: ANCHOR_END: measurable-mul-continuous
```
The modulus step calls Mathlib's additive theorem
`MeasureTheory.Measure.AddMonoidHom.continuous_of_measurable`; the nonvanishing window is supplied
by the interval form of the Lebesgue differentiation theorem
(`LocallyIntegrable.ae_hasDerivAt_integral`); the primitive's continuity is
`intervalIntegral.continuous_primitive`.
:::

:::{dropdown} Lean: measurable homomorphism `ℝ → 𝕜ˣ` is continuous — `continuous_of_measurable_of_mul_units`
```{literalinclude} math_notes_lean/MathNotesLean/AutomaticContinuity.lean
:language: lean
:start-after: ANCHOR: measurable-mul-units-continuous
:end-before: ANCHOR_END: measurable-mul-units-continuous
```
The unit-circle factor of $g$ descends through the quotient map `Circle.exp` in
`continuous_cstar_on_circle`, and the radial factor uses this lemma directly.
:::

:::{dropdown} Lean: measurable ⇒ continuous and the boxed formula — `cstar_homomorphism_formula_measurable`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: cstar-measurable
:end-before: ANCHOR_END: cstar-measurable
```
`cstar_homomorphism_continuous_of_measurable` assembles the radial and unit-circle factor
continuities through the polar factorization, and
`cstar_homomorphism_formula_measurable` feeds the resulting continuity into
`cstar_homomorphism_formula_continuous`.
:::

This is the formula needed for the free factor $g$ in
[Determinant From Homomorphism](determinant_homomorphism.md).

(multiplicative-cauchy-from-measurable-homomorphisms)=
## Multiplicative Cauchy from Measurable Homomorphisms

The measurable homomorphism classification gives a shorter derivation of the
solutions to {eq}`eq-cauchy-multiplicative-real`.

Let $m:\mathbb R\to\mathbb R$ be measurable and multiplicative:
$$
m(xy)=m(x)m(y).
$$
First, $m(1)=m(1)^2$, so $m(1)=0$ or $m(1)=1$. If $m(1)=0$, then
$$
m(x)=m(x\cdot 1)=m(x)m(1)=0,
$$
so $m\equiv0$.

Now assume $m(1)=1$. Since $m(0)=m(0)^2$, either $m(0)=0$ or $m(0)=1$. If
$m(0)=1$, then
$$
1=m(0)=m(0\cdot x)=m(0)m(x)=m(x),
$$
so $m\equiv1$.

It remains to handle $m(1)=1$ and $m(0)=0$. For every $x\in\mathbb R^*$,
$$
m(x)m(x^{-1})=m(1)=1,
$$
so $m(x)\in\mathbb R^*$. Therefore the restriction
$$
m|_{\mathbb R^*}:\mathbb R^*\to\mathbb R^*
$$
is a measurable group homomorphism.

The same classification argument as in
[](#cstar-homomorphism-formula), applied to
$\mathbb R^*\cong\mathbb R_{>0}\times\{\pm1\}$, gives
```{math}
:label: eq-rstar-homomorphism-formula

m(x)=\operatorname{sgn}(x)^\epsilon |x|^c,
\qquad x\in\mathbb R^*,
\qquad \epsilon\in\{0,1\},\quad c\in\mathbb R.
```
Indeed, the positive factor contributes $|x|^c$, and the $\{\pm1\}$ factor
contributes $m(-1)=\pm1$, which is $\operatorname{sgn}(x)^\epsilon$.

Extending by $m(0)=0$ gives exactly the nondegenerate solutions listed in
{eq}`eq-real-multiplicative-one-formula`, together with the degenerate
solutions $m\equiv0$ and $m\equiv1$.

:::{dropdown} Lean proof: `cauchy_multiplicative_measurable_classification_with_zero`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: mult-classification
:end-before: ANCHOR_END: mult-classification
```
The three-way split (`m≡0`, `m≡1`, or the nondegenerate formula) follows the same
case analysis on `m(1)` and `m(0)` used in the text; `eq_zero_or_eq_one_of_eq_mul_self`
is the `a=a²ᵉ ⇒ a∈{0,1}` lemma.
:::

The parameters in {eq}`eq-rstar-homomorphism-formula` are **unique**: the radial exponent
$c\in\mathbb R$ is read off at $x=2$ (so $2^c=2^{c'}\Rightarrow c=c'$), and the sign $m(-1)\in\{\pm1\}$
at $x=-1$. This is the real counterpart of the complex uniqueness
[](#cstar-homomorphism-formula): there the angular exponent is a full integer $k\in\mathbb Z$,
because the circle $U(1)$ has characters $\widehat{U(1)}=\mathbb Z$; here the angular group is
$\{\pm1\}$, whose character group is $\mathbb Z/2$, so the integer $k$ collapses to
$\epsilon=k\bmod 2$ — $k=1$ and $k=3$ give the same real sign character $\operatorname{sgn}$.

:::{dropdown} Lean proof: `existsUnique_cauchy_multiplicative_sign_rpow` (and `realSignRpow_injective`)
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: mult-uniqueness
:end-before: ANCHOR_END: mult-uniqueness
```
:::

(cauchy-multiplicative-complex)=
## Multiplicative Functions on $\mathbb C$

The same argument extends the boxed homomorphism classification from $\mathbb C^*$ to all of
$\mathbb C$, i.e. to measurable functions
$$
m:\mathbb C\to\mathbb C,\qquad m(zw)=m(z)m(w),
$$
whose domain now contains $0$. The result is the exact complex analogue of the real case in
[](#multiplicative-cauchy-from-measurable-homomorphisms): there are two degenerate solutions and
one nondegenerate family.

First, $m(1)=m(1)^2$, so $m(1)=0$ or $m(1)=1$. If $m(1)=0$, then
$$
m(z)=m(z\cdot 1)=m(z)m(1)=0,
$$
so $m\equiv0$.

Now assume $m(1)=1$. Since $m(0)=m(0)^2$, either $m(0)=0$ or $m(0)=1$. If $m(0)=1$, then
$$
1=m(0)=m(0\cdot z)=m(0)m(z)=m(z),
$$
so $m\equiv1$.

It remains to handle $m(1)=1$ and $m(0)=0$. For every $z\in\mathbb C^*$,
$$
m(z)m(z^{-1})=m(1)=1,
$$
so $m(z)\in\mathbb C^*$, and the restriction $m|_{\mathbb C^*}:\mathbb C^*\to\mathbb C^*$ is a
measurable group homomorphism. By the boxed classification
{eq}`eq-cstar-homomorphism-formula`,
$$
m(z)=|z|^{\,s}\left(\frac{z}{|z|}\right)^{k},
\qquad z\in\mathbb C^*,\qquad s\in\mathbb C,\ k\in\mathbb Z,
$$
and the value at $0$ is fixed by $m(0)=0$.

So, in contrast with the $\mathbb C^*\to\mathbb C^*$ group homomorphisms (where $m\equiv1$ is just
the parameter choice $s=0,\,k=0$ and $m\equiv0$ is impossible), the equation on all of $\mathbb C$
genuinely has the two extra degenerate solutions $m\equiv0$ and $m\equiv1$, exactly because the
codomain now includes $0$ and the domain now includes $0$.

:::{dropdown} Lean proof: `cauchy_multiplicative_complex_classification`
```{literalinclude} math_notes_lean/MathNotesLean/CstarHomomorphism.lean
:language: lean
:start-after: ANCHOR: mult-complex-classification
:end-before: ANCHOR_END: mult-complex-classification
```
The nondegenerate branch packages `m|_{ℂ*}` as a `ℂˣ →* ℂˣ` (`m z ≠ 0` for `z ≠ 0` because
`m(z)m(z⁻¹)=1`), checks it is measurable, and applies `cstar_homomorphism_formula_measurable`;
the polar factors are read back to `ℂ` via `coe_cstarNormCPow` and `coe_cstarCircleUnit`. The
shared `a=a² ⇒ a∈{0,1}` lemma `eq_zero_or_eq_one_of_eq_mul_self` is now stated for any field, so it
serves both the real and the complex case.
:::
