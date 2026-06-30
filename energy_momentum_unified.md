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
($\sinh$ or linear); together they assemble the Galilean pair
$(p,E_{\text{kin}})=(mv,\tfrac12mv^2)$ or the relativistic four-momentum
$P^\mu=(E/c,p)=(\gamma mc,\gamma mv)$.

(ue-fourvector)=
## Four-momentum and the conservation law

The momentum derived above is not an isolated three-vector. In both spacetimes it is the
spatial part of a **four-momentum** $P^\mu=m\,u^\mu$ (mass times four-velocity). The
relativistic time slot is $E/c$; the Galilean time slot is $m$. Thus the Galilean object
is more precisely a **mass-momentum** four-vector, not an energy-momentum four-vector.

This section builds that object in full for both theories and proves a key structural
fact: once the appropriate components are conserved, they assemble into a single
frame-independent conservation law; conversely, frame-independence *couples* the
components, so momentum conservation cannot hold without the time component (mass, or
energy) being conserved too.

### What "four-vector" means here

There are two levels of covariance to keep distinct.

First, in flat spacetime with inertial Cartesian/adapted frames, the admissible inertial
frame changes are the ten continuous symmetries: rotations, translations, boosts, and
time translations (plus optional discrete reflections). These are the Galilei
transformations in Galilean spacetime and the Poincare transformations in Minkowski
spacetime. Checking how $P^\mu$ transforms under these transformations proves that its
components form the correct inertial-frame four-vector.

Second, in the differential-geometric sense, a tensor is a coordinate-independent object
whose components transform tensorially under arbitrary smooth coordinate changes. That
stronger statement is proved not by checking every coordinate system, but by giving a
coordinate-free definition: $u^\mu$ is the tangent to the worldline, and $P^\mu=m u^\mu$
with $m$ a scalar. Then the tensor transformation law follows by the chain rule. The
Galilei and Poincare formulas below are the inertial-coordinate special cases of this
general tensorial statement.

Also, tensorial means **covariant**, not invariant. Components may change from one frame
to another; what matters is that they change by the correct transformation law.

### Definition versus conservation

Two claims must be kept separate.

First, $P^\mu=m u^\mu$ is the **definition** of four-momentum. Since $u^\mu$ is the
worldline tangent and $m$ is a scalar, this also proves that $P^\mu$ is a vector. This is
a kinematic/geometric statement: it determines how $P^\mu$ transforms between frames, but
it does **not** by itself say that $P^\mu$ is conserved.

Second, conservation is an additional **dynamical** statement:
$$
\sum_{\rm in}P^\mu=\sum_{\rm out}P^\mu.
$$
The earlier collision setup supplies or assumes the component conservation laws: in
Galilean mechanics, mass conservation plus momentum conservation; in relativity, energy
conservation plus momentum conservation. Once these components are conserved in one
inertial frame, the vector character of $P^\mu$ packages them into one law and makes that
law frame-independent. Thus $P^\mu=m u^\mu$ proves tensoriality, while the
collision/symmetry argument supplies conservation.

### The four-velocity

Parametrize a particle's worldline by the time natural to each spacetime.

**Relativistic — Minkowski spacetime.** The invariant parameter is the **proper time**
$\tau$, related to coordinate time by $d\tau=dt/\gamma$. The four-velocity is
$$
u^\mu:=\frac{dx^\mu}{d\tau}=\gamma\frac{dx^\mu}{dt}=(\gamma c,\ \gamma\mathbf v),
\qquad \gamma=\frac{1}{\sqrt{1-v^2/c^2}}.
$$
It is a four-vector; under a Lorentz transformation
$u'^\mu=\Lambda^\mu{}_\nu u^\nu$, with constant Minkowski norm
$\eta_{\mu\nu}u^\mu u^\nu=\gamma^2(c^2-v^2)=c^2$.

**Galilean — absolute time.** Time is absolute, so in adapted coordinates the natural
parameter is coordinate time $t$. Equivalently, the Newton-Cartan clock one-form
$\tau_\mu$ normalizes the worldline tangent by $\tau_\mu u^\mu=1$. In such adapted
coordinates the four-velocity is
$$
u^\mu:=\frac{dx^\mu}{dt}=(1,\ \mathbf v).
$$
Under a Galilean boost, including a possible rotation
($\mathbf x'=R\mathbf x-\mathbf b\,t+\mathbf a$, $t'=t+a^0$),
$$
u'^0=u^0,\qquad \mathbf u'=R\mathbf u-\mathbf b\,u^0,
$$
so for $u^0=1$ one has $\mathbf v'=R\mathbf v-\mathbf b$ — precisely the transformation
law of a Galilean four-vector.

