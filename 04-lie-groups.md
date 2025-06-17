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

This last equation is called the Campbell identity. We can also write it as:

$$
e^{-X} Y e^{X} = Y
+ {1\over 1!} [-X,Y]
+ {1\over 2!} [-X,[-X,Y]]
+ {1\over 3!} [-X,[-X,[-X,Y]]]
+ \cdots =
$$
$$
= Y
+ {1\over 1!} [Y,X]
+ {1\over 2!} [[Y,X],X]
+ {1\over 3!} [[[Y,X],X],X]
+ \cdots
$$

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

## Computing $\exp(\theta J_3) P_2 \exp(-\theta J_3)$

Similarly, let's compute:

$$
e^{\theta J_3} P_2 e^{-\theta J_3} = P_2
+ {1\over 1!} [J_3,P_2] \theta
+ {1\over 2!} [J_3,[J_3,P_2]] \theta^2
+ {1\over 3!} [J_3,[J_3,[J_3,P_2]]] \theta^3
+ \cdots =
$$

$$
= P_2
+ {1\over 1!} (-P_1) \theta
+ {1\over 2!} (-P_2) \theta^2
+ {1\over 3!} P_1 \theta^3
+ {1\over 4!} P_2 \theta^4
+ {1\over 5!} (-P_1) \theta^5
+ \cdots =
$$
$$
= P_1 \left(-{\theta\over 1!} + {\theta^3\over 3!} - {\theta^5\over 5!} + \cdots\right)
+ P_2 \left(1 - {\theta^2\over 2!} + {\theta^4\over 4!} + \cdots \right) =
$$
$$
= -P_1 \sin(\theta) + P_2 \cos(\theta)\,.
$$

## Computing $\exp(\theta J_3) P_3 \exp(-\theta J_3)$

Finally:

$$
e^{\theta J_3} P_3 e^{-\theta J_3} = P_3
+ {1\over 1!} [J_3,P_3] \theta
+ {1\over 2!} [J_3,[J_3,P_3]] \theta^2
+ \cdots = P_3\,,
$$
since all the commutators are zero.

## Summary

We have thus shown that for any operator satisfying
$[J_i, P_j] = \epsilon_{ijk} P_k$ we get:

$$
\begin{aligned}
e^{\theta J_3} P_1 e^{-\theta J_3} &= P_1 \cos(\theta) + P_2 \sin(\theta)\,, \\
e^{\theta J_3} P_2 e^{-\theta J_3} &= -P_1 \sin(\theta) + P_2 \cos(\theta)\,, \\
e^{\theta J_3} P_3 e^{-\theta J_3} &= P_3\,.
\end{aligned}
$$

We can thus write these as a single equation in index notation:

$$
e^{\theta J_3} P_j e^{-\theta J_3}
=(R_3)^i{}_j P_i\,,
$$

where the matrix $(R_3)^i{}_j$ is a rotation around the $z$-axis:

$$
(R_3(\theta))^i{}_j
=\begin{pmatrix}
 \cos \theta &-\sin \theta & 0 \\
 \sin \theta & \cos \theta & 0 \\
 0      & 0      & 1 \\ 
\end{pmatrix}\,.
$$

We are interested in computing ${\bf a} \cdot {\bf P} = a^j P_j$:

$$
e^{\theta J_3} a^j P_j e^{-\theta J_3}
=(R_3)^i{}_j a^j P_i
$$

and using the below indentity:

$$
e^{\theta J_3} e^{a^j P_j} e^{-\theta J_3}
=e^{e^{\theta J_3} a^j P_j e^{-\theta J_3}}
=e^{(R_3)^i{}_j a^j P_i}\,,
$$

or:

$$
e^{\theta J_3} T({\bf a}) e^{-\theta J_3} =T(R_3(\theta) {\bf a})\,.
$$

In an analogous way we can obtain:

$$
e^{\theta J_1} T({\bf a}) e^{-\theta J_1} =T(R_1(\theta) {\bf a})\,,
$$

$$
e^{\theta J_2} T({\bf a}) e^{-\theta J_2} =T(R_2(\theta) {\bf a})\,.
$$

