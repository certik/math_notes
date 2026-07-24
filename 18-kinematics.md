# Free-Particle Dynamics from Spacetime Symmetry

This note compares massive free particles in Galilean and Minkowski spacetime.
The logical order is

$$
\text{inertial-frame symmetry}
\longrightarrow
\text{inertial motion}
\longrightarrow
\text{action principle}
\longrightarrow
\text{Lagrangian and Noether charges}.
$$

Passing to a curved spacetime requires an additional universal-free-fall
postulate and a specified connection. It does not follow from coordinate
covariance alone.

## Scope and assumptions

The result below concerns a structureless massive point particle with no
external fields.

**Physical principles**

1. Inertial frames are related by the Galilei group in the
   non-relativistic theory and by the proper orthochronous Poincare group in
   the relativistic theory.
2. Space and time translations and spatial rotations are physical
   symmetries.
3. The law of motion has the same form in every inertial frame.

**Mathematical assumptions**

1. The worldline is twice differentiable.
2. The law is local and second order: acceleration at an event depends only
   on the event and the velocity there. It has no dependence on higher
   derivatives, internal variables, or hidden background fields.
3. In the relativistic case the worldline is timelike and is parametrized by
   proper time.

These assumptions define the class in which uniqueness is claimed. Symmetry
alone does not exclude higher-derivative laws, nonlocal laws, massless
particles, or particles carrying additional internal data.

We use the spacetime structures derived in
[the metric note](13-poincare-galilei-metric.md): Minkowski spacetime in the
Poincare branch and the temporal metric plus spatial co-metric in the Galilei
branch.

## Inertial motion

### Galilean spacetime

In an inertial Cartesian frame, write the most general law in the stated
class as

$$
\dot{\mathbf v}
=\mathbf F(\mathbf x,\mathbf v,t).
$$

Spatial and temporal translation invariance give

$$
\mathbf F(\mathbf x+\mathbf a,\mathbf v,t+s)
=\mathbf F(\mathbf x,\mathbf v,t)
$$

for every constant $\mathbf a$ and $s$. Hence

$$
\dot{\mathbf v}=\mathbf F(\mathbf v).
$$

Use the Galilean boost convention

$$
t'=t,\qquad
\mathbf x'=\mathbf x-\mathbf b t,\qquad
\mathbf v'=\mathbf v-\mathbf b,\qquad
\dot{\mathbf v}'=\dot{\mathbf v}.
$$

Covariance means that the primed observer uses the same function
$\mathbf F$:

