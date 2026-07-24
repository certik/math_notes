# Spacetime from Common Kinematical Assumptions

The purpose of this note is to classify the flat local spacetime structures
compatible with a common set of physical assumptions. We do not assume
Galilean or Lorentzian spacetime at the start. Instead, the two arise as the
causal branches of one kinematical algebra.

The conclusion is deliberately limited. The argument classifies flat
inertial kinematics. Obtaining Newton-Cartan theory or general relativity
requires additional assumptions about gravity, universal free fall, and
field dynamics.

## Assumptions ledger

### Physical principles

1. **Relativity principle.** No inertial frame is preferred. The identity
   component of the inertial transformations acts transitively on inertial
   velocity states.
2. **Strong spacetime homogeneity.** The transformation of a displacement
   between two events is independent of where that displacement is based.
3. **Spatial isotropy and reflection symmetry.** Within the identity
   component, the stabilizer of a rest frame is $SO(3)$. Spatial reflection
   is an additional discrete symmetry acting in the standard way: $P_i$ and
   $K_i$ are polar vectors, $J_i$ is an axial vector, and $H$ is a scalar.
4. **Causal time orientation.** The connected inertial symmetry group
   preserves a distinction between future and past.

### Mathematical assumptions

1. Events have four real coordinates, and inertial-frame transformations are
   continuous bijections.
2. We classify the connected transformations through their Lie algebra; the
   discrete spatial reflection is used only to constrain its structure
   constants.
3. The connected inertial algebra has exactly ten generators: three
   rotations, three boosts, three spatial translations, and one time
   translation. In particular, an independent dilation is not an inertial
   transformation. Without this fixed generator content, Weyl-type extensions
   preserving only a conformal class would also be possible.

### Conventions

The generators are:

- $J_i$: spatial rotations;
- $K_i$: boosts;
- $P_i$: spatial translations;
- $H$: time translation.

## Strong homogeneity forces affine transformations

Let $F:\mathbb R^4\to\mathbb R^4$ be a transformation between inertial
coordinate systems. Strong homogeneity says that for every displacement $a$,

$$
F(x+a)-F(x)=L(a)
$$

is independent of the base event $x$. Applying this twice gives

$$
\begin{aligned}
L(a+b)
&=F(x+a+b)-F(x)
\\
&=\bigl(F(x+a+b)-F(x+a)\bigr)
 +\bigl(F(x+a)-F(x)\bigr)
\\
&=L(b)+L(a).
\end{aligned}
$$

Thus $L$ is additive. Continuity excludes pathological additive maps, so
$L$ is linear over $\mathbb R$. Taking $x=0$ gives

$$
F(x)=L(x)+F(0).
$$

Every inertial-frame transformation is therefore affine. After choosing a
common origin, it is linear.

Pure translations are consequently

$$
T_a(x)=x+a,
$$

and satisfy

$$
T_aT_b=T_{a+b}=T_bT_a.
$$

Hence commuting translations are a conclusion of strong homogeneity, not an
independent assumption. Kinematics whose translation generators do not
commute, including de Sitter, anti-de Sitter, and Newton-Hooke kinematics, are
already outside this stronger notion of homogeneity.

Affine transformations form a semidirect product

$$
GL(4,\mathbb R)\ltimes\mathbb R^4.
$$

The translations $\mathbb R^4$ are therefore an ideal: the commutator of a
linear generator with a translation generator is another translation
generator. Likewise, the commutator of two linear generators has no
translation part. These closure facts restrict the boost brackets below.

## The common kinematical algebra

Spatial isotropy fixes the rotation brackets and the transformation of
spatial vectors:

$$
\begin{aligned}
[J_i,J_j]&=\epsilon_{ijk}J_k,
&
[J_i,K_j]&=\epsilon_{ijk}K_k,
\\
[J_i,P_j]&=\epsilon_{ijk}P_k,
&
[J_i,H]&=0.
\end{aligned}
$$

The affine result above gives

$$
[P_i,P_j]=0,
\qquad
[P_i,H]=0.
$$

Because translations are an ideal, $[K_i,H]$ must be a translation. Rotation
covariance makes it a spatial vector, so

$$
[K_i,H]=bP_i.
$$

Transitivity on inertial velocity states requires $b\ne0$: a boost must change
the velocity of the rest worldline. Rescaling $K_i$ sets $b=1$. Static and
Carroll-type boosts, which leave that velocity fixed, do not satisfy the
stated relativity principle. We therefore use the convention

$$
[K_i,H]=P_i.
$$

The ideal property requires $[K_i,P_j]$ to be a translation. Rotational
covariance permits a scalar term $\delta_{ij}H$ and a chiral vector term
$\epsilon_{ijk}P_k$; spatial reflection excludes the latter. The commutator
of two boosts belongs to the homogeneous linear algebra. Antisymmetry,
rotational covariance, and reflection symmetry allow an axial rotation term
but exclude a polar boost term. Consequently the general remaining brackets
are

