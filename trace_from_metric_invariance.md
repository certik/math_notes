# The Trace of a $(0,2)$ Tensor from a Metric

Starting from a covariant rank-2 tensor $T$ together with a metric $g$, and a few invariance assumptions, we derive — with no skipped steps — that the only linear scalar one can attach to $T$ is the **metric trace** $g^{ij}T_{ij}$, which in any orthonormal basis is the ordinary trace $\sum_i T_{ii}$ of the component matrix.

This is the additive, metric-dependent companion of [The Determinant of a $(0,2)$ Tensor from Relative Invariance](determinant_from_relative_invariance.md). The contrast is the whole point. The determinant of a $(0,2)$ tensor needs **no** metric: it is a relative scalar (a density of weight $2$) under the full $GL$ congruence group. A $(0,2)$ tensor has **no** intrinsic trace — under congruence $M\mapsto A^{\mathsf T}MA$ the coordinate sum $\sum_i M_{ii}$ is not preserved — and a metric is exactly the extra datum that repairs this, by letting one index be raised.

## Setup

Let $V$ be an $n$-dimensional vector space over $\mathbb C$ and $T$ a $(0,2)$ tensor, i.e. a bilinear form $T:V\times V\to\mathbb C$. Fix a basis $e_1,\dots,e_n$ and form the component matrix
$$
M_{ij}=T(e_i,e_j).
$$
A **metric** is a nondegenerate symmetric $(0,2)$ tensor $g$ with components $G_{ij}=g(e_i,e_j)$; its inverse is the $(2,0)$ tensor with components $g^{ij}:=(G^{-1})_{ij}$, so that $\sum_j g^{ij}G_{jk}=\delta^i_k$.

For $A\in GL(V)$ (the matrix of a change of basis), both covariant tensors transform by **congruence**, and the inverse metric contravariantly:
```{math}
:label: eq-trmet-congruence

M\mapsto A^{\mathsf T}MA,\qquad G\mapsto A^{\mathsf T}GA,\qquad G^{-1}\mapsto A^{-1}G^{-1}A^{-\mathsf T}.
```
A basis is **orthonormal** for $g$ when $G=I$, i.e. $g(e_i,e_j)=\delta_{ij}$. Over $\mathbb C$ every nondegenerate symmetric form admits an orthonormal basis (diagonalize, then rescale each diagonal entry to $1$ using a complex square root). The changes of basis that preserve $g$ form the **isometry group**
$$
O(g):=\{A\in GL(V):A^{\mathsf T}GA=G\};
$$
in an orthonormal basis $O(g)=O(n,\mathbb C)=\{A:A^{\mathsf T}A=I\}$, and there congruence by an isometry coincides with conjugation, $A^{\mathsf T}MA=A^{-1}MA$.

We seek a scalar $D(M)\in\mathbb C$ built from the components of $T$, with the metric fixed as background data.

## Assumptions

