---
date: 2026-05-12
authors:
  - name: Ondřej Čertík
exports:
  - format: docx
  - format: pdf
  - format: tex
  - format: typst
bibliography:
  - references.bib
---

# From the Poincaré and Galilei Algebras to the Spacetime Metric

## Overview

We start from the **abstract Lie algebras** of the Poincaré and (bare) Galilei
groups, defined purely by their commutation relations, and derive the
**invariant metric on the spacetime** they act on. We do everything at the
level of the algebra, using nothing but commutators and the Leibniz rule.

Conventions: 3+1 dimensions, no factors of $i$ in the structure constants,
signature $(-, +, +, +)$, units $c = 1$. For Galilei we use the *bare*
algebra (no central charge), which is sufficient for the spacetime metric.

The companion document [03-lie-groups.md](03-lie-groups.md) starts from
explicit matrix generators and solves the same invariance condition. Here we
*derive* everything from the commutation relations.

## Strategy

### The translation subspace as a representation

Let $V = \operatorname{span}\{P^0, P^1, P^2, P^3\}$ with $P^0 \equiv H$, the
4-dimensional subspace of translation generators inside the full Lie algebra.

The homogeneous generators $X \in \{J_i, K_i\}$ act on the whole algebra by
the **adjoint action**

$$
X \cdot Y := [X, Y] \,.
$$

A direct inspection of the Poincaré or Galilei commutation relations (given
in Parts I and II below) shows
that for every generator $X \in \{J_i, K_i\}$ and every $\mu$,

$$
[X, P^\mu] \in V \,,
$$

so the adjoint action restricts to a linear representation of the homogeneous
algebra on $V$.

### Group invariance ⇒ Leibniz condition

Exponentiate. The group element $U = \exp(\theta X)$ acts on $V$ by
conjugation:

$$
U\, P^\mu\, U^{-1} = e^{\theta X} P^\mu e^{-\theta X}
= P^\mu + \theta [X, P^\mu] + \tfrac{\theta^2}{2}\big[X, [X, P^\mu]\big] + \cdots
$$

A symmetric bilinear form $g$ on $V$ is **invariant under the group action**
if

$$
g\big(U P^\mu U^{-1},\, U P^\nu U^{-1}\big)
= g(P^\mu, P^\nu) \qquad \forall \theta, X \,.
$$

Differentiate at $\theta = 0$. Using $\dfrac{d}{d\theta}\big|_0 U P^\mu
U^{-1} = [X, P^\mu]$ and the bilinearity of $g$,

$$
\frac{d}{d\theta}\Big|_{\theta=0}
g\big(U P^\mu U^{-1}, U P^\nu U^{-1}\big)
= g\big([X, P^\mu], P^\nu\big) + g\big(P^\mu, [X, P^\nu]\big) \,.
$$

Invariance forces this derivative to vanish:

$$
\boxed{\;
g\big([X, P^\mu], P^\nu\big) + g\big(P^\mu, [X, P^\nu]\big) = 0
\;}
$$

for every generator $X \in \{J_i, K_i\}$ and every $\mu, \nu$. This is the
**Leibniz condition**: invariance is the statement that $X$ acts as a
derivation on $g$ with zero output.

It is a necessary condition. It is also sufficient: the **infinitesimal**
Leibniz condition (at $\theta = 0$) implies the **finite** group invariance
$g(U P^\mu U^{-1}, U P^\nu U^{-1}) = g(P^\mu, P^\nu)$ for **all** $\theta \in
\mathbb{R}$. To see this, define

$$
f(\theta) := g\big(U(\theta) P^\mu U(\theta)^{-1},\ U(\theta) P^\nu U(\theta)^{-1}\big), \qquad U(\theta) = e^{\theta X}.
$$

Differentiating at an arbitrary $\theta$:

$$
f'(\theta) = g\big([X, P^\mu_\theta], P^\nu_\theta\big) + g\big(P^\mu_\theta, [X, P^\nu_\theta]\big),
\qquad P^\mu_\theta := U(\theta) P^\mu U(\theta)^{-1} \in V.
$$

By closure of $V$ under the adjoint action, $P^\mu_\theta \in V$, so the
Leibniz condition (which holds for *every* pair of vectors in $V$, not just
the basis) gives $f'(\theta) = 0$ identically. Hence $f$ is constant,
$f(\theta) = f(0) = g(P^\mu, P^\nu)$, for all $\theta$. So the infinitesimal
Leibniz condition is equivalent to finite group invariance along each
one-parameter subgroup, and composing these recovers invariance under every
element of the identity component of the group.

Writing $g(P^\mu, P^\nu) = \eta^{\mu\nu}$ with $\eta^{\mu\nu} =
\eta^{\nu\mu}$, the Leibniz condition becomes a finite system of linear
equations on the 10 components of $\eta$.

---

## Spacetime as a homogeneous space

So far we have treated the translation subspace $V =
\operatorname{span}\{P^0, P^1, P^2, P^3\}$ as if its basis carried a preferred
geometric interpretation: $P^\mu$ generates translation along the $\mu$-th
spacetime direction, and the parameters $a^\mu$ in $T_a = \exp(a^\mu P^\mu)$
are spacetime coordinates. This step needs justification, because the Lie
algebra by itself does not announce which of its elements are "translations"
and which are not.

The proper framework is that of a **Klein geometry**. Given a Lie group $G$
and a closed subgroup $H \subset G$, the coset space

$$
\mathcal{M} := G/H
$$

is a smooth manifold on which $G$ acts transitively, with $H$ playing the
role of the stabilizer of a chosen basepoint. At the algebra level this
corresponds to a vector-space decomposition

$$
\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m},
$$

where $\mathfrak{h}$ is the Lie subalgebra of $H$ (the isotropy at the
basepoint) and $\mathfrak{m}$ is a complementary subspace identified with the
tangent space $T_{eH}\mathcal{M}$. The pair $(\mathfrak{g}, \mathfrak{h})$ is
what defines the geometry; the Lie algebra $\mathfrak{g}$ alone is not
enough.

### Reductive and symmetric Klein geometries

The vector-space splitting $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$
needs a word of qualification, because the rest of this document silently
relies on a non-trivial property of it.

A Klein geometry $(G, H)$ is called **reductive** if the splitting can be
chosen so that $\mathfrak{m}$ is preserved by the adjoint action of $H$ —
equivalently, at the algebra level,

$$
[\mathfrak{h},\, \mathfrak{m}] \;\subset\; \mathfrak{m}.
$$

Note that $\mathfrak{m}$ is not required to be a Lie subalgebra; only that
$\mathrm{ad}_X$ for $X \in \mathfrak{h}$ maps $\mathfrak{m}$ back into
itself.

If, in addition,

$$
[\mathfrak{m},\, \mathfrak{m}] \;\subset\; \mathfrak{h},
$$

the geometry is called **symmetric**. Every symmetric Klein geometry is
reductive; the converse is false.

**Why reductivity matters here.** Each step of our construction needs
$\mathrm{Ad}(H)$ to act on $\mathfrak{m}$ separately from the rest of
$\mathfrak{g}$:

- The Leibniz invariance condition asks for an $\mathrm{Ad}(H)$-invariant
  bilinear form on $\mathfrak{m}$. This presupposes that
  $\mathrm{ad}_X(Y) \in \mathfrak{m}$ for $X \in \mathfrak{h}$, $Y \in
  \mathfrak{m}$, i.e. exactly $[\mathfrak{h}, \mathfrak{m}] \subset
  \mathfrak{m}$.
- The Maurer–Cartan splitting $\omega = e + \omega_{\mathfrak{h}}$ into
  *vielbein* and *spin connection*, used to translate the algebraic
  metric on $\mathfrak{m}$ into a metric in coordinates (see the
  $S^2$ derivation in Part IV), needs an $\mathrm{Ad}(H)$-equivariant
  projection $\mathfrak{g} \to \mathfrak{m}$, which exists iff the
  geometry is reductive.

Without reductivity, "invariant form on $\mathfrak{m}$" is not even
well-posed, because every choice of complement to $\mathfrak{h}$ in
$\mathfrak{g}$ would lose pieces of $\mathrm{ad}_X(\mathfrak{m})$ back
into $\mathfrak{h}$ under $\mathrm{Ad}(H)$. The whole machinery of this
document is specifically a recipe for *reductive* Klein geometries.

**Are there non-reductive Klein geometries?** Yes, and they describe
important geometries — they are simply not the ones where a metric is
the primary invariant. The canonical examples are the **parabolic
geometries**, where $H$ is a parabolic subgroup of a semisimple $G$:

| Geometry | $G$ | $H$ | Primary invariant on $\mathfrak{m}$ |
|---|---|---|---|
| Conformal | $SO(p+1, q+1)$ | parabolic | conformal class $[g]$ (no preferred metric) |
| Projective | $PGL(n+1, \mathbb{R})$ | affine stabiliser of a line | projective class of connections |
| CR | $SU(p+1, q+1)$ | parabolic | complex tangent distribution + Levi form |

In each case the parabolic $H$ has a Levi decomposition $H = L \ltimes
N$ with $N$ unipotent, and the nilpotent pieces in $\mathfrak{h}$
prevent any choice of complement $\mathfrak{m}$ from being
$\mathrm{Ad}(H)$-invariant. The right invariants on $G/H$ are no longer
first-order tensors on $\mathfrak{m}$ (such as a metric) but live in
*filtrations* of $\mathfrak{g}/\mathfrak{h}$ and capture geometric
structure one or more derivative orders higher. This is the world of
**Tanaka–Morimoto–Čap–Slovák parabolic geometry**, the modern home for
conformal and projective geometry.

**All six examples in this document.** Poincaré, Galilei, $\mathfrak{e}(2)$,
$\mathfrak{e}(3)$, $\mathfrak{so}(3)$, and $\mathfrak{so}(4)$ — together
with their close cousins (de Sitter, anti-de Sitter, hyperbolic space) —
are all not just reductive but **symmetric**. That is why each one
admits a canonical metric (or pair of metrics) determined by an
algebraic invariance condition, and why the construction works so
cleanly. The bracket dichotomy

$$
[\mathfrak{m}, \mathfrak{m}] \;=\; 0
\quad\text{vs.}\quad
[\mathfrak{m}, \mathfrak{m}] \;\subset\; \mathfrak{h}
$$

— flat vs. constant curvature, as summarised in the table after Part IV
— is the *symmetric-space* dichotomy. The cases where it fails (e.g.,
neither inclusion holds, or $[\mathfrak{h}, \mathfrak{m}] \not\subset
\mathfrak{m}$ in any complement) take us out of symmetric Klein geometry
and, in the most interesting non-reductive case, into parabolic
geometry.

Many familiar spaces are constructed this way: the sphere as $SO(3)/SO(2)$,
Euclidean space as $E(n)/SO(n)$, hyperbolic space as $SO(n,1)/SO(n)$, and —
the case at hand — Minkowski spacetime as $\text{Poincaré}/\text{Lorentz}$
and Galilean spacetime as $\text{Galilei}/\{J, K\}$. In each case the Lie
group encodes the symmetries, and the chosen subgroup $H$ encodes "what
fixes the origin".

For the **Poincaré algebra**, the choice of subalgebra is essentially
canonical. The Levi decomposition reads

$$
\mathfrak{p}
= \underbrace{\mathfrak{so}(3,1)}_{\text{semisimple Levi factor}}
\;\ltimes\;
\underbrace{\mathfrak{t}}_{\text{abelian radical}},
$$

with the radical $\mathfrak{t} = \operatorname{span}\{H, P^i\}$ being the
unique maximal abelian ideal. Both $\mathfrak{t}$ and the Levi complement
$\mathfrak{h} = \mathfrak{so}(3,1)$ are determined up to conjugation by the
algebraic structure alone. So Minkowski spacetime $\mathbb{R}^{3,1}$ is
intrinsically attached to the Poincaré algebra.

For the **bare Galilei algebra**, the situation is genuinely ambiguous. The
maximal abelian ideal turns out to be $\operatorname{span}\{K_i, P^i\}$ —
six-dimensional, since $[K_i, K_j] = [K_i, P^j] = [P^i, P^j] = 0$ and one
verifies that bracketing this subspace with any generator stays inside it.
The standard "spacetime translations" $\{H, P^i\}$ form a *strictly smaller*
four-dimensional abelian ideal, and indeed there are two natural Klein pairs:

- $\mathfrak{h} = \{J_i, K_i\}$, $\mathfrak{m} = \{H, P^i\}$ — giving the
  four-dimensional **Galilean spacetime**;
- $\mathfrak{h}' = \{J_i, H\}$, $\mathfrak{m}' = \{K_i, P^i\}$ — giving the
  six-dimensional **phase space** (position × velocity).

Both are valid homogeneous spaces of the Galilei group. The Lie algebra
alone does not single one of them out; the physical identification of
spacetime as the space of *events* fixes the choice $\mathfrak{h} = \{J_i,
K_i\}$ — that is, rotations and boosts are the transformations that leave a
chosen event in place.

To see this more explicitly, note that the choice of Klein pair is fixed
*operationally*, by specifying what kind of object the points of the
homogeneous space are meant to be. An **event** in physics is a localised
occurrence: a flash at a place at a moment. Two observers at different
positions or with different velocities may label it by different
coordinates, but it is the same physical thing. Asking *which of the ten
Galilei transformations does NOT move an event* gives a clean answer:

| Transformation | Effect on an event | Fixes event? |
|---|---|---|
| $P^i$ (spatial translation by $a^i$) | the flash is now at a different *place* | ✗ |
| $H$ (time translation by $\tau$) | the flash is now at a different *time* | ✗ |
| $J^i$ (rotation around the event) | the flash stays where and when it is | ✓ |
| $K^i$ (boost by $v^i$) | only the *observer's* velocity changes; the flash is unchanged | ✓ |

So the transformations that fix an event are exactly $\{J^i, K^i\}$ and
those that move events are exactly $\{H, P^i\}$. By the orbit–stabilizer
theorem, the space of events is

$$
\text{(Galilean spacetime)} \;=\; G \big/ \{J^i, K^i\}, \qquad \dim = 4,
$$

with $\{H, P^i\}$ acting on it transitively.

Repeating the same procedure with a different physical primitive gives a
different homogeneous space. Take **inertial worldlines** as the primitive
(a worldline is a constant-velocity trajectory $x(t) = a + vt$):

| Transformation | Effect on an inertial worldline | Fixes worldline? |
|---|---|---|
| $J^i$ (rotation around the time axis) | the basepoint worldline (the time axis) is invariant | ✓ |
| $H$ (time translation) | slides along the worldline; the worldline as a set is unchanged | ✓ |
| $K^i$ (boost) | changes the velocity — different worldline | ✗ |
| $P^i$ (spatial translation) | shifts to a parallel worldline | ✗ |

The stabilizer of a worldline is thus $\{J^i, H\}$ and the resulting
homogeneous space $G / \{J^i, H\}$ is the **6-dimensional space of
inertial worldlines**, parametrised by $(a, v)$. This is the underlying
manifold of **classical Galilean phase space**, equivalently $T^*
\mathbb{R}^3$.

One can take this further. Choosing as primitive "an event together with
a velocity vector at it" gives a 7-dimensional homogeneous space $G /
\{J^i\}$, with coordinates $(t, x, v)$ — Souriau's **evolution space** of
classical mechanics. Choosing the empty stabilizer recovers the full
10-dimensional group $G$ itself. Every choice of physical primitive thus
gives a homogeneous space; the Lie algebra accommodates them all, and
physics picks one by saying *what kind of object* the points are.

Two remarks are in order. First, the Klein construction returns only the
*smooth manifold* — not the symplectic structure that makes the 6D space
a Hamiltonian phase space. The symplectic form $\omega = dp_i \wedge
dq^i$ involves the **mass** $m$ (since $p = m v$), which is not present
in the bare Galilei algebra; it enters via the **Bargmann central
extension**, where one of the commutators is modified to $[K_i, P^j] = m
\delta_{ij}\, M$ with $M$ a central generator. So bare Galilei gives the
6D manifold; Bargmann gives the symplectic structure. More generally,
phase spaces in physics arise as **coadjoint orbits** of (centrally
extended) symmetry groups — the Kirillov–Kostant–Souriau picture — in
which the Klein-pair construction supplies the manifold and the central
extension supplies the symplectic geometry.

Second, among all these candidates events are special because they are
the most **local** and **operational** primitives: point-like, observable
in principle by a single localised detection, and requiring no derived
notion of velocity, mass, frame, or trajectory. Worldlines, phase-space
points, and evolution-space points are all *built out of* events
(equivalence classes of events under time translation, of worldlines
under further equivalences, and so on). This operational primacy of
events is what makes spacetime the natural arena for the laws of physics,
and the other homogeneous spaces the natural arenas for derived
constructions such as Hamiltonian dynamics or Lagrangian mechanics.

In the Poincaré case this whole subtlety disappears. The only abelian
ideal is the spacetime translations $\{H, P^i\}$, so there is no analog of
the 6-dimensional abelian ideal $\{K_i, P^i\}$ and no competing Klein
pair. The "events as primitive" choice is canonical because it is the
*only* choice. The Galilei algebra is ambiguous precisely because
$[K_i, P^j] = 0$ — the same single algebraic difference that destroys
non-degeneracy of the metric is what permits two distinct Klein pairs to
exist in the first place.

The reason the translation parameters $a^\mu$ can be used directly as
*global* coordinates on spacetime — in both the Poincaré and the standard
Galilei case — is that in each case $\mathfrak{m}$ is an **abelian ideal**.
Two consequences follow:

- Because $\mathfrak{m}$ is abelian, the exponential map $\mathfrak{m} \to T
  = \exp(\mathfrak{m})$ is a Lie-group isomorphism: $T$ is the additive
  group $(\mathbb{R}^4, +)$, with coordinates $a^\mu$.
- Because $\mathfrak{m}$ is an ideal complementary to $\mathfrak{h}$, every
  coset $gH$ has a unique representative in $T$, giving a global
  diffeomorphism $\mathcal{M} \cong T \cong \mathbb{R}^4$.

This is what makes Minkowski and Galilean spacetimes **flat affine spaces**
— a special feature of the algebras at hand. For a non-abelian or
non-ideal $\mathfrak{m}$ — for instance $SO(3)/SO(2) = S^2$ — the exponential
map is not a global bijection and the resulting homogeneous space is
curved. The further generalization to spaces that are not even homogeneous
is the framework of **Cartan geometry**, where the homogeneous model varies
smoothly from point to point; this is how curved spacetimes of general
relativity are described, modelled point-wise on flat Minkowski space.

Finally, with the Klein-geometry picture in place, the connection between
the abstract bilinear form $\eta^{\mu\nu}$ derived below and the spacetime
metric is straightforward. The translation parameters $a^\mu$ transform
under the homogeneous generators in exactly the same way as the basis
$\{P^\mu\}$, since the conjugation $U T_a U^{-1} = T_{\Lambda a}$ at the
group level differentiates to the same adjoint action $[X, P^\mu]$ at the
algebra level. Hence the matrix $\eta^{\mu\nu}$ that solves the Leibniz
invariance condition on $V$ is also the matrix of the invariant bilinear
form on the spacetime coordinates $x^\mu = a^\mu$ — i.e., the metric.

---

## Part I: The Poincaré algebra → Minkowski metric

### Commutation relations

The Poincaré algebra has ten generators $\{J_i, K_i, P^i, H\}$ with

$$
\begin{aligned}
{[J_i, J_j]} &= \epsilon_{ijk} J_k \,, & {[J_i, K_j]} &= \epsilon_{ijk} K_k \,, & {[K_i, K_j]} &= -\epsilon_{ijk} J_k \,, \\
{[J_i, H]} &= 0 \,, & {[J_i, P^j]} &= \epsilon_{ijk} P^k \,, \\
{[K_i, H]} &= P^i \,, & {[K_i, P^j]} &= \delta_{ij}\, H \,, \\
{[P^i, P^j]} &= 0 \,, & {[P^i, H]} &= 0 \,.
\end{aligned}
$$

We use $P^0 = H$ and label $\eta^{\mu\nu}$ accordingly: $\eta^{00} =
g(H, H)$, $\eta^{0i} = g(H, P^i)$, $\eta^{ij} = g(P^i, P^j)$.

### Imposing invariance

Apply the Leibniz condition with $X = K_i$ and the indicated indices.

**$(\mu, \nu) = (0, 0)$**:

$$
g([K_i, H], H) + g(H, [K_i, H]) = g(P^i, H) + g(H, P^i) = 2\, \eta^{i0} = 0
\quad\Longrightarrow\quad \eta^{i0} = 0 \,.
$$

**$(\mu, \nu) = (0, j)$**:

$$
g([K_i, H], P^j) + g(H, [K_i, P^j]) = g(P^i, P^j) + g(H, \delta_{ij} H)
= \eta^{ij} + \delta_{ij}\, \eta^{00} = 0 \,.
$$

So

$$
\eta^{ij} = -\delta_{ij}\, \eta^{00} \,.
$$

**$(\mu, \nu) = (j, k)$, both spatial**:

$$
g(\delta_{ij} H, P^k) + g(P^j, \delta_{ik} H) = \delta_{ij}\, \eta^{0k} + \delta_{ik}\, \eta^{j0} = 0 \,,
$$

which is automatic from $\eta^{0i} = 0$.

Rotations $J_i$ impose no further constraint: the diagonal isotropic form
$\eta^{ij} \propto \delta^{ij}$ already commutes with them.

### Result

Setting $\eta^{00} = -1$:

$$
\boxed{\;
\eta^{\mu\nu} = \operatorname{diag}(-1, 1, 1, 1)
\;}
\qquad\text{(Minkowski metric).}
$$

It is non-degenerate, $\det \eta = -1$, so the inverse $\eta_{\mu\nu} =
\operatorname{diag}(-1, 1, 1, 1)$ is also invariant and is the same matrix.

---

## Part II: The bare Galilei algebra → degenerate metrics

### Commutation relations

The bare Galilei algebra has the same generators with two changes from
Poincaré (boxed):

$$
\begin{aligned}
{[J_i, J_j]} &= \epsilon_{ijk} J_k \,, & {[J_i, K_j]} &= \epsilon_{ijk} K_k \,, & \boxed{[K_i, K_j]} &= 0 \,, \\
{[J_i, H]} &= 0 \,, & {[J_i, P^j]} &= \epsilon_{ijk} P^k \,, \\
{[K_i, H]} &= P^i \,, & \boxed{[K_i, P^j]} &= 0 \,, \\
{[P^i, P^j]} &= 0 \,, & {[P^i, H]} &= 0 \,.
\end{aligned}
$$

The two differences — $[K_i, K_j] = 0$ and $[K_i, P^j] = 0$ — are what change
Minkowski into the Galilean structure.

### Temporal metric (bilinear form on $V$)

Apply the Leibniz condition with $X = K_i$:

**$(\mu, \nu) = (0, 0)$**:

$$
g([K_i, H], H) + g(H, [K_i, H]) = 2\, \eta^{i0} = 0
\quad\Longrightarrow\quad \eta^{i0} = 0 \,.
$$

**$(\mu, \nu) = (0, j)$**:

$$
g([K_i, H], P^j) + g(H, [K_i, P^j]) = g(P^i, P^j) + g(H, 0)
= \eta^{ij} = 0 \,.
$$

The spatial block is killed.

**$(\mu, \nu) = (j, k)$**: $\;0 + 0 = 0$ (automatic).

Only $\eta^{00}$ survives. Rotations leave it untouched. Setting $\eta^{00}
= 1$:

$$
\boxed{\;
\eta^{\mu\nu} = \operatorname{diag}(1, 0, 0, 0)
\;}
\qquad\text{(temporal metric, degenerate).}
$$

This is the spacetime interval $\Delta s^2 = (\Delta t)^2$: **absolute
time**.

### Spatial metric (symmetric 2-tensor on $V$)

The temporal metric is degenerate ($\det = 0$), so it has no inverse. But
the Galilei algebra admits a second, independent invariant: a symmetric
contravariant 2-tensor

$$
\xi = \xi^{\mu\nu}\, P^\mu \otimes P^\nu \in V \otimes V \,.
$$

