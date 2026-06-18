# The Trace of a $(0,2)$ Tensor by Raising an Index

The trace is already settled for $(1,1)$ tensors. By [Trace From Linearity and Cyclicity](trace_linear_cyclic.md), an endomorphism $M$ of an $n$-dimensional space has a trace
$$
\operatorname{tr}(M)=M^{i}{}_{i},
$$
the unique-up-to-scale linear functional that is cyclic, $\operatorname{tr}(M_1M_2)=\operatorname{tr}(M_2M_1)$, and therefore conjugation-invariant, $\operatorname{tr}(P^{-1}MP)=\operatorname{tr}(M)$.

A $(0,2)$ tensor has no trace of its own — under a change of basis the sum of its diagonal components is not preserved. But a metric turns it into a $(1,1)$ tensor by **raising an index**, and we simply trace that. This note takes the construction as the definition, reads off every property in a few lines by piggybacking on the $(1,1)$ trace, and proves uniqueness — that nothing else deserves the name — only at the very end.

## Setup

Let $V$ be $n$-dimensional over $\mathbb C$. A **metric** is a nondegenerate symmetric $(0,2)$ tensor $g$ with matrix $G=(g_{ij})$ and inverse $g^{ij}=(G^{-1})_{ij}$. In a basis $e_1,\dots,e_n$ we meet three kinds of components:

- an endomorphism — a $(1,1)$ tensor — $M=(M^{i}{}_{j})$;
- a $(0,2)$ tensor $A=(A_{ij})$;
- the metric $G$.

The metric **lowers** the upper index of $M$, and because $G$ is invertible this is reversible — it **raises** the lower index of $A$:
```{math}
:label: eq-trir-raise

A_{ij}=g_{ik}\,M^{k}{}_{j}\;\;(A=GM),\qquad\qquad M^{k}{}_{j}=g^{ki}A_{ij}\;\;(M=G^{-1}A).
```
Under a change of basis $P\in GL(V)$ the two covariant objects transform by congruence and the endomorphism by similarity,
```{math}
:label: eq-trir-transform

A\mapsto P^{\mathsf T}AP,\qquad G\mapsto P^{\mathsf T}GP,\qquad M=G^{-1}A\mapsto P^{-1}MP,
```
the last following from the first two. A basis is **orthonormal** for $g$ when $G=I$ (one exists over $\mathbb C$); the changes of basis preserving $G$ are the isometries $O(g)=\{P:P^{\mathsf T}GP=G\}$, which in an orthonormal basis is $O(n,\mathbb C)$.

## Definition

The $(0,2)$ tensor $A$ has no intrinsic trace; the metric supplies one. Raise its index to the endomorphism $M=G^{-1}A$ and **define** the trace of $A$ to be that of $M$:
```{math}
:label: eq-trir-def

\operatorname{tr}_g(A):=\operatorname{tr}(M)=\operatorname{tr}\!\big(G^{-1}A\big).
```
This is the extension of the $(1,1)$ trace to $(0,2)$ tensors furnished by the metric. Everything below is an immediate consequence.

## Consequences

**Component formula.** By {eq}`eq-trir-raise` and the $(1,1)$ trace,
```{math}
:label: eq-trir-formula

\operatorname{tr}_g(A)=M^{i}{}_{i}=g^{ij}A_{ij},
```
a contraction of the upper indices of $g^{ij}$ against the lower indices of $A_{ij}$ — a genuine scalar. In an orthonormal basis, where $g^{ij}=\delta^{ij}$, its value is the diagonal sum $A_{11}+\dots+A_{nn}$. But that diagonal sum is only a coordinate number: it pairs two *lower* indices, so it is neither a contraction nor basis-independent, and it agrees with $g^{ij}A_{ij}$ only because the basis is orthonormal. This is exactly why $A$ has no trace of its own — and why an index had to be raised to define one.

**It is a scalar.** Under {eq}`eq-trir-transform` the endomorphism transforms by similarity $M\mapsto P^{-1}MP$, so the conjugation invariance of the $(1,1)$ trace makes $\operatorname{tr}_g(A)$ basis-independent — for the **full** $GL(V)$, not merely the isometries. Equivalently, $g^{ij}A_{ij}$ is the complete contraction of a $(2,0)$ tensor with a $(0,2)$ tensor.

**Linearity.** $\operatorname{tr}_g$ is linear in $A$, since $M=G^{-1}A$ is linear in $A$ and the trace is linear.

