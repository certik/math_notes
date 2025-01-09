---
date: 2025-01-08
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
# Differential Forms

We express differential forms in terms of tensors and index notation. The
closest treatment seems to be @winitzki2009linear, but we improve even upon
that in terms of clarity, exact short definitions and explicit examples.

It seems the usual old-fashioned index-based tensor formalism described in
@TheoreticalPhysicsReference is all that is needed, and the differential forms
provide an equivalent and optional treatment for antisymmetric tensors, which
might be sometimes useful, but fundamentally does not bring any new feature or
machinery, exactly the same computations can be done using index-based tensors
also. We show how to equivalently rewrite any differential form formula or
computation using tensors.

## Vectors, Forms and Tensors

Any vector $\mathbf{u}$ can be written as:
$$\mathbf{u}=u^i \vec{e}_i\,.$$

Any form $\mathbf{p}$ can be written as:
$$\mathbf{p}=p_i \tilde{e}^i\,.$$

The basis vectors are $\vec{e}_i$ and the basis forms are $\tilde{e}^i$.

Any rank 2 tensor $\mathbf{A}$ can be written as:
$$\mathbf{A}=A^{ij} \vec{e}_i \otimes \vec{e}_j\,.$$
Any rank 3 tensor $\mathbf{A}$ can be written as:
$$\mathbf{A}=A^{ijk} \vec{e}_i \otimes \vec{e}_j \otimes \vec{e}_k\,.$$

The tensor basis is $\vec{e}_i \otimes \vec{e}_j$ and $\vec{e}_i \otimes \vec{e}_j \otimes \vec{e}_k$.
If we mix lower and upper indices:
$$\mathbf{A}=A^i{}_{j} \vec{e}_i \otimes \tilde{e}^j\,.$$

The vector basis and the dual (form) basis is related by a dot product:
$$\tilde{e}^i \cdot \vec{e}_j = \delta^i{}_j\,.
$$

If the vector basis is a coordinate basis, then it can be written as:
$$\vec{e}_i = {\partial\mathbf{r}\over\partial x^i} \equiv
  {\partial\over\partial x^i}\,,
$$
where the position vector $\mathbf{r}$ can be omitted, and the basis vector is
treated as an operator on any function on the manifold (we will not use this
notation).
The corresponding form basis can be written as
$$\tilde{e}^i \equiv dx^i\,.
$$
The form can be said to act on a vector to produce a number (definition of a
dual space) as follows using a dot product:
$$\mathbf{p}(\mathbf{u})\equiv\mathbf{p} \cdot \mathbf{u}
=p_i \tilde{e}^i \cdot u^j \vec{e}_j
=p_i u^j \tilde{e}^i \cdot \vec{e}_j
=p_i u^j \delta^i{}_j
=p_i u^i\,.
$$
We will not use the $\mathbf{p}(\mathbf{u})$ notation, we will use the dot
product directly, or simply contracting indices as $p_i u^i$. All other forms
acting on vectors is defined in a similar way using a dot product, and in index
notation it just becomes a contraction.


## Index Notation

We omit writing the basis vectors, so equations from the previous sections
would be just $u^i$, $p_i$, $A^{ij}$, $A^{ijk}$, $A^i{}_j$, $p_i u^i$, etc. In
most cases that is enough to fully represent everything. When we want to
represent the tensor itself, we include the basis functions too.

The upper and lower indices are treated equally, they are just contravariant
and  covariant components of the same tensor.

## Exterior (Wedge) Product

The exterior (wedge) product of two forms $\mathbf{u}=u_i \tilde{e}^i$ and $\mathbf{v}=v_i \tilde{e}^i$ is defined as:
$$\label{wedge_def}
\mathbf{u} \wedge \mathbf{v} \equiv
\mathbf{u} \otimes \mathbf{v} - \mathbf{v} \otimes \mathbf{u}\,.
$$
Expressing this in components in terms of the basis:
$$\mathbf{u} \wedge \mathbf{v}
    = u_i \tilde{e}^i \wedge v_j \tilde{e}^j
    =\mathbf{u} \otimes \mathbf{v} - \mathbf{v} \otimes \mathbf{u}
    = u_i \tilde{e}^i \otimes v_j \tilde{e}^j
    - v_i \tilde{e}^i \otimes u_j \tilde{e}^j =
