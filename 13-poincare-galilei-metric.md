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

In this document we start from the **abstract Lie algebras** of the Poincaré
and Galilei groups, defined purely by their commutation relations, and derive
step by step the **invariant bilinear form (metric) on the spacetime** on
which these algebras act. We do this without postulating any matrix
representation in advance — the matrix action on coordinates is *derived* from
the algebra itself.

We work in 3+1 dimensions and use the convention where the structure constants
carry no factor of $i$ (so the generators are mathematical, not Hermitian).
For the Galilei side we use the *bare* algebra (no central charge $M$), since
the spacetime metric is determined by the action on classical coordinates,
which is insensitive to the central extension.

The companion document
[03-lie-groups.md](03-lie-groups.md) starts from explicit matrix generators
and solves for the invariant metric. Here we take a step backwards and
*derive* those very matrices from the abstract algebra.

## Strategy

Both the Poincaré and the (bare) Galilei algebras share the same overall
structure:

- Three rotation generators $J_1, J_2, J_3$.
- Three boost generators $K_1, K_2, K_3$.
- Three spatial translation generators $P_1, P_2, P_3$.
- One time translation generator $H$.

The two algebras differ only in **two** of their commutators (those
involving boosts: among themselves, and with spatial translations).

Our strategy has four steps, executed identically for both algebras:

**Step 1.** Identify the translation generators and stack them into a
4-component object $\Phi_\mu = (H, P_1, P_2, P_3)$ with $\mu = 0, 1, 2, 3$.

**Step 2.** From the commutation relations of any generator $G \in \{J_i,
K_i\}$ with $\Phi_\mu$, read off a matrix $M_G$ defined by

$$
[G, \Phi_\nu] = (M_G)^\mu{}_\nu \, \Phi_\mu \,.
$$

**Step 3.** Show that this same matrix $M_G$ describes the linear action of
$G$ on spacetime coordinates $x^\mu = (t, x^1, x^2, x^3)$:

$$
\delta_G x^\mu = (M_G)^\mu{}_\nu \, x^\nu \,.
$$

This step uses only that $\Phi_\mu$ generates translations and that all
translations commute.

**Step 4.** Find every symmetric bilinear form $g$ on $x^\mu$ that is
preserved by all generators. Infinitesimally, invariance of $g_{\mu\nu} x^\mu
x^\nu$ under $\delta x = M_G x$ gives the **Killing-type equation**

$$
M_G^T g + g \, M_G = 0 \qquad \text{for every generator } G.
$$

Equivalently, for the *contravariant* metric (acting on momenta) the
condition is

$$
M_G \, g + g \, M_G^T = 0 \qquad \text{for every generator } G.
$$

Solving these linear constraints determines the metric.

## Why the same matrix acts on $\Phi_\mu$ and on $x^\mu$

Before turning to the two algebras, we justify Step 3. Consider a finite
translation $T_a = \exp(a^\mu \Phi_\mu)$, where $a^\mu = (a^0, a^1, a^2, a^3)$
are the four real translation parameters. By construction $T_a$ shifts the
spacetime origin to the point with coordinates $x^\mu = a^\mu$. So
**translation parameters and spacetime coordinates are the same object** —
points of spacetime are labeled by translation 4-vectors $a^\mu$.

Now let $U = \exp(\theta G)$ for some rotation or boost generator $G$. Since
$[G, \Phi_\nu] = (M_G)^\mu{}_\nu \Phi_\mu$, conjugation gives

$$
U \, \Phi_\nu \, U^{-1}
= \exp\!\big(\theta\, \mathrm{ad}_G\big) \Phi_\nu
= \big(e^{\theta M_G}\big)^\mu{}_\nu \, \Phi_\mu \,.
$$

Conjugating the translation $T_a$:

$$
U \, T_a \, U^{-1}
= U \exp(a^\nu \Phi_\nu) U^{-1}
= \exp\!\big(a^\nu \, U \Phi_\nu U^{-1}\big)
= \exp\!\Big(\big[(e^{\theta M_G})^\mu{}_\nu a^\nu\big]\, \Phi_\mu\Big)
= T_{a'} \,,
$$

with

$$
a'^\mu = \big(e^{\theta M_G}\big)^\mu{}_\nu \, a^\nu \,.
$$

So the **same matrix** $e^{\theta M_G}$ acts on the translation 4-vector
$a^\mu$. Since $a^\mu$ is identified with the spacetime coordinate $x^\mu$,

$$
x'^\mu = \big(e^{\theta M_G}\big)^\mu{}_\nu \, x^\nu \,,
\qquad
\delta_G x^\mu = (M_G)^\mu{}_\nu \, x^\nu \,.
$$

This is exactly Step 3.

## Invariant bilinear forms

A symmetric bilinear form $g_{\mu\nu}$ on spacetime coordinates is preserved
under $x \to e^{\theta M_G} x$ if and only if $\big(e^{\theta M_G}\big)^T g \,
e^{\theta M_G} = g$. Differentiating at $\theta = 0$ gives the infinitesimal
condition

$$
\boxed{\; M_G^T \, g + g \, M_G = 0 \;}\qquad \text{(covariant metric)} \,.
$$

A symmetric contravariant form $g^{\mu\nu}$ (which pairs with momenta /
gradients, the dual space to coordinates) is preserved if and only if

$$
\boxed{\; M_G \, g + g \, M_G^T = 0 \;}\qquad \text{(contravariant metric)} \,.
$$

When the algebra admits a non-degenerate invariant $g_{\mu\nu}$, the
contravariant form $g^{\mu\nu}$ is just its matrix inverse. We will see that
this is the case for Poincaré, but **not** for Galilei: the Galilei algebra
admits two independent, degenerate invariants, one covariant and one
contravariant, which cannot be inverted into each other.

---

## Part I: The Poincaré Algebra → Minkowski metric

### The commutation relations

The Poincaré algebra has the ten generators $\{J_i, K_i, P_i, H\}$ with the
relations (no factors of $i$):

$$
\begin{aligned}
{[J_i, J_j]} &= \epsilon_{ijk} J_k \,, & {[J_i, K_j]} &= \epsilon_{ijk} K_k \,, & {[K_i, K_j]} &= -\epsilon_{ijk} J_k \,, \\
{[J_i, P_j]} &= \epsilon_{ijk} P_k \,, & {[J_i, H]} &= 0 \,, \\
{[K_i, P_j]} &= \delta_{ij}\, H \,, & {[K_i, H]} &= P_i \,, \\
{[P_i, P_j]} &= 0 \,, & {[P_i, H]} &= 0 \,.
\end{aligned}
$$

The key relations for our derivation are those involving translations
($\{P_i, H\}$) and either a rotation $J_i$ or a boost $K_i$.

### Step 1–2: Matrix action on translations

Group the translation generators into

$$
\Phi_\mu = (H, P_1, P_2, P_3) \quad\Leftrightarrow\quad
\Phi_0 = H, \quad \Phi_i = P_i \ (i=1,2,3) \,.
$$

We read off $(M_G)^\mu{}_\nu$ from $[G, \Phi_\nu] = (M_G)^\mu{}_\nu \Phi_\mu$.

**Rotation $J_i$**:

- $[J_i, \Phi_0] = [J_i, H] = 0 \quad\Rightarrow\quad (M_{J_i})^\mu{}_0 = 0$.
- $[J_i, \Phi_j] = [J_i, P_j] = \epsilon_{ijk} P_k = \epsilon_{ijk} \Phi_k
  \quad\Rightarrow\quad (M_{J_i})^k{}_j = \epsilon_{ijk}$, with all other
  entries zero.

Explicitly, for $i=3$:

$$
M_{J_3} =
\begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & -1 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} \,,
$$

and similarly $M_{J_1}, M_{J_2}$ are the standard spatial-rotation generators
embedded into the 4×4 block.

**Boost $K_i$ (Poincaré)**:

- $[K_i, \Phi_0] = [K_i, H] = P_i = \Phi_i \quad\Rightarrow\quad
  (M_{K_i})^\mu{}_0 = \delta^\mu_i$.
- $[K_i, \Phi_j] = [K_i, P_j] = \delta_{ij}\, H = \delta_{ij}\, \Phi_0
  \quad\Rightarrow\quad (M_{K_i})^\mu{}_j = \delta_{ij}\, \delta^\mu_0$.

Explicitly:

$$
M_{K_1} =
\begin{pmatrix}
0 & 1 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} ,\
M_{K_2} =
\begin{pmatrix}
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} ,\
M_{K_3} =
\begin{pmatrix}
0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0
\end{pmatrix} \,.
$$

Note that these matrices are **symmetric**: $M_{K_i}^T = M_{K_i}$. The
rotation matrices are **antisymmetric**: $M_{J_i}^T = -M_{J_i}$.

### Step 3: Action on coordinates

By the general argument above, the same matrices act on $x^\mu = (t, x^1,
x^2, x^3)$:

$$
\delta_{J_i} x^\mu = (M_{J_i})^\mu{}_\nu x^\nu \,,
\qquad
\delta_{K_i} x^\mu = (M_{K_i})^\mu{}_\nu x^\nu \,.
$$

For example $\delta_{K_1} t = x^1$ and $\delta_{K_1} x^1 = t$, the
infinitesimal Lorentz boost in the $x^1$ direction.

### Step 4: Solve $M_G^T g + g\, M_G = 0$ for the covariant metric

Let $g$ be a symmetric $4 \times 4$ matrix with entries $g_{\mu\nu}$ and we
solve the constraints from rotations and boosts.

**Rotations.** Since $M_{J_i}^T = -M_{J_i}$, the constraint $M_{J_i}^T g + g\,
M_{J_i} = 0$ becomes $[M_{J_i}, g] = 0$: the metric must commute with every
rotation generator. Writing $g$ in block form

$$
g = \begin{pmatrix} a & b^T \\ b & C \end{pmatrix} \,,
$$

with $a \in \mathbb{R}$, $b \in \mathbb{R}^3$, and $C$ a symmetric $3 \times
3$ matrix, the rotation generators (which act trivially on the time row /
column) demand

- $b$ is invariant under the spatial rotation $R \in SO(3)$: only $b = 0$
  works.
- $C$ commutes with every rotation: $C = c\, I_3$ for some $c \in
  \mathbb{R}$.

So rotation invariance alone forces

$$
g = \begin{pmatrix} a & 0 \\ 0 & c\, I_3 \end{pmatrix} = \operatorname{diag}(a, c, c, c) \,.
$$

**Boost $K_1$.** Compute $M_{K_1}^T g + g\, M_{K_1}$ for $g =
\operatorname{diag}(a, c, c, c)$. Since $M_{K_1}^T = M_{K_1}$:

$$
M_{K_1} g + g\, M_{K_1} =
\begin{pmatrix}
2 \cdot 0 & a + c & 0 & 0 \\
a + c & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
= 0
\quad\Longrightarrow\quad a + c = 0 \,.
$$

(In the diagonal $g$, the $g_{01}$-component of $M_{K_1} g + g M_{K_1}$ picks
up $g_{00} = a$ from $M_{K_1} g$ and $g_{11} = c$ from $g\, M_{K_1}$.)

The same constraint $a + c = 0$ comes from $K_2$ and $K_3$.

**Result.** Setting $a = -1$ (the standard normalization), $c = 1$:

$$
\boxed{\; g_{\mu\nu} = \operatorname{diag}(-1, 1, 1, 1) \;}
\qquad \text{(Minkowski metric, signature } (-,+,+,+) \text{).}
$$

This is non-degenerate ($\det g = -1 \neq 0$), so the contravariant metric is
just the inverse:

$$
g^{\mu\nu} = \operatorname{diag}(-1, 1, 1, 1) \,,
$$

and one can verify directly that it satisfies the contravariant condition
$M_G g + g M_G^T = 0$.

The overall sign of $g_{\mu\nu}$ is undetermined by the algebra alone (the
opposite signature $(+,-,-,-)$ also satisfies the constraint); fixing it is a
**convention**, not a result of the algebra. What the algebra *does* fix is
the relative sign between the time and the space entries.

---

## Part II: The (bare) Galilei Algebra → degenerate metrics

### The commutation relations

The bare Galilei algebra has the same ten generators $\{J_i, K_i, P_i, H\}$
with the following relations — identical to Poincaré except for the boxed
changes:

$$
\begin{aligned}
{[J_i, J_j]} &= \epsilon_{ijk} J_k \,, & {[J_i, K_j]} &= \epsilon_{ijk} K_k \,, & \boxed{[K_i, K_j]} &= 0 \,, \\
{[J_i, P_j]} &= \epsilon_{ijk} P_k \,, & {[J_i, H]} &= 0 \,, \\
\boxed{[K_i, P_j]} &= 0 \,, & {[K_i, H]} &= P_i \,, \\
{[P_i, P_j]} &= 0 \,, & {[P_i, H]} &= 0 \,.
\end{aligned}
$$

The two changes from the Poincaré algebra are

1. $[K_i, K_j] = 0$ (boosts commute — no rotation arises from composing two
   boosts).
2. $[K_i, P_j] = 0$ (a Galilean boost commutes with spatial translation —
   intuitively, boosting then translating gives the same result as the other
   way around, because the boost does not mix space into time).

The relation $[K_i, H] = P_i$ is unchanged: boosting a time translation does
produce a spatial translation, because boosted observers disagree on what is
"a translation purely in time".

### Step 1–2: Matrix action on translations