$$
[K_i,P_j]=\kappa\,\delta_{ij}H,
\qquad
[K_i,K_j]=a\,\epsilon_{ijk}J_k
$$

for constants $\kappa$ and $a$. The Jacobi identity for
$(K_i,K_j,P_k)$ determines their relation. Substitution gives

$$
\begin{aligned}
0
&=[K_i,[K_j,P_k]]
  +[K_j,[P_k,K_i]]
  +[P_k,[K_i,K_j]]
\\
&=(\kappa+a)
  \left(\delta_{jk}P_i-\delta_{ik}P_j\right).
\end{aligned}
$$

Therefore

$$
a=-\kappa.
$$

All brackets relevant to inertial kinematics are consequently

$$
\boxed{
\begin{aligned}
[K_i,H]&=P_i,
&
[K_i,P_j]&=\kappa\,\delta_{ij}H,
&
[K_i,K_j]&=-\kappa\,\epsilon_{ijk}J_k.
\end{aligned}
}
$$

The single constant $\kappa$ has dimensions of inverse speed squared. At this
stage the algebra has three branches: $\kappa>0$, $\kappa=0$, and
$\kappa<0$.

## Selecting the causal branches

### Finite invariant speed: $\kappa>0$

Write

$$
\kappa=\frac{1}{c^2},
\qquad 0<c<\infty.
$$

Rescaling the time coordinate by $c$ converts the brackets into the Poincare
algebra. The boosts do not commute, and their commutator is a rotation:

$$
[K_i,K_j]=-\frac{1}{c^2}\epsilon_{ijk}J_k.
$$

The invariant spacetime tensor derived from this algebra is a non-degenerate
Lorentzian metric. Its normalization is conventional; with signature
$(-+++)$,

$$
g_{\mu\nu}
=\operatorname{diag}(-1,1,1,1).
$$

The connected group preserves each component of the timelike cone, so a
future time orientation can be chosen and preserved.

### Infinite invariant speed: $\kappa=0$

The boost brackets become

$$
[K_i,P_j]=0,
\qquad
[K_i,K_j]=0.
$$

This is the bare Galilei algebra. It has no non-degenerate invariant
spacetime metric. Instead it preserves two degenerate structures:

$$
\tau_\mu=(1,0,0,0),
\qquad
h^{\mu\nu}=\operatorname{diag}(0,1,1,1),
$$

with

$$
h^{\mu\nu}\tau_\nu=0.
$$

The covector $\tau_\mu$ defines absolute elapsed time and a time orientation;
$h^{\mu\nu}$ defines Euclidean spatial lengths within simultaneity slices.

### Euclidean branch: $\kappa<0$

If $\kappa=-1/c_E^2$, boosts act as ordinary compact rotations between the
time direction and spatial directions. The invariant bilinear form is
positive definite rather than Lorentzian.

The connected homogeneous group can continuously rotate a chosen time
direction into spatial directions and eventually into its negative. It
therefore preserves no future cone or global distinction between future and
past. The causal-time-orientation principle excludes this branch.

Thus the stated assumptions leave exactly

$$
\boxed{\kappa=0\quad\text{or}\quad\kappa=\frac{1}{c^2}>0.}
$$

These are the Galilean and Lorentzian branches, respectively. Their names are
conclusions of the classification, not initial assumptions.

## Geometry from the two algebras

The algebraic classification and the geometric classification are separate
steps. For either surviving algebra, spacetime is the homogeneous space

$$
M=G/H_{\mathrm{event}},
$$

where $G$ is the inertial symmetry group and $H_{\mathrm{event}}$ is the
subgroup generated by rotations and boosts that fixes a chosen event. The
translation generators $\{H,P_i\}$ span the tangent representation at that
event.

The invariant-tensor calculation is carried out in
[the metric note](13-poincare-galilei-metric.md). Its results are:

| branch | invariant local spacetime structure |
| --- | --- |
| $\kappa>0$ | non-degenerate Lorentzian metric $g_{\mu\nu}$ |
| $\kappa=0$ | temporal covector $\tau_\mu$ and spatial co-metric $h^{\mu\nu}$ |

Because translations commute and form an abelian ideal, both homogeneous
models are flat affine spaces. This conclusion follows from strong
homogeneity; it does not follow from isotropy or transitivity alone.

## The common velocity-space structure

The two branches also share the structure needed for free-particle
kinematics. Fix a future-directed rest velocity $u_0$. The connected
homogeneous group generated by rotations and boosts acts transitively on the
admissible inertial velocity space $\mathcal V$:

$$
\mathcal V=G_0/SO(3).
$$