Putting it all together we get:

$$
e^{\theta_1 J_1} e^{\theta_2 J_2} e^{\theta_3 J_3}
T({\bf a})
e^{-\theta_3 J_3} e^{-\theta_2 J_2} e^{-\theta_1 J_1}=
$$
$$
= e^{\theta_1 J_1} e^{\theta_2 J_2}
T(R_3(\theta_3) {\bf a})
e^{-\theta_2 J_2} e^{-\theta_1 J_1}=
$$
$$
= e^{\theta_1 J_1} T(R_2(\theta_2) R_3(\theta_3) {\bf a}) e^{-\theta_1 J_1}
$$
$$
= T(R_1(\theta_1) R_2(\theta_2) R_3(\theta_3) {\bf a}) \,.
$$

In other words, we can see how a general element of the rotation group
$e^{\theta_1 J_1} e^{\theta_2 J_2} e^{\theta_3 J_3}$ acts on a general element
of the translation group $T({\bf a})$. The result is another translation
$T(R_1(\theta_1) R_2(\theta_2) R_3(\theta_3) {\bf a})$ and the translation
vector ${\bf a}$ gets rotated with the three rotation matrices
${\bf a} \rightarrow R_1(\theta_1) R_2(\theta_2) R_3(\theta_3) {\bf a}$.

## For T=J

As a special case, we'll use $P_i = J_i$, and we'll use $\bf n$ instead of $\bf
a$:

$$
e^{\theta J_3} n^j J_j e^{-\theta J_3}
=(R_3)^i{}_j n^j J_i
$$

In an analogous way we can obtain:

$$
e^{\theta J_1} n^j J_j e^{-\theta J_1}
=(R_1)^i{}_j n^j J_i
$$
$$
e^{\theta J_2} n^j J_j e^{-\theta J_2}
=(R_2)^i{}_j n^j J_i
$$

Putting it all together we get:

$$
e^{\theta_1 J_1} e^{\theta_2 J_2} e^{\theta_3 J_3}
n^j J_j
e^{-\theta_3 J_3} e^{-\theta_2 J_2} e^{-\theta_1 J_1}=
$$
$$
= e^{\theta_1 J_1} e^{\theta_2 J_2}
(R_3)^i{}_j n^j J_i
e^{-\theta_2 J_2} e^{-\theta_1 J_1}=
$$
$$
= e^{\theta_1 J_1}
(R_2)^i{}_j (R_3)^j{}_k n^k J_i
e^{-\theta_1 J_1} =
$$
$$
= (R_1)^i{}_j (R_2)^j{}_k (R_3)^k{}_l n^l J_i \,.
$$

This shows how to "encode" the 3D vector $\bf n$ into any $j$ representation.
The RHS is encoding the rotated vector, the LHS is encoding the original vector
and then transforming it using the "sandwich" formula. Thus showing that the
"sandwich" transformation is equivalent to a rotation. It is thus showing how
any SU(2) transformation corresponds to SO(3) transformation, the "minus"
cancels out in the sandwich, so 360 degree rotation transforms $\bf n$ into
itself. To obtain the 360 rotation equal to -1 we need to act with just the
left part of the sandwich on some "spinor", and it would transform it to -1.

Thus we have proven:

$$
U(\theta_1, \theta_2, \theta_3)
\ {\bf a} \cdot {\bf J}\ 
U(\theta_1, \theta_2, \theta_3)^{-1}
=
(R(\theta_1, \theta_2, \theta_3) {\bf a}) \cdot {\bf J}\,,
$$

where:

$$
U(\theta_1, \theta_2, \theta_3)
=e^{\theta_1 J_1} e^{\theta_2 J_2} e^{\theta_3 J_3}\,,
$$
$$
R(\theta_1, \theta_2, \theta_3)
= R_1(\theta_1) R_2(\theta_2) R_3(\theta_3) \,.
$$

Now we would like to show for spin $j={1\over2}$ that:

$$
U(\theta_1, \theta_2, \theta_3)
=e^{i\theta_1 \sigma_1} e^{i\theta_2 \sigma_2} e^{i\theta_3 \sigma_3}
=U({\bf n}, \theta) = e^{-i {\theta\over2}\left({\bf n}\cdot {\bf\sigma} \right)}
$$

