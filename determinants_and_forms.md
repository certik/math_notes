---
date: 2026-07-07
authors:
  - name: Brian Beckman
exports:
  - format: docx
  - format: pdf
  - format: tex
  - format: typst
bibliography:
  - references.bib
---

# Determinants and Differential Forms

## Introduction

The contribution of this note is a pedagogical bridge between abstract linear algebra and differential geometry. While other notes in this repository explore advanced matrix representations, tensor densities, and invariance equations (for instance, [determinant_of_tensors.md](https://github.com/certik/math_notes/blob/main/determinant_of_tensors.md) and [determinant_of_02_tensor.md](https://github.com/certik/math_notes/blob/main/determinant_of_02_tensor.md)), this document focuses specifically on the role of the determinant as a concrete computational building block for differential $k$-forms. The geometric and computational ideas presented here—specifically the definition of differential forms using determinants of submatrices—are covered in detail by Hubbard and Hubbard in *Vector Calculus, Linear Algebra, and Differential Forms: A Unified Approach* @hubbard2015vector.

In particular, we highlight:
* How the defining multilinear and alternating properties of the determinant are directly inherited by $k$-forms.
* A concrete computational view of how $k$-forms act on vectors by extracting submatrices (striking out rows and columns) and taking their determinants.
* The translation of algebraic sign-flipping under matrix column-swaps into the wedge product's anticommutativity.

---

## Axiomatic Characterization of the Determinant

The determinant of a matrix can be defined axiomatically without referring to the Leibniz formula or to cofactor expansion. Specifically, we note:

**Theorem.** *The determinant is the unique multilinear function of the columns (or rows) of an $n \times n$ matrix that is alternating and maps the identity matrix to $1$.*

For a deeper exploration of this multilinear/alternating viewpoint on the determinant, see the derivations and proofs in _Lean_ in the optional section of [determinant_over_C.md](https://github.com/certik/math_notes/blob/main/determinant_over_C.md#optional---the-multilinear-and-alternating-viewpoint). A similar classical characterization of the determinant as the unique multilinear, alternating function is also discussed in the context of bilinear form matrices in [determinant_of_02_tensor.md](https://github.com/certik/math_notes/blob/main/determinant_of_02_tensor.md). Additionally, see [determinant_of_tensors.md](https://github.com/certik/math_notes/blob/main/determinant_of_tensors.md#7-axiomatic-characterization-uniquely-deriving-the-determinant) for an axiomatic uniqueness derivation of the determinant based on the transformation laws of weight-2 densities.

### Defining Properties

Let $A = (v_1, v_2, \dots, v_n)$ be an $n \times n$ matrix where each $v_i \in \mathbb{K}^n$ represents a column vector over an arbitrary field $\mathbb{K}$ (which, in physics, is typically $\mathbb{R}$ or $\mathbb{C}$). The determinant function $\det: M_{n \times n}(\mathbb{K}) \to \mathbb{K}$ is characterized by three conditions:

1. **Multilinearity:** The function is linear with respect to each column individually when the other columns are held constant. For any scalar $c \in \mathbb{K}$ and vector $u \in \mathbb{K}^n$:
   $$
   \det(v_1, \dots, c v_i + u, \dots, v_n) = c \det(v_1, \dots, v_i, \dots, v_n) + \det(v_1, \dots, u, \dots, v_n)\,.
   $$
2. **Alternating Property:** The function yields $0$ if any two columns are identical:
   $$
   \det(v_1, \dots, w, \dots, w, \dots, v_n) = 0\,.
   $$
   A direct consequence of this property, combined with multilinearity, is that swapping any two columns flips the sign of the determinant:
   $$
   \det(\dots, v_i, \dots, v_j, \dots) = -\det(\dots, v_j, \dots, v_i, \dots)\,.
   $$
   *(Note: This skew-symmetric property is equivalent to the alternating property for any commutative ring $\mathbb{K}$ in which $2$ is not a zero-divisor—i.e., where $w = -w \implies w = 0$. In characteristic $2$, however, the alternating property is strictly stronger.)*
3. **Normalization:** The determinant of the identity matrix $I$ is $1$:
   $$
   \det(I) = 1\,.
   $$

### Lean Formalization

These defining properties—normalization, the alternating property, and multilinearity—for the Leibniz determinant $L$ are formalized directly in Lean 4 within [DeterminantHomomorphismFlow.lean](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/DeterminantHomomorphismFlow.lean) (specifically see theorems `L_one`, `L_eq_zero_of_row_eq`, and `L_updateRow_expand`).

### Proof of Uniqueness

To see why any function $f: M_{n \times n}(\mathbb{K}) \to \mathbb{K}$ satisfying these three properties must be the determinant, we expand any matrix $A$ in terms of the standard basis $\{e_1, \dots, e_n\}$ of $\mathbb{K}^n$.

Let $A = (v_1, \dots, v_n)$ where the $j$-th column is represented as $v_j = \sum_{i=1}^n A_{ij} e_i$. Using multilinearity in each column slot, we expand $f(A)$:
$$
f(v_1, \dots, v_n) = f\left(\sum_{i_1=1}^n A_{i_1 1} e_{i_1}, \dots, \sum_{i_n=1}^n A_{i_n n} e_{i_n}\right) = \sum_{i_1, \dots, i_n = 1}^n A_{i_1 1} \cdots A_{i_n n} f(e_{i_1}, \dots, e_{i_n})\,.
$$
By the alternating property, any term in the sum where two indices are equal (i.e., $i_a = i_b$ for $a \neq b$) must vanish because the input vectors to $f$ will be identical. Thus, the only non-zero terms in the sum are those where the indices $(i_1, \dots, i_n)$ form a permutation $\sigma \in S_n$ of the set $\{1, \dots, n\}$:
$$
f(v_1, \dots, v_n) = \sum_{\sigma \in S_n} A_{\sigma(1) 1} \cdots A_{\sigma(n) n} f(e_{\sigma(1)}, \dots, e_{\sigma(n)})\,.
$$
For any permutation $\sigma$, we can transform the standard basis tuple $(e_{\sigma(1)}, \dots, e_{\sigma(n)})$ back to the ordered identity basis $(e_1, \dots, e_n)$ by a sequence of swaps. Each swap changes the sign of $f$, meaning:
$$
f(e_{\sigma(1)}, \dots, e_{\sigma(n)}) = \operatorname{sgn}(\sigma) f(e_1, \dots, e_n)\,.
$$
By the normalization property, $f(e_1, \dots, e_n) = f(I) = 1$. Substituting this back into the sum yields:
$$
f(v_1, \dots, v_n) = \sum_{\sigma \in S_n} \operatorname{sgn}(\sigma) A_{\sigma(1) 1} \cdots A_{\sigma(n) n}\,,
$$
which is precisely the Leibniz formula for the determinant. Thus, $f(A) = \det(A)$ is uniquely determined. $\quad\blacksquare$ 

---

## Relationship to Differential Forms

_Differential forms_ in differential geometry are the natural generalization of this algebraic structure. Specifically, a differential $k$-form is an alternating multilinear map on a tangent space. We can relate the definition of the determinant directly to differential forms by looking at submatrices.

### Evaluation of $k$-Forms

Let $V = \mathbb{K}^n$. A basis for the space of differential $k$-forms (or alternating $k$-tensors) $\Lambda^k(V^*)$ consists of elements ($V^*$ is the dual space of $V$ containing _covectors_ for $V$'s vectors):
$$
dx_I = dx_{i_1} \wedge dx_{i_2} \wedge \dots \wedge dx_{i_k}\,,
$$
where $I = \{i_1, i_2, \dots, i_k\}$ is an index set satisfying $1 \le i_1 < i_2 < \dots < i_k \le n$.

Suppose we evaluate the basis $k$-form $dx_I$ on $k$ vectors $v_1, v_2, \dots, v_k \in \mathbb{K}^n$. We can arrange these vectors as columns to form an $n \times k$ matrix $A$:
$$
A = \begin{pmatrix} | & | & & | \\ v_1 & v_2 & \dots & v_k \\ | & | & & | \end{pmatrix}\,.
$$
Evaluating the form $dx_I$ yields:
$$
dx_I(v_1, v_2, \dots, v_k) = \det(A_I)\,,
$$
where $A_I$ is the $k \times k$ submatrix of $A$ obtained by **keeping only the rows indexed by $I$ and striking out the remaining $n - k$ rows**.

### Geometric Interpretation and Properties

By defining the action of $dx_I$ via this submatrix determinant, the algebraic properties of the determinant are directly inherited by the differential form:

* **Multilinearity:** The evaluation $dx_I(v_1, \dots, v_k)$ is linear in each input vector $v_j$.
* **Antisymmetry:** The alternating property of the determinant corresponds to the antisymmetry of the wedge product:
  $$
  dx_i \wedge dx_j = -dx_j \wedge dx_i\,.
  $$
  Swapping any two input vectors changes the sign of the evaluated $k$-form.
* **Pullbacks and the Jacobian:** In the context of manifolds (typically defined over $\mathbb{K}$ as $\mathbb{R}$ or $\mathbb{C}$), if we consider a differentiable map $g: \mathbb{K}^k \to \mathbb{K}^n$ parameterizing a $k$-dimensional submanifold, the **pullback** of the basis form $dx_I$ involves the Jacobian matrix of $g$ (an $n \times k$ matrix). The coefficients of the pulled-back form are the determinants of the $k \times k$ submatrices, where rows corresponding to the coordinates *not* in the index set $I$ are struck out.
* **Top-Dimensional Forms ($k = n$):** When $k = n$, no rows are struck out. The basis $n$-form is $dx_1 \wedge \dots \wedge dx_n$, and its evaluation on $n$ vectors in $\mathbb{K}^n$ is exactly the determinant of the full $n \times n$ matrix:
  $$
  (dx_1 \wedge \dots \wedge dx_n)(v_1, \dots, v_n) = \det(A)\,.
  $$
* **Zero-Dimensional Forms ($k = 0$):** For $0$-forms (scalar functions), all $n$ rows are struck out, leaving the empty $0 \times 0$ matrix. By convention, the determinant of a $0 \times 0$ matrix is $1$, so the form simply evaluates to the scalar function value itself.
* **Higher-Dimensional Forms ($k > n$):** On an $n$-dimensional space, all $k$-forms with $k > n$ vanish identically. Under the submatrix view, this is because we cannot select $k$ distinct rows out of $n$ rows; any selection would require repeating at least one row, resulting in a submatrix with duplicate rows whose determinant vanishes.

---

## Credits and Cross-References

The concepts presented in this note build directly upon discussions and derivations in the following notes:
* [determinant_over_C.md](https://github.com/certik/math_notes/blob/main/determinant_over_C.md) - For the multilinear and alternating viewpoint of the determinant.
* [determinant_of_02_tensor.md](https://github.com/certik/math_notes/blob/main/determinant_of_02_tensor.md) - For relative invariance of bilinear forms and the classical characterization of matrices.
* [determinant_of_tensors.md](https://github.com/certik/math_notes/blob/main/determinant_of_tensors.md) - For the axiomatic characterization of determinants under tensor density transformations.

Additionally, the concrete approach to differential forms via determinants of submatrices is covered in:
* Hubbard & Hubbard, *Vector Calculus, Linear Algebra, and Differential Forms: A Unified Approach* @hubbard2015vector.
