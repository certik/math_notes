---
date: 2025-01-15
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
# Determinant

## Multiplicative Property

In this section we assume the usual definition of a determinant, from which one
can derive the following properties that we will need:
$$
\det \mathrm{diag}(d_1, d_2, \dots, d_n)=d_1 d_2 \dots d_n\,,
$$
$$
\det AB = \det A \det B\,,
$$
$$
\det \lambda A = \lambda^n \det A\,.
$$

Now our task is to find all functions $f(A)$ from matrices to real numbers 
that satisfy the multiplicative property:
$$
\label{multiplicative1}
f(AB) = f(A)f(B)\,.
$$
We will use [](#multiplicative1) repeatedly in the following calculation. First
we decompose the matrix $A=HU$ using a polar decomposition, where $H$ is
Hermitian and $U$ is unitary. Both $H$ and $U$ are individually diagonalizable
(but not mutually diagonalizable, since $A$ is not in general diagonalizable).
For any matrix $C$ that is diagonalizable, we can write
$C=P D P^{-1}$ where $D$ is diagonal and $P$ is invertible. Then:
$$
f(C)
= f(P D P^{-1})
= f(P) f(D) f(P^{-1})
= f(P) f(P^{-1}) f(D)=
$$
$$
= f(P P^{-1} D)
= f(D)\,.
$$
That means that if a matrix is diagonalizable, then $f$ applied to that matrix
is equal to $f$ applied to the diagonal matrix.

Below we will use matrices $P_i$ that are unit
matrices with the 1st and $i$-th rows permuted. Now we can compute, using the
fact that $H$ and $U$ can be decomposed into diagonal matrices $D_H$ and $D_U$,
and their product is also a diagonal matrix $D=D_H D_U$:
$$
f(A)
= f(HU)
= f(H)f(U)
= f(D_H)f(D_U)
= f(D_H D_U)
= f(D) =
$$
$$
= f(\mathrm{diag}(d_1,1,1,\dots))
f(\mathrm{diag}(1,d_2,1,\dots))
\dots
f(\mathrm{diag}(1,\dots,1,d_n))=
$$
$$
= f(P_1\mathrm{diag}(d_1,1,1,\dots)P_1^{-1})
f(P_2\mathrm{diag}(d_2,1,1,\dots)P_2^{-1})
\dots
$$
$$
\dots f(P_n\mathrm{diag}(d_n,1,1,\dots)P_n^{-1})=
$$
$$
= f(\mathrm{diag}(d_1,1,1,\dots)
\mathrm{diag}(d_2,1,1,\dots)
\dots
\mathrm{diag}(d_n,1,1,\dots))=
$$
$$
= f(\mathrm{diag}(d_1 d_2 \dots d_n,1,1,\dots))=
$$
$$
= f(\mathrm{diag}(\det D,1,1,\dots))=
$$
$$
= g(\det D)= g(\det D_H D_U)
= g(\det D_H \det D_U)= g(\det H \det U) =
$$
$$
=g(\det HU) = g(\det A)\,,
$$
where we defined a function $g(x)$ using
$$
g(x) = f(\mathrm{diag}(x,1,1,\dots))\,.
$$
Let's compute the functional equation for $g(x)$:
$$
g(x y) = f(\mathrm{diag}(xy,1,1,\dots))=
$$
$$
=f(\mathrm{diag}(x,1,1,\dots)\mathrm{diag}(y,1,1,\dots))=
$$
$$
=f(\mathrm{diag}(x,1,1,\dots)) f(\mathrm{diag}(y,1,1,\dots))=
$$
$$
=g(x) g(y)\,.
$$
In the above computations we have only used [](#multiplicative1) and no other
assumptions.

Let's summarize our results. From [](#multiplicative1) it follows that:
$$
\label{multiplicative1_result}
f(A) = g(\det A)\,,
$$
$$
\label{multiplicative2}
g(xy) = g(x)g(y)\,,
$$
for numbers $x$, $y$.

The equation [](#multiplicative2) can be solved in several different ways.

Approach 1: Assuming that $f(A)$ (and thus $g(x)$) is measurable, the
multiplicative Cauchy equation is solved in
[Homomorphisms $\mathbb C^*\to\mathbb C^*$](cstar_homomorphism.md). For
real-valued functions this gives $g(x)=0$ or, on $\mathbb R^*$,
$g(x)=\operatorname{sgn}(x)^\epsilon |x|^s$ with
$\epsilon\in\{0,1\}$ and $s\in\mathbb R$. Consequently the only nonzero
solution to [](#multiplicative1) is a power of a determinant (optionally
multiplied by the signum function). Without measurability, there are also
highly pathological solutions.

Approach 2: Instead of assuming measurability, we can instead
assume homogeneity:
$$
\label{homogeneity}
f(\lambda A) = \lambda^n f(A)\,,
$$
where $n$ is the (integer) dimension of the matrix $A$.
Using [](#multiplicative1_result) and [](#multiplicative2) we get:
$$
f(\lambda A) = g(\det \lambda A)
=g(\lambda^n \det A)
=g(\lambda^n) g(\det A)
=g(\lambda^n) f(A)=
$$
$$
=g(\lambda)^n f(A)
=f(g(\lambda) A)\,.
$$
Comparing the LHS and RHS we can see that $g(\lambda)=\lambda$, or:
$$
g(x) = x
$$
and from [](#multiplicative1_result) we get:
$$
\label{multiplicative1_result2}
f(A) = \det A\,.
$$

Summary:
* Assuming equations [](#multiplicative1) and [](#homogeneity) we obtained
  [](#multiplicative1_result2) as the only nonzero solution. That means that we
  can define a determinant using [](#multiplicative1) and [](#homogeneity) and
  no other assumptions.
* Alternatively, if we only assume [](#multiplicative1) and that $f(A)$ is
  measurable, then the only nonzero solution is a power of a determinant
  (optionally multiplied with the signum function).


## Cauchy Functional Equations

The additive and multiplicative Cauchy functional equations, including the
measurable solutions needed above, are collected in
[Homomorphisms $\mathbb C^*\to\mathbb C^*$](cstar_homomorphism.md).

## Geometric Definition

The way to define a determinant using area/volume from geometry is as follows:
$$
V(\mathbf{e}_1,\mathbf{e}_2) = 1\,,
$$
$$
V(\mathbf{u},\mathbf{u}) = 0\,,
$$
for $c>0$:
$$
V(c\mathbf{u}, \mathbf{w})
= c V(\mathbf{u}, \mathbf{w}) = V(\mathbf{u},
c\mathbf{w})\,,
$$
$$
V(\mathbf{u}+\mathbf{v}, \mathbf{w})
= V(\mathbf{u}, \mathbf{w}) + V(\mathbf{v}, \mathbf{w})\,,
$$
$$
V(\mathbf{w}, \mathbf{u}+\mathbf{v})
= V(\mathbf{w}, \mathbf{u}) + V(\mathbf{w}, \mathbf{v})\,.
$$
All these formulas can be "derived" from intuitive properties of areas in 2D.
Another equivalent set of requirements is:
$$
V(\mathbf{e}_1,\mathbf{e}_2) = 1\,,
$$
$$
V(c\mathbf{u}, \mathbf{w})
= c V(\mathbf{u}, \mathbf{w}) = V(\mathbf{u},
c\mathbf{w})\,,
$$
$$
V(\mathbf{u}+\mathbf{v}, \mathbf{v})
= V(\mathbf{u}, \mathbf{v})
= V(\mathbf{u}, \mathbf{u}+\mathbf{v})\,.
$$
Let's use the first set of requirements below. We get:
$$
0 = V(\mathbf{v}-\mathbf{v}, \mathbf{w}) = V(\mathbf{v}, \mathbf{w}) + V(-\mathbf{v}, \mathbf{w})\,,
$$
from which it follows:
$$
V(-\mathbf{v}, \mathbf{w}) = -V(\mathbf{v}, \mathbf{w})\,.
$$
Now we derive antisymmetry:
$$
0
= V(\mathbf{u}+\mathbf{v}, \mathbf{u}+\mathbf{v}) =
$$
$$
= V(\mathbf{u},\mathbf{u}) + V(\mathbf{u},\mathbf{v}) + V(\mathbf{v},\mathbf{u}) + V(\mathbf{v},\mathbf{v}) = V(\mathbf{u},\mathbf{v}) + V(\mathbf{v},\mathbf{u})
$$
and we get:
$$
V(\mathbf{v},\mathbf{u}) = -V(\mathbf{u},\mathbf{v})\,.
$$
Now we derive a formula for $V$:
$$
V(\mathbf{u},\mathbf{v})
= V(u_1\mathbf{e}_1+u_2\mathbf{e}_2, v_1\mathbf{e}_1+v_2\mathbf{e}_2) =
$$
$$
= u_1v_2V(\mathbf{e}_1,\mathbf{e}_2) + u_2v_1V(\mathbf{e}_2,\mathbf{e}_1)
= (u_1v_2-u_2v_1)V(\mathbf{e}_1,\mathbf{e}_2)
= u_1v_2-u_2v_1\,.
$$
This proves both existence and uniqueness.

## Coordinate Definition

Determinant of a 2x2 matrix $(\mathbf{A})_{ij}=a_{ij}$ is defined as:
$$
\det \mathbf{A} = \epsilon^{ij} a_{1i}a_{2j}
= {1\over 2!}\epsilon^{ij}\epsilon^{kl} a_{ki}a_{lj}
$$
and for a 3x3 matrix $(\mathbf{A})_{ij}=a_{ij}$:
$$
\det \mathbf{A} = \epsilon^{ijk} a_{1i}a_{2j}a_{3k}
= {1\over 3!} \epsilon^{ijk}\epsilon^{lmn} a_{li}a_{mj}a_{nk}
$$
And so on in any dimension. The symbol $\epsilon^{ijk}$ is a Levi-Civita
symbol. All the properties of determinants are encoded in the Levi-Civita
symbol, so we need to understand it well, but the rest are just usual tensor
manipulations.

:::{note}
For the 2x2 matrix we can compute the second formula on the RHS as follows:
$$
\det \mathbf{A}
= {1\over 2!}\epsilon^{ij}\epsilon^{kl} a_{ki}a_{lj}
= {1\over 2!}\det\begin{pmatrix} \delta^{ik} & \delta^{il} \\
\delta^{jk} & \delta^{jl} \end{pmatrix} a_{ki}a_{lj} =
$$
$$
= {1\over 2!}( \delta^{ik}\delta^{jl} - \delta^{il} \delta^{jk})
a_{ki}a_{lj}
= {1\over 2!}( a_{ii}a_{jj} - a_{ji}a_{ij}) =
$$
$$
= {1\over 2!}( (a_{11}+a_{22})(a_{11}+a_{22}) - (a_{11}a_{11}+a_{12}a_{21}+a_{21}a_{12}+a_{22}a_{22})) =
$$
$$
= {1\over 2!}( 2a_{11}a_{22} - 2a_{21}a_{12})
= a_{11}a_{22} - a_{21}a_{12}\,.
$$
The first formula on the RHS is just:
$$
\det \mathbf{A}
= \epsilon^{ij} a_{1i}a_{2j}
= a_{11}a_{22}-a_{12}a_{21}\,.
$$
Both results are equivalent. It works the same way in any dimension, the
factorial factor corrects the overcounting.
:::

Let us now derive the multiplicative formula for determinants:
$$
\det\mathbf{AB} = \det\mathbf{A}\det\mathbf{B}\,.
$$
Let's show it for 2x2 matrices.
The LHS is:
$$
\det\mathbf{AB}
= \epsilon^{ij} (\mathbf{AB})_{1i}(\mathbf{AB})_{2j}
= \epsilon^{ij} (a_1{}^k b_{ki}) (a_2{}^l b_{lj})\,.
$$
The RHS is:
$$
\det\mathbf{A}\det\mathbf{B}
= \epsilon^{ij} a_{1i}a_{2j} \epsilon^{kl} b_{1k}b_{2l}=
$$
$$
= (\delta^{ik}\delta^{jl} - \delta^{il}\delta^{jk}) a_{1i}a_{2j} b_{1k}b_{2l}=
$$
$$
= a_{1i}a_{2j} b_1{}^i b_2{}^j - a_{1i}a_{2j} b_1{}^j b_2{}^i =
$$
$$
= a_{1i}a_{2j} (b_1{}^i b_2{}^j - b_1{}^j b_2{}^i) =
$$
$$
= \epsilon^{kl}a_{1i}a_{2j} b_k{}^i b_l{}^j =
$$
$$
= \epsilon^{kl}a_{1i} b_k{}^i a_{2j} b_l{}^j =
$$
$$
= \epsilon^{ij}a_{1k} b_i{}^k a_{2l} b_j{}^l =
$$
$$
= \epsilon^{ij}a_1{}^k b_{ik} a_2{}^l b_{jl} =
$$
$$
=\det\mathbf{AB}^T\,.
$$
Now we need to prove $\det\mathbf{A}^T = \det\mathbf{A}$. We can do that using
the factorial formula by relabeling indices as follows:
$$
\det\mathbf{A}^T
= {1\over 2!}\epsilon^{ij}\epsilon^{kl} a_{ik}a_{jl}
= {1\over 2!}\epsilon^{kl}\epsilon^{ij} a_{ki}a_{lj}
= {1\over 2!}\epsilon^{ij}\epsilon^{kl} a_{ki}a_{lj}
= \det\mathbf{A}\,.
$$
We have thus shown:
$$\det\mathbf{AB}
=\det\mathbf{A}\det\mathbf{B}^T
=\det\mathbf{A}\det\mathbf{B}\,.
$$

### Alternative Proof

First we need the following identity:
$$
\det({\mathbf A}) \epsilon_{ij}
= \epsilon^{kl} a_{1k}a_{2l} \epsilon_{ij}
= \det\begin{pmatrix}
\delta_i{}^{k} & \delta_i{}^{l} \\
\delta_j{}^{k} & \delta_j{}^{l} \end{pmatrix} a_{1k}a_{2l}
= \det\begin{pmatrix}
a_{1i} & a_{2i} \\
a_{1j} & a_{2j} \end{pmatrix}
= \epsilon^{kl} a_{ki} a_{lj}\,.
$$

:::{note}
The final step above follows from using the definition of a determinant as
follows:
$$
\det(\mathbf{X})
= \det\begin{pmatrix}
a_{1i} & a_{2i} \\
a_{1j} & a_{2j} \end{pmatrix}
=\epsilon^{kl} \mathbf{X}_{1k} \mathbf{X}_{2l}\,.
$$
Now $\mathbf{X}_{11}=a_{1i}$ and $\mathbf{X}_{12}=a_{2i}$, so
$\mathbf{X}_{1k}=a_{ki}$. Similarly $\mathbf{X}_{2l}=a_{lj}$, so we get:
$$
=\epsilon^{kl} a_{ki} a_{lj}\,.
$$
Alternatively, one can simply expand the determinant as follows:
$$
\det\begin{pmatrix}
a_{1i} & a_{2i} \\
a_{1j} & a_{2j} \end{pmatrix}
= a_{1i} a_{2j} - a_{2i} a_{1j}
=\epsilon^{kl} a_{ki} a_{lj}\,.
$$
:::

Contracting both sides with $\epsilon^{ij}$ we get:
$$
\det({\mathbf A}) \epsilon_{ij} \epsilon^{ij}
=\epsilon^{ij}\epsilon^{kl} a_{ki} a_{lj}\,,
$$
$$
\det({\mathbf A})\, 2!
=\epsilon^{ij}\epsilon^{kl} a_{ki} a_{lj}\,,
$$
$$
\det({\mathbf A})
={1\over2!}\epsilon^{ij}\epsilon^{kl} a_{ki} a_{lj}\,.
$$
Note that $\epsilon^{kl} a_{ki} a_{lj} = \epsilon^{kl} a_{ik} a_{jl}$ due to
the transposition property derived using the last equation in the previous
section:
$$
\det({\mathbf A}) \epsilon_{ij}
= \epsilon^{kl} a_{ki} a_{lj}
= \det({\mathbf A}^T) \epsilon_{ij}
= \epsilon^{kl} a_{ik} a_{jl}\,.
$$
Now we can compute:
$$
\det(\mathbf{AB})
= \epsilon^{ij} (\mathbf{AB})_{1i} (\mathbf{AB})_{2j}
= \epsilon^{ij} (a_1{}^{k}b_{ki}) (a_2{}^{l}b_{lj})
= a_1{}^{k} a_2{}^{l} (\epsilon^{ij} b_{ki} b_{lj}) =
$$
$$
= a_1{}^{k} a_2{}^{l} (\epsilon^{ij} b_{ik} b_{jl})
= a_1{}^{k} a_2{}^{l} \det(\mathbf{B}) \epsilon_{kl}
= (\epsilon^{kl} a_{1k} a_{2l}) \det(\mathbf{B})
= \det(\mathbf{A}) \det(\mathbf{B})\,.
$$