The rotations $J_i$ act exactly as in the Poincaré case: same matrices
$M_{J_i}$.

For boosts the commutators changed, so the matrices change.

**Boost $K_i$ (Galilei)**:

- $[K_i, \Phi_0] = [K_i, H] = P_i = \Phi_i \quad\Rightarrow\quad
  (M_{K_i})^\mu{}_0 = \delta^\mu_i$. *(Same as Poincaré.)*
- $[K_i, \Phi_j] = [K_i, P_j] = 0 \quad\Rightarrow\quad (M_{K_i})^\mu{}_j =
  0$. *(Was $\delta_{ij}\delta^\mu_0$ in Poincaré.)*

Explicitly:

$$
M_{K_1} =
\begin{pmatrix}
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} ,\
M_{K_2} =
\begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} ,\
M_{K_3} =
\begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0
\end{pmatrix} \,.
$$

These matrices are **not** symmetric: only the lower-triangular entries of
the time column are nonzero. Compared to the Poincaré boosts, the symmetric
upper-triangular entry in the time row is **gone**. This is the algebraic
encoding of "boosts mix space into time" (Lorentz) versus "boosts mix only
time into space" (Galilei).

### Step 3: Action on coordinates

The matrices act on $x^\mu = (t, x^1, x^2, x^3)$ as

$$
\delta_{K_i} x^\mu = (M_{K_i})^\mu{}_\nu x^\nu \,.
$$

Explicitly:
$\delta_{K_1} t = 0$ and $\delta_{K_1} x^1 = t$, i.e., the Galilean boost
$x^1 \to x^1 + v\, t$ with $t' = t$. Time is **not** mixed with space.

### Step 4a: Covariant metric — temporal

Look for symmetric $g_{\mu\nu}$ with $M_G^T g + g\, M_G = 0$ for every
generator.

**Rotations** again force the diagonal form $g = \operatorname{diag}(a, c, c,
c)$ (same argument as before).

**Galilei boost $K_1$.** Now $M_{K_1}^T \neq M_{K_1}$. With $g =
\operatorname{diag}(a, c, c, c)$:

$$
M_{K_1}^T g =
\begin{pmatrix}
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
\begin{pmatrix}
a & 0 & 0 & 0 \\
0 & c & 0 & 0 \\
0 & 0 & c & 0 \\
0 & 0 & 0 & c
\end{pmatrix}
=
\begin{pmatrix}
0 & c & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} \,.
$$

$$
g\, M_{K_1} =
\begin{pmatrix}
a & 0 & 0 & 0 \\
0 & c & 0 & 0 \\
0 & 0 & c & 0 \\
0 & 0 & 0 & c
\end{pmatrix}
\begin{pmatrix}
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
=
\begin{pmatrix}
0 & 0 & 0 & 0 \\
c & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix} \,.
$$

$$
M_{K_1}^T g + g\, M_{K_1} =
\begin{pmatrix}
0 & c & 0 & 0 \\
c & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
= 0
\quad\Longrightarrow\quad c = 0 \,.
$$

The boost annihilates the spatial part of the covariant metric. The same
conclusion comes from $K_2$ and $K_3$. The time coefficient $a$ is **not**
constrained.

**Result.** Setting $a = 1$:

$$
\boxed{\; g_{\mu\nu} = \operatorname{diag}(1, 0, 0, 0) \;}
\qquad \text{(temporal metric, degenerate).}
$$

This degenerate form encodes **absolute time**: the quadratic form $g_{\mu\nu}
x^\mu x^\nu = t^2$ depends only on $t$, and Galilean transformations preserve
$t$ exactly.

### Step 4b: Contravariant metric — spatial

Look for symmetric $g^{\mu\nu}$ with $M_G g + g\, M_G^T = 0$ for every
generator.

**Galilei boost $K_1$.** With $g$ symmetric and $4 \times 4$:

$$
M_{K_1} g \quad\text{has nonzero entries only in row } 1\text{:}\quad
(M_{K_1} g)^{1\nu} = g^{0\nu} \,,
$$

$$
g\, M_{K_1}^T \quad\text{has nonzero entries only in column } 1\text{:}\quad
(g M_{K_1}^T)^{\mu 1} = g^{\mu 0} \,.
$$

Setting their sum to zero entry-by-entry:

- $(\mu,\nu) = (0,1)$: $g^{00} = 0$.
- $(1,1)$: $g^{01} + g^{10} = 2 g^{01} = 0 \Rightarrow g^{01} = 0$.
- $(1,2)$: $g^{02} = 0$.
- $(1,3)$: $g^{03} = 0$.

