# The Relativistic Free-Particle Lagrangian

This note derives the Lagrangian of a free relativistic particle,
$$
L = -\frac{mc^2}{\gamma} = -mc^2\sqrt{1-\frac{v^2}{c^2}},
\qquad \gamma=\frac{1}{\sqrt{1-v^2/c^2}},
$$
from two independent directions. **Route 1** consumes the relativistic energy and
momentum derived in [the kinetic-energy note](kinetic_energy_galilean.md) and
recovers $L$ by a Legendre transform — a consistency check showing that those
quantities are compatible with a *unique* Lagrangian. **Route 2** ignores the
collision results and derives $L$ straight from Lorentz symmetry (the action must be
a Lorentz scalar), then re-derives $p$ and $E$ from $L$ as its own check.

Both routes require adjoining one postulate that the collision analysis never used —
the **action principle** — and with it the relativistic free-particle Lagrangian is
fixed with no free constants.

:::{note} Prerequisites
This note builds on [the relativistic section of the kinetic-energy note](kinetic_energy_galilean.md),
which derives — from Lorentz symmetry plus collision symmetries, and *without*
assuming $E=mc^2$ — the total energy, kinetic energy, and momentum of a free
particle:
$$
E = \gamma\, m c^2, \qquad E_{\text{kin}} = (\gamma-1)\,m c^2, \qquad p = \gamma\, m v,
$$
with $\gamma = 1/\sqrt{1-v^2/c^2} = \cosh\phi$ and rest energy $mc^2$. We re-use
these as inputs to Route 1. The single new ingredient of the present note is the
action principle stated in [](#rl-action-principle).
:::

(rl-action-principle)=
## The action principle: the one new postulate

The collision derivation obtained $E$ and $p$ from symmetries alone — no equation of
motion, no action. To speak of a Lagrangian we adjoin **Hamilton's principle**:

- A particle's trajectory extremizes the **action**
  $$
  S = \int_{t_1}^{t_2} L(\mathbf x, \mathbf v, t)\,dt, \qquad \mathbf v = \dot{\mathbf x}.
  $$
- The **canonical momentum** and **Hamiltonian** are, in one spatial dimension,
  ```{math}
  :label: eq-rl-canon

  p = \frac{\partial L}{\partial v}, \qquad H = p\,v - L.
  ```
  (In three dimensions $p_i = \partial L/\partial v_i$ and $H = \mathbf p\cdot\mathbf v - L$.)

For a free particle $L$ has no explicit time dependence, so $H$ is conserved and
equals the total energy $E$; and $L$ depends on $\mathbf v$ only through $v^2$
(isotropy, the relativistic analog of (P1)), so the canonical momentum coincides with
the mechanical momentum $\mathbf p=\gamma m\mathbf v$. Under these identifications,
{eq}`eq-rl-canon` is the bridge between the Lagrangian and the dynamical quantities
($p$, $E$) already derived. Two routes now pin down $L$.

(rl-route1)=
## Route 1: the Legendre transform (from the derived $p$ and $E$)

This is the direct route: take the collision-derived $p(v)$ and $E(v)$ and invert
{eq}`eq-rl-canon`.

:::{tip} Result
```{math}
:label: eq-rl-lagrangian

\boxed{\,L = -\frac{mc^2}{\gamma} = -mc^2\sqrt{1-\frac{v^2}{c^2}}\,.}
```
:::

**From energy.** Since $E = H = p v - L$, we have $L = p v - E$. Substituting
$p = \gamma m v$ and $E = \gamma m c^2$,
$$
L = (\gamma m v)\,v - \gamma m c^2 = \gamma m (v^2 - c^2) = -\gamma m (c^2 - v^2).
$$
Now use
$$
\gamma\,(c^2 - v^2)
= \frac{c^2 - v^2}{\sqrt{1-v^2/c^2}}
= \frac{c^2(1-v^2/c^2)}{\sqrt{1-v^2/c^2}}
= c^2\sqrt{1-v^2/c^2}
= \frac{c^2}{\gamma},
$$
so $L = -m\cdot c^2/\gamma$, which is {eq}`eq-rl-lagrangian`.

**From momentum.** Equivalently, integrate $p = \partial L/\partial v$:
```{math}
:label: eq-rl-integrate

L(v) = \int p(v)\,dv = \int \frac{m v}{\sqrt{1-v^2/c^2}}\,dv.
```
With the substitution $u = 1 - v^2/c^2$, $du = -2v\,dv/c^2$, the integral is
$$
\int \frac{m v}{\sqrt{u}}\cdot\frac{-c^2}{2}\,\frac{du}{v}
= -\frac{m c^2}{2}\int u^{-1/2}\,du
= -m c^2\sqrt{u}
= -m c^2\sqrt{1-v^2/c^2}.
$$
Hence
$$
L(v) = -m c^2\sqrt{1-v^2/c^2} + C
$$
for an integration constant $C$. It is fixed by the derived rest energy: at $v=0$,
$p(0)=0$ and $L(0) = -mc^2 + C$, so
$$
E(0) = H(0) = p(0)\cdot 0 - L(0) = mc^2 - C.
$$
The kinetic-energy note derived $E(0) = mc^2$ (the rest energy, output of the
non-relativistic limit), so $C = 0$. Thus $L = -mc^2/\gamma$.

:::{note} What Route 1 shows, and what it does not
Route 1 is a **compatibility and uniqueness** check: the derived $p$ and $E$ fit a
single Lagrangian, and that Lagrangian has no free constant (the constant is pinned
by the rest energy, which covariance makes non-shiftable — see [](#rl-constants)). It
does *not* explain *why* $L$ has this particular form. That explanation is Route 2.
:::

(rl-route2)=
## Route 2: Lorentz invariance of the action (symmetry-first)

The deeper derivation uses only Lorentz symmetry, not the collision results. It has
three steps.

### Step 1 — the action is a Lorentz scalar

The equations of motion are Lorentz-covariant, and the action generates them via
$\delta S = 0$. For the variational principle to be frame-independent, $S$ itself
must be a **Lorentz scalar** — a number unchanged by boosts. (Any non-scalar part of
$S$ would single out a preferred frame and break the symmetry.)

### Step 2 — the only worldline invariant is the proper time

Along a particle's worldline the Lorentz-invariant line element is
$$
ds^2 = c^2\,dt^2 - d\mathbf x^{\,2} = c^2\,dt^2\,(1 - v^2/c^2),
$$
so the invariant **proper time** is
```{math}
:label: eq-rl-proper-time

d\tau = \frac{ds}{c} = dt\sqrt{1-v^2/c^2} = \frac{dt}{\gamma}.
```
Any Lorentz-scalar functional of the worldline alone is built from $\int d\tau$. For
a free particle — no external fields, no internal structure — the action must be
*linear* in this invariant, with a coefficient proportional to the particle's only
attribute, its rest mass $m$:
```{math}
:label: eq-rl-S-ansatz

S = \alpha\, m \int d\tau
```
for a constant $\alpha$ with dimensions $[\text{energy}]/[\text{mass}]=(\text{velocity})^2$.
The only relativistic velocity scale is $c$, so $\alpha = k\,c^2$ for a dimensionless
$k$.

:::{note} Why linear in $m$ and in $\int d\tau$?
**Linearity in $m$ is extensivity**: two identical non-interacting particles carry
twice the action of one (the action is additive over independent degrees of freedom),
so $S\propto m$. **Linearity in $\int d\tau$** is the demand that the action be a
*single* invariant of the worldline: a free particle has no further scale or
structure to generate higher powers, and any such power would introduce an arbitrary
dimensionful coupling with no symmetry justification. Thus $S=\alpha\,m\int d\tau$ is
the unique Lorentz-invariant, extensive free-particle action.
:::

### Step 3 — fix the prefactor from the non-relativistic limit

Since $d\tau = dt/\gamma$, the Lagrangian is
$$
L = \alpha\,m\,\frac{1}{\gamma} = k\,m c^2\sqrt{1-v^2/c^2}.
$$
Expanding at small speed,
$$
L = k\,m c^2\Bigl(1 - \tfrac12\frac{v^2}{c^2} - \cdots\Bigr)
= k\,m c^2 - \tfrac{k}{2}\,m v^2 + O(v^4/c^2).
$$
For this to reproduce the Newtonian free-particle Lagrangian $L_{\text{Newt}}=\tfrac12 m v^2$,
the coefficient of $m v^2$ must be $+\tfrac12$, i.e. $-k/2 = 1/2$, so
```{math}
:label: eq-rl-prefactor

k = -1, \qquad \alpha = -c^2.
```
Both the factor $c^2$ and the minus sign are *forced*; nothing is put in by hand.
Therefore
$$
L = -\,\frac{m c^2}{\gamma} = -m c^2\sqrt{1-v^2/c^2},
$$
in agreement with Route 1, {eq}`eq-rl-lagrangian`. Equivalently, the action is the
proper time weighted by rest energy,
```{math}
:label: eq-rl-S-final

S = -m c^2\int d\tau.
```

(rl-close-loop)=
### Closing the loop: $L \;\longrightarrow\; p,\,E$

Route 2 never used the collision results, so it must re-derive them. From
$L = -m c^2(1-v^2/c^2)^{1/2}$,
```{math}
:label: eq-rl-p-from-L

p = \frac{\partial L}{\partial v}
= -m c^2\cdot\frac{1}{2}(1-v^2/c^2)^{-1/2}\cdot\Bigl(-\frac{2v}{c^2}\Bigr)
= \frac{m v}{\sqrt{1-v^2/c^2}} = \gamma\,m v,
```
and
```{math}
:label: eq-rl-E-from-L

E = p v - L = \gamma m v^2 + \frac{m c^2}{\gamma}
= \frac{m\,\bigl(v^2 + c^2(1-v^2/c^2)\bigr)}{\sqrt{1-v^2/c^2}}
= \frac{m c^2}{\sqrt{1-v^2/c^2}} = \gamma\,m c^2.
```
These are exactly the energy and momentum derived from collisions in [the kinetic-energy
note](kinetic_energy_galilean.md). The two routes — symmetry-first (Route 2) and
collision-first (Route 1) — meet here, each confirming the other.

(rl-checks)=
## Checks

**Non-relativistic limit.** Expanding {eq}`eq-rl-lagrangian`,
```{math}
:label: eq-rl-nr-expand

L = -m c^2\sqrt{1-v^2/c^2}
= -m c^2 + \tfrac12 m v^2 + \tfrac18\frac{m v^4}{c^2} + \tfrac{1}{16}\frac{m v^6}{c^4} + \cdots.
```
The leading dynamical term $\tfrac12 m v^2$ is the Newtonian free-particle Lagrangian;
the additive constant $-m c^2$ is a total time derivative and drops out of the
Euler–Lagrange equations; and $\tfrac18\,m v^4/c^2$ is the first post-Newtonian
correction. The expansion matches that of $E_{\text{kin}}=(\gamma-1)mc^2$, as it must,
since both come from the same $\gamma$.

**Equation of motion.** For a free particle $\partial L/\partial \mathbf x = 0$, so the
Euler–Lagrange equation gives $d(\gamma m\mathbf v)/dt = 0$: momentum is conserved and
the particle moves inertially.

**Hamiltonian.** $H = \mathbf p\cdot\mathbf v - L = \gamma m v^2 + m c^2/\gamma = \gamma m c^2 = E$,
the total energy (including rest energy), conserved because $L$ has no explicit time
dependence.

**Energy–momentum relation.** From the recovered $p$ and $E$,
$$
E^2 - (pc)^2 = (\gamma m c^2)^2 - (\gamma m v c)^2
= \gamma^2 m^2 c^4\,(1-v^2/c^2) = m^2 c^4 = (m c^2)^2.
$$

(rl-constants)=
## The additive constant and covariance

In non-relativistic mechanics one may add a constant to $L$ freely: it changes the
Lagrangian by a total time derivative and leaves the equations of motion untouched.
Why, then, can we not replace $L \to L + C$ here?

Because of covariance. The Hamiltonian shifts as $H \to H - C$ when $L \to L + C$, and
$H = E$ is the time component of the energy–momentum 4-vector, which mixes with
momentum under boosts. A constant shift $-C$ would *not* transform as a component of
a 4-vector (it would be a frame-independent additive constant in $E$), breaking
Lorentz symmetry. Hence $C$ is fixed, not free: requiring $E$ to be the time
component of a 4-vector — equivalently, requiring $S$ to be the Lorentz scalar
$-mc^2\int d\tau$ — sets $C=0$ and pins the rest energy to exactly $mc^2$.

This is the Lagrangian-side echo of the point made in [the kinetic-energy note](kinetic_energy_galilean.md):
the rest energy $\mathcal E(0)=c^2$ is a genuine physical scale, not a convention,
precisely because Lorentz covariance forbids shifting it. The collision derivation
derives that fact from the functional equation; the Lagrangian derivation respects it
through the invariance of the action.

(rl-generalization)=
## Remarks: dimensions, interactions, massless particles

**Three dimensions.** Replace $v^2$ by $\lVert\mathbf v\rVert^2$ throughout:
$$
L = -m c^2\sqrt{1-\lVert\mathbf v\rVert^2/c^2}, \qquad
\mathbf p = \frac{\partial L}{\partial\mathbf v} = \gamma m\,\mathbf v,
\qquad \gamma = \frac{1}{\sqrt{1-\lVert\mathbf v\rVert^2/c^2}}.
$$
Isotropy guarantees $L$ depends on $\mathbf v$ only through its magnitude, so the
one-dimensional derivation carries over unchanged.

**Interactions.** The free Lagrangian is the building block: external fields couple by
adding terms rather than modifying $-mc^2/\gamma$. For electromagnetism (minimal
coupling),
$$
L = -\frac{m c^2}{\gamma} - q\,\phi + q\,\mathbf v\cdot\mathbf A,
$$
with $(\phi,\mathbf A)$ the scalar and vector potentials. This separability — free
part plus interaction — is a feature of the Lagrangian formulation that the pure
collision/symmetry analysis does not by itself provide; it is an additional principle
(local coupling to fields).

**Massless particles.** For $m=0$ the action $-mc^2\int d\tau$ vanishes, and a
massless particle's worldline has $d\tau=0$ (it travels at $v=c$), so this Lagrangian
does not apply. Massless particles are described by an action extremized over an
arbitrary affine parameter, e.g. $S\propto\int g_{\mu\nu}\dot x^\mu\dot x^\nu\,d\lambda$,
a separate construction outside the scope of this note.

(rl-summary)=
## Summary

| | Route 1: Legendre transform | Route 2: Lorentz-invariant action |
| --- | --- | --- |
| input | derived $p=\gamma m v$, $E=\gamma m c^2$ | Lorentz symmetry + action principle |
| key step | $L = p v - E$ | $S$ scalar $\Rightarrow$ $S\propto\int d\tau$ |
| prefactor fixed by | rest energy $mc^2$ (covariance) | non-relativistic limit ($k=-1$) |
| output | $L=-mc^2/\gamma$ | $L=-mc^2/\gamma$, then $p,E$ recovered |

Both routes give
$$
\boxed{\,L = -\frac{m c^2}{\gamma} = -m c^2\sqrt{1-v^2/c^2}\,,}
$$
and each confirms the other. Route 1 shows that the collision-derived $p$ and $E$ are
compatible with a unique Lagrangian (no free constant); Route 2 shows that same
Lagrangian is *forced* by Lorentz invariance of the action, and it reproduces $p$ and
$E$ without using the collision. The single postulate added beyond the kinetic-energy
note is the action principle; given it, the relativistic free-particle Lagrangian is
determined with no freedom.
