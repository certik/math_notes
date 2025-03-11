---
date: 2025-03-09
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
# Lie Groups II

## Adjoint Representation

We define $\mathrm{Ad}_{X}(Y)$ by:

$$ \mathrm{Ad}_{X}(Y) = X Y X^{-1} $$

and define a matrix function $f(t)$ by:

$$ f(t) = \mathrm{Ad}_{e^{tX}}(Y) = e^{tX} Y e^{-tX}\,. $$

Differentiate $f(t)$:

$$
f'(t) = {d\over d t} \mathrm{Ad}_{e^{tX}}(Y)
= {d\over d t} e^{tX} Y e^{-tX} =
$$

$$
= X e^{tX} Y e^{-tX} - e^{tX} Y X e^{-tX} =
$$

$$
= e^{tX} X Y e^{-tX} - e^{tX} Y X e^{-tX} =
$$

$$
= e^{tX} (XY - YX) e^{-tX} =
$$

$$
= e^{tX} [X, Y] e^{-tX}\,.
$$

We apply it recursively for the second derivative:

$$
f''(t) = {d^2\over d t^2} \mathrm{Ad}_{e^{tX}}(Y)
= {d^2\over d t^2} e^{tX} Y e^{-tX} =
$$

$$
= {d\over d t} e^{tX} [X, Y] e^{-tX} =
$$

$$
= e^{tX} [X, [X, Y]] e^{-tX}\,. 
$$

We evaluate these derivatives at $t=0$:
$$
f(0)=Y\,,
$$
$$
f'(0)=[X, Y]\,,
$$
$$
f''(0)=[X, [X, Y]]\,.
$$

We expand $f(t)$ using a Taylor series around the point $t=0$:

$$
f(t)= f(0)
+ {1\over 1!}f'(0) t
+ {1\over 2!}f''(0) t^2
+ {1\over 3!}f'''(0) t^3
+ \cdots
$$
and we get:

$$
f(t) = e^{tX} Y e^{-tX} = Y
+ {1\over 1!} [X,Y] t
+ {1\over 2!} [X,[X,Y]] t^2
+ {1\over 3!} [X,[X,[X,Y]]] t^3
+ \cdots
$$

We can set $t=1$:

$$
f(1) = e^{X} Y e^{-X} = Y
+ {1\over 1!} [X,Y]
+ {1\over 2!} [X,[X,Y]]
+ {1\over 3!} [X,[X,[X,Y]]]
+ \cdots
$$

## Lie Algebra

Lie algebra for a Lie group that is a topologically closed subgroup of GL(n,
R) is defined by:
$$
g = \{X: \exp(t X) \in G \quad \forall t \in \mathbb{R}\}
$$
The following can be proven:
1. $g$ is a vector space
2. $X, Y \in g \Rightarrow [X, Y] \in g$
3. $g$ is the tangent space to $G$ at $I$.
4. $\exp: g \rightarrow G$ is locally invertible

### Examples

#### O(n)

The orthogonal Lie group can be defined as:
$$
\mathrm{O}(n) = \{X: X^T X = 1\}
$$
The corresponding Lie algebra can be shown to be all antisymmetric matrices $n
\times n$:
$$
\mathfrak{o}(n) = \{X: X^T = -X\}
$$

#### SL(2, C)

The special linear Lie group can be defined as $2\times2$ matrices:
$$
\mathrm{SL}(2,\mathbb{C}) = \{X: \det X = 1\}
$$
The corresponding Lie algebra can be shown to be all antisymmetric matrices $n
\times n$:
$$
\mathfrak{sl}(2,\mathbb{C}) = \{X: \mathrm{Tr}(X) = 0\}
$$
One can choose a basis of this space as:
$$
H = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}
$$
$$
X = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix}
$$
$$
Y = \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}
$$

The Lie brackets are:
$$
[H, X] = 2X
$$
$$
[H, Y] = -2Y
$$
$$
[X, Y] = H
$$

#### SU(2, C)

The special unitary Lie group can be defined as $2\times2$ unitary matrices
with determinant 1:
$$
\mathrm{SU}(2,\mathbb{C}) = \{X: X^\dagger X = 1, \quad \det X = 1\}
$$
The corresponding Lie algebra can be shown to be all skew-Hermitian matrices
$2 \times 2$ with trace zero:
$$
\mathfrak{su}(2,\mathbb{C}) = \{X: X^H=-X, \quad \mathrm{Tr}(X) = 0\}
$$
One can choose a basis of this space as:
$$
u_1 = +i\sigma_1 = \begin{pmatrix} 0 & i \\ i & 0 \end{pmatrix}
$$
$$
u_2 = -i\sigma_2 = \begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}
$$
$$
u_3 = +i\sigma_3 = \begin{pmatrix} i & 0 \\ 0 & -i \end{pmatrix}
$$
The matrices are a representation of quaternions.

The Lie brackets are:
$$
[u_1, u_2] = 2u_3
$$
$$
[u_2, u_3] = 2u_1
$$
$$
[u_3, u_1] = 2u_2
$$

One can pass to the complexified Lie algebra:
$$
\mathfrak{su}(2,\mathbb{C}) + i\,\mathfrak{su}(2,\mathbb{C})=
\mathfrak{sl}(2,\mathbb{C})
$$
The complexified Lie algebra is spanned by three elements X, Y, H:
$$
H = {1\over i} u_3 = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}
$$
$$
X = {1\over 2i}(u_1-i u_2) = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix}
$$
$$
Y = {1\over 2i}(u_1+i u_2) =\begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}
$$

The Lie brackets are:
$$
[H, X] = 2X
$$
$$
[H, Y] = -2Y
$$
$$
[X, Y] = H
$$
