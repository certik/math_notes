# Determinant of Tensors: A Comprehensive Guide

## From Classical Matrices to Higher-Order Generalizations and Intrinsic Definitions for Covariant Bilinear Forms

---

## Table of Contents

1. [Introduction](#id-1-introduction)
2. [The Determinant for Matrices (Rank-2 Endomorphisms)](#id-2-the-determinant-for-matrices-rank-2-endomorphisms)
3. [Higher-Order Tensors and the Hyperdeterminant](#id-3-higher-order-tensors-and-the-hyperdeterminant)
4. [Rank-2 Covariant Tensors: Bilinear Forms of Type (0,2)](#id-4-rank-2-covariant-tensors-bilinear-forms-of-type-0-2)
5. [Basis-Independent Constructions for (0,2) Tensors](#id-5-basis-independent-constructions-for-0-2-tensors)
6. [Weight-2 Densities and Transformation Laws](#id-6-weight-2-densities-and-transformation-laws)
7. [Axiomatic Characterization: Uniquely Deriving the Determinant](#id-7-axiomatic-characterization-uniquely-deriving-the-determinant)
8. [Special Cases and Geometric Applications](#id-8-special-cases-and-geometric-applications)
9. [Conclusion and Further Directions](#id-9-conclusion-and-further-directions)
10. [References and Further Reading](#id-10-references-and-further-reading)

---

## 1. Introduction

The concept of the **determinant** is one of the most fundamental in linear algebra. For an $n \times n$ matrix $A$, $\det(A)$ is a scalar that encodes critical information: it tells us whether $A$ is invertible, measures the signed volume scaling factor of the linear transformation represented by $A$, and appears in countless formulas (Cramer's rule, characteristic polynomial, change of variables in integration, etc.).

When we move from matrices to **tensors** (multi-linear objects of higher rank or different variance types), the situation becomes more subtle. A matrix can be viewed as a rank-2 tensor of type (1,1) (an endomorphism) or (0,2) (a bilinear form). For higher-order tensors (order $d > 2$), or even for pure covariant rank-2 tensors without additional structure, there is no universally agreed "determinant" that preserves *all* the familiar properties.

This document provides a complete, self-contained explanation, starting from the classical case and building up rigorously to intrinsic (basis-free) definitions, with special emphasis on:

- The hyperdeterminant for higher-order tensors.
- Why a pure (0,2) covariant tensor does *not* have a canonical scalar determinant.
- How the natural object lives in a weight-2 density bundle.
- An axiomatic characterization that uniquely determines the determinant (up to scale) assuming only natural properties, including the weight-2 transformation law.

All constructions are presented step-by-step, with explicit formulas, geometric interpretations, and proofs of key properties where feasible.

---

## 2. The Determinant for Matrices (Rank-2 Endomorphisms)

### 2.1 Classical Definitions (with Basis)

Let $V$ be an $n$-dimensional vector space over a field $K$ (usually $\mathbb{R}$ or $\mathbb{C}$) and let $f: V \to V$ be a linear endomorphism. Fix a basis $\{e_1, \dots, e_n\}$ of $V$. The matrix of $f$ with respect to this basis is the $n \times n$ matrix $A = (a_{ij})$ where
$$
f(e_j) = \sum_{i=1}^n a_{ij} e_i.
$$

The **determinant** of $A$ (and thus of $f$) can be defined in several equivalent ways:

**Leibniz formula (permutation expansion):**
$$
\det(A) = \sum_{\sigma \in S_n} \operatorname{sgn}(\sigma) \prod_{i=1}^n a_{i,\sigma(i)},
$$
where $S_n$ is the symmetric group of all permutations of $\{1,\dots,n\}$ and $\operatorname{sgn}(\sigma) = +1$ if $\sigma$ is even, $-1$ if odd.

**Levi-Civita symbol expression:**
$$
\det(A) = \sum_{i_1,\dots,i_n = 1}^n \epsilon_{i_1 \dots i_n} a_{1 i_1} \cdots a_{n i_n},
$$
where $\epsilon_{1 2 \dots n} = +1$ and $\epsilon$ is totally antisymmetric.

**Cofactor expansion** (recursive definition along a row or column) and many other equivalent characterizations exist.

These definitions depend on the choice of basis, but the resulting scalar $\det(A)$ is independent of the basis in the following sense: if we change basis with an invertible matrix $P$, the new matrix is $A' = P^{-1} A P$, and
$$
\det(A') = \det(A).
$$
Thus $\det(f)$ is intrinsically associated to the linear map $f$.

### 2.2 Geometric Meaning

If the columns of $A$ are vectors $v_1, \dots, v_n \in V$, then $|\det(A)|$ equals the **signed $n$-dimensional volume** of the parallelepiped they span. In particular:
- $\det(A) = 0$ if and only if the vectors are linearly dependent (the parallelepiped has zero volume).
- $\det(A)$ measures the local volume distortion factor of the linear transformation $f$.

### 2.3 Basis-Free Definition via Exterior Algebra (The Clean Intrinsic Way)

This is the most elegant and basis-independent definition. It uses only the universal property of the exterior algebra.

**Step 1: The determinant line.**  
Let $L = \bigwedge^n V$ be the **top exterior power** of $V$. This is a 1-dimensional vector space (the *determinant line*). Any nonzero element of $L$ can be thought of as a "volume element" on $V$.

**Step 2: Induced map on the determinant line.**  
Any linear map $f: V \to V$ induces a unique linear map on the exterior algebra
$$
\bigwedge^n f : \bigwedge^n V \to \bigwedge^n V,
$$
defined on decomposable elements by
$$
\bigwedge^n f (v_1 \wedge v_2 \wedge \cdots \wedge v_n) = f(v_1) \wedge f(v_2) \wedge \cdots \wedge f(v_n)
$$
and extended by linearity. Because $\bigwedge^n V$ is 1-dimensional, any linear endomorphism of a 1-dimensional space is multiplication by a scalar $\lambda \in K$:
$$
\bigwedge^n f (\omega) = \lambda \, \omega \quad \text{for all } \omega \in L.
$$

**Step 3: Definition of the determinant.**  
We define $\det(f) := \lambda$. This scalar is independent of any basis and satisfies all the classical properties (multiplicativity $\det(f \circ g) = \det(f)\det(g)$, etc.).

**Why this works without a basis:**
- The construction uses only the universal property of the exterior algebra (alternating multilinear maps factor uniquely through $\bigwedge$).
- The 1-dimensionality of $L$ ("homogeneity") guarantees that the induced map is multiplication by a scalar.
- No coordinates or choice of volume form are required because domain and codomain are the *same* line $L$.

This is the definition that generalizes most naturally and will serve as our model when we discuss (0,2) tensors.

### 2.4 Key Properties (Summary)

- **Multiplicativity**: $\det(f \circ g) = \det(f) \det(g)$.
- **Invertibility**: $f$ is invertible $\iff \det(f) \neq 0$.
- **Eigenvalues**: $\det(f) = \prod \lambda_i$ (product of eigenvalues, counted with multiplicity).
- **Characteristic polynomial**: $\det(\lambda I - f) = \lambda^n - \operatorname{tr}(f)\lambda^{n-1} + \cdots + (-1)^n \det(f)$.
- **Volume interpretation**: As described above.

---

## 3. Higher-Order Tensors and the Hyperdeterminant

### 3.1 The Problem with Higher Order

A tensor of order $d > 2$ (a $d$-linear map, or multidimensional array) does not have a direct analogue of the determinant that preserves all the nice properties (multiplicativity, simple geometric meaning, easy computation). Naïve attempts (e.g., summing over multi-permutations with signs) generally fail to be invariant or to detect the correct notion of "singularity."

### 3.2 The Hyperdeterminant – The Standard Generalization

The **hyperdeterminant** (introduced by Arthur Cayley in the 1840s and systematically developed by Gelfand–Kapranov–Zelevinsky in the 1990s) is the correct algebraic generalization.

**Definition (geometric/algebraic):**  
Let $A$ be a tensor in $V_1^* \otimes \cdots \otimes V_r^*$ (an $r$-linear form $f$). The hyperdeterminant $\operatorname{Det}(A)$ is the homogeneous polynomial (with integer coefficients) in the components of $A$ that vanishes if and only if there exist nonzero vectors $x^{(1)} \in V_1, \dots, x^{(r)} \in V_r$ such that *all partial derivatives* of the multilinear form $f$ vanish at $(x^{(1)},\dots,x^{(r)})$. In other words, it is the equation of the *discriminant hypersurface* of the multilinear map.

It exists (as a non-trivial polynomial) only when the format $(k_1+1, \dots, k_r+1)$ (where $\dim V_i = k_i + 1$) satisfies the **convexity condition**:
$$
\max_i k_i \leq \sum_{j \neq i} k_j.
$$
For $r=2$ this reduces exactly to square matrices.

### 3.3 Explicit Example: Cayley's Hyperdeterminant for $2 \times 2 \times 2$ Tensors

Consider a tensor $A = (a_{ijk})$ with indices $i,j,k \in \{0,1\}$ (format $2\times2\times2$).

The hyperdeterminant is the following **quartic** polynomial:
$$
\begin{align*}
\operatorname{Det}(A) &= a_{000}^2 a_{111}^2 + a_{001}^2 a_{110}^2 + a_{010}^2 a_{101}^2 + a_{100}^2 a_{011}^2 \\
&\quad - 2 a_{000} a_{001} a_{110} a_{111} - 2 a_{000} a_{010} a_{101} a_{111} - 2 a_{000} a_{011} a_{100} a_{111} \\
&\quad - 2 a_{001} a_{010} a_{101} a_{110} - 2 a_{001} a_{011} a_{110} a_{100} - 2 a_{010} a_{011} a_{101} a_{100} \\
&\quad + 4 a_{000} a_{011} a_{101} a_{110} + 4 a_{001} a_{010} a_{100} a_{111}.
\end{align*}
$$

It vanishes if and only if the following system of six equations has a nontrivial solution $(x_0,x_1,y_0,y_1,z_0,z_1)$:
$$
\begin{align*}
&a_{000} x_0 y_0 + a_{010} x_0 y_1 + a_{100} x_1 y_0 + a_{110} x_1 y_1 = 0, \\
&a_{001} x_0 y_0 + a_{011} x_0 y_1 + a_{101} x_1 y_0 + a_{111} x_1 y_1 = 0, \\
&a_{000} x_0 z_0 + a_{001} x_0 z_1 + a_{100} x_1 z_0 + a_{101} x_1 z_1 = 0, \\
&a_{010} x_0 z_0 + a_{011} x_0 z_1 + a_{110} x_1 z_0 + a_{111} x_1 z_1 = 0, \\
&a_{000} y_0 z_0 + a_{001} y_0 z_1 + a_{010} y_1 z_0 + a_{011} y_1 z_1 = 0, \\
&a_{100} y_0 z_0 + a_{101} y_0 z_1 + a_{110} y_1 z_0 + a_{111} y_1 z_1 = 0.
\end{align*}
$$

These equations are precisely the conditions that all partial derivatives of the trilinear form vanish.

There are also compact expressions using (generalized) Levi-Civita symbols, but the expanded polynomial above is fully explicit.

### 3.4 Properties of the Hyperdeterminant

- It is a **relative invariant** under the action of $\mathrm{SL}(k_1+1) \times \cdots \times \mathrm{SL}(k_r+1)$.
- For boundary formats it has a geometric interpretation as a discriminant.
- Computation is hard for large formats (related to tensor rank problems).
- It reduces to the ordinary determinant when $r=2$ and the format is square.

Higher-order hyperdeterminants (e.g., for $2\times2\times2\times2$) exist but become extremely complicated.

---

## 4. Rank-2 Covariant Tensors: Bilinear Forms of Type (0,2)

### 4.1 Definition

A **rank-2 covariant tensor** (type (0,2)) on $V$ is a bilinear map
$$
T : V \times V \to K, \qquad T(\lambda v + \mu w, u) = \lambda T(v,u) + \mu T(w,u)
$$
(and similarly in the second argument). Equivalently, $T \in V^* \otimes V^*$.

### 4.2 Matrix Representation and the Usual Determinant

Choose any basis $\{e_1,\dots,e_n\}$. Define the **Gram matrix** (or component matrix) $M$ by
$$
M_{ij} = T(e_i, e_j).
$$
Then one can form the ordinary scalar $\det(M)$. This number *depends on the basis*.

### 4.3 Transformation Law – Why It Is a Density, Not a Scalar

Let $\{e'_i\}$ be a new basis related to the old one by
$$
e'_j = \sum_i P^i_j e_i
$$
($P$ is the change-of-basis matrix). The new components are
$$
M'_{kl} = T(e'_k, e'_l) = \sum_{i,j} P^i_k P^j_l T(e_i, e_j) = (P^T M P)_{kl}.
$$
Therefore
$$
\det(M') = \det(P^T M P) = \det(P^T) \cdot \det(M) \cdot \det(P) = [\det(P)]^2 \det(M).
$$

**Conclusion:** Under basis change, the "determinant" transforms by the factor $[\det(P)]^2$. It is therefore a **tensor density of weight 2**, *not* a true scalar invariant. This is the fundamental reason why a pure (0,2) tensor does not possess a canonical basis-independent scalar determinant in the same way an endomorphism does.

---

## 5. Basis-Independent Constructions for (0,2) Tensors

### 5.1 The Induced Linear Map $\phi_T$

Any (0,2) tensor $T$ defines a linear map
$$
\phi_T : V \to V^* \qquad \text{by} \qquad \phi_T(v)(w) := T(v,w).
$$
$T$ is non-degenerate if and only if $\phi_T$ is an isomorphism.

### 5.2 Induced Map on Determinant Lines

Apply the exterior functor:
$$
\bigwedge^n \phi_T : \bigwedge^n V \to \bigwedge^n V^*.
$$
Since $\bigwedge^n V^* \cong (\bigwedge^n V)^*$, we obtain a canonical linear map between dual lines:
$$
\bigwedge^n \phi_T : L \to L^*,
$$
where $L = \bigwedge^n V$.

This map $L \to L^*$ is the **intrinsic object** associated to $T$. It can be viewed as:
- A quadratic form on the determinant line $L$, or
- An element of $L^* \otimes L^*$.

### 5.3 Why No Canonical Scalar Exists

In the endomorphism case, $\bigwedge^n f : L \to L$ (same line), so the map is multiplication by a scalar $\det(f) \in K$.

Here the map goes from $L$ to its dual $L^*$. A map $L \to L^*$ is *not* multiplication by an element of $K$; it encodes more data (a density). To extract a number one must choose an additional structure (a volume form $\mathrm{vol} \in L^*$) to normalize and pair.

Thus the "determinant" of a pure (0,2) tensor lives naturally in the weight-2 density bundle, not in the scalars.

---

## 6. Weight-2 Densities and Transformation Laws

A **density of weight $w$** on $V$ is an object that, under basis change with matrix $P$, transforms by the factor $[\det(P)]^w$.

From Section 4.3 we see that the ordinary matrix determinant of the Gram matrix of a (0,2) tensor transforms with weight $w=2$.

The map $\bigwedge^n \phi_T : L \to L^*$ transforms with exactly this weight because:
- $L$ itself transforms with weight $-1$ (or $+1$, depending on convention) under $\mathrm{GL}(V)$,
- The dual $L^*$ transforms with the opposite weight,
- The induced map therefore acquires weight 2 overall.

This confirms that the exterior-algebra construction automatically produces an object with the correct transformation law.

In Riemannian geometry, when $T = g$ is a metric, one uses $g$ itself to define a canonical volume form $\mathrm{vol}_g$. Then $\sqrt{|\det(g_{ij})|}$ appears as the coefficient that makes $\mathrm{vol}_g$ have the proper normalization with respect to $g$-orthonormal frames. The raw $\det(g_{ij})$ is recovered squared in the density.

---

## 7. Axiomatic Characterization: Uniquely Deriving the Determinant

We now show that, *assuming only that the object transforms as a weight-2 density*, a small set of natural axioms uniquely determines the determinant (up to a constant factor).

### 7.1 The Five Natural Axioms

Let $d$ be a map that assigns to each bilinear form $T \in \mathcal{B}(V)$ a weight-2 density $d(T)$. We require:

1. **Homogeneity of degree $n$**  
   $$
   d(\lambda T) = \lambda^n \, d(T).
   $$

2. **Detects degeneracy**  
   $d(T) = 0$ if and only if $\phi_T : V \to V^*$ is not an isomorphism.

3. **Correct transformation law (weight 2)**  
   $$
   d(g \cdot T) = [\det(g)]^2 \, d(T) \quad \text{for all } g \in \mathrm{GL}(V).
   $$

4. **Multiplicativity for direct sums**  
   If $V = V_1 \oplus V_2$ and $T = T_1 \oplus T_2$, then
   $$
   d(T) = d(T_1) \cdot d(T_2)
   $$
   (densities multiply compatibly).

5. **Polynomial (or algebraic) character**  
   In any basis, $d(T)$ is given by a homogeneous polynomial of degree $n$ in the components of $T$. For symmetric forms this can be weakened all the way to mere **continuity** — in fact it can be dropped entirely; see Section 7.5.

These axioms are all intrinsic and motivated by the classical properties of the determinant, adapted to the density setting.

### 7.2 Uniqueness: Complete Derivation

We now carry out the full argument that the five axioms force $d(T)$ to equal, in components, the ordinary determinant of the Gram matrix.

**Theorem.** Let $\dim V = n$ and fix a basis $\{e_1,\dots,e_n\}$, so that a bilinear form $T$ is represented by its Gram matrix $M=(T_{ij})$ with $T_{ij}=T(e_i,e_j)$. The only map $d$ satisfying Axioms 1–5 is, in components,
$$
d(T) = c\,\det(T_{ij})
$$
for a single constant $c\in K$, and the normalization of Section 7.3 forces $c=1$, so that
$$
d(T)=\det(T_{ij}).
$$

We work over an algebraically closed field $K$ (for instance $K=\mathbb{C}$); the field $K=\mathbb{R}$ is recovered at the very end by complexification.

#### Step 0 — Reduce to a single polynomial in the components

A weight-2 density on an $n$-dimensional space has a *single* top component. Relative to the fixed basis, $d(T)$ is therefore encoded by one scalar
$$
D(M) := d(T)\big|_{\{e_i\}} \in K, \qquad M=(T_{ij}).
$$
By Axiom 5, $D:\mathrm{Mat}_n(K)\to K$ is a homogeneous polynomial of degree $n$ in the $n^2$ entries $x_{ij}:=T_{ij}$. The entire problem reduces to identifying this one polynomial. The remaining axioms translate into the following statements about $D$:

- **(A1) Homogeneity.** $D(\lambda M)=\lambda^n D(M)$.
- **(A2) Degeneracy.** $D(M)=0 \iff \det M = 0$, because $\phi_T$ is an isomorphism iff $M$ is invertible.
- **(A3) Weight-2 law.** $D(P^{\mathsf T} M P) = (\det P)^2\,D(M)$ for all $P\in GL_n(K)$ (this is exactly the computation of Section 4.3).
- **(A4) Block multiplicativity.** $D\!\begin{pmatrix}M_1&0\\0&M_2\end{pmatrix} = D_{k}(M_1)\,D_{n-k}(M_2)$, where $D_m$ denotes the degree-$m$ function in dimension $m$.

#### Step 1 — The determinant is an irreducible polynomial

This is the structural fact that makes the degeneracy axiom so powerful.

**Lemma.** For every $n\ge 1$, $\det_n=\det(x_{ij})$ is irreducible in the polynomial ring $K[x_{ij} : 1\le i,j\le n]$.

*Proof.* Induct on $n$. For $n=1$, $\det_1=x_{11}$ is irreducible. Let $n\ge 2$ and expand along the first column:
$$
\det_n=\sum_{i=1}^n (-1)^{i+1} x_{i1}\,A_{i1},
$$
where $A_{i1}$ is the minor obtained by deleting row $i$ and column $1$. Observe:

1. $A_{11}$ is the determinant of the block on rows and columns $\{2,\dots,n\}$, hence irreducible by the inductive hypothesis;
2. no minor $A_{i1}$ contains any column-1 variable, and $A_{11}$ contains no row-1 variable.

Because the variables $x_{i1}$ of column $1$ occur in $\det_n$ only through the explicit factors above, $\det_n$ is **linear in $x_{11}$**, with coefficient $A_{11}$.

Suppose $\det_n=PQ$ with $P,Q$ non-constant. Linearity in $x_{11}$ forces $x_{11}$ to appear in exactly one factor, say $P$; then $Q$ is free of $x_{11}$. Comparing the coefficients of $x_{11}$ gives $A_{11}=(\partial_{x_{11}}P)\,Q$, so $Q\mid A_{11}$. Since $A_{11}$ is irreducible, either $Q$ is a nonzero constant — contradicting non-constancy — or
$$
Q=c\,A_{11}\quad(c\in K^\times), \qquad\text{whence}\qquad A_{11}\mid \det_n.
$$
We rule out the latter. As $A_{11}$ is free of $x_{11}$, the divisibility persists after setting $x_{11}=0$:
$$
A_{11}\mid \det_n\big|_{x_{11}=0}.
$$
Now $\det_n$ is linear in $x_{21}$ with coefficient $-A_{21}$ (every column-1 variable appears only once), and $A_{11}$ is free of $x_{21}$; hence $A_{11}\mid A_{21}$. Both polynomials have degree $n-1$ and $A_{11}$ is irreducible, so $A_{21}=c'A_{11}$ for a constant $c'$. This is impossible: the minor $A_{21}$ (delete row $2$, column $1$) involves the row-1 variable $x_{12}$, whereas $A_{11}$ does not. The contradiction shows $Q$ must be constant, so $\det_n$ is irreducible. $\qquad\square$

#### Step 2 — The determinant divides $D$

By Axiom A2 the polynomial $D$ vanishes at *every* point of the determinantal hypersurface $\{M : \det M = 0\}$. Since $\det$ is irreducible (Step 1), it is in particular squarefree, so the principal ideal $(\det)$ is prime and therefore radical. Hilbert's Nullstellensatz then gives
$$
I\big(\{\det = 0\}\big)=\sqrt{(\det)}=(\det).
$$
As $D$ lies in this vanishing ideal, $D\in(\det)$; that is, $\det\mid D$, so there is a polynomial $E$ with
$$
D=E\cdot\det .
$$

#### Step 3 — A degree count pins down $D=c\det$

Both $\det$ and (by Axiom 5 / A1) $D$ are homogeneous of degree exactly $n$. Hence the quotient $E=D/\det$ is homogeneous of degree $0$, i.e. a constant:
$$
\boxed{\,D(M)=c\,\det(M)\,}\qquad\text{for some } c\in K.
$$
This already establishes uniqueness up to a single scalar, using **only Axioms 2 and 5** together with the irreducibility of $\det$. (Note that the weight law A3 has not yet been used — in agreement with the fact that the weight alone does *not* characterize the determinant; the degeneracy and polynomiality axioms are what do the work.)

#### Step 4 — Identifying the constant intrinsically

Axioms 1 and 4 compute $c$ without any arbitrary basis-dependent choice. Apply A4 repeatedly to a diagonal Gram matrix $M=\operatorname{diag}(\lambda_1,\dots,\lambda_n)$, arising from an orthogonal direct sum $T=T_1\oplus\cdots\oplus T_n$ of one-dimensional forms with $\lambda_i=T_i(e_i,e_i)$:
$$
D\big(\operatorname{diag}(\lambda_1,\dots,\lambda_n)\big)=\prod_{i=1}^n D_1(\lambda_i).
$$
In dimension one, A1 gives $D_1(\lambda)=\lambda\,D_1(1)$. Writing $\kappa:=D_1(1)$,
$$
D\big(\operatorname{diag}(\lambda_1,\dots,\lambda_n)\big)=\kappa^{\,n}\prod_{i=1}^n \lambda_i=\kappa^{\,n}\,\det\big(\operatorname{diag}(\lambda_1,\dots,\lambda_n)\big).
$$
Comparing with Step 3 on diagonal matrices yields
$$
c=\kappa^{\,n}=\big(D_1(1)\big)^n .
$$
The overall constant is thus the $n$-th power of the single one-dimensional normalization constant $D_1(1)$ — precisely the residual freedom removed in Section 7.3.

#### Step 5 — Consistency with the weight-2 law (and a Nullstellensatz-free route)

The solution $D=c\det$ automatically satisfies A3, since
$$
D(P^{\mathsf T}MP)=c\det(P^{\mathsf T}MP)=c\,(\det P)^2\det M=(\det P)^2 D(M).
$$
So A3 imposes no further constraint: it is exactly the transformation law $\det$ already obeys, and its real content is that the answer is a genuine weight-2 *density*, not a bare number.

Conversely, A3 by itself gives a quick elementary derivation on the dense set of nondegenerate symmetric forms, bypassing the Nullstellensatz. Over $K=\overline{K}$ with $\operatorname{char}K\ne 2$, every nondegenerate symmetric $M$ is congruent to the identity, $M=P^{\mathsf T}P$, so
$$
D(M)=D(P^{\mathsf T}P)=(\det P)^2 D(I)=(\det P)^2\,c=c\,\det M,
$$
because $\det M=(\det P)^2$. Since the nondegenerate matrices are Zariski-dense and $D-c\det$ is polynomial, $D=c\det$ everywhere on symmetric forms. (For non-symmetric bilinear forms the symmetric and antisymmetric parts decouple under congruence and cannot be simultaneously diagonalized — which is exactly why the general statement genuinely needs the irreducibility argument of Steps 1–3.)

#### Step 6 — The real field

Over $K=\mathbb{R}$ the identity $D=c\det$ follows by complexification. By Axiom 5, $D\in\mathbb{R}[x_{ij}]$; extend it to $D_{\mathbb{C}}\in\mathbb{C}[x_{ij}]$. Steps 1–3 apply over $\mathbb{C}$ and give $D_{\mathbb{C}}=c\det$ with $c\in\mathbb{C}$; evaluating at a single real matrix (e.g. $D(I)$) shows $c\in\mathbb{R}$. Equivalently, an identity of polynomials that holds on the Zariski-dense set of real points holds identically.

#### Conclusion and the role of each axiom

Putting the steps together, every solution of Axioms 1–5 is
$$
d(T)=c\,\det(T_{ij}),\qquad c=\big(D_1(1)\big)^n,
$$
and imposing the normalization $d(T_0)=1$ of Section 7.3 (e.g. taking $T_0$ to be the form with Gram matrix $I$) forces $c=1$:
$$
\boxed{\,d(T)=\det(T_{ij})\,}.
$$

The five axioms play sharply distinct roles:

- **Axiom 5** (polynomial of degree $n$) places $D$ inside $K[x_{ij}]$ and bounds its degree.
- **Axiom 2** (degeneracy) forces $D$ to vanish on the *irreducible* hypersurface $\{\det=0\}$; with Axiom 5 this already yields $D=c\det$ (Steps 1–3). **These two axioms alone give uniqueness up to scale.**
- **Axioms 1 and 4** (homogeneity and direct sums) pin the constant intrinsically as the $n$-th power of the one-dimensional value (Step 4).
- **Axiom 3** (weight-2 law) is automatically satisfied; it supplies the alternative congruence derivation and, crucially, certifies that the output is the correct density rather than a mere scalar. By itself it is *not* enough to single out the determinant — uniqueness rests on Axioms 2 and 5.

### 7.3 Normalization – Removing the Ambiguity

Choose any fixed non-degenerate reference bilinear form $T_0$ that can be characterized intrinsically (for example, the standard dot product on $K^n$ when a preferred basis or inner-product structure is available, or the form induced by an endomorphism via a fixed volume form). Require
$$
d(T_0) = 1.
$$
This fixes the constant completely. The resulting function is then the **unique** object satisfying all the axioms.

### 7.4 The Exterior-Algebra Construction Satisfies All Axioms

The map $\bigwedge^n \phi_T : L \to L^*$ (or the associated quadratic form on $L$) satisfies:
- Homogeneity of degree $n$ (because each factor of $\phi_T$ contributes degree 1).
- Vanishes exactly when $\phi_T$ is singular (the induced map on top exterior power is zero precisely then).
- Transforms with weight exactly 2 (as shown in Section 6).
- Is multiplicative for direct sums (exterior algebra respects direct sums).
- Is polynomial of degree $n$.

When a volume form is chosen to normalize, it yields a scalar density satisfying the normalization condition on reference forms. Therefore it *is* the unique object characterized by the axioms.

### 7.5 Continuity in Place of Polynomiality

Axiom 5 was used in Section 7.2 in an essential, but rather heavy, way: it placed $D$ inside the polynomial ring so that the Nullstellensatz could be applied. It is natural to ask whether the much weaker hypothesis of **continuity** suffices. The answer is a clean *yes for symmetric forms* — which is exactly the geometrically relevant case, since metrics and quadratic forms are symmetric — and there the regularity hypothesis can in fact be removed altogether. We also explain the one genuine pitfall over $\mathbb{R}$ that makes the precise statement matter.

Throughout, $D(M)$ denotes the component function of Section 7.2 (Step 0), and we read the axioms as holding for forms on spaces of *every* finite dimension (Axiom 4 already forces us to consider subspaces), so in particular homogeneity (Axiom 1) holds in each dimension.

#### The symmetric case: Axioms 1–4 already suffice (no regularity at all)

**Theorem.** Let $T$ range over *symmetric* bilinear forms. Then Axioms 1–4 alone force
$$
d(T)=\kappa^{\,n}\,\det(T_{ij}),\qquad \kappa:=D_1(1),
$$
and the normalization of Section 7.3 gives $\kappa=1$. No polynomiality and no continuity are needed.

*Proof.* 

**Step 1 (dimension one).** A one-dimensional form is a single number $\lambda$, and Axiom 1 (in dimension one) reads $D_1(\lambda)=D_1(\lambda\cdot 1)=\lambda\,D_1(1)=\kappa\lambda$. Thus $D_1$ is *linear* — there is no room for, say, $|\lambda|$.

**Step 2 (diagonal forms).** Iterating the block-multiplicativity Axiom 4 over the orthogonal splitting into one-dimensional pieces,
$$
D\big(\operatorname{diag}(\lambda_1,\dots,\lambda_n)\big)=\prod_{i=1}^n D_1(\lambda_i)=\kappa^{\,n}\prod_{i=1}^n\lambda_i=\kappa^{\,n}\det\big(\operatorname{diag}(\lambda_1,\dots,\lambda_n)\big).
$$

**Step 3 (all symmetric forms).** By the real spectral theorem (or Sylvester's law of inertia) every symmetric $M$ is congruent to a diagonal matrix, $M=P^{\mathsf T}\Lambda P$ with $\Lambda$ diagonal. If $M$ is nondegenerate, Axiom 3 gives
$$
D(M)=(\det P)^2 D(\Lambda)=(\det P)^2\,\kappa^{\,n}\det\Lambda=\kappa^{\,n}\det(P^{\mathsf T}\Lambda P)=\kappa^{\,n}\det M.
$$
If $M$ is degenerate, Axiom 2 gives $D(M)=0=\kappa^{\,n}\det M$. Hence $D=\kappa^{\,n}\det$ on *all* symmetric forms. $\qquad\square$

The point is that congruence is **transitive enough** on symmetric forms — every symmetric matrix has a diagonal representative — so Axiom 3 alone propagates the value from the diagonal forms (where Axioms 1 and 4 already determine it) to every symmetric form, *exactly*, with no limiting argument. This is why no regularity is needed here. If one nevertheless prefers to state a fifth axiom, **continuity is more than enough** and is the "much better" hypothesis: it is far weaker than polynomiality and is automatically satisfied by the exterior-algebra construction of Section 7.4.

#### Why "continuity in dimension $n$ alone" is *not* enough

It is essential that homogeneity be imposed in *every* dimension (so that the one-dimensional piece is forced to be linear). If one only assumes the axioms in the fixed dimension $n$ and merely asks for continuity, the determinant is **not** singled out. The clean counterexample is, for **even** $n$,
$$
D(M)=|\det M|.
$$
Indeed $|\det|$ is continuous and satisfies, in dimension $n$ even,
$$
|\det(\lambda M)|=|\lambda|^{n}|\det M|=\lambda^{n}|\det M|,\quad
|\det(P^{\mathsf T}MP)|=(\det P)^2|\det M|,\quad
|\det(M_1\oplus M_2)|=|\det M_1|\,|\det M_2|,
$$
so it obeys Axioms 1–4 *within dimension $n$* and the degeneracy Axiom 2, yet it is not a constant multiple of $\det$ (it never takes negative values). What rescues uniqueness is precisely the cross-dimensional reading above: $|\det|$ corresponds to the one-dimensional rule $D_1(\lambda)=|\lambda|$, which violates Axiom 1 in dimension one ($D_1(-1)=1\neq -1=(-1)\cdot D_1(1)$). Equivalently, $|\det|$ is exactly the sign-twisted impostor $D=\operatorname{sign}(\det)\cdot\det$, and over $\mathbb{R}$ the nondegenerate locus is *disconnected* (the connected components are the signature classes $(p,q)$), so a hypothesis that does not link the components — bare continuity in one dimension — cannot exclude a different constant on each component. The polynomial Axiom 5 excluded these impostors automatically, because $|\det|$ and its relatives are not polynomials; the cross-dimensional homogeneity above excludes them just as effectively, and much more cheaply.

#### The general (non-symmetric) case

For a *general* (0,2) tensor the Gram matrix need not be congruent to a diagonal one: congruence preserves the symmetric and antisymmetric parts separately, so the reduction of Step 3 is unavailable, and the nondegenerate orbits are neither dense nor open in one another. Here continuity by itself is delicate (one must control congruence invariants such as the eigenvalues of the cosquare $M^{-\mathsf T}M$), and the clean sufficient hypothesis is the polynomial Axiom 5 used in Section 7.2. In short:

- **Symmetric forms (metrics, quadratic forms):** Axioms 1–4 already give $d(T)=\det(T_{ij})$ after normalization; a regularity axiom is optional, and if included, *continuity* is the natural and sufficient choice.
- **Arbitrary bilinear forms:** keep the polynomial Axiom 5 (Section 7.2), which handles every form uniformly via the irreducibility of $\det$.

---

## 8. Special Cases and Geometric Applications

### 8.1 Symmetric Bilinear Forms / Quadratic Forms

When $T$ is symmetric, the associated quadratic form $Q(v) = T(v,v)$ has a well-studied **discriminant**, which is $\det(M)$ considered as an element of the quotient group $K^\times / (K^\times)^2$. This is a true invariant (independent of basis) and classifies quadratic forms up to isomorphism over many fields (together with the Hasse invariant, signature, etc.).

### 8.2 Skew-Symmetric Bilinear Forms (2-Forms)

For even dimension $n = 2m$, the top exterior power
$$
\underbrace{T \wedge T \wedge \cdots \wedge T}_{m \text{ times}} \in \bigwedge^n V^*
$$
is a canonical $n$-form. Its coefficient with respect to a volume form is (a multiple of) the **Pfaffian**. We have $\operatorname{Pf}(T)^2 = \pm \det(T)$. Again, a scalar requires a volume form.

### 8.3 Riemannian Metrics

A Riemannian metric $g$ is a positive-definite symmetric (0,2) tensor. It canonically defines a volume form $\mathrm{vol}_g$ by declaring that $\mathrm{vol}_g(v_1,\dots,v_n) = 1$ for any $g$-orthonormal positively oriented basis. In local coordinates,
$$
\mathrm{vol}_g = \sqrt{|\det(g_{ij})|} \, dx^1 \wedge \cdots \wedge dx^n.
$$
Thus $\sqrt{|\det g|}$ is recovered intrinsically as the normalizing factor. The raw determinant $\det(g_{ij})$ appears in the transformation law of the density.

### 8.4 When the (0,2) Tensor Comes from an Endomorphism

If we have an endomorphism $f$ and a fixed volume form $\mathrm{vol}$, we can define $T(v,w) = \mathrm{vol}(f(v),w)$. Then the determinant of $T$ (in the density sense) recovers the ordinary $\det(f)$ after normalization by $\mathrm{vol}$.

---

## 9. Conclusion and Further Directions

- **Endomorphisms ((1,1) tensors)**: The determinant is a canonical scalar, uniquely characterized via the exterior algebra $\bigwedge^n f : L \to L$.
- **Higher-order tensors**: The hyperdeterminant is the natural generalization (a polynomial detecting degeneracy of the multilinear map). It exists only for certain formats.
- **Pure covariant (0,2) tensors**: There is no canonical *scalar* determinant. The natural object is the induced map $L \to L^*$ (or the associated weight-2 density). It is uniquely determined (up to scale) by the five natural axioms listed in Section 7, including the weight-2 transformation law.
- The exterior-algebra construction provides the explicit, functorial realization that satisfies all the axioms.

In practice:
- Use the classical determinant when you have an endomorphism or a matrix.
- Use the hyperdeterminant when working with higher-order tensors in algebraic geometry or tensor decomposition.
- Use the density-aware version (or $\sqrt{|\det|}$) when working with metrics or bilinear forms on manifolds.
- Always keep track of transformation weights when changing coordinates or bases.

---

## 10. References and Further Reading

- **Classical determinant**: Any standard linear algebra textbook (e.g., Axler, Hoffman & Kunze, or Lang).
- **Exterior algebra and intrinsic determinant**: Greub, *Multilinear Algebra*; or any text covering the exterior algebra functor.
- **Hyperdeterminant**: Gelfand, Kapranov, Zelevinsky, *Discriminants, Resultants and Multidimensional Determinants*; Wikipedia article on "Hyperdeterminant".
- **Bilinear forms and discriminants**: K. Conrad, *Bilinear Forms* (online notes); Lam, *Introduction to Quadratic Forms over Fields*.
- **Differential geometry / metrics**: Lee, *Introduction to Riemannian Manifolds*; or any text on tensor calculus on manifolds.
- **Invariant theory**: Procesi, *Lie Groups: An Approach through Invariants and Representations* (for the representation-theoretic view of relative invariants).

This document aimed to be complete and self-contained. All steps—from classical definitions through the exterior-algebra construction, transformation laws, and the axiomatic uniqueness proof—have been spelled out explicitly.

If you need a rendered PDF version, additional examples, code to compute hyperdeterminants, or extensions to manifolds with density bundles, please let me know!