### The four-momentum $P^\mu=m\,u^\mu$

Multiply by the rest mass $m$ (a frame-invariant scalar in both theories):

| | four-velocity $u^\mu$ | four-momentum $P^\mu=m\,u^\mu$ |
| --- | --- | --- |
| relativistic | $(\gamma c,\ \gamma\mathbf v)$ | $(\gamma mc,\ \gamma m\mathbf v)=(E/c,\ \mathbf p)$ |
| Galilean | $(1,\ \mathbf v)$ | $(m,\ m\mathbf v)=(m,\ \mathbf p)$ |

The *same* formula $P^\mu=m\,u^\mu$ holds in both. Since $m$ is a scalar and $u^\mu$ is
the worldline tangent, $P^\mu$ is a genuine vector in the generally covariant
formulation. The only difference is what occupies the time slot in adapted inertial
coordinates — $E/c$ (relativistic) or $m$ (Galilean).

For a Galilean boost this gives
$$
P'^0=P^0=m,\qquad \mathbf P'=R\mathbf P-\mathbf b\,P^0
=R\mathbf p-m\mathbf b.
$$
The term $-m\mathbf b$ has the elementary meaning
$m(\mathbf v-\mathbf b)=m\mathbf v-m\mathbf b$: changing to a frame moving with velocity
$\mathbf b$ subtracts the frame's velocity from every particle velocity, and therefore
subtracts $m\mathbf b$ from its momentum. This is why $\mathbf p$ alone is not a
Galilean spacetime vector. It is a three-vector under rotations, but under boosts it is
not closed by itself; it needs the mass component $P^0=m$.

The metric then reads off the "mass-shell":

- **Relativistic**, non-degenerate $\eta_{\mu\nu}=\mathrm{diag}(1,-1,-1,-1)$:
  $$
  \eta_{\mu\nu}P^\mu P^\nu=(E/c)^2-|\mathbf p|^2=m^2c^2
  \quad\Longleftrightarrow\quad E^2=p^2c^2+m^2c^4.
  $$
- **Galilean**, the degenerate pair $\tau_\mu=(1,0,0,0)$ (temporal) and
  $h^{\mu\nu}=\mathrm{diag}(0,1,1,1)$ (spatial), with $\tau_\mu h^{\mu\nu}=0$: the
  temporal one-form reads off the mass,
  $$
  \tau_\mu P^\mu=m,
  $$
  and the spatial part is $\mathbf p$. There is *no* non-degenerate quadratic form in
  $P^\mu$ yielding an energy; instead
  $E=|\mathbf p|^2/(2m)=|\mathbf p|^2/\bigl(2\,\tau_\mu P^\mu\bigr)$, a ratio — the
  algebraic fingerprint of the degenerate metric.

### Conservation, and a one-line proof of frame-independence

For a collision with incoming momenta $P_i^\mu$ and outgoing $P_j^\mu$, **conservation
of four-momentum** is the single statement
```{math}
:label: eq-ue-Pcons

\sum_{\rm in}P^\mu=\sum_{\rm out}P^\mu.
```
Because $P^\mu$ is a four-vector it transforms linearly, $P'^\mu=\Lambda^\mu{}_\nu
P^\nu$, so {eq}`eq-ue-Pcons` holds in *every* inertial frame:
$$
\sum_{\rm in}P'^\mu=\Lambda^\mu{}_\nu\sum_{\rm in}P^\nu
=\Lambda^\mu{}_\nu\sum_{\rm out}P^\nu=\sum_{\rm out}P'^\mu.
$$
Linearity of $\Lambda$ is the whole proof. Reading off components gives the conservation
laws:

- **relativistic:** $\sum_{\rm in}E=\sum_{\rm out}E$ (energy) and
  $\sum_{\rm in}\mathbf p=\sum_{\rm out}\mathbf p$ (momentum);
- **Galilean:** $\sum_{\rm in}m=\sum_{\rm out}m$ (mass) and
  $\sum_{\rm in}\mathbf p=\sum_{\rm out}\mathbf p$ (momentum).

