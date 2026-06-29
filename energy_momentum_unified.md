# Energy and Momentum from Symmetry: a Unified Derivation

This note derives the kinetic energy and momentum of a free particle in *both*
Galilean and special relativity from a single common axiom set. The two theories are
two specializations of **one functional equation**; the only difference is a small
"package" — the boost (velocity vs rapidity) together with one companion axiom (mass
conserved vs total energy conserved). Everything else is identical.

The detailed case-by-case derivations live in
[kinetic_energy_galilean.md](kinetic_energy_galilean.md); this note's role is to
exhibit their common root.

:::{note} The punchline
One collision, one balance law, one functional equation,
```{math}
:label: eq-ue-energy

\mathcal E(\xi+\beta)+\mathcal E(\xi-\beta)=2\,\mathcal E(\xi)+\frac{M}{m}\bigl[\mathcal E(\beta)-\mathcal E(0)\bigr],
```
contains both theories. The **Galilean package** ($M=2m$, velocity boosts) reduces it
to the parallelogram law $\Rightarrow$ $E_{\text{kin}}=\tfrac12mv^2$, $p=mv$; the
**relativistic package** ($M$ free, total energy conserved, rapidity boosts) reduces
it to d'Alembert's equation $\Rightarrow$ $E_{\text{kin}}=(\gamma-1)mc^2$,
$p=\gamma mv$.
:::

## The common axioms

Both theories share, verbatim:

- **(A1) Energy is a state function of a velocity variable $\xi$, extensive in mass,
  isotropic.** A body of mass $m$ at "velocity-state" $\xi$ has energy
  $m\,\mathcal E(\xi)$, with $\mathcal E$ even: $\mathcal E(-\xi)=\mathcal E(\xi)$.
  (The variable $\xi$ is velocity $v$ for Galilean, rapidity $\phi$ for relativity —
  see the packages.)
- **(A2) Relativity principle.** The laws are the same in every inertial frame;
  frames are related by boosts.
- **(A3) Parity.** The symmetric collision — two equal masses approaching at
  $\pm\xi$ — leaves the blob at rest. (The setup is invariant under $\xi\mapsto-\xi$,
  so the blob cannot move either way.)
- **(A4) Collision balance with frame-invariant bookkeeping.** In an inelastic
  collision,
  $$
  \sum_i m_i\,\mathcal E(\xi_i)=M\,\mathcal E(0)+Q,
  $$
  where $M$ is the blob's mass and $Q\ge0$ the dissipated energy. **Both $M$ and $Q$
  are frame-invariant scalars** (the same number in every inertial frame).
- **(A5) Regularity.** $\mathcal E$ is Lebesgue measurable.

Axiom (A4) is the heart: it says the collision's two bookkeeping quantities — the mass
$M$ and the dissipation $Q$ — are each frame-invariant. What distinguishes the two
theories is *which of them is independently fixed*.

## The package: the only difference

Each theory selects a boost and fixes one of the two frame-invariant scalars in (A4):

