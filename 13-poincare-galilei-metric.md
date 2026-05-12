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
the 2D plane. The metric *at the basepoint* (the north pole) is the
Euclidean form on the tangent space. By $G$-equivariance — the metric is
invariant under the full $SO(3)$ action — this extends uniquely to a
$G$-invariant Riemannian metric on all of $S^2$, namely the **round
metric**:

$$
ds^2 = R^2 \,(d\theta^2 + \sin^2\theta\, d\phi^2),
$$

with $R^2$ proportional to the scale $\lambda$.

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
radius $R$ (with $R^2$ proportional to $\lambda$).

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