### The components are coupled (the heart of the matter)

The frame-independence proof conceals the key point: a boost *mixes* the time and space
components, so conserving one component alone does **not** survive a change of frame.
The components are locked together. In relativity the mixing is two-way: $E/c$ and
$\mathbf p$ are not separate Lorentz tensors, only components of the four-vector
$P^\mu$. In Galilean spacetime the mixing is triangular: the mass component is invariant,
but the spatial momentum still receives a contribution from it. Thus $\mathbf p$ is a
tensor only for the reduced rotation subgroup, not for the full Galilei group with
boosts.

**Galilean — momentum conservation forces mass conservation.** Assume only that
momentum is conserved in the lab, $\sum_{\rm in}\mathbf p=\sum_{\rm out}\mathbf p$, and
ask whether it holds in a frame boosted by $\mathbf b$. Since $\mathbf p'=\mathbf
p-m\mathbf b$,
$$
\sum_{\rm in}\mathbf p'=\sum_{\rm in}\mathbf p-\mathbf b\!\sum_{\rm in}m,\qquad
\sum_{\rm out}\mathbf p'=\sum_{\rm out}\mathbf p-\mathbf b\!\sum_{\rm out}m.
$$
Subtracting,
$$
\sum_{\rm in}\mathbf p'-\sum_{\rm out}\mathbf p'
=\underbrace{\bigl(\sum_{\rm in}\mathbf p-\sum_{\rm out}\mathbf p\bigr)}_{=\,0\text{ (assumption)}}
\;-\;\mathbf b\bigl(\sum_{\rm in}m-\sum_{\rm out}m\bigr).
$$
For this to vanish for *every* boost $\mathbf b$,
```{math}
:label: eq-ue-masscons

\sum_{\rm in}m=\sum_{\rm out}m.
```
So **frame-independent momentum conservation entails mass conservation**. The two are
inseparable: they are the time and space slots of one four-vector, and the boost couples
them.

**Relativistic — momentum conservation forces energy conservation.** Take a Lorentz
boost of rapidity $\beta$ along $x$,
$$
E'=\gamma_\beta(E-\beta c\,p_x),\qquad
p'_x=\gamma_\beta\!\left(p_x-\frac{\beta}{c}E\right),
$$
and assume only $\sum_{\rm in}p_x=\sum_{\rm out}p_x$. Then
$$
\sum_{\rm in}p'_x-\sum_{\rm out}p'_x
=\gamma_\beta\!\left[\underbrace{\bigl(\sum_{\rm in}p_x-\sum_{\rm out}p_x\bigr)}_{=\,0}
\;-\;\frac{\beta}{c}\bigl(\sum_{\rm in}E-\sum_{\rm out}E\bigr)\right],
$$
which vanishes for every $\beta$ only if $\sum_{\rm in}E=\sum_{\rm out}E$. So in
relativity **frame-independent momentum conservation entails energy conservation**, and
conversely. The invariant $E^2-p^2c^2=m^2c^4$ is the same coupling in static form.

### What this explains, and the Galilean asymmetry

The coupling is exactly what the package demanded and what our derivations produced,
now seen geometrically. In the **Galilean package** the companion axiom was mass
conservation; the four-vector shows it is *forced* on us by frame-independent momentum
conservation — the two come as one. In the **relativistic package** the companion axiom
was total-energy conservation; the four-vector shows it is *forced* by frame-independent
momentum conservation just the same.

The asymmetry, now sharp: the Galilean four-momentum $(m,\mathbf p)$ contains **mass and
momentum**, not energy. Energy conservation in Galilean mechanics is therefore a
*separate* law — outside the four-vector — and (as derived in
[kinetic_energy_galilean.md](kinetic_energy_galilean.md)) it follows from the
frame-invariance of heat, not from four-vector structure. Relativity needs no such extra
law: its four-momentum already carries the energy in the time slot, so the single
statement {eq}`eq-ue-Pcons` covers everything. One conservation law (relativistic)
versus one plus an extra (Galilean) — that is the precise cost of the degenerate metric.

(ue-gravity)=
## Adding gravity: from inertial forces to curvature

The derivation so far was the flat-spacetime theory. If we write the same theory in
arbitrary coordinates, including accelerating or rotating coordinates, the equations
already contain connection terms. Those terms are **fictitious forces**: they come from a
non-inertial coordinate choice, and the corresponding curvature is still zero. True
gravity begins when the connection has nonzero curvature, so that no coordinate choice
can remove the effect everywhere.

