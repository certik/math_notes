# Deriving Tensors and Their Transformations Using Group Theory: The SO(3) Approach

This document derives the definition and transformation properties of tensors in 3D Euclidean space using the Lie group SO(3) and its Lie algebra $\mathfrak{so}(3)$. We focus on rotations, building tensors from representation theory without assuming prior coordinate systems or manifolds. The approach is rigorous, starting from abstract group axioms and proceeding step by step to define scalars, vectors, higher-rank tensors, and fields. We derive transformation laws for both tensors and fields under active rotations.

All derivations are self-contained, drawing from standard Lie group and representation theory. We use the active transformation convention (rotating the physical system), but note connections to passive views where relevant.

## Step 1: Defining the Lie Group SO(3) and Its Lie Algebra $\mathfrak{so}(3)$

The special orthogonal group SO(3) is the group of all proper rotations in 3D space. Formally:

- SO(3) consists of 3×3 real matrices $g$ satisfying $g^T g = I$ (orthogonality) and $\det g = 1$ (proper, no reflections). The group operation is matrix multiplication.

The Lie algebra $\mathfrak{so}(3)$ is the tangent space at the identity, consisting of 3×3 skew-symmetric matrices $X$ (i.e., $X^T = -X$) with trace zero. A basis is given by the generators:

$$
J_x = \begin{pmatrix} 0 & 0 & 0 \\ 0 & 0 & -1 \\ 0 & 1 & 0 \end{pmatrix}, \quad
J_y = \begin{pmatrix} 0 & 0 & 1 \\ 0 & 0 & 0 \\ -1 & 0 & 0 \end{pmatrix}, \quad
J_z = \begin{pmatrix} 0 & -1 & 0 \\ 1 & 0 & 0 \\ 0 & 0 & 0 \end{pmatrix}.
$$

These satisfy the commutation relations:

$$
[J_i, J_j] = \epsilon_{ijk} J_k,
$$

where $\epsilon_{ijk}$ is the Levi-Civita symbol ($\epsilon_{123} = 1$, antisymmetric).

Finite group elements are obtained via the exponential map:

$$
g = \exp(X) = \sum_{k=0}^\infty \frac{X^k}{k!},
$$

for $X \in \mathfrak{so}(3)$. For a rotation by angle $\theta$ around unit axis $\mathbf{n} = (n_x, n_y, n_z)$, $X = \theta \mathbf{n} \cdot \mathbf{J} = \theta (n_x J_x + n_y J_y + n_z J_z)$. This map is surjective onto the connected component of SO(3).

The fundamental representation $\rho: \mathrm{SO}(3) \to \mathrm{GL}(\mathbb{R}^3)$ is the natural matrix action on vectors in $\mathbb{R}^3$: $\rho(g) v = g v$. This is irreducible (cannot be block-decomposed into smaller invariant subspaces), corresponding to the $l=1$ irrep with dimension 3.

## Step 2: Defining Fields and Their Transformations (Scalars as Starting Point)

Physical quantities are often fields defined on $\mathbb{R}^3$. We derive their transformation laws from the SO(3) action.

A scalar field $\phi: \mathbb{R}^3 \to \mathbb{R}$ transforms under $g \in \mathrm{SO}(3)$ such that the value at the rotated point reflects the original system. In the active view, the transformed field $\phi_g$ satisfies:

$$
\phi_g(x) = \phi(g^{-1} x).
$$

**Derivation**: The rotation $g$ maps the point $g^{-1} x$ to $x$, so the value at the new position $x$ should be the original value at the pre-rotated position $g^{-1} x$. This ensures invariance: if $\phi$ is constant, $\phi_g = \phi$.

Infinitesimally, for small $\theta$, $g \approx I + \theta \mathbf{n} \cdot \mathbf{J}$, so $g^{-1} \approx I - \theta \mathbf{n} \cdot \mathbf{J}$. The variation is:

$$
\delta \phi(x) = \phi_g(x) - \phi(x) = -\theta (\mathbf{n} \cdot \mathbf{J} x) \cdot \nabla \phi(x) = \theta \mathbf{n} \cdot (\mathbf{x} \times \nabla) \phi(x),
$$

using the vector identity for rotations ($J_i$ generates $\mathbf{e}_i \times$). This is the Lie derivative along the rotation generator, derived from the algebra.

This defines scalars as transforming in the trivial representation ($l=0$): no change beyond domain shift.

## Step 3: Defining Vectors (Rank-1 Contravariant Tensors) via the Fundamental Representation

A contravariant vector field $V: \mathbb{R}^3 \to \mathbb{R}^3$ transforms as:

$$
V_g(x) = g V(g^{-1} x).
$$

**Derivation**:
- Start from the fundamental rep: Vectors are elements of $\mathbb{R}^3$, rotated by $g$.
- For fields, combine with domain: The vector at $x$ after rotation is the rotated original vector at $g^{-1} x$.
- This follows from requiring that the vector "aligns" with rotated directions, e.g., if $V$ is a displacement, $g V$ is the rotated displacement.