Where ${\bf n}$ is a unit vector representing the axis of rotation and $\theta$
is the rotation around this axis.

I think our $J_i = i \sigma_i$, but somehow it can be shown that we can combine
the exponentials. We also want to prove that the three rotation matrices can be
written as just one matrix:

$$
R(\theta_1, \theta_2, \theta_3)
= R_1(\theta_1) R_2(\theta_2) R_3(\theta_3)
= R({\bf n}, \theta)\,.
$$

Then we get:

$$
U({\bf n}, \theta)
\ {\bf a} \cdot {\bf \sigma}\ 
U({\bf n}, \theta)^{-1}
=
(R({\bf n}, \theta) {\bf a}) \cdot {\bf \sigma}\,,
$$

Here $U$ can be expanded as:

$$
U({\bf n}, \theta) = e^{-i {\theta\over2}\left({\bf n}\cdot {\bf\sigma} \right)}
= \cos\left({\theta\over 2}\right) - i \sin\left({\theta\over2}\right) \left({\bf n}\cdot {\bf\sigma} \right)\,.
$$

We can now identify this relation with quaternions as follows:

$$
U({\bf n}, \theta)
= \cos\left({\theta\over 2}\right) + \sin\left({\theta\over2}\right)
\left(n^1 (-i\sigma_1) + n^2 (-i\sigma_2) + n^3 (-i\sigma_3) \right)\,,
$$
$$
q
= \cos\left({\theta\over 2}\right) + \sin\left({\theta\over2}\right)
\left(n^1 i + n^2 j + n^3 k \right)\,.
$$

And the rotation equation is:

$$
q (a^1 i + a^2 j + a^3 k) q^{-1} = (R(q){\bf a}) \cdot (i, j, k)
$$

In other words, the LHS is encoding the vector ${\bf a}$ into a quaternion as
$a^1 i + a^2 j + a^3 k$, and the RHS gives us the rotated quaternion vector
that we can decode back.


## Identity $g e^X g^{-1} = e^{g X g^{-1}}$


The identity
$$
g e^X g^{-1} = e^{g X g^{-1}}
$$
can be proven using:
$$
g e^X g^{-1}=g \left( \sum_{n=0}^\infty {X^n\over n!} \right) g^{-1}
=\sum_{n=0}^\infty {g X^n g^{-1} \over n!}
=\sum_{n=0}^\infty {(g X g^{-1})^n \over n!}
=e^{g X g^{-1}}\,.
$$

## Computing $\exp(\theta_3 J_3) \exp(\theta_1 P_1) \exp(-\theta_3 J_3)$

Using the identity $g e^X g^{-1} = e^{g X g^{-1}}$ we get:
$$
e^{\theta_3 J_3} e^{\theta_1 P_1} e^{-\theta_3 J_3}
=\exp\left(e^{\theta_3 J_3} (\theta_1 P_1) e^{-\theta_3 J_3}\right)
=e^{\theta_1 \left(P_1 \cos\theta_3 + P_2 \sin\theta_3\right)} \,.
$$

## Rodrigues' Rotation Formula

If $\mathbf{v}$ is a vector in R^3 and $\mathbf{k}$ is a unit vector (axis of
rotation) and $\theta$ the angle of rotation, then the vector $\mathbf{v}$ gets
rotated to $\mathbf{v}_\mathrm{rot}$.

We define a matrix $\mathbf{K}$ using:

$$
\mathbf{K}_{ij} = -\epsilon_{ijk} k^k
= \begin{pmatrix}
  0  & -k^3 &  k^2 \\
 k^3 &   0  & -k^1 \\
-k^2 &  k^1 &   0
\end{pmatrix}
$$

Note that $|\mathbf{k}|^2 = k_1^2 + k_2^2 + k_3^3 = 1$. We get:

$$
(\mathbf{K}\mathbf{v})_i
=\mathbf{K}_{ij} v^j
= -\epsilon_{ijk} k^k v^j
= \epsilon_{ikj} k^k v^j
= (\mathbf{k}\times\mathbf{v})_i\,.
$$