The bottom-up extension to gravity follows the same pattern in the Galilean and
relativistic theories. The common steps are:

1. **Universal free fall.** All test bodies fall the same way, independently of their
   mass and composition.
2. **Geometrize the universal force.** Since the acceleration is universal, it should not
   be a force attached separately to each body. It is encoded in a common spacetime
   connection $\nabla$, and free particles follow geodesics.
3. **Only tidal effects are invariant.** A uniform gravitational field can be removed
   locally by a freely falling frame. Thus the connection coefficients themselves are not
   the invariant gravitational field; curvature is.
4. **Choose the conserved source.** Galilean gravity is sourced by mass density. Relativistic
   gravity is sourced by the full stress-energy tensor.
5. **Locality and second-order simplicity.** The field equation should be local,
   covariant, and second order in the gravitational variables.
6. **Fix the normalization.** The remaining constant is fixed by the observed Newtonian
   weak/static limit; symmetry fixes the form, not the numerical value of $G$.

### Universal free fall gives the geodesic equation

The equivalence principle is the shared starting point:

| | **Galilean / Newton-Cartan** | **Relativistic / GR** |
| --- | --- | --- |
| clock/metric structure | clock one-form $\tau_\mu$ and spatial metric $h^{\mu\nu}$ | Lorentzian metric $g_{\mu\nu}$ |
| normalization | $\tau_\mu u^\mu=1$ | $g_{\mu\nu}u^\mu u^\nu=c^2$ |
| free-fall equation | $u^\nu\nabla_\nu u^\mu=0$ | $u^\nu\nabla_\nu u^\mu=0$ |

So the equation of motion is literally the same tensor equation in both theories:
```{math}
:label: eq-ue-grav-geodesic

\boxed{\,u^\nu\nabla_\nu u^\mu=0\,}.
```
The difference lies in the background geometric structure: Newton-Cartan has absolute
time and a degenerate spatial metric; GR has a non-degenerate Lorentzian metric.

In adapted Newton-Cartan coordinates, $\tau=dt$ and $u^\mu=(1,\dot{\mathbf x})$. For an
ordinary Newtonian potential $\Phi$, the gravitational connection component is
$$
\Gamma^i_{00}=\partial^i\Phi,
$$
so {eq}`eq-ue-grav-geodesic` becomes
$$
\frac{d^2x^i}{dt^2}+\Gamma^i_{00}=0
\qquad\Longleftrightarrow\qquad
\frac{d^2x^i}{dt^2}=-\partial^i\Phi.
$$

In GR, the same geodesic equation in the weak, slowly moving, static limit with
$$
g_{00}=1+\frac{2\Phi}{c^2}
$$
also reduces to
$$
\frac{d^2x^i}{dt^2}=-\partial^i\Phi.
$$
Thus both theories agree on the motion law in the Newtonian limit.

### Curvature is the gravitational field

A freely falling coordinate system can set the connection coefficients to zero at one
event. Therefore $\Gamma^\mu_{\nu\rho}$ itself is not the invariant gravitational field.
The invariant obstruction to removing gravity throughout a region is curvature.

In Newton-Cartan theory, with $\Gamma^i_{00}=\partial^i\Phi$, the tidal tensor is the
second derivative of the potential:
$$
R^i{}_{0j0}=\partial_j\partial^i\Phi,
\qquad
R_{00}=\partial_i\partial^i\Phi=\nabla^2\Phi.
$$
A uniform field has $\partial_i\Phi=\text{constant}$ and hence zero curvature; it is
locally removable by an accelerating frame. Tidal gravity is what remains.

In GR, the same statement is expressed by the Riemann tensor
$R^\mu{}_{\nu\rho\sigma}$. In a local inertial frame the connection can be made to
vanish at a point, but the curvature tensor generally cannot.

### The field equation: curvature sourced by the conserved quantity

The final step is to connect curvature to matter.

