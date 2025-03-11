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
g = \{X: \exp(t X) \in G \quad \forall t \in \mathbb{R}\}\,.
$$
The following can be proven:
1. $g$ is a vector space
2. $X, Y \in g \Rightarrow [X, Y] \in g$
3. $g$ is the tangent space to $G$ at $I$.
4. $\exp: g \rightarrow G$ is locally invertible

### Examples

In each case we have two equivalent approaches:

1. We can start from the definition of the Lie group itself, for example the
   orghogonal Lie group O(n) is defined as all transformations that leave the
   Euclidean metric invariant. Then we derive the Lie algebra and the
   commutation relations.
2. Or we start from the Lie algebra, defined using the commutation relations,
   and we derive the Lie group from it.

The first approach is in some ways simpler, but it requires to assume what
metric we are preserving. The second approach is more work to derive
everything, but it has less assumptions, the only assumption is how many
generators there are and their commutation relations. From that we derive the
Lie group and what metric it leaves invariant.

#### O(n)

The orthogonal Lie group can be defined as:
$$
\mathrm{O}(n) = \{X: X^T X = 1\}\,.
$$
To find the Lie algebra, we write $X = \exp(t x)$ and get:
$$
(\exp(tx))^T \exp(tx) = 1\,,
$$
$$
\exp(tx^T) \exp(tx) = 1\,,
$$
$$
\exp(tx^T + tx) = 1\,,
$$
$$
\exp(t(x^T + x)) = 1\,,
$$
which is equivalent to:
$$
t(x^T + x) = 0\,,
$$
$$
x^T + x = 0\,.
$$
The corresponding Lie algebra is thus all antisymmetric matrices
$n \times n$:
$$
\mathfrak{o}(n) = \{X: X^T = -X\}\,.
$$

#### SL(2, C)

The special linear Lie group can be defined as $2\times2$ matrices:
$$
\mathrm{SL}(2,\mathbb{C}) = \{X: \det X = 1\}\,.
$$
To find the Lie algebra, we use:
$$
\det\exp x = \exp \mathrm{Tr}\,x\,.
$$
We write $X = \exp(t x)$ and get:
$$
1 = \det X = \det\exp(t x)=\exp\mathrm{Tr}\, tx=\exp (t\,\mathrm{Tr}\, x)\,,
$$
that is equivalent to:
$$
t\,\mathrm{Tr}\, x = 0\,,
$$
$$
\mathrm{Tr}\, x = 0\,.
$$
The corresponding Lie algebra is thus all $n \times n$ matrices with zero trace:
$$
\mathfrak{sl}(2,\mathbb{C}) = \{x: \mathrm{Tr}(x) = 0\}\,.
$$
One can choose a basis of this space as:
$$
H = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}\,,
$$
$$
X = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix}\,,
$$
$$
Y = \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}\,.
$$

The Lie brackets are:
$$
[H, X] = 2X\,,
$$
$$
[H, Y] = -2Y\,,
$$
$$
[X, Y] = H\,.
$$

#### SU(2, C)

The special unitary Lie group can be defined as $2\times2$ unitary matrices
with determinant 1:
$$
\mathrm{SU}(2,\mathbb{C}) = \{X: X^\dagger X = 1, \quad \det X = 1\}\,.
$$
Using the above derivations, the corresponding Lie algebra is
all $2 \times 2$ skew-Hermitian matrices with trace zero:
$$
\mathfrak{su}(2,\mathbb{C}) = \{X: X^H=-X, \quad \mathrm{Tr}(X) = 0\}\,.
$$
One can choose a basis of this space as:
$$
u_1 = +i\sigma_1 = \begin{pmatrix} 0 & i \\ i & 0 \end{pmatrix}\,,
$$
$$
u_2 = -i\sigma_2 = \begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}\,,
$$
$$
u_3 = +i\sigma_3 = \begin{pmatrix} i & 0 \\ 0 & -i \end{pmatrix}\,.
$$
The matrices are a representation of quaternions.

The Lie brackets are:
$$
[u_1, u_2] = 2u_3\,,
$$
$$
[u_2, u_3] = 2u_1\,,
$$
$$
[u_3, u_1] = 2u_2\,.
$$

One can pass to the complexified Lie algebra:
$$
\mathfrak{su}(2,\mathbb{C}) + i\,\mathfrak{su}(2,\mathbb{C})=
\mathfrak{sl}(2,\mathbb{C})\,.
$$
The complexified Lie algebra is spanned by three elements X, Y, H:
$$
H = {1\over i} u_3 = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}\,,
$$
$$
X = {1\over 2i}(u_1-i u_2) = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix}\,,
$$
$$
Y = {1\over 2i}(u_1+i u_2) =\begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}\,.
$$

The Lie brackets are:
$$
[H, X] = 2X\,,
$$
$$
[H, Y] = -2Y\,,
$$
$$
[X, Y] = H\,.
$$

#### Computing $\exp(\theta J_3) P_1 \exp(-\theta J_3)$

Where $J_i$ are generators of the SO(3) group and $P_1$ are generators of the
translation group. We do not know their matrices, we only know their
commutators. We use the formula above with
$t = \theta$, $X=J_3$ and $Y=P_1$:

$$
e^{\theta J_3} P_1 e^{-\theta J_3} = P_1
+ {1\over 1!} [J_3,P_1] \theta
+ {1\over 2!} [J_3,[J_3,P_1]] \theta^2
+ {1\over 3!} [J_3,[J_3,[J_3,P_1]]] \theta^3
+ \cdots\,.
$$

We need to compute the commutators. The Lie algebra commutator is:
$$
[J_i, P_j] = \epsilon_{ijk} P_k\,.
$$
So:
$$
[J_3, P_1] = \epsilon_{312} P_2 = P_2\,,
$$
$$
[J_3, [J_3, P_1]] = [J_3, P_2] = \epsilon_{321} P_1 = -P_1\,,
$$
$$
[J_3, [J_3, [J_3, P_1]]] = [J_3, -P_1] = -\epsilon_{312} P_2 = -P_2\,.
$$
And higher terms repeat. The commutators alternate between $P_2$ and $P_1$ and
their signs:

$$
e^{\theta J_3} P_1 e^{-\theta J_3} = P_1
+ {1\over 1!} P_2 \theta
+ {1\over 2!} (-P_1) \theta^2
+ {1\over 3!} (-P_2) \theta^3
+ {1\over 4!} P_1 \theta^4
+ {1\over 5!} P_2 \theta^5
+ \cdots =
$$
$$
= P_1 (1 - {1\over 2!} \theta^2 + {1\over 4!} \theta^4 + \cdots)
+ P_2 ({1\over 1!} \theta - {1\over 3!} \theta^3 + {1\over 5!} \theta^5 + \cdots) =
$$
$$
= P_1 \cos(\theta) + P_2 \sin(\theta)\,.
$$

Any vector operator has the same Lie bracket, for example for $J_i$ we have
$[J_i, J_j] = \epsilon_{ijk} J_k$ and obtain:
$$
e^{\theta J_3} J_1 e^{-\theta J_3} = J_1 \cos(\theta) + J_2 \sin(\theta)\,.
$$