We will also need:

$$
\left(\mathbf{K}^2\right)_{ij}
=K_i{}^k K_{kj}
=(-\epsilon_i{}^k{}_l\, k^l)(-\epsilon_{kjm} k^m)
=(\delta_{jl} \delta_{mi}-\delta_{ji}\delta_{ml}) k^l k^m
=k_i k_j - \delta_{ij}\,,
$$
where we used $\delta_{ml}k^l k^m=1$.

Now we compute the characteristic polynomial:

$$
P(t) = \det(\mathbf{K}-t\mathbf{I})=-t^3-t(k_1^2+k_2^2+k_3^2) = -t^3-t\,,
$$
$$P(\mathbf{K}) = 0\,,$$
$$-\mathbf{K}^3-\mathbf{K} = 0\,,$$
$$\mathbf{K}^3=-\mathbf{K}\,.$$

From the last equation we get $\mathbf{K}^4=-\mathbf{K}^2$ and
$\mathbf{K}^5=-\mathbf{K}^3=\mathbf{K}$ and so on.

Then the rotation matrix $\mathbf{R}$ is:

$$
\mathbf{R}
= e^{\theta \mathbf{K}}
= \sum_{k=0}^\infty {(\theta\mathbf{K})^k \over k!}
= \mathbf{I} + \theta\mathbf{K}
+ {(\theta\mathbf{K})^2 \over 2!}
+ {(\theta\mathbf{K})^3 \over 3!}
+ \cdots =
$$
$$
= \mathbf{I}
+ \mathbf{K}\left(\theta - {\theta^3\over3!} + {\theta^5\over5!} - \cdots\right)
+ \mathbf{K}^2\left({\theta^2\over2!} - {\theta^4\over4!} + {\theta^6\over6!} - \cdots\right)
=
$$
$$
= \mathbf{I}
+ \mathbf{K}\sin\theta
+ \mathbf{K}^2(1-\cos\theta)\,.
$$

So we got:
$$
\mathbf{R} = \mathbf{I}
+\mathbf{K} \sin\theta
+\mathbf{K}^2 (1-\cos\theta)\,.
$$

Now we can write:

$$
\mathbf{v}_\mathrm{rot} = \mathbf{R} \mathbf{v}
$$

and get:

$$
\mathbf{v}_\mathrm{rot} = \mathbf{v}
+\mathbf{K}\mathbf{v} \sin\theta
+\mathbf{K}^2\mathbf{v} (1-\cos\theta)\,.
$$

We use:

$$
\mathbf{K}\mathbf{v} = \mathbf{k}\times\mathbf{v}\,,
$$
$$
\mathbf{K}^2\mathbf{v} = \mathbf{K}(\mathbf{K}\mathbf{v})
= \mathbf{k}\times(\mathbf{k}\times\mathbf{v})
= \mathbf{k}(\mathbf{k}\cdot\mathbf{v}) - (\mathbf{k}\cdot\mathbf{k})\mathbf{v}
= \mathbf{k}(\mathbf{k}\cdot\mathbf{v}) - \mathbf{v}
$$

and get:

$$
\mathbf{v}_\mathrm{rot} = \mathbf{v} \cos\theta
+(\mathbf{k}\times\mathbf{v}) \sin\theta
+\mathbf{k}(\mathbf{k}\cdot\mathbf{v}) (1-\cos\theta)\,.
$$

This is called the Rodrigues' formula. In components:

$$
\mathbf{R}_{ij} = \mathbf{I}_{ij}
+\mathbf{K}_{ij} \sin\theta
+\left(\mathbf{K}^2\right)_{ij} (1-\cos\theta)\,.
$$

We can simplify:

$$
R_{ij} = \delta_{ij}
-\epsilon_{ij}{}^k n_k \sin\theta
+(n_i n_j - \delta_{ij}) (1-\cos\theta)\,,
$$

$$
R_{ij}=\cos\theta\delta_{ij}+(1-\cos\theta)n_i n_j
-\sin\theta\,\epsilon_{ij}{}^k n_k\,.
$$