**Galilean / Newton-Cartan.** The source selected by the flat theory is mass. Let
$\rho$ be the mass density. Locality, spatial rotational invariance, and second-order
simplicity select the scalar second-derivative equation
$$
\nabla^2\Phi=C\rho.
$$
Writing $C=4\pi G$ gives Poisson's equation,
```{math}
:label: eq-ue-poisson

\boxed{\,\nabla^2\Phi=4\pi G\rho\,}.
```
In Newton-Cartan tensor form this is
```{math}
:label: eq-ue-newton-cartan-field

\boxed{\,R_{\mu\nu}=4\pi G\,\rho\,\tau_\mu\tau_\nu\,}.
```
In adapted coordinates, the only nontrivial component is $R_{00}=4\pi G\rho$, exactly
{eq}`eq-ue-poisson`.

For a point mass, $\rho=M\delta^{(3)}(\mathbf x)$, the rotationally symmetric solution is
$$
\Phi(r)=-\frac{GM}{r},
\qquad
\mathbf a=-\nabla\Phi=-\frac{GM}{r^2}\,\hat{\mathbf r}.
$$
Thus the inverse-square law follows from locality, three-dimensional rotational
symmetry, and the second-order Poisson equation; $G$ is the empirical coupling constant.

**Relativistic / GR.** The source selected by the relativistic flat theory is the full
stress-energy tensor $T_{\mu\nu}$, not just mass density. The left-hand side must be a
symmetric, generally covariant, divergence-free tensor built locally from the metric and
at most two derivatives. In four dimensions, the Lovelock uniqueness theorem gives
$$
G_{\mu\nu}+\Lambda g_{\mu\nu}
$$
as the unique possibility of this type, where
$G_{\mu\nu}:=R_{\mu\nu}-\tfrac12 Rg_{\mu\nu}$ and $\nabla^\mu G_{\mu\nu}=0$ by the
Bianchi identity. Therefore the field equation must be
```{math}
:label: eq-ue-einstein-field

\boxed{\,G_{\mu\nu}+\Lambda g_{\mu\nu}
=\frac{8\pi G}{c^4}\,T_{\mu\nu}\,}.
```
The coefficient is fixed by the weak/static limit: with
$T_{00}\approx\rho c^2$ and $g_{00}=1+2\Phi/c^2$, the $00$ component of
{eq}`eq-ue-einstein-field` reduces to
$$
\nabla^2\Phi=4\pi G\rho.
$$
The cosmological constant $\Lambda$ is allowed by the same covariance and second-order
axioms; it is an additional empirical constant, set to zero if one demands exactly flat
empty spacetime.

The parallel structure is therefore:
$$
\text{universal free fall}
\Rightarrow
\text{connection/geodesics}
\Rightarrow
\text{curvature as gravity}
\Rightarrow
\text{curvature sourced by mass or stress-energy}.
$$

With gravity present, the flat-spacetime global conservation law is also replaced by a
local covariant statement. In GR this is $\nabla_\mu T^{\mu\nu}=0$ for matter (with the
gravitational field included geometrically rather than as a separate local
stress-energy tensor). In Newton-Cartan theory, mass conservation remains the local
continuity equation for the mass current, while momentum balance is expressed using the
Newton-Cartan connection. Global conserved energies or momenta require extra spacetime
symmetries, just as in GR.

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
| four-momentum | $(m,\mathbf p)$, mass-momentum | $(E/c,\mathbf p)$, energy-momentum |
| energy in four-vector? | no; $E=|\mathbf p|^2/(2m)$ is separate | yes; $E$ is the time component |
| free fall with gravity | $u^\nu\nabla_\nu u^\mu=0$, $\tau_\mu u^\mu=1$ | $u^\nu\nabla_\nu u^\mu=0$, $g_{\mu\nu}u^\mu u^\nu=c^2$ |
| gravitational field equation | $R_{\mu\nu}=4\pi G\rho\,\tau_\mu\tau_\nu$ | $G_{\mu\nu}+\Lambda g_{\mu\nu}=8\pi G T_{\mu\nu}/c^4$ |
| rest energy $\mathcal E(0)$ | $0$ (free, shiftable) | $c^2$ (forced) |
| mass in collision | conserved ($M=2m$) | grows ($M=2\gamma m$) |

The common axioms (A1)–(A5) — energy extensive and isotropic, relativity, parity, the
frame-invariant collision balance, regularity — produce one energy equation
{eq}`eq-ue-general` and one momentum equation {eq}`eq-ue-momentum`. The sole
difference is the package: {velocity boost, mass conserved} versus {rapidity boost,
energy conserved}. From this single fork, both $\tfrac12mv^2,\ mv$ and
$(\gamma-1)mc^2,\ \gamma mv$ unfold.