**The raised index may be either one.** Raising the second index of $A$ instead produces the endomorphism $AG^{-1}$, whose trace $\operatorname{tr}(AG^{-1})=\operatorname{tr}(G^{-1}A)$ by cyclicity. So {eq}`eq-trir-def` does not depend on which slot is raised. And since $g^{ij}$ is symmetric, $g^{ij}A_{ij}=g^{ij}A_{(ij)}$ — the contraction annihilates the antisymmetric part $A_{[ij]}$, so $\operatorname{tr}_g$ sees only the symmetric part of $A$.

**Normalization.** Tracing the metric against itself, $\operatorname{tr}_g(g)=\operatorname{tr}(G^{-1}G)=\operatorname{tr}(I)=n$.

That is the entire theory: the definition {eq}`eq-trir-def`, the formula {eq}`eq-trir-formula`, basis-independence, linearity, and the normalization, all inherited from the $(1,1)$ trace without a single new computation.

## Uniqueness

The construction produces one functional; we close by showing it is the *only* linear scalar of a $(0,2)$ tensor, up to scale.

> **Claim.** If $D$ is a linear functional on $(0,2)$ tensors that is isometry-invariant, $D(P^{\mathsf T}AP)=D(A)$ for all $P\in O(g)$, then $D=\lambda\,\operatorname{tr}_g$ for some $\lambda\in\mathbb C$.

Work in an orthonormal basis, so $G=I$; then the matrix of $A$ coincides with that of its raised endomorphism $M=G^{-1}A=A$, the isometries are $O(n,\mathbb C)$, and congruence by an isometry is conjugation, $P^{\mathsf T}AP=P^{-1}AP$. So $D$ is a linear functional invariant under $O(n,\mathbb C)$-conjugation. Write it on the matrix units,
$$
D(A)=\sum_{i,j}c_{ij}A_{ij},\qquad c_{ij}=D(E_{ij}).
$$
Two families of isometries — both **signed permutation matrices**, which satisfy $P^{\mathsf T}P=I$ — pin the coefficients.

*Diagonal sign matrices kill the off-diagonal $c_{ij}$.* For $\varepsilon\in\{\pm1\}^n$ put $S=\operatorname{diag}(\varepsilon_1,\dots,\varepsilon_n)$, so $S^{-1}=S$ and $(S^{-1}AS)_{ij}=\varepsilon_i\varepsilon_jA_{ij}$. Invariance forces $c_{ij}\varepsilon_i\varepsilon_j=c_{ij}$ for all $\varepsilon$; for $i\neq j$ take $\varepsilon_i=-1$ and the rest $+1$, so $\varepsilon_i\varepsilon_j=-1$ and $c_{ij}=0$.

*Permutations equate the diagonal $c_{ii}$.* A transposition matrix $P_\tau$ acts by $(P_\tau^{-1}AP_\tau)_{kl}=A_{\tau(k)\tau(l)}$, so invariance forces $c_{\tau(k)\tau(l)}=c_{kl}$; on the diagonal $c_{ii}=c_{jj}$. Write $\lambda$ for the common value.

Hence $c_{ij}=\lambda\,\delta_{ij}$, and since $g^{ij}=\delta^{ij}$ in the orthonormal basis,
$$
D(A)=\sum_{i,j}c_{ij}A_{ij}=\lambda\sum_{i,j}\delta_{ij}A_{ij}=\lambda\,g^{ij}A_{ij}=\lambda\operatorname{tr}_g(A);
$$
both sides are scalars {eq}`eq-trir-transform`, so the identity holds in every basis. $\qquad\blacksquare$

The normalization $D(g)=n$ then fixes $\lambda=1$, singling out $\operatorname{tr}_g$ itself.

## Remark — why uniqueness needs its own argument

Existence, the formula, and invariance piggybacked directly on the $(1,1)$ trace; uniqueness did not. The reason is that with $G$ fixed, isometry-invariance of $A$ pulls back only to $O(g)$-conjugation-invariance of $M=G^{-1}A$ — the isometry subgroup, not all of $GL(V)$ — so the full-$GL$ uniqueness of [Trace From Linearity and Cyclicity](trace_linear_cyclic.md) cannot be quoted directly. The signed-permutation argument is exactly what shows $O(g)$ is still rigid enough (its commutant is already the scalars). One *can* inherit uniqueness wholesale by instead assuming the pulled-back functional is cyclic, $D(A_1G^{-1}A_2)=D(A_2G^{-1}A_1)$, which is literally linearity-plus-cyclicity on $M$ — but that is a stronger, algebraic hypothesis, not the bare geometric one used above. The axiom-first development, and this trade-off in full, is in [The Trace of a $(0,2)$ Tensor from a Metric](trace_from_metric_invariance.md).