The Leibniz condition for $\xi$ is derived exactly as before. The group
element $U = \exp(\theta X)$ acts on $V \otimes V$ on both factors:

$$
U \xi\, U^{-1}
= \xi^{\mu\nu}\, (U P^\mu U^{-1}) \otimes (U P^\nu U^{-1}) \,.
$$

Invariance $U \xi U^{-1} = \xi$ for all $\theta$, differentiated at $\theta =
0$, gives

$$
\boxed{\;
\xi^{\mu\nu}\, \Big( [X, P^\mu] \otimes P^\nu + P^\mu \otimes [X, P^\nu] \Big) = 0
\;}
$$

for every generator $X \in \{J_i, K_i\}$. This is the Leibniz condition on a
*contravariant* tensor — note that the same rule applies, but now contracted
*against* $\xi^{\mu\nu}$ rather than evaluating $g$ on $P^\mu, P^\nu$.

Reading off coefficients of the basis $P^\alpha \otimes P^\beta$ with $[X,
P^\mu] = L^\rho{}_\mu\, P^\rho$:

$$
L^\alpha{}_\mu\, \xi^{\mu\beta} + L^\beta{}_\nu\, \xi^{\alpha\nu} = 0 \,.
$$

For Galilei $K_i$, the only nonzero commutator is $[K_i, H] = P^i$, i.e.
$L^\rho{}_0 = \delta^\rho_i$. The invariance condition reduces to

$$
\delta^\alpha_i\, \xi^{0\beta} + \delta^\beta_i\, \xi^{\alpha 0} = 0
\qquad \text{for every } \alpha, \beta \,.
$$

Choosing $\alpha = i$, free $\beta$: $\xi^{0\beta} = 0$. Choosing $\beta = i$,
free $\alpha$: $\xi^{\alpha 0} = 0$. Together: **the entire time row and
column of $\xi$ vanish**.

The remaining spatial block $\xi^{ij}$ is rotation-invariant only if
proportional to $\delta^{ij}$. Setting the proportionality to $1$:

$$
\boxed{\;
\xi^{\mu\nu} = \operatorname{diag}(0, 1, 1, 1)
\;}
\qquad\text{(spatial metric, degenerate).}
$$

This is the Euclidean 3-metric on each slice of simultaneity.

### Why two metrics for Galilei?

The two invariants live in different spaces:

$$
\eta \in V^* \otimes V^* \qquad \text{(bilinear form on translations)},
$$
$$
\xi \in V \otimes V \qquad \text{(contravariant 2-tensor on translations)}.
$$

Both are degenerate, so neither is the inverse of the other:

$$
\eta^{\mu\rho}\, \xi^{\rho\nu} = \operatorname{diag}(1, 0, 0, 0)
\cdot \operatorname{diag}(0, 1, 1, 1) = 0 \,.
$$

For Poincaré the corresponding $V^* \otimes V^*$ and $V \otimes V$ forms are
**both** non-degenerate Minkowski — and they are mutual inverses, so the
distinction collapses to a single metric.

That **no** non-degenerate $\eta$ exists for Galilei is visible directly from
the calculation: the boost condition $\eta^{ij} = 0$ forces the entire
spatial block to vanish, leaving $\det \eta = 0$.

---

## Part III: Euclidean spaces — $\mathbb{R}^2$ and $\mathbb{R}^3$

The Poincaré and Galilei algebras are only two members of a much larger
family. The Lie algebras $\mathfrak{e}(n)$ of Euclidean isometries — and
the Lie algebras $\mathfrak{so}(n+1)$ of spherical isometries — admit the
same Klein-pair + Leibniz-invariance analysis, and produce the standard
Euclidean and spherical metrics. We work them out in 2 and 3 dimensions
to show how generic the construction is.

### Two-dimensional Euclidean space $\mathbb{R}^2$

The Euclidean algebra $\mathfrak{e}(2) = \mathfrak{so}(2) \ltimes
\mathbb{R}^2$ has three generators $\{J, P^1, P^2\}$, with

$$
[J, P^1] = P^2, \qquad [J, P^2] = -P^1, \qquad [P^1, P^2] = 0.
$$

**Klein-pair candidates.** The proper subalgebras of $\mathfrak{e}(2)$,
up to conjugacy, are:

- $\{0\}$: $G/H$ is the whole 3-dim group manifold $E(2)$.
- $\{J\}$: 1-dim, generated by a rotation. Gives $\dim G/H = 2$.
- $\{aP^1 + bP^2\}$ for $(a, b) \neq 0$: 1-dim, generated by a translation.
  All such are conjugate under rotation. Gives $\dim G/H = 2$.
- $\{P^1, P^2\}$: 2-dim abelian (and an ideal). Gives $\dim G/H = 1$,
  the circle $S^1 \cong SO(2)$ of orientations.

Of these, the choice that gives "the standard $\mathbb{R}^2$ of points" is
$\mathfrak{h} = \{J\}$. The operational reason is the orbit–stabilizer
analysis of *which transformations fix a point*: translations $P^1, P^2$
move points to other points, while a rotation $J$ centered on the point
itself leaves the point fixed. So $\mathfrak{h} = \{J\}$,
$\mathfrak{m} = \{P^1, P^2\}$, and

$$
\mathbb{R}^2 = E(2)/SO(2).
$$

**Metric derivation.** Define the symmetric bilinear form $g(P^i, P^j) =
\eta^{ij}$ on $\mathfrak{m}$. Three independent components: $\eta^{11},
\eta^{22}, \eta^{12}$. The Leibniz condition is imposed for every $X
\in \mathfrak{h}$; here only $X = J$:

$$
g([J, P^i], P^j) + g(P^i, [J, P^j]) = 0.
$$

Plugging in the brackets:

- $i = j = 1$: $g(P^2, P^1) + g(P^1, P^2) = 2 \eta^{12} = 0$
  $\Rightarrow \eta^{12} = 0$.
- $i = 1, j = 2$: $g(P^2, P^2) + g(P^1, -P^1) = \eta^{22} - \eta^{11} = 0$
  $\Rightarrow \eta^{11} = \eta^{22}$.

Hence $\eta^{ij} = \lambda\, \delta^{ij}$ for an overall positive scale
$\lambda$ (an arbitrary unit of length squared). Choosing $\lambda = 1$:

$$
\boxed{\;\eta^{ij} = \delta^{ij} = \operatorname{diag}(1, 1)\;}
$$

This is the standard Euclidean metric on $\mathbb{R}^2$. Because
$\mathfrak{m}$ is an abelian ideal, the exponential map gives a global
diffeomorphism $\mathfrak{m} \to \mathbb{R}^2$, and $\eta^{ij}$ on
$\mathfrak{m}$ becomes $ds^2 = (dx^1)^2 + (dx^2)^2$ on $\mathbb{R}^2$.

**Translating to polar coordinates.** Polar coordinates make the same
point that was sharper on $S^2$: the *coordinate* form of the metric
depends on the chart, while the underlying bilinear form does not. We
run the five-step Maurer–Cartan procedure used for $S^2$, now on
$\mathfrak{e}(2)$ instead of $\mathfrak{so}(3)$. The output is the
familiar polar-coordinate metric of flat $\mathbb{R}^2$ — and the
connection $\omega_{\mathfrak{h}}$ comes out flat by direct
calculation, confirming that the space is flat despite the
coordinate-dependent metric components.

*Step 1: Coordinate-defining section.* Pick the basepoint at the origin
and define polar coordinates $(r, \phi)$ algebraically by the section

$$
\sigma(r, \phi) \;=\; e^{\phi J}\, e^{r P^1}.
$$

$P^1$ translates the basepoint by $r$ along the 1-direction (giving
point $(r, 0)$); $J$ then rotates by $\phi$ around the origin (giving
$(r\cos\phi, r\sin\phi)$). These are standard polar coordinates by
construction. The section is regular on $r > 0$; at $r = 0$ the
$\phi$-coordinate is ill-defined, exactly as for the polar chart on
$\mathbb{R}^2$.

*Step 2: Maurer–Cartan form.* Compute
$\sigma^{-1}\, d\sigma = \omega_r\, dr + \omega_\phi\, d\phi$.

$\partial_r \sigma = e^{\phi J} P^1 e^{r P^1}$ gives, after multiplying
on the left by $\sigma^{-1}$,

$$
\omega_r \;=\; e^{-r P^1} P^1 e^{r P^1} \;=\; P^1
$$

(since $[P^1, P^1] = 0$). Next, $\partial_\phi \sigma = J\, \sigma$
gives

$$
\omega_\phi \;=\; \sigma^{-1} J\, \sigma
\;=\; e^{-r P^1}\, J\, e^{r P^1}
\;=\; \mathrm{Ad}_{e^{-r P^1}}\, J.
$$

The Lie-algebra calculation:
$[-rP^1,\, J] = r\,[J, P^1] = r P^2$; the next bracket
$[-rP^1,\, r P^2] = -r^2 [P^1, P^2] = 0$ closes the series. Hence

$$
\omega_\phi \;=\; J + r\, P^2.
$$

*Step 3: Read off the vielbein.* With $\mathfrak{m} = \{P^1, P^2\}$ and
$\mathfrak{h} = \{J\}$, split $\omega = e + \omega_{\mathfrak{h}}$:

$$
\begin{aligned}
e_r &= P^1,        & e_\phi &= r\, P^2, \\
\omega_{\mathfrak{h},\, r} &= 0,  & \omega_{\mathfrak{h},\, \phi} &= J.
\end{aligned}
$$

Reading off vielbein components $e_\mu = e^a{}_\mu\, P_a$:

$$
e^1{}_r = 1, \quad e^2{}_r = 0, \qquad
e^1{}_\phi = 0, \quad e^2{}_\phi = r,
$$

equivalently the coframe

$$
e^1 \;=\; dr, \qquad e^2 \;=\; r\, d\phi.
$$

*Step 4: Killing vector fields.* Using $Y_\xi^\mu = (e^{-1})^\mu{}_a\,
[\mathrm{Ad}_{\sigma^{-1}}\xi]^a$, i.e. $\dot r =$ ($P^1$-coefficient of
$\sigma^{-1} \xi\, \sigma$) and $\dot\phi =$ ($P^2$-coefficient) $/\, r$:

- $\xi = J$: $\sigma^{-1} J\, \sigma = J + r P^2$ (computed above), so
  $\dot r = 0$, $\dot\phi = 1$, giving $J = \partial_\phi$ as expected.
- $\xi = P^1$: $\sigma^{-1} P^1 \sigma = \mathrm{Ad}_{e^{-\phi J}}\, P^1
  = \cos\phi\, P^1 - \sin\phi\, P^2$ (rotation by $-\phi$ in the
  $(P^1, P^2)$-plane, since $\mathrm{ad}_J$ acts on $\{P^1, P^2\}$ as a
  90° rotation), giving

  $$
  P^1 \;=\; \cos\phi\, \partial_r - \frac{\sin\phi}{r}\, \partial_\phi.
  $$

- $\xi = P^2$: similarly $\sigma^{-1} P^2 \sigma = \sin\phi\, P^1 +
  \cos\phi\, P^2$, giving

  $$
  P^2 \;=\; \sin\phi\, \partial_r + \frac{\cos\phi}{r}\, \partial_\phi.
  $$

These are the standard polar-coordinate expressions for the Cartesian
translation Killing fields $\partial_x, \partial_y$.

*Step 5: The metric in coordinates.* The bridge from form on $\mathfrak{m}$
to tensor field on $\mathbb{R}^2$ is identical to Step 5a of the $S^2$
case: $g = \lambda\, \delta_{ab}\, e^a \otimes e^b$. Expanding,

$$
g \;=\; \lambda\bigl[(e^1)^2 + (e^2)^2\bigr]
\;=\; \lambda\bigl[(dr)^2 + (r\, d\phi)^2\bigr]
\;=\; \lambda\,\bigl(dr^2 + r^2\, d\phi^2\bigr).
$$

Choosing the conventional unit $\lambda = 1$:

$$
\boxed{\;ds^2 \;=\; dr^2 + r^2\, d\phi^2.\;}
$$

This is the **flat Euclidean metric** of $\mathbb{R}^2$, written in polar
coordinates. The coordinate components $g_{\mu\nu} = \operatorname{diag}(1, r^2)$
*do* depend on $r$, even though the space is flat — the $r^2$ is the
squared length of $\partial_\phi$ at radius $r$, in exact analogy with
the $\sin^2\theta$ of $S^2$.

**Why this is flat — verified at the algebra level.** The Cartan
curvature 2-form of the connection $\omega_{\mathfrak{h}}$ on the model
space is

$$
\Omega \;=\; d\omega_{\mathfrak{h}} + \tfrac{1}{2}[\omega_{\mathfrak{h}},\, \omega_{\mathfrak{h}}].
$$

Here $\omega_{\mathfrak{h}} = J\, d\phi$, so $d\omega_{\mathfrak{h}} =
dJ \wedge d\phi = 0$ (since $J$ is a constant element of the algebra),
and $[\omega_{\mathfrak{h}}, \omega_{\mathfrak{h}}] = [J, J]\, d\phi
\wedge d\phi = 0$ trivially. Hence

$$
\Omega \;=\; 0,
$$

i.e., zero sectional curvature everywhere. By contrast, on $S^2$ one
gets $\omega_{\mathfrak{h}} = \cos\theta\, J^3\, d\phi$, whose exterior
derivative $-\sin\theta\, J^3\, d\theta \wedge d\phi$ is non-zero —
precisely the constant positive curvature $1/R^2$.

So the polar-coordinate $\mathbb{R}^2$ exhibits the moral lesson
sharply: the coordinate components of the metric vary, but the
*curvature* (read off the connection 1-form, an algebraic Lie-algebra
object) vanishes. The bracket-level distinction $[\mathfrak{m},
\mathfrak{m}] = 0$ is doing exactly the work that makes flat space flat.

#### Cartesian derivation: $\sigma = \exp(x P^1 + y P^2)$

The derivation above was the *traditional* one — it used a section
$\sigma = e^{\phi J}\, e^{r P^1}$ with the rotation generator $J$
inside (as a "fiber direction") and a translation generator radially.
The same machinery accepts another natural choice: skip the rotation
entirely and use only the translations,

$$
\sigma(x, y) \;=\; \exp(x\, P^1 + y\, P^2).
$$

Geometrically, this is a *single* translation by the vector
$(x, y)$ from the basepoint. Because $[P^1, P^2] = 0$, this is the
same as $e^{xP^1}\, e^{yP^2}$ in either order — the two translations
commute, so no Baker–Campbell–Hausdorff correction arises. Let us run
the four-step algorithm with this section.

##### Step 1 — structure constants

The Klein pair is unchanged: $\mathfrak{h} = \mathrm{span}(J)$,
$\mathfrak{m} = \mathrm{span}(P^1, P^2)$. The non-zero brackets are

$$
[J, P^1] = P^2, \qquad [J, P^2] = -P^1.
$$

The crucial novelty is the $\mathfrak{m}$–$\mathfrak{m}$ bracket:
$[P^1, P^2] = 0$. We will see exactly what this triviality does to the
algorithm.

##### Step 2 — Maurer–Cartan form

We need $\omega = \sigma^{-1}\, d\sigma$. Use the standard
$3 \times 3$ affine representation of $\mathfrak{e}(2)$:

$$
P^1 = \begin{pmatrix} 0 & 0 & 1 \\ 0 & 0 & 0 \\ 0 & 0 & 0 \end{pmatrix}, \quad
P^2 = \begin{pmatrix} 0 & 0 & 0 \\ 0 & 0 & 1 \\ 0 & 0 & 0 \end{pmatrix}, \quad
J = \begin{pmatrix} 0 & -1 & 0 \\ 1 & 0 & 0 \\ 0 & 0 & 0 \end{pmatrix}.
$$

The Lie-algebra element $V := x P^1 + y P^2$ has $V^2 = 0$ in this
representation (both translation matrices are strictly upper-triangular
and their product vanishes). So the exponential series terminates
after one term:

$$
\sigma(x, y) \;=\; \exp(V) \;=\; I + V \;=\;
\begin{pmatrix} 1 & 0 & x \\ 0 & 1 & y \\ 0 & 0 & 1 \end{pmatrix}.
$$

This is just the affine matrix for translation by $(x, y)$ — as
expected. The inverse:

$$
\sigma^{-1} \;=\;
\begin{pmatrix} 1 & 0 & -x \\ 0 & 1 & -y \\ 0 & 0 & 1 \end{pmatrix},
\qquad
d\sigma \;=\;
\begin{pmatrix} 0 & 0 & dx \\ 0 & 0 & dy \\ 0 & 0 & 0 \end{pmatrix}.
$$

The bottom row of $d\sigma$ is zero, so the matrix product
$\sigma^{-1}\, d\sigma$ leaves the upper-right column $(dx, dy)^T$
untouched:

$$
\boxed{\;
\omega \;=\; \sigma^{-1}\, d\sigma \;=\;
\begin{pmatrix} 0 & 0 & dx \\ 0 & 0 & dy \\ 0 & 0 & 0 \end{pmatrix}
\;=\; P^1\, dx + P^2\, dy.
\;}
$$

Decomposed into the $\mathfrak{m}$- and $\mathfrak{h}$-parts
$\omega = e^a X_a + \omega_{\mathfrak{h}}$:

$$
e^1 \;=\; dx, \qquad e^2 \;=\; dy, \qquad
\omega_{\mathfrak{h}} \;=\; 0.
$$

The **vielbein is the identity matrix**: $e^a{}_\mu = \delta^a_\mu$.
The **spin connection vanishes identically**. Both consequences trace
back to $[P^1, P^2] = 0$ — the BCH formula contributes no nonlinear
correction, and the rotation generator $J$ never appears in $\omega$.

##### Step 3 — invariance equation

The invariance equation is the *same one we solved in the polar
derivation*. With $\mathrm{ad}_J|_{\mathfrak{m}}$ a $90°$ rotation in
the $(P^1, P^2)$-plane, the symmetric matrix $\eta$ satisfying $\eta\,
\mathrm{ad}_J + (\mathrm{ad}_J)^T\, \eta = 0$ is

$$
\eta \;=\; \lambda\, I_{2 \times 2}, \qquad \lambda > 0.
$$

A single positive scale parameter — the same answer as before. The
invariance condition is a property of the $(\mathfrak{g},
\mathfrak{h})$ Klein pair and does not depend on which section was
chosen.

##### Step 4 — assemble the metric

$g = \eta_{ab}\, e^a \otimes e^b = \lambda\, ((e^1)^2 + (e^2)^2)$ with
$e^1 = dx$, $e^2 = dy$:

$$
\boxed{\;ds^2 \;=\; \lambda\, (dx^2 + dy^2).\;}
$$

Setting $\lambda = 1$ for the standard normalization, we recover the
Cartesian metric of $\mathbb{R}^2$ in the most direct possible way.
The intrinsic geometry is identical to the polar result
$ds^2 = dr^2 + r^2\, d\phi^2$ — it is the same flat metric in
different coordinates — but the coordinate components are now
*constants* instead of being $r$-dependent.

##### Why this works globally

Three structural features make Cartesian coordinates better-behaved
than polar in this example:

- **Single-step exponential.** $\sigma(x, y) = \exp(xP^1 + yP^2)$ is
  well-defined for all $(x, y) \in \mathbb{R}^2$, with no coordinate
  singularity (compare polar: $r = 0$ is a singularity).
- **Identity vielbein.** $\det e^a{}_\mu = 1 \neq 0$ everywhere. No
  point is excluded from the chart.
- **Vanishing spin connection.** $\omega_{\mathfrak{h}} \equiv 0$
  globally on the chart, so no curvature term is even present.

All three are consequences of one algebraic fact: $[\mathfrak{m},
\mathfrak{m}] = 0$. The translations commute, so the BCH formula
reduces to the linear sum, no $\mathfrak{h}$-generator can appear in
$\sigma^{-1} d\sigma$, and the exponential map $\mathbb{R}^2 \to G/H$
is a global diffeomorphism. This is the algebraic signature of
*flatness with a globally trivial chart*. We will see in the next
subsection that the same condition $[\mathfrak{m}, \mathfrak{m}] = 0$
is also what makes the **position vector** globally well-defined on
$\mathbb{R}^2$.

##### Killing vector fields

The three Killing fields generated by $\xi \in \{P^1, P^2, J\}$ acting
on the section. Using $Y_\xi^\mu = (e^{-1})^\mu{}_a\,
(\mathrm{Ad}_{\sigma^{-1}} \xi)^a|_{\mathfrak{m}}$ with vielbein the
identity:

- $\xi = P^1$ produces $\partial_x$.
- $\xi = P^2$ produces $\partial_y$.
- $\xi = J$ produces $-y\, \partial_x + x\, \partial_y$.

These are exactly the three Killing fields familiar from elementary
geometry — two translations and a rotation around the origin.

#### Christoffel symbols, frame vectors, and the position vector

Once the metric $ds^2 = dr^2 + r^2\, d\phi^2$ is in hand, everything
familiar from elementary vector calculus in polar coordinates can be
read off it. We give the short version here for completeness, then
turn to the harder question of how to compute the **position vector**
without going through Cartesian coordinates — a question for which the
Klein-geometry section $\sigma$ does exactly the right thing.

##### Curvilinear basis vectors

The coordinate basis vectors are $\partial_r$ and $\partial_\phi$.
Their lengths and inner products come straight from the metric:

$$
|\partial_r|^2 = g_{rr} = 1, \qquad
|\partial_\phi|^2 = g_{\phi\phi} = r^2, \qquad
\langle \partial_r, \partial_\phi \rangle = g_{r\phi} = 0.
$$

So $\partial_r$ is already a unit vector, while $\partial_\phi$ has
length $r$. The **unit (orthonormal) frame vectors** are obtained by
normalizing:

$$
\hat r \;=\; \partial_r, \qquad \hat\phi \;=\; \frac{1}{r}\,\partial_\phi.
$$

This is exactly the orthonormal frame $\vec e_1, \vec e_2$ produced by
the Klein construction: the dual of the coframe $\{e^1 = dr,\; e^2 = r\, d\phi\}$
satisfies $e^a(\vec e_b) = \delta^a_b$, giving

$$
\vec e_1 \;=\; \partial_r \;=\; \hat r, \qquad
\vec e_2 \;=\; \frac{1}{r}\, \partial_\phi \;=\; \hat\phi.
$$

##### How $e^1, e^2$ came from the Maurer–Cartan form

Briefly recapping the polar derivation above so the rest of this
section is self-contained. We chose the section
$\sigma(r, \phi) = e^{\phi J}\, e^{r P^1}$, computed

$$
\omega = \sigma^{-1}\, d\sigma
= P^1\, dr + (J + r\, P^2)\, d\phi,
$$

and split it via $\mathfrak{m} = \mathrm{span}(P^1, P^2)$,
$\mathfrak{h} = \mathrm{span}(J)$. The $\mathfrak{m}$-coefficients are
the vielbein components $e^a{}_\mu$ — i.e., the coefficient of $P^a$
in $\omega_\mu$:

$$
e^1{}_r = 1,\quad e^1{}_\phi = 0,\qquad
e^2{}_r = 0,\quad e^2{}_\phi = r.
$$

Writing $e^a = e^a{}_\mu\, dx^\mu$,

$$
\boxed{\;e^1 \;=\; dr, \qquad e^2 \;=\; r\, d\phi.\;}
$$

##### Christoffel symbols

For $g_{rr} = 1$, $g_{\phi\phi} = r^2$ (others zero), with inverse
$g^{rr} = 1$, $g^{\phi\phi} = 1/r^2$, the formula

$$
\Gamma^\rho_{\mu\nu}
= \tfrac{1}{2}\, g^{\rho\sigma}\bigl(
\partial_\mu g_{\sigma\nu} + \partial_\nu g_{\sigma\mu}
- \partial_\sigma g_{\mu\nu}\bigr)
$$

has only one non-zero metric derivative, $\partial_r g_{\phi\phi} = 2r$.
Direct substitution gives two non-zero connection coefficients:

$$
\boxed{\;
\Gamma^r{}_{\phi\phi} = -r, \qquad
\Gamma^\phi{}_{r\phi} = \Gamma^\phi{}_{\phi r} = \frac{1}{r}.
\;}
$$

All others vanish. (Check: $\Gamma^r{}_{\phi\phi} = -\tfrac{1}{2}\,\partial_r g_{\phi\phi}
= -r$; $\Gamma^\phi{}_{r\phi} = \tfrac{1}{2}\, g^{\phi\phi}\, \partial_r g_{\phi\phi}
= \tfrac{1}{2}\cdot \tfrac{1}{r^2}\cdot 2r = 1/r$.) These reproduce the
familiar coordinate derivatives of polar unit vectors:

$$
\nabla_{\partial_r} \hat\phi = \frac{1}{r}\, \hat\phi, \qquad
\nabla_{\partial_\phi} \hat r = \hat\phi, \qquad
\nabla_{\partial_\phi} \hat\phi = -r\, \hat r,
$$

and the Riemann tensor is identically zero (since $\partial g$ has
only one non-zero term and the second-derivative combinations cancel),
consistent with the algebraic flatness $\Omega = 0$ computed earlier.

##### The position vector — derived without Cartesian coordinates

Now the structural question: in flat space, there is a distinguished
object — the **position vector** $\vec r$ — that points from the
origin to the current point. Its existence depends on the flatness
of the space (translations form an abelian Lie algebra
$\mathfrak{m}$, and the exponential map $\mathfrak{m} \to G/H$ is a
global diffeomorphism). One can also see this from coordinates: in
$\mathbb{R}^2$ the position vector is naturally
$\vec r = x\, \hat x + y\, \hat y$, which uses the *global* Cartesian
chart. The challenge is to compute $\vec r$ at a given polar
coordinate point $(r, \phi)$ from the algebra alone, without
parametrizing through Cartesian.

The Klein-geometry section $\sigma$ gives the answer directly. The
key step is to rewrite $\sigma$ as a translation times a rotation:

$$
\sigma(r, \phi) \;=\; e^{T}\, h,
$$

where $T \in \mathfrak{m}$ is a Lie-algebra translation and $h \in H$
is the residual rotation at the destination point. Once we have $T$,
the position vector is just $T$ identified with a vector in
$\mathfrak{m} \cong T_o(\mathbb{R}^2)$: it is the translation that
moves the origin to the current point.

*The decomposition.* Start from our section
$\sigma = e^{\phi J}\, e^{r P^1}$ and insert the identity factor
$e^{-\phi J}\, e^{\phi J}$ between the two exponentials:

$$
\sigma
\;=\; e^{\phi J}\, e^{r P^1}\, e^{-\phi J}\, e^{\phi J}
\;=\; \bigl(e^{\phi J}\, e^{r P^1}\, e^{-\phi J}\bigr)\, e^{\phi J}
\;=\; e^{r\, \mathrm{Ad}_{e^{\phi J}}(P^1)}\, e^{\phi J},
$$

using the identity $e^{\phi J}\, e^{r P^1}\, e^{-\phi J} =
\exp\bigl(r\, \mathrm{Ad}_{e^{\phi J}}(P^1)\bigr)$ (conjugation acts
on the exponent by the adjoint). The bracket structure on
$\mathfrak{m}$ — $[J, P^1] = P^2$, $[J, P^2] = -P^1$ — gives, by the
same series we used in Step 4 of the polar derivation,

$$
\mathrm{Ad}_{e^{\phi J}}(P^1) \;=\; \cos\phi\, P^1 + \sin\phi\, P^2.
$$

Therefore the section factorizes as

$$
\sigma(r, \phi)
\;=\; e^{\,r\cos\phi\, P^1 \,+\, r\sin\phi\, P^2}\, e^{\phi J},
$$

and we read off

$$
\boxed{\;T(r, \phi) \;=\; (r\cos\phi)\, P^1 \;+\; (r\sin\phi)\, P^2 \;\in\; \mathfrak{m},\;}
\qquad h(r, \phi) = e^{\phi J}.
$$

The vector $T$ *is* the position vector — its components in the
algebraic basis $\{P^1, P^2\}$ of $\mathfrak{m}$ are exactly $(x, y) =
(r\cos\phi, r\sin\phi)$. So Cartesian coordinates have re-emerged as a
purely algebraic byproduct: they are the **components of the position
vector in the algebra basis** of $\mathfrak{m}$. We never had to
invoke an independent Cartesian chart; the Klein structure delivers it
automatically when $\mathfrak{m}$ is abelian.

*Expressing $\vec r$ at the current point.* The above $T$ lives in
$\mathfrak{m}$, naturally an algebra element. To view it as a tangent
vector field on $\mathbb{R}^2$ — as an arrow attached to the current
point $(r, \phi)$ — push it through the translation Killing fields,
whose polar-coordinate expressions we have from Step 4 of the polar
derivation:

$$
\vec{P^1} = \cos\phi\, \partial_r - \frac{\sin\phi}{r}\, \partial_\phi, \qquad
\vec{P^2} = \sin\phi\, \partial_r + \frac{\cos\phi}{r}\, \partial_\phi.
$$

Substituting:

$$
\begin{aligned}
\vec r
&\;=\; (r\cos\phi)\, \vec{P^1} \;+\; (r\sin\phi)\, \vec{P^2} \\
&\;=\; r\cos\phi\, \Bigl(\cos\phi\, \partial_r - \frac{\sin\phi}{r}\, \partial_\phi\Bigr)
 \;+\; r\sin\phi\, \Bigl(\sin\phi\, \partial_r + \frac{\cos\phi}{r}\, \partial_\phi\Bigr) \\
&\;=\; r\,(\cos^2\phi + \sin^2\phi)\, \partial_r
 \;+\; (-\sin\phi\cos\phi + \sin\phi\cos\phi)\, \partial_\phi \\
&\;=\; r\, \partial_r.
\end{aligned}
$$

The $\partial_\phi$ component cancels exactly by the Pythagorean
identity. So in polar coordinates,

$$
\boxed{\;\vec r \;=\; r\, \partial_r \;=\; r\, \vec e_1 \;=\; r\, \hat r.\;}
$$

The familiar elementary result is recovered, but the derivation used
only the algebra (the bracket relations and the section), not
Cartesian coordinates. Two observations close the section:

- **Why polar coordinates make the position vector look so simple.**
  In the local orthonormal frame $\vec e_1 = \hat r$, $\vec e_2 = \hat\phi$
  at the point $(r, \phi)$, the position vector has frame components
  $(r, 0)$ — one non-zero entry. This is because the section
  $\sigma = e^{\phi J}\, e^{r P^1}$ first translates along $P^1$ and
  then rotates: the rotation aligns $\hat e_1$ with the radial
  direction by construction, so the entire displacement $r P^1$ shows
  up in the $\vec e_1$ slot.
- **Why the position vector exists only in flat space.** The
  decomposition $\sigma = e^T h$ relied on the fact that, in
  $\mathfrak{m}$, the translation $e^{r P^1}$ stays a single
  translation under conjugation by the rotation — there is no
  "tilting term" added. Equivalently, $\mathrm{Ad}_h$ sends
  $\mathfrak{m}$ to itself as an honest linear map without picking up
  $\mathfrak{h}$-pieces, *and* $[\mathfrak{m}, \mathfrak{m}] = 0$ so
  the exponential map $\mathfrak{m} \to G/H$ is a diffeomorphism. On
  $S^2$ the second condition fails: $[\mathfrak{m}, \mathfrak{m}] =
  \mathfrak{h}$, so $e^T$ does not exhaust the group, the exponential
  map is only local, and there is no globally well-defined "position
  vector to the basepoint." The position vector is the algebraic
  signature of flatness.

### Three-dimensional Euclidean space $\mathbb{R}^3$

The algebra $\mathfrak{e}(3) = \mathfrak{so}(3) \ltimes \mathbb{R}^3$
has six generators $\{J^i, P^j\}$ ($i, j \in \{1, 2, 3\}$) with

$$
[J^i, J^j] = \epsilon^{ijk} J^k, \qquad
[J^i, P^j] = \epsilon^{ijk} P^k, \qquad
[P^i, P^j] = 0.
$$

**Klein-pair candidates.** The conjugacy classes of subalgebras include:

- $\mathfrak{so}(3) = \{J^i\}$: gives $\dim G/H = 3$, the standard
  $\mathbb{R}^3$.
- $\mathbb{R}^3 = \{P^i\}$: an abelian ideal, gives $\dim G/H = 3$, the
  *space of rotations* $SO(3) \cong \mathbb{RP}^3$.
- $\mathfrak{so}(2) = \{J^3\}$: 1-dim, gives $\dim G/H = 5$.
- $\{J^3, P^3\}$: 2-dim, the "screw axis" subgroup; gives $\dim G/H = 4$.
- And several others.

The standard $\mathbb{R}^3$ comes from $\mathfrak{h} = \mathfrak{so}(3)$
by the same orbit–stabilizer argument: a point is moved by translations
$P^i$ and fixed by rotations $J^i$ centered on it. So
$\mathfrak{m} = \{P^1, P^2, P^3\}$ and

$$
\mathbb{R}^3 = E(3)/SO(3).
$$

**Metric derivation.** Set $g(P^i, P^j) = \eta^{ij}$, a symmetric $3
\times 3$ matrix (6 unknowns). The Leibniz condition with $X = J^k$ is

$$
g(\epsilon^{kil} P^l, P^j) + g(P^i, \epsilon^{kjl} P^l) = 0
\quad\Longleftrightarrow\quad
\epsilon^{kil} \eta^{lj} + \epsilon^{kjl} \eta^{il} = 0.
$$

Picking $k = 3$ and running through the off-diagonal/diagonal pairings as
in the 2D case forces $\eta^{12} = \eta^{13} = \eta^{23} = 0$ and
$\eta^{11} = \eta^{22}$; then $k = 1$ gives $\eta^{22} = \eta^{33}$.
Hence

$$
\boxed{\;\eta^{ij} = \delta^{ij} = \operatorname{diag}(1, 1, 1)\;}
$$

the standard 3D Euclidean metric. By the same reasoning as in 2D, the
abelian-ideal structure of $\mathfrak{m}$ makes $\mathbb{R}^3$ flat with
global coordinates $a^i$, and $\eta^{ij}$ becomes $ds^2 = \delta_{ij}\,
dx^i\, dx^j$.

#### All Klein-pair candidates for $\mathfrak{e}(3)$

The four candidates listed above are illustrative, not exhaustive. Here we
enumerate the *complete* classification of proper subalgebras
$\mathfrak{h} \subset \mathfrak{e}(3)$ up to $E(3)$-conjugacy, compute the
metric in each reductive case, and show with equations that the orbit–
stabilizer argument singles out $\mathbb{R}^3 = E(3)/SO(3)$ as the unique
"space of points".

**Notion of conjugacy.** We classify subalgebras up to the adjoint action of
$E(3)$ itself: two subalgebras are equivalent if one is obtained from the
other by rotating axes (conjugation by $SO(3)$) and/or shifting the origin
(conjugation by translation). This freedom lets us always orient a
distinguished axis along $\hat z$ and place rotation centers at the origin.

**Full classification.** Working through bracket closure, the
$E(3)$-conjugacy classes of proper non-trivial subalgebras are:

| $\dim\mathfrak{h}$ | $\mathfrak{h}$ | Reductive? | $\eta$ family on $\mathfrak{m}$ | Non-deg? | $\dim G/H$ | Geometric meaning |
|---|---|---|---|---|---|---|
| 0 | $\{0\}$ | yes (trivial) | 21 params (left-inv) | yes | 6 | group manifold $E(3) \cong \mathbb{R}^3 \times SO(3)$ |
| 1 | $\langle P^3 \rangle$ | yes | 7 | **no** | 5 | frames mod $z$-translation |
| 1 | $\langle J^3 \rangle$ | yes | 5 | **yes** | 5 | $\mathbb{R}^3 \times S^2$ (point + direction) |
| 1 | $\langle J^3 + a P^3 \rangle$, $a > 0$ | yes | 3 | no | 5 | frames mod screw of pitch $a$ |
| 2 | $\langle P^1, P^2 \rangle$ | **no** | — | — | 4 | (no reductive metric) |
| 2 | $\langle J^3, P^3 \rangle$ | yes | 2 | no | 4 | space of oriented lines in $\mathbb{R}^3$ |
| 3 | $\mathfrak{so}(3) = \langle J^i \rangle$ | yes | **1** | **yes** | 3 | $\mathbb{R}^3$, **space of points** ★ |
| 3 | $\mathfrak{t} = \langle P^i \rangle$ | **no** | — | — | 3 | $SO(3)$ as coset space (no Leibniz metric) |
| 3 | $\mathfrak{e}(2) = \langle J^3, P^1, P^2 \rangle$ | yes | 1 | no | 3 | space of oriented 2-planes ($\mathbb{R} \times S^2$) |
| 3 | screw-$\mathfrak{e}(2)$, $a > 0$ | **no** | — | — | 3 | (no reductive metric) |
| 4 | $\langle J^3, P^1, P^2, P^3 \rangle$ | **no** | — | — | 2 | $S^2$ (directions in $\mathbb{R}^3$) |

There are no 5-dim proper subalgebras: any 5-dim $\mathfrak{h}$ would require
either $\mathfrak{h} \supset \mathfrak{t}$ with $\dim \pi_\mathfrak{r}(\mathfrak{h}) = 2$
(but $\mathfrak{so}(3)$ has no 2-dim subalgebra), or a Lie-section
$\sigma: \mathfrak{so}(3) \hookrightarrow \mathfrak{e}(3)$ with image disjoint
from $\mathfrak{t}$ except along one direction — which one can check has no
solution.

**Reductivity.** Each case is checked by computing $[\mathfrak{h}, \mathfrak{m}]$
for the natural complement $\mathfrak{m}$. The four non-reductive cases fail
because some bracket lands back in $\mathfrak{h}$:

- $\mathfrak{t}$: $[P^i, J^j] = -\epsilon^{ijk}P^k \in \mathfrak{h}$.
- $\langle P^1, P^2 \rangle$: $[P^1, J^3] = -P^2 \in \mathfrak{h}$.
- screw-$\mathfrak{e}(2)$ with $a > 0$: any candidate complement fails the
  closure constraint (worked out below).
- $\langle J^3, P^1, P^2, P^3 \rangle$: $[P^i, J^j]$ for $i,j \in \{1,2\}$ lies
  inside $\mathfrak{h}$.

For these, the Leibniz algorithm does not produce a $G$-invariant metric on
$G/H$ — although the coset space itself still makes sense as a manifold.

**Metric for each reductive case.** Solving
$\eta\,\mathrm{ad}_Z + (\mathrm{ad}_Z)^T \eta = 0$ for each $Z \in \mathfrak{h}$
on the chosen $\mathfrak{m}$ (these are short computations, easily verified by
a SymPy script analogous to the one above; results stated in basis order):

- *$\mathfrak{h} = \mathfrak{so}(3)$*, $\mathfrak{m} = \langle P^1, P^2, P^3 \rangle$:
  $\eta^{ij} = \alpha\, \delta^{ij}$. **1 parameter, non-degenerate**. The
  $\mathbb{R}^3$ Euclidean metric.

- *$\mathfrak{h} = \langle J^3 \rangle$*, $\mathfrak{m} = \langle J^1, J^2, P^1, P^2, P^3 \rangle$:
  invariance under $\mathrm{ad}_{J^3}$ (90° rotation in both $(J^1,J^2)$ and
  $(P^1,P^2)$ planes) leaves 5 free parameters:
  $\eta(J^1, J^1) = \eta(J^2, J^2) = \alpha$,
  $\eta(P^1, P^1) = \eta(P^2, P^2) = \beta$,
  $\eta(P^3, P^3) = \gamma$,
  $\eta(J^1, P^1) = \eta(J^2, P^2) = \mu$,
  $\eta(J^2, P^1) = -\eta(J^1, P^2) = \nu$.
  **Non-degenerate** for generic $\alpha, \beta, \gamma$ (with $\mu = \nu = 0$
  giving the most natural choice).

- *$\mathfrak{h} = \langle J^3, P^3 \rangle$*, $\mathfrak{m} = \langle J^1, J^2, P^1, P^2 \rangle$:
  invariance under both $J^3$ and $P^3$ gives 2 parameters
  $\eta(J^a, J^b) = \alpha\, \delta^{ab}$, $\eta(J^a, P^b) = \mu\, \delta^{ab}$,
  but $\eta(P^a, P^b) = 0$. **Degenerate** (translation block vanishes).

- *$\mathfrak{h} = \mathfrak{e}(2)$*, $\mathfrak{m} = \langle J^1, J^2, P^3 \rangle$:
  1 parameter $\eta = \alpha\, \mathrm{diag}(1, 1, 0)$. **Degenerate** on $P^3$.

- *$\mathfrak{h} = \langle P^3 \rangle$*, $\mathfrak{m} = \langle J^1, J^2, J^3, P^1, P^2 \rangle$:
  7-parameter family, but the entire $(P^1, P^2)$-block is forced to zero by
  $\mathrm{ad}_{P^3}(J^a) = \pm P^b$. **Degenerate**.

- *$\mathfrak{h} = \langle J^3 + a P^3 \rangle$ with $a > 0$*: 3 parameters; the
  extra $aP^3$ contribution gives the constraint $a\, \eta(P^b, P^b) = 0$, so
  the translation block dies for any $a \neq 0$. **Degenerate**.

- *$\mathfrak{h} = \{0\}$*: Leibniz is vacuous; any inner product on the 6-dim
  $\mathfrak{e}(3)$ defines a *left-invariant* Riemannian metric on $E(3)$.
  Requiring full *bi-invariance* (ad-invariance under all of $\mathfrak{e}(3)$,
  in particular under translations) gives the constraint
  $\eta(P^a, P^b) = 0$ — so the only bi-invariant form on $E(3)$ is degenerate.
  Thus $E(3)$ admits many left-invariant Riemannian metrics, but no bi-invariant
  Riemannian one.

**The non-degeneracy pattern.** Three of the eight reductive cases give a
non-degenerate metric: $\mathfrak{h} = \{0\}$, $\langle J^3 \rangle$, and
$\mathfrak{so}(3)$. These are *exactly* the cases with
$\mathfrak{h} \subset \mathfrak{r}$ (no translations in $\mathfrak{h}$).

This is not coincidence. Take any $P \in \mathfrak{h} \cap \mathfrak{t}$ and
any $J \in \mathfrak{m}$ with non-zero rotation part. Applying the Leibniz
condition with $X = P$, $Y = J$, $Z = P'$ for any translation $P' \in \mathfrak{m}$:

$$
\eta([P, J], P') + \eta(J, \underbrace{[P, P']}_{=0}) = 0,
$$

