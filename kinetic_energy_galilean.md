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
- Replacing Galilean boosts by Lorentz boosts turns the parallelogram law into
  **d'Alembert's equation**. Assuming only Lorentz symmetry plus the same collision
  symmetries — and *not* $E=mc^2$ — this yields the Lorentz factor, derives $E=mc^2$
  from the non-relativistic limit, and gives the relativistic
  $E_{\text{kin}}=(\gamma-1)mc^2$; see [](#ke-relativistic).

(ke-relativistic)=
## Relativistic kinetic energy: replacing Galilean by Lorentz boosts

The derivation above used relativity at only one point: "view the *same* collision
from a frame moving at velocity $b$." Special relativity changes that one kinematic
ingredient — boosts compose by adding **rapidity**, not velocity — and *everything
else follows from the same symmetries*. In particular we do **not** assume
mass–energy equivalence, nor that the dissipated heat raises the blob's rest mass;
we assume only the symmetries (Lorentz covariance, energy and momentum conservation,
extensivity, regularity) and **derive** $E=mc^2$, the Lorentz factor, the form of the
relativistic momentum, and the kinetic energy $E_{\text{kin}}=(\gamma-1)mc^2$ from
them.

### One change: boosts add rapidity

Collinear Lorentz boosts do not add velocities; instead the **rapidity**
$\phi:=\operatorname{artanh}(v/c)$ adds. A boost by rapidity $\beta$ sends
$\phi\mapsto\phi-\beta$, exactly as a Galilean boost sent $v\mapsto v-b$. *In
rapidity variables, Lorentz boosts look Galilean.* The only kinematic identity we
need is its definition,
$$
\tanh\phi=\frac{v}{c},
$$
together with the trig consequence $\cosh\phi=1/\sqrt{1-v^2/c^2}$. The total energy
per unit rest mass, $\mathcal E(\phi)$, is an **unknown** function: determining its
form is the whole point of this section.

### Assumptions: only symmetries

- **(P1′)** Energy is a state function, additive over bodies, **extensive in rest
  mass**, and isotropic. A body of rest mass $m$ at rapidity $\phi$ has total energy
  $m\,\mathcal E(\phi)$, with $\mathcal E$ even. The **rest energy per unit mass**
  $\mathcal E(0)$ is a constant of the theory — *not* assumed to equal $c^2$ and
  *not* assumed to vanish. *(As (P1), but the rest value is left unknown.)*
- **(P2′)** **Lorentz relativity.** Inertial frames are related by Lorentz boosts,
  so rapidity is additive, $\phi\mapsto\phi-\beta$. *(The one substantive kinematic
  change — and the only post-Newtonian input.)*
- **(P3′)** **Momentum conservation** (spatial-translation symmetry), as in (P3). In
  the symmetric collision the two incoming momenta cancel by the $v\leftrightarrow -v$
  symmetry of the setup, so the blob is at rest in the lab. We use only this
  cancellation — *not* the explicit form of relativistic momentum, which is itself
  derived in [](#ke-derived-momentum).
- **(P4′)** **Energy conservation** holds in every inertial frame, and energy is
  additive over bodies (time-translation symmetry). *(As (P4).)*
- **(P5′)** **A body at rest is fully characterized by its invariant rest mass $M$,
  a Lorentz scalar** — the same number in every inertial frame. This is the
  pure-symmetry content of "rest mass is Lorentz invariant," and it assumes **no
  part** of mass–energy equivalence. In particular we do *not* assume $M=2m$: unlike
  the Galilean case, where mass conservation forced $M=2m$ as a separate law, here
  $M$ is *determined* by energy conservation — see [](#ke-derived-mass).
- **(P6′)** **Regularity:** $\mathcal E$ is measurable (or continuous). *(As (P6);
  like the parallelogram law, d'Alembert's equation has Hamel-basis pathologies
  without it.)*

So the only post-Newtonian input is **(P2′)**. The other hypotheses are either
symmetries already present in the Galilean derivation ((P1), (P3), (P4), (P6)) or a
direct consequence of Lorentz covariance ((P5′): a body at rest carries a
Lorentz-invariant label). No relativistic *law* — not $E=mc^2$, not the form of $p$,
not the mass increase — is assumed; each is derived below.

### The collision, in rapidity variables

Take the same symmetric collision: two rest-mass-$m$ particles at rapidities $+\phi$
and $-\phi$ (velocities $\pm v$). By momentum conservation and the symmetry of the
setup (P3′) they form a blob **at rest** (rapidity $0$). Let $M$ be the blob's
invariant rest mass (P5′); it is *not* assumed to equal $2m$.

**Lab frame.** Energy conservation (P4′) with extensivity (P1′): the incoming
particles contribute $m\,\mathcal E(\phi)+m\,\mathcal E(-\phi)=2m\,\mathcal E(\phi)$,
and the blob at rest contributes $M\,\mathcal E(0)$. Hence
```{math}
:label: eq-ke-M-lab

M\,\mathcal E(0)=2m\,\mathcal E(\phi),
\qquad\text{i.e.}\qquad
M=\frac{2m\,\mathcal E(\phi)}{\mathcal E(0)}.
```
We take the non-degenerate case $\mathcal E(0)\ne 0$: if $\mathcal E(0)=0$ then the
balance forces $\mathcal E(\phi)=0$ for every collision, i.e. $\mathcal E\equiv0$,
the trivial theory (the Galilean limit, where mass conservation is decoupled, is
recovered separately in [](#ke-nr-limit)).

*This is the decisive difference from the Galilean case.* There $\mathcal E(0)=0$, so
the blob's rest energy $M\,\mathcal E(0)$ vanished and the balance above reduced to
$0=0$ — it said nothing about $M$, and a separate mass-conservation law had to be
adjoined to force $M=2m$. Here $\mathcal E(0)\ne0$, so energy conservation **fixes**
$M$ on its own, and mass is not separately conserved.

**Boosted frame.** Now view the collision from a frame boosted by rapidity $\beta$.
By (P2′) rapidities add: particle A has rapidity $\phi-\beta$, particle B has
$-\phi-\beta$, and the blob has $-\beta$. The blob's invariant mass is still $M$
((P5′), a Lorentz scalar). Energy conservation (P4′) in this frame reads
$$
m\,\mathcal E(\phi-\beta)+m\,\mathcal E(-\phi-\beta)=M\,\mathcal E(-\beta).
$$
Substituting $M=2m\,\mathcal E(\phi)/\mathcal E(0)$ and using that $\mathcal E$ is
even ($\mathcal E(-\phi-\beta)=\mathcal E(\phi+\beta)$, $\mathcal E(-\beta)=\mathcal
E(\beta)$) gives the central identity.

:::{tip} d'Alembert's equation
For all real rapidities $\phi$ and boosts $\beta$,
```{math}
:label: eq-ke-dalembert

\boxed{\,\mathcal E(\phi+\beta)+\mathcal E(\phi-\beta)
=\frac{2}{\mathcal E(0)}\,\mathcal E(\phi)\,\mathcal E(\beta)\,.}
```
Equivalently, for the **energy ratio** $\gamma_{\mathcal E}(\phi):=\mathcal
E(\phi)/\mathcal E(0)$ with $\gamma_{\mathcal E}(0)=1$,
```{math}
:label: eq-ke-dalembert-gamma

\gamma_{\mathcal E}(\phi+\beta)+\gamma_{\mathcal E}(\phi-\beta)
=2\,\gamma_{\mathcal E}(\phi)\,\gamma_{\mathcal E}(\beta).
```
:::

This is the multiplicative cousin of the parallelogram law: the additive right-hand
side $2\mathcal E(\phi)+2\mathcal E(\beta)$ has become the **product**
$\tfrac{2}{\mathcal E(0)}\mathcal E(\phi)\mathcal E(\beta)$, precisely because the
conserved blob on the right is itself labeled by its rest energy $M\,\mathcal E(0)$,
and energy conservation ties $M$ to the collision energy. Note the constant is
$2/\mathcal E(0)$ — with the **unknown** rest energy per unit mass $\mathcal E(0)$,
*not* $2/c^2$. We have not assumed $E=mc^2$; $\mathcal E(0)$ is determined in
[](#ke-nr-limit).

(ke-solving-dalembert)=
### Solving d'Alembert's equation

The measurable (equivalently, continuous) solutions of {eq}`eq-ke-dalembert-gamma`
with $\gamma_{\mathcal E}(0)=1$ are
$$
\gamma_{\mathcal E}(\phi)=\cosh(a\phi),\qquad
\gamma_{\mathcal E}(\phi)=\cos(a\phi),\qquad\text{or}\qquad
\gamma_{\mathcal E}\equiv 1,
$$
for a constant $a$. (Without regularity there are again Hamel-basis pathologies.)
The physics selects one branch: energy is minimized at rest and grows with speed, so
$\gamma_{\mathcal E}\ge 1$ and increases with $|\phi|$, which rules out
$\cos(a\phi)$ — it dips below $1$ — and the constant. Hence
$\gamma_{\mathcal E}(\phi)=\cosh(a\phi)$, i.e.
```{math}
:label: eq-ke-Eform

\mathcal E(\phi)=\mathcal E(0)\cosh(a\phi).
```
The constant $a$ sets the scale of rapidity; it is pinned to $a=1$ by the
non-relativistic limit below (matching $E_{\text{kin}}\to\tfrac12 mv^2$), exactly as
the free constant in the Galilean law $E=cv^2$ was fixed by the Newtonian unit
convention. Thus $\mathcal E(\phi)=\mathcal E(0)\cosh\phi$, and — using
$\cosh(\operatorname{artanh}(v/c))=1/\sqrt{1-v^2/c^2}$ — as a function of velocity
$$
\mathcal E(v)=\frac{\mathcal E(0)}{\sqrt{1-v^2/c^2}}.
$$

(ke-nr-limit)=
### Deriving $E=mc^2$: the non-relativistic limit

Up to the single constant $\mathcal E(0)$ — the rest energy per unit mass — the
energy function is now fixed. **This constant is not a convention:** in a
Lorentz-covariant theory the rest energy is a genuine physical quantity (energy is
the time component of the energy–momentum and cannot be shifted by an additive
constant without breaking covariance), unlike in the Galilean theory where it was set
to zero. It is fixed by requiring the theory to reduce to the Galilean one at small
speeds.

Expanding {eq}`eq-ke-Eform` at small rapidity, $\phi=\operatorname{artanh}(v/c)\to
v/c$,
$$
\mathcal E(\phi)=\mathcal E(0)\cosh\phi
=\mathcal E(0)+\tfrac12\mathcal E(0)\phi^2+O(\phi^4),
$$
so the kinetic energy per unit mass is
$$
\mathcal E(\phi)-\mathcal E(0)=\frac{\mathcal E(0)}{2c^2}\,v^2+O(v^4).
$$
The first half of this note showed the Galilean kinetic energy per unit mass is
$\tfrac12 v^2$. Matching the leading term forces
```{math}
:label: eq-ke-rest-energy

\boxed{\;\mathcal E(0)=c^2.\;}
```
So **the rest energy is $mc^2$** — mass–energy equivalence — is a *theorem*: the
output of the low-velocity limit, not an assumption. With $\mathcal E(0)=c^2$, the
energy ratio $\gamma_{\mathcal E}=\mathcal E/c^2$ becomes the usual Lorentz factor
$\gamma=1/\sqrt{1-v^2/c^2}=\cosh\phi$ (henceforth we drop the subscript), and
```{math}
:label: eq-ke-gamma

\mathcal E(v)=\frac{c^2}{\sqrt{1-v^2/c^2}}=\gamma\,c^2,
```
so the total and kinetic energies of a body of rest mass $m$ are
```{math}
:label: eq-ke-rel-kinetic

E=\gamma\,mc^2,\qquad
\boxed{\,E_{\text{kin}}=(\gamma-1)\,mc^2\,.}
```

### The non-relativistic limit recovers the parallelogram law

Write $\mathcal E=c^2+\varepsilon$, with $\varepsilon$ the kinetic energy per unit
mass. Substituting into {eq}`eq-ke-dalembert` (now with $\mathcal E(0)=c^2$) and
cancelling the common $2c^2$,
$$
\varepsilon(\phi+\beta)+\varepsilon(\phi-\beta)
=2\varepsilon(\phi)+2\varepsilon(\beta)+\frac{2}{c^2}\,\varepsilon(\phi)\,\varepsilon(\beta).
$$
As $c\to\infty$ the last term vanishes and $\phi\to v/c$ becomes proportional to $v$,
so $\varepsilon$ — as a function of the rescaled velocity — satisfies the
**parallelogram law** {eq}`eq-ke-parallelogram` of the previous sections, returning
the quadratic $\varepsilon\propto v^2$. Quantitatively,
$\varepsilon=c^2(\cosh\phi-1)\approx\tfrac12v^2$; matching the Newtonian value is
exactly what fixed $\mathcal E(0)=c^2$ (and $a=1$) above. The relativistic d'Alembert
law contains the Galilean parallelogram law as its $c\to\infty$ shadow.

(ke-derived-mass)=
### Derived corollary: the heat has mass

The blob's invariant mass was *not* assumed — it was fixed by the lab-frame balance
{eq}`eq-ke-M-lab`. Substituting $\mathcal E(\phi)=c^2\cosh\phi=c^2\gamma$ and
$\mathcal E(0)=c^2$,
$$
M=\frac{2m\,\mathcal E(\phi)}{\mathcal E(0)}=2m\cosh\phi=2\gamma\,m.
$$
So the rest mass *grows* in the collision, by
$$
M-2m=2(\gamma-1)m=\frac{2(\gamma-1)mc^2}{c^2}=\frac{Q}{c^2},
$$
where $Q=2(\gamma-1)mc^2$ is exactly the kinetic energy lost — the heat. **The
"frame-invariant heat" of the Galilean derivation is, relativistically, the increase
in invariant rest mass**, and $Q=\Delta M\,c^2$ is a direct consequence of
$\mathcal E(0)=c^2$, not an additional hypothesis. That is why the conserved object
on the right of {eq}`eq-ke-dalembert` is multiplicative rather than additive.

(ke-derived-momentum)=
### Remark: the form of relativistic momentum is also derived

We never assumed the relativistic momentum $p=m\gamma v$ — only momentum conservation
(P3′), used through the cancellation that brings the blob to rest. The form itself
follows once $E=mc^2$ is known. Energy and momentum are the time and space
components of the **energy–momentum** $P^\mu$, the conserved Noether charge of
spacetime translations; Lorentz covariance makes $P^\mu$ a 4-vector, so boosting the
rest-frame value $P^\mu=(mc,0)$ by rapidity $\phi$ gives
$$
P^\mu=(mc\cosh\phi,\;mc\sinh\phi)=(m\gamma c,\;m\gamma v),
$$
hence $p=m\gamma v$ and the invariant $E^2-(pc)^2=(mc^2)^2$. These are consequences
of Lorentz symmetry plus the derived $E=mc^2$, not extra assumptions.

### Why mass–energy equivalence is a relativistic phenomenon

The Galilean and relativistic regimes differ at exactly one point: the value of the
rest energy $\mathcal E(0)$.

- **Galilean:** $\mathcal E(0)=0$. The blob's rest energy $M\,\mathcal E(0)$ vanishes,
  the balance $M\,\mathcal E(0)=2m\,\mathcal E(\phi)$ collapses to $0=0$, and energy
  conservation says nothing about $M$. A separate law — mass conservation — must be
  adjoined, giving $M=2m$. Passing to the additive variable $\varepsilon$ first turns
  the multiplicative d'Alembert equation into the additive parallelogram law.
- **Relativistic:** $\mathcal E(0)=c^2\ne0$. Energy conservation alone fixes
  $M=2\gamma m>2m$; no separate mass law is needed (or possible — mass is not
  conserved), and the multiplicative d'Alembert equation holds as is.

So $E=mc^2$ is precisely the statement "$\mathcal E(0)\ne0$": rest energy is a nonzero
physical scale, energy conservation alone accounts for the mass of composite bodies,
and the entire relativistic energy structure follows from Lorentz symmetry plus this
one derived constant.
