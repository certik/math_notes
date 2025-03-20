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

# Adjoint Representation and Campbell Identity

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

This last equation is called the Campbell identity.

## Lie Algebra

Lie algebra $g$ for a Lie group $G$ that is a topologically closed subgroup of
GL(n, R) is defined by:
$$
g = \{X: \exp(t X) \in G \quad \forall t \in \mathbb{R}\}\,.
$$
The following can be proven:
1. $g$ is a vector space
2. $X, Y \in g \Rightarrow [X, Y] \in g$
3. $g$ is the tangent space to $G$ at $I$.
4. $\exp: g \rightarrow G$ is locally invertible

*Invariant subgroup* $a$ of a group $g$: for every $a$ and
$g$ the following holds:
$$
g a g^{-1} = a'\,,
$$
where $a'$ is a member of $a$.

*Invariant abelian subgroup*: is an invariant subgroup that is abelian: $a a' =
a' a$, or $[a, a'] = 0$.

Lie group is:

* *simple* if it does not posses an invariant Lie subgroup.
* *semisimple* if it does not posses an abelian invariant Lie subgroup.

Typical examples of semisimple groups are the direct products of simple groups.

Using the structure constants $[L_i, L_j] = C_{ij}{}^k L_k$ we can define a
*metric tensor* (also called *Killing form*):
$$
g_{ij} = g_{ji} = C_{ik}{}^l C_{jl}{}^k\,.
$$
The regular representation is:
$$
(L_i)_{j}{}^k = C_{ij}{}^k\,.
$$
From this it follows:
$$
g_{ij} = C_{ik}{}^l C_{jl}{}^k = (L_i)_{k}{}^l (L_j)_{l}{}^k
= \mathrm{Tr} (L_i, L_j) \equiv (L_i, L_j)\,.
$$
This fulfills all properties of a metric, e.g.:
$$
(L_i,L_j) = (L_j, L_i)\,,
$$
$$
(L_i+L_j,L_k) = (L_i, L_k) + (L_j, L_k)\,,
$$
but it is not necessarily positive definite (i.e., $(L_i, L_i) > 0$).

Theorem: a Lie algebra is semisimple if and only if $\det g_{ij} \neq 0$.

The center of a group G is a set of elements that commute with every element of
G:

$$
Z(G) = \{z ∈ G \quad | \quad  ∀g ∈ G, \quad zg = gz\}\,.
$$

The center is a normal subgroup of G, so the quotient $G / Z(G)$ is a group.

To construct every other connected Lie group with the same Lie algebra su(2) as
SU(2), such as SO(3), we take quotients of SU(2) by discrete subgroups of its
center $Z(SU(2))=\{I,−I\}$. The possible quotients are:

$$
SU(2)/\{I\}≅SU(2),
$$
$$
SU(2)/\{I,−I\}≅SO(3).
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
