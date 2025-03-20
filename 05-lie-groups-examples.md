---
date: 2025-03-19
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
# Lie Groups III Examples

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

# Examples

## O(n)

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
Taking a determinant of $X^T X = 1$ we get:
$$
1 = \det(X^T X) = \det(X^T)\det(X) = \det(X)\det(X) = \det(X)^2\,,
$$
$$
\det(X) = \pm 1\,.
$$
The group thus has two connected components:
$$
\mathrm{O}(n) \cong \{-1, 1\} \times \mathrm{SO}(n)\,.
$$
Where the special orthogonal group SO(n) is:
$$
\mathrm{SO}(n) = \{X: X^T X = 1,\quad \det X = 1\}\,.
$$

## O(3)

$$
\mathrm{O}(3) \cong \{-1, 1\} \times \mathrm{SO}(3)\,.
$$

$$
\mathrm{O}(3)/\{I,−I\} \cong \mathrm{SO}(3)
$$

## SO(3)

$$
\mathrm{SO}(3) = \{X: X^T X = 1,\quad \det X = 1\}\,.
$$
$$
\mathfrak{so}(3) = \{x: x^T = -x\}\,.
$$
The $\mathfrak{so}(3)$ matrices thus look like:

$$
x =
\begin{pmatrix}
    0     &  \theta_3 & -\theta_2 \\
-\theta_3 &     0     &  \theta_1 \\
 \theta_2 & -\theta_1 &     0
\end{pmatrix} = \theta_1 J_1 + \theta_2 J_2 + \theta_3 J_3\,,
$$
where we have three generators $J_i$ for $i=1, 2, 3$:

$$
J_1 =
\begin{pmatrix}
 0 &  0 & 0 \\
 0 &  0 & 1 \\
 0 & -1 & 0
\end{pmatrix}\,.
$$
$$
J_2 =
\begin{pmatrix}
 0 & 0 & -1 \\
 0 & 0 &  0 \\
 1 & 0 &  0
\end{pmatrix}\,,
$$
$$
J_3 =
\begin{pmatrix}
 0 & 1 & 0 \\
-1 & 0 & 0 \\
 0 & 0 & 0
\end{pmatrix}\,,
$$

The matrices $J_i$ form a basis of the $\mathfrak{so}(3)$ vector space and they
satisfy the following commutation relations (Lie bracket):
$$
[J_i, J_j]=\epsilon_{ijk} J_k\,.
$$

The general element $X$ of the Lie group is:
$$
X = \exp x = \exp (\theta_1 J_1 + \theta_2 J_2 + \theta_3
J_3)\,.
$$

:::{note}
We can also write every element $X$ as:
$$
X = \exp (\theta_1' J_1)\exp(\theta_2' J_2)\exp(\theta_3' J_3)\,.
$$
That is a different parametrization and one can compute the relation between
$\theta_i$ and $\theta_i'$. One can convert one to the other using the BCH
formula.
:::

:::{note}
Note that $X = \exp tx$, but since $x$ is a vector space, then if $x$ belongs
to it, so does $tx$, so we can just write $X = \exp x$.
:::

:::{note}
We can change the basis, for example $J_z=J_3$,
$J_\pm={1\over2}(J_1\pm i J_2)$, then we obtain different Lie brackets:
$$
[J_z, J_+] = J_+\,,
$$
$$
[J_z, J_-] = -J_-\,,
$$
$$
[J_+, J_-] = 2J_z\,.
$$
But the Lie algebras are equivalent.
:::

:::{note}
Every Lie bracket is always equal to a linear combination of all the
generators, e.g.:
$$
[J_1, J_2] = \alpha J_1 + \beta J_2 + \gamma J_3\,,
$$
because the Lie bracket lies in the same vector space and the generators form a
basis. In the above example we get $\alpha=\beta=0$ and $\gamma=1$. In general
we always have:
$$
[J_i, J_j] = f_{ij}{}^k J_k\,,
$$
where $f_{ij}{}^k$ are called the structure constants that define the Lie
algebra.
:::

The structure constants are $C_{ij}{}^k = \epsilon_{ij}{}^k$. The metric tensor
is:
$$
g_{ij} = C_{ik}{}^l C_{jl}{}^k = \epsilon_{ik}{}^l \epsilon_{jl}{}^k = 
-2 \delta_{ij}\,.
$$
:::{warning} TODO
The metric tensor might be defined with a minus sign.
:::
We have:
$$
\det g_{ij} = 8 \neq 0
$$
So the SO(3) group is semisimple.

## Translation-Rotation Group

The group of all translations $T$ and rotations $R$ has six generators $P_1$,
$P_2$, $P_3$, $J_1$, $J_2$, $J_3$. The translations $P_i$ are an abelian
subgroup. We have for every $T$ and every element $R$:
$$
R T R^{-1} = T'
$$
So $T$ is an *invariant subgroup*. Furthermore for all $T$ and $T'$ we have:
$$
[T, T'] = 0
$$
So $T$ is *abelian invariant subgroup*.

The commutation relations of the generators:
$$
[J_i, J_j] = \epsilon_{ijk} J_k\,,
$$
$$
[J_i, P_j] = \epsilon_{ijk} P_k\,,
$$
$$
[P_i, P_j] = 0\,.
$$

## SL(2, C)

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

## SU(2, C)

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

We have $\{I,−I\}$ as the center of the SU(2) group and:
$$
\mathrm{SU}(2)/\{I,−I\} \cong \mathrm{SO}(3)
$$

# Utilities

## Computing $\exp(\theta J_3) P_1 \exp(-\theta J_3)$

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