So $K_1$ kills the entire time row/column: $g^{0\mu} = 0$ for all $\mu$. The
same conclusion comes from $K_2, K_3$.

**Rotations.** The remaining $3 \times 3$ spatial block $g^{ij}$ must be
invariant under spatial rotations, which forces $g^{ij} = c\, \delta^{ij}$.

**Result.** Setting $c = 1$:

$$
\boxed{\; g^{\mu\nu} = \operatorname{diag}(0, 1, 1, 1) \;}
\qquad \text{(spatial metric, degenerate).}
$$

This degenerate contravariant form encodes **Euclidean space at each
instant**: the quadratic form $g^{\mu\nu} p_\mu p_\nu = |\vec p\,|^2$ depends
only on the spatial 3-momentum, and Galilean transformations preserve the
spatial length.

### Why two independent degenerate metrics?

For Poincaré, $g_{\mu\nu}$ is non-degenerate ($\det = -1$), so its inverse
$g^{\mu\nu}$ is fixed by it. There is one metric.

For Galilei, $\det g_{\mu\nu} = 0$ and $\det g^{\mu\nu} = 0$, so neither can
be inverted into the other. The two are *independent* invariants of the
algebra. Concretely:

$$
g_{\mu\nu}\, g^{\nu\rho} =
\operatorname{diag}(1,0,0,0) \cdot \operatorname{diag}(0,1,1,1) = 0 \,.
$$

The covariant metric measures **temporal separation**; the contravariant
metric measures **spatial separation of co-momenta**. They live in dual
spaces and cannot be combined into a single non-degenerate object.

A short argument that **no** non-degenerate invariant $g_{\mu\nu}$ exists for
the Galilei algebra: from the $K_i$ constraint alone we derived $g_{ij} = 0$
(and rotation invariance preserved this). So the entire spatial block
vanishes, and $\det g_{\mu\nu} = 0$ for **any** Galilei-invariant covariant
metric.

---

## Summary

We started from the abstract Lie algebras (commutation relations) and, in
both cases, performed the same three steps:

1. Read off matrices $(M_G)^\mu{}_\nu$ from the action of $G$ on the
   translation generators $\Phi_\mu = (H, \vec P)$.
2. Observe (via conjugation of $T_a$ by $\exp(\theta G)$) that the same
   matrices act on the spacetime 4-coordinate $x^\mu = (t, \vec x)$.
3. Solve $M_G^T g + g\, M_G = 0$ (covariant) and $M_G g + g\, M_G^T = 0$
   (contravariant) for every generator.

The results:

| Algebra | Non-trivial commutators (vs the other) | Covariant metric $g_{\mu\nu}$ | Contravariant metric $g^{\mu\nu}$ |
|---|---|---|---|
| Poincaré | $[K_i, K_j] = -\epsilon_{ijk} J_k$, $\ [K_i, P_j] = \delta_{ij} H$ | $\operatorname{diag}(-1,1,1,1)$ | $\operatorname{diag}(-1,1,1,1)$ |
| Galilei (bare) | $[K_i, K_j] = 0$, $\ [K_i, P_j] = 0$ | $\operatorname{diag}(1,0,0,0)$ (degenerate, temporal) | $\operatorname{diag}(0,1,1,1)$ (degenerate, spatial) |

The single key algebraic difference — namely whether the commutator $[K_i,
P_j]$ contains $H$ or vanishes — controls whether the boost matrix $M_{K_i}$
is symmetric or strictly lower-triangular, which in turn controls whether
the invariant form is non-degenerate Minkowski or the pair of degenerate
Galilean metrics.

## Comparison with `03-lie-groups.md`

The companion document `03-lie-groups.md` postulates the boost generators as
$4 \times 4$ matrices acting on $(t, \vec x)$ and then solves the same
invariance equations $K^T B + B K = 0$ and $K C + C K^T = 0$ to recover the
metrics. The present document **derives those very matrices from the abstract
algebra** by identifying the translation generators and reading off
$(M_G)^\mu{}_\nu$ from $[G, \Phi_\nu] = (M_G)^\mu{}_\nu \Phi_\mu$. The final
metrics agree:

- Poincaré: $\operatorname{diag}(-1,1,1,1)$ (Minkowski).
- Galilei: $\operatorname{diag}(1,0,0,0)$ covariant and $\operatorname{diag}(0,1,1,1)$ contravariant.

Thus the abstract commutation relations of the Poincaré/Galilei algebras
already determine — up to overall normalization — the spacetime metric on
which they act.