so $\eta([P, J], P') = 0$. As $J$ ranges over rotations in $\mathfrak{m}$, the
bracket $[P, J] = -\epsilon\, P^k$ spans the translation directions in
$\mathfrak{m}$, forcing $\eta(P^k, P') = 0$ for *all* translations in
$\mathfrak{m}$. The translation block dies. So:

> *A non-degenerate $G$-invariant Riemannian metric on $G/H$ exists only when
> $\mathfrak{h}$ contains no translations.*

This narrows the candidates to $\{0\}$, $\langle J^3 \rangle$, and
$\mathfrak{so}(3)$.

**Singling out $\mathbb{R}^3 = E(3)/SO(3)$.** Among these three non-degenerate
candidates:

- $\mathfrak{h} = \{0\}$ gives the 6-dim group manifold $E(3)$ — the bundle of
  orthonormal frames, *not* the underlying space of points.
- $\mathfrak{h} = \langle J^3 \rangle$ gives a 5-dim space parameterizing
  (point, unit vector) pairs $\cong \mathbb{R}^3 \times S^2$ — point plus
  attached direction, not just a point.
- $\mathfrak{h} = \mathfrak{so}(3)$ gives the 3-dim space of *points* $\mathbb{R}^3$. ★

The third is picked out by the **orbit–stabilizer correspondence**:

> *The space of points* is the homogeneous space whose elements are moved
> simply-transitively by translations alone, with rotations playing the role
> of the stabilizer at each point.

Concretely, fix the origin $\vec 0 \in \mathbb{R}^3$. An element
$(R, \vec a) \in E(3)$ (rotation $R$ followed by translation $\vec a$) acts on
$\vec 0$ as
$$
(R, \vec a) \cdot \vec 0 = R \vec 0 + \vec a = \vec a.
$$
The stabilizer of $\vec 0$ is
$$
\mathrm{Stab}(\vec 0) = \{(R, \vec a) : R \vec 0 + \vec a = \vec 0\}
                     = \{(R, \vec 0) : R \in SO(3)\}
                     = SO(3).
$$
At the Lie-algebra level: rotations centered at the origin fix $\vec 0$
($J^i \cdot \vec 0 = \vec 0$), while translations move it
($P^j \cdot \vec 0 = \hat e_j \neq \vec 0$). So the stabilizer subalgebra is

$$
\boxed{\;\mathfrak{h} = \langle J^1, J^2, J^3 \rangle = \mathfrak{so}(3)\;}
$$

and translations $P^j \in \mathfrak{m}$ act simply transitively on points
(any two points related by a unique translation). The orbit–stabilizer
theorem gives

$$
\boxed{\;\mathbb{R}^3 \;=\; E(3) \cdot \vec 0 \;\cong\; E(3) / SO(3).\;}
$$

The Leibniz invariance condition with $\mathfrak{h} = \mathfrak{so}(3)$ then
uniquely (up to scale) selects $\eta^{ij} = \delta^{ij}$, and the flat
coordinates $\vec a$ on $\mathfrak{m} = \mathfrak{t}$ give the global
$ds^2 = (dx^1)^2 + (dx^2)^2 + (dx^3)^2$.

**What translations alone give vs. what rotations add.** A natural question
is: translations *by themselves* already act transitively on $\mathbb{R}^3$
— any point reaches any other by a unique translation, and the stabilizer
is trivial. So why is the full Euclidean group $E(3)$ needed at all? What
do the rotations contribute?

Concretely, take just the abelian translation group $G = T^3$ with Klein pair
$(\mathfrak{t}, \{0\})$: $\mathfrak{m} = \mathfrak{t}$ and $\mathfrak{h} = \{0\}$.
Topologically this still gives $T^3 / \{0\} = \mathbb{R}^3$ — the manifold is
the same. But the Leibniz invariance condition

$$
\sum_{X \in \mathfrak{h}}\bigl(\eta\,\mathrm{ad}_X + (\mathrm{ad}_X)^T\,\eta\bigr) = 0
$$

becomes **vacuous** when $\mathfrak{h} = \{0\}$, so *every* symmetric $3 \times 3$
matrix $\eta^{ij}$ is allowed — a **6-parameter** family of translation-invariant
constant metrics. Concrete examples all satisfying translation-invariance:

| $\eta^{ij}$ | geometry |
|---|---|
| $\delta^{ij}$ | standard flat Euclidean |
| $\operatorname{diag}(1, 1, -1)$ | (2+1)-Minkowski-like indefinite form |
| $\operatorname{diag}(1, 4, 9)$ | anisotropic / axis-scaled |
| any symmetric $\eta$ | some constant-metric "geometry" |

Translation-invariance alone forces the metric to be **constant** across
$\mathbb{R}^3$, but says nothing about its **shape**. Adding $\mathfrak{so}(3)$
to $\mathfrak{h}$ imposes the additional Leibniz constraints
$\epsilon^{kil}\eta^{lj} + \epsilon^{kjl}\eta^{il} = 0$, which collapse the
6-parameter family to a **1-parameter** family $\eta = \alpha\,\delta^{ij}$ —
unique up to overall scale.

So rotations contribute not transitivity but *shape-fixing*:

1. **Isotropy** — all directions become equivalent (no axis is preferred).
2. **Uniqueness of metric** (up to scale) — $\delta^{ij}$ is the only $\eta$
   the rotations preserve.
3. **Orthonormal frames** — at each point, rotations distinguish orthonormal
   bases from skewed ones.

In Erlangen-program language: $T^3$ alone gives a flat **affine** space
(parallelism and straight lines, but no canonical distances or angles);
enlarging to $E(3) = T^3 \rtimes SO(3)$ promotes it to a flat **Euclidean**
space (distances and angles too). Equivalently, the isometry group of
$(\mathbb{R}^3, \delta_{ij})$ is the full $E(3)$, not just $T^3$: $T^3$ is the
isometry group of *every* constant-metric flat geometry on $\mathbb{R}^3$,
whereas $E(3)$ is the one that singles out the round metric.

**The weak isotropy principle.** What is the *minimal* physical input that
forces the rotation algebra $\mathfrak{so}(3)$? Not "preservation of a
positive-definite metric" (which presupposes that a metric exists), nor
"preservation of length" (which presupposes a notion of length), nor any
quantitative geometric structure. The minimal input is a single qualitative
statement:

> **Weak isotropy principle.** At each point of space, all directions are
> physically equivalent: for any two unit vectors $\hat u, \hat v$ in the
> tangent space, there exists a (closed, bounded) symmetry transformation
> $h$ taking $\hat u$ to $\hat v$.

That is: the stabilizer $\mathfrak{h}$ at each point integrates to a closed
Lie subgroup $H \subset GL(n,\mathbb{R})$ that acts *transitively on the unit
sphere $S^{n-1}$* of directions. No assumption about distances, angles,
metric, or any quantitative structure is made — only that all directions
are "the same".

**Inevitability of $\mathfrak{so}(3)$.** From weak isotropy alone — just
"directions are transitive" — the $\mathfrak{so}(3)$ algebra emerges
inevitably, by a structural theorem (Borel; Montgomery–Samelson; Onishchik,
1940s–60s):

> Every compact connected Lie group $H$ acting transitively on a sphere
> $S^{n-1}$ ($n \geq 3$) contains $SU(2) \cong SO(3)$ as a closed subgroup.

At the Lie-algebra level: every algebra $\mathfrak{h}$ implementing weak
isotropy in dimension $\geq 3$ contains $\mathfrak{so}(3)$ as a subalgebra,
with the commutation relations $[J^i, J^j] = \epsilon^{ijk} J^k$ baked in.

The minimal compact transitive groups in low dimensions:

| ambient $\mathbb{R}^n$ | sphere $S^{n-1}$ | minimal compact transitive group | algebra | contains $\mathfrak{so}(3)$? |
|---|---|---|---|---|
| $n = 3$ | $S^2$ | $SO(3)$ | $\mathfrak{so}(3)$ | ✓ (it *is* $\mathfrak{so}(3)$) |
| $n = 4$ | $S^3$ | $SU(2)$ | $\mathfrak{su}(2) \cong \mathfrak{so}(3)$ | ✓ |
| $n = 5$ | $S^4$ | $SO(5)$ | $\mathfrak{so}(5)$ | ✓ ($\mathfrak{so}(3) \subset \mathfrak{so}(5)$) |
| $n = 6$ | $S^5$ | $SU(3)$ | $\mathfrak{su}(3)$ | ✓ ($\mathfrak{su}(2) \subset \mathfrak{su}(3)$) |
| $n = 7$ | $S^6$ | $G_2$ | $\mathfrak{g}_2$ (14-dim, exceptional!) | ✓ (root $\mathfrak{su}(2)$ inside) |
| $n = 8$ | $S^7$ | $\mathrm{Spin}(7)$ | $\mathfrak{spin}(7) = \mathfrak{so}(7)$ | ✓ |

The structural reason: any compact connected non-abelian Lie algebra contains
$\mathfrak{su}(2)$ as a subalgebra — one copy for each root in its root
system. Transitive action on a sphere of dimension $\geq 2$ forces
non-abelianness (abelian groups have torus orbits, not spherical orbits). So
every isotropy algebra in dimension $\geq 3$ must contain $\mathfrak{so}(3)$.

Even in dimensions where the *full* rotation algebra $\mathfrak{so}(n)$ is
not required for isotropy — e.g., $n = 6$ where $\mathfrak{su}(3)$ (8-dim) is
already sufficient, or $n = 7$ where the exceptional $\mathfrak{g}_2$
(14-dim) is — the $\mathfrak{so}(3)$ subalgebra is *always* present. It is
the irreducible algebraic content of "isotropy".

**Everything else is a derived consequence, not an additional assumption.**
Once $\mathfrak{so}(3) \subset \mathfrak{h}$ is forced, the Leibniz invariance
equation with the rotation generators $J^i$ acting on $\mathfrak{m}$
automatically gives:

- A unique (up to scale) invariant Riemannian metric $\eta = \alpha\,\delta^{ij}$
  on $\mathfrak{m}$ (the calculation done earlier).
- Hence a notion of *length* $|\vec u| = \sqrt{\delta_{ij}\, u^i u^j}$.
- Hence a notion of *angle* $\cos\theta = \delta_{ij}\, u^i v^j /(|\vec u||\vec v|)$.
- Hence the existence of orthonormal frames at each point.
- Hence (combined with translation-invariance and flatness from $[\mathfrak{m},
  \mathfrak{m}] = 0$) the standard global metric $ds^2 = (dx^1)^2 + (dx^2)^2
  + (dx^3)^2$ on $\mathbb{R}^3$.

None of these structures were assumed up front. They are all *forced* by
the single weak-isotropy principle (giving $\mathfrak{so}(3) \subset
\mathfrak{h}$) plus translation invariance (giving the flat-manifold
structure). This is a striking conceptual economy of the Klein-geometric
viewpoint: a single qualitative statement — *"all directions are
equivalent"* — generates the entire quantitative scaffolding of Euclidean
geometry.

**The four 3-dim quotients side-by-side.** Each 3-dim Klein quotient
corresponds to "things modulo a different stabilizer":

| $\mathfrak{h}$ | Stabilizes... | What $G/H$ parameterizes | Metric |
|---|---|---|---|
| $\mathfrak{so}(3)$ | a *point* (origin) | points of $\mathbb{R}^3$ | flat Euclidean ★ |
| $\mathfrak{t}$ | (no point; identifies all of $\mathbb{R}^3$) | orientations $SO(3) \cong \mathbb{RP}^3$ | non-reductive (bi-invariant from $\mathfrak{so}(3)$ Killing form) |
| $\mathfrak{e}(2)$ | an oriented 2-plane through origin | oriented planes $\cong \mathbb{R} \times S^2$ | reductive but degenerate |
| screw-$\mathfrak{e}(2)$, $a>0$ | a "twisted plane" with helical pitch | (no clean reductive description) | non-reductive |

The *same* Lie algebra $\mathfrak{e}(3)$ thus admits several geometrically
distinct 3-dim homogeneous spaces. The orbit–stabilizer interpretation
uniquely identifies $E(3)/SO(3)$ as the space of points, and the Leibniz
invariance condition then fixes its metric to be the standard flat one.

The structural pattern is exactly the one we saw for Minkowski: $G$ is a
semidirect product $H \ltimes T$ with $T$ an abelian ideal of
translations, $\mathfrak{m} = T$ acts transitively on the space, and the
Leibniz invariance condition with respect to $\mathfrak{h}$ fixes the
metric uniquely (up to overall scale). The only signature-distinguishing
input is the bracket $[\mathfrak{h}, \mathfrak{m}]$: with $\mathfrak{h}
= \mathfrak{so}(n)$ acting on $\mathfrak{m}$ by the defining
representation, the invariant form is positive-definite Euclidean; with
$\mathfrak{h} = \mathfrak{so}(3,1)$ acting on $\mathfrak{m}$ by its
defining representation, the invariant form is Minkowski.

---

## Part IV: Spheres — $S^2$ and $S^3$

The Euclidean cases above are *flat* because the translation generators
satisfy $[\mathfrak{m}, \mathfrak{m}] = 0$. Replacing the Euclidean
algebra by $\mathfrak{so}(n+1)$ changes exactly this bracket: now
$[\mathfrak{m}, \mathfrak{m}] \subset \mathfrak{h}$, the homogeneous space
acquires constant positive curvature, and one obtains the round sphere
$S^n$. The metric on $\mathfrak{m}$ is computed by the same Leibniz
condition, and turns out to have the same form $\delta^{ij}$; the
curvature lives in the bracket $[\mathfrak{m}, \mathfrak{m}]$, not in the
metric formula itself. This is the canonical example of how the
Klein/Cartan framework separates the *shape* of the metric (controlled
by $[\mathfrak{h}, \mathfrak{m}]$) from the *curvature* of the space
(controlled by $[\mathfrak{m}, \mathfrak{m}]$).

One subtlety should be flagged in advance, because the spherical case
makes it impossible to ignore: the metric the Leibniz condition produces
on $\mathfrak{m}$ is the metric in an **orthonormal frame** — equivalently,
the metric at the basepoint in the basis given by the Lie-algebra
generators. It is *not* the metric in some chosen coordinate chart.
For the flat cases above, the two agree, because $\mathfrak{m}$ is an
abelian ideal and exponentiation gives global Cartesian coordinates in
which the orthonormal frame coincides with the coordinate basis. For
$S^n$, this is no longer true: no single coordinate chart is orthonormal
everywhere, so the coordinate form of the metric differs from $\delta_{ab}$.
We treat this carefully in $S^2$ below.

### The 2-sphere $S^2$

The algebra $\mathfrak{so}(3)$ has three generators $\{J^1, J^2, J^3\}$
with

$$
[J^i, J^j] = \epsilon^{ijk} J^k.
$$

**Klein-pair candidates.** The proper subalgebras of $\mathfrak{so}(3)$
are:

- $\{0\}$: $G/H = G$ is 3-dimensional (the group manifold
  $SO(3) \cong \mathbb{RP}^3$, or $SU(2) \cong S^3$ for the double cover).
- Any 1-dim subspace $\{n^i J^i\}$ for a unit vector $n^i$ — all such are
  conjugate under $SO(3)$. Gives $\dim G/H = 2$.
- No 2-dim subalgebras exist (any pair $X, Y \in \mathfrak{so}(3)$ has
  $[X, Y]$ generically outside $\operatorname{span}\{X, Y\}$).

So the only nontrivial 2-dimensional Klein geometry of $\mathfrak{so}(3)$
is $G/\{n^i J^i\}$ for some axis $n$, and by conjugacy all choices are
equivalent. Picking $n = \hat z$ to fix a "north pole," we take

$$
\mathfrak{h} = \{J^3\}, \qquad \mathfrak{m} = \{J^1, J^2\}, \qquad
S^2 = SO(3)/SO(2).
$$

**Operational interpretation.** $J^3$ generates rotations around the
$z$-axis. A point at the north pole is fixed by these rotations and
moved by the other two generators $J^1, J^2$ (which tilt the pole toward
the $x$- or $y$-axis). So "the points of the sphere" form the
homogeneous space $G/H$ with this stabilizer.

**Reductive check.** We need $[\mathfrak{h}, \mathfrak{m}] \subset
\mathfrak{m}$, so that the Leibniz condition makes sense as a condition
on $\mathfrak{m}$. Compute:

$$
[J^3, J^1] = J^2 \in \mathfrak{m}, \qquad
[J^3, J^2] = -J^1 \in \mathfrak{m}. \;\;\checkmark
$$

What about $[\mathfrak{m}, \mathfrak{m}]$? Compute $[J^1, J^2] = J^3 \in
\mathfrak{h}$. So $[\mathfrak{m}, \mathfrak{m}] \subset \mathfrak{h}$:
this is the hallmark of a **symmetric space** — and it is what produces
the curvature, as discussed below.

**Metric derivation.** Set $g(J^a, J^b) = \eta^{ab}$ for $a, b \in \{1,
2\}$, three unknowns. The Leibniz condition with $X = J^3$:

$$
g([J^3, J^a], J^b) + g(J^a, [J^3, J^b]) = 0.
$$

- $a = b = 1$: $g(J^2, J^1) + g(J^1, J^2) = 2\eta^{12} = 0$
  $\Rightarrow \eta^{12} = 0$.
- $a = 1, b = 2$: $g(J^2, J^2) + g(J^1, -J^1) = \eta^{22} - \eta^{11} = 0$
  $\Rightarrow \eta^{11} = \eta^{22}$.

So $\eta^{ab} = \lambda\, \delta^{ab}$ on $\mathfrak{m}$, exactly as for
the 2D plane. This result needs careful unpacking, because read naively it
appears to say that the metric on $S^2$ is flat — which is wrong.

**What this answer is, and what it is not.** The Lie-algebra basis
$\{J^1, J^2\}$ for $\mathfrak{m}$ is a basis of *one tangent space* —
namely $T_N S^2$, the tangent space at the basepoint (north pole). The
derivation gives the components of the metric in that basis on that one
tangent space. By $G$-equivariance, the same components reappear at every
other point if we use the basis obtained by transporting $\{J^1, J^2\}$
around $S^2$ via the group action: that is an **orthonormal frame**
$\{e_1, e_2\}$, in which the metric is $\delta_{ab}$ *globally*.

This does not contradict $S^2$ being curved. By a standard theorem, every
Riemannian manifold admits an orthonormal frame at every point; in that
frame the metric components are always $\delta_{ab}$. The curvature does
not live in the *values* of the metric in such a frame — it lives in how
the frame must twist as one moves from point to point, encoded in the
connection 1-form $\omega^a{}_b$. This is the same fact that underlies
the equivalence principle in general relativity: at any point one can
choose coordinates in which $g_{\mu\nu}(p) = \eta_{\mu\nu}$ and
$\partial_\rho g_{\mu\nu}(p) = 0$, even on a strongly curved spacetime.

**Translating to spherical coordinates.** To recover the familiar form
$R^2(d\theta^2 + \sin^2\theta\, d\phi^2)$ we must express the
$G$-invariant metric in the *coordinate* basis $\{\partial_\theta,
\partial_\phi\}$ rather than the Lie-algebra-derived frame
$\{e_1, e_2\}$. The bridge is the **vielbein** (here a *zweibein*)
$e^a{}_\mu$ — a soldering form that gives the components of the coframe
$\{e^1, e^2\}$ in coordinates. Crucially, the entire bridge can be
obtained from the abstract Lie algebra alone, without any embedding of
$S^2$ in $\mathbb{R}^3$. We carry that derivation out now.

*Step 1: Define coordinates by a coset section.* A point of $S^2 = G/H$
is an equivalence class $g H$. To turn this into a coordinate chart we
pick a smooth map $\sigma: U \to G$ that selects one representative in
each class — a **coset section**. The natural section adapted to the
basepoint (north pole) is the algebraic prescription

$$
\sigma(\theta, \phi) \;=\; e^{\phi J^3}\, e^{\theta J^2}.
$$

This is purely algebraic: $J^2$ tilts the basepoint by an angle $\theta$
in the $(x, z)$-plane (giving colatitude $\theta$), then $J^3$ rotates
by $\phi$ around the chosen axis (giving longitude $\phi$). No embedding
in $\mathbb{R}^3$ has been used — only one-parameter subgroups generated
by Lie algebra elements. The coordinates $(\theta, \phi)$ are by
*definition* the parameters of this section.

*Step 2: Compute the Maurer–Cartan form of the section.* For any smooth
map $\sigma: U \to G$, the pullback of the Maurer–Cartan form is

$$
\omega \;=\; \sigma^{-1}\, d\sigma
\;=\; \omega_\theta\, d\theta + \omega_\phi\, d\phi,
$$

with $\omega_\theta, \omega_\phi \in \mathfrak{g}$. Using the
Baker–Campbell–Hausdorff identity
$e^{-X}\, \tfrac{d}{ds}\big|_{s=0}\!\bigl(e^{X + sY}\bigr) = Y + O(\text{brackets})$
and, more usefully, the identity $\sigma^{-1} d\sigma$ on a product of
exponentials, one computes:

$$
\omega_\theta \;=\; J^2, \qquad
\omega_\phi \;=\; -\sin\theta\; J^1 + \cos\theta\; J^3.
$$

(Sketch: $\partial_\theta \sigma = e^{\phi J^3} J^2 e^{\theta J^2}$, so
$\sigma^{-1} \partial_\theta \sigma = e^{-\theta J^2} e^{-\phi J^3} \cdot
e^{\phi J^3} J^2 e^{\theta J^2} = J^2$. For
$\partial_\phi \sigma = J^3 \sigma$, we get $\sigma^{-1} \partial_\phi
\sigma = e^{-\theta J^2} J^3 e^{\theta J^2}$, which by
$\mathrm{Ad}_{e^{-\theta J^2}}$ acting on $J^3$ — using $[J^2, J^3] =
J^1$, $[J^2, J^1] = -J^3$ — gives $\cos\theta\, J^3 - \sin\theta\, J^1$.)

*Step 3: Read off the vielbein.* Split $\omega = e + \omega_{\mathfrak{h}}$
into its $\mathfrak{m}$-part $e$ (the **soldering form** / vielbein) and
its $\mathfrak{h}$-part $\omega_{\mathfrak{h}}$ (the **spin connection**).
With $\mathfrak{m} = \{J^1, J^2\}$ and $\mathfrak{h} = \{J^3\}$:

$$
\begin{aligned}
e_\theta &= J^2,        & e_\phi &= -\sin\theta\, J^1, \\
\omega_{\mathfrak{h},\theta} &= 0,  & \omega_{\mathfrak{h},\phi} &= \cos\theta\, J^3.
\end{aligned}
$$

Writing $e_\mu = e^a{}_\mu\, J_a$ with $J_a = J^a$ for $a \in \{1, 2\}$
gives the vielbein components

$$
e^1{}_\theta = 0, \quad e^2{}_\theta = 1, \qquad
e^1{}_\phi = -\sin\theta, \quad e^2{}_\phi = 0,
$$

equivalently the coframe (up to an orientation flip of $\phi$ that
absorbs the sign of $e^1$)

$$
e^1 \;=\; \sin\theta\, d\phi, \qquad
e^2 \;=\; d\theta.
$$

This is the orthonormal coframe in its bare (scale-free) form,
*derived* now from the Maurer–Cartan calculation rather than asserted.
The overall scale $\lambda$ from the Leibniz derivation will be
reinstated when we assemble the metric in Step 5.

*Step 4: Killing vector fields.* The vector field on $G/H$ generated by
$\xi \in \mathfrak{g}$ is the unique field $Y_\xi$ whose tangent vector
at $\sigma(\theta, \phi)$ matches the infinitesimal left-action of
$e^{t\xi}$ on the section. In coordinates,

$$
Y_\xi^\mu(\theta, \phi)\, e_\mu \;=\; \bigl[\mathrm{Ad}_{\sigma^{-1}}\, \xi\bigr]_{\mathfrak{m}},
$$

i.e. one expresses $\sigma^{-1} \xi \sigma \in \mathfrak{g}$ in the
basis $\{J^1, J^2, J^3\}$, keeps the $\mathfrak{m}$-components, and
inverts the vielbein $e^a{}_\mu$ to read off $Y_\xi^\mu$. The adjoint
action is a pure Lie-algebra calculation:

$$
\mathrm{Ad}_{e^{-\theta J^2}}\, J^1
= \cos\theta\, J^1 + \sin\theta\, J^3, \qquad
\mathrm{Ad}_{e^{-\phi J^3}}(\cos\theta\, J^1 + \sin\theta\, J^3)
= \cos\phi\cos\theta\, J^1 - \sin\phi\cos\theta\, J^2 + \sin\theta\, J^3,
$$

and similarly for $J^2, J^3$. The $\mathfrak{m}$-projection
$(J^1$-coefficient $a$, $J^2$-coefficient $b$) and the vielbein
inversion ($\dot\theta = b$, $\dot\phi = -a/\sin\theta$) then yield

$$
J^1 = -\sin\phi\, \partial_\theta - \cos\phi\, \cot\theta\, \partial_\phi,
\qquad
J^2 = \cos\phi\, \partial_\theta - \sin\phi\, \cot\theta\, \partial_\phi,
\qquad
J^3 = \partial_\phi.
$$

These are the Killing vector fields of $S^2$, derived from the bracket
relations of $\mathfrak{so}(3)$ and the choice of section, with no use
of any embedding.

*Step 5: The metric in coordinates.* We now turn the bilinear form
$\eta^{ab} = \lambda\,\delta^{ab}$ on the *single* vector space
$\mathfrak{m} = T_{eH}(G/H)$ into a (0,2)-tensor field on the manifold
$G/H$, and evaluate it explicitly in $(\theta, \phi)$.

*5a. From form on $\mathfrak{m}$ to tensor field on $G/H$.* At each point
$p = \sigma(\theta, \phi) \cdot eH$ the vielbein, viewed at $p$, is a
linear isomorphism
$e_p : T_p(G/H) \stackrel{\sim}{\longrightarrow} \mathfrak{m}$,
$\;X \mapsto e^a(X)\, J_a$ — it sends a tangent vector to its components
in the orthonormal frame. Pulling the bilinear form $\eta$ back along
this isomorphism gives a bilinear form on $T_p(G/H)$:

$$
g_p(X, Y) \;:=\; \eta\bigl(e_p(X),\, e_p(Y)\bigr)
\;=\; \eta_{ab}\, e^a_p(X)\, e^b_p(Y).
$$

As a (0,2)-tensor field on $G/H$ this reads

$$
g \;=\; \eta_{ab}\, e^a \otimes e^b
\;=\; \lambda\, \delta_{ab}\, e^a \otimes e^b.
$$

The choice is $G$-equivariant by construction: the section $\sigma$
threads the basepoint frame consistently across the manifold, and the
single bilinear form $\eta$ is used at every point in that frame. So
$g$ is automatically the unique $G$-invariant metric extending $\eta$
from the basepoint.

*5b. Expand the index sum.* With $a, b \in \{1, 2\}$ and $\delta_{ab}$
diagonal, only the two diagonal terms survive:

$$
\delta_{ab}\, e^a \otimes e^b
\;=\; e^1 \otimes e^1 + e^2 \otimes e^2.
$$

Writing $(e^a)^2 := e^a \otimes_S e^a$ for the symmetric tensor square
(equivalently, $ds^2 = g_{\mu\nu}\, dx^\mu\, dx^\nu$ in the line-element
notation),

$$
g \;=\; \lambda\bigl[(e^1)^2 + (e^2)^2\bigr].
$$

*5c. Substitute the coframe.* From Step 3, $e^1 = \sin\theta\, d\phi$
and $e^2 = d\theta$ (in the bare, $\lambda$-free normalisation read off
the Maurer–Cartan form). Then

$$
(e^1)^2 \;=\; (\sin\theta\, d\phi) \otimes_S (\sin\theta\, d\phi)
\;=\; \sin^2\theta\; d\phi \otimes_S d\phi
\;=\; \sin^2\theta\; d\phi^2,
$$

$$
(e^2)^2 \;=\; d\theta \otimes_S d\theta \;=\; d\theta^2.
$$

Adding the two and multiplying by the overall scale $\lambda$:

$$
g \;=\; \lambda\,\bigl(d\theta^2 + \sin^2\theta\; d\phi^2\bigr).
$$

*5d. Identify the scale with the squared radius.* Define $R^2 := \lambda$.
This is just a relabelling of the single free parameter — the algebra
fixed the ratio of metric scale to curvature scale, so $R$ is determined
by the choice of curvature unit. The metric becomes

$$
\boxed{\;ds^2 \;=\; R^2\,\bigl(d\theta^2 + \sin^2\theta\, d\phi^2\bigr).\;}
$$

This is the **round metric** of $S^2$ — and it is the *same* metric as
$\delta_{ab}$ in the frame: the two formulas express the same bilinear
form in different bases. The $\sin^2\theta$ is not a feature of the
metric itself; it is the squared length of the coordinate vector
$\partial_\phi$, a Killing field whose magnitude varies from $0$ at
the poles to $R$ at the equator.

**Algebraic content of the construction.** Steps 1–5 use only:
- the bracket relations $[J^i, J^j] = \epsilon^{ijk}J^k$,
- the Klein-pair choice $\mathfrak{m} = \{J^1, J^2\}$, $\mathfrak{h} = \{J^3\}$,
- and the Leibniz-derived metric $\eta^{ab} = \delta^{ab}$ on $\mathfrak{m}$.

The same procedure (coset section ⇒ Maurer–Cartan form ⇒ vielbein and
Killing fields ⇒ coordinate metric via $g = \delta_{ab}\, e^a \otimes e^b$)
applies verbatim to any reductive Klein geometry, and is the standard
algorithm by which the abstract algebraic data $(\mathfrak{g},
\mathfrak{h}, \eta)$ is turned into explicit coordinate geometry.

**Flat space in curvilinear coordinates.** Lest this seem like a feature
of curvature, the same phenomenon appears in flat $\mathbb{R}^2$ if one
uses polar coordinates: $g_{\mu\nu} = \operatorname{diag}(1, r^2)$ even
though the space is flat. The orthonormal coframe $e^1 = dr$, $e^2 = r\,
d\phi$ still gives $\delta_{ab}$. The genuine algebraic distinction
"flat vs. curved" is not whether $g_{\mu\nu}$ depends on the coordinates;
it is whether one can choose *global* coordinates in which $g_{\mu\nu}$
is constant. For $\mathbb{R}^2$ ($\mathfrak{m}$ abelian, exponential map
a global diffeomorphism) yes; for $S^2$ ($[\mathfrak{m}, \mathfrak{m}] =
\{J^3\} \subset \mathfrak{h}$, exponential map only local) no. This is
exactly the bracket-level distinction discussed next.

**Where the curvature comes from.** The fact that this is *not* the flat
2-plane is encoded in the bracket $[\mathfrak{m}, \mathfrak{m}] = \{J^3\}
\subset \mathfrak{h}$. In Cartan-geometric language, the Maurer–Cartan
equation $d\omega + \tfrac{1}{2}[\omega, \omega] = 0$ on the model space
$G$ decomposes via $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$ into
a torsion equation on the soldering form and a curvature equation on the
connection. The $\mathfrak{h}$-part of $\tfrac{1}{2}[\omega, \omega]$
contains $\tfrac{1}{2}[e^a, e^b]_{\mathfrak{h}}$, which here is non-zero
and is precisely what gives $S^2$ its constant positive sectional
curvature $1/R^2$. For the Euclidean case $[\mathfrak{m}, \mathfrak{m}]
= 0$, the same equation gives zero curvature — flat $\mathbb{R}^2$.

#### A streamlined derivation following the general algorithm

The construction above proceeds in two phases: first an abstract
bilinear form on $\mathfrak{m}$ via Leibniz invariance, then a separate
coordinate-and-vielbein passage. The general recipe in §"Mechanizing
the algorithm" merges these into one mechanical procedure with exactly
four steps. We run it here on $S^2$, spelling out every operation and
defining each new object in the language of vielbein/tetrad
differential geometry — the same language used for general relativity.
No new technology is needed beyond what physicists already use to write
$ds^2 = \eta_{ab}\, e^a{}_\mu\, e^b{}_\nu\, dx^\mu\, dx^\nu$ in a
non-coordinate frame.

##### Set-up

We want a metric on $S^2$ that is invariant under $SO(3)$. The Lie
algebra $\mathfrak{so}(3)$ has basis $\{J^1, J^2, J^3\}$ with
$[J^i, J^j] = \epsilon^{ijk} J^k$. Pick the basepoint $o$ at the north
pole. The rotations that fix $o$ are those around the $z$-axis,
generated by $J^3$. So

$$
\mathfrak{h} = \mathrm{span}(J^3), \qquad
\mathfrak{m} = \mathrm{span}(J^1, J^2).
$$

The two-dimensional subspace $\mathfrak{m}$ plays the role of "tangent
space at the basepoint" — its two basis vectors $J^1, J^2$ are the two
infinitesimal directions in which the north pole can be moved.

Choose polar coordinates $(\theta, \phi) \in (0, \pi) \times [0, 2\pi)$.
We need a way to write *every* point of $S^2$ as the image of $o$ under
some rotation. The natural choice: first rotate the pole down by angle
$\theta$ around the $y$-axis (using $J^2$), then around the $z$-axis
by $\phi$ (using $J^3$). Symbolically:

$$
\sigma(\theta, \phi) \;=\; e^{\phi J^3}\, e^{\theta J^2}.
$$

This map $\sigma\colon (\theta, \phi) \mapsto SO(3)$ is called a
**section**. It is just a coordinate parametrization of the sphere by
rotations: at every point $(\theta, \phi) \in S^2$ we have chosen a
specific rotation that takes the pole to that point. (Different points
in $SO(3)$ map to the same point in $S^2$ if they differ by an extra
$z$-rotation, which is why the choice is not unique. The section picks
one representative per point.)

##### Step 1 — structure constants

Read them off the brackets:

$$
[J^1, J^2] = J^3, \quad [J^2, J^3] = J^1, \quad [J^3, J^1] = J^2.
$$

In the notation $[X_a, X_b] = f^c{}_{ab}\, X_c$, the only non-zero
$f$'s are the cyclic permutations $f^k{}_{ij} = \epsilon^{ijk}$. We
shall need only two of them in what follows: $[J^3, J^1] = J^2$ and
$[J^3, J^2] = -J^1$.

##### Step 2 — Maurer–Cartan form

This is the central new object. Let us define it carefully, then
compute it for our section, then interpret the result.

###### Definition and physical meaning

For a path $\sigma(x)$ in a Lie group $G$, the
**Maurer–Cartan 1-form** is

$$
\omega \;:=\; \sigma^{-1}\, d\sigma.
$$

What does this mean? Imagine moving from coordinates $x$ to $x + dx$.
The group element changes from $\sigma(x)$ to $\sigma(x + dx) \approx
\sigma(x) + d\sigma$, where $d\sigma = \partial_\mu \sigma\, dx^\mu$.
Multiplying by $\sigma^{-1}$ from the left,

$$
\sigma^{-1}\, d\sigma \;=\; \sigma(x)^{-1}\, \sigma(x + dx) - \mathbf 1
\;\approx\; \log\bigl(\sigma(x)^{-1}\, \sigma(x + dx)\bigr).
$$

This is the **infinitesimal group element** needed to step from
$\sigma(x)$ to $\sigma(x + dx)$. Because the difference is
infinitesimal, this element is small and lies in the Lie algebra
$\mathfrak{g}$. So $\omega$ is a **1-form on the coordinate space,
valued in the Lie algebra**.

The cleanest physics analogy is the **angular velocity of a rigid
body**. If $R(t) \in SO(3)$ is the orientation of a rigid body as a
function of time, the body's angular velocity tensor is

$$
\Omega(t) \;=\; R(t)^{-1}\, \dot R(t) \;\in\; \mathfrak{so}(3).
$$

This is the same construction, with $t$ replacing $x^\mu$ and one
parameter instead of $\dim(G/H)$. The angular velocity tells you "how
the body is rotating at time $t$" expressed as an element of the
rotation algebra. Likewise $\omega(x)$ tells you "how the section is
varying at point $x$" expressed as a Lie-algebra element.

###### Why we need this for the metric

In standard tetrad/vielbein differential geometry the metric on a
manifold is written

$$
g_{\mu\nu}(x) \;=\; \eta_{ab}\, e^a{}_\mu(x)\, e^b{}_\nu(x),
$$

where $\eta_{ab}$ is a constant flat metric (Euclidean or Minkowski)
and $e^a{}_\mu(x)$ is the **vielbein** — a frame field that, at each
point, gives an orthonormal basis of $T_x M$. The components of any
tensor in the vielbein basis are also constant under parallel transport
in a metric-compatible torsion-free connection, provided the **spin
connection** $\omega^a{}_{b\mu}(x)$ is chosen correctly.

The remarkable fact on a homogeneous space $G/H$ is that **the vielbein
and the spin connection come for free** from the section $\sigma$: they
are exactly the two pieces into which $\sigma^{-1} d\sigma$ splits
under $\mathfrak{g} = \mathfrak{m} \oplus \mathfrak{h}$. Concretely,
write

$$
\omega \;=\; \omega^a\, X_a^{\mathfrak{m}}
\;+\; \omega^A\, X_A^{\mathfrak{h}}
\;\equiv\; e \;+\; \omega_{\mathfrak{h}},
$$

where $X_a^{\mathfrak{m}}$ runs over a basis of $\mathfrak{m}$ and
$X_A^{\mathfrak{h}}$ over a basis of $\mathfrak{h}$. Then:

- The $\mathfrak{m}$-components $\omega^a{}_\mu = e^a{}_\mu$ are the
  **vielbein components**. Reason: $\mathfrak{m} \cong T_o(G/H)$ (the
  generators of $\mathfrak{m}$ are exactly the infinitesimal moves of
  the basepoint), so $\omega^a$ encodes how the basepoint shifts as
  we vary $x^\mu$ — i.e., a frame field with values in $T_o(G/H)$.
- The $\mathfrak{h}$-components $\omega^A{}_\mu$ are the **spin
  connection** components. Reason: $\mathfrak{h}$ generates rotations
  of the local frame; its components encode how the frame rotates as
  we move along $dx^\mu$. (This is the same connection that appears
  in the covariant derivative of spinors in GR.)

Both pieces are simply read off from one matrix product:
$\sigma^{-1}\, d\sigma$.

###### Computing $\omega$ for $S^2$

We need $\sigma^{-1} \partial_\theta \sigma$ and $\sigma^{-1}
\partial_\phi \sigma$ with $\sigma = e^{\phi J^3}\, e^{\theta J^2}$.

For $\partial_\theta$: differentiating commutes with the leftmost
factor since it does not depend on $\theta$, giving

$$
\partial_\theta \sigma \;=\; e^{\phi J^3}\, J^2\, e^{\theta J^2}.
$$

Multiplying by $\sigma^{-1} = e^{-\theta J^2}\, e^{-\phi J^3}$ on the
left, the inner factors $e^{-\phi J^3} \cdot e^{\phi J^3} = \mathbf 1$
cancel, leaving

$$
\sigma^{-1}\, \partial_\theta \sigma
\;=\; e^{-\theta J^2}\, J^2\, e^{\theta J^2}
\;=\; J^2,
$$

where the last equality holds because $J^2$ commutes with the
exponentials of itself.

For $\partial_\phi$: now the derivative hits the leftmost factor,

$$
\partial_\phi \sigma \;=\; J^3\, e^{\phi J^3}\, e^{\theta J^2}
\;=\; J^3\, \sigma.
$$

Multiplying by $\sigma^{-1}$ on the left,

$$
\sigma^{-1}\, \partial_\phi \sigma \;=\; \sigma^{-1}\, J^3\, \sigma
\;=\; e^{-\theta J^2}\, e^{-\phi J^3}\, J^3\, e^{\phi J^3}\, e^{\theta J^2}
\;=\; e^{-\theta J^2}\, J^3\, e^{\theta J^2}.
$$

This is the **adjoint action** of the group element $e^{-\theta J^2}$
applied to the algebra element $J^3$, written
$\mathrm{Ad}_{e^{-\theta J^2}} J^3$. The adjoint is just matrix
conjugation by a group element; its purpose here is to express "the
element $J^3$, as seen from a rotated frame." We compute it by the
standard expansion

$$
e^X Y e^{-X} \;=\; Y + [X, Y] + \frac{1}{2!}[X, [X, Y]]
+ \frac{1}{3!}[X, [X, [X, Y]]] + \cdots.
$$

With $X = -\theta J^2$ and $Y = J^3$, each nested bracket maps
$\{J^3, J^1\}$ to itself (a closed 2-d subspace under $\mathrm{ad}_{J^2}$
because of the cyclic algebra). Specifically:

$$
[J^2, J^3] = J^1, \qquad [J^2, J^1] = -J^3, \qquad [J^2, -J^3] = -J^1,
\qquad [J^2, -J^1] = J^3.
$$

So nested brackets cycle through $J^3 \to J^1 \to -J^3 \to -J^1 \to
J^3 \to \cdots$ with period 4. Summing the series with the
sign-alternating coefficient $-\theta$:

$$
\mathrm{Ad}_{e^{-\theta J^2}} J^3
\;=\; \cos\theta\, J^3 \;-\; \sin\theta\, J^1.
$$

(Sanity check: at $\theta = 0$ we get $J^3$ unchanged. At
$\theta = \pi/2$ we get $-J^1$, which is correct since rotating the
$z$-axis by $-\pi/2$ around the $y$-axis brings it to the negative
$x$-axis.)

Putting both partial derivatives together, the Maurer–Cartan form on
$S^2$ in polar coordinates is

$$
\omega
\;=\; J^2\, d\theta \;+\; \bigl(\cos\theta\, J^3 - \sin\theta\, J^1\bigr)\, d\phi.
$$

###### Reading off the vielbein and connection

Split $\omega$ into its $\mathfrak{m}$-part (coefficients of $J^1, J^2$)
and $\mathfrak{h}$-part (coefficient of $J^3$):

$$
\boxed{\;
\begin{aligned}
e^1 &\;=\; -\sin\theta\, d\phi, &
e^2 &\;=\; d\theta, \\
\omega_{\mathfrak{h}} &\;=\; \cos\theta\, J^3\, d\phi.
\end{aligned}
\;}
$$

We choose to label the $\mathfrak{m}$-basis $\{J^1, J^2\}$ as
$\{X^1_{\mathfrak{m}}, X^2_{\mathfrak{m}}\}$ in the coframe indices, so
$e^1$ is the $J^1$-coefficient and $e^2$ the $J^2$-coefficient.

The minus sign in $e^1 = -\sin\theta\, d\phi$ is just a frame
orientation convention (from $-J^1$ in the expansion); it disappears
when we square in Step 4. The pair $(e^1, e^2)$ is an **orthonormal
coframe**, the standard tetrad object of GR. The 1-form
$\omega_{\mathfrak{h}}$ is the **spin connection** — a single
$\mathfrak{h}$-valued (i.e., $\mathfrak{so}(2)$-valued) 1-form, which
in matrix terms is a single skew $2\times 2$ rotation generator
multiplied by $\cos\theta\, d\phi$.

##### Step 3 — invariance equation

###### Why this step is needed

We have a frame field $e^a{}_\mu(x)$ at every point of $S^2$. To turn
it into a metric we need to specify a constant inner product
$\eta_{ab}$ on the algebraic tangent space $\mathfrak{m}$: the full
metric is then $g_{\mu\nu} = \eta_{ab}\, e^a{}_\mu\, e^b{}_\nu$.

But $\eta_{ab}$ on $\mathfrak{m}$ cannot be just any symmetric matrix.
The basepoint $o$ is fixed by $H = SO(2)$, the rotations around the
$z$-axis. Any such rotation $h \in H$ acts on the tangent space at the
basepoint — that is, on $\mathfrak{m}$ — by a 2-d rotation; physically,
the rotation acts on the directions $J^1, J^2$ in which we can move
the pole. For the metric to be the same at every point of $S^2$ (an
$SO(3)$-invariant metric), we need it at the basepoint to be invariant
under this $H$-action on $\mathfrak{m}$:

$$
\eta\bigl(\mathrm{Ad}_h X,\; \mathrm{Ad}_h Y\bigr) \;=\; \eta(X, Y)
\qquad \text{for all } h \in H,\ X, Y \in \mathfrak{m}.
$$

This is just saying "the dot product of two tangent vectors does not
change if we rotate them both by the same $H$-rotation."

The **adjoint action** of $h$ on $\mathfrak{m}$ is matrix
conjugation: $\mathrm{Ad}_h X = h\, X\, h^{-1}$, with the result still
in $\mathfrak{m}$ because the Klein pair is reductive
($[\mathfrak{h}, \mathfrak{m}] \subset \mathfrak{m}$). Restricting to
$\mathfrak{m}$, $\mathrm{Ad}_h$ is an honest $2 \times 2$ matrix acting
on the column vector of components in the $(J^1, J^2)$ basis.

###### Linearizing the invariance

Take $h = e^{t Z}$ for $Z \in \mathfrak{h}$, differentiate at $t = 0$,
and use the chain rule. With $\mathrm{Ad}_{e^{tZ}} X = X + t [Z, X] +
O(t^2)$,

$$
0 \;=\; \frac{d}{dt}\bigg|_{t=0}
\eta\bigl(\mathrm{Ad}_{e^{tZ}} X,\; \mathrm{Ad}_{e^{tZ}} Y\bigr)
\;=\; \eta\bigl([Z, X], Y\bigr) + \eta\bigl(X, [Z, Y]\bigr).
$$

This is the **infinitesimal invariance condition** — the Leibniz rule
used throughout the document. The map $X \mapsto [Z, X]$ on
$\mathfrak{m}$ is called $\mathrm{ad}_Z$ ("the infinitesimal
adjoint"); as a matrix, $(\mathrm{ad}_Z)^a{}_b = f^a{}_{Zb}$, with
structure constants from Step 1.

In matrix notation, the condition reads

$$
\eta\, \mathrm{ad}_Z + (\mathrm{ad}_Z)^T\, \eta \;=\; 0
\qquad \text{for every basis element } Z \in \mathfrak{h}.
$$

###### Solving it for $S^2$

The single generator of $\mathfrak{h}$ is $Z = J^3$. Its bracket
action on $\mathfrak{m}$:

$$
[J^3, J^1] = J^2, \qquad [J^3, J^2] = -J^1.
$$

In the basis $(J^1, J^2)$, $\mathrm{ad}_{J^3}$ is therefore the matrix
of a 90° rotation,

$$
\mathrm{ad}_{J^3}\big|_{\mathfrak{m}}
\;=\; \begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}.
$$

Let $\eta = \begin{pmatrix} a & b \\ b & c \end{pmatrix}$ (symmetric).
Compute $\eta\, \mathrm{ad}_{J^3} + (\mathrm{ad}_{J^3})^T\, \eta$:

$$
\begin{pmatrix} a & b \\ b & c \end{pmatrix}
\begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}
+
\begin{pmatrix} 0 & 1 \\ -1 & 0 \end{pmatrix}
\begin{pmatrix} a & b \\ b & c \end{pmatrix}
\;=\;
\begin{pmatrix} 2b & c - a \\ c - a & -2b \end{pmatrix}
\;\stackrel!=\; 0.
$$

So $b = 0$ and $c = a$. The unique (up to scale) invariant inner
product on $\mathfrak{m}$ is

$$
\boxed{\;\eta_{ab} \;=\; \lambda\, \delta_{ab}, \quad \lambda > 0.\;}
$$

This says: $J^1$ and $J^2$ are orthogonal and have the same length, in
the only frame-independent way available. Geometrically obvious — the
two algebraic "directions to move the pole" are equivalent up to the
$SO(2)$ rotation that fixes the pole. Algebraically, this fact is now
*derived* rather than postulated.

##### Step 4 — assemble the metric

Compute $g_{\mu\nu} = \eta_{ab}\, e^a{}_\mu\, e^b{}_\nu$ with $\eta =
\lambda\, \delta$:

$$
g \;=\; \lambda\bigl[(e^1)^2 + (e^2)^2\bigr]
\;=\; \lambda\bigl[(-\sin\theta\, d\phi)^2 + (d\theta)^2\bigr]
\;=\; \lambda\bigl[d\theta^2 + \sin^2\theta\, d\phi^2\bigr].
$$

Identifying the overall scale with the squared radius, $\lambda = R^2$:

$$
\boxed{\; ds^2 \;=\; R^2 \bigl(d\theta^2 + \sin^2\theta\, d\phi^2\bigr). \;}
$$

The round metric of the sphere of radius $R$, as expected.

##### Summary of new ingredients

The whole construction needed only three abstract concepts beyond the
GR vielbein formalism:

- **Section $\sigma$.** A choice of representative rotation per point
  of $S^2$. The same role as a coordinate chart, but expressed via
  group elements rather than coordinates only. Selecting a section is
  literally choosing a parametrization.
- **Maurer–Cartan form $\omega = \sigma^{-1} d\sigma$.** An
  $\mathfrak{so}(3)$-valued 1-form. By construction it tells you which
  infinitesimal rotation takes $\sigma(x)$ to $\sigma(x + dx)$.
  Splitting it via $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$
  produces the vielbein $e^a$ and the spin connection
  $\omega_{\mathfrak{h}}$ — the two standard tetrad-formalism objects
  of GR — automatically.
- **Adjoint action $\mathrm{Ad}_h$ and $\mathrm{ad}_Z$.** Conjugation
  in the group ($\mathrm{Ad}_h X = h X h^{-1}$) and its infinitesimal
  version ($\mathrm{ad}_Z X = [Z, X]$). Their role is twofold: they
  appear inside the computation of $\omega$ (because moving the
  derivative through $\sigma$ produces conjugations), and they
  express the symmetry condition that the metric must satisfy on
  $\mathfrak{m}$.

Everything else is matrix algebra. No general-position differential
topology, no global existence theorems, no abstract bundle
constructions were invoked. The recipe is local, explicit, and
mechanical — exactly the kind of computation a physicist would write
out using only the tools of GR. The same four steps applied to any
other reductive Klein pair $(\mathfrak{g}, \mathfrak{h})$ with section
$\sigma$ yield the corresponding metric.

#### Cartesian-like derivation: $\sigma = \exp(a J^1 + b J^2)$

The streamlined derivation above used a *product* section,
$\sigma = e^{\phi J^3}\, e^{\theta J^2}$, in which an
$\mathfrak{h}$-generator ($J^3$) handles the azimuthal direction. The
natural analogue of the Cartesian section on $\mathbb{R}^2$ — built
entirely from $\mathfrak{m}$-generators in a single exponential — is

$$
\sigma(a, b) \;=\; \exp(a\, J^1 + b\, J^2).
$$

Geometrically, this is a *single* rotation: about the axis
$(a, b, 0)/\sqrt{a^2 + b^2}$ in the equatorial plane, by angle
$\rho = \sqrt{a^2 + b^2}$. The coordinates $(a, b)$ are **geodesic
normal coordinates** at the north pole — exponentiating an
$\mathfrak{m}$-vector of length $\rho$ moves the basepoint along the
geodesic of arclength $\rho$ in direction $(\cos\psi, \sin\psi)$ where
$\psi = \arctan(b/a)$.

This is precisely the $\mathbb{R}^2$ recipe of the previous section
transplanted onto $S^2$. Let us run the four-step algorithm and see
what comes out — and exactly where the chart breaks down.

##### Step 1 — structure constants

Unchanged from the polar derivation: $[J^i, J^j] = \epsilon^{ijk} J^k$,
with Klein pair $\mathfrak{h} = \mathrm{span}(J^3)$, $\mathfrak{m} =
\mathrm{span}(J^1, J^2)$.

The crucial bracket is now $[J^1, J^2] = J^3 \in \mathfrak{h}$, *not*
zero. Already at this stage we can predict — by comparison with the
$\mathbb{R}^2$ Cartesian case — that the BCH formula will not collapse
and that the spin connection will not vanish.

##### Step 2 — Maurer–Cartan form

The exponential $\sigma = \exp(V)$ with $V = aJ^1 + bJ^2$ no longer
truncates after one term. In the standard $3 \times 3$ representation
of $\mathfrak{so}(3)$,

$$
V \;=\; \begin{pmatrix} 0 & 0 & b \\ 0 & 0 & -a \\ -b & a & 0 \end{pmatrix},
$$

which is the skew-symmetric matrix representing infinitesimal rotation
about the axis $(a, b, 0)$. Direct computation shows
$V^3 = -\rho^2 V$ with $\rho = \sqrt{a^2 + b^2}$, so the exponential
series collapses to the **Rodrigues formula**:

$$
\sigma \;=\; \exp(V) \;=\; I + \frac{\sin\rho}{\rho}\, V
                       + \frac{1 - \cos\rho}{\rho^2}\, V^2.
$$

This is a rotation by angle $\rho$ about the axis $(a, b, 0)$ — a
well-known elementary fact.

The Maurer–Cartan form is $\omega = \sigma^{-1}\, d\sigma$ (using
$\sigma^{-1} = \sigma^T$ since $\sigma \in SO(3)$). Carrying out the
matrix differentiation and projecting onto the basis $(J^1, J^2, J^3)$
gives (computed with [`klein_geometry.py`](klein_geometry.py))

$$
e^1{}_a \;=\; \frac{a^2}{\rho^2} + \frac{b^2 \sin\rho}{\rho^3}, \qquad
e^1{}_b \;=\; \frac{ab\,(\rho - \sin\rho)}{\rho^3},
$$

$$
e^2{}_a \;=\; \frac{ab\,(\rho - \sin\rho)}{\rho^3}, \qquad
e^2{}_b \;=\; \frac{a^2 \sin\rho}{\rho^3} + \frac{b^2}{\rho^2},
$$

$$
\omega_{\mathfrak{h}}^{\;3} \;=\; \frac{1 - \cos\rho}{\rho^2}\,
(b\, da - a\, db).
$$

These are not pretty in $(a, b)$ coordinates. But the vielbein
determinant simplifies dramatically:

$$
\det\!\begin{pmatrix} e^1{}_a & e^1{}_b \\ e^2{}_a & e^2{}_b \end{pmatrix}
\;=\; \frac{\sin\rho}{\rho}.
$$

This is *the* key formula. It is nonzero on the open disc
$0 < \rho < \pi$, vanishes first at $\rho = \pi$, becomes negative for
$\pi < \rho < 2\pi$, vanishes again at $\rho = 2\pi$, and so on. The
chart is non-singular only inside the disc of radius $\pi$ centered at
the origin in $(a, b)$ space.

**Cleaning up by switching to geodesic-polar coordinates.** Set
$a = \rho \cos\psi$, $b = \rho \sin\psi$, so $\rho \ge 0$ is the
geodesic distance from the basepoint and $\psi$ is the angle around
it. Then $da = \cos\psi\, d\rho - \rho \sin\psi\, d\psi$ and
$db = \sin\psi\, d\rho + \rho \cos\psi\, d\psi$. Substituting and
simplifying:

$$
\boxed{\;e^1 \;=\; \cos\psi\, d\rho - \sin\rho\, \sin\psi\, d\psi, \quad
e^2 \;=\; \sin\psi\, d\rho + \sin\rho\, \cos\psi\, d\psi.\;}
$$

$$
\boxed{\;\omega_{\mathfrak{h}}^{\;3} \;=\; (\cos\rho - 1)\, d\psi.\;}
$$

In these coordinates, the vielbein determinant is $\sin\rho$ — the
$1/\rho$ singularity at the origin came purely from the conversion
$(a, b) \leftrightarrow (\rho, \psi)$, the usual artifact of polar
coordinates at the origin. The remaining zero at $\rho = \pi$ is the
genuine failure of the section.

##### Step 3 — invariance equation

Unchanged: $\mathrm{ad}_{J^3}|_{\mathfrak{m}}$ is a $90°$ rotation in
the $(J^1, J^2)$-plane, and the invariance equation gives $\eta =
\lambda\, I_{2 \times 2}$ with $\lambda > 0$. Set $\lambda = R^2$ to
match the standard convention.

##### Step 4 — assemble the metric

$g = \eta_{ab}\, e^a \otimes e^b = R^2\, ((e^1)^2 + (e^2)^2)$ in
geodesic-polar coordinates:

$$
g \;=\; R^2\, \big[(\cos\psi\, d\rho - \sin\rho\, \sin\psi\, d\psi)^2
+ (\sin\psi\, d\rho + \sin\rho\, \cos\psi\, d\psi)^2\big].
$$

The cross-terms cancel (the $\cos\psi \sin\psi$ pieces have opposite
signs) and the diagonal terms collapse by
$\cos^2\psi + \sin^2\psi = 1$:

$$
\boxed{\;ds^2 \;=\; R^2\,(d\rho^2 + \sin^2\rho\, d\psi^2).\;}
$$

Setting $R = 1$: $ds^2 = d\rho^2 + \sin^2\rho\, d\psi^2$. This *is* the
round metric on the unit sphere — the same intrinsic geometry as
$ds^2 = d\theta^2 + \sin^2\theta\, d\phi^2$ from the streamlined polar
derivation. The geodesic-polar coordinates $(\rho, \psi)$ are
essentially relabelled colatitude/longitude: $\theta = \rho$ (on a
unit sphere, colatitude *is* the geodesic distance from the pole), and
$\phi = \psi$ (longitude *is* the angle around the pole). The two
sections produce identical metrics up to this relabelling.

##### What "fails" — and what it teaches us

The Cartesian-like section on $S^2$ does *not* fail algebraically.
The four-step algorithm runs to completion and produces the correct,
$SO(3)$-invariant, constant-curvature round metric. What is different
from $\mathbb{R}^2$ Cartesian is in the columns below:

| Property | $\mathbb{R}^2$ Cartesian | $S^2$ Cartesian-like |
|---|---|---|
| Section | $\exp(xP^1 + yP^2)$ | $\exp(aJ^1 + bJ^2)$ |
| BCH series | Terminates ($V^2 = 0$) | Doesn't terminate (Rodrigues) |
| Vielbein in section coords | Identity | $\sin\rho/\rho$-modulated |
| Spin connection | $0$ identically | $(\cos\rho - 1)\, d\psi \neq 0$ |
| Vielbein determinant | $1$ everywhere | $\sin\rho$, vanishes at $\rho = 0, \pi$ |
| Global chart? | Yes — covers all of $\mathbb{R}^2$ | No — covers $S^2 \setminus \{\text{south pole}\}$ |
| Curvature | $0$ | $1/R^2$ |

The non-trivial entries on the right are not flaws in the algorithm —
they are the algebra honestly reporting the geometry of the sphere:

- The non-vanishing $\omega_{\mathfrak{h}} = (\cos\rho - 1)\, d\psi$
  is the canonical Cartan connection for the round metric. Its
  exterior derivative $d\omega_{\mathfrak{h}} = \sin\rho\, d\rho \wedge
  d\psi$, times $J^3$, encodes the constant positive Gaussian
  curvature $K = 1/R^2$.
- The vanishing of $\det e^a{}_\mu = \sin\rho$ at $\rho = \pi$ is the
  algebra reporting the **injectivity radius** of the exponential map.
  Geometrically: a tangent vector at the north pole of length $\pi$
  traces out a half-great-circle and reaches the south pole; tangent
  vectors of length $\pi$ in *all* directions $\psi$ converge to the
  same antipodal point. The chart cannot distinguish them, so the
  Jacobian collapses.
- Beyond $\rho = \pi$ the exponential map is no longer injective at
  all; tangent vectors of length $\rho + 2\pi$ produce the same group
  element as those of length $\rho$. The Cartesian-like chart cannot
  be extended to all of $S^2$ no matter how cleverly you stitch it.

So no algebraic failure. The *only* failure is **topological**: $S^2$
is compact and cannot be covered by a single $\mathbb{R}^2$-valued
chart. The algebra-level signal of this — visible already before any
matrix arithmetic — is that the bracket $[J^1, J^2] = J^3$ lives in
$\mathfrak{h}$, not in $\{0\}$. That is precisely the curvature of
the canonical connection, and it is also precisely what prevents the
exponential map from being a global diffeomorphism.

The price of insisting on a single-exponential, Cartesian-like
section on $S^2$ is therefore: (i) an incomplete chart (missing one
point), and (ii) metric components $(d\rho^2, \sin^2\rho\, d\psi^2)$
that — by coincidence of $\theta = \rho$ on the unit sphere — happen
to match the usual spherical form anyway. The product section
$\sigma = e^{\phi J^3}\, e^{\theta J^2}$ trades these for a chart
that is *also* incomplete (the poles are singular there too) but
where the metric components are immediately recognizable from
elementary spherical geometry. Both sections describe the same
Riemannian manifold; only the coordinate dress is different.

#### The other Klein pair: $G/\{0\}$ as a 3-manifold

The enumeration of proper subalgebras of $\mathfrak{so}(3)$ at the
start of this section listed two non-trivial Klein-pair choices:
$\mathfrak{h} = \mathrm{span}(n^i J^i)$ for some axis (giving $S^2$),
and $\mathfrak{h} = \{0\}$ (giving the whole group manifold). The
first occupied the rest of the section; we now run the algorithm with
the second choice for completeness.

The setup is

$$
\mathfrak{h} = \{0\}, \qquad
\mathfrak{m} = \mathfrak{so}(3) = \mathrm{span}(J^1, J^2, J^3).
$$

The space $G/\{0\}$ is literally the group manifold $G$, and its
identity depends on which integration of $\mathfrak{so}(3)$ we take:

| Group | $G/\{0\}$ | Topology |
|---|---|---|
| $SO(3)$ | $SO(3)$ | $\mathbb{RP}^3 = S^3/\mathbb{Z}_2$ |
| $SU(2)$ (simply connected cover) | $SU(2)$ | $S^3$ |

Both are 3-dimensional and carry constant positive sectional
curvature; they differ by an antipodal $\mathbb{Z}_2$ identification.
The Lie algebra alone does not distinguish them — only the global
group does. Below we work with $G = SO(3)$ (the adjoint representation
we have used throughout); $SU(2)$ would yield exactly the same local
formulas with a doubled $r$-range.

##### Step 1 — structure constants

Unchanged: $[J^i, J^j] = \epsilon^{ijk}\, J^k$.

##### Step 2 — Maurer–Cartan form

Take the geodesic-normal section

$$
\sigma(x^1, x^2, x^3) \;=\; \exp(x^1 J^1 + x^2 J^2 + x^3 J^3),
$$

a single exponential parameterized by the whole $\mathfrak{m}$.
Geometrically, $\sigma$ is a rotation by angle $r = \sqrt{(x^1)^2 +
(x^2)^2 + (x^3)^2}$ about the axis $(x^1, x^2, x^3)/r$. The Rodrigues
formula gives

$$
\sigma \;=\; I + \frac{\sin r}{r}\, V
            + \frac{1 - \cos r}{r^2}\, V^2, \qquad
V \;=\; x^a J^a.
$$

Express $\vec x$ in spherical coordinates: $\vec x = r\,\hat n(\theta,
\phi)$ with $\hat n = (\sin\theta \cos\phi, \sin\theta \sin\phi,
\cos\theta)$. Then $r \in [0, \pi]$ covers all of $SO(3)$ (rotations
of any axis up to angle $\pi$; at $r = \pi$ a rotation by $\pi$ about
$\hat n$ equals one about $-\hat n$, the antipodal identification of
$\mathbb{RP}^3$). The coordinates $(r, \theta, \phi)$ are
**three-dimensional geodesic-polar coordinates** centered at the
identity.

A direct computation of $\omega = \sigma^{-1}\, d\sigma$ (using the
identity $\omega = (1 - e^{-\mathrm{ad}_V})/\mathrm{ad}_V \cdot dV$
truncated by $(\mathrm{ad}_V)^3 = -r^2\, \mathrm{ad}_V$, or
equivalently via direct matrix algebra; verified by
[`klein_geometry.py`](klein_geometry.py)) gives a $3 \times 3$
vielbein

$$
(e^a{}_\mu) \;=\; \begin{pmatrix}
\sin\theta \cos\phi & * & * \\
\sin\theta \sin\phi & * & * \\
\cos\theta          & -\sin r\, \sin\theta & (\cos r - 1)\sin^2\theta
\end{pmatrix},
$$

whose first column is just $\hat n$ (so $e^a$ at $\theta, \phi$ in
the radial direction points along $\hat n$ — the radial geodesic),
and whose orthogonal columns combine $\sin r$ and $1 - \cos r$
factors. The remaining entries are not crucial; what matters is the
resulting metric, computed below.

##### Step 3 — invariance equation

Here is the new twist. The invariance equation must hold for every
$Z \in \mathfrak{h}$, but $\mathfrak{h} = \{0\}$ has no non-zero
elements. The equation is therefore **vacuous**: any symmetric
$3 \times 3$ matrix $\eta_{ab}$ is allowed.

This is six parameters of freedom in $\eta$ — more than the
single-parameter family $\eta = \lambda I_{2 \times 2}$ we got on
$S^2$. The reason: with no $\mathfrak{h}$-symmetry to enforce, the
algorithm produces a generic *left-invariant* metric on $G$, not a
distinguished bi-invariant one.

To single out a "natural" choice we impose one further requirement:
invariance under the *adjoint action of the full group* $G$ — i.e.,
$\eta$ must be $\mathrm{ad}_X$-invariant for every $X \in
\mathfrak{g}$, not just for $X \in \mathfrak{h}$. This is the
*bi-invariance* condition. For a compact simple Lie algebra such as
$\mathfrak{so}(3)$, the unique (up to scale) bi-invariant inner
product is (the negative of) the **Killing form**:

$$
K(J^i, J^j) \;=\; \mathrm{tr}(\mathrm{ad}_{J^i}\, \mathrm{ad}_{J^j})
\;=\; -2\, \delta_{ij}.
$$

Taking $\eta_{ab} = \lambda\, \delta_{ab}$ with $\lambda > 0$ for a
Riemannian (positive-definite) metric makes the resulting geometry
the standard bi-invariant metric on the group.

##### Step 4 — assemble the metric

With $\eta_{ab} = \delta_{ab}$, computing
$g = \delta_{ab}\, e^a \otimes e^b$ in $(r, \theta, \phi)$ coordinates:

$$
\boxed{\;ds^2 \;=\; dr^2 + 4\sin^2\!\tfrac{r}{2}\,
(d\theta^2 + \sin^2\theta\, d\phi^2),\quad
r \in [0, \pi].\;}
$$

This is exactly the round metric on the **3-sphere of radius 2**
restricted to the closed ball $r \le \pi$, with the antipodal
identification at $r = \pi$. To see this, substitute $\chi = r/2$:

$$
ds^2 \;=\; 4\, d\chi^2 + 4 \sin^2\chi\,
(d\theta^2 + \sin^2\theta\, d\phi^2)
\;=\; 4\,\Big[\, d\chi^2 + \sin^2\chi\, d\Omega_{S^2}^2\,\Big],
$$

which is $4$ times the standard unit-radius $S^3$ metric in
geodesic-polar coordinates, with $\chi \in [0, \pi/2]$. So we have
covered a closed hemisphere of unit $S^3$; the equatorial $S^2$ at
$\chi = \pi/2$ (i.e., $r = \pi$) is identified antipodally, giving
$\mathbb{RP}^3 = SO(3)$.

Rescaling $\eta_{ab} = \tfrac{1}{4}\, \delta_{ab}$ would produce
the round unit-radius $\mathbb{RP}^3$ instead. Lifting to $G = SU(2)$
extends the $r$-range to $[0, 2\pi]$ (with $r = 2\pi$ identified with
the identity rotation) and recovers the full unit $S^3$. The
intrinsic Riemannian geometry — constant positive sectional curvature
— is the same throughout this family of normalizations.

##### Connection to the later $S^3 = SO(4)/SO(3)$ derivation

The 3-sphere also appears later in this document as a different Klein
quotient: $S^3 = SO(4)/SO(3)$, built from the algebra $\mathfrak{so}(4)$.
That construction is genuinely independent of the present one — it uses
a *bigger* algebra ($\mathfrak{so}(4)$ has six generators, not three),
with $\mathfrak{m}$ four-dimensional minus a three-dimensional stabilizer.
The fact that both constructions land on the same manifold $S^3$ is
because $\mathfrak{so}(4) \cong \mathfrak{so}(3) \oplus \mathfrak{so}(3)$
and the diagonal $\mathfrak{so}(3)$-action realizes $S^3$ as a coset.
We do not pursue this isomorphism here, but it is the algebraic reason
the two constructions agree on the geometry while differing on
group-theoretic ancillary data.

#### Why $\mathbb{R}^3$ is not a Klein quotient of $\mathfrak{so}(3)$, even though $S^2 \subset \mathbb{R}^3$

A natural question arises from comparing the $\mathfrak{so}(3)$
classification above with the Euclidean algebra $\mathfrak{e}(3) =
\mathfrak{so}(3) \ltimes \mathbb{R}^3$ of Part III. The rotation
generators are *literally the same* — $\mathfrak{so}(3) \subset
\mathfrak{e}(3)$ as a subalgebra — and the resulting space $S^2$ sits
inside $\mathbb{R}^3$ as a unit sphere. So why doesn't $\mathfrak{so}(3)$
alone produce $\mathbb{R}^3$? The Lie algebra is a *subset* of the
bigger one; why aren't the spaces?

The short answer is that the Klein construction outputs the space whose
*symmetries* the algebra encodes. Rotations alone are not enough
symmetry to move every point of $\mathbb{R}^3$ to every other point —
they only move points around *within* spheres of constant radius. The
translations $P^i$ in $\mathfrak{e}(3)$ are exactly what allows you to
jump from one sphere to another.

Let us spell this out from three perspectives.

##### 1. Group action: rotations alone are not transitive

A homogeneous space is one on which the group acts *transitively*: any
point can be moved to any other point by some group element. $SO(3)$
acts on $\mathbb{R}^3$ by rotations centered at the origin, and these
preserve the radial coordinate $|\vec r|$. So:

- The orbit of a point $\vec r$ under $SO(3)$ is the sphere
  $\{|\vec r'| = |\vec r|\}$ of the same radius.
- Two points with different radii cannot be related by any rotation.
- $SO(3)$ acts transitively on each sphere $S^2_r$ separately,
  but *not* on $\mathbb{R}^3$ as a whole.

So $\mathbb{R}^3$ is not a homogeneous space of $SO(3)$. It is
*foliated* by $SO(3)$-orbits — spheres of varying radii (plus the
fixed origin) — and each leaf is an $S^2$. To make $\mathbb{R}^3$
itself homogeneous, you must enlarge the group by adding
transformations that *move between* the orbits. The minimal such
enlargement is to add translations: any two points are connected by a
unique translation. The result is the Euclidean group $E(3)$, with Lie
algebra $\mathfrak{e}(3) = \mathfrak{so}(3) \ltimes \mathbb{R}^3$.

##### 2. Dimension count: what Klein quotients of $\mathfrak{so}(3)$ are available

The Klein construction outputs spaces of dimension $\dim G - \dim H$,
where $H$ runs over the proper subalgebras of $\mathfrak{g}$. For
$\mathfrak{so}(3)$ (dimension 3) the options are exactly:

| $\dim \mathfrak{h}$ | $\dim G/H$ | Space |
|---|---|---|
| 0 | 3 | Group manifold $SO(3) = \mathbb{RP}^3$ (or $S^3 = SU(2)$) |
| 1 | 2 | $S^2$ |
| 2 | — | (no 2-dim subalgebra exists) |
| 3 | 0 | Point |

The 3-dimensional output is the group manifold — and the group
manifold of $\mathfrak{so}(3)$ is *compact* ($\mathbb{RP}^3$ or
$S^3$, both finite volume). It cannot be $\mathbb{R}^3$. The
compactness is an *algebraic* feature, visible already on the Killing
form: $K(J^i, J^j) = -2\, \delta^{ij}$ is **negative definite**, which
by Cartan's criterion is the signature of a compact semisimple Lie
algebra. There is no way to integrate $\mathfrak{so}(3)$ to a
non-compact Lie group.

By contrast, $\mathfrak{e}(3)$ has dimension 6, the right amount to
fit $\mathbb{R}^3 = E(3)/SO(3)$ as $\dim = 6 - 3 = 3$. The translation
subalgebra $\mathfrak{t}^3 \subset \mathfrak{e}(3)$ is itself a *non-
compact* abelian Lie algebra (the additive group $\mathbb{R}^3$), and
this non-compactness is what gives $\mathbb{R}^3$ its non-compact
character.

##### 3. The "stacking $S^2$'s" picture is exactly right

The intuition — $\mathbb{R}^3$ is foliated by $S^2$'s of all radii —
captures the geometric content precisely. Three statements make this
rigorous:

**(a) Foliation by $SO(3)$-orbits.** $\mathbb{R}^3 \setminus \{0\}$
is fibered by $SO(3)$-orbits via

$$
\mathbb{R}^3 \setminus \{0\} \;\cong\; S^2 \times \mathbb{R}_{>0},
\qquad \vec r \mapsto (\hat r, |\vec r|),
$$

and the origin is the unique $SO(3)$-fixed point. Each fiber is a
copy of $S^2 = SO(3)/SO(2)$. So $\mathbb{R}^3$ is (topologically) a
cone over $S^2$: the trivial bundle $S^2 \times [0, \infty)$ with the
$S^2$-fiber at zero collapsed to a point.

**(b) $\mathfrak{e}(3)$ knows about both layers, $\mathfrak{so}(3)$
about only one.** Inside $\mathfrak{e}(3) = \mathfrak{so}(3) \oplus
\mathfrak{t}^3$ (as a vector space), rotations move points within a
sphere and translations move them across spheres. The semidirect
bracket $[J^i, P^j] = \epsilon^{ijk} P^k$ encodes that the $P^j$'s
transform as a vector under rotations — precisely what is needed to
make the foliation above $SO(3)$-equivariant.

**(c) Algebraic inclusion vs. space inclusion go in opposite
directions.** This is the part that can feel counterintuitive.
Embedding $\mathfrak{so}(3) \hookrightarrow \mathfrak{e}(3)$ gives
*fewer* symmetries, not more, and produces a *smaller* (lower-
dimensional) space:

- $\mathfrak{so}(3)$ sees only the angular directions $\hat r$ — its
  homogeneous quotient is $S^2$, two-dimensional.
- $\mathfrak{e}(3) \supset \mathfrak{so}(3)$ adds the radial direction
  via translations — its homogeneous quotient is $\mathbb{R}^3$,
  three-dimensional.

The geometric inclusion $S^2 \hookrightarrow \mathbb{R}^3$ corresponds
to the *pair* of algebra inclusions $\mathfrak{so}(3) \subset
\mathfrak{e}(3)$ *and* $\mathfrak{u}(1) \subset \mathfrak{so}(3)$
(stabilizer of a point on $S^2$ as subgroup of the rotation
stabilizer of the origin in $\mathbb{R}^3$). Together these make the
embedding $SO(3)$-equivariant.

##### 4. The slogan

The general lesson is that *the same algebra can describe the
symmetries of geometrically different objects*, and *different
algebras can produce the same object via different routes*:

- $\mathfrak{so}(3)$ produces both $S^2$ and $\mathbb{RP}^3$ — same
  algebra, different Klein pairs, different manifolds.
- $S^3$ arises both as $SU(2)$ (= group manifold of $\mathfrak{so}(3)$
  with $\mathfrak{h} = 0$) and as $SO(4)/SO(3)$ (a different algebra,
  a different $\mathfrak{h}$). Same manifold, different algebraic
  routes.

The Klein *pair* $(\mathfrak{g}, \mathfrak{h})$, not the algebra
alone, is what determines the space. So the right comparison between
$\mathfrak{so}(3)$ and $\mathfrak{e}(3)$ is not "same algebra,
different spaces" — it's *different Klein pairs* whose spaces are
geometrically nested:

| Klein pair | Space | Role of $\mathfrak{so}(3)$ |
|---|---|---|
| $(\mathfrak{e}(3), \mathfrak{so}(3))$ | $\mathbb{R}^3$ | The stabilizer of the origin |
| $(\mathfrak{so}(3), \mathfrak{u}(1))$ | $S^2$ | The full symmetry group |

Climbing from the lower row to the upper row corresponds to embedding
the unit sphere into Euclidean space: $S^2 \hookrightarrow
\mathbb{R}^3$. The same generators $J^i$ play different roles —
*symmetries* of the smaller space (on $S^2$) become *stabilizers* of
a basepoint in the bigger space (in $\mathbb{R}^3$). This is the
algebraic signature of "thinking of $S^2$ as the unit sphere of
$\mathbb{R}^3$".

### The 3-sphere $S^3$

The algebra $\mathfrak{so}(4)$ has six generators. Writing them as
$\{J^i, K^i\}$ ($i = 1, 2, 3$) — three "spatial" rotations and three
"tilts" of the fourth axis toward each spatial axis — the brackets are

$$
[J^i, J^j] = \epsilon^{ijk} J^k, \qquad
[J^i, K^j] = \epsilon^{ijk} K^k, \qquad
[K^i, K^j] = \epsilon^{ijk} J^k.
$$

These match Poincaré except for the sign of $[K, K]$, which here is
$+\epsilon J$ instead of $-\epsilon J$ — a positive sign, since the
fourth axis enters with Euclidean (not Lorentzian) signature.

**Klein-pair candidates.** $\mathfrak{so}(4) \cong \mathfrak{so}(3)
\oplus \mathfrak{so}(3)$ via $L^i = \tfrac{1}{2}(J^i + K^i)$, $R^i =
\tfrac{1}{2}(J^i - K^i)$, with $[L^i, R^j] = 0$. The natural
subalgebras include:

- $\{0\}$: $G/H$ is $SO(4)$ itself, six-dimensional.
- The "diagonal" $\mathfrak{so}(3) = \{J^i\}$: gives $\dim G/H = 3$. This
  is our choice — $S^3 = SO(4)/SO(3)$.
- $\mathfrak{so}(3)_L = \{L^i\}$ or $\mathfrak{so}(3)_R = \{R^i\}$: each
  also has $\dim G/H = 3$. These exhibit $S^3$ as the group manifold of
  $SU(2)$ with its bi-invariant metric — the same Riemannian manifold,
  realised via the group-manifold construction.
- 1-dim subalgebras (e.g. a single $J^i$ or $K^i$): give 5-dim
  homogeneous spaces, related to the Hopf fibration.

For "the standard 3-sphere of points" the diagonal choice $\mathfrak{h} =
\{J^i\}$ is the one that matches the orbit–stabilizer analysis:
rotations among the three spatial axes fix the north pole on the
fourth axis, while $K^1, K^2, K^3$ tilt the pole tangentially in three
independent directions. So
$\mathfrak{m} = \{K^1, K^2, K^3\}$ and

$$
S^3 = SO(4)/SO(3).
$$

**Reductive check.** $[\mathfrak{h}, \mathfrak{m}] = [J^i, K^j] =
\epsilon^{ijk} K^k \in \mathfrak{m}$ ✓. And $[\mathfrak{m},
\mathfrak{m}] = [K^i, K^j] = \epsilon^{ijk} J^k \in \mathfrak{h}$, so
again $S^3$ is a symmetric space.

**Metric derivation.** Set $g(K^i, K^j) = \eta^{ij}$, symmetric $3
\times 3$. The Leibniz condition with $X = J^k$ is

$$
g(\epsilon^{kil} K^l, K^j) + g(K^i, \epsilon^{kjl} K^l) = 0
\quad\Longleftrightarrow\quad
\epsilon^{kil} \eta^{lj} + \epsilon^{kjl} \eta^{il} = 0,
$$

which is *exactly* the same equation as for $\mathbb{R}^3$ (with $K$
playing the role of $P$). The unique solution up to scale is

$$
\boxed{\;\eta^{ij} = \delta^{ij} = \operatorname{diag}(1, 1, 1)\;}
$$

and the resulting $G$-invariant metric on $S^3$ is the round metric of
radius $R$ (with $R^2$ proportional to $\lambda$). As in the $S^2$ case,
this $\delta^{ij}$ is the metric in the orthonormal frame $\{K^1, K^2,
K^3\}$ at the basepoint (and globally, by $G$-equivariance). In
hyperspherical coordinates $(\chi, \theta, \phi)$ the same metric reads

$$
ds^2 = R^2\bigl(d\chi^2 + \sin^2\chi\,(d\theta^2 + \sin^2\theta\, d\phi^2)\bigr),
$$

with the coordinate-dependent factors $\sin^2\chi$ and $\sin^2\theta$
arising — exactly as for $S^2$ — from the coordinate basis vectors having
varying length, not from any change in the underlying bilinear form. The
soldering form is $e^1 = R\,d\chi$, $e^2 = R\sin\chi\,d\theta$,
$e^3 = R\sin\chi\sin\theta\,d\phi$, and $g = \delta_{ab}\, e^a \otimes e^b$.

The bracket $[K^i, K^j] = \epsilon^{ijk} J^k$ — the one that distinguishes
$\mathfrak{so}(4)$ from $\mathfrak{e}(3)$ — does *not* enter the metric
derivation at all, because the right-hand side lies in $\mathfrak{h}$,
not in $\mathfrak{m}$. It determines instead the **curvature** of the
space: constant positive sectional curvature $1/R^2$.

### Same algebra-to-metric machinery, different curvature

Comparing the four cases $\mathbb{R}^2$, $\mathbb{R}^3$, $S^2$, $S^3$
side by side, the picture is now uniform. In every case the metric on
$\mathfrak{m}$ comes out as

$$
\eta^{ij} \;\propto\; \delta^{ij},
$$

and the only input to this derivation is the bracket $[\mathfrak{h},
\mathfrak{m}]$ — which has the same structure ($\mathfrak{so}(n)$ acting
on its defining $n$-dim representation) in all four cases. What
changes from one space to another is *not* the metric formula but the
bracket $[\mathfrak{m}, \mathfrak{m}]$:

| Space | Algebra $\mathfrak{g}$ | $\mathfrak{h}$ | $\mathfrak{m}$ | $[\mathfrak{m}, \mathfrak{m}]$ | Curvature |
|---|---|---|---|---|---|
| $\mathbb{R}^2$ | $\mathfrak{e}(2)$ | $\{J\}$ | $\{P^1, P^2\}$ | $0$ | $0$ (flat) |
| $\mathbb{R}^3$ | $\mathfrak{e}(3)$ | $\{J^i\}$ | $\{P^i\}$ | $0$ | $0$ (flat) |
| $S^2$ | $\mathfrak{so}(3)$ | $\{J^3\}$ | $\{J^1, J^2\}$ | $\subset \mathfrak{h}$ | $+1/R^2$ |
| $S^3$ | $\mathfrak{so}(4)$ | $\{J^i\}$ | $\{K^i\}$ | $\subset \mathfrak{h}$ | $+1/R^2$ |

The hyperbolic space $H^n$ would appear with $\mathfrak{g} =
\mathfrak{so}(n, 1)$ and $[\mathfrak{m}, \mathfrak{m}] \subset
\mathfrak{h}$ with the *opposite* sign, giving constant negative
curvature $-1/R^2$ — and Minkowski space sits in the same family with
$\mathfrak{m}$ an abelian ideal but $\mathfrak{h} = \mathfrak{so}(3, 1)$
instead of $\mathfrak{so}(4)$, producing the signature flip $\delta^{ij}
\to \operatorname{diag}(-1, 1, 1, 1)$.

The single algebraic distinction "$[\mathfrak{m}, \mathfrak{m}] = 0$ vs.
$\subset \mathfrak{h}$" thus separates the *flat* model spaces
(Minkowski, Galilean, Euclidean) from the *curved* constant-curvature
ones (spheres, hyperbolic, de Sitter, anti-de Sitter). The metric on
$\mathfrak{m}$, in every case, is fixed by the same Leibniz invariance
condition.

---

## Summary

In **one** algebraic principle — that $\eta$ be invariant under the
adjoint action of $\{J_i, K_i\}$ —

$$
g([X, P^\mu], P^\nu) + g(P^\mu, [X, P^\nu]) = 0,
$$

the spacetime metric is completely determined by the commutation relations:

| Algebra | $\mathfrak{h}$ | $\mathfrak{m}$ | $[\mathfrak{m}, \mathfrak{m}]$ | Invariants on $\mathfrak{m}$ | Curvature |
|---|---|---|---|---|---|
| Poincaré | $\{J_i, K_i\}$ | $\{H, P^i\}$ | $0$ | $\eta^{\mu\nu} = \operatorname{diag}(-1, 1, 1, 1)$ (Minkowski) | $0$ |
| Galilei (bare) | $\{J_i, K_i\}$ | $\{H, P^i\}$ | $0$ | $\eta = \operatorname{diag}(1, 0, 0, 0)$, $\xi = \operatorname{diag}(0, 1, 1, 1)$ (degenerate pair) | $0$ |
| $\mathfrak{e}(2)$ | $\{J\}$ | $\{P^i\}$ | $0$ | $\eta^{ij} = \delta^{ij}$ (Euclidean) | $0$ |
| $\mathfrak{e}(3)$ | $\{J^i\}$ | $\{P^i\}$ | $0$ | $\eta^{ij} = \delta^{ij}$ (Euclidean) | $0$ |
| $\mathfrak{so}(3)$ | $\{J^3\}$ | $\{J^1, J^2\}$ | $\subset \mathfrak{h}$ | $\eta^{ab} = \delta^{ab}$ | $+1/R^2$ |
| $\mathfrak{so}(4)$ | $\{J^i\}$ | $\{K^i\}$ | $\subset \mathfrak{h}$ | $\eta^{ij} = \delta^{ij}$ | $+1/R^2$ |

The pattern is uniform across all rows: the Leibniz invariance condition
on $\mathfrak{m}$, given the action $[\mathfrak{h}, \mathfrak{m}]$, fixes
the metric uniquely (up to overall scale). The Poincaré/Galilei split
comes from the bracket $[K, P]$ (yielding $H$ versus $0$), which controls
the *signature* / non-degeneracy of the metric. The flat/curved split
comes from the bracket $[\mathfrak{m}, \mathfrak{m}]$ (vanishing versus
landing in $\mathfrak{h}$), which controls the *curvature* of the
homogeneous space.

## What the algebra determines (and what it doesn't)

Looking back across the six examples, the Leibniz condition is doing
something quite specific — and worth stating in its sharpest form.

For an isotropy representation $\rho: \mathfrak{h} \to
\mathfrak{gl}(\mathfrak{m})$, the Leibniz condition is the statement
"find the $\rho$-invariant symmetric bilinear forms on $\mathfrak{m}$."
This is a Schur's-lemma exercise, and the structure of the answer is
dictated entirely by the decomposition of $\mathfrak{m}$ under $\rho$.

**When $\rho$ is irreducible** — Poincaré, all $\mathfrak{e}(n)$,
all $\mathfrak{so}(n+1)$, all $\mathfrak{so}(n, 1)$, de Sitter,
anti-de Sitter — Schur's lemma forces the real vector space of invariant
symmetric forms to be one-dimensional. The answer is then:

- a **discrete** invariant — the *signature* of the form, fixed by which
  real form of the isotropy algebra ($\mathfrak{so}(p, q)$ for some
  $p + q = \dim\mathfrak{m}$) is acting;
- plus **one** continuous degree of freedom — an overall positive scalar
  (the unit of length squared).

So in this case the entire derivation produces *the signature plus one
scale*. The signature is forced by the algebra; the scale is free.

**When $\rho$ is reducible** — Galilei, Carrollian, and other limiting
algebras — the invariant forms decompose summand by summand. Each
irreducible piece contributes its own independent scale, and isomorphic
pieces can contribute additional off-diagonal mixing parameters. For
Galilei, $\mathfrak{m}$ splits as $\mathbb{R}_H \oplus \mathbb{R}^3$
under $SO(3)$, the two summands are non-isomorphic, and we get exactly
the two independent forms — the temporal $\tau$ and the spatial $h$ —
each with its own scale (the unit of time and the unit of length are
algebraically independent in non-relativistic physics).

**What is *not* derived.** The numerical values of the scales. The
algebra cannot know whether you mean meters or light-years; in the
irreducible case there is nothing else free, and in the reducible case
the freedom is exactly one positive number per irreducible summand
(plus any off-diagonal mixing among isomorphic summands).

**Scale ratios are fixed by the algebra.** In curved cases like $S^2$,
the bracket $[J^1, J^2] = J^3$ has a definite normalisation. Once we
pick the metric scale $\eta^{ab} = \lambda\, \delta^{ab}$, the Cartan
structure equation forces the sectional curvature to be $1/\lambda$:
metric and curvature scales are *not* independent. The algebra fixes
the **ratio** of (length scale)² to (curvature scale)⁻¹; only the
absolute scale is free.

The same applies on the Lorentzian side. Poincaré has a single scale,
so the speed of light $c$ is the *only* dimensionful constant relating
space and time, and the algebra lets us set $c = 1$ without loss. Galilei
has two independent scales, so $c$ has no algebraic meaning — it is
undefined, not merely unset.

**The clean statement.** The algebra determines:

1. the **signature** of the metric (a discrete invariant, fixed by the
   real form of the isotropy algebra);
2. the **dimensional structure** — how many independent scales appear,
   i.e., how many irreducible pieces $\mathfrak{m}$ has under $\rho$;
3. all **relations** among metric scales and curvature scale.

It does *not* determine the absolute numerical value of any scale. This
is exactly what one would want from a derivation that starts only with
abstract commutation relations: the algebra cannot know about units,
but it determines everything invariant under the choice of units.

## Mechanizing the algorithm

By this point the same steps have been performed by hand for six
examples: Minkowski, Galilean, $\mathbb{R}^2$, $\mathbb{R}^3$, $S^2$,
$S^3$. The procedure is mechanical. Given a faithful matrix
representation of $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$ and
a section $\sigma$, every step reduces to symbolic linear algebra. We
collect the algorithm in one place here, then describe a companion
SymPy script that runs it end-to-end.

### The algorithm

**Inputs.**

1. A faithful matrix representation $\rho \colon \mathfrak{g} \to
   \mathfrak{gl}(N, \mathbb{R})$ — i.e., a list of matrices $X_a$,
   $a = 1, \dots, \dim\mathfrak{g}$, forming a basis of $\mathfrak{g}$.
2. A partition of the basis indices into "stabilizer" indices
   $\mathcal{H} \subset \{1, \dots, \dim\mathfrak{g}\}$ and "complement"
   indices $\mathcal{M}$ — corresponding to the splitting
   $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$ that defines the
   Klein pair.
3. A coordinate chart $(x^\mu)$ on $G/H$ and a section
   $\sigma(x^\mu) \in G$ realizing it.

**Crank.**

*Step 1 — Structure constants.* Compute the commutators
$[X_a, X_b]$ in the matrix algebra, and decompose them on the basis:

$$
[X_a, X_b] = \sum_c f^c{}_{ab}\, X_c.
$$

Each decomposition is one linear system in $\dim\mathfrak{g}$ unknowns
(the coefficients $f^c{}_{ab}$).

*Step 2 — Maurer–Cartan form.* For each coordinate $x^\mu$, compute

$$
\omega_\mu \;\equiv\; \sigma^{-1}\, \partial_\mu\, \sigma
\;=\; \sum_a \omega^a{}_\mu\, X_a,
$$

and split into $\mathfrak{m}$- and $\mathfrak{h}$-parts: the vielbein
1-form components are $e^a{}_\mu = \omega^a{}_\mu$ for $a \in \mathcal{M}$,
and the spin-connection components are $\omega_{\mathfrak{h}}^A{}_\mu =
\omega^A{}_\mu$ for $A \in \mathcal{H}$.

*Step 3 — Invariance equations.* For each $A \in \mathcal{H}$, build the
$\dim\mathfrak{m} \times \dim\mathfrak{m}$ matrix
$\mathrm{ad}_{X_A}\big|_{\mathfrak{m}}$ from the structure constants
(its $(a, b)$ entry, with $a, b \in \mathcal{M}$, is $f^a{}_{Ab}$).
Solve the linear system

$$
\eta\, \mathrm{ad}_{X_A}\big|_{\mathfrak{m}}
+ \bigl(\mathrm{ad}_{X_A}\big|_{\mathfrak{m}}\bigr)^T\, \eta \;=\; 0
\qquad (A \in \mathcal{H})
$$

for the symmetric matrix $\eta = (\eta_{ab})_{a, b \in \mathcal{M}}$.
The solution space is finite-dimensional (an irreducible
$\mathfrak{h}$-rep on $\mathfrak{m}$ gives a 1-d family; reducible
$\mathfrak{m}$ gives one scale per irreducible piece).

*Step 4 — Metric in coordinates.* For any choice of $\eta$ in the
invariant family,

$$
g_{\mu\nu}(x) \;=\; \sum_{a, b \in \mathcal{M}} \eta_{ab}\, e^a{}_\mu(x)\, e^b{}_\nu(x).
$$

*Step 5 (optional) — Curvature.* Compute the Cartan curvature 2-form

$$
\Omega^A{}_{\mu\nu}
\;=\; \partial_\mu \omega_{\mathfrak{h}}^A{}_\nu
- \partial_\nu \omega_{\mathfrak{h}}^A{}_\mu
+ \sum_{B, C \in \mathcal{H}} f^A{}_{BC}\, \omega_{\mathfrak{h}}^B{}_\mu\, \omega_{\mathfrak{h}}^C{}_\nu.
$$

It vanishes iff the model space is flat (e.g. $\mathbb{R}^n$,
Minkowski, Galilean); on $S^n$ it is proportional to the volume form
with coefficient $1/R^2$.

*Step 6 (optional) — Killing vector fields.* For $\xi = \sum_a c_a X_a
\in \mathfrak{g}$ regarded as an infinitesimal generator on $G/H$, the
induced vector field is

$$
Y_\xi^\mu(x) \;=\; (e^{-1})^\mu{}_a(x)\, \bigl[\mathrm{Ad}_{\sigma(x)^{-1}}\, \xi\bigr]^a_{\mathfrak{m}},
$$

where $(e^{-1})^\mu{}_a$ is the inverse vielbein and the subscript
$\mathfrak{m}$ projects onto the $\mathcal{M}$-indices.

### Inputs the user has to supply

Three pieces cannot be deduced from the bare Lie algebra:

- **Subalgebra $\mathfrak{h}$.** Different stabilizer choices give
  different homogeneous spaces (Galilean spacetime vs. phase space, for
  instance; cf. Part II).
- **Section $\sigma$.** This selects coordinates. Different sections
  give different charts (Cartesian vs. polar vs. spherical) — the
  intrinsic geometry is unchanged.
- **Scale parameters in $\eta$.** Step 3 produces a family; physical
  units fix the numerical values.

Everything else — the vielbein, the connection, the curvature, the
Killing fields, the relations among scales — is determined by Steps
1–6 above.

### How much freedom is there in choosing the section?

Of the three user-supplied inputs above, the section is the one that
is purely a matter of coordinates — what *parametrization* you use,
not what *space* you describe. So in practice the natural follow-up
question is: how much freedom do you have? Is there always a
Cartesian-like choice that covers the whole space, like in the polar
$\mathbb{R}^2$ section above? For $S^2$, the spherical coordinates
worked, but did we get lucky — or could we have predicted in advance
which choices would and would not give a global chart?

The freedom is large, the obstructions are well-understood, and "luck"
plays no role: the bracket $[\mathfrak{m}, \mathfrak{m}]$ in the algebra
tells you in advance whether a global Cartesian-style section exists.

#### What counts as a section

Formally, a section over an open subset $U \subset G/H$ is any smooth
map $\sigma \colon U \to G$ such that projecting back to $G/H$ gives
the identity: $\pi(\sigma(x)) = x$. In plain terms, $\sigma(x)$ picks
one specific group element representing the coset of $x$. *Any* such
$\sigma$ is good for running the four-step algorithm, with one
technical requirement: the resulting vielbein must be non-singular on
$U$, i.e., $\det(e^a{}_\mu) \ne 0$. Otherwise the algorithm cannot
read off coordinates.

In practice, two natural families show up:

- **Exponential normal section.** $\sigma(x^a) = \exp(x^a X_a)$, where
  $X_a$ runs over a basis of $\mathfrak{m}$ only. Single exponential of
  an algebra element.
- **Product (nested) section.** $\sigma(x^1, x^2, \dots) =
  e^{x^1 X_{i_1}}\, e^{x^2 X_{i_2}}\, \cdots$, where each $X_{i_k}$ is
  some chosen generator from either $\mathfrak{m}$ or $\mathfrak{h}$.
  Each factor exponentiates a single generator.

The product form is more general: you can include $\mathfrak{h}$
-generators in the section (as we did with $J^3$ for spherical, $J$ for
polar). This is fine — the action of an $\mathfrak{h}$-generator on
the basepoint produces a non-trivial point in $G/H$ whenever it does
not commute with everything in $\mathfrak{m}$, so $\mathfrak{h}$
-factors carry geometric information too. They typically produce
*angular* coordinates (longitude, azimuth) that pair naturally with
radial $\mathfrak{m}$-coordinates.

#### Example A: Cartesian on $\mathbb{R}^2$

For $\mathfrak{e}(2)$ with $\mathfrak{m} = \mathrm{span}(P^1, P^2)$,
the exponential normal section is

$$
\sigma(x, y) \;=\; \exp(x\, P^1 + y\, P^2).
$$

Because $[P^1, P^2] = 0$, the Baker–Campbell–Hausdorff series
collapses: $\sigma(x, y)$ is simply the pure translation by $(x, y)$.
The product version $e^{xP^1}\, e^{yP^2}$ equals the same group
element, for the same reason. The Maurer–Cartan form is then

$$
\omega \;=\; \sigma^{-1}\, d\sigma \;=\; P^1\, dx + P^2\, dy,
$$

so the vielbein is the identity matrix, the spin connection vanishes,
and the metric is $g = dx^2 + dy^2$. This is *global*: the section is
defined on all of $\mathbb{R}^2$, and the vielbein is non-singular
everywhere. Cartesian coordinates cover the whole space.

#### Example B: "Cartesian-like" on $S^2$

The natural analogue for $\mathfrak{so}(3)$ with $\mathfrak{m} =
\mathrm{span}(J^1, J^2)$ is

$$
\sigma(a, b) \;=\; \exp(a\, J^1 + b\, J^2),
$$

i.e., a single rotation by some angle around an axis in the $xy$
-plane. This is a valid section, and in fact it gives **geodesic
normal coordinates** at the north pole — the radial parameter is the
geodesic distance from the pole. Re-parametrising
$a = \rho \cos\psi$, $b = \rho \sin\psi$ (so $\rho \ge 0$ is the
geodesic distance and $\psi$ is the angle around the basepoint),
direct computation gives

$$
e^1 \;=\; \cos\psi\, d\rho - \sin\rho\, \sin\psi\, d\psi, \qquad
e^2 \;=\; \sin\psi\, d\rho + \sin\rho\, \cos\psi\, d\psi,
$$

and the metric is

$$
g \;=\; (e^1)^2 + (e^2)^2
\;=\; d\rho^2 + \sin^2\rho\, d\psi^2,
$$

after using $\sin^2\psi + \cos^2\psi = 1$. This is the same round
metric we derived earlier with spherical coordinates — just with
$\rho$ now interpreted as colatitude and $\psi$ as longitude. The
intrinsic geometry is the same; only the coordinate labels differ.

The crucial point about *coverage*, though: this Cartesian-like
section does **not** cover the whole sphere. The vielbein
determinant in the $(\rho, \psi)$ coordinates above is

$$
\det\!\begin{pmatrix}
\cos\psi & -\sin\rho\, \sin\psi \\
\sin\psi & \sin\rho\, \cos\psi
\end{pmatrix}
\;=\; \sin\rho,
$$

which vanishes at $\rho = 0$ (the basepoint, a coordinate singularity
of the same kind as the origin in plane polars) and at $\rho = \pi$
(the antipodal south pole, a genuine wraparound — all values of $\psi$
collapse to the same group element there). The exponential
$\exp\colon \mathfrak{m} \to S^2$ wraps the open disc $\{\rho < \pi\}$
onto $S^2$ minus the south pole, and beyond $\rho = \pi$ the map is no
longer injective. The exponential normal section is a chart on an
open dense subset, not on all of $S^2$.

#### Algebraic foreknowledge: when does a global chart exist?

Here is the predictive content. From the bracket $[\mathfrak{m},
\mathfrak{m}]$ alone:

- **$[\mathfrak{m}, \mathfrak{m}] = 0$ (abelian $\mathfrak{m}$).** The
  exponential map $\mathfrak{m} \to G/H$ is a covering, and for
  simply-connected $G/H$ it is a global diffeomorphism. So an
  exponential normal section is good globally. This is the
  Cartesian situation. The same algebra-level signature also explains
  why the *position vector* is globally well-defined here (cf. the
  R² subsection on the position vector): both are consequences of
  abelian $\mathfrak{m}$.
- **$[\mathfrak{m}, \mathfrak{m}] \not\subset \{0\}$ (non-abelian
  $\mathfrak{m}$).** The exponential map is only a local
  diffeomorphism. In fact, $[\mathfrak{m}, \mathfrak{m}] \subset
  \mathfrak{h}$ is *precisely* the curvature of the canonical
  connection on $G/H$ in the abstract Cartan-geometric sense. For
  $S^2$, $[J^1, J^2] = J^3 \in \mathfrak{h}$ is the bracket that
  encodes the constant positive curvature $1/R^2$. From this single
  bracket we know in advance — without doing any computation — that
  no globally non-singular section can exist.

So no luck was involved. We *knew* on entering the $S^2$ calculation
that no chart would cover the whole sphere. The spherical product
section $e^{\phi J^3}\, e^{\theta J^2}$ and the geodesic normal
section $\exp(a J^1 + b J^2)$ are two different *local* charts; both
miss measure-zero subsets (the poles, or the antipodal point and the
basepoint), and they patch together via overlap maps in the standard
atlas-of-charts way. The Klein construction is happy with any one of
them.

#### Pragmatic guidance

- If $\mathfrak{m}$ is abelian, prefer the exponential normal section.
  It is global, the vielbein is the identity, the spin connection
  vanishes, and the metric in the resulting coordinates is the flat
  $\eta$-metric — exactly Cartesian. Cf. Example A.
- If $\mathfrak{m}$ is non-abelian, use whichever local section makes
  the symmetries of your problem manifest. The product section, with
  $\mathfrak{h}$-generators handling angular directions, is the
  standard recipe — and it is what produces polar / spherical
  coordinates throughout this document.
- Whatever section you choose, check $\det(e^a{}_\mu)$. Where it
  vanishes is a coordinate singularity, not an obstruction to the
  algorithm — just switch charts there.

In short, the section is a coordinate chart in the usual sense, and
the algebra tells you in advance whether a global chart exists. The
algorithm itself is indifferent: it produces the metric in whichever
coordinates the section delivers.

### The SymPy implementation

The script [`klein_geometry.py`](klein_geometry.py) in this repository
implements the algorithm as a `KleinGeometry` class with methods

```text
.structure_constants()      Step 1
.maurer_cartan()            Step 2  →  (ω_components, e, ω_h)
.invariant_forms()          Step 3  →  (η symbolic, free scales)
.metric(scale_subs=...)     Step 4
.curvature()                Step 5
.killing_field(ξ)           Step 6
```

The four canonical examples from this document are reproduced at the
bottom of the script: Minkowski $(1{+}1)$, Galilean $(1{+}1)$,
$\mathbb{R}^2$ in polar coordinates, and the round $S^2$. Running it
produces the algebra, the vielbein and connection, the dimension of
the invariant-form space, the explicit metric in the chosen chart, the
Cartan curvature, and the Killing fields — for each example.

Self-test output from running `python klein_geometry.py`:

```text
[R^2 polar]
  [OK] metric = dr^2 + r^2 dphi^2
  [OK] curvature is flat
  [OK] J = ∂_φ
  [OK] P^1 = cos(φ) ∂_r − (sin(φ)/r) ∂_φ

[S^2]
  [OK] metric = dθ^2 + sin^2θ dφ^2
  [OK] curvature = −sin(θ)   (so K = 1/R^2 > 0)

[Minkowski (1+1)]
  [OK] Minkowski signature is (−,+) or (+,−)
  [OK] Minkowski curvature flat

[Galilei (1+1)]
  [OK] Galilei: 1-d family of invariant (0,2) forms
  [OK] Galilei (0,2) form is degenerate clock dt^2
```

A few caveats worth noting:

- **Only reductive Klein geometries** are handled; the splitting
  $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$ with
  $[\mathfrak{h}, \mathfrak{m}] \subset \mathfrak{m}$ is built into
  Step 3. Parabolic (non-reductive) geometries need additional
  filtration data.
- **Only (0,2)-tensors** are enumerated. The Galilean cometric
  $h^{ij} \partial_i \otimes \partial_j$, a (2,0)-tensor, is a
  separate invariant the routine does not look for.
- **Local chart only.** The section $\sigma$ is the user's choice of
  coordinates; output is local to the chart's domain.

So the abstract narrative — "from commutators alone, by turning the
Maurer–Cartan crank, the metric falls out" — really is an algorithm.
The Lie algebra is the input; the metric, connection, curvature, and
isometry generators are the output. The script is a small worked
proof that the construction mechanizes.

## Comparison with [03-lie-groups.md](03-lie-groups.md)

The companion document postulates the boost generators as explicit $4 \times
4$ matrices acting on $(t, \vec x)$ and then solves $K^T B + B K = 0$ for the
invariant metric. The present derivation does not need any matrix
representation: the Leibniz invariance condition is applied directly to the
commutators of the abstract algebra. The final metrics agree.

---

## Outlook: from Klein to Cartan — the connection to general relativity

The Klein-geometry picture used above produces a single rigid model space
$G/H$ in which $G$ acts globally and the curvature is zero by construction.
Curved spacetimes of general relativity cannot be obtained this way, because
they have no transitive symmetry group. The required generalisation —
"Klein geometry made local" — is **Cartan geometry**.

A Cartan geometry modelled on the Klein pair $(\mathfrak{g}, \mathfrak{h})$
consists of a principal $H$-bundle $P \to M$ over a manifold $M$ of
dimension $\dim G/H$, together with a **Cartan connection** — a
$\mathfrak{g}$-valued 1-form $\omega \in \Omega^1(P, \mathfrak{g})$ that

- is a linear isomorphism $T_pP \to \mathfrak{g}$ at every $p \in P$,
- restricts on vertical (fibre) vectors to the Maurer–Cartan form of $H$, and
- is $H$-equivariant under the right action.

The first condition is the key one: $\omega$ identifies each tangent space
with the *full* model algebra $\mathfrak{g}$, not just $\mathfrak{m}$. So
the model $\mathfrak{g} = \mathfrak{h} \oplus \mathfrak{m}$ is present at
every point of $M$ — but only the isotropy subgroup $H$ acts globally on the
fibres. The **curvature**

$$
\Omega = d\omega + \tfrac{1}{2}[\omega, \omega]
$$

measures the failure of the Klein model to fit exactly: when $\Omega = 0$
the Cartan geometry is locally isomorphic to $G/H$. Cartan's intuitive
picture is that of rolling the model space $G/H$ along $M$ without
slipping; the connection $\omega$ encodes how the model tilts as it rolls,
and the curvature is the holonomy of a small loop.

For the Klein model $G/H = \text{Poincaré}/\text{Lorentz} = \mathbb{R}^{3,1}$
the splitting $\mathfrak{p} = \mathfrak{so}(3,1) \oplus \mathbb{R}^{3,1}$
decomposes the Cartan connection into two fields,

$$
\omega = \underbrace{\omega^a{}_b}_{\mathfrak{so}(3,1)\text{ part}}
\;\oplus\;
\underbrace{e^a}_{\mathbb{R}^{3,1}\text{ part}},
$$

which are exactly the **spin connection** and the **vierbein** of the
tetrad (or first-order) formulation of general relativity. The curvature
$\Omega$ splits in the same way:

| Cartan-geometry object | Name in GR |
|---|---|
| $\mathfrak{h}$-part of $\omega$ | spin connection $\omega^a{}_b$ |
| $\mathfrak{m}$-part of $\omega$ | vierbein $e^a$ |
| $\mathfrak{h}$-part of $\Omega$ | Riemann curvature $R^a{}_b$ |
| $\mathfrak{m}$-part of $\Omega$ | torsion $T^a$ |

Cartan's structure equations $T^a = de^a + \omega^a{}_b \wedge e^b$ and
$R^a{}_b = d\omega^a{}_b + \omega^a{}_c \wedge \omega^c{}_b$ are nothing but
the components of $\Omega = d\omega + \tfrac{1}{2}[\omega, \omega]$. This is
the **Einstein–Cartan formulation** of GR; imposing $T^a = 0$ determines
$\omega$ uniquely from $e$ (the Levi-Civita connection) and recovers
ordinary Einstein gravity.

The connection back to the present derivation is now direct. The
$\mathfrak{m}$-part of the Cartan connection — the vierbein $e^a$ —
identifies each tangent space $T_xM$ with the model translation subspace
$\mathfrak{m} = \mathbb{R}^{3,1}$. The bilinear form $\eta^{\mu\nu}$ we
derived above as the unique Lorentz-invariant form on $\mathfrak{m}$ is then
automatically a Lorentz-invariant form on every $T_xM$, and the spacetime
metric is

$$
g_{\mu\nu}(x) = \eta_{ab}\, e^a{}_\mu(x)\, e^b{}_\nu(x).
$$

The metric of a curved spacetime is, in this sense, "the Minkowski metric
of the Klein model, transported from point to point by the vierbein." The
signature, the Lorentz fibre symmetry, and the structure of the tangent
space are all inherited from the algebraic derivation of this note; what
Cartan geometry adds is the prescription for varying the model smoothly
across $M$.

The conceptual chain is therefore

$$
\text{Lie algebra}
\;\xrightarrow{\text{Klein pair}}\;
\text{flat model spacetime}
\;\xrightarrow{\text{Cartan connection}}\;
\text{curved spacetime of GR}.
$$

### Why the Klein pair is not ad hoc — the Erlangen Programme

The construction $G/H$ may at first look like an arbitrary technical
device. It is not. It is the precise mathematical articulation of Felix
Klein's **Erlangen Programme** (1872), which proposed that

> *a geometry is the invariant theory of a group action on a space.*

A geometry, in this view, is a pair $(X, G)$ with $G$ acting on $X$, and a
property is "geometric" exactly when it is preserved by every element of
$G$. This single idea unified the previously disparate Euclidean,
projective, affine, hyperbolic, and inversive geometries into a common
framework — each is characterised by its symmetry group acting on an
appropriate space.

Once one accepts the Erlangen point of view, the Klein pair $(G, H)$ is not
chosen but **forced** by an elementary theorem. Three steps:

1. *Homogeneity* — every point is to be on the same footing as every other
   (no preferred origin). This is the principle of relativity in its
   purest form: for spacetime, "no preferred event"; for space, "no
   preferred location."
2. *Pick a basepoint* $x_0 \in X$ and consider its stabilizer
   $H = \{g \in G : g \cdot x_0 = x_0\}$.
3. *Orbit–stabilizer theorem* — the map $g H \mapsto g \cdot x_0$ is a
   $G$-equivariant bijection $G/H \to X$.

So *any* homogeneous space of a Lie group $G$ is automatically of the form
$G/H$. The Klein pair is then the most economical encoding of "(symmetry
group) + (operational notion of a point)." In physics, $G$ comes from a
relativity principle and $H$ comes from "what fixes a chosen event." In
the Poincaré case this gives Minkowski space; in the Galilei case,
Galilean spacetime.

Of course the Erlangen viewpoint is not the *only* way to define a space.
Pure manifold theory ($M$ = topological space $+$ smooth atlas) imposes no
symmetry from the outset; metric-space, synthetic-axiomatic, algebraic,
sheaf-theoretic, topos-theoretic, and noncommutative formulations all
provide alternative foundations. What is special about the Klein–Cartan
viewpoint is that it is the foundation that puts *symmetry first*, which
is exactly what physical theories do.

### Scope of the framework

Within its proper domain — smooth manifolds with local Lie-group symmetry —
Cartan geometry is remarkably comprehensive. The same construction
specialises to:

| Klein model $G/H$ | Resulting geometry |
|---|---|
| $E(n)/SO(n)$ | Riemannian |
| Poincaré $/$ Lorentz | Pseudo-Riemannian / GR |
| Galilei $/\{J, K\}$ | Newton–Cartan |
| Conformal group $/$ stab. | Conformal |
| $\mathrm{PGL}(n{+}1)/$stab. | Projective |
| $\mathrm{Aff}(n)/\mathrm{GL}(n)$ | Affine |
| $\mathrm{Sp}(2n)/$stab. | Contact / projective contact |

Three-dimensional Euclidean space is the case $G/H = E(3)/SO(3)$. The
Cartan connection consists of an orthonormal frame field $e^a$ and a
rotation connection $\omega^a{}_b$; on flat $\mathbb{R}^3$ both torsion and
curvature vanish, while on a curved Riemannian 3-manifold the same data
describes the geometry. Curvilinear coordinates are simply a *change of
frame*: the vierbein $e^a{}_\mu$ relates the orthonormal frame to a
coordinate frame, and Christoffel symbols arise as the components of the
connection in a coordinate basis. The whole tensor calculus used in GR —
covariant derivatives, Christoffels, Riemann tensor — sits inside Cartan
geometry as a particular choice of frame.

A vast modern generalisation of this list is the theory of **parabolic
geometries** of Čap and Slovák, which treats all $G/P$ with $P$ a
parabolic subgroup uniformly.

### Where Cartan is not enough

Cartan geometry requires three things: a smooth manifold, a homogeneous
local model $G/H$, and a connection *soldered* to the tangent bundle. Step
outside any of these and one needs a different framework:

- **Yang–Mills gauge theory.** Principal $G$-bundles in which $G$ is an
  *internal* gauge group — most notably electromagnetism ($G = U(1)$, the
  simplest Yang–Mills theory), colour ($SU(3)$), and electroweak
  ($SU(2) \times U(1)$). The connection here is *not* soldered to $TM$,
  so it is a **principal connection**, not a Cartan connection. The
  technical distinction is sharp: a Cartan connection $\omega$ must be a
  pointwise linear isomorphism $T_pP \xrightarrow{\cong} \mathfrak{g}$,
  whose $\mathfrak{m}$-part (the vierbein) identifies $TM$ with the model
  translation space at every point. An electromagnetic connection $A$ has
  no such piece — $\mathfrak{u}(1) \cong \mathbb{R}$ is one-dimensional and
  internal, and the bundle direction sits "above" spacetime rather than
  "tangent" to it. So while $A$ and the vierbein-plus-spin-connection
  $\omega^a{}_b + e^a$ are both principal-bundle connections with
  curvature, only the latter is a Cartan connection. Schematically,
  Cartan geometry is "tangential" gauge theory; Yang–Mills is "internal"
  gauge theory.
- **Symplectic and Poisson geometry** on non-homogeneous phase spaces — the
  setting of most of classical mechanics on cotangent bundles of curved
  configuration spaces.
- **Singular and stratified spaces**: orbifolds, algebraic varieties with
  singularities, conifold geometries.
- **Quantum theory.** Hilbert spaces and operator algebras are not Cartan
  geometries. The classical *background* spacetime of a QFT can be
  Cartan, but the quantum sector itself is not.
- **Noncommutative geometry** (Connes): replace $C^\infty(M)$ by a
  noncommutative algebra; there is no underlying manifold.
- **Higher gauge theory, gerbes, $\infty$-bundles**: anomalies, the $B$-field
  of string theory, higher-form gauge fields.
- **Generalised geometry** (Hitchin), **double field theory**, T-duality:
  the tangent bundle is replaced by $TM \oplus T^*M$ or by a doubled
  spacetime, which is outside the Cartan paradigm.
- **Discrete / lattice geometries** as used in lattice gauge theory and
  numerical relativity.

So Cartan geometry covers essentially all classical relativistic field
theory built on a spacetime manifold — including all of GR and its
geometric extensions (Einstein–Cartan, teleparallel, Poincaré gauge
theory, MacDowell–Mansouri). Where it falls short is exactly where one
leaves smooth manifolds with local Lie-group symmetry behind.

There is one fascinating qualification to the statement that
electromagnetism is not a Cartan geometry: the **Kaluza–Klein**
observation. On a 5-manifold $M^5 = M^4 \times S^1$, a $U(1)$ rotation of
the extra circle *is* a translation in the geometry of $M^5$. The
gauge potential $A_\mu$ then becomes a piece of the 5-dimensional metric,

$$
g^{(5)}_{MN}
=
\begin{pmatrix} g_{\mu\nu} + A_\mu A_\nu & A_\mu \\ A_\nu & 1 \end{pmatrix},
$$

so that in the higher-dimensional Cartan geometry (model
$\text{Poincaré}_5 / \text{Lorentz}_5$) electromagnetism *is* part of the
geometry — its gauge group has been promoted from "internal" to
"spacetime" by adding a dimension. Analogous constructions exist for
non-abelian Yang–Mills at the cost of $\dim G$ extra dimensions, but with
strong constraints on the higher-dimensional metric. This is the line
pursued by Kaluza, Klein, Einstein, Pauli, and many others, and never
quite produced a fully viable unification. The takeaway is that the
boundary "Cartan vs. internal gauge theory" is dimension-dependent: a
gauge field that is internal in $D$ dimensions can become geometrical in
$D+1$.

### Klein, Cartan, and Yang–Mills compared

All three frameworks use Lie groups, but they package them very
differently — and only the first two construct the underlying space out of
the group. Yang–Mills theory does not construct spacetime at all. It
takes a manifold $M$ as **given** (typically Minkowski, or a curved
Lorentzian manifold which by itself may be a Cartan geometry — the
gravitational sector) and adds on top of it the following data:

1. A **principal $G$-bundle** $\pi : P \to M$ with $G$ a Lie group
   ($U(1)$, $SU(2)$, $SU(3)$, …). Each fibre $\pi^{-1}(x) \cong G$ is an
   "internal" copy of the gauge group, not related to $T_xM$. The total
   space has dimension $\dim M + \dim G$.

2. A **principal connection** $\omega \in \Omega^1(P, \mathfrak{g})$
   satisfying $\omega(\xi^*) = \xi$ for the vertical vector $\xi^*$
   generated by $\xi \in \mathfrak{g}$, and the $G$-equivariance
   $R_g^* \omega = \mathrm{Ad}_{g^{-1}} \omega$. Compared with the Cartan
   case, *only the vertical condition is imposed* — there is no demand
   that $\omega$ be a linear isomorphism with all of $\mathfrak{g}$,
   because $\mathfrak{g}$ is not soldered to $TM$.

3. A **curvature** $\Omega = d\omega + \tfrac{1}{2}[\omega, \omega] = F$,
   the field strength.

4. **Associated bundles** $E = P \times_\rho V$ for each representation
   $\rho : G \to GL(V)$; sections of $E$ are the matter fields (quarks,
   leptons, …).

The crucial conceptual point is that the **geometric object is the pair
$(P, \omega)$, not a space $G/H$**. The Lie group encodes a local
symmetry that acts pointwise on the fibres of $P$, not on the base $M$.
Spacetime is given separately, and the bundle structure is layered on top
of it. The three frameworks line up as follows:

| | Klein | Cartan | Yang–Mills |
|---|---|---|---|
| Role of $G$ | *defines* the space | *local model* of the manifold | *internal* gauge symmetry |
| Where $G$ acts | on the space itself, transitively | on tangent spaces (soldered to $TM$) | on internal fibres of $P$ (not soldered) |
| What is "space"? | $G/H$ | $M$, locally modelled on $G/H$ | $M$ (given), plus the bundle $P \to M$ |
| Connection 1-form | (Maurer–Cartan of $G$ on $G$ itself) | Cartan: $\omega_p : T_pP \xrightarrow{\cong} \mathfrak{g}$ | Principal: only the vertical part of $\omega$ is fixed |
| Curvature | $0$ identically | model failure $+$ torsion | field strength $F$ |
| Typical example | Minkowski as $\text{Poincaré}/\text{Lorentz}$ | GR as a Cartan geometry on the same model | EM, QCD, electroweak |

In one sentence: a **Klein geometry** *is* a Lie-group quotient; a **Cartan
geometry** is a manifold *modelled on* a Lie-group quotient, with the
model tangentially soldered at every point; a **Yang–Mills theory** is a
manifold equipped with an *unrelated* Lie-group fibre bundle and a
non-soldered connection on it. All three use Lie groups, but only the
first two build the space itself out of them. Yang–Mills uses Lie groups
to enrich a pre-existing space with internal symmetry.

There is one further wrinkle worth knowing about. In gauge theory one
often studies the **moduli space of connections** $\mathcal{A}/\mathcal{G}$
(connections modulo gauge transformations), which becomes a genuine
"space" of its own — typically infinite-dimensional and not homogeneous.
Donaldson invariants, Seiberg–Witten theory, and similar 4-manifold
invariants are about the geometry of *this* space. But that is one level
removed from the principal-bundle setup itself.

### Synthesis: Cartan for physical space, other geometries on top

Stepping back from the individual items in the "Where Cartan is not
enough" list, one notices that almost every entry is not really an
*alternative* to Cartan geometry but an *additional* structure layered on
top of a Cartan-modelled physical spacetime. They are not different
descriptions of physical space; they are different *kinds of space*
attached to it.

| Theory | Physical spacetime | Extra structure on top | Geometry of the extra structure |
|---|---|---|---|
| Yang–Mills (EM, QCD, …) | Cartan ($M^4$, possibly curved) | Principal $G$-bundle $P \to M$ | Principal connection $(P, \omega)$ |
| Classical mechanics | Cartan ($\mathbb{R}^3$ or curved $Q$) | Phase space $T^*Q$ | Symplectic |
| Quantum mechanics / QFT | Cartan ($\mathbb{R}^{3,1}$ or curved) | Hilbert space $\mathcal{H}$ of states | Linear / Hilbert |
| Statistical mechanics | Cartan ($\mathbb{R}^3$ or $\mathbb{R}^{3,1}$) | Phase space $\Gamma$ with a measure | Measure-theoretic |
| Higher gauge theory, gerbes | Cartan | Higher principal bundle or gerbe | Higher-categorical |
| Lattice gauge theory | Cartan $\to$ lattice $\Lambda \subset M$ | Bundle data on $\Lambda$ | Discrete |

In every row, the physical spacetime is still a smooth Cartan geometry —
Minkowski or its curved GR generalisation — and supplies the metric, the
causal structure, and the gravitational dynamics. The additional layer
encodes whatever the theory is *about*: internal symmetry directions
(gauge theories), configurations and states (mechanics), quantum
amplitudes (Hilbert spaces), or probability distributions (statistical
mechanics). These additional structures need their own appropriate
geometry, and there is no reason to expect them to be Cartan — they are
not spacetime.

This is particularly clear in classical mechanics, where the architecture
is the three-layer structure

$$
\underbrace{\mathbb{R}^3}_{\text{Cartan / physical space}}
\;\hookrightarrow\;
\underbrace{Q}_{\text{Cartan / configuration space}}
\;\hookrightarrow\;
\underbrace{T^*Q}_{\text{symplectic / phase space, not Cartan}}.
$$

The physical space is $\mathbb{R}^3$, the Klein geometry $E(3)/SO(3)$.
The configuration space $Q$ — points of $S^2$ for a particle on a sphere,
$SO(3)$ for a rigid body, $\mathbb{R}^{3N}$ for $N$ point particles — is
typically itself a Cartan/Riemannian manifold, with the kinetic energy
supplying a metric. The phase space $T^*Q$, where Hamilton's equations
live, is symplectic and not in general homogeneous, so it is not a Cartan
geometry. Yet none of this is in conflict with the Cartan framework: each
layer is the natural geometric setting for the data it carries.

A small list of frameworks does propose genuinely modifying physical
spacetime itself rather than adding structure on top — noncommutative
geometry, generalised geometry, double field theory, higher-categorical
spacetimes, and the various Planck-scale or string-theoretic notions of
emergent or noncommutative spacetime. Those are the cases where the
Cartan picture of *physical space* itself is being challenged. For all
standard physics, however, the working rule is:

> Physical spacetime is a Cartan geometry; everything else is additional
> structure layered on top of it, and the geometry of those layers is not
> Cartan.

This is the reason the Lie-algebra-to-metric derivation of this note —
followed by its Cartan extension to curved spacetimes — sits at the
foundation of essentially all relativistic field theory: it is the
foundation of *spacetime itself*, on which the rest of physics is built.

### Closing remark

The same Cartan construction applied to the Galilei algebra yields
**Newton–Cartan geometry**, the geometric formulation of Newtonian
gravity, in which the degenerate temporal and spatial metrics derived in
Part II play the role of the two background tensors. A standard reference
is Sharpe, *Differential Geometry: Cartan's Generalization of Klein's
Erlangen Program*.
