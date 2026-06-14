# Determinant of Tensors: A Comprehensive Guide

## From Classical Matrices to Higher-Order Generalizations and Intrinsic Definitions for Covariant Bilinear Forms

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [The Determinant for Matrices (Rank-2 Endomorphisms)](#2-the-determinant-for-matrices-rank-2-endomorphisms)
3. [Higher-Order Tensors and the Hyperdeterminant](#3-higher-order-tensors-and-the-hyperdeterminant)
4. [Rank-2 Covariant Tensors: Bilinear Forms of Type (0,2)](#4-rank-2-covariant-tensors-bilinear-forms-of-type-02)
5. [Basis-Independent Constructions for (0,2) Tensors](#5-basis-independent-constructions-for-02-tensors)
6. [Weight-2 Densities and Transformation Laws](#6-weight-2-densities-and-transformation-laws)
7. [Axiomatic Characterization: Uniquely Deriving the Determinant](#7-axiomatic-characterization-uniquely-deriving-the-determinant)
8. [Special Cases and Geometric Applications](#8-special-cases-and-geometric-applications)
9. [Conclusion and Further Directions](#9-conclusion-and-further-directions)
10. [References and Further Reading](#10-references-and-further-reading)

---

## 1. Introduction

The concept of the **determinant** is one of the most fundamental in linear algebra. For an \(n \times n\) matrix \(A\), \(\det(A)\) is a scalar that encodes critical information: it tells us whether \(A\) is invertible, measures the signed volume scaling factor of the linear transformation represented by \(A\), and appears in countless formulas (Cramer's rule, characteristic polynomial, change of variables in integration, etc.).

When we move from matrices to **tensors** (multi-linear objects of higher rank or different variance types), the situation becomes more subtle. A matrix can be viewed as a rank-2 tensor of type (1,1) (an endomorphism) or (0,2) (a bilinear form). For higher-order tensors (order \(d > 2\)), or even for pure covariant rank-2 tensors without additional structure, there is no universally agreed "determinant" that preserves *all* the familiar properties.

This document provides a complete, self-contained explanation, starting from the classical case and building up rigorously to intrinsic (basis-free) definitions, with special emphasis on:

- The hyperdeterminant for higher-order tensors.
- Why a pure (0,2) covariant tensor does *not* have a canonical scalar determinant.
- How the natural object lives in a weight-2 density bundle.
- An axiomatic characterization that uniquely determines the determinant (up to scale) assuming only natural properties, including the weight-2 transformation law.

All constructions are presented step-by-step, with explicit formulas, geometric interpretations, and proofs of key properties where feasible.

---

## 2. The Determinant for Matrices (Rank-2 Endomorphisms)

### 2.1 Classical Definitions (with Basis)

Let \(V\) be an \(n\)-dimensional vector space over a field \(K\) (usually \(\mathbb{R}\) or \(\mathbb{C}\)) and let \(f: V \to V\) be a linear endomorphism. Fix a basis \(\{e_1, \dots, e_n\}\) of \(V\). The matrix of \(f\) with respect to this basis is the \(n \times n\) matrix \(A = (a_{ij})\) where
\[
f(e_j) = \sum_{i=1}^n a_{ij} e_i.
\]

The **determinant** of \(A\) (and thus of \(f\)) can be defined in several equivalent ways:

**Leibniz formula (permutation expansion):**
\[
\det(A) = \sum_{\sigma \in S_n} \operatorname{sgn}(\sigma) \prod_{i=1}^n a_{i,\sigma(i)},
\]
where \(S_n\) is the symmetric group of all permutations of \(\{1,\dots,n\}\) and \(\operatorname{sgn}(\sigma) = +1\) if \(\sigma\) is even, \(-1\) if odd.

**Levi-Civita symbol expression:**
\[
\det(A) = \sum_{i_1,\dots,i_n = 1}^n \epsilon_{i_1 \dots i_n} a_{1 i_1} \cdots a_{n i_n},
\]
where \(\epsilon_{1 2 \dots n} = +1\) and \(\epsilon\) is totally antisymmetric.

**Cofactor expansion** (recursive definition along a row or column) and many other equivalent characterizations exist.

These definitions depend on the choice of basis, but the resulting scalar \(\det(A)\) is independent of the basis in the following sense: if we change basis with an invertible matrix \(P\), the new matrix is \(A' = P^{-1} A P\), and
\[
\det(A') = \det(A).
\]
Thus \(\det(f)\) is intrinsically associated to the linear map \(f\).

### 2.2 Geometric Meaning

If the columns of \(A\) are vectors \(v_1, \dots, v_n \in V\), then \(|\det(A)|\) equals the **signed \(n\)-dimensional volume** of the parallelepiped they span. In particular:
- \(\det(A) = 0\) if and only if the vectors are linearly dependent (the parallelepiped has zero volume).
- \(\det(A)\) measures the local volume distortion factor of the linear transformation \(f\).

### 2.3 Basis-Free Definition via Exterior Algebra (The Clean Intrinsic Way)

This is the most elegant and basis-independent definition. It uses only the universal property of the exterior algebra.

**Step 1: The determinant line.**  
Let \(L = \bigwedge^n V\) be the **top exterior power** of \(V\). This is a 1-dimensional vector space (the *determinant line*). Any nonzero element of \(L\) can be thought of as a "volume element" on \(V\).

**Step 2: Induced map on the determinant line.**  
Any linear map \(f: V \to V\) induces a unique linear map on the exterior algebra
\[
\bigwedge^n f : \bigwedge^n V \to \bigwedge^n V,
\]
defined on decomposable elements by
\[
\bigwedge^n f (v_1 \wedge v_2 \wedge \cdots \wedge v_n) = f(v_1) \wedge f(v_2) \wedge \cdots \wedge f(v_n)
\]
and extended by linearity. Because \(\bigwedge^n V\) is 1-dimensional, any linear endomorphism of a 1-dimensional space is multiplication by a scalar \(\lambda \in K\):
\[
\bigwedge^n f (\omega) = \lambda \, \omega \quad \text{for all } \omega \in L.
\]

**Step 3: Definition of the determinant.**  
We define \(\det(f) := \lambda\). This scalar is independent of any basis and satisfies all the classical properties (multiplicativity \(\det(f \circ g) = \det(f)\det(g)\), etc.).

**Why this works without a basis:**
- The construction uses only the universal property of the exterior algebra (alternating multilinear maps factor uniquely through \(\bigwedge\)).
- The 1-dimensionality of \(L\) ("homogeneity") guarantees that the induced map is multiplication by a scalar.
- No coordinates or choice of volume form are required because domain and codomain are the *same* line \(L\).

This is the definition that generalizes most naturally and will serve as our model when we discuss (0,2) tensors.

### 2.4 Key Properties (Summary)

- **Multiplicativity**: \(\det(f \circ g) = \det(f) \det(g)\).
- **Invertibility**: \(f\) is invertible \(\iff \det(f) \neq 0\).
- **Eigenvalues**: \(\det(f) = \prod \lambda_i\) (product of eigenvalues, counted with multiplicity).
- **Characteristic polynomial**: \(\det(\lambda I - f) = \lambda^n - \operatorname{tr}(f)\lambda^{n-1} + \cdots + (-1)^n \det(f)\).
- **Volume interpretation**: As described above.

---

## 3. Higher-Order Tensors and the Hyperdeterminant

### 3.1 The Problem with Higher Order

A tensor of order \(d > 2\) (a \(d\)-linear map, or multidimensional array) does not have a direct analogue of the determinant that preserves all the nice properties (multiplicativity, simple geometric meaning, easy computation). Naïve attempts (e.g., summing over multi-permutations with signs) generally fail to be invariant or to detect the correct notion of "singularity."

### 3.2 The Hyperdeterminant – The Standard Generalization

The **hyperdeterminant** (introduced by Arthur Cayley in the 1840s and systematically developed by Gelfand–Kapranov–Zelevinsky in the 1990s) is the correct algebraic generalization.

**Definition (geometric/algebraic):**  
Let \(A\) be a tensor in \(V_1^* \otimes \cdots \otimes V_r^*\) (an \(r\)-linear form \(f\)). The hyperdeterminant \(\operatorname{Det}(A)\) is the homogeneous polynomial (with integer coefficients) in the components of \(A\) that vanishes if and only if there exist nonzero vectors \(x^{(1)} \in V_1, \dots, x^{(r)} \in V_r\) such that *all partial derivatives* of the multilinear form \(f\) vanish at \((x^{(1)},\dots,x^{(r)})\). In other words, it is the equation of the *discriminant hypersurface* of the multilinear map.

It exists (as a non-trivial polynomial) only when the format \((k_1+1, \dots, k_r+1)\) (where \(\dim V_i = k_i + 1\)) satisfies the **convexity condition**:
\[
\max_i k_i \leq \sum_{j \neq i} k_j.
\]
For \(r=2\) this reduces exactly to square matrices.

### 3.3 Explicit Example: Cayley's Hyperdeterminant for \(2 \times 2 \times 2\) Tensors

Consider a tensor \(A = (a_{ijk})\) with indices \(i,j,k \in \{0,1\}\) (format \(2\times2\times2\)).

The hyperdeterminant is the following **quartic** polynomial:
\[
\begin{align*}
\operatorname{Det}(A) &= a_{000}^2 a_{111}^2 + a_{001}^2 a_{110}^2 + a_{010}^2 a_{101}^2 + a_{100}^2 a_{011}^2 \\
&\quad - 2 a_{000} a_{001} a_{110} a_{111} - 2 a_{000} a_{010} a_{101} a_{111} - 2 a_{000} a_{011} a_{100} a_{111} \\
&\quad - 2 a_{001} a_{010} a_{101} a_{110} - 2 a_{001} a_{011} a_{110} a_{100} - 2 a_{010} a_{011} a_{101} a_{100} \\
&\quad + 4 a_{000} a_{011} a_{101} a_{110} + 4 a_{001} a_{010} a_{100} a_{111}.
\end{align*}
\]

It vanishes if and only if the following system of six equations has a nontrivial solution \((x_0,x_1,y_0,y_1,z_0,z_1)\):
\[
\begin{align*}
&a_{000} x_0 y_0 + a_{010} x_0 y_1 + a_{100} x_1 y_0 + a_{110} x_1 y_1 = 0, \\
&a_{001} x_0 y_0 + a_{011} x_0 y_1 + a_{101} x_1 y_0 + a_{111} x_1 y_1 = 0, \\
&a_{000} x_0 z_0 + a_{001} x_0 z_1 + a_{100} x_1 z_0 + a_{101} x_1 z_1 = 0, \\
&a_{010} x_0 z_0 + a_{011} x_0 z_1 + a_{110} x_1 z_0 + a_{111} x_1 z_1 = 0, \\
&a_{000} y_0 z_0 + a_{001} y_0 z_1 + a_{010} y_1 z_0 + a_{011} y_1 z_1 = 0, \\
&a_{100} y_0 z_0 + a_{101} y_0 z_1 + a_{110} y_1 z_0 + a_{111} y_1 z_1 = 0.
\end{align*}
\]

These equations are precisely the conditions that all partial derivatives of the trilinear form vanish.

There are also compact expressions using (generalized) Levi-Civita symbols, but the expanded polynomial above is fully explicit.

### 3.4 Properties of the Hyperdeterminant

- It is a **relative invariant** under the action of \(\mathrm{SL}(k_1+1) \times \cdots \times \mathrm{SL}(k_r+1)\).
- For boundary formats it has a geometric interpretation as a discriminant.
- Computation is hard for large formats (related to tensor rank problems).
- It reduces to the ordinary determinant when \(r=2\) and the format is square.

Higher-order hyperdeterminants (e.g., for \(2\times2\times2\times2\)) exist but become extremely complicated.

---

## 4. Rank-2 Covariant Tensors: Bilinear Forms of Type (0,2)

### 4.1 Definition

A **rank-2 covariant tensor** (type (0,2)) on \(V\) is a bilinear map
\[
T : V \times V \to K, \qquad T(\lambda v + \mu w, u) = \lambda T(v,u) + \mu T(w,u)
\]
(and similarly in the second argument). Equivalently, \(T \in V^* \otimes V^*\).

### 4.2 Matrix Representation and the Usual Determinant

Choose any basis \(\{e_1,\dots,e_n\}\). Define the **Gram matrix** (or component matrix) \(M\) by
\[
M_{ij} = T(e_i, e_j).
\]
Then one can form the ordinary scalar \(\det(M)\). This number *depends on the basis*.

### 4.3 Transformation Law – Why It Is a Density, Not a Scalar

Let \(\{e'_i\}\) be a new basis related to the old one by
\[
e'_j = \sum_i P^i_j e_i
\]
(\(P\) is the change-of-basis matrix). The new components are
\[
M'_{kl} = T(e'_k, e'_l) = \sum_{i,j} P^i_k P^j_l T(e_i, e_j) = (P^T M P)_{kl}.
\]
Therefore
\[
\det(M') = \det(P^T M P) = \det(P^T) \cdot \det(M) \cdot \det(P) = [\det(P)]^2 \det(M).
\]

**Conclusion:** Under basis change, the "determinant" transforms by the factor \([\det(P)]^2\). It is therefore a **tensor density of weight 2**, *not* a true scalar invariant. This is the fundamental reason why a pure (0,2) tensor does not possess a canonical basis-independent scalar determinant in the same way an endomorphism does.

---

## 5. Basis-Independent Constructions for (0,2) Tensors

### 5.1 The Induced Linear Map \(\phi_T\)

Any (0,2) tensor \(T\) defines a linear map
\[
\phi_T : V \to V^* \qquad \text{by} \qquad \phi_T(v)(w) := T(v,w).
\]
\(T\) is non-degenerate if and only if \(\phi_T\) is an isomorphism.

### 5.2 Induced Map on Determinant Lines

Apply the exterior functor:
\[
\bigwedge^n \phi_T : \bigwedge^n V \to \bigwedge^n V^*.
\]
Since \(\bigwedge^n V^* \cong (\bigwedge^n V)^*\), we obtain a canonical linear map between dual lines:
\[
\bigwedge^n \phi_T : L \to L^*,
\]
where \(L = \bigwedge^n V\).

This map \(L \to L^*\) is the **intrinsic object** associated to \(T\). It can be viewed as:
- A quadratic form on the determinant line \(L\), or
- An element of \(L^* \otimes L^*\).

### 5.3 Why No Canonical Scalar Exists

In the endomorphism case, \(\bigwedge^n f : L \to L\) (same line), so the map is multiplication by a scalar \(\det(f) \in K\).

Here the map goes from \(L\) to its dual \(L^*\). A map \(L \to L^*\) is *not* multiplication by an element of \(K\); it encodes more data (a density). To extract a number one must choose an additional structure (a volume form \(\mathrm{vol} \in L^*\)) to normalize and pair.

Thus the "determinant" of a pure (0,2) tensor lives naturally in the weight-2 density bundle, not in the scalars.

---

## 6. Weight-2 Densities and Transformation Laws

A **density of weight \(w\)** on \(V\) is an object that, under basis change with matrix \(P\), transforms by the factor \([\det(P)]^w\).

From Section 4.3 we see that the ordinary matrix determinant of the Gram matrix of a (0,2) tensor transforms with weight \(w=2\).

The map \(\bigwedge^n \phi_T : L \to L^*\) transforms with exactly this weight because:
- \(L\) itself transforms with weight \(-1\) (or \(+1\), depending on convention) under \(\mathrm{GL}(V)\),
- The dual \(L^*\) transforms with the opposite weight,
- The induced map therefore acquires weight 2 overall.

This confirms that the exterior-algebra construction automatically produces an object with the correct transformation law.

In Riemannian geometry, when \(T = g\) is a metric, one uses \(g\) itself to define a canonical volume form \(\mathrm{vol}_g\). Then \(\sqrt{|\det(g_{ij})|}\) appears as the coefficient that makes \(\mathrm{vol}_g\) have the proper normalization with respect to \(g\)-orthonormal frames. The raw \(\det(g_{ij})\) is recovered squared in the density.

---

## 7. Axiomatic Characterization: Uniquely Deriving the Determinant

We now show that, *assuming only that the object transforms as a weight-2 density*, a small set of natural axioms uniquely determines the determinant (up to a constant factor).

### 7.1 The Five Natural Axioms

Let \(d\) be a map that assigns to each bilinear form \(T \in \mathcal{B}(V)\) a weight-2 density \(d(T)\). We require:

1. **Homogeneity of degree \(n\)**  
   \[
   d(\lambda T) = \lambda^n \, d(T).
   \]

2. **Detects degeneracy**  
   \(d(T) = 0\) if and only if \(\phi_T : V \to V^*\) is not an isomorphism.

3. **Correct transformation law (weight 2)**  
   \[
   d(g \cdot T) = [\det(g)]^2 \, d(T) \quad \text{for all } g \in \mathrm{GL}(V).
   \]

4. **Multiplicativity for direct sums**  
   If \(V = V_1 \oplus V_2\) and \(T = T_1 \oplus T_2\), then
   \[
   d(T) = d(T_1) \cdot d(T_2)
   \]
   (densities multiply compatibly).

5. **Polynomial (or algebraic) character**  
   In any basis, \(d(T)\) is given by a homogeneous polynomial of degree \(n\) in the components of \(T\).

These axioms are all intrinsic and motivated by the classical properties of the determinant, adapted to the density setting.

### 7.2 Uniqueness (Sketch)

The set of degenerate bilinear forms is the zero set of a single irreducible homogeneous polynomial of degree \(n\) in the components (the determinantal hypersurface). Because this hypersurface is irreducible, any polynomial vanishing on it must be a scalar multiple of this generator.

Axiom 3 fixes the precise character (weight 2) under the \(\mathrm{GL}(V)\) action. Therefore the polynomial is unique up to a constant scalar in \(K\).

Axioms 1 and 4 ensure consistency with scaling and direct sums (where the Gram matrix becomes block-diagonal and the usual determinant factors). Axiom 5 guarantees we remain inside the polynomial ring.

Hence any two functions satisfying the five axioms differ only by a constant factor.

### 7.3 Normalization – Removing the Ambiguity

Choose any fixed non-degenerate reference bilinear form \(T_0\) that can be characterized intrinsically (for example, the standard dot product on \(K^n\) when a preferred basis or inner-product structure is available, or the form induced by an endomorphism via a fixed volume form). Require
\[
d(T_0) = 1.
\]
This fixes the constant completely. The resulting function is then the **unique** object satisfying all the axioms.

### 7.4 The Exterior-Algebra Construction Satisfies All Axioms

The map \(\bigwedge^n \phi_T : L \to L^*\) (or the associated quadratic form on \(L\)) satisfies:
- Homogeneity of degree \(n\) (because each factor of \(\phi_T\) contributes degree 1).
- Vanishes exactly when \(\phi_T\) is singular (the induced map on top exterior power is zero precisely then).
- Transforms with weight exactly 2 (as shown in Section 6).
- Is multiplicative for direct sums (exterior algebra respects direct sums).
- Is polynomial of degree \(n\).

When a volume form is chosen to normalize, it yields a scalar density satisfying the normalization condition on reference forms. Therefore it *is* the unique object characterized by the axioms.

---

## 8. Special Cases and Geometric Applications

### 8.1 Symmetric Bilinear Forms / Quadratic Forms

When \(T\) is symmetric, the associated quadratic form \(Q(v) = T(v,v)\) has a well-studied **discriminant**, which is \(\det(M)\) considered as an element of the quotient group \(K^\times / (K^\times)^2\). This is a true invariant (independent of basis) and classifies quadratic forms up to isomorphism over many fields (together with the Hasse invariant, signature, etc.).

### 8.2 Skew-Symmetric Bilinear Forms (2-Forms)

For even dimension \(n = 2m\), the top exterior power
\[
\underbrace{T \wedge T \wedge \cdots \wedge T}_{m \text{ times}} \in \bigwedge^n V^*
\]
is a canonical \(n\)-form. Its coefficient with respect to a volume form is (a multiple of) the **Pfaffian**. We have \(\operatorname{Pf}(T)^2 = \pm \det(T)\). Again, a scalar requires a volume form.

### 8.3 Riemannian Metrics

A Riemannian metric \(g\) is a positive-definite symmetric (0,2) tensor. It canonically defines a volume form \(\mathrm{vol}_g\) by declaring that \(\mathrm{vol}_g(v_1,\dots,v_n) = 1\) for any \(g\)-orthonormal positively oriented basis. In local coordinates,
\[
\mathrm{vol}_g = \sqrt{|\det(g_{ij})|} \, dx^1 \wedge \cdots \wedge dx^n.
\]
Thus \(\sqrt{|\det g|}\) is recovered intrinsically as the normalizing factor. The raw determinant \(\det(g_{ij})\) appears in the transformation law of the density.

### 8.4 When the (0,2) Tensor Comes from an Endomorphism

If we have an endomorphism \(f\) and a fixed volume form \(\mathrm{vol}\), we can define \(T(v,w) = \mathrm{vol}(f(v),w)\). Then the determinant of \(T\) (in the density sense) recovers the ordinary \(\det(f)\) after normalization by \(\mathrm{vol}\).

---

## 9. Conclusion and Further Directions

- **Endomorphisms ((1,1) tensors)**: The determinant is a canonical scalar, uniquely characterized via the exterior algebra \(\bigwedge^n f : L \to L\).
- **Higher-order tensors**: The hyperdeterminant is the natural generalization (a polynomial detecting degeneracy of the multilinear map). It exists only for certain formats.
- **Pure covariant (0,2) tensors**: There is no canonical *scalar* determinant. The natural object is the induced map \(L \to L^*\) (or the associated weight-2 density). It is uniquely determined (up to scale) by the five natural axioms listed in Section 7, including the weight-2 transformation law.
- The exterior-algebra construction provides the explicit, functorial realization that satisfies all the axioms.

In practice:
- Use the classical determinant when you have an endomorphism or a matrix.
- Use the hyperdeterminant when working with higher-order tensors in algebraic geometry or tensor decomposition.
- Use the density-aware version (or \(\sqrt{|\det|}\)) when working with metrics or bilinear forms on manifolds.
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