| | **Galilean package** | **Relativistic package** |
| --- | --- | --- |
| boost | velocities add: $\xi=v$, $u\mapsto u-b$ | rapidities add: $\xi=\phi=\operatorname{artanh}(v/c)$, $\phi\mapsto\phi-\beta$ |
| fixed scalar | **mass conserved**: $M=\sum_i m_i$ | **total energy conserved**: $Q=0$ |
| free scalar | $Q$ (the heat) | $M$ (the blob's rest mass — it grows) |

The two rows are not independent choices: they come locked as a pair
(see [](#ue-locked)). Picking the Galilean boost *forces* mass conservation for a
sensible theory; picking the Lorentz boost *forces* total-energy conservation.

## The single functional equation

Derive {eq}`eq-ue-energy`. Take the symmetric collision: two masses $m$ at $\pm\xi$,
blob at rest (A3) of mass $M$. The lab-frame balance (A4) is
```{math}
:label: eq-ue-lab

2m\,\mathcal E(\xi)=M\,\mathcal E(0)+Q.
```
View it from a frame boosted by $\beta$ (A2). The particles move to $\xi-\beta$ and
$-\xi-\beta$; the blob, still of mass $M$ (frame-invariant, A4), moves to $-\beta$.
The balance there is
```{math}
:label: eq-ue-boosted

m\,\mathcal E(\xi-\beta)+m\,\mathcal E(-\xi-\beta)=M\,\mathcal E(\beta)+Q.
```
(The blob's energy is $M\mathcal E(\beta)$ by evenness; the dissipation $Q$ is the
*same* number, frame-invariant by A4.) Subtract {eq}`eq-ue-lab` from
{eq}`eq-ue-boosted` and use evenness:
```{math}
:label: eq-ue-general

\boxed{\,\mathcal E(\xi+\beta)+\mathcal E(\xi-\beta)=2\,\mathcal E(\xi)+\frac{M}{m}\bigl[\mathcal E(\beta)-\mathcal E(0)\bigr]\,.}
```
This is the entire theory before the package is chosen. Now specialize.

### Galilean specialization

$M=2m$ (mass conserved), $\xi=v$. Then $M/m=2$ and {eq}`eq-ue-general` becomes
$$
\mathcal E(v+b)+\mathcal E(v-b)=2\,\mathcal E(v)+2\bigl[\mathcal E(b)-\mathcal E(0)\bigr].
$$
Writing the kinetic energy $T(v):=\mathcal E(v)-\mathcal E(0)$ (so $T(0)=0$),
$$
T(v+b)+T(v-b)=2\,T(v)+2\,T(b),
$$
the **parallelogram law**. With regularity (A5) its solutions are $T(v)=c\,v^2$ (the
Hamel-basis pathologies excluded by measurability). Hence
$$
E_{\text{kin}}=m\,T(v)=c\,m\,v^2.
$$
The constant $c$ is fixed by energy units (Newton's convention $c=\tfrac12$, giving
$\tfrac12mv^2$); the rest energy $\mathcal E(0)$ is a free additive constant — in
Galilean mechanics energy is shiftable, so we conventionally set $\mathcal E(0)=0$.

### Relativistic specialization

$Q=0$ (total energy conserved), so {eq}`eq-ue-lab` fixes
$M=2m\,\mathcal E(\xi)/\mathcal E(0)$, i.e. $M/m=2\,\mathcal E(\xi)/\mathcal E(0)$.
With $\xi=\phi$, {eq}`eq-ue-general` becomes
$$
\mathcal E(\phi+\beta)+\mathcal E(\phi-\beta)=2\,\mathcal E(\phi)+\frac{2\,\mathcal E(\phi)}{\mathcal E(0)}\bigl[\mathcal E(\beta)-\mathcal E(0)\bigr]=\frac{2}{\mathcal E(0)}\,\mathcal E(\phi)\,\mathcal E(\beta),
$$
**d'Alembert's equation**. With regularity and the physical selection (energy
$\ge$ rest, minimized at $\phi=0$), its solution is
$$
\mathcal E(\phi)=\mathcal E(0)\cosh\phi.
$$
The non-relativistic limit fixes the constant:
$E_{\text{kin}}=m[\mathcal E(\phi)-\mathcal E(0)]=m\,\mathcal E(0)(\cosh\phi-1)\approx m\,\mathcal E(0)\,v^2/(2c^2)$,
and matching $\tfrac12mv^2$ forces
$$
\mathcal E(0)=c^2,
\qquad\text{hence}\qquad
\mathcal E=\gamma\,mc^2,\quad E_{\text{kin}}=(\gamma-1)mc^2.
$$
Note the contrast with the Galilean case: here $\mathcal E(0)=c^2$ is *forced*, not a
free constant — Lorentz covariance forbids shifting the rest energy. And the blob's
mass, $M=2m\cosh\phi=2\gamma m$, *grows*: the dissipated kinetic energy became rest
mass, $Q_{\text{rel}}=\Delta M\,c^2$ — itself a derived theorem, not an assumption.

## Momentum, unified

Momentum is derived from the *same* collision by the *same* move (write momentum
balance in the boosted frame), giving a second functional equation that is the exact
companion of {eq}`eq-ue-general`.

Assume momentum is extensive in mass (a body of mass $m$ at $\xi$ carries momentum
$m\,\pi(\xi)$, with $\pi$ odd) and conserved in every frame. The boosted-frame
balance for the symmetric collision reads
$$
m\,\pi(\xi-\beta)+m\,\pi(-\xi-\beta)=M\,\pi(-\beta).
$$
Oddness on both sides gives the unified momentum equation
```{math}
:label: eq-ue-momentum

\boxed{\,\pi(\xi+\beta)-\pi(\xi-\beta)=\frac{M}{m}\,\pi(\beta)\,.}
```

**Galilean** ($M/m=2$, $\xi=v$): $\pi(v+b)-\pi(v-b)=2\pi(b)$. Swapping
$v\leftrightarrow b$ and using oddness yields $\pi(v+b)+\pi(v-b)=2\pi(v)$; adding
gives $\pi(v+b)=\pi(v)+\pi(b)$, **Cauchy's equation**, whose regular solution is
$\pi(v)=v$ (the slope is a free unit convention, set to $1$ so that $p=mv$). Thus
$$
p=m\pi(v)=mv.
$$

**Relativistic** ($M/m=2\cosh\phi$, $\xi=\phi$):
$\pi(\phi+\beta)-\pi(\phi-\beta)=2\cosh\phi\,\pi(\beta)$. Swapping and adding gives
$\pi(\phi+\beta)=\cosh\phi\,\pi(\beta)+\cosh\beta\,\pi(\phi)$, the **$\sinh$ addition
formula**, whose regular solution is $\pi(\phi)=c\sinh\phi$ — here the prefactor is
*forced* to the invariant speed $c$ by the non-relativistic limit $p\to mv$. Thus
$$
p=mc\sinh\phi=\gamma mv.
$$

So the same two equations, {eq}`eq-ue-general` and {eq}`eq-ue-momentum`, produce both
$\{E_{\text{kin}}=\tfrac12mv^2,\ p=mv\}$ and $\{E_{\text{kin}}=(\gamma-1)mc^2,\
p=\gamma mv\}$, distinguished only by the package. The energy equation fixes the
"even" function ($\cosh$ or quadratic) and the momentum equation its "odd" companion
($\sinh$ or linear); together they assemble the Galilean pair $(mv,\tfrac12mv^2)$ or
the relativistic 4-vector $(\gamma mv,\,\gamma mc^2)$.

(ue-limit)=
## The Galilean theory is the $c\to\infty$ limit

The two packages are not parallel alternatives; one is the singular limit of the
other. In the relativistic solution let $c\to\infty$ at fixed $v$. Then rapidity
$\phi=\operatorname{artanh}(v/c)\to v/c\to0$, $\cosh\phi\to 1+v^2/(2c^2)$, and
$$
\mathcal E=c^2\cosh\phi\to c^2+\tfrac12 v^2,\qquad
M=2m\cosh\phi\to 2m,\qquad
p=mc\sinh\phi\to mv.
$$
The rest energy $c^2$ diverges and drops out of the kinetic energy
$E_{\text{kin}}=\mathcal E-c^2\to\tfrac12 v^2$; the blob's mass $M\to2m$ (mass
conservation *re-emerges*); the mass *excess* $\Delta M=2m(\cosh\phi-1)\to mv^2/c^2\to0$
vanishes, while the heat $Q=\Delta M\,c^2\to mv^2$ stays finite. In words: as
$c\to\infty$ the relativistic bookkeeping "$Q$ becomes rest mass" degenerates into the
Galilean bookkeeping "mass is conserved, $Q$ is heat" — the heat is the $c\to\infty$
shadow of the relativistic rest-mass gain. This is why the two packages are locked:
the Galilean one is the singular limit of the relativistic one, not an independent
option.

(ue-locked)=
## Why the packages are locked

One might hope to mix and match — e.g. Lorentz boosts with mass conservation.
Equation {eq}`eq-ue-general` shows this fails: with $M=2m$ (mass conserved) but
$\xi=\phi$ (rapidity), it becomes the parallelogram law *in the rapidity variable*,
$T(\phi+\beta)+T(\phi-\beta)=2T(\phi)+2T(\beta)$, whose solution $T(\phi)\propto\phi^2$
grows only quadratically with rapidity and does *not* match the observed
$\gamma mc^2$. Conversely, Galilean boosts with $Q=0$ (total energy conserved) give
d'Alembert's equation *in the velocity variable*, $T(v)\propto\cosh(v)$, exponential
in speed. Both cross-combinations are mathematically consistent but describe worlds
that are not ours.

So the boost and the bookkeeping are not independent dials: a physically correct
theory requires them matched. Choosing the boost effectively chooses its companion
axiom.

## Summary

| | **Galilean** | **Relativistic** |
| --- | --- | --- |
| boost | $v\mapsto v-b$ | $\phi\mapsto\phi-\beta$ |
| companion axiom | mass conserved ($M=2m$) | total energy conserved ($Q=0$) |
| energy equation | parallelogram law | d'Alembert's equation |
| kinetic energy | $\tfrac12 mv^2$ | $(\gamma-1)mc^2$ |
| momentum equation | Cauchy's equation | $\sinh$ addition formula |
| momentum | $mv$ | $\gamma mv$ |
| rest energy $\mathcal E(0)$ | $0$ (free, shiftable) | $c^2$ (forced) |
| mass in collision | conserved ($M=2m$) | grows ($M=2\gamma m$) |

The common axioms (A1)–(A5) — energy extensive and isotropic, relativity, parity, the
frame-invariant collision balance, regularity — produce one energy equation
{eq}`eq-ue-general` and one momentum equation {eq}`eq-ue-momentum`. The sole
difference is the package: {velocity boost, mass conserved} versus {rapidity boost,
energy conserved}. From this single fork, both $\tfrac12mv^2,\ mv$ and
$(\gamma-1)mc^2,\ \gamma mv$ unfold.