- **(L) Linearity.** $D(M+M')=D(M)+D(M')$ and $D(cM)=c\,D(M)$ for all $M,M'$ and $c\in\mathbb C$. The trace is additive and homogeneous of degree $1$ — the additive analogue of the determinant's degree-$n$ homogeneity.
- **(I) Isometry invariance.** There is a character $\kappa:O(g)\to\mathbb C^{*}$ with
$$
D\big(A^{\mathsf T}MA\big)=\kappa(A)\,D(M)\qquad(\forall M,\ \forall A\in O(g)),
$$
i.e. $D$ is a relative scalar under isometries — the analogue of the determinant's relative invariance, now restricted to the subgroup that the metric singles out.
- **(N) Normalization.** $D(G)=n$ (the metric's own trace; in an orthonormal basis $D(I)=n$).
- $D\not\equiv 0$.

## Step 1 — the character is trivial

Set $M=G$ in (I). Since $A^{\mathsf T}GA=G$ for every isometry,
$$
D(G)=D\big(A^{\mathsf T}GA\big)=\kappa(A)\,D(G).
$$
By (N), $D(G)=n\neq0$, so $\kappa(A)=1$ for all $A\in O(g)$:
```{math}
:label: eq-trmet-absolute

D\big(A^{\mathsf T}MA\big)=D(M)\qquad(A\in O(g)).
```
So $D$ is an **absolute** invariant under isometries — a scalar of weight $0$, in contrast with the determinant, whose weight-$2$ density survives only as a relative scalar. The normalization is what trivializes the character; note $O(n,\mathbb C)$ does carry the nontrivial character $A\mapsto\det A=\pm1$, but $D(G)\neq0$ excludes it.

## Step 2 — work in an orthonormal basis

Choosing an orthonormal basis makes $G=I$, the isometry group $O(n,\mathbb C)$, and {eq}`eq-trmet-absolute` the conjugation invariance
```{math}
:label: eq-trmet-conjugation

D\big(A^{-1}MA\big)=D(M)\qquad(A\in O(n,\mathbb C)).
```
Everything below is computed in this basis; the basis-free form is restored in Step 4.

## Step 3 — signed permutations force $D=\lambda\operatorname{tr}$

By linearity (L), $D$ is determined by its values on the matrix units $E_{ij}$:
$$
D(M)=\sum_{i,j}c_{ij}M_{ij},\qquad c_{ij}:=D(E_{ij}).
$$
Two families of isometries pin the coefficients $c_{ij}$. Both are **signed permutation matrices**, which satisfy $A^{\mathsf T}A=I$ and so lie in $O(n,\mathbb C)$.

**Diagonal sign matrices kill the off-diagonal coefficients.** For $\varepsilon\in\{\pm1\}^n$ let $S=\operatorname{diag}(\varepsilon_1,\dots,\varepsilon_n)$, so $S^{-1}=S$ and $(S^{-1}MS)_{ij}=\varepsilon_i\varepsilon_j M_{ij}$. Invariance {eq}`eq-trmet-conjugation` gives $\sum_{ij}c_{ij}\varepsilon_i\varepsilon_j M_{ij}=\sum_{ij}c_{ij}M_{ij}$ for all $M$, hence $c_{ij}(\varepsilon_i\varepsilon_j-1)=0$. For $i\neq j$, take $\varepsilon_i=-1$ and the rest $+1$; then $\varepsilon_i\varepsilon_j=-1$ and
```{math}
:label: eq-trmet-offdiagonal

c_{ij}=0\qquad(i\neq j).
```

**Permutations equate the diagonal coefficients.** For a transposition $\tau=(i\;j)$ the permutation matrix $P_\tau\in O(n,\mathbb C)$ acts by $(P_\tau^{-1}MP_\tau)_{kl}=M_{\tau(k)\tau(l)}$, so {eq}`eq-trmet-conjugation` forces $c_{\tau(k)\tau(l)}=c_{kl}$; on the diagonal this is $c_{ii}=c_{jj}$. Thus all diagonal coefficients share one value
```{math}
:label: eq-trmet-diagonal

\lambda:=c_{11}=c_{22}=\dots=c_{nn}.
```
Combining {eq}`eq-trmet-offdiagonal` and {eq}`eq-trmet-diagonal`,
$$
D(M)=\lambda\sum_i M_{ii}=\lambda\operatorname{tr}(M).
$$

## Step 4 — normalization and the covariant formula

In the orthonormal basis $G=I$, so (N) reads $D(I)=\lambda n=n$, giving $\lambda=1$ and
$$
D(M)=\sum_i M_{ii}=\operatorname{tr}(M)\qquad(\text{orthonormal basis}).
$$
To see the same scalar in an arbitrary basis, contract $T$ with the inverse metric:
```{math}
:label: eq-trmet-covariant

\operatorname{tr}_g(T):=\sum_{i,j}g^{ij}M_{ij}=\operatorname{tr}\!\big(G^{-1}M\big),
```
which collapses to $\sum_i M_{ii}$ exactly when $G=I$. The next section verifies that {eq}`eq-trmet-covariant` is itself a genuine scalar satisfying (L), (I), (N), so by the uniqueness just proved it is *the* answer.

## Existence: the metric trace is a scalar

Equation {eq}`eq-trmet-covariant` defines one explicit functional, which we check directly.

* **Linear** in $T$, since each $M_{ij}$ is.
* **Invariant** under *every* change of basis (not merely isometries): under {eq}`eq-trmet-congruence`,
$$
\operatorname{tr}\!\big(G^{-1}M\big)\mapsto\operatorname{tr}\!\big(A^{-1}G^{-1}A^{-\mathsf T}\,A^{\mathsf T}MA\big)=\operatorname{tr}\!\big(A^{-1}G^{-1}MA\big)=\operatorname{tr}\!\big(G^{-1}M\big),
$$
by the cyclic property of the trace. In particular (I) holds with $\kappa\equiv1$.
* **Normalized:** $\operatorname{tr}_g(g)=\sum_{ij}g^{ij}G_{ij}=\sum_i\delta^i_i=n$, so (N) holds.

The reason it is invariant under the *full* group, while the abstract $D$ was only assumed invariant under isometries, is index-raising. The matrix
$$
S:=G^{-1}M,\qquad S^{i}{}_{j}=\sum_k g^{ik}T_{kj},
$$
is the **$(1,1)$ tensor** obtained by raising the first index of $T$ with the metric. Under {eq}`eq-trmet-congruence` it transforms by similarity, $S\mapsto A^{-1}SA$, so it is a genuine endomorphism of $V$, and
$$
\operatorname{tr}_g(T)=\operatorname{tr}(S)
$$
is simply its trace — the invariant of a mixed tensor characterized in [Trace From Linearity and Cyclicity](trace_linear_cyclic.md). The metric's sole job is to convert the covariant tensor $T$ into the endomorphism $S$; the trace then lives where it naturally belongs.

## Conclusion

In every orthonormal basis the linear, isometry-invariant, normalized scalar of a $(0,2)$ tensor is the trace of its component matrix, and in an arbitrary basis it is the metric contraction:
$$
\boxed{\,D(M)=\operatorname{tr}_g(T)=\sum_{i,j}g^{ij}M_{ij}=\operatorname{tr}\!\big(G^{-1}M\big)\;\xrightarrow[\;G=I\;]{}\;\sum_i M_{ii}.\,}
$$
Linearity (L), isometry invariance (I), and the scale (N) force the trace of a $(0,2)$ tensor — taken against the metric — to be the ordinary component trace in any orthonormal frame. $\qquad\blacksquare$

## Remarks

**Only the symmetric part is seen.** Since $g^{ij}$ is symmetric, $g^{ij}M_{ij}=g^{ij}M_{(ij)}$ depends only on the symmetric part of $T$; equivalently, an antisymmetric $M_{ij}=-M_{ji}$ has $M_{ii}=0$, so $\sum_i M_{ii}=0$. The metric trace is blind to the $2$-form part of $T$.

**Why a metric is unavoidable.** Without the metric the only invariance available on a $(0,2)$ tensor is the full congruence group, under which no nonzero *linear* scalar is invariant: writing $D(M)=\operatorname{tr}(C^{\mathsf T}M)$ and taking the scaling $A=cI$ gives $D(A^{\mathsf T}MA)=c^2D(M)$, so $D(A^{\mathsf T}MA)=D(M)$ for **all** $A\in GL(V)$ already forces $c^2D(M)=D(M)$ for every $c$, hence $D\equiv0$. The determinant escapes this because it is *relative*, scaling by $\det(A)^2$ rather than staying fixed; the trace cannot, so it must borrow a metric to lower the symmetry to the isometry subgroup $O(g)$, on which $\sum_i M_{ii}$ *is* invariant. The metric-free home of the trace is instead the mixed $(1,1)$ tensor of [Trace From Linearity and Cyclicity](trace_linear_cyclic.md), recovered here as $\operatorname{tr}(G^{-1}M)$.

**Parallel with the determinant.** The determinant note reduces its per-slot relative invariance to two homomorphisms $GL(n,\mathbb C)\to\mathbb C^{*}$ and identifies them with $\det$ via [Determinant From Homomorphism](determinant_homomorphism.md). Here the relative invariance reduces, after the character is trivialized in Step 1, to a single linear functional invariant under $O(n,\mathbb C)$-conjugation, identified with $\operatorname{tr}$ via the signed-permutation argument of Step 3 — the orthogonal-group shadow of [Trace From Linearity and Cyclicity](trace_linear_cyclic.md).
