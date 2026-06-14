---
date: 2026-05-17
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

# What Is a Tensor?

## Overview

The word *tensor* admits at least two standard definitions. One is **algebraic**:
a tensor is an element of a tensor‑product of a vector space with itself and
its dual. The other is **geometric**: a tensor is a field on a manifold that
transforms in a prescribed way under changes of coordinates. Both definitions
are used in the literature, and both appear in our own notes —
[](./01-paper.md) uses the algebraic definition, while
[the differential-geometry chapter of the Theoretical Physics Reference](https://www.theoretical-physics.com/dev/math/differential-geometry.html) uses
the geometric one. This document explains the relationship between the two, and
then uses that relationship to clarify a number of related notions:
*vector*, *matrix*, *array*, *linear transformation*, and *pseudotensor*.

## The algebraic definition

Following [](./01-paper.md), a tensor is built from a finite‑dimensional real
vector space $V$ with dual $V^*$ by taking tensor products. The space of
$(r,s)$‑tensors is

$$
T^r_s(V) \;=\; \underbrace{V\otimes\cdots\otimes V}_{r}
\;\otimes\;\underbrace{V^*\otimes\cdots\otimes V^*}_{s},
$$

equivalently the space of multilinear maps
$\underbrace{V^*\times\cdots\times V^*}_{r}\times \underbrace{V\times\cdots\times V}_{s}\to\R$.

Choosing a basis $\{\vec e_i\}$ of $V$ and the dual basis $\{\tilde e^i\}$ of
$V^*$ (related by $\tilde e^i \cdot \vec e_j = \delta^i{}_j$), a rank‑$2$
tensor can be written

$$
\mathbf{A} \;=\; A^{ij}\,\vec e_i \otimes \vec e_j\,,
$$

a rank‑$3$ tensor

$$
\mathbf{A} \;=\; A^{ijk}\,\vec e_i \otimes \vec e_j \otimes \vec e_k\,,
$$

and a tensor of mixed type for instance

$$
\mathbf{A} \;=\; A^i{}_j\,\vec e_i \otimes \tilde e^j\,.
$$

Vectors $\mathbf{u} = u^i \vec e_i$ and forms $\mathbf{p} = p_i \tilde e^i$ are
the rank‑$1$ cases. In index notation the basis is dropped and the tensor is
represented by its components alone — $u^i$, $p_i$, $A^{ij}$, $A^{ijk}$,
$A^i{}_j$, $p_i u^i$, and so on. Upper and lower indices are just the
contravariant and covariant components of the same tensor.

This definition is **purely algebraic**: it needs only a vector space and its
dual, no notion of a manifold, no coordinates, no transformation law.

## The geometric (manifold) definition

[The differential-geometry chapter of the Theoretical Physics Reference](https://www.theoretical-physics.com/dev/math/differential-geometry.html) instead
defines tensors by their **transformation rule** under a change of coordinates
on a manifold. The construction proceeds inductively.

Start with a differentiable manifold $U$ and a coordinate change
$x'=x'(x)$, $x=x(x')$.

- A **scalar** $\phi(x)$ is a field such that $\phi'(x')=\phi(x)$.
- A **one‑form** $p_\alpha$ is a field that transforms the same as the
  gradient of a scalar:
  $$
  p'_\mu(x') \;=\; \frac{\partial x^\nu}{\partial x'^\mu}\,p_\nu(x).
  $$
- A **vector** $V^\alpha$ is a field that, contracted with a one‑form, gives a
  scalar ($\phi = V^\alpha p_\alpha$). This forces
  $$
  V'^\mu \;=\; \frac{\partial x'^\mu}{\partial x^\beta}\,V^\beta.
  $$
- **Higher‑rank tensors** are built up from these, with their transformation
  laws derived from the requirement that contracting with a vector or a form
  produces a lower‑rank tensor whose transformation law we already know.

Having defined scalar, vector, and tensor fields, one then chooses a basis
$\vec e_\alpha$ at each point (any non‑singular basis will do) and writes a
vector field as $\vec V = V^\alpha \vec e_\alpha$.

The contrast with the algebraic definition is that here the tensor is defined
*operationally* by how it transforms, on a space that already has the structure
of a manifold, whereas in the algebraic definition the tensor is defined
*constructively* via tensor products with no manifold in sight.

## A tensor can be defined without a manifold

The algebraic definition is self‑contained and needs no manifold. A tensor in
the algebraic sense is simply an element of $V^{\otimes r} \otimes (V^*)^{\otimes s}$,
i.e. of $T^r_s(V)$. A manifold is required only when one wants a **tensor
field** — a tensor at each point of some space.

In that case, at each point $p$ of a manifold $M$ one attaches a tangent space
$T_pM$ (a vector space), and a tensor field assigns to every $p$ an element of
$T^r_s(T_pM)$. The transformation‑law definition above is really just the
consistency condition for such an assignment under a change of coordinate
chart on $M$.

So the picture is:

- **Tensor (algebraic)** = element of $V \otimes \cdots \otimes V^*$ — needs
  only a vector space.
- **Tensor field (geometric)** = a tensor at every point of a manifold —
  needs the manifold so the tangent spaces exist and glue together smoothly.

The two definitions in our notes are not in conflict: [](./01-paper.md)
defines the algebraic object, and [the differential-geometry chapter of the Theoretical Physics Reference](https://www.theoretical-physics.com/dev/math/differential-geometry.html)
describes how that same object behaves when it varies smoothly over a manifold.

## Algebraic tensors have their own change of basis

Algebraic tensors come with change‑of‑basis transformations of their own,
independent of any manifold. Given a vector space $V$ with basis
$\{\vec e_i\}$ and a new basis $\{\vec e'_i\}$ related by an invertible
matrix $M$:

$$
\vec e'_i \;=\; M^j{}_i\,\vec e_j,
$$

components transform inversely:

- Vector: $V'^i = (M^{-1})^i{}_j\,V^j$,
- One‑form: $p'_i = M^j{}_i\,p_j$,
- Rank‑$2$: $A'^{ij} = (M^{-1})^i{}_k (M^{-1})^j{}_l\,A^{kl}$, and so on.

This is just linear algebra. The matrix $M$ is any invertible matrix; no
manifold or coordinate system is involved.

## $T_pM$ as the algebraic vector space at each point

At each point $p$ of a manifold $M$, the tangent space $T_pM$ is itself a
vector space (of dimension $\dim M$). Tensors *at* $p$ are exactly the
algebraic tensors over $T_pM$, built from $T_pM \otimes \cdots \otimes T_p^*M$
as above. A tensor *field* is a choice of such an algebraic tensor at every
point.

A coordinate chart $x^\mu$ on $M$ supplies a specific basis of $T_pM$, called
the **coordinate basis**:

$$
\vec e_\mu \;=\; \frac{\partial}{\partial x^\mu}\,, \qquad
\tilde e^\mu \;=\; dx^\mu\,.
$$

When the coordinates are changed $x \to x'(x)$, the chain rule gives the new
coordinate basis:

$$
\frac{\partial}{\partial x'^\mu} \;=\; \frac{\partial x^\nu}{\partial x'^\mu}\,
\frac{\partial}{\partial x^\nu}.
$$

So the change‑of‑basis matrix on $T_pM$ is forced to be the **Jacobian**:

$$
M^\nu{}_\mu \;=\; \frac{\partial x^\nu}{\partial x'^\mu}.
$$

Plugging this $M$ into the algebraic change‑of‑basis rule of the previous
section gives exactly the tensor transformation law of the manifold
definition:

$$
V'^\mu \;=\; \frac{\partial x'^\mu}{\partial x^\nu}\,V^\nu, \qquad
p'_\mu \;=\; \frac{\partial x^\nu}{\partial x'^\mu}\,p_\nu.
$$

The unifying picture is then:

|  | Vector space | Change‑of‑basis matrix |
|---|---|---|
| Algebraic tensor | abstract $V$ | any invertible $M$ |
| Tensor field on manifold | $T_pM$ at each $p$ | Jacobian $\partial x/\partial x'$ |

So the manifold's transformation law is the **same algebraic rule**,
specialized to the case where the basis comes from coordinates and the
change‑of‑basis matrix is forced to be a Jacobian.

Two useful consequences follow:

- On a manifold one is free to use a **non‑coordinate basis** (e.g. an
  orthonormal tetrad / frame field). Then the change‑of‑basis matrix at each
  point is no longer a Jacobian — it is an arbitrary invertible matrix that
  may vary from point to point. The tensor transformation law still holds; it
  is purely algebraic at each $p$, just no longer expressible via
  $\partial x'/\partial x$.
- Conversely, an algebraic change of basis can always be realized **locally**
  as a coordinate transformation (any invertible matrix is the Jacobian of
  some local diffeomorphism), but **not globally** — that is a manifold‑level
  constraint, not an algebraic one.

The manifold's job is therefore to (a) supply a vector space $T_pM$ at every
point and (b) glue them together smoothly, so that "change of coordinates"
becomes a global operation that simultaneously changes the basis on every
$T_pM$ via Jacobians.

## Building a tensor field from the algebraic definition

The previous section can be turned into a step‑by‑step recipe. Starting from
the algebraic tensor, what exactly does one add to get a tensor field whose
transformation laws and coordinate bases come out as consequences?

### Step 1 — Algebra at a point

This is already done: pick a finite‑dimensional real vector space $V$ with
dual $V^*$ and define

$$
T^r_s(V) \;=\;
\underbrace{V\otimes\cdots\otimes V}_{r}\;\otimes\;
\underbrace{V^*\otimes\cdots\otimes V^*}_{s}.
$$

A choice of basis $\{\vec e_i\}$ of $V$ induces a dual basis $\{\tilde e^i\}$
of $V^*$ and a tensor‑product basis on $T^r_s(V)$. Any change of basis
$\vec e'_i = M^j{}_i \vec e_j$ produces the algebraic transformation law on
components. Nothing manifold‑shaped is needed yet.

### Step 2 — A vector space at every point

To get a tensor *field*, one needs a vector space $V_p$ for every point $p$ of
some set $M$. The minimum extra structure required is:

1. A **smooth manifold** $M$ — an atlas of charts $x: U\to\R^n$.
2. A **smoothly varying family** $\{V_p\}_{p\in M}$ of $n$‑dimensional real
   vector spaces — i.e. a **rank‑$n$ vector bundle** $E\to M$.
3. A **smooth section** — an assignment $p\mapsto T(p)\in T^r_s(V_p)$ that is
   smooth in $p$.

This already gives "tensor field with values in some vector bundle $E$". But no
transformation law involving Jacobians yet — a change of chart on $M$ has
nothing to do with the basis of $V_p$.

### Step 3 — The canonical choice $V_p = T_pM$

The step that couples manifold coordinates to fiber bases is the choice of
$V_p$ to be the tangent space at $p$. The most transparent definition for our
purposes is:

> $T_pM$ is the set of equivalence classes $[(x, v)]$ where $x$ is a chart at
> $p$ and $v\in\R^n$, modulo
> $$
> (x, v) \sim (x', v') \iff v'^\mu = \left.\frac{\partial x'^\mu}{\partial x^\nu}\right|_p v^\nu.
> $$

That is: $T_pM$ is defined by gluing copies of $\R^n$ via Jacobians. Each
chart $x$ then supplies a canonical basis of $T_pM$ — namely the equivalence
class of the standard basis of $\R^n$ — which one writes

$$
\vec e_\mu \;=\; \frac{\partial}{\partial x^\mu}.
$$

By construction, two charts $x,x'$ give bases related by the Jacobian:

$$
\frac{\partial}{\partial x'^\mu} \;=\; \frac{\partial x^\nu}{\partial x'^\mu}\,
\frac{\partial}{\partial x^\nu}.
$$

This is the only ingredient that links "change of coordinates on $M$" to
"change of basis in $V_p$".

### Step 4 — Assemble the tensor bundle

From the tangent bundle $TM = \bigsqcup_p T_pM$ and cotangent bundle $T^*M$,
form

$$
T^r_s M \;=\;
\underbrace{TM\otimes\cdots\otimes TM}_{r}\otimes
\underbrace{T^*M\otimes\cdots\otimes T^*M}_{s} \;\longrightarrow\; M,
$$

where the algebra of Step 1 is applied fiber by fiber. A **tensor field** is a
smooth section of $T^r_s M$.

### Step 5 — Coordinate basis and components

A chart $x$ supplies the basis $\{\partial/\partial x^\mu\}$ on each fiber of
$TM$ and dually $\{dx^\mu\}$ on $T^*M$, hence a tensor‑product basis on each
fiber of $T^r_s M$. Components $T^{\mu_1\dots\mu_r}{}_{\nu_1\dots\nu_s}(p)$
are just the components of the algebraic tensor $T(p)$ in this basis.

### Step 6 — The transformation law falls out

Now everything is forced. Under a chart change $x \to x'$:

- *At the manifold level*: the coordinates change.
- *At the fiber level* (Step 3): the basis of each $T_pM$ changes by the
  Jacobian $M^\nu{}_\mu = \partial x^\nu/\partial x'^\mu$.
- *At the algebraic level* (Step 1): the components transform by the algebraic
  change‑of‑basis rule with this specific $M$:

$$
T'^{\mu_1\dots\mu_r}{}_{\nu_1\dots\nu_s}
\;=\; \frac{\partial x'^{\mu_1}}{\partial x^{\alpha_1}}\cdots
      \frac{\partial x^{\beta_1}}{\partial x'^{\nu_1}}\cdots\;
      T^{\alpha_1\dots\alpha_r}{}_{\beta_1\dots\beta_s}.
$$

This is exactly the manifold transformation law: no new content, just Step 1
applied at every $p$ with $M$ chosen by Step 3.

### What each ingredient contributes

| Ingredient | What it adds |
|---|---|
| Vector space $V$, dual $V^*$, tensor products | The algebraic tensor and its change‑of‑basis law (any invertible $M$) |
| Smooth manifold $M$ | A space of "points" with a notion of smoothness |
| Vector bundle structure | A vector space at every point, varying smoothly |
| Choice $V_p = T_pM$ | Couples chart changes on $M$ to basis changes on $V_p$ via Jacobians |
| Smooth section | The tensor field itself |

### Sanity check

If Step 3 were replaced by "$V_p$ = some fixed vector space $W$ independent of
$TM$" (a trivial $W$‑bundle), one would still get tensor fields — but a
coordinate change on $M$ would leave the fiber basis untouched. The
Jacobian transformation law is **not** a feature of tensor fields in general;
it is a feature of fields valued specifically in tensor powers of $TM$. This
is why "tensors on a manifold" almost always means $T^r_s M$, and why the
Jacobian shows up.

## Tensors, vectors, matrices, and arrays

It is useful to separate two **levels** in the algebraic setting: the
abstract object (basis‑free) and its concrete representation (basis‑dependent).

| Level | What lives there |
|---|---|
| **Abstract** (basis‑free) | scalar, vector, form, tensor |
| **Concrete** (basis‑dependent) | number, 1D array, 2D array (matrix), $k$D array |

Choosing a basis is what maps one to the other:

$$
\text{abstract tensor} \;\xrightarrow{\text{pick a basis}}\; \text{array of components}.
$$

Fix a finite‑dimensional vector space $V$ with basis $\{\vec e_i\}$. Tensors
form a tower indexed by rank:

| Rank | Abstract object | Lives in | Array shape (in a basis) |
|---|---|---|---|
| $0$ | scalar | $\R$ | single number |
| $1$ (contra) | vector | $V$ | 1D array $v^i$ |
| $1$ (co) | form / covector | $V^*$ | 1D array $p_i$ |
| $2$ | rank‑2 tensor | $V\otimes V$, $V\otimes V^*$, $V^*\otimes V^*$ | 2D array (matrix) $A^{ij}$, $A^i{}_j$, $A_{ij}$ |
| $k$ | rank‑$k$ tensor | $k$‑fold tensor product | $k$D array |

So:

- A **vector** is a rank‑$1$ tensor. Its array of components is a 1D array.
- A **tensor** is the general object at any rank.
- A **matrix** (in the strict sense) is a 2D array of numbers, i.e. the
  components of a rank‑$2$ tensor (or of a linear map) in a chosen basis.
- An **array** is the generic name for the multi‑dimensional grid of
  components at any rank.

### Where "matrix" gets ambiguous

The word *matrix* is used for two different things:

1. **A 2D array of numbers** — purely concrete data, $A_{ij}$.
2. **A linear map** $f: V\to V$ — an abstract object, which is in fact a
   $(1,1)$‑tensor $f\in V\otimes V^*$ with components $f^i{}_j$.

These two coincide only after a basis is chosen: the "matrix of a linear map
in a basis" is then the 2D array of its components.

### Shape vs. type

The **shape** of an array tells you the rank, but not the type $(r,s)$. A 2D
array could represent any of:

- a $(2,0)$ tensor in $V\otimes V$: components $A^{ij}$ — transforms with two
  Jacobians;
- a $(1,1)$ tensor in $V\otimes V^*$: components $A^i{}_j$ — one Jacobian and
  one inverse (the "linear map" case);
- a $(0,2)$ tensor in $V^*\otimes V^*$: components $A_{ij}$ — two inverse
  Jacobians (the metric is of this type).

The array $\begin{pmatrix} 1 & 2 \\ 3 & 4 \end{pmatrix}$ alone does not know
which of these it is. The **upper/lower index pattern** carries that extra
information. This is why index notation distinguishes $A^{ij}$, $A^i{}_j$,
$A_{ij}$ — all three would just look like the same matrix in a programming
language.

### A note on the "ML tensor"

In machine‑learning libraries (`numpy`, `pytorch`, `tensorflow`), the word
*tensor* simply means a multi‑dimensional array — only the concrete side of
the table above. There is no notion of basis, of upper vs. lower indices, or
of transformation law. A "rank‑$3$ tensor" in PyTorch is just a 3D array of
numbers; it is not in general a rank‑$3$ tensor in the algebraic sense unless
one additionally declares which axes are contravariant and which are
covariant, and how they transform under change of basis.

## Matrix as a linear transformation: which tensor exactly?

The reading of a matrix as a *linear transformation* identifies it with one
specific tensor type: the $(1,1)$ tensor.

For a finite‑dimensional vector space $V$ there is a canonical isomorphism

$$
V \otimes V^* \;\;\xrightarrow{\sim}\;\; \mathrm{Hom}(V, V)
$$

$$
\vec v \otimes \tilde p \;\;\longmapsto\;\;
\big(\,\vec u \mapsto \tilde p(\vec u)\,\vec v\,\big).
$$

So a $(1,1)$‑tensor *is* a linear map $V\to V$, and vice versa. No basis is
needed for the correspondence.

### In components: matrix multiplication is tensor contraction

Pick a basis $\vec e_i$ with dual $\tilde e^j$. A $(1,1)$‑tensor is

$$
\mathbf{A} \;=\; A^i{}_j\,\vec e_i \otimes \tilde e^j.
$$

Apply it to a vector $\vec u = u^k \vec e_k$:

$$
\mathbf{A}(\vec u) \;=\; A^i{}_j\,(\tilde e^j \cdot \vec u)\,\vec e_i
\;=\; A^i{}_j\,u^j\,\vec e_i.
$$

So the $i$‑th component of $\mathbf{A}\vec u$ is

$$
(\mathbf{A}\vec u)^i \;=\; A^i{}_j\,u^j,
$$

which is exactly matrix–vector multiplication. Matrix multiplication of two
linear maps $\mathbf{A}\mathbf{B}$ is the same statement:

$$
(\mathbf{AB})^i{}_k \;=\; A^i{}_j\,B^j{}_k,
$$

a tensor **contraction** over the middle index.

### Why $(1,1)$ and not $(2,0)$ or $(0,2)$?

A 2D array $A_{ij}$, $A^{ij}$, or $A^i{}_j$ all "look like" matrices, but they
are different tensors, with different actions and different transformation
laws:

| Type | Lives in | Acts as | Transforms as |
|---|---|---|---|
| $(2,0)$ : $A^{ij}$ | $V \otimes V$ | bilinear map $V^*\times V^* \to \R$ | $A' = M\,A\,M^T$ |
| $(0,2)$ : $A_{ij}$ | $V^* \otimes V^*$ | bilinear map $V\times V \to \R$ (e.g. metric) | $A' = M^{-T}\,A\,M^{-1}$ |
| $(1,1)$ : $A^i{}_j$ | $V \otimes V^*$ | linear map $V \to V$ | $A' = M\,A\,M^{-1}$ |

Here $M^i{}_j = \partial x'^i / \partial x^j$ is the change‑of‑basis matrix.
The "linear map" identification corresponds to the **$(1,1)$ type**, and under
change of basis it transforms by the familiar **similarity transformation**
$A' = MAM^{-1}$ — one Jacobian and one inverse, in agreement with one upper
and one lower index.

By contrast, a metric or a bilinear form is $(0,2)$: it eats two vectors and
gives a number. The transposes and inverses in its transformation are
different from a similarity. A metric is therefore not a linear map $V\to V$,
even though both can be written as $n\times n$ arrays.

### Linear maps between different spaces

A linear map $f: V\to W$ corresponds to an element of $W\otimes V^*$. In
coordinates with bases $\{\vec e_i\}$ of $V$ and $\{\vec f_a\}$ of $W$:

$$
f \;=\; f^a{}_i\,\vec f_a \otimes \tilde e^i, \qquad
(f\vec u)^a \;=\; f^a{}_i\,u^i.
$$

So a "rectangular matrix" representing $V\to W$ is a $(1,1)$ tensor with one
$W$‑type upper index and one $V$‑type lower index.

## Linear algebra handles several tensor types

Given that the $(1,1)$ reading is so canonical, one might ask whether linear
algebra is simply "tensor calculus on $(1,1)$ tensors". It is not: linear
algebra actually handles **several** tensor types, but it usually does not
distinguish them, because the standard inner product on $\R^n$ silently
converts between them.

### What tensor types appear in linear algebra

| Linear algebra object | Tensor type | Lives in |
|---|---|---|
| Column vector $\vec v$ | $(1,0)$ | $V$ |
| Row vector $\vec p^T$ | $(0,1)$ | $V^*$ |
| Matrix as linear map $A\vec x = \vec b$ | $(1,1)$ | $V \otimes V^*$ |
| Matrix as bilinear form $\vec x^T A \vec y$, quadratic form $\vec x^T A \vec x$, inner product, Gram matrix | $(0,2)$ | $V^* \otimes V^*$ |
| Outer product $\vec u\,\vec v^T$ as a low‑rank operator | varies — usually $(1,1)$, sometimes $(2,0)$ | depends |
| Matrix as "covariance / inverse metric" | $(2,0)$ | $V \otimes V$ |

So a "matrix" in linear algebra is sometimes a $(1,1)$, sometimes a $(0,2)$,
sometimes a $(2,0)$. The same 2D array of numbers stands in for very different
geometric objects depending on context.

### Why linear algebra can get away with conflating them

Two collapses happen in standard linear algebra:

1. **An implicit inner product.** $\R^n$ comes with the standard dot product
   $\langle \vec u, \vec v\rangle = \sum u^i v^i$. An inner product is a
   $(0,2)$ tensor $g_{ij}$ and gives a canonical isomorphism $V\cong V^*$ via
   $v^i \mapsto g_{ij} v^j$. So vectors and covectors stop being
   distinguishable: "row vector $=$ transpose of column vector".

2. **An orthonormal Cartesian basis.** In such a basis $g_{ij}=\delta_{ij}$,
   so raising and lowering indices does nothing to the numerical components.
   All three of $A^{ij}$, $A^i{}_j$, $A_{ij}$ look like the *same* array of
   numbers. The type information has been thrown away.

That is why linear algebra can pretend "matrix" is a single concept: with
$g = I$ in an orthonormal basis, $(2,0)$, $(1,1)$, and $(0,2)$ tensors all
share the same matrix representation.

### Which operations care about the type?

These are **truly $(1,1)$‑tensorial** (basis‑invariant, equivariant under the
similarity transformation):

- **Trace** $\mathrm{tr}(A) = A^i{}_i$ — contraction of upper with lower
  index, requires $(1,1)$.
- **Determinant** of a linear map — invariant under $A\mapsto MAM^{-1}$.
- **Eigenvalues** and characteristic polynomial — same.
- **Matrix powers** $A^n$, exponential $e^A$, functional calculus —
  composition of linear maps.

These are **$(0,2)$‑tensorial** (transform as bilinear forms,
$A\mapsto M^{-T}AM^{-1}$):

- **Quadratic forms** $\vec x^T A \vec x$.
- **Inner products / Gram matrices**.
- **Definiteness** (positive / negative definite) — only meaningful for
  $(0,2)$ tensors.
- **Congruence**, **Sylvester's law of inertia**.

These are **basis‑dependent or not tensorial at all** without extra structure:

- **Transpose** $A\mapsto A^T$. Not a tensor operation in the abstract sense
  — there is no natural map $V\otimes V^*\to V\otimes V^*$ that does this. It
  only makes sense after the inner product has been used to identify $V$ with
  $V^*$.
- **Symmetry of a matrix** $A=A^T$. Meaningful only when $A$ is viewed as
  $(0,2)$ or $(2,0)$; ill‑defined as a property of a $(1,1)$‑tensor (a linear
  map).
- **Orthogonal matrices** are defined by preserving the inner product, so they
  presuppose a $(0,2)$ metric.

Reading a linear algebra theorem, one can almost always tell which tensor
type it secretly assumes by which of $\{\text{trace, determinant,
eigenvalues}\}$ vs $\{\text{symmetry, quadratic form, positive definite}\}$
vs $\{\text{orthogonal, transpose}\}$ it uses.

### Beyond rank 2

Linear algebra essentially stops at rank $2$. Once one needs rank‑$3$ or
higher objects (e.g. the Riemann curvature tensor $R^\mu{}_{\nu\alpha\beta}$,
the structure constants of a Lie algebra $c^k{}_{ij}$, the elasticity tensor
$C_{ijkl}$, the Levi‑Civita symbol $\varepsilon_{ijk}$), there is no good
"matrix" language for them, and one must use tensor / index notation. That is
the regime where the algebraic tensor framework becomes essential and linear
algebra runs out.

### Refining the picture of "matrix"

It is now precise to say that **matrix** admits two definitions:

- The **concrete** definition: a 2D array of numbers, with no geometric
  meaning.
- The **abstract** definition: the components of a rank‑$2$ tensor in a basis,
  which in linear algebra is silently allowed to be any of $(1,1)$, $(2,0)$,
  or $(0,2)$.

The collapse "all three look identical" requires two ingredients:

1. An inner product (a $(0,2)$ metric $g$) to identify $V\cong V^*$ — this is
   what lets one raise / lower indices at all.
2. An orthonormal basis so that $g_{ij}=\delta_{ij}$ — this is what makes the
   raising / lowering numerically a no‑op.

Without orthonormality, even with an inner product, the components of
$A^{ij}$, $A^i{}_j$, $A_{ij}$ differ; raising an index multiplies by $g^{ij}
\neq \delta^{ij}$. And the $(1,1)$ "linear map" reading is the only one that
needs no metric at all — it is self‑contained via the canonical isomorphism
$V\otimes V^* \cong \mathrm{Hom}(V,V)$. Only the $(2,0)$ and $(0,2)$ readings
need the metric to be related to it.

## "Vector" also has multiple meanings

The same story plays out, one rank lower, for the word *vector*.

### Senses of "vector"

| Sense | What it is | Where |
|---|---|---|
| **1D array** | a tuple of numbers $(v_1, \dots, v_n)$, no geometric meaning | programming, numerical methods, `numpy.ndarray` |
| **Element of a vector space** | any object that can be added and scaled: functions, polynomials, matrices themselves, sequences, $L^2$ functions, … | abstract linear algebra, functional analysis |
| **Rank‑$1$ contravariant tensor** $(1,0)$ | element of $V$; "column vector" | tensor algebra, physics |
| **One‑form / covector** $(0,1)$ | element of $V^*$; "row vector"; also called *covariant vector* in older physics | tensor algebra, differential geometry |
| **Tangent vector on a manifold** | element of $T_pM$ — the $(1,0)$ tensor at a point | differential geometry |
| **Geometric arrow** | "magnitude and direction in space" | elementary physics, intuition |
| **Pseudovector / axial vector** | not actually a vector — transforms like one under rotations but flips sign under reflections; e.g. $\vec\omega$, $\vec B$, $\vec L = \vec r\times\vec p$ | 3D physics |

### The same conflation as for "matrix"

In standard Euclidean $\R^n$ with the standard dot product and orthonormal
Cartesian basis, the components of the $(1,0)$ vector $v^i$ and of the
$(0,1)$ form $v_i$ are numerically identical: $v_i = \delta_{ij} v^j = v^i$.
So:

- *Vector* and *covector* collapse into one "1D array of numbers".
- *Column vector* and *row vector* become just transposes of each other.

The collapse requires both (i) an inner product to identify $V\cong V^*$ and
(ii) an orthonormal basis to make the identification numerically trivial —
exactly the same story as for matrices. In a non‑orthogonal basis, even with
the standard inner product, $v^i \neq v_i$ as numbers; that is why
differential geometry insists on the distinction.

### What gives away which sense is meant

- *"Vector space of polynomials of degree $\leq 5$"* — sense 2 (abstract).
- *"The gradient $\nabla f$ is a vector"* — it is really a $(0,1)$ form, not a
  $(1,0)$ vector; the conflation is a metric‑induced abuse.
- *"Velocity $\vec v$ is a vector"* — $(1,0)$ tensor, genuinely contravariant.
- *"Angular velocity $\vec\omega$ is a vector"* — pseudovector; really an
  antisymmetric $(0,2)$ tensor in disguise (in 3D, via the Hodge star).
- *"Tangent vector to a curve"* — element of $T_pM$, i.e. $(1,0)$ at a point on
  a manifold.
- *`v = np.array([1,2,3])`* — 1D array; no geometric content unless one is
  supplied.

### Parallel with "matrix"

| | Concrete | Abstract algebraic | Tensor types conflated by std. inner product + orthonormal basis |
|---|---|---|---|
| **Vector** | 1D array | element of a vector space | $(1,0)$ and $(0,1)$ |
| **Matrix** | 2D array | linear map / bilinear form | $(1,1)$, $(2,0)$, $(0,2)$ |

So the situation is structurally identical, one rank lower.

## Pseudotensors at every rank and in every dimension

Pseudovectors are not a quirk of 3D vectors — they are a special case of
**pseudotensors**, which exist at every rank and in every dimension. The
"pseudo" prefix is a parity twist that is orthogonal to rank and dimension; a
"matrix" can be a pseudotensor just as well as a vector can.

### Definition

A **pseudotensor** transforms like a tensor under orientation‑preserving
changes of basis but picks up an extra sign $\operatorname{sgn}(\det M)$ under
orientation‑reversing ones:

$$
T'^{i_1\dots}{}_{j_1\dots}
\;=\; \operatorname{sgn}(\det M)\,
M^{i_1}{}_{k_1}\cdots (M^{-1})^{l_1}{}_{j_1}\cdots\;
T^{k_1\dots}{}_{l_1\dots}.
$$

The $\operatorname{sgn}(\det M)$ factor is the only difference from a genuine
tensor. There are therefore parallel hierarchies:

| Rank | Tensor | Pseudotensor |
|---|---|---|
| $0$ | scalar | pseudoscalar |
| $1$ | vector / covector | pseudovector / pseudocovector |
| $2$ | matrix (the various types) | **pseudomatrix** (the same types, twisted) |
| $3$ | rank‑$3$ tensor | rank‑$3$ pseudotensor |
| $n$ | rank‑$n$ tensor | rank‑$n$ pseudotensor |

So a "matrix" can absolutely be a pseudotensor, and this is
dimension‑independent.

### 2D examples

- **2D Levi‑Civita symbol** $\varepsilon_{ij}$ with
  $\varepsilon_{12} = -\varepsilon_{21} = 1$. This $2\times 2$ array is
  literally a **pseudomatrix** — an antisymmetric rank‑$2$ pseudotensor of
  type $(0,2)$.
- **2D "cross product"** $u\times v \equiv \varepsilon_{ij} u^i v^j$ is a
  **pseudoscalar** (signed area). Under a reflection of the $xy$‑plane the
  geometric area is unchanged but its *sign* flips, which is exactly the
  pseudoscalar behavior.
- **2D curl** $(\partial_x v_y - \partial_y v_x) = \varepsilon^{ij}\partial_i v_j$
  is a pseudoscalar.
- The outer product of a regular vector with a pseudovector gives a
  pseudomatrix.

### 3D: how pseudovectors are "really" pseudomatrices

This makes precise a remark in [](./01-paper.md). In 3D, an antisymmetric
rank‑$2$ tensor $A_{ij}$ has 3 independent components, and one can identify
them with a vector via

$$
A_{ij} \;=\; \varepsilon_{ijk}\,B^k.
$$

Because $\varepsilon_{ijk}$ is a pseudotensor:

- If $A_{ij}$ is a genuine (antisymmetric) tensor, then $B^k$ is a
  **pseudovector** (one $\varepsilon$ flips parity once).
- If $A_{ij}$ is itself a pseudotensor, then $B^k$ is a **genuine vector**
  (two pseudos cancel).

This is why the magnetic field $\vec B$ and the angular velocity $\vec\omega$
are pseudovectors: they are really antisymmetric rank‑$2$ tensors in disguise,
and the disguise is performed by $\varepsilon_{ijk}$.

### The deeper unification

A pseudotensor is just a tensor on an **unoriented** manifold, or equivalently
a section of the bundle

$$
T^r_s M \;\otimes\; \mathrm{or}(M),
$$

where $\mathrm{or}(M)$ is the orientation line bundle (a $\mathbb{Z}_2$‑twist).
Choosing an orientation trivializes this bundle and lets one treat
pseudotensors as ordinary tensors — until the orientation is changed, at
which point the sign flip becomes visible.

Equivalently, pseudotensors are tensor densities of weight $0$ with a sign
character: they differ from ordinary tensors only in carrying the sign
representation of $GL(n,\R) \to \{\pm 1\}$ given by $\operatorname{sgn}(\det)$.

## Tensor densities and the determinant of $A_{ij}$

The same language also gives the clean way to say what the determinant of a
covariant rank-$2$ tensor means. The important point is that $\det(A_{ij})$ is
not naturally a scalar. It is naturally a **density-like object**.

### Relative invariants

Let $J\in GL(n,\R)$ be a change-of-basis matrix, and let $J*A$ denote the
induced action on whatever object $A$ is. A scalar-valued expression $F(A)$ is a
**relative invariant** if

$$
F(J*A)=\chi(J)F(A)
$$

for some factor $\chi(J)$ depending only on $J$, not on $A$. If $F$ is not
identically zero, then $\chi$ is forced to be a group homomorphism. Indeed, for
some $A$ with $F(A)\ne0$,

$$
F((J K)*A)=\chi(JK)F(A),
$$

while associativity of the group action gives

$$
F(J*(K*A))=\chi(J)F(K*A)=\chi(J)\chi(K)F(A).
$$

Thus

$$
\chi(JK)=\chi(J)\chi(K).
$$

The determinant notes show the corresponding principle for matrix
homomorphisms: a multiplicative character of $GL(n)$ factors through the
determinant. Over $\R$, with the usual regularity assumptions used for
Cauchy-type equations (continuity, or merely measurability), the characters
are

$$
\chi(J)=|\det J|^{-w}\big(\operatorname{sgn}\det J\big)^k,
\qquad k\in\mathbb Z,
$$

where only the parity of $k$ matters. This is the tensor-density
classification. For objects with free tensor indices, the table records the
extra density factor multiplying the ordinary tensor index transformation.

| Object | Ordinary tensor type | Extra factor $\chi(J)$ | $(w,k)$ |
|---|---:|---:|---:|
| scalar $s$ | $(0,0)$ | $1$ | $(0,0)$ |
| pseudoscalar $s$ | $(0,0)$ | $\operatorname{sgn}(\det J)$ | $(0,1)$ |
| scalar density $\rho$ | $(0,0)$ | $\lvert\det J\rvert^{-1}$ | $(1,0)$ |
| inverse scalar density $\rho^{-1}$ | $(0,0)$ | $\lvert\det J\rvert$ | $(-1,0)$ |
| top-form component $\omega$ in $\omega\,\Omega$ | coefficient | $(\det J)^{-1}$ | $(1,1)$ |
| coordinate volume basis $\Omega=dx^1\wedge\cdots\wedge dx^n$ | basis | $\det J$ | $(-1,1)$ |
| metric density $\sqrt{\lvert\det g\rvert}$ | $(0,0)$ | $\lvert\det J\rvert^{-1}$ | $(1,0)$ |
| inverse metric density $1/\sqrt{\lvert\det g\rvert}$ | $(0,0)$ | $\lvert\det J\rvert$ | $(-1,0)$ |
| Lagrangian density $\sqrt{\lvert\det g\rvert}\,\mathcal L$ for scalar $\mathcal L$ | $(0,0)$ | $\lvert\det J\rvert^{-1}$ | $(1,0)$ |
| coordinate Dirac delta $\delta^{(n)}(x)$ | distribution coefficient | $\lvert\det J\rvert^{-1}$ | $(1,0)$ |
| determinant of $A_{ij}$ | $(0,0)$ | $\lvert\det J\rvert^{-2}$ | $(2,0)$ |
| determinant of $A^{ij}$ | $(0,0)$ | $\lvert\det J\rvert^2$ | $(-2,0)$ |
| determinant of $A^i{}_j$ | $(0,0)$ | $1$ | $(0,0)$ |
| lower Levi-Civita symbol $\varepsilon_{i_1\cdots i_n}$ | $(0,n)$ | $\det J$ | $(-1,1)$ |
| upper Levi-Civita symbol $\varepsilon^{i_1\cdots i_n}$ | $(n,0)$ | $(\det J)^{-1}$ | $(1,1)$ |
| covariant Levi-Civita tensor $E_{i_1\cdots i_n}=\sqrt{\lvert g\rvert}\,\varepsilon_{i_1\cdots i_n}$ | $(0,n)$ | $\operatorname{sgn}(\det J)$ | $(0,1)$ |
| contravariant Levi-Civita tensor $E^{i_1\cdots i_n}=\varepsilon^{i_1\cdots i_n}/\sqrt{\lvert g\rvert}$ | $(n,0)$ | $\operatorname{sgn}(\det J)$ | $(0,1)$ |
| densitized vector $\sqrt{\lvert g\rvert}\,V^i$ | $(1,0)$ | $\lvert\det J\rvert^{-1}$ | $(1,0)$ |
| densitized inverse metric $\sqrt{\lvert g\rvert}\,g^{ij}$ | $(2,0)$ | $\lvert\det J\rvert^{-1}$ | $(1,0)$ |

Here $\lvert g\rvert$ abbreviates $\lvert\det g_{ij}\rvert$. For example, the
lower Levi-Civita symbol row means

$$
\varepsilon'_{i_1\cdots i_n}
=(\det J)(J^{-1})^{a_1}{}_{i_1}\cdots(J^{-1})^{a_n}{}_{i_n}
\varepsilon_{a_1\cdots a_n},
$$

so it is not an ordinary $(0,n)$ tensor; it is a $(0,n)$ tensor density with
$(w,k)=(-1,1)$. Similarly, the upper Levi-Civita symbol has $(w,k)=(1,1)$.

So the determinant of a linear map $A^i{}_j$ is a true scalar, but the
determinant of a covariant tensor $A_{ij}$ is a weight-$2$, even-parity scalar
density.

### Basis-independent definition

Let $V$ be $n$-dimensional and let

$$
A\in V^*\otimes V^*
$$

be a covariant rank-$2$ tensor, i.e. a bilinear form. It defines a linear map

$$
A^\flat:V\to V^*,
\qquad
(A^\flat v)(u)=A(v,u).
$$

For a genuine linear map $T:V\to V$, the determinant is a scalar because
$\Lambda^n T$ maps the one-dimensional line $\Lambda^n V$ to itself. Here the
map is instead $A^\flat:V\to V^*$, so its top exterior power maps one
determinant line to a different determinant line:

$$
\Lambda^n A^\flat:\Lambda^n V\to \Lambda^n V^*.
$$

This is the basis-independent determinant of $A_{ij}$:

$$
\boxed{\;
\operatorname{Det}(A):=\Lambda^n A^\flat
\in \operatorname{Hom}(\Lambda^n V,\Lambda^n V^*)
\cong (\Lambda^n V^*)^{\otimes 2}.
\;}
$$

Equivalently,

$$
\big[\operatorname{Det}(A)(v_1\wedge\cdots\wedge v_n)\big]
(u_1,\dots,u_n)
=
\det\!\big(A(v_i,u_j)\big).
$$

This formula uses an ordinary determinant only on the final $n\times n$ array
of numbers obtained after feeding $A$ actual vectors. The output
$\operatorname{Det}(A)$ itself is coordinate-free.

In a basis $e_i$ with dual coframe $\theta^i$, let

$$
\Omega=\theta^1\wedge\cdots\wedge\theta^n.
$$

Then

$$
\operatorname{Det}(A)=\det(A_{ij})\,\Omega\otimes\Omega.
$$

Thus the component number $\det(A_{ij})$ depends on the chosen co-volume
$\Omega$, but the product $\det(A_{ij})\,\Omega\otimes\Omega$ does not. Under
the component transformation

$$
A'=J^{-T}AJ^{-1},
\qquad
\Omega'=(\det J)\Omega,
$$

we get

$$
\det(A'_{ij})
=\det(J^{-T})\det(A_{ij})\det(J^{-1})
=(\det J)^{-2}\det(A_{ij})
=|\det J|^{-2}\det(A_{ij}),
$$

and therefore

$$
\det(A'_{ij})\,\Omega'\otimes\Omega'
=\det(A_{ij})\,\Omega\otimes\Omega.
$$

This is the precise meaning of the shorthand $\det A_{ij}$: it is the
coordinate component of the invariant object $\operatorname{Det}(A)$, and that
component is a tensor density with $(w,k)=(2,0)$.

The component formula is the usual two-antisymmetrizer expression

$$
\det(A_{ij})
= {1\over n!}\,
\varepsilon^{i_1\cdots i_n}\varepsilon^{j_1\cdots j_n}
A_{i_1j_1}\cdots A_{i_nj_n}.
$$

In this sense this is the $p=q=1$ case: one alternating symbol antisymmetrizes
the first index family, and one alternating symbol antisymmetrizes the second
index family. It should not be confused with a tensor of type $(1,1)$; a
$(1,1)$ tensor has the similarity law $A'=JAJ^{-1}$, and its determinant is an
ordinary scalar.

If one wants an actual scalar from $A_{ij}$, one must choose an additional
volume form $\Omega_0$ and write

$$
\operatorname{Det}(A)=d_{\Omega_0}\,\Omega_0\otimes\Omega_0.
$$

The number $d_{\Omega_0}$ is the determinant **relative to that chosen volume
form**. Without such a choice, the invariant object is
$\operatorname{Det}(A)\in(\Lambda^n V^*)^{\otimes2}$, not a scalar.

For a nondegenerate metric $g_{ij}$ this explains the familiar expression
$\sqrt{|\det g_{ij}|}$: it is a weight-$1$ density, so
$\sqrt{|\det g_{ij}|}\,d^n x$ is coordinate-invariant.

## Summary

Pulling all of the above together:

- A **tensor** can be defined two ways. The **algebraic** definition (as in
  [](./01-paper.md)) takes a tensor to be an element of
  $V^{\otimes r}\otimes(V^*)^{\otimes s}$; it needs only a vector space and
  carries change‑of‑basis transformations with any invertible matrix $M$. The
  **geometric** (manifold) definition (as in [the differential-geometry chapter of the Theoretical Physics Reference](https://www.theoretical-physics.com/dev/math/differential-geometry.html))
  defines a tensor as a field on a manifold whose components transform in a
  prescribed way under a coordinate change $x\to x'$.
- These definitions are compatible. A manifold supplies a vector space $T_pM$
  at each point; a tensor field is then just an algebraic tensor at every
  point. A coordinate chart on $M$ induces a coordinate basis on each $T_pM$,
  and a change of chart induces the algebraic change of basis on $T_pM$ with
  $M$ equal to the Jacobian. The manifold transformation law is the algebraic
  one applied pointwise.
- "Tensor" sits at the abstract level; "array" sits at the concrete level. A
  **vector** is a rank‑$1$ tensor (1D array of components); a **matrix** is
  the 2D array of components of a rank‑$2$ tensor or of a linear map. The
  shape of an array tells you the rank but not the variance $(r,s)$.
- A **matrix as a linear transformation** is exactly a $(1,1)$‑tensor in
  $V\otimes V^*$; matrix multiplication is index contraction; similarity
  transformation $A\mapsto MAM^{-1}$ is the algebraic tensor transformation
  law of type $(1,1)$. Rectangular matrices for $V\to W$ are $(1,1)$‑tensors
  in $W\otimes V^*$.
- Linear algebra is *not* tensor calculus on $(1,1)$ tensors only: it silently
  mixes $(1,0)$, $(0,1)$, $(1,1)$, $(2,0)$, $(0,2)$ tensors under the single
  names *matrix* and *vector*, using the standard inner product and an
  orthonormal basis to identify them. The conflation requires both
  ingredients. The $(1,1)$ reading needs no metric at all.
- "Vector" has the same multiplicity of meanings — 1D array, abstract
  vector‑space element, $(1,0)$ vector, $(0,1)$ form, tangent vector on a
  manifold, geometric arrow, pseudovector — collapsed similarly by the
  standard inner product and an orthonormal basis.
- **Pseudotensors** are a parity twist orthogonal to rank and dimension. They
  exist at every rank and in every dimension; the 2D Levi‑Civita symbol
  $\varepsilon_{ij}$ is a pseudomatrix, the 3D Levi‑Civita symbol
  $\varepsilon_{ijk}$ is a rank‑$3$ pseudotensor, and pseudovectors such as
  $\vec B$ and $\vec\omega$ are antisymmetric rank‑$2$ tensors in disguise via
  $\varepsilon_{ijk}$. They can be understood uniformly as tensors on an
  unoriented manifold, i.e. sections of $T^r_s M \otimes \mathrm{or}(M)$.
- Tensor densities are relative invariants with character
  $|\det J|^{-w}(\operatorname{sgn}\det J)^k$. The determinant of a covariant
  tensor $A_{ij}$ is basis-independently
  $\operatorname{Det}(A)=\Lambda^n A^\flat\in(\Lambda^n V^*)^{\otimes2}$; its
  component $\det(A_{ij})$ has $(w,k)=(2,0)$, so it is not an ordinary scalar.
