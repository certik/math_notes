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
closest treatment seems to be @winitzki2009linear, but we improve even upon that
in clarity, exact short definitions and explicit examples.

It seems the usual old-fashioned index-based tensor formalism described in
@TheoreticalPhysicsReference is all that is needed, and the differential forms
provide an equivalent and optional treatment for antisymmetric tensors, which
might be sometimes useful, but fundamentally does not bring any new feature or
machinery, exactly the same computations can be done using index-based tensors
also. We show how to equivalently rewrite any differential form formula or
computation using tensors.

Here is a concurring opinion from [Brian Beckman's _From the Steam Age to the Standard Model_](https://community.wolfram.com/groups/-/m/t/3594810)

> This book uses the old-fashioned index notation typified by Lovelock and Rund (L&R). It is written entirely in terms of transformation rules between coordinate systems. This is refreshingly concrete for the physicist concerned with calculation. After all, we must have numbers and arrays to do calculations. The downside of this ancient notation is that it's no help in understanding contemporary literature. We can't have our cake—coordinate-free notation for concise theorizing—and eat it—concrete coordinates for practical calculation—too. 
> 
> We also avoid Cartan's exterior calculus, typified by the Grassmann wedge product, as in $d x\wedge{}d y$. While this is a beautiful and powerful formalism, it's not usually taught at an undergraduate level, and we don't want assume it of the reader. We also don't want to take the time and space to develop it. We can do all the physics we want without it, for now. 

In these notes, we _do_ take the time and space to develop that bridge from modern notation to the classical index notation.

## Vectors, Forms, and Tensors

### Vectors

Any vector $\mathbf{u}$ can be written as:
$$\mathbf{u}=u^i \vec{e}_i\,.$$

:::{note}
 
The _Einstein summation convention_ simplifies formulae, expressions, and
equations by omitting explicit summation symbols. Under this convention,
whenever an index variable appears twice in a single term—once as a superscript
(upper index) and once as a subscript (lower index)—an implicit summation over
all possible values of that index is assumed. For example, an $n$‑dimensional
vector $\mathbf{u}$ is written simply as:
$$ \mathbf{u} = u^i \vec{e}_i $$
which implicitly represents 
$$ \quad \mathbf{u} = \sum_{i=1}^n u^i \vec{e}_i\,. $$
where $u^i$ is a _scalar_ number—a member of the underlying field of the vector
space (usually $\mathbb{R}$ or $\mathbb{C}$), and $\vec{e}_i$ is a basis vector.

This convention applies implicitly throughout our notes to both Latin indices
(e.g., $i, j, k$ for spatial or generic dimensions) and to Greek indices (e.g.,
$\mu, \nu$ for spacetime coordinates), unless an exception is explicitly stated,
as via a “no sum” label.
:::

### One-Forms

Any one-form $\mathbf{p}$ can be written as:
$$\mathbf{p}=p_i \tilde{e}^i\,.$$
Whereas the basis vectors are $\vec{e}_i\;$, the basis one-forms are $\tilde{e}^i$.

:::{note}
In the language of linear algebra, vectors are _column vectors_ and one-forms
are _row vectors_, also called _covectors_. Covectors are linear operators that
transform vectors to scalars via the _inner product_
$\mathbf{u}^\intercal\mathbf{v}$, or transform vectors to matrices via the _outer
product_ $\mathbf{u}\mathbf{v}^\intercal$, an instance of the _tensor product_ $\mathbf{u}\otimes\mathbf{v}$. 

The basis vector $\vec{e}_i$ in the _standard basis_ is the column vector with
$1$ in position $i$ and zeros elsewhere. Likewise, the basis one-form
$\tilde{e}^i$ is the row vector with $1$ in position $I$ and zeros elsewhere
such that  $\tilde{e}^i={\vec{e}_i}^\intercal$. 

:::

### Tensors

Any rank‑2 _contravariant_ tensor $\mathbf{A}$ can be written as:
$$\mathbf{A}=A^{ij}\; \vec{e}_i \otimes \vec{e}_j\,.$$
Any rank‑3 contravariant tensor $\mathbf{A}$ can be written as:
$$\mathbf{A}=A^{ijk}\; \vec{e}_i \otimes \vec{e}_j \otimes \vec{e}_k\,.$$
The contravariant tensor bases are $\vec{e}_i \otimes \vec{e}_j$ and $\vec{e}_i \otimes \vec{e}_j \otimes \vec{e}_k\,$, respectively.

:::{note}
The expression $\vec{e}_i \otimes \vec{e}_j$ is the _tensor product_ of
$\vec{e}_i$ and $\vec{e}_j$. In the language of linear algebra and in the
_standard basis_, it is the matrix $\vec{e}_i {\vec{e}_j}^\intercal$, with $1$
at row $i$ and column $j$, and zeros elsewhere. 
:::

Mixing lower and upper indices:
$$\mathbf{A}=A^i{}_{j}\; \vec{e}_i \otimes \tilde{e}^j\,.$$
:::{note}
The expression $\vec{e}_i\otimes\tilde{e}^j$ is, again, a tensor product of
$\vec{e}_i$ and $\tilde{e}^j$. In the language of linear algebra, this is the
outer product $\vec{e}_i \tilde{e}^j = \vec{e}_i {\vec{e}_j}^\intercal$ in the
standard basis because $\tilde{e}^j={\vec{e}_j}^\intercal$ is a row vector
(covector). 
:::

The vector basis and the dual (form) basis are related by a dot product:
$$\tilde{e}^i \cdot \vec{e}_j = \delta^i{}_j\,.
$$
:::{note}
This is again the inner product, i.e., $\tilde{e}^i \cdot \vec{e}_j\equiv\tilde{e}^i\vec{e}_j\equiv\vec{e}_i^\intercal\vec{e}_j$.
:::

:::{note}
The _Kronecker delta_ $\delta^i{}_j$ is often written (unambiguously) in stacked
form as $\delta^i_j\,$.
:::

If the vector basis is a _coordinate basis_, then basis vectors can be written
as:
$$\vec{e}_i = {\partial\,\mathbf{r}\over\partial x^i} \equiv
  {\partial\over\partial x^i}\,,
$$
where the position vector $\mathbf{r}$ can be omitted, and the basis vector is
treated as an operator on any function on the manifold (we will not use this
notation).

The corresponding 1-form basis can be written as
$$\tilde{e}^i \equiv dx^i\,.
$$
As noted above, the one-form can act on a vector to produce a scalar, by
definition of the _dual space_ of linear operators on vectors, where 1-forms
live, as follows using an inner (dot) product:
$$
\begin{aligned}
\mathbf{p}(\mathbf{u})&\equiv\mathbf{p} \cdot \mathbf{u}
\\&=p_i \tilde{e}^i \cdot u^j \vec{e}_j
\\&=p_i u^j \tilde{e}^i \cdot \vec{e}_j
\\&=p_i u^j \delta^i{}_j
\\&=p_i u^i\,.
\end{aligned}
$$
We will not use the $\mathbf{p}(\mathbf{u})$ notation, preferring the dot
product directly, or simply contracting indices as $p_i u^i$. All other forms
acting on vectors are defined in a similar way using a dot product. In index
notation, dot product becomes _contraction_.

## Index Notation

We omit writing the basis vectors, so expressions from the previous sections
would be just $u^i$, $p_i$, $A^{ij}$, $A^{ijk}$, $A^i{}_j$, $p_i u^i$, etc. In
most cases that is enough to fully represent everything. When we want to
represent the tensor itself rather than just its components in the underlying
fields (usually $\mathbb{R}$ or $\mathbb{C}$), we include the basis functions too.

Upper and lower indices are treated equally. They just denote contravariant
and covariant components of the same tensor.

:::{note}
Mnemonically, vectors transform contravariantly and covectors transform covariantly. 

For example, if a coordinate transformation $\partial{x}/\partial{\bar{x}}=12\text{ inches per foot }$ converts feet $\bar{x}$ to inches $x$, then a velocity vector $\bar{v}$ in feet per second transforms into $v=\bar{v}\times\partial{x}/\partial{\bar{x}}$ inches per second. This transformation is _contravariant_ because the barred vector is multiplied by a derivative with the bar in the lower (denominator), _contra-_ position. Conversely, a temperature gradient covector $\bar{\tilde{t}}$ in degrees per foot transforms into $\tilde{t}=\bar{\tilde{t}}/(\partial{x}/\partial{\bar{x}})=\bar{\tilde{t}}\times\partial{\bar{x}}/\partial{x}$ degrees per inch. This transformation is _covariant_ because the barred covector is multiplied by a derivative with the bar in the upper (numerator), _co-_ position. 

Gradients, generally, are covectors rather than vectors because they transform
differently than do vectors with respect to coordinates or _gauges_. The same
logic applies to tensors with up, down, or mixed indices indices. The up indices
transform contravariantly and the down indices transform covariantly.
:::
## Antisymmetric and Symmetric Tensors

The antisymmetric part of any covariant rank-2 tensor $A_{ij}$ can be written as follows:
$$
\begin{aligned}
A_{[ij]} &= {1\over2!}\varepsilon_{ij}\varepsilon^{kl} A_{kl}
\\ &= {1\over2}\det\begin{pmatrix} \delta_i{}^k & \delta_i{}^l \\ \delta_j{}^k & \delta_j{}^l \end{pmatrix} A_{kl}
\\ &= {1\over2}(\delta_i{}^k\delta_j{}^l - \delta_i{}^l \delta_j{}^k) A_{kl}\\
& =\frac12(A_{ij}-A_{ji})\,.
\end{aligned}
$$
:::{note}
The _rank_ of a tensor is the number of indices. It has nothing to do with the
rank of a matrix, which is the number of linearly independent columns.
:::

:::{note}
The _symmetric part_ of a rank-2 tensor is written
$$A_{(ij)}=\frac12(A_{ij} + A_{ji})\,.$$
which is equal to the _permanent_, which is like the determinant, but with all positive signs, without minus signs for the odd permutations. The symmetric part is of secondary interest in Cartan's Exterior Calculus of forms.

For a 2-tensor, the permanent is:
$$\text{perm}\begin{pmatrix} a & b \\ c & d \end{pmatrix} \stackrel{\text{def}}{=} ad + bc$$
Thus, the symmetric part of a covariant rank-2 tensor $A_{ij}$ is:
$$
\begin{aligned}
A_{(ij)} &= \frac{1}{2!} \text{perm}\begin{pmatrix} \delta_i{}^k & \delta_i{}^l \\ 
\delta_j{}^k & \delta_j{}^l
\end{pmatrix} A_{kl} 
\\ & = \frac{1}{2}(\delta_i{}^k\delta_j{}^l + \delta_i{}^l\delta_j{}^k) A_{kl} 
\\ & = \frac{1}{2}(A_{ij} + A_{ji})\,.
\end{aligned}
$$
:::

### Antisymmetric part of a covariant rank-3 tensor:
$$
\begin{aligned}
A_{[ijk]} &= {1\over3!}\varepsilon_{ijk}\varepsilon^{lmn} A_{lmn}
\\&= {1\over3!}\det\begin{pmatrix}
\delta_i{}^l & \delta_i{}^m & \delta_i{}^n \\
\delta_j{}^l & \delta_j{}^m & \delta_j{}^n \\
\delta_k{}^l & \delta_k{}^m & \delta_k{}^n  \\
\end{pmatrix} A_{lmn}
\\&= {1\over3!}(\delta_i{}^l\delta_j{}^m\delta_k{}^n - \delta_i{}^m\delta_j{}^l\delta_k{}^n + \cdots) A_{lmn}
\\&= {1\over6}(A_{ijk}-A_{jik}+\cdots - \cdots + \cdots)\,.
\end{aligned}
$$
### Antisymmetric part of a covariant rank-4 tensor:
$$
\begin{aligned}
A_{[ijkl]} &= {1\over4!}\varepsilon_{ijkl}\varepsilon^{mnop} A_{mnop}
\\&= {1\over4!}\det\begin{pmatrix}
\delta_i{}^m & \delta_i{}^n & \delta_i{}^o & \delta_i{}^p \\
\delta_j{}^m & \delta_j{}^n & \delta_j{}^o & \delta_j{}^p \\
\delta_k{}^m & \delta_k{}^n & \delta_k{}^o & \delta_k{}^p \\
\delta_l{}^m & \delta_l{}^n & \delta_l{}^o & \delta_l{}^p \end{pmatrix} A_{mnop}
\\&={1\over4!}(\delta_i{}^m\delta_j{}^n\delta_k{}^o\delta_l{}^p - \delta_i{}^n\delta_j{}^m\delta_k{}^o\delta_l{}^p + \cdots) A_{mnop}
\\&={1\over24}(A_{ijkl}-A_{jikl}+\cdots)\,.
\end{aligned}
$$
The fraction at the beginning tells us how many terms there are in the final
answer: 2, 6, 24 for ranks 2, 3, 4.

:::{note}
The above expressions work for any dimension, except the Levi-Civita expression
only works for rank equal to dimension (e.g., rank 2, dimension 2). For
dimension higher than the rank, one can skip the Levi-Civita expression and go
straight to the determinant, which is correct in any dimension.

There is a dimension-dependent expression using contracted Levi-Civita symbols
that is equal to the determinant. For example for rank 3 and dimension 4, the
expression is $\varepsilon_{ijks}\varepsilon^{slmn}$.
:::

:::{note}
The generalization of the symmetric part of a covariant tensor to $N$ dimensions is
$$A_{(i_1,\, \dots,\, i_N)} = \frac{1}{N!} \text{perm} \begin{pmatrix}
\delta_{i_1}{}^{k_1} & \delta_{i_1}{}^{k_2} & \dots & \delta_{i_1}{}^{k_N} \\
\delta_{i_2}{}^{k_1} & \delta_{i_2}{}^{k_2} & \dots & \delta_{i_2}{}^{k_N} \\
\vdots & \vdots & \ddots & \vdots \\
\delta_{i_N}{}^{k_1} & \delta_{i_N}{}^{k_2} & \dots & \delta_{i_N}{}^{k_N} 
\end{pmatrix} 
A_{k_1,\, \dots,\, k_N}$$
:::

## Exterior (Wedge) Product

The _exterior (wedge) product_ of two 1-forms $\mathbf{u}=u_i \tilde{e}^i$ and $\mathbf{v}=v_i \tilde{e}^i$ is defined as:
$$\label{wedge_def}
\mathbf{u} \wedge \mathbf{v} \equiv
\mathbf{u} \otimes \mathbf{v} - \mathbf{v} \otimes \mathbf{u}\,.
$$
Expressing this in components in a basis:
$$\begin {aligned}
 \mathbf {u} \wedge \mathbf {v} & = u_i \tilde {e}^i \wedge v_j \tilde {e}^j \\
 & = \mathbf {u} \otimes \mathbf {v} - \mathbf {v} \otimes \mathbf {u} \\
 & = u_i \tilde {e}^i \otimes v_j \tilde {e}^j - v_i \tilde {e}^i \otimes u_j \tilde {e}^j \\
 & = u_i v_j \tilde{e}^i \otimes \tilde{e}^j
    - v_i u_j \tilde{e}^i \otimes \tilde{e}^j \\
& = (u_i v_j-u_j v_i) \tilde{e}^i \otimes \tilde{e}^j \\
& = \det\begin{pmatrix} u_i & u_j \\ v_i & v_j \end{pmatrix}
        \tilde{e}^i \otimes \tilde{e}^j \\
& = A_{ij}\;\tilde{e}^i \otimes \tilde{e}^j\,.
 \end {aligned}
$$
The tensor $A_{ij}$ is antisymmetric.

The last equation can be written as a wedge product by
first rewriting the tensor basis into its symmetric and antisymmetric parts:
$$
\begin{aligned}
A_{ij}\;\tilde{e}^i \otimes \tilde{e}^j
&=A_{ij}{1\over2}(\tilde{e}^i \otimes \tilde{e}^j+\tilde{e}^j \otimes \tilde{e}^i)
+A_{ij}{1\over2}(\tilde{e}^i \otimes \tilde{e}^j-\tilde{e}^j \otimes \tilde{e}^i)
\\&=A_{ij}{1\over2}(\tilde{e}^i \otimes \tilde{e}^j+\tilde{e}^j \otimes \tilde{e}^i)+A_{ij}{1\over2} \tilde{e}^i \wedge \tilde{e}^j
\\&={1\over2} A_{ij}\; \tilde{e}^i \wedge \tilde{e}^j\,.
\end{aligned}
$$
The left term contains an antisymmetric tensor
$A_{ij}=u_i v_j-u_j v_i$ contracted with a symmetric tensor $(\tilde{e}^i \otimes \tilde{e}^j+\tilde{e}^j \otimes \tilde{e}^i)$; the result is zero.

:::{dropdown} Lean proof: `contract_antisymm_symm` (and `contract_antisymm_symm_eq_neg`)
Writing the full contraction of two rank-2 covariant tensors as $\sum_{i,j} A_{ij}\,S^{ij}$,
relabelling the summation indices $i\leftrightarrow j$ and using antisymmetry $A_{ij}=-A_{ji}$
together with symmetry $S^{ij}=S^{ji}$ shows that the contraction equals its own negation. Over
$\mathbb{R}$ this forces it to vanish.
```{literalinclude} math_notes_lean/MathNotesLean/DifferentialFormsFlow.lean
:language: lean
:start-after: ANCHOR: contract-vanishes
:end-before: ANCHOR_END: contract-vanishes
```
:::

We end up with:
$$\begin{aligned}
u_i \tilde{e}^i \wedge v_j \tilde{e}^j
&=(u_i v_j-u_j v_i) \tilde{e}^i \otimes \tilde{e}^j
\\&    = {1\over2} (u_i v_j-u_j v_i)\; \tilde{e}^i \wedge \tilde{e}^j\,.
\end{aligned}
$$

:::{note}
The equation
$$A_{ij}\;\tilde{e}^i \otimes \tilde{e}^j
={1\over2} A_{ij}\; \tilde{e}^i \wedge \tilde{e}^j
$$
shows that any rank-2 antisymmetric covariant tensor (a 2-form) can be written as a wedge product or as a differential form. And Definition [](#wedge_def) shows that
any differential 2-form can be written as an antisymmetric tensor. The same
will be true for higher ranks too.

Thus differential forms are simply antisymmetric tensors.
:::

:::{note}
The ${1\over2}$ factor ends up there due to double counting: if we expand the
original, in this note we'll assume dimension 2 for simplicity (i.e., $i=1,2$):
$$\begin{aligned}
A_{ij}\tilde{e}^i \otimes \tilde{e}^j
&=A_{12}\tilde{e}^1 \otimes \tilde{e}^2
+A_{21}\tilde{e}^2 \otimes \tilde{e}^1
+A_{11}\tilde{e}^1 \otimes \tilde{e}^1
+A_{22}\tilde{e}^2 \otimes \tilde{e}^2
\\&=A_{12}\tilde{e}^1 \otimes \tilde{e}^2
-A_{12}\tilde{e}^2 \otimes \tilde{e}^1
\\&=A_{12}(\tilde{e}^1 \otimes \tilde{e}^2 -\tilde{e}^2 \otimes \tilde{e}^1)
\\&=A_{12}(\tilde{e}^1 \wedge \tilde{e}^2)\,.
\end{aligned}
$$
Above we used the fact that $A_{11}=A_{22}=0$ and $A_{21}=-A_{12}$ due to antisymmetry.
Now we expand the wedge formula in a similar manner:
$$\begin{aligned}
{1\over2}A_{ij}\tilde{e}^i \wedge \tilde{e}^j
&={1\over2}\left(A_{12}\tilde{e}^1 \wedge \tilde{e}^2
+A_{21}\tilde{e}^2 \wedge \tilde{e}^1
+A_{11}\tilde{e}^1 \wedge \tilde{e}^1
+A_{22}\tilde{e}^2 \wedge \tilde{e}^2\right)\
\\&={1\over2}\left(A_{12}\tilde{e}^1 \wedge \tilde{e}^2
-A_{12}\tilde{e}^2 \wedge \tilde{e}^1\right)
\\&={1\over2}A_{12}(\tilde{e}^1 \wedge \tilde{e}^2 -\tilde{e}^2 \wedge \tilde{e}^1)
\\&={1\over2}A_{12}(\tilde{e}^1 \wedge \tilde{e}^2 +\tilde{e}^1 \wedge \tilde{e}^2)
\\&=A_{12}(\tilde{e}^1 \wedge \tilde{e}^2)\,.
\end{aligned}
$$
The final answer is exactly the same in both cases: $A_{12}(\tilde{e}^1 \wedge \tilde{e}^2)$. We can see that the terms $\tilde{e}^1 \wedge \tilde{e}^2$ and $\tilde{e}^2 \wedge \tilde{e}^1$ combined due to antisymmetry, canceling the ${1\over2}$. When we use the full tensor basis $\tilde{e}^i \otimes \tilde{e}^j$ then no terms combine, we will always have 4 terms in 2D for a general asymmetric tensor. The wedge product basis combines the $(12)$ and $(21)$ terms, double counting the element values. Another way to put it is:
$$\tilde{e}^1 \wedge \tilde{e}^2
={1\over2}(\tilde{e}^1 \wedge \tilde{e}^2 -\tilde{e}^2 \wedge \tilde{e}^1)
=(\tilde{e}^1 \otimes \tilde{e}^2 -\tilde{e}^2 \otimes \tilde{e}^1)\,.
$$
Each wedge product contains two tensor products, thus requiring the ${1\over2}$. Alternatively, for both wedge and tensor products the ${1\over2}$ comes from:
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
The wedge product of three 1-forms is defined using:
$$\label{wedge_def3}
\begin{aligned}
\mathbf{u} \wedge \mathbf{v} \wedge \mathbf{w} &\equiv
 \mathbf{u} \otimes \mathbf{v} \otimes \mathbf{w}
\\&-\mathbf{v} \otimes \mathbf{u} \otimes \mathbf{w}
\\&+\mathbf{w} \otimes \mathbf{u} \otimes \mathbf{v}
\\&-\mathbf{w} \otimes \mathbf{v} \otimes \mathbf{u}+%
\\&+\mathbf{v} \otimes \mathbf{w} \otimes \mathbf{u}
\\&-\mathbf{u} \otimes \mathbf{w} \otimes \mathbf{v}
\end{aligned}
$$
Expressing this in components we get a rank 3 antisymmetric tensor:
$$\label{wedge_rank3}
\begin{aligned}
u_i \tilde{e}^i \wedge v_j \tilde{e}^j \wedge w_k\tilde{e}^k &=
    \det\begin{pmatrix} u_i & u_j & u_k \\ v_i & v_j & v_k \\ w_i & w_j & w_k \end{pmatrix}
    \tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k
\\&=A_{ijk}\;\tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k\,.
\end{aligned}
$$
:::{warning} TODO
Likely this is true:
$$A_{ijk}\;\tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k
={1\over 3!}A_{ijk}\;\tilde{e}^i \wedge \tilde{e}^j \wedge \tilde{e}^k\,.
$$
But we need to prove it.
:::

Higher-order products are defined in analogous manner ($n$ wedge products is a rank $n$ fully antisymmetric tensor). The exterior product can be defined for vectors as well. The components of these tensors are equal to:
$$\label{index_rank2}
A_{ij}= \det\begin{pmatrix} u_i & u_j \\ v_i & v_j \end{pmatrix}
    = u_i v_j - u_j v_i
$$
and
$$\label{index_rank3}
A_{ijk} = \det\begin{pmatrix} u_i & u_j & u_k \\ v_i & v_j & v_k \\ w_i & w_j & w_k \end{pmatrix}\,.
$$

The wedge product is equal to the tensor written using the tensor basis in
equations [](#wedge_rank2) and [](#wedge_rank3). The same tensor in index
notation is given by equations [](#index_rank2) and [](#index_rank3).

Via properties of a determinant, we can see that the wedge product is just a
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

### $dx \wedge dz$

We can now use the definitions to compute various special cases. For example, if
we have the exterior product of two 1-forms $dx$ and $dz$ (with components
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
### $\tilde{e}^1 \wedge \tilde{e}^3$

The exterior product of two basis 1-forms $\tilde{e}^1$ and $\tilde{e}^3$ is:
$$\tilde{e}^1 \wedge \tilde{e}^3 =
    \det\begin{pmatrix} \delta_{1i} & \delta_{1j} \\ \delta_{3i} & \delta_{3j} \end{pmatrix}
    \tilde{e}^i \otimes \tilde{e}^j
    = \tilde{e}^1 \otimes \tilde{e}^3 - \tilde{e}^3 \otimes \tilde{e}^1 \,,
$$
thus the components of this rank 2 tensor are:
$$A_{ij}=\det\begin{pmatrix} \delta_{1i} & \delta_{1j} \\ \delta_{3i} & \delta_{3j} \end{pmatrix}=\delta_{1i}\delta_{3j}-\delta_{1j}\delta_{3i}
=\begin{pmatrix} 0 & 0 & 1 \\ 0 & 0 & 0 \\ -1 & 0 & 0 \end{pmatrix} \,.
$$
We can see that $\tilde{e}^1 \wedge \tilde{e}^3 = \tilde{e}^1 \otimes \tilde{e}^3 - \tilde{e}^3 \otimes \tilde{e}^1$, so the wedge product is simply an antisymmetric tensor, written with with basis functions included.

### $dx^1 \wedge dx^2 \wedge dx^4$ Evaluated on Vectors

When evaluating the form (composed of basis forms) on vectors $\mathbf{u}$, $\mathbf{v}$ and $\mathbf{w}$, we are computing the following dot product of the two rank-3 tensors (full contraction):
$$
\begin{aligned}
&(dx^1 \wedge dx^2 \wedge dx^4) \cdot 
(\mathbf{u} \otimes \mathbf{v} \otimes \mathbf{w})
\\&= \det\begin{pmatrix}
\delta_{1i} & \delta_{1j} & \delta_{1k} \\
\delta_{2i} & \delta_{2j} & \delta_{2k} \\
\delta_{4i} & \delta_{4j} & \delta_{4k} \\
\end{pmatrix}
\tilde{e}^i \otimes \tilde{e}^j \otimes \tilde{e}^k
\cdot (u^l v^m w^n \vec{e}_l \otimes \vec{e}_m \otimes \vec{e}_n)
\\&=
\det\begin{pmatrix}
\delta_{1i} & \delta_{1j} & \delta_{1k} \\
\delta_{2i} & \delta_{2j} & \delta_{2k} \\
\delta_{4i} & \delta_{4j} & \delta_{4k} \\
\end{pmatrix}
u^i v^j w^k
\\&= \det\begin{pmatrix}
u_1 & v_1 & w_1 \\
u_2 & v_2 & w_2 \\
u_4 & v_4 & w_4 \\
\end{pmatrix}\,.\end{aligned}
$$
The form has thus selected the first, second and fourth component row of the
vectors. The result is just a scalar.

## Exterior Derivative

The exterior derivative $d$ is defined via the following rules / definitions for differential forms:

* 0-form $f$: $df \equiv {\partial f\over\partial x^i} dx^i =\partial_i f \, dx^i$
* k-forms $\alpha$ and $\beta$, numbers $a$, $b$:
  $d(a\alpha+b\beta) = a\; d\alpha + b\; d\beta$
* $k$-form $\alpha$, 1-form $\beta$:
  $d(\alpha \wedge \beta) = d\alpha\wedge\beta + (-1)^k \alpha\wedge d\beta$
* $k$-form $\alpha$: $d(d\alpha) = 0$

It turns out that in terms of tensors, the exterior derivative is simply a regular derivative that is made antisymmetric:

* 0-form: $\partial_i f$
* 1-form: $\partial_{[i} f_{j]}$
* 2-form: $\partial_{[i} A_{jk]}$
* 3-form: $\partial_{[i} A_{jkl]} = 0$ (in 3 dimensions, since a rank-4 fully antisymmetric tensor in 3D is identically 0)

One can use the formulas from the section "Antisymmetric Tensors" above to
evaluate these antisymmetric derivatives. We show examples of this below. We
first compute the exterior derivative using differential forms and the above
rules, and then we do exactly the same operations using tensors.

### Differentiating 0-forms

Input:
$$
f(x, y)\,.
$$
Derivative:
$$
df = \partial_x f\, dx + \partial_y f\, dy\,.
$$
In general, we get:
$$
df = \partial_i f \, dx^i\,.
$$

### Differentiating 1-forms

Input:
$$
\omega = f_1(x^1,x^2) dx^1 + f_2(x^1,y^2) dx^2\,.
$$
Derivative:
$$
\begin{aligned}
d\omega &= d f1 \wedge dx^1 + df_2 \wedge dx^2
\\&= \partial_i f_1 \, dx^i \wedge dx^1 + \partial_i f_2 \, dx^i \wedge dx^2
\\&= \partial_2 f_1 \, dx^2 \wedge dx^1 + \partial_1 f_2 \, dx^1 \wedge dx^2
\\&= (\partial_1 f_2 - \partial_2 f_1) dx^1 \wedge dx^2\,.
\end{aligned}
$$
In general, the derivative of a 1-form $\tilde f=f_i dx^i$ is:
$$
\begin{aligned}
d\tilde f &=d(f_i dx^i)
\\&=df_i \wedge dx^i
\\&=(\partial_j f_i dx^j) \wedge dx^i
\\&={1\over2}(\partial_j f_i - \partial_i f_j) dx^j \wedge dx^i=
\\&=(\partial_j f_i - \partial_i f_j) dx^j \otimes dx^i\,.
\\&= A_{ij}\; dx^i \otimes dx^j\,,
\end{aligned}
$$
Take a 1-form $f_j$, differentiate $\partial_i f_j$, to get a rank-2 tensor. Project it into the antisymmetric subspace $dx^i \otimes dx^j - dx^j \otimes dx^i={1\over2}dx^i\wedge dx^j$, canceling the symmetric part of the derivative. Only the antisymmetric part survives: $\partial_i f_j - \partial_j f_i$. So we define the derivative to be $A_{ij}=\partial_i f_j - \partial_j f_i$. We can define the derivative on antisymmetric tensors (exterior derivative) to be a regular derivative projected into the antisymmetric subset.

Let's now do the same computation using regular tensors:
$$
\begin{aligned}
A_{ij} &= \partial_{[i} f_{j]}
\\&= {1\over 2}\varepsilon_{ij}\varepsilon^{kl} \partial_{k} f_{l}
\\&= {1\over 2}(\delta_i{}^k\delta_j{}^l-\delta_i{}^l\delta_j{}^k) \partial_{k} f_{l}
\\&= {1\over 2}(\partial_i f_j - \partial_j f_i)\,.
\end{aligned}
$$
:::{error}
This seems to be off by a factor of $\frac12$ from the above.
:::

The exterior derivative is simply a regular (not antisymmetric) derivative $\partial_{i} f_{j}$ that is made antisymmetric: $\partial_{[i} f_{j]}$. The same applies to higher ranks.

### Differentiating 2-forms in 3D

Input:
$$
\omega = (F^1 \,dx^2 \wedge dx^3) + (F^2 \,dx^3 \wedge dx^1) + (F^3 \,dx^1 \wedge dx^2)\,.
$$
Output:
$$
\begin{aligned}
d\omega &= (dF^1 \wedge dx^2 \wedge dx^3) + (dF^2 \wedge dx^3 \wedge dx^1) + (dF^3 \wedge dx^1 \wedge dx^2)
\\&= (\partial_1 F^1 dx^1 \wedge dx^2 \wedge dx^3) + (\partial_2 F^2 dx^2 \wedge dx^3 \wedge dx^1) + (\partial_3 F^3 dx^3 \wedge dx^1 \wedge dx^2)
\\&= (\partial_1 F^1 + \partial_2 F^2 + \partial_3 F^3) \,dx^1 \wedge dx^2 \wedge dx^3\,.
\end{aligned}
$$
In general for antisymmetric $A_{ij}$:
$$
\omega = A_{ij}\, dx^i \otimes dx^j = {1\over2} A_{ij}\, dx^i \wedge dx^j\,.
$$
Differentiate the tensor:
$$
\begin{aligned}
d\omega &= {1\over2} d A_{ij} \, dx^i \wedge dx^j
\\&= {1\over2} \partial_k A_{ij} \, dx^k \wedge dx^i \wedge dx^j
\\&= {1\over2} \partial_{[k} A_{ij]} \, dx^i \wedge dx^j \wedge dx^k
\\&= {1\over2} {1\over 6}\varepsilon_{kij}\varepsilon^{lmn} \partial_{l} A_{mn} \, dx^i \wedge dx^j \wedge dx^k
\\&= {1\over2} {1\over 6}\varepsilon_{kij}\varepsilon^{lmn} \partial_{l} \varepsilon_{mnq} F^q \, dx^i \wedge dx^j \wedge dx^k
\\&= {1\over2} {1\over 6}\varepsilon_{kij} 2 \delta^l{}_q \partial_{l} F^q \, dx^i \wedge dx^j \wedge dx^k
\\&= {1\over 6}\varepsilon_{ijk} \partial_q F^q \, dx^i \wedge dx^j \wedge dx^k
\\&= \partial_q F^q \, dx^1 \wedge dx^2 \wedge dx^3\,.
\end{aligned}
$$

We used the fact that the basis is antisymmetric, so only the antisymmetric part
of the derivative survives. The basis becomes antisymmetric due to the
incorporation of the $dx^k$ base via the wedge product, otherwise the derivative
is not fully antisymmetric.

The above is the correct result for differentiating any $k$-form in $n$-D space
where $k=n-1$.

Let's now do the same computation using regular tensors: 
$$ \begin{aligned}
\partial_{[k} A_{ij]} &= {1\over 6}\varepsilon_{kij}\varepsilon^{lmn}
\partial_{l} A_{mn} \\&= {1\over 6}\varepsilon_{kij}\varepsilon^{lmn}
\partial_{l} \varepsilon_{mnq} F^q = \\&= {1\over 6}\varepsilon_{kij} 2
\delta^l{}_q \partial_{l} F^q \\&= {1\over 6}\varepsilon_{ijk} \partial_q F^q\,.
\end{aligned} 
$$
The exterior derivative is simply a regular (not antisymmetric)
derivative $\partial_{k} A_{ij}$ that is made antisymmetric: $\partial_{[k} A_{ij]}$.

:::{note}
The quantity $F^q$ above is a pseudovector, it is not a tensor, because it is
defined by $A_{ij}=\varepsilon_{ijq}F^q$ where $A_{ij}$ is an antisymmetric
tensor and $\varepsilon_{ijq}$ is a pseudotensor. The divergence operation is a
tensor operation, but a divergence of a pseudovector is a pseudoscalar. The
exterior derivative $\partial_{[k} A_{ij]}$ on the LHS is a (fully
antisymmetric) tensor. So we need the Levi-Civita pseudotensor
$\varepsilon_{ijk}$ on the RHS to make everything work: together with the
pseudoscalar, the RHS is a tensor, but the individual terms are not. 
:::

## TODO

:::{warning} TODO

Add examples of a 3D space, rank 0-, 1-, 2-, 3-forms that correspond to scalars,
vectors/forms, rank-2 antisymmetric tensors (which internally contain a
pseudovector, I think, using $A_{ij}=\varepsilon_{ijk}B_k$; here
$\varepsilon_{ijk}$ is a tensor density, not a tensor, so also $B_k$ is not a
vector, but a pseudovector), and rank-3 antisymmetric tensor, which I think must
contain only one independent component, and it is related to the oriented
volume, the component might be a pseudoscalar, since it changes sign when you
flip axes, or something like that.

Riemannian volume form ($\sqrt{|g|} dx^1 \wedge ... \wedge dx^n$) is related to this, add examples.

$\sqrt{-g}$ is a scalar density, add examples.

Show this:
$$\mathbf{a}\wedge \mathbf{b} = i \mathbf{a} \times \mathbf{b}\,,$$
where $i = e_1 \wedge e_2 \wedge e_3$ is a unit pseudoscalar, $i^2=-1$.

This is also related to the Hodge star operator, which provides isomorphism
between axial vectors (pseudovectors) and bivectors (2-forms).

Give examples from physics for each. It should be possible to build this
structure fully using antisymmetric tensors.

Also add examples of differentiation, where derivative of a vector creates a
tensor, this must be related to $F_{\mu\nu}=\partial_\mu A_\nu - \partial_\nu A_\mu$ which
is antisymmetric, so this operation can be expressed as differentiating
differential forms, since both LHS and RHS are antisymmetric tensors.
Differentiating one more time in the antisymmetric manner then creates the rank-3 
tensor. No more antisymmetric derivatives are then possible.

Knowing exactly where each physical entity belongs is crucial (give examples),
but that is possible already using tensors, we do not need differential forms
for that. Rewrite various equations that use differential forms to use tensors.
:::