The stabilizer of $u_0$ is $SO(3)$, and its action on
$T_{u_0}\mathcal V$ is the ordinary three-dimensional vector
representation. Concretely,

| branch | velocity space $\mathcal V$ | invariant affine parameter |
| --- | --- | --- |
| $\kappa=0$ | $\{u:\tau_\mu u^\mu=1\}\cong\mathbb R^3$ | absolute time |
| $\kappa>0$ | $\{u:g(u,u)=-c^2,\ u\text{ future}\}$ | proper time |

This shared homogeneous-space statement, rather than either explicit boost
formula, is the input used for the unified derivation of inertial motion in
[the kinematics note](18-kinematics.md).

## Coordinate covariance is not a physical symmetry

A passive coordinate change relabels the same events and tensor fields. A
physical spacetime symmetry maps one physical configuration to another while
preserving the background spacetime structure. These are different claims:

- **coordinate covariance** says that an equation has the same geometric
  meaning in every chart;
- **inertial symmetry** says that the flat background is preserved by a
  particular finite-dimensional group;
- **diffeomorphism gauge symmetry** identifies configurations related by an
  active diffeomorphism when the theory makes that identification.

Writing an equation in tensor form establishes coordinate covariance. It does
not by itself establish the relativity principle, remove preferred background
fields, or imply the strong equivalence principle.

For example, let $D$ be the flat compatible Newton-Cartan connection. The
coordinate Poisson equation

$$
\delta^{ij}\partial_i\partial_j\Phi=4\pi G\rho
$$

is the adapted-coordinate form of a Newton-Cartan scalar equation such as

$$
h^{\mu\nu}D_\mu D_\nu\Phi=4\pi G\rho.
$$

Equivalently, after the gravitational potential has been incorporated into a
compatible Newton-Cartan connection, the field equation can be written

$$
R_{\mu\nu}=4\pi G\rho\,\tau_\mu\tau_\nu
$$

subject to the additional Newton-Cartan curvature conditions. These tensor
equations remain meaningful under coordinate transformations that mix the
time and space labels.

Conversely, a preferred-frame force can also be written covariantly if one
introduces an observer field $n^\mu$ representing that preferred frame. The
equation is then coordinate-covariant but still violates the relativity
principle because $n^\mu$ is observable background structure. Tensor notation
cannot turn a preferred-frame theory into a frame-independent one.

## From flat models to curved spacetime

The flat homogeneous models describe tangent kinematics. A curved theory
introduces an affine connection $\nabla$ compatible with the branch's local
geometric structure.

At any event, the symmetric part of a connection can be made to vanish by a
coordinate choice. This is only a pointwise statement:

$$
\Gamma^\lambda_{(\mu\nu)}(p)=0.
$$

Derivatives of the connection need not vanish, and curvature can remain
nonzero. A local normal-coordinate construction therefore does not imply
flatness on a neighborhood or globally.

The equivalence principle supplies physical content beyond coordinate
covariance: sufficiently small freely falling experiments cannot detect a
universal homogeneous gravitational field, although tidal effects can remain.
To turn that statement into geodesic motion one must additionally assume
universal free fall and minimal coupling to a connection.

The two curved continuations are then:

- a Lorentzian geometry with a metric-compatible connection, as used in
  general relativity;
- a Galilean geometry with $\tau_\mu$, $h^{\mu\nu}$, and an independent
  compatible connection, as used in Newton-Cartan theory.

The kinematical classification does not determine either gravitational field
equation.

## Background independence

Background independence is stronger than coordinate covariance. It asks that
geometric structures affecting observable motion or causal relations not be
fixed nondynamical fields.

This condition is conceptually separate from the classification above:

- the flat inertial models intentionally contain fixed invariant structures;
- Newton-Cartan theory commonly retains $\tau_\mu$ and $h^{\mu\nu}$ as
  absolute structures while allowing the compatible connection to carry
  gravity;
- general relativity makes the Lorentzian metric dynamical.

Exactly which fields must be dynamical is an additional choice of theory, not
a consequence of writing equations under $\operatorname{Diff}(M)$.

## Dependency summary

The logical chain is

$$
\begin{gathered}
\text{relativity}+\text{strong homogeneity}+\text{isotropy}
+\text{fixed ten-generator content}
\\
\Longrightarrow
\text{one-parameter algebra } \mathfrak g_\kappa
\\
\xrightarrow{\text{causal time orientation}}
\kappa=0\ \text{or}\ \kappa>0
\\
\Longrightarrow
\text{Galilean or Lorentzian local geometry}.
\end{gathered}
$$

The stronger homogeneity condition has already excluded non-affine curved
kinematics, while transitivity on velocity states excludes ineffective
boosts. Gravity, geodesic motion, actions, and field equations all require
further physical assumptions.
