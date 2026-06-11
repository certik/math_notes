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
one of these measurable sets has positive measure. By the Steinhaus theorem,
its difference set contains an interval around $0$, so $b$ is bounded on
some interval around $0$. Additivity then implies continuity at $0$: if
$x_j\to0$, choose integers $n_j\to\infty$ with $n_jx_j$ in that interval;
then
$$
|b(x_j)|={|b(n_jx_j)|\over n_j}\to0.
$$
An additive function continuous at $0$ is continuous everywhere. Since $b$
vanishes on the dense set $\mathbb Q$, continuity gives $b(x)=0$ for every
real $x$.
:::

:::{note}
If measurability is not required, there are infinitely many nonlinear solutions
to {eq}`eq-cauchy-additive`, and their graphs are dense in $\mathbb R^2$. These
are the pathological Cauchy solutions excluded by measurability.
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

:::{note} Derivation
A Borel measurable homomorphism between these locally compact groups is
automatically continuous, so it suffices to classify continuous homomorphisms.
Every $w\in\mathbb C^*$ decomposes uniquely as
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

This is the formula needed for the free factor $g$ in
[Determinant From Homomorphism](determinant_homomorphism.md).

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
