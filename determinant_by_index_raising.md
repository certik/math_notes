# The Determinant of a $(0,2)$ Tensor by Raising an Index

The determinant is already settled for $(1,1)$ tensors. By [Determinant From Homomorphism](determinant_homomorphism.md), an endomorphism $M$ of an $n$-dimensional space has a determinant
$$
\det(M)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}M^{i}{}_{\sigma(i)},
$$
the single-valued Leibniz polynomial; it is multiplicative, $\det(M_1M_2)=\det(M_1)\det(M_2)$, and therefore conjugation-invariant, $\det(P^{-1}MP)=\det(M)$ — an intrinsic scalar.

A $(0,2)$ tensor has no determinant of its own as a scalar: the determinant of its component matrix, $\det(A_{ij})$, is basis-dependent — under a change of basis $A\mapsto P^{\mathsf T}AP$ it picks up a factor $\det(P)^2$, making it a density of weight $2$ (the subject of [The Determinant of a $(0,2)$ Tensor from Relative Invariance](determinant_from_relative_invariance.md)). A metric repairs this by raising an index, exactly as for the trace. This note takes that construction as the definition, reads off existence and every property by piggybacking on the $(1,1)$ determinant, and proves uniqueness from multiplicativity only at the very end.

## Setup

Let $V$ be $n$-dimensional over $\mathbb C$. A **metric** is a nondegenerate symmetric $(0,2)$ tensor $g$ with matrix $G=(g_{ij})$ and inverse $g^{ij}=(G^{-1})_{ij}$. In a basis $e_1,\dots,e_n$ we meet three kinds of components:

- an endomorphism — a $(1,1)$ tensor — $M=(M^{i}{}_{j})$;
- a $(0,2)$ tensor $A=(A_{ij})$;
- the metric $G$.

The metric **lowers** the upper index of $M$, and because $G$ is invertible this is reversible — it **raises** the lower index of $A$:
```{math}
:label: eq-detir-raise

A_{ij}=g_{ik}\,M^{k}{}_{j}\;\;(A=GM),\qquad\qquad M^{k}{}_{j}=g^{ki}A_{ij}\;\;(M=G^{-1}A).
```
Under a change of basis $P\in GL(V)$ the two covariant objects transform by congruence and the endomorphism by similarity,
```{math}
:label: eq-detir-transform

A\mapsto P^{\mathsf T}AP,\qquad G\mapsto P^{\mathsf T}GP,\qquad M=G^{-1}A\mapsto P^{-1}MP,
```
the last following from the first two. A basis is **orthonormal** for $g$ when $G=I$ (one exists over $\mathbb C$).

## The $(1,1)$ determinant

These are the facts we borrow from [Determinant From Homomorphism](determinant_homomorphism.md). On endomorphisms the determinant is

- explicit and single-valued — the Leibniz polynomial above, defined for every $M$;
- multiplicative on $GL(V)$, hence conjugation-invariant, $\det(P^{-1}MP)=\det(M)$;
- normalized, $\det(I)=1$;
- universal: every homomorphism $GL(V)\to\mathbb C^{*}$ equals $h\circ\det$ for some homomorphism $h:\mathbb C^{*}\to\mathbb C^{*}$, and $\det$ is the only one taking the value $\prod_i d_i$ on $\operatorname{diag}(d_1,\dots,d_n)$.

## Definition

The $(0,2)$ tensor $A$ has no intrinsic determinant; the metric supplies one. Raise its index to the endomorphism $M=G^{-1}A$ and **define** the determinant of $A$ to be that of $M$:
```{math}
:label: eq-detir-def

\det\nolimits_g(A):=\det(M)=\det\!\big(G^{-1}A\big).
```
This is the metric-furnished extension of the $(1,1)$ determinant to $(0,2)$ tensors. Everything below is an immediate consequence.

## Existence and consequences

**Existence and component formula.** The Leibniz polynomial makes $\det(G^{-1}A)$ an explicit, single-valued polynomial in the entries of $A$, and by multiplicativity
```{math}
:label: eq-detir-formula

\det\nolimits_g(A)=\det\!\big(G^{-1}A\big)=\frac{\det(A_{ij})}{\det(g_{ij})}.
```
In an orthonormal basis, where $\det(g_{ij})=1$, its value is the component determinant $\det(A_{ij})$. But that component determinant is only a coordinate number: under $A\mapsto P^{\mathsf T}AP$ it scales by $\det(P)^2$, so it is a weight-$2$ density, not basis-independent, and it agrees with $\det_g(A)$ only because the orthonormal metric has unit determinant. This is exactly why $A$ has no determinant of its own as a scalar — and why an index had to be raised to define one.

**It is a scalar.** Under {eq}`eq-detir-transform` the endomorphism transforms by similarity $M\mapsto P^{-1}MP$, so the conjugation invariance of the $(1,1)$ determinant makes $\det_g(A)$ basis-independent — for the **full** $GL(V)$.

**Multiplicative under metric-composition.** Composing two $(0,2)$ tensors through the metric, $A_1\,G^{-1}A_2$ is again a $(0,2)$ tensor, and
```{math}
:label: eq-detir-mult

\det\nolimits_g\!\big(A_1\,G^{-1}A_2\big)=\det\!\big(G^{-1}A_1G^{-1}A_2\big)=\det\!\big(G^{-1}A_1\big)\det\!\big(G^{-1}A_2\big)=\det\nolimits_g(A_1)\,\det\nolimits_g(A_2).
```