$$

$$= u_i v_j \tilde{e}^i \otimes \tilde{e}^j
    - v_i u_j \tilde{e}^i \otimes \tilde{e}^j =
$$

$$= (u_i v_j-u_j v_i) \tilde{e}^i \otimes \tilde{e}^j =
$$

$$= \det\begin{pmatrix} u_i & u_j \\ v_i & v_j \end{pmatrix}
        \tilde{e}^i \otimes \tilde{e}^j
    = A_{ij}\tilde{e}^i \otimes \tilde{e}^j\,.
$$
The tensor $A_{ij}$ is antisymmetric.
The last equation can be written using a wedge product by
first rewriting the tensor basis into its symmetric and antisymmetric parts:
$$A_{ij}\tilde{e}^i \otimes \tilde{e}^j
=A_{ij}{1\over2}(\tilde{e}^i \otimes \tilde{e}^j+\tilde{e}^j \otimes \tilde{e}^i)
+A_{ij}{1\over2}(\tilde{e}^i \otimes \tilde{e}^j-\tilde{e}^j \otimes \tilde{e}^i)=
$$
$$=A_{ij}{1\over2}(\tilde{e}^i \otimes \tilde{e}^j+\tilde{e}^j \otimes \tilde{e}^i)
+A_{ij}{1\over2} \tilde{e}^i \wedge \tilde{e}^j
={1\over2} A_{ij} \tilde{e}^i \wedge \tilde{e}^j\,.
$$
The left term contains an antisymmetric tensor
$A_{ij}=u_i v_j-u_j v_i$ contracted with a symmetric tensor, the result is zero.
We end up with:
$$u_i \tilde{e}^i \wedge v_j \tilde{e}^j
=(u_i v_j-u_j v_i) \tilde{e}^i \otimes \tilde{e}^j
    = {1\over2} (u_i v_j-u_j v_i) \tilde{e}^i \wedge \tilde{e}^j\,.
$$

