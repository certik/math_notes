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

The translation generators $P^0 \equiv H, P^1, P^2, P^3$ span a 4-dimensional
vector space $V$ on which the homogeneous generators $X \in \{J_i, K_i\}$ act
by commutation:

$$
[X, P^\mu] \in V \quad \text{for all } X, \mu.
$$

The action is a derivation, so for any symmetric bilinear form
$g(\cdot, \cdot)$ on $V$ — written in components as

$$
g(P^\mu, P^\nu) = \eta^{\mu\nu}
$$

with $\eta^{\mu\nu} = \eta^{\nu\mu}$ — invariance under $X$ is the Leibniz
condition

$$
\boxed{\;
g\big([X, P^\mu], P^\nu\big) + g\big(P^\mu, [X, P^\nu]\big) = 0
\;}
$$

for every generator $X$ and every $\mu, \nu$. This is a finite system of
linear equations on the 10 components of $\eta$.

**Identification with the spacetime metric.** A point of spacetime is
labelled by the four translation parameters $a^\mu$ in $T_a = \exp(a^\mu
P^\mu)$. By conjugation $U(\Lambda) T_a U(\Lambda)^{-1} = T_{\Lambda a}$ the
parameters $a^\mu$ transform under the same representation as the basis
$\{P^\mu\}$. Hence $\eta^{\mu\nu}$ is also the matrix of the invariant
bilinear form on spacetime coordinates $x^\mu = a^\mu$.

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

Leibniz on $V \otimes V$ gives $X \cdot \xi = 0 \Leftrightarrow$

$$
\boxed{\;
[X, P^\mu] \otimes P^\nu + P^\mu \otimes [X, P^\nu]
\;}
\quad \text{contracted with } \xi^{\mu\nu} \quad = 0 \,.
$$

Equivalently, reading off coefficients of $P^\alpha \otimes P^\beta$:

$$
L^\alpha{}_\mu\, \xi^{\mu\beta} + L^\beta{}_\nu\, \xi^{\alpha\nu} = 0 \,,
\qquad \text{where } [X, P^\mu] = L^\rho{}_\mu\, P^\rho \,.
$$

(This is the same Leibniz rule on a *contravariant* tensor — there is no
metric to lower indices, so the second slot is *not* the same as for the
covariant form.)

For Galilei $K_i$, the only nonzero commutator is $[K_i, H] = P^i$, i.e.
$L^\rho{}_0 = \delta^\rho_i$. So the invariance condition becomes

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