**Homogeneous of degree $n$.** $\det_g(cA)=\det(cG^{-1}A)=c^{n}\det_g(A)$ for $c\in\mathbb C$.

**The raised index may be either one.** Raising the second index of $A$ produces the endomorphism $AG^{-1}$, and $\det(AG^{-1})=\det(G^{-1}A)$, so {eq}`eq-detir-def` does not depend on which slot is raised.

**Normalization.** Taking $A=g$, $\det_g(g)=\det(G^{-1}G)=\det(I)=1$.

That is the whole theory: the definition {eq}`eq-detir-def`, the formula {eq}`eq-detir-formula`, basis-independence, multiplicativity, the degree, and the normalization, all inherited from the $(1,1)$ determinant without a single new computation.

## Uniqueness

The construction produces one functional; we close by showing it is the only one of its kind. The hypotheses are the multiplicative analogues of the trace's linear ones.

> **Claim.** Let $D$ be a function on $(0,2)$ tensors, nonzero on the nondegenerate ones, with
> - **(M)** metric-multiplicativity: $D(A_1G^{-1}A_2)=D(A_1)D(A_2)$ for all nondegenerate $A_1,A_2$;
> - **(H)** homogeneity: $D(cA)=c^{n}D(A)$ for $c\in\mathbb C^{*}$;
> - **(N)** normalization: $D(g)=1$.
> Then $D=\det_g$ on every nondegenerate $(0,2)$ tensor.

Pull back along the index-raising. For $M\in GL(V)$ set $\tilde D(M):=D(GM)$; then $A=GM$ is nondegenerate, so $\tilde D(M)\in\mathbb C^{*}$. By **(M)**, for $M_1,M_2\in GL(V)$,
$$
\tilde D(M_1M_2)=D(GM_1M_2)=D\big((GM_1)\,G^{-1}\,(GM_2)\big)=D(GM_1)\,D(GM_2)=\tilde D(M_1)\,\tilde D(M_2),
$$
so $\tilde D:GL(V)\to\mathbb C^{*}$ is a group homomorphism. By [Determinant From Homomorphism](determinant_homomorphism.md) it factors,
```{math}
:label: eq-detir-factor

\tilde D=h\circ\det,\qquad h:\mathbb C^{*}\to\mathbb C^{*}\ \text{a homomorphism}.
```
Now evaluate on the metric ray. By **(H)** and **(N)**, $D(cg)=c^{n}D(g)=c^{n}$; on the other hand $cg=G(cI)$, so $D(cg)=\tilde D(cI)=h(\det(cI))=h(c^{n})$. Hence
$$
h(c^{n})=c^{n}\qquad\text{for every }c\in\mathbb C^{*}.
$$
Over $\mathbb C$ every element is an $n$-th power, so $h=\operatorname{id}$, and {eq}`eq-detir-factor` collapses to $\tilde D=\det$. Therefore, for every nondegenerate $A$,
$$
D(A)=\tilde D\big(G^{-1}A\big)=\det\!\big(G^{-1}A\big)=\det\nolimits_g(A).\qquad\blacksquare
$$
On a degenerate $A$ both sides vanish — $\det_g(A)=0$ by {eq}`eq-detir-formula`, and the explicit polynomial $\det_g$ extends the identity there by continuity — so $D=\det_g$ outright once $D$ is taken to be the everywhere-defined Leibniz extension.

## Remarks

**Existence piggybacked; uniqueness used multiplicativity.** As with the trace, existence, the component formula, and invariance came straight from the $(1,1)$ determinant by raising an index. Uniqueness, however, rested on **(M)** — multiplicativity — and reduced, through the same index-raising, to the homomorphism theorem of [Determinant From Homomorphism](determinant_homomorphism.md). It is the determinant's counterpart of the trace's pull-back of cyclicity.

**Why isometry-invariance is not enough — the contrast with the trace.** For the trace, linearity together with isometry-invariance pinned $\operatorname{tr}_g$ uniquely (a signed-permutation argument). For the determinant the same geometric hypothesis is far too weak: *every* coefficient of the characteristic polynomial of $M=G^{-1}A$ — the elementary symmetric functions $\operatorname{tr}(M),\ \dots,\ \det(M)$ of its eigenvalues — is an isometry-invariant scalar built from $A$, and $\det_g$ is only the last of them. Linearity selects the first of these (the trace); multiplicativity selects the last (the determinant). This is why the determinant's uniqueness must invoke its multiplicative structure rather than a symmetry.

**Relation to the density.** The formula $\det_g(A)=\det(A_{ij})/\det(g_{ij})$ exhibits $\det_g$ as the weight-$2$ density of [The Determinant of a $(0,2)$ Tensor from Relative Invariance](determinant_from_relative_invariance.md) divided by the metric's own weight-$2$ density — the standard way a metric trivializes a density into a genuine scalar.

**Geometric meaning.** $M=G^{-1}A$ is the endomorphism of the generalized eigenvalue problem $A\,v=\lambda\,g\,v$, so $\det_g(A)$ is the product of the eigenvalues of $A$ relative to $g$ — the ratio of the volume form determined by $A$ to that determined by $g$. Unlike the trace, which saw only the symmetric part of $A$, the determinant sees all of it: a nonzero antisymmetric $A$ can have $\det_g(A)\neq0$.