In components (basis introduced later), if $V(x) = V^i(x) \mathbf{e}_i$, then $V_g^i(x) = g^i{}_j V^j(g^{-1} x)$.

For covector fields (one-forms) $p: \mathbb{R}^3 \to (\mathbb{R}^3)^*$, they are dual: $p(x) \cdot V(x) = \phi(x)$ (scalar). Preservation requires:

$$
p_g(x) \cdot V_g(x) = p(g^{-1} x) \cdot V(g^{-1} x).
$$

Substitute $V_g(x) = g V(g^{-1} x)$:

$$
p_g(x) \cdot g V(g^{-1} x) = p(g^{-1} x) \cdot (g^{-1} x) \implies p_g(x) = p(g^{-1} x) g^{-1},
$$

since $p \cdot w = p \cdot (g^{-1} w)$ implies $p_g = p g^{-1}$ (transposition for dual). For SO(3), $g^{-1} = g^T$, so:

$$
p_g(x) = g^T p(g^{-1} x).
$$

Infinitesimally, for vectors: $\delta V(x) = \theta J_i V(x) + \theta (\mathbf{n} \cdot \mathbf{x} \cdot \nabla) V(x)$, where $J_i V$ is the matrix action (spin part) and the gradient is orbital.

This defines rank-1 tensors as the fundamental irrep space.

## Step 4: Defining Higher-Rank Tensors via Tensor Product Representations

Higher-rank tensors are defined as elements of tensor product spaces. A contravariant) rank-$n$ tensor field $T: \mathbb{R}^3 \to (\mathbb{R}^3)^{\otimes n}$ transforms as:

$$
T_g(x) = (g \otimes \cdots \otimes g) T(g^{-1} x),
$$

with $n$ factors of $g$.

**Derivation**:
- The tensor product space $(\mathbb{R}^3)^{\otimes n}$ is spanned by products $v_1 \otimes \dots \otimes v_n$.
- The induced representation $\pi^{\otimes n}(g)$ acts as:
  $$
  \pi^{\otimes n}(g) (v_1 \otimes \dots \otimes v_n) = (g v_1) \otimes \dots \otimes (g v_n).
  $$
  This follows from the universal property: the action is multilinear and preserves the product structure.
- For fields, include domain: $T_g(x) = \pi^{\otimes n}(g) T(g^{-1} x)$.

In components (with basis), $T^{i_1 \dots i_n}(x)$:

$$
T_g^{i_1 \dots i_n}(x) = g^{i_1}_{j_1} \cdots g^{i_n}_{j_n} T^{j_1 \dots j_n}(g^{-1} x).
$$

For covariant tensors, use the dual rep ($g^{-T}$ per leg). Mixed tensors combine accordingly.

Infinitesimally, the generator is $J_i^{\otimes n} = \sum_{k=1}^n I \otimes \dots \otimes J_i \otimes \dots \otimes I$ (J_i in k-th position). The finite transformation is $\exp(\theta n_j J_j^{\otimes n})$.

This derives the "n matrices" rule as a consequence of the induced rep.

## Step 5: Decomposition into Irreducible Representations

Tensor products are reducible. For rank-2 contravariant: $(\mathbb{R}^3)^{\otimes 2} \cong l=0 \oplus l=1 \oplus l=2$ (dims 1+3+5=9).

**Derivation**:
- Use the Casimir operator $J^2 = J_x^2 + J_y^2 + J_z^2$, eigenvalue $l(l+1)$, on the tensor space.
- Projectors: Symmetric $P_s(T)_{ij} = \frac{1}{2}(T_{ij} + T_{ji})$, antisymmetric $P_a(T)_{ij} = \frac{1}{2}(T_{ij} - T_{ji})$.
- Trace: $l=0$ is $\frac{1}{3} \delta_{ij} T_{kk}$.
- Antisymmetric: $l=1$, transforms as vector (via $\epsilon_{ijk}$).
- Symmetric traceless: $l=2$, $T_{\{ij\}} = P_s(T)_{ij} - \frac{1}{3} \delta_{ij} T_{kk}$.

Transformations block-diagonalize in this basis, using the $l$-specific matrices (e.g., 5×5 for $l=2$).

Higher ranks follow via Clebsch-Gordan: max $l=n$, multiplicities from symmetries.

## Transformation of Fields: General Case

For a tensor field $T$ of type (k,l) (k contravariant, l covariant):

$$
(T_g)^{i_1 \dots i_k}{}_{j_1 \dots j_l}(x) = g^{i_1}{}_{m_1} \cdots g^{i_k}{}_{m_k} (g^{-1})^{n_1}{}_{j_1} \cdots (g^{-1})^{n_l}{}_{j_l} T^{m_1 \dots m_k}{}_{n_1 \dots n_l}(g^{-1} x).
$$

Derived as above: contravariant legs get $g$, covariant get $g^{-1}$, plus domain shift.

This completes the derivation: tensors are rep spaces, transformations from induced actions, fields include spatial dependence.