$$
\dot{\mathbf v}'
=\mathbf F(\mathbf v').
$$

Describing the same worldline with the unprimed equation therefore gives

$$
\mathbf F(\mathbf v-\mathbf b)=\mathbf F(\mathbf v)
$$

for every $\mathbf v$ and every boost velocity $\mathbf b$. Given any
$\mathbf v_1,\mathbf v_2$, choose
$\mathbf b=\mathbf v_1-\mathbf v_2$; then
$\mathbf F(\mathbf v_2)=\mathbf F(\mathbf v_1)$. Thus $\mathbf F$ is a
constant vector $\mathbf C$.

Rotation covariance now requires

$$
\mathbf C=\mathbf F(R\mathbf v)=R\mathbf F(\mathbf v)=R\mathbf C
$$

for every $R\in SO(3)$. The only vector fixed by every rotation is zero, so

$$
\boxed{\dot{\mathbf v}=0.}
$$

Boost covariance removes velocity dependence; isotropy removes the remaining
constant acceleration.

### Minkowski spacetime

Let

$$
u^\mu=\frac{dx^\mu}{d\tau},
\qquad
a^\mu=\frac{du^\mu}{d\tau},
\qquad
\eta_{\mu\nu}u^\mu u^\nu=-c^2.
$$

Translation invariance reduces the most general covariant law in the stated
class to

$$
a^\mu=A^\mu(u).
$$

Lorentz covariance is the equivariance condition

$$
A(\Lambda u)=\Lambda A(u)
$$

for every proper orthochronous Lorentz transformation $\Lambda$.

Choose the rest four-velocity $u_0=(c,\mathbf 0)$. Every spatial rotation
$R$ fixes $u_0$. Equivariance then gives

$$
A(u_0)=A(Ru_0)=R A(u_0).
$$

Consequently the spatial part of $A(u_0)$ vanishes, so
$A(u_0)$ is proportional to $u_0$. On the other hand, differentiating the
fixed normalization of the four-velocity gives

$$
0=\frac{d}{d\tau}(u\mathbin{\cdot}u)=2u\mathbin{\cdot}a.
$$

Thus $A(u_0)$ is also orthogonal to $u_0$. Since $u_0$ is non-null, both
conditions can hold only when $A(u_0)=0$.

Every future-directed timelike four-velocity is $\Lambda u_0$ for some
Lorentz transformation. Therefore

$$
A(\Lambda u_0)=\Lambda A(u_0)=0,
$$

and hence

$$
\boxed{a^\mu=0.}
$$

This argument uses the full Lorentz orbit of timelike velocities, not one
special boost. In an inertial coordinate system it is equivalent to constant
three-velocity.

## What has and has not been proved

Within the local second-order class above, inertial-frame symmetry uniquely
selects straight, uniformly parametrized worldlines. No action or momentum
formula was used.

This does **not** prove that the equation has a unique Lagrangian. Inverse
variational problems generally admit inequivalent Lagrangians producing the
same trajectories. To determine the familiar free-particle Lagrangians we
must add more input.

## Adding an action principle

Assume Hamilton's principle for a local first-order action,

$$
S=\int L(\mathbf x,\mathbf v,t)\,dt.
$$

Two Lagrangians differing by

$$
L' = L+\frac{d\chi(\mathbf x,t)}{dt}
$$

have the same Euler-Lagrange equations. Any uniqueness statement below is
therefore only modulo such a total derivative.

We also identify canonical momentum,

$$
\mathbf p_{\mathrm{can}}=\frac{\partial L}{\partial\mathbf v},
$$

with the mechanical momentum independently derived from inertial-frame
symmetry, collision balance, extensivity, and regularity in
[the unified energy-momentum note](energy_momentum_unified.md). Those extra
collision assumptions, not spacetime symmetry by itself, determine the mass
normalization.

### Galilean Lagrangian

The imported momentum law is

$$
\mathbf p=m\mathbf v.
$$

In a homogeneous gauge $L=L(\mathbf v)$, the canonical-mechanical
identification gives

$$
\frac{\partial L}{\partial v_i}=m v_i.
$$

Integrating each component yields

$$
L=\frac12m\mathbf v^2+C.
$$

The constant is dynamically irrelevant because
$C=d(Ct)/dt$. Restoring the general total-derivative freedom,

$$
\boxed{
L_{\mathrm G}
=\frac12m\mathbf v^2+\frac{d\chi}{dt}.
}
$$

The coefficient $m$ is the Bargmann central charge carried by the particle;
the bare Galilei spacetime geometry does not fix its value.

### Relativistic Lagrangian

For a structureless free particle, require the action to be local, additive
along adjacent worldline segments, reparametrization invariant, and Lorentz
invariant. Let $\lambda$ be an arbitrary increasing worldline parameter and
write

$$
S=\int \mathcal L(\dot x)\,d\lambda,
\qquad
\dot x^\mu=\frac{dx^\mu}{d\lambda}.
$$

Translation invariance removes explicit $x$-dependence. For a timelike
worldline, Lorentz invariance permits dependence on $\dot x^\mu$ only through

$$
z=-\eta_{\mu\nu}\dot x^\mu\dot x^\nu>0,
$$

so $\mathcal L(\dot x)=f(z)$. Under a constant reparametrization for which
$\dot x\mapsto k\dot x$, invariance of
$\mathcal L\,d\lambda$ requires positive homogeneity,

$$
f(k^2z)=k f(z)
$$

for every $k>0$. Taking $k=\sqrt{w/z}$ gives

$$
f(w)=\sqrt{\frac wz}\,f(z),
$$

so $f(z)=\beta\sqrt z$ for one constant $\beta$. Because
$\sqrt z\,d\lambda=c\,d\tau$, the action has the form

$$
S=\alpha\int d\tau
$$

with $\alpha=\beta c$, a constant having dimensions of energy. Thus locality,
Lorentz invariance, and reparametrization invariance fix the form; they do not
fix this particle-dependent normalization.

Using

$$
d\tau=dt\sqrt{1-\frac{\mathbf v^2}{c^2}},
$$

we obtain

$$
L=\alpha\sqrt{1-\frac{\mathbf v^2}{c^2}}.
$$

Its canonical momentum is

$$
\frac{\partial L}{\partial\mathbf v}
=-\frac{\alpha}{c^2}\,
\frac{\mathbf v}{\sqrt{1-\mathbf v^2/c^2}}.
$$

The independently derived relativistic momentum is

$$
\mathbf p=\gamma m\mathbf v,
\qquad
\gamma=\frac{1}{\sqrt{1-\mathbf v^2/c^2}}.
$$

Equating the two fixes $\alpha=-mc^2$. Thus

$$
\boxed{
L_{\mathrm P}
=-mc^2\sqrt{1-\frac{\mathbf v^2}{c^2}}
+\frac{d\chi}{dt}.
}
$$

This conclusion applies to massive timelike particles. A massless particle
requires an auxiliary worldline field or an equivalent affine-parameter
action and is a separate branch.

## Equations of motion from the actions

For the Galilean action,

$$
\frac{d}{dt}\frac{\partial L_{\mathrm G}}{\partial\mathbf v}
=m\dot{\mathbf v}=0.
$$

For the relativistic action,

$$
\frac{d}{dt}\frac{\partial L_{\mathrm P}}{\partial\mathbf v}
=\frac{d}{dt}(\gamma m\mathbf v)=0.
$$

For $m>0$ and $|\mathbf v|<c$, the map
$\mathbf v\mapsto\gamma m\mathbf v$ is one-to-one, so conserved momentum
implies constant $\mathbf v$ and hence $a^\mu=0$. The actions therefore
reproduce, rather than supply, the previously derived inertial motion.

## Noether charges

After the action principle has been introduced, spatial and temporal
translations give canonical momentum and energy. Choosing the homogeneous
representatives $\chi=0$ gives

| Quantity | Galilean | Relativistic |
| --- | --- | --- |
| momentum | $\mathbf p=m\mathbf v$ | $\mathbf p=\gamma m\mathbf v$ |
| energy | $E=\frac12m\mathbf v^2$ | $E=\gamma mc^2$ |

For the relativistic particle,

$$
E
=\mathbf v\mathbin{\cdot}\frac{\partial L_{\mathrm P}}{\partial\mathbf v}
-L_{\mathrm P}
=\gamma mc^2.
$$

It follows algebraically that

$$
E^2-\mathbf p^2c^2=m^2c^4.
$$

In Galilean mechanics an additive constant in the energy remains
conventional. In the relativistic theory, $(E/c,\mathbf p)$ must transform as
a four-vector, so a frame-independent additive shift of $E$ is not compatible
with Lorentz covariance.

## Curved spacetime and the geodesic postulate

Coordinate covariance is a requirement on how an already specified geometric
law is represented; it is not a physical force law and does not determine a
connection.

To pass from inertial motion to gravity, add:

1. **universal free fall:** all structureless test bodies couple to one affine
   connection, independently of mass and composition;
2. **minimal coupling:** in the absence of nongravitational forces, no
   additional curvature-dependent force term is present;
3. **an affine parameter:** proper time in Lorentzian spacetime, and an
   affine parameter compatible with absolute time in Newton-Cartan spacetime.

The invariant equation is then

$$
u^\nu\nabla_\nu u^\lambda=0,
$$

or in coordinates,

$$
\frac{d^2x^\lambda}{d\lambda^2}
+\Gamma^\lambda_{\mu\nu}
\frac{dx^\mu}{d\lambda}
\frac{dx^\nu}{d\lambda}
=0.
$$

In general relativity, imposing torsion freedom and metric compatibility
makes $\Gamma$ the Levi-Civita connection of $g_{\mu\nu}$. In
Newton-Cartan theory, compatibility with the temporal metric and spatial
co-metric does not uniquely determine $\Gamma$; gravitational and Coriolis
data remain in the connection, as discussed in
[the Newton-Cartan note](16-nc.md).

At any event one can choose normal coordinates in which the symmetric part of
the connection vanishes at that event, reducing the equation there to
$d^2x^\lambda/d\lambda^2=0$. This is a pointwise statement. It does not make
the connection vanish on a neighborhood and does not imply zero curvature.

## Continuum conservation laws

For matter fields, conservation laws require a matter action and its field
equations. Diffeomorphism invariance of that action gives an on-shell Noether
identity.

In a Lorentzian theory with matter coupled only to the metric, the identity is

$$
\nabla_\mu T^{\mu\nu}=0.
$$

In Newton-Cartan theory the background data are degenerate and independent,
so the corresponding Ward identities involve the mass current, momentum
current, and energy current. They should not be compressed into the
Lorentzian formula without specifying the Newton-Cartan matter couplings.

These are consequences of the matter action's diffeomorphism invariance and
the matter equations of motion. They are not consequences of inertial-frame
symmetry alone, and deriving them does not require a gravitational field
equation.

## Dependency summary

| Result | Inputs actually used |
| --- | --- |
| $\dot{\mathbf v}=0$ | local second-order law + translations + rotations + all Galilean boosts |
| $a^\mu=0$ | local second-order law + translations + full Lorentz covariance + timelike normalization |
| $L_{\mathrm G}=\frac12m\mathbf v^2$ | action principle + imported $\mathbf p=m\mathbf v$ |
| $L_{\mathrm P}=-mc^2/\gamma$ | local additive Lorentz-scalar action + imported $\mathbf p=\gamma m\mathbf v$ |
| momentum and energy | established action + Noether theorem |
| geodesic motion | universal free fall + connection + minimal coupling |
| continuum Ward identities | diffeomorphism-invariant matter action + matter equations |

The non-circular chain is therefore not “symmetry fixes everything.”
Spacetime symmetry fixes inertial motion within a stated class; additional,
explicit physical assumptions determine its variational representation,
normalization, coupling to gravity, and continuum conservation laws.