:::{note}
The equation
$$A_{ij}\tilde{e}^i \otimes \tilde{e}^j
={1\over2} A_{ij} \tilde{e}^i \wedge \tilde{e}^j
$$
shows that any rank 2 antisymmetric tensor can be written in terms of a wedge
product as a differential form. And the definition [](#wedge_def) shows that
any differential 2-form can be written as an antisymmetric tensor. The same
will be true for higher ranks too.

Thus differential forms are simply antisymmetric tensors.
:::

:::{note}
The ${1\over2}$ factor ends up there due to double counting: if we expand the
original, in this note we'll assume dimension 2 for simplicity (i.e., $i=1,2$):
$$A_{ij}\tilde{e}^i \otimes \tilde{e}^j
=A_{12}\tilde{e}^1 \otimes \tilde{e}^2
+A_{21}\tilde{e}^2 \otimes \tilde{e}^1
+A_{11}\tilde{e}^1 \otimes \tilde{e}^1
+A_{22}\tilde{e}^2 \otimes \tilde{e}^2=
$$
$$
=A_{12}\tilde{e}^1 \otimes \tilde{e}^2
-A_{12}\tilde{e}^2 \otimes \tilde{e}^1
=A_{12}(\tilde{e}^1 \otimes \tilde{e}^2 -\tilde{e}^2 \otimes \tilde{e}^1)
=A_{12}(\tilde{e}^1 \wedge \tilde{e}^2)\,.
$$
Above we used the fact that $A_{11}=A_{22}=0$ and $A_{21}=-A_{12}$ due to
antisymmetry.
Now we expand the wedge formula in a similar manner:
$${1\over2}A_{ij}\tilde{e}^i \wedge \tilde{e}^j
={1\over2}\left(A_{12}\tilde{e}^1 \wedge \tilde{e}^2
+A_{21}\tilde{e}^2 \wedge \tilde{e}^1
+A_{11}\tilde{e}^1 \wedge \tilde{e}^1
+A_{22}\tilde{e}^2 \wedge \tilde{e}^2\right)=
$$
$$
={1\over2}\left(A_{12}\tilde{e}^1 \wedge \tilde{e}^2
-A_{12}\tilde{e}^2 \wedge \tilde{e}^1\right)
={1\over2}A_{12}(\tilde{e}^1 \wedge \tilde{e}^2 -\tilde{e}^2 \wedge \tilde{e}^1)=
$$
$$
={1\over2}A_{12}(\tilde{e}^1 \wedge \tilde{e}^2 +\tilde{e}^1 \wedge \tilde{e}^2)
=A_{12}(\tilde{e}^1 \wedge \tilde{e}^2)\,.
$$
The final answer is exactly the same in both cases:
$A_{12}(\tilde{e}^1 \wedge \tilde{e}^2)$.
We can see that the terms $\tilde{e}^1 \wedge \tilde{e}^2$ and $-\tilde{e}^2
\wedge \tilde{e}^1$ combined due to antisymmetry, canceling the ${1\over2}$.
When we use the full tensor basis $\tilde{e}^i \otimes \tilde{e}^j$ then no
terms combine, we will always have 4 terms in 2D for a general asymmetric
tensor. The wedge product basis combines the (12) and (21) terms, double
counting the element values. Another way to put it is:
$$\tilde{e}^1 \wedge \tilde{e}^2
={1\over2}(\tilde{e}^1 \wedge \tilde{e}^2 -\tilde{e}^2 \wedge \tilde{e}^1)
=(\tilde{e}^1 \otimes \tilde{e}^2 -\tilde{e}^2 \otimes \tilde{e}^1)\,.
$$
Each wedge product contains two tensor products, thus requiring the
${1\over2}$. Alternatively, for both wedge and tensor products the ${1\over2}$
comes from:
$$A_{ij} = {1\over2}(A_{ij}-A_{ji})
$$
For an antisymmetric tensor $A_{ij}$.
:::

Thus we get:
$$\label{wedge_rank2}
u_i \tilde{e}^i \wedge v_j \tilde{e}^j =
    \det\begin{pmatrix} u_i & u_j \\ v_i & v_j \end{pmatrix}
    \tilde{e}^i \otimes \tilde{e}^j
    = A_{ij}\tilde{e}^i \otimes \tilde{e}^j
    = {1\over2}A_{ij}\tilde{e}^i \wedge \tilde{e}^j\,.
$$
For a wedge product of three 1-forms we get a rank 3 antisymmetric tensor:
$$\label{wedge_rank3}
u_i \tilde{e}^i \wedge v_j \tilde{e}^j \wedge w_k\tilde{e}^k =
    \det\begin{pmatrix} u_i & u_j & u_k \\ v_i & v_j & v_k \\ w_i & w_j & w_k \end{pmatrix}
    \tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k
    =A_{ijk}\tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k\,.
$$
Higher-order products are defined in analogous manner ($n$ wedge products is a rank
$n$ fully antisymmetric tensor). The exterior product can be
defined for vectors as well.
The components of these tensors are
equal to:
$$\label{index_rank2}
A_{ij}= \det\begin{pmatrix} u_i & u_j \\ v_i & v_j \end{pmatrix}
    = u_i v_j - u_j v_i
$$
and
$$\label{index_rank3}
A_{ijk} = \det\begin{pmatrix} u_i & u_j & u_k \\ v_i & v_j & v_k \\ w_i & w_j & w_k \end{pmatrix}\,.
$$

The wedge product is equal to the tensor written
using the tensor basis in equations [](#wedge_rank2) and [](#wedge_rank3).
The same tensor in index notation is given by equations [](#index_rank2) and
[](#index_rank3).

Using properties of a determinant, we can see that the wedge product is just a
fully antisymmetric tensor.

:::{warning} TODO
Derive all properties of the wedge product using existing tensor machinery:
antisymmetry, all the common relations from literature, etc.
:::

:::{warning} TODO
Show that in 2D and 3D the wedge product is the oriented area and volume.
Ideally using tensors first, since we only want to use that, and then show that
the wedge product when written using tensors gives the area and volume exactly.
:::

:::{warning} TODO
Derive integration formulas by converting to tensor formulation and a metric.
The determinant takes care of the volume and becomes the usual square root of a
determinant of the metric I think.
:::

## Examples

### Example: $dx \wedge dz$

We can now use the definitions to compute various special cases. For example if
we have the exterior product of two forms $dx$ and $dz$ (which have components
$dx_i=\delta_{1i}$ and $dz_i=\delta_{3i}$):
$$dx \wedge dz =
    \det\begin{pmatrix} \delta_{1i} & \delta_{1j} \\ \delta_{3i} & \delta_{3j} \end{pmatrix}
    \tilde{e}^i \otimes \tilde{e}^j
    = \tilde{e}^1 \otimes \tilde{e}^3 - \tilde{e}^3 \otimes \tilde{e}^1 \,,
$$
thus the components of this rank 2 tensor are:
$$A_{ij}=\det\begin{pmatrix} \delta_{1i} & \delta_{1j} \\ \delta_{3i} & \delta_{3j} \end{pmatrix}=\delta_{1i}\delta_{3j}-\delta_{1j}\delta_{3i}
=\begin{pmatrix} 0 & 0 & 1 \\ 0 & 0 & 0 \\ -1 & 0 & 0 \end{pmatrix} \,.
$$


### Example: $\tilde{e}^1 \wedge \tilde{e}^3$

The exterior product of two basis forms $\tilde{e}^1$ and $\tilde{e}^3$ is:
$$\tilde{e}^1 \wedge \tilde{e}^3 =
    \det\begin{pmatrix} \delta_{1i} & \delta_{1j} \\ \delta_{3i} & \delta_{3j} \end{pmatrix}
    \tilde{e}^i \otimes \tilde{e}^j
    = \tilde{e}^1 \otimes \tilde{e}^3 - \tilde{e}^3 \otimes \tilde{e}^1 \,,
$$
thus the components of this rank 2 tensor are:
$$A_{ij}=\det\begin{pmatrix} \delta_{1i} & \delta_{1j} \\ \delta_{3i} & \delta_{3j} \end{pmatrix}=\delta_{1i}\delta_{3j}-\delta_{1j}\delta_{3i}
=\begin{pmatrix} 0 & 0 & 1 \\ 0 & 0 & 0 \\ -1 & 0 & 0 \end{pmatrix} \,.
$$
We can see that $\tilde{e}^1 \wedge \tilde{e}^3
    = \tilde{e}^1 \otimes \tilde{e}^3 - \tilde{e}^3 \otimes \tilde{e}^1$, so
the wedge product is simply an antisymmetric tensor, written with the form
basis functions included.


### Example: $dx^1 \wedge dx^2 \wedge dx^4$ evaluated on vectors

When evaluating the form (composed of basis forms) on vectors $\mathbf{u}$, $\mathbf{v}$ and
$\mathbf{w}$, we are computing the following dot product of the two rank 3
tensors (full contraction):
$$(dx^1 \wedge dx^2 \wedge dx^4) \cdot 
(\mathbf{u} \otimes \mathbf{v} \otimes \mathbf{w})=
$$
$$= \det\begin{pmatrix}
\delta_{1i} & \delta_{1j} & \delta_{1k} \\
\delta_{2i} & \delta_{2j} & \delta_{2k} \\
\delta_{4i} & \delta_{4j} & \delta_{4k} \\
\end{pmatrix}
\tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k
\cdot (u^l v^m w^n \vec{e}_l \vec{e}_m \vec{e}_n)=
$$
$$= \det\begin{pmatrix}
\delta_{1i} & \delta_{1j} & \delta_{1k} \\
\delta_{2i} & \delta_{2j} & \delta_{2k} \\
\delta_{4i} & \delta_{4j} & \delta_{4k} \\
\end{pmatrix}
u^i v^j w^k
= \det\begin{pmatrix}
u_1 & v_1 & w_1 \\
u_2 & v_2 & w_2 \\
u_4 & v_4 & w_4 \\
\end{pmatrix}\,.
$$

The form has thus selected the first, second and fourth component row of the
vectors. The result is just a scalar.
