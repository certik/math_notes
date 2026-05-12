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

## Summary

In **one** algebraic principle — that $\eta$ be invariant under the
adjoint action of $\{J_i, K_i\}$ —

$$
g([X, P^\mu], P^\nu) + g(P^\mu, [X, P^\nu]) = 0,
$$

the spacetime metric is completely determined by the commutation relations:

| Algebra | Distinguishing commutators | Invariants on translations |
|---|---|---|
| Poincaré | $[K_i, K_j] = -\epsilon_{ijk} J_k$, $\ [K_i, P^j] = \delta_{ij} H$ | $\eta^{\mu\nu} = \operatorname{diag}(-1, 1, 1, 1)$ (Minkowski; $V^* \otimes V^*$ and $V \otimes V$ coincide) |
| Galilei (bare) | $[K_i, K_j] = 0$, $\ [K_i, P^j] = 0$ | $\eta \in V^* \otimes V^*: \ \operatorname{diag}(1, 0, 0, 0)$ (temporal, degenerate) and $\xi \in V \otimes V: \ \operatorname{diag}(0, 1, 1, 1)$ (spatial, degenerate) |

The single algebraic difference — whether $[K_i, P^j]$ contains $H$ or
vanishes — is what flips the algebra's invariant form from non-degenerate
Minkowski to the pair of degenerate Galilean metrics.

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

### Closing remark

The same Cartan construction applied to the Galilei algebra yields
**Newton–Cartan geometry**, the geometric formulation of Newtonian
gravity, in which the degenerate temporal and spatial metrics derived in
Part II play the role of the two background tensors. A standard reference
is Sharpe, *Differential Geometry: Cartan's Generalization of Klein's
Erlangen Program*.
