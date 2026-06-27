# Kinetic Energy is Quadratic: a Galilean-Invariance Derivation

This note derives the functional form of kinetic energy,
$$
E(v)=c\,v^2,
$$
from a single inelastic-collision thought experiment together with Galilean
invariance. The key intermediate result is the **parallelogram law**
$$
E(v+b)+E(v-b)=2E(v)+2E(b)\qquad\text{for all }v,b,
$$
which holds because the same collision, viewed from a continuous family of moving
frames, must balance energy in each of them. Unlike the single doubling relation
$E(2v)=4E(v)$ studied in
[the scaling functional equation](scaling_functional_equation.md) — which is too
weak to fix the form of $E$ — the parallelogram law constrains $E$ at a *dense*
set of scales, and so (with a mild regularity assumption) pins it down completely.

:::{note}
This is the "complete" companion to
[the scaling functional equation $E(2v)=4E(v)$](scaling_functional_equation.md).
There we saw that the doubling relation alone, even with continuity, leaves a free
log-periodic factor, because iterating it only reaches the discrete set of scales
$\{2^n:n\in\mathbb Z\}$. Here we show what extra physics removes that freedom:
boosting the collision by an *arbitrary* velocity $b$, not just by $b=v$.
:::

:::{note} Lean formalization
The derivations in this note are formalized in Lean 4 + Mathlib in
[`KineticEnergyGalileanFlow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean).
It takes the parallelogram law {eq}`eq-ke-parallelogram` as the hypothesis (the physics input) and
proves that its continuous — and even merely *measurable* — solutions are exactly the quadratics
$E(v)=E(1)\,v^2$, together with the converse and the non-measurable Hamel-basis pathology. Each
**Lean proof** dropdown below splices the corresponding declaration verbatim from the compiled
source. Continuous integration runs `lake build` (which fails on any error or `sorry`), so every
displayed proof is guaranteed to type-check.
:::

(ke-what-is-E)=
## What we are computing

We treat the kinetic energy of a moving body as a function of its speed alone.

:::{tip} Operational definition
$E(v)$ is the **kinetic energy per unit mass** of a body moving at speed $v$. It
can be measured directly: a soft (perfectly inelastic) ball of mass $m$ moving at
speed $v$ that strikes a rigid wall and sticks comes to rest, converting all of
its kinetic energy into heat. The heat released, per unit mass, is $E(v)$.
:::

The goal is to determine the function $E$. We will find that the physics forces
$E(v)=cv^2$ for a single positive constant $c$ (a unit convention; the Newtonian
choice is $c=\tfrac12$).

(ke-assumptions)=
## Assumptions

We make the following physical assumptions. Each is stated once and then used
explicitly in the derivation.

- **(P1) Kinetic energy is a state function, extensive in mass and isotropic.**
  A body of mass $m$ at speed $v$ carries kinetic energy $m\,E(v)$, where
  $E:[0,\infty)\to\mathbb R$ depends only on the speed (not on direction or
  internal structure), and $E(0)=0$. Extending $E$ to negative arguments by
  $E(v)=E(|v|)$ makes it an **even** function.
- **(P2) Galilean relativity.** Inertial frames are related by velocity boosts
  $u\mapsto u-b$, and the conservation laws below hold in every inertial frame.
- **(P3) Momentum conservation.** Total momentum $\sum_i m_i u_i$ is conserved in
  a collision; in particular, equal masses that stick together leave with the
  average of their velocities.
- **(P4) Energy balance with heat.** In any inertial frame,
  $$
  (\text{initial kinetic energy})=(\text{final kinetic energy})+Q,
  $$
  where $Q\ge 0$ is the heat produced in the collision.
- **(P5) Heat is frame-invariant.** $Q$ is an internal thermodynamic quantity (a
  temperature rise), so it is the **same number** in every inertial frame.
- **(P6) Regularity.** $E$ is continuous, or merely Lebesgue measurable. (This is
  the only non-mechanical hypothesis; its role is discussed in
  [](#ke-regularity).)

Assumptions (P2), (P3), (P5) are the heart of the argument: the *same* physical
collision is described in many inertial frames, the bookkeeping (P3)–(P4) must
work in each, and the heat (P5) is the frame-independent glue that ties the
descriptions together.

(ke-collision)=
## One collision, seen from every frame

Consider the simplest symmetric collision. Two identical balls, each of mass $m$,
move directly toward each other along a line, one at velocity $+v$ and the other
at $-v$ in the laboratory frame. They are made of clay: they collide, stick, and
form a single body of mass $2m$.

By momentum conservation (P3), the combined body has total momentum
$m(+v)+m(-v)=0$, so it is **at rest** after the collision.

Now view this one event from a second inertial frame $S'$ moving at an arbitrary
velocity $b$ relative to the lab. Velocities transform by $u\mapsto u-b$ (P2). The
velocities of the three objects — the two incoming balls and the final clump — are:

| Object (mass) | Lab frame | Frame $S'$ (boost $b$) | Speed in $S'$ |
| --- | --- | --- | --- |
| Ball 1 ($m$) | $+v$ | $v-b$ | $\lvert v-b\rvert$ |
| Ball 2 ($m$) | $-v$ | $-v-b$ | $\lvert v+b\rvert$ |
| Final clump ($2m$) | $0$ | $-b$ | $\lvert b\rvert$ |

We now write the energy balance (P4) in two frames and equate the heat (P5).

**Laboratory frame.** The two incoming balls have speed $v$, so the initial
kinetic energy is $mE(v)+mE(v)=2mE(v)$. The final body is at rest, with kinetic
energy $2m\,E(0)=0$. Hence the heat is
```{math}
:label: eq-ke-Q-lab

Q=2mE(v).
```

**Frame $S'$.** Using the speeds from the table and extensivity (P1), the initial
kinetic energy is $mE(|v-b|)+mE(|v+b|)$ and the final kinetic energy is the energy
of the mass $2m$ moving at speed $|b|$, namely $2m\,E(|b|)$. Energy balance (P4)
in $S'$, with the **same** heat $Q$ by frame-invariance (P5), reads
```{math}
:label: eq-ke-balance-S

mE(|v-b|)+mE(|v+b|)=2m\,E(|b|)+Q.
```

Substituting {eq}`eq-ke-Q-lab` for $Q$, dividing by $m$, and using that $E$ is
even (P1) to drop the absolute values, we obtain the central identity.

:::{tip} The parallelogram law
For all real $v$ and all real boosts $b$,
```{math}
:label: eq-ke-parallelogram

\boxed{\,E(v+b)+E(v-b)=2E(v)+2E(b)\,.}
```
:::

It holds for *all* $b$ precisely because the boost is arbitrary: each choice of
frame $S'$ is an independent instance of energy conservation for the same event.

:::{note} Sanity check: momentum is consistent in $S'$
In $S'$ the initial momentum is $m(v-b)+m(-v-b)=-2mb$ and the final momentum is
$2m(-b)=-2mb$; they agree, as they must by (P3). So the only nontrivial content of
the boosted description is the energy balance {eq}`eq-ke-balance-S`.
:::

:::{dropdown} Lean: the parallelogram law and its basic consequences
The hypothesis is the predicate `Parallelogram E`.
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-def
:end-before: ANCHOR_END: flow-ke-def
```
From it one reads off $E(0)=0$, evenness, and the doubling slice $E(2v)=4E(v)$, which is exactly
the equation of the companion note (`parallelogram_isSolution`).
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-basic
:end-before: ANCHOR_END: flow-ke-basic
```
:::

(ke-doubling)=
## The doubling relation is just one slice

Setting $b=v$ in {eq}`eq-ke-parallelogram` and using $E(0)=0$ gives
$$
E(2v)+E(0)=2E(v)+2E(v)\;\Longrightarrow\; E(2v)=4E(v).
$$
This is exactly the relation analysed in
[the scaling functional equation](scaling_functional_equation.md). The point of
the present note is that this single slice ($b=v$) is **not enough**: iterating
$E(2v)=4E(v)$ only relates scales differing by integer powers of $2$, a discrete
set, which leaves an entire $1$-periodic factor free. The parallelogram law is the
full content of the physics — all boosts $b$, not just $b=v$ — and as we show next
it determines $E$ completely.

(ke-solve)=
## Solving the parallelogram law

We now extract $E(v)=cv^2$ from {eq}`eq-ke-parallelogram`. Write $c:=E(1)$.

**Step 1 — integer scaling.** Fix $v$ and apply {eq}`eq-ke-parallelogram` with the
two points $nv$ and $v$:
$$
E(nv+v)+E(nv-v)=2E(nv)+2E(v),
$$
that is,
```{math}
:label: eq-ke-recurrence

E\bigl((n+1)v\bigr)=2E(nv)+2E(v)-E\bigl((n-1)v\bigr).
```
With the initial data $E(0\cdot v)=E(0)=0$ and $E(1\cdot v)=E(v)$, the recurrence
{eq}`eq-ke-recurrence` has the unique solution
$$
E(nv)=n^2E(v),\qquad n=0,1,2,\dots,
$$
as one checks by induction:
$2n^2E(v)+2E(v)-(n-1)^2E(v)=(n^2+2n+1)E(v)=(n+1)^2E(v)$. By evenness this holds
for all integers $n\in\mathbb Z$.

**Step 2 — rational scaling.** Applying Step 1 with $v$ replaced by $v/n$ gives
$E(v)=E\bigl(n\cdot\tfrac{v}{n}\bigr)=n^2E(v/n)$, hence
$$
E\!\left(\frac{v}{n}\right)=\frac{1}{n^2}E(v).
$$
Combining the two, for any positive rational $r=p/q$,
$$
E(rv)=E\!\left(p\cdot\frac{v}{q}\right)=p^2\,E\!\left(\frac{v}{q}\right)
=\frac{p^2}{q^2}E(v)=r^2E(v).
$$
Setting $v=1$ yields
```{math}
:label: eq-ke-rational

E(r)=r^2E(1)=c\,r^2\qquad\text{for every rational }r,
```
using evenness for $r<0$.

:::{dropdown} Lean: Steps 1–2 — integer and rational scaling
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-scaling
:end-before: ANCHOR_END: flow-ke-scaling
```
:::

**Step 3 — all real speeds, by regularity.** The rationals are **dense** in
$\mathbb R$. By the regularity assumption (P6), $E$ is continuous (the measurable
case is discussed in [](#ke-regularity)). The two continuous functions $E(x)$ and
$cx^2$ agree on the dense set $\mathbb Q$ by {eq}`eq-ke-rational`, so they agree
everywhere:
```{math}
:label: eq-ke-final

\boxed{\,E(v)=c\,v^2\,,\qquad c=E(1)>0.}
```

This is the kinetic energy law. The constant $c$ is fixed by a choice of units;
the Newtonian convention $E(v)=\tfrac12 v^2$ corresponds to $c=\tfrac12$.

:::{dropdown} Lean: Step 3 — continuity forces the quadratic, and the converse
The continuous solution agrees with $E(1)\,v^2$ on the dense set $\mathbb Q$, hence everywhere.
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-continuous
:end-before: ANCHOR_END: flow-ke-continuous
```
Conversely, every quadratic $E(v)=c\,v^2$ satisfies the parallelogram law, so the description is
exact.
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-converse
:end-before: ANCHOR_END: flow-ke-converse
```
:::

(ke-why-works)=
## Why the density argument is legitimate here

It is worth contrasting this with the companion note, because the *same-looking*
density step fails there and succeeds here.

| | reachable scalings $\lambda$ with $E(\lambda v)=\lambda^2E(v)$ | in $\log_2$ coordinates | dense in $\mathbb R$? | conclusion |
| --- | --- | --- | --- | --- |
| doubling $E(2v)=4E(v)$ alone | $\{2^n:n\in\mathbb Z\}$ | the integers $\mathbb Z$ | **no** | $1$-periodic factor survives |
| parallelogram law | all rationals $\mathbb Q_{>0}$ | dense | **yes** | $E=cv^2$ |

Iterating the doubling relation can only multiply or divide a speed by $2$, so it
reaches the discrete group $\{2^n\}$; its logarithm is the lattice $\mathbb Z$,
which is not dense, and continuity buys nothing beyond the periodicity already
present. The parallelogram law instead delivers scaling by **every rational**, a
dense set, so continuity legitimately extends {eq}`eq-ke-rational` to all reals.
The extra strength is precisely the boosts $b\neq v$: the doubling relation is the
lone instance $b=v$.

(ke-regularity)=
## The role of regularity

Some regularity (P6) is genuinely needed: without it, {eq}`eq-ke-parallelogram`
has pathological non-measurable solutions built from a Hamel basis of $\mathbb R$
over $\mathbb Q$ (the same mechanism that produces nonlinear solutions of Cauchy's
additive equation). These are physically irrelevant but mathematically real, so
*some* hypothesis must exclude them.

:::{dropdown} Lean: a non-measurable, non-quadratic solution exists
For a non-linear additive $a$ (a Hamel-basis solution of Cauchy's equation), $E(x)=a(x)\,x$ satisfies
the parallelogram law but is not $c x^2$.
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-pathological
:end-before: ANCHOR_END: flow-ke-pathological
```
:::

Continuity is the most transparent choice and is what we used in Step 3. However,
the much weaker assumption of **Lebesgue measurability** already suffices:
measurable solutions of the quadratic functional equation
{eq}`eq-ke-parallelogram` are automatically continuous (a Steinhaus-type argument,
exactly as for the additive Cauchy equation), after which Step 3 applies
unchanged. Physically, measurability is an extremely mild requirement — it merely
says that the heat produced is a measurable function of the impact speed — so the
quadratic law $E(v)=cv^2$ is forced under any reasonable regularity at all.

In the Lean development the measurable case is handled directly through the **polarization**
$\operatorname{pol}(x,y)=\tfrac14\bigl(E(x+y)-E(x-y)\bigr)$, which the parallelogram law makes
symmetric and biadditive. Each slice $x\mapsto\operatorname{pol}(x,y)$ is therefore a measurable
additive map, hence linear (reusing the measurable additive Cauchy theorem from
[the companion C\*-note](cstar_homomorphism.md)); evaluating on the diagonal,
$E(x)=\operatorname{pol}(x,x)=E(1)\,x^2$.

:::{dropdown} Lean: the polarization is symmetric, biadditive, and measurable-linear
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-polar
:end-before: ANCHOR_END: flow-ke-polar
```
:::

:::{dropdown} Lean: measurability forces the quadratic
```{literalinclude} math_notes_lean/MathNotesLean/KineticEnergyGalileanFlow.lean
:language: lean
:start-after: ANCHOR: flow-ke-measurable
:end-before: ANCHOR_END: flow-ke-measurable
```
:::

(ke-remark-inner-product)=
## Remark: the name "parallelogram law"

Equation {eq}`eq-ke-parallelogram` is the classical parallelogram identity
$$
\|x+y\|^2+\|x-y\|^2=2\|x\|^2+2\|y\|^2
$$
with $E(\cdot)=\|\cdot\|^2$. The associated symmetric form
$$
B(x,y):=\tfrac14\bigl(E(x+y)-E(x-y)\bigr)
$$
is **biadditive** — additive in each slot, which the parallelogram law guarantees on its own — and
$E(x)=B(x,x)$, the polarization identity. So the physics says that kinetic energy is a *quadratic
form* in velocity.

There is a subtlety here, and it is the same regularity assumption as before. Biadditivity makes $B$
bilinear only over $\mathbb Q$: $B(qx,y)=q\,B(x,y)$ for *rational* $q$. Concluding $B(x,y)=c\,xy$
(hence $E(v)=cv^2$ in one dimension) needs bilinearity over $\mathbb R$, i.e.
$B(\lambda x,y)=\lambda\,B(x,y)$ for *real* $\lambda$, and upgrading $\mathbb Q$-homogeneity to
$\mathbb R$-homogeneity is exactly the Cauchy/Steinhaus step — it requires the regularity (P6).
Without it there are wild $\mathbb Q$-bilinear forms: the non-measurable solution $E(x)=a(x)\,x$ of
[](#ke-regularity) has polarization $B(x,y)=\tfrac12\bigl(a(x)\,y+a(y)\,x\bigr)$, which is symmetric
and biadditive with $B(x,x)=E(x)$, yet is **not** $c\,xy$. So "every quadratic form is $cv^2$" holds
only for the *measurable* (equivalently, $\mathbb R$-bilinear) ones.

With that regularity in hand, the one-dimensional form is $cv^2$; in three dimensions the same
argument applied componentwise, together with isotropy (P1), gives
$E(\mathbf v)=c\,\lVert\mathbf v\rVert^2$. For a genuine norm the regularity is automatic — a norm is
continuous — and the statement that a norm obeying the parallelogram law comes from an inner product
is the Jordan–von Neumann theorem.

(ke-summary)=
## Summary

- The operational quantity $E(v)$ (kinetic energy, equivalently inelastic-collision
  heat, per unit mass) satisfies the **parallelogram law**
  {eq}`eq-ke-parallelogram`, derived from one symmetric clay-ball collision viewed
  in a continuum of inertial frames (assumptions P1–P5).
- Solved with a mild regularity assumption (P6), the parallelogram law gives
  $E(v)=cv^2$ {eq}`eq-ke-final`.
- The single doubling relation $E(2v)=4E(v)$ is only the $b=v$ slice and is too
  weak on its own; the full quadratic law needs the relations coming from all
  boosts $b$, which together constrain $E$ at a dense set of scales.
