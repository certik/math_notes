# Deriving the determinant from homogeneity and multiplicativity

Traditionally the determinant is defined using its action on identity and its
multilinear and alternating properties, but the latter two are formulated in
terms of rows of the matrix, so it is basis dependent. These properties are
also rather arbitrary, although it can be motivated by properties of oriented
areas spanned by the row vectors. Another common derivation is to simply
define it using the Leibniz formula, but then the definition is completely
arbitrary.

Instead, in this note we derive it using its action on a multiplication of a
matrix. Matrix can be multiplied by either a scalar ($\lambda A$) or by another
matrix ($A B$). We define the determinant by its behavior in these two cases,
as a function $f$ of a matrix into scalars, and we want this behavior to be
distributive. The precise behavior that we assume is
$f(A B) = f(A) f(B)$ (homomorphism) and
$f(\lambda A) = f(\lambda I) f(A) = \lambda^n f(A)$ (homogeneity), in the
second case we really only need to assume how it behaves on the identity matrix
multiplied by a scalar: $f(\lambda I) = \lambda^n$. Both definitions are basis
independent, just a very natural distributivity in the simplest possible way.
We do not assume anything else.

Note: if we assumed just $f(\lambda I) = \lambda$, then for $n\ge2$ there is no
such multiplicative function $f$ at all (for $n=1$ it trivially works, since
$\lambda^n=\lambda$). The homomorphism property is stronger and forces the
$\lambda$-dependence to factor through $\lambda^n$. Specifically, in the
steps 1.-3. below we show that homomorphism alone implies $f(\lambda I) =
g(\lambda^n)$, where $g(w)$ is a homomorphism $C^* \to C^*$, which can be fully
solved with some extra regularity assumptions (continuous or measurable):
$$g(w)=|w|^{\,s}\Big(\tfrac{w}{|w|}\Big)^{k}=w^{p}\bar w^{\,q},\qquad s\in C,\ k\in\mathbb Z\ \ (p-q=k).$$
Only now we need to make some additional choice other than the original
homomorphism of $f$ and the extra regularity assumption. The trivial choice
$g\equiv1$ gives the degenerate $f\equiv1$, so the simplest nontrivial choice is
the identity $g(w) = w$, which implies $f(\lambda I) = \lambda^n$ (homogeneity);
and if we assume just the homogeneity we do not even need to assume continuity.
So in this note we simply assume homogeneity in this form, and derive everything
else, but it is good to understand that the homomorphism is the strong main
assumption, and it heavily restricts the possible forms of the homogeneity
assumption, and we choose the simplest possible form given the restrictions, in
the above sense.

This note is **strictly bottom-up**. We assume *only* that a function $f$ on invertible complex matrices is

- a **homomorphism**, and
- **homogeneous**,

and from these two properties alone we derive, step by step, that $f$ must be given by the **Leibniz formula**. Nothing about the determinant is assumed in advance; each step uses only the steps before it.

---

## Assumptions

- $C^* = C\setminus\{0\}$ under multiplication; $M_n(C)$ all complex $n\times n$ matrices; $GL(n,C)$ the invertible ones, a group under multiplication.
- $\operatorname{diag}(x_1,\dots,x_n)$ is the diagonal matrix with the listed entries.

We are given a function $f:GL(n,C)\to C^*$ such that:

**(H1) Multiplicativity.** $f(AB)=f(A)\,f(B)$ for all $A,B\in GL(n,C)$.

**(H2) Homogeneity.** $f(\lambda I)=\lambda^{n}$ for all $\lambda\in C^*$.

We use one background fact about $C$:

**(R) Roots.** Every $w\in C^*$ has an $n$-th root: some $\lambda\in C^*$ with $\lambda^n=w$.

We also use only elementary language about rows, spans, and multilinear functions. We do **not** assume the determinant, the Leibniz formula, the polar decomposition, or the spectral theorem.

Throughout, $e_1,\dots,e_n$ is the standard basis, and we view a matrix $A$ as its list of rows $r_1,\dots,r_n\in C^n$. The **matrix unit** $E_{ij}$ is the $n\times n$ matrix with a $1$ in row $i$, column $j$, and $0$ everywhere else. We write $T_{ij}(c)=I+c\,E_{ij}$ (for $i\neq j$) for the **transvection** that adds $c$ times row $j$ to row $i$ under left multiplication.

The permutation matrix swapping indicies $i$ and $j$ can be written using
transvections as:

$$S_{ij}=\operatorname{diag}(1,\dots,\underset{j}{-1},\dots,1)\,T_{ij}(1)\,T_{ji}(-1)\,T_{ij}(1)$$

It can be shown that $S_{ij} \in GL(n, C)$ and $S^{-1}_{ij} = S_{ji}$.

*Remark (the swap via transvections --- might not be needed).* Since $\det P_i=-1$ while $\det T_{ij}(c)=1$, the permutation $P_i$ is not itself a product of transvections, but the **signed swap**
$$W_{1i}:=T_{1i}(1)\,T_{i1}(-1)\,T_{1i}(1)=\operatorname{diag}(1,\dots,\underset{i}{-1},\dots,1)\cdot P_i$$
is (this is the $S_{ij}$ identity of (9)/the Appendix on coordinates $\{1,i\}$, where the $2\times2$ block is $\big(\begin{smallmatrix}0&1\\-1&0\end{smallmatrix}\big)$). One may use $W_{1i}$ in place of $P_i$ in (4): they differ by the diagonal matrix $D=\operatorname{diag}(1,\dots,\underset{i}{-1},\dots,1)$, which commutes with any diagonal matrix, so $W_{1i}\operatorname{diag}(x,1,\dots,1)W_{1i}^{-1}=D\,\big(P_i\operatorname{diag}(x,1,\dots,1)P_i^{-1}\big)D^{-1}=\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)$, the $D,D^{-1}$ cancelling because the middle factor is diagonal.

---

## Step 1 — $f(I)=1$ and conjugation invariance

From $I\cdot I=I$ and (H1): $f(I)=f(I)^2$. Since $f(I)\in C^*$ is nonzero, $f(I)=1$.

For any $P\in GL(n,C)$, using (H1) and the commutativity of $C^*$,
$$f(PAP^{-1})=f(P)f(A)f(P^{-1})=f(P)f(P^{-1})f(A)=f(PP^{-1})f(A)=f(A). \tag{1}$$
So $f$ is invariant under conjugation.

---

## Step 2 — $f(T_{ij}(c))$ is $1$ on every transvection $T_{ij}(c)$

Fix $i\neq j$. Two observations.

**All nonzero $c$ give conjugate transvections.** For a diagonal $D=\operatorname{diag}(d_1,\dots,d_n)$ one computes $D\,T_{ij}(c)\,D^{-1}=T_{ij}\!\big(c\,d_i/d_j\big)$. Choosing $d_i/d_j$ freely, the factor $c\,d_i/d_j$ ranges over all of $C^*$. Hence all $T_{ij}(c)$ with $c\neq 0$ are conjugate, so by (1) the value $f(T_{ij}(c))=:t$ is the same for every $c\neq 0$.

Better: all matrices $T_{ij}(c)$ for all $c\neq 0$ are mutually conjugate. From
Step 1 it follows that $f(T_{ij}(c))=t$ is constant for all $c\neq 0$.

**The values multiply additively.** Since $e_{ij}^2=0$, we have $T_{ij}(c)\,T_{ij}(c')=T_{ij}(c+c')$, so by (H1) the map $c\mapsto f(T_{ij}(c))$ turns addition into multiplication. Taking $c=c'=1$: $t=f(T_{ij}(2))=f(T_{ij}(1))^2=t^2$. As $t\in C^*$, this forces $t=1$.

Therefore
$$f\big(T_{ij}(c)\big)=1\qquad\text{for all }c. \tag{2}$$
In particular, by (H1), **left- or right-multiplying by a transvection does not change $f$** — i.e. adding a multiple of one row (or column) to another leaves $f$ unchanged.

---

## Step 3 — The one-variable function $g$, and $f$ on diagonal matrices

Define
$$g(x):=f\big(\operatorname{diag}(x,1,\dots,1)\big),\qquad x\in C^*.$$

**$g$ is a homomorphism $C^*\to C^*$:** from $\operatorname{diag}(xy,1,\dots,1)=\operatorname{diag}(x,1,\dots,1)\operatorname{diag}(y,1,\dots,1)$ and (H1),
$$g(xy)=g(x)g(y). \tag{3}$$

**Position does not matter.** Let $P_i=S_{1i}$ be the permutation matrix swapping coordinates $1$ and $i$ (so $P_i\in GL(n,C)$, $P_i^{-1}=P_i^{T}$). Explicitly $P_i=S_{1i}=I-e_{11}-e_{ii}+e_{1i}+e_{i1}$: the identity with rows (and columns) $1$ and $i$ interchanged.
This moves $x$ from slot $1$ to slot $i$. Then $\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)=P_i\operatorname{diag}(x,1,\dots,1)P_i^{-1}$, so by (1)
$$f\big(\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)\big)=g(x). \tag{4}$$

Note: check if the $P^{-1}_i$ should be there or not. We assume it is, and so
applying $f$ on the expression above cancels it. Let's make it explicit.

Note:
Conjugating any diagonal matrix by a permutation matrix permutes its diagonal entries
(explicitly: $P_\sigma\operatorname{diag}(d_1,\dots,d_n)P_\sigma^{-1}=\operatorname{diag}(d_{\sigma^{-1}(1)},\dots,d_{\sigma^{-1}(n)})$);



**Product over the diagonal.** Writing $\operatorname{diag}(d_1,\dots,d_n)=\prod_{i=1}^n\operatorname{diag}(1,\dots,\underset{i}{d_i},\dots,1)$ and using (H1), (4), (3),
$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_{i=1}^n g(d_i)=g\!\Big(\prod_{i=1}^n d_i\Big). \tag{5}$$

---

## Layer 1 — the factorization theorem $f=g\circ\det$ (multiplicativity only)

Everything so far (Steps 1–3) used **only** that $f$ is a homomorphism (H1); homogeneity has not yet been touched. Three facts are all we shall use:

* (H1) $f$ is a homomorphism $GL(n,C)\to C^*$;
* (2) $f\big(T_{ij}(c)\big)=1$ for every transvection;
* (5) $f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=g\!\big(\prod_i d_i\big)$, with $g:C^*\to C^*$ the homomorphism of Step 3.

We show these force $f=g\circ\det$, the determinant being supplied — single-valued — by the Leibniz polynomial. We work entirely inside $GL$, never evaluating $f$ on a singular matrix, with no appeal to homogeneity, continuity, exterior algebra, or Zariski density. (The optional Steps 5–7 below develop the classical multilinear/alternating viewpoint of $f$; the present derivation does **not** use them. The one ingredient missing for $f$ on $GL$ — the *alternating* property — enters here only as a formal identity about a polynomial, where the singular-matrix obstruction simply does not arise.)

**1. Transvections and diagonal matrices generate $GL$.**
*Lemma.* Every $A\in GL(n,C)$ factors as
$$A=E\,D,\qquad E=\text{a product of transvections},\quad D=\operatorname{diag}(d_1,\dots,d_n). \tag{19}$$
*Proof.* Row-reduce $A$ by Gaussian elimination. Adding $c$ times row $j$ to row $i$ is left multiplication by $T_{ij}(c)$. Should a pivot vanish, some entry in its column is nonzero (the columns of an invertible matrix are independent), and the row swap that brings it up is the purely algebraic identity (verified in the Appendix)
$$S_{ij}=\operatorname{diag}(1,\dots,\underset{j}{-1},\dots,1)\,T_{ij}(1)\,T_{ji}(-1)\,T_{ij}(1)$$
— again transvections times a diagonal. So a product of transvections and diagonal matrices reduces $A$ to a diagonal matrix. Finally, a diagonal matrix conjugates a transvection to a transvection, $D\,T_{ij}(c)\,D^{-1}=T_{ij}(c\,d_i/d_j)$ (Step 2), so every diagonal factor can be slid to the right past the transvections, collecting into a single $D$ and leaving the form (19):
$$D\,T_{ij}(c)
=D\,T_{ij}(c) D^{-1} D
=T_{ij}(c\,d_i/d_j) D\,.$$ $\square$

**2. A concrete anchor: the Leibniz polynomial.** Before drawing any conclusion about the abstract $f$, exhibit one *explicit* function we can evaluate unambiguously. Let
$$L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n a_{i,\sigma(i)},$$
a polynomial defined for **every** matrix by this formula — hence single-valued by construction. The following are **formal identities in the entries**, valid for all $A$ (singular included) and checked directly on the sum:

* (a) $L(I)=1$, and more generally $L\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i$ — only $\sigma=\mathrm{id}$ survives;
* (b) **two equal rows $\Rightarrow L=0$**: pairing each $\sigma$ with $\sigma\circ(\text{transposition of the two equal rows})$ cancels the sum term by term (using $\operatorname{char}C=0$);
* (c) $L$ is **linear in each row** — every summand is.

From (b) and (c), adding a multiple of one row to another leaves $L$ unchanged, $L\big(T_{ij}(c)\,X\big)=L(X)$; taking $X=I$ and using (a) gives in particular $L(T_{ij}(c))=1$. Thus $L$ satisfies $L(T_{ij}(c))=1$ and $L(\operatorname{diag}(d_1,\dots,d_n))=\prod_i d_i$ outright — and, unlike the abstract $f$ on $GL$, with **no domain caveat**, because $L$ is everywhere-defined and (b) is a genuine polynomial identity even though "two equal rows" is a singular configuration. The obstruction that blocked the alternating property for $f$ has been transferred to $L$, where it evaporates.

Feed $L$ a factorization (19). Peeling the transvections of $E$ off one at a time by $L(T_{ij}(c)X)=L(X)$, then applying (a),
$$L(A)=L(E\,D)=L(D)=\prod_i d_i. \tag{20}$$

**3. $\prod_i d_i$ is well-defined.** A priori the product in (20) could depend on the factorization (19) chosen, and the concrete $L$ is exactly what rules this out. If a second factorization $A=E'D'$ gave a different product $\prod_i d_i'$, then (20) applied to *it* would read $L(A)=\prod_i d_i'$ as well; but $L(A)$ is one unambiguous number, so $\prod_i d_i=\prod_i d_i'$. Hence every factorization of $A$ yields the same product, an honest function of $A$ alone, which we write $p(A):=\prod_i d_i$. (Note we proved independence *using* the single-valued $L$ — never assuming it beforehand.)

**4. Every homomorphism $f$ equals $g\circ\det$.** Define $\det:=L$, the everywhere-defined Leibniz polynomial. Let $f$ be *any* homomorphism — the given $f$ of Steps 1–3 is one such. For any factorization (19), using (H1), then (2) (so $f(E)=1$), then (5) (so $f(D)=g(\prod_i d_i)$),
$$f(A)=f(E)\,f(D)\overset{(2)}{=}f(D)\overset{(5)}{=}g\!\Big(\prod_i d_i\Big)=g\big(p(A)\big)=g\big(\det A\big),$$
where $p(A)=\prod_i d_i$ is unambiguous by part 3 and equals $L(A)=\det A$ by (20). This is the **factorization theorem**:
$$\boxed{\,f(A)=g(\det A),\qquad \det A:=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)}\qquad(A\in GL(n,C)),\,}$$
for some homomorphism $g:C^*\to C^*$ — **derived from multiplicativity alone**, with no homogeneity, continuity, measurability, or Zariski density. The grounding is fully transparent: the single-valued determinant is the explicit polynomial $L$ (part 2), well-definedness of $p(A)=\det A$ is anchored on $L$ (part 3), and the factorization $f=g\circ\det$ is part 4.

Conversely, every $g\circ\det$ with $g\in\operatorname{Hom}(C^*,C^*)$ *is* a homomorphism $GL(n,C)\to C^*$, so these are **exactly** all of them: the determinant is the universal homomorphism, and every other is a "rescaling" $g$ of it. The factor $g$ is genuinely free here — continuity or measurability would narrow it to $g(w)=|w|^s(w/|w|)^k$, and homogeneity (Layer 2) pins it to the identity.

---

## Layer 2 — homogeneity selects $g=\mathrm{id}$, hence $f=\det$

Layer 1 leaves exactly one degree of freedom, the homomorphism $g$; homogeneity removes it. Apply the factorization theorem to $\lambda I$, whose determinant is $\det(\lambda I)=\lambda^n$, and compare with (H2):
$$g(\lambda^n)=f(\lambda I)=\lambda^n\qquad\text{for all }\lambda\in C^*.$$
Given any $w\in C^*$, pick an $n$-th root $\lambda$ with $\lambda^n=w$ (fact (R)); then $g(w)=g(\lambda^n)=\lambda^n=w$. Hence
$$g=\mathrm{id}_{C^*}, \tag{6}$$
and the factorization theorem collapses to
$$\boxed{\,f(A)=\det A=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)}\qquad(A\in GL(n,C)).\,}$$
So $f$ is the determinant, and the **unique** homogeneous homomorphism.

This last step is the *only* place $C$ rather than $R$ is used: it needs every $w\in C^*$ to be an $n$-th power. Over $R^*$ it fails — e.g. $w=-1$ has no real $\lambda$ with $\lambda^2=w$ — so over $R$ with even $n$ the value $g(-1)=\pm1$ stays free, and the choice $g(-1)=+1$ gives a second, sign-blind solution (the permanent-like $|\det|$).

Two consequences of $g=\mathrm{id}$, used in the optional sections below: from (5) and (6),
$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i, \tag{5$'$}$$
and, since left-multiplying by $\operatorname{diag}(1,\dots,\underset{i}{\lambda},\dots,1)$ scales row $i$ by $\lambda$, scaling a single row by $\lambda$ multiplies $f$ by $\lambda$:
$$f\big(\operatorname{diag}(1,\dots,\underset{i}{\lambda},\dots,1)A\big)=\lambda\,f(A). \tag{7}$$

---

## Optional — the multilinear and alternating viewpoint

The two sections that follow (Steps 5–6) develop the classical multilinear and sign properties of $f$, and Step 7 expands them into the Leibniz formula. **None of this is used by Layers 1–2 above** — it is the traditional textbook route, recorded for context and referenced by the Lie-theoretic correspondence in Part III. A reader after the shortest path may stop here.

---

## Step 5 — $f$ is multilinear in the rows

Fix all rows of an invertible matrix except row $i$; call the others $r_1,\dots,\widehat{r_i},\dots,r_n$ (they are linearly independent, since the matrix is invertible). View $f$ as a function of the single varying row $r_i$.

- By Step 2, adding any multiple of another row $r_k$ ($k\neq i$) to $r_i$ leaves $f$ unchanged. Hence $f$ depends on $r_i$ **only through its class modulo** $V:=\operatorname{span}\{r_k:k\neq i\}$. Because the other rows are independent, $\dim V=n-1$, so the quotient $C^n/V$ is **one-dimensional**, and the matrix is invertible exactly when the class of $r_i$ is nonzero.
- By (7), $f$ is homogeneous of degree $1$ in $r_i$: replacing $r_i$ by $\lambda r_i$ multiplies $f$ by $\lambda$.

A function on the one-dimensional space $C^n/V$ that is homogeneous of degree $1$ is **linear**. Concretely, fix a nonzero class $z_0$ and let $c$ be the value of $f$ there. Every nonzero class is $t\,z_0$ for a unique scalar $t\in C^*$, and degree-$1$ homogeneity forces the value to be exactly $t\,c$. This rule $t\,z_0\mapsto t\,c$ is linear by the field arithmetic of $C$ (no Hamel-basis pathologies can arise in dimension one). Pulling back, $f$ is an additive (indeed linear) function of $r_i$:
$$f(\dots,\,u+v\,,\dots)=f(\dots,u,\dots)+f(\dots,v,\dots),\qquad f(\dots,\lambda u,\dots)=\lambda\,f(\dots,u,\dots).$$
Since $i$ was arbitrary, **$f$ is multilinear in the rows.** (8)

---

## Step 6 — Swapping two rows changes the sign

Work in the plane of coordinates $i,j$ (everything else is left fixed). The factorization
$$S_{ij}=\operatorname{diag}(1,\dots,\underset{j}{-1},\dots,1)\cdot T_{ij}(1)\,T_{ji}(-1)\,T_{ij}(1)$$
holds (it reduces to the $2\times2$ identity verified in the Appendix), where $S_{ij}$ is the permutation matrix swapping coordinates $i$ and $j$. By (H1), (2) and (5$'$)/(6),
$$f(S_{ij})=g(-1)\cdot 1=-1. \tag{9}$$
Since left-multiplication by $S_{ij}$ swaps rows $i$ and $j$, (9) and (H1) say: for every invertible $A$, swapping two of its rows multiplies $f$ by $-1$,
$$f(S_{ij}A)=-f(A)\qquad(A\in GL(n,C)). \tag{10}$$
This **antisymmetry** is a genuine statement about $GL$: a swap sends invertible matrices to invertible matrices. One is tempted to conclude at once that $f=0$ whenever two rows coincide — equate the two rows, swap them, and $f=-f$. But a matrix with two equal rows is **singular**, where $f$ is not defined, so the *alternating* property is **not** available on $GL$; Layer 1 above supplies it in the only place it is needed, as a formal identity about the Leibniz polynomial.
Finally, any permutation matrix $P_\sigma$ is a product of swaps, so by (9)
$$f(P_\sigma)=\operatorname{sgn}(\sigma). \tag{11}$$

(Here is the only place the choice of branch mattered: (9) used $g(-1)=-1$ from Layer 2. Had $g(-1)=+1$ — the situation that survives over $R$ for even $n$ — we would get the sign-blind "permanent" instead. Homogeneity, through (6), is exactly what selects the alternating sign.)

---

## Step 7 — The same formula via the classical basis expansion (optional)

Layers 1–2 above already derived the boxed formula rigorously and elementarily. The familiar textbook route reaches it a different way — by expanding $f$ multilinearly over the standard basis — and is worth recording, with one caveat that Layer 1 was designed to handle.

Multilinearity (8) lets one expand each row $r_i=\sum_{j}A_{ij}\,e_j$:
$$f(A)=\sum_{j_1,\dots,j_n}A_{1,j_1}\cdots A_{n,j_n}\;f(e_{j_1},\dots,e_{j_n}).$$
The surviving terms are those where $(j_1,\dots,j_n)=(\sigma(1),\dots,\sigma(n))$ for a permutation $\sigma$, contributing $f(P_\sigma)=\operatorname{sgn}(\sigma)$ by (11), and one recovers
$$\boxed{\,f(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}A_{i,\sigma(i)}\,,}$$
the **Leibniz formula**, in agreement with Layers 1–2.

A word on the basis expansion. The intermediate tuples $f(e_{j_1},\dots,e_{j_n})$ with a *repeated* index correspond to **singular** matrices, where $f$ was never defined — so the step "these terms vanish" cannot be justified by the abstract $f$ alone (this is the same gap that blocked the alternating property in Step 6). The clean fix is the one used in Layer 1: read every term as a value of the everywhere-defined polynomial $L(A)=\sum_\sigma\operatorname{sgn}(\sigma)\prod_i A_{i,\sigma(i)}$, whose vanishing on repeated indices is the *formal* identity (b) of Layer 1 (part 2), with no domain caveat. The expansion is then a convenient mnemonic for the rigorous generating-set derivation above — and needs neither continuity nor Zariski density.

---

## Conclusion

The argument splits into two independent layers.

> **Layer 1 — factorization (multiplicativity only).** Every homomorphism $f:GL(n,C)\to C^*$ has the form $f(A)=g(\det A)$ for some homomorphism $g:C^*\to C^*$, where $\det$ is the Leibniz polynomial. No homogeneity, continuity, or measurability is used; conversely every $g\circ\det$ is a homomorphism, so these are *all* of them.

> **Layer 2 — normalization (adding homogeneity).** If in addition $f(\lambda I)=\lambda^n$, then $g=\mathrm{id}$, so $f=\det$: the determinant is the unique homogeneous homomorphism.

Two remarks:

- **No regularity, no spectral theory.** We never assumed $f$ continuous or measurable, and never used eigenvalues, the polar decomposition, or the determinant itself. Layer 1 came from (H1) alone; Layer 2 added (H2) and one use of (R).
- **Where $C$ was essential.** Homogeneity is needed only to select $g=\mathrm{id}$, and that is the single step (Layer 2) requiring $C$ rather than $R$: every $w\in C^*$ — in particular $-1=i^2$ — has an $n$-th root, which forces $g=\mathrm{id}$ and hence $g(-1)=-1$, the sign in Step 6. Over $R$ with even $n$ the value $-1$ has no real $n$-th root, $g(-1)=\pm1$ stays free, and the choice $g(-1)=+1$ yields a second, sign-blind solution (the permanent-like $|\det|$). Over $C$ that ambiguity cannot occur.

---

## Appendix — The swap factorization for $2\times2$

The identity used in Step 6 reduces to the $2\times2$ case (all other coordinates are untouched). Write $T_{12}(c)=\begin{pmatrix}1&c\\0&1\end{pmatrix}$, $T_{21}(c)=\begin{pmatrix}1&0\\c&1\end{pmatrix}$. Then
$$T_{12}(1)\,T_{21}(-1)\,T_{12}(1)
=\begin{pmatrix}1&1\\0&1\end{pmatrix}\begin{pmatrix}1&0\\-1&1\end{pmatrix}\begin{pmatrix}1&1\\0&1\end{pmatrix}
=\begin{pmatrix}0&1\\-1&0\end{pmatrix},$$
and multiplying on the left by $\operatorname{diag}(1,-1)$ gives
$$\begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&1\\-1&0\end{pmatrix}
=\begin{pmatrix}0&1\\1&0\end{pmatrix}=S_{12},$$
as claimed. All three transvection factors have $f=1$ by (2), so $f(S_{12})=f(\operatorname{diag}(1,-1))=g(-1)=-1$.

---

## Chapter — The Lie-theoretic picture behind $e_{ij}$ and $T_{ij}$

Everything in the derivation has a clean interpretation in the language of Lie groups and Lie algebras. This chapter is independent of the main argument — it does not feed back into the proof — but it explains *why* the elementary steps work, and where they come from. We work over $C$ throughout, so $G=GL(n,C)$ is a complex Lie group of dimension $n^2$, and its Lie algebra is
$$\mathfrak{g}=\mathfrak{gl}(n,C)=M_n(C),\qquad [X,Y]=XY-YX.$$

### 1. The matrix units $e_{ij}$ are a basis of the Lie algebra

The $n^2$ matrix units $\{e_{ij}\}_{1\le i,j\le n}$ form a basis of $\mathfrak{gl}(n,C)$. Their bracket is computed from $e_{ij}e_{kl}=\delta_{jk}\,e_{il}$:
$$[e_{ij},e_{kl}]=\delta_{jk}\,e_{il}-\delta_{li}\,e_{kj}. \tag{L1}$$

This single rule encodes the entire structure we used.

- The **diagonal** units $h_i:=e_{ii}$ commute with each other ($[h_i,h_j]=0$) and span the **Cartan subalgebra** $\mathfrak{h}$ — the diagonal matrices. This is the "torus direction."
- The **off-diagonal** units $e_{ij}$ ($i\neq j$) are the **root vectors**. From (L1),
$$[h_k,e_{ij}]=(\delta_{ki}-\delta_{kj})\,e_{ij},$$
so $e_{ij}$ is a simultaneous eigenvector for the adjoint action of all diagonal $h_k$. Writing $\varepsilon_i\in\mathfrak{h}^*$ for the functional "read off the $i$-th diagonal entry," the eigenvalue is the **root**
$$\alpha_{ij}=\varepsilon_i-\varepsilon_j,\qquad [H,e_{ij}]=\alpha_{ij}(H)\,e_{ij}\ \ \text{for diagonal }H. \tag{L2}$$

**Example ($n=2$).** Here $\mathfrak{sl}(2,C)$ has the textbook basis
$$h=e_{11}-e_{22}=\begin{pmatrix}1&0\\0&-1\end{pmatrix},\quad e=e_{12}=\begin{pmatrix}0&1\\0&0\end{pmatrix},\quad f_-=e_{21}=\begin{pmatrix}0&0\\1&0\end{pmatrix},$$
with the famous relations $[h,e]=2e$, $[h,f_-]=-2f_-$, $[e,f_-]=h$. The root of $e_{12}$ is $\varepsilon_1-\varepsilon_2$, evaluating to $+2$ on $h$; the root of $e_{21}$ is $\varepsilon_2-\varepsilon_1$, evaluating to $-2$. These are exactly the entries you see in the brackets.

### 2. The transvections $T_{ij}(c)$ are the exponentials of the root vectors

For $i\neq j$ the matrix unit is **nilpotent**: $e_{ij}^2=0$. Hence the exponential series stops after one term,
$$\exp(c\,e_{ij})=I+c\,e_{ij}=T_{ij}(c). \tag{L3}$$
So a transvection is literally $\exp$ of a root vector. The map
$$c\longmapsto T_{ij}(c)=\exp(c\,e_{ij})$$
is a **one-parameter subgroup**: a Lie-group homomorphism from the additive group $(C,+)$ into $G$. The defining identity used in Step 2,
$$T_{ij}(c)\,T_{ij}(c')=T_{ij}(c+c'),$$
is exactly the statement $\exp(c\,e_{ij})\exp(c'e_{ij})=\exp((c+c')e_{ij})$, valid because the two exponents commute (they are multiples of the same nilpotent). The image $U_{ij}:=\{T_{ij}(c):c\in C\}\cong(C,+)$ is the **root subgroup** attached to $\alpha_{ij}$, a unipotent one-dimensional subgroup.

**Example.** $T_{12}(c)=\exp\!\begin{pmatrix}0&c\\0&0\end{pmatrix}=\begin{pmatrix}1&c\\0&1\end{pmatrix}$, and indeed $\begin{pmatrix}1&c\\0&1\end{pmatrix}\begin{pmatrix}1&c'\\0&1\end{pmatrix}=\begin{pmatrix}1&c+c'\\0&1\end{pmatrix}$.

### 3. Conjugation by the torus is the adjoint action — and the roots reappear

In Step 2 we conjugated a transvection by a diagonal matrix $D=\operatorname{diag}(d_1,\dots,d_n)$ and found
$$D\,T_{ij}(c)\,D^{-1}=T_{ij}\!\Big(c\,\tfrac{d_i}{d_j}\Big). \tag{L4}$$
This is the **adjoint action** $\mathrm{Ad}(D)$ of the group on the subgroup, and at the Lie-algebra level it is $\mathrm{Ad}(D)e_{ij}=\tfrac{d_i}{d_j}\,e_{ij}$. The eigenvalue $d_i/d_j$ is the root $\alpha_{ij}=\varepsilon_i-\varepsilon_j$ **exponentiated**: if $D=\exp(H)$ with $H=\operatorname{diag}(t_1,\dots,t_n)$, then $d_i/d_j=e^{t_i-t_j}=e^{\alpha_{ij}(H)}$, matching the infinitesimal version (L2) via $\mathrm{Ad}(\exp H)=\exp(\operatorname{ad} H)$. So the fact that "all nonzero-$c$ transvections are conjugate" is the geometric statement that the torus acts on the root line $C\,e_{ij}$ by the nonzero scalars $d_i/d_j$, which sweep out all of $C^*$.

**Example ($n=2$).** With $D=\operatorname{diag}(d_1,d_2)$,
$$D\begin{pmatrix}1&c\\0&1\end{pmatrix}D^{-1}=\begin{pmatrix}1&c\,d_1/d_2\\0&1\end{pmatrix},$$
and choosing $d_1/d_2$ freely rescales $c$ to anything nonzero.

### 4. Why $f$ must be trivial on the transvections: the derived subgroup

Here is the structural punchline. Brackets of root vectors *produce more root vectors*. From (L1), for instance,
$$[e_{ik},e_{kj}]=e_{ij}\qquad(i,k,j\ \text{distinct}),$$
which exponentiates (via the commutator of group elements) to the statement that transvections are **commutators** in $G$. Concretely, the group commutator of two root subgroups gives a third:
$$[\,T_{ik}(a),\,T_{kj}(b)\,]:=T_{ik}(a)T_{kj}(b)T_{ik}(a)^{-1}T_{kj}(b)^{-1}=T_{ij}(ab)\qquad(i,k,j\ \text{distinct}). \tag{L5}$$

Now recall any homomorphism $f:G\to C^*$ lands in an **abelian** group. Abelian targets cannot see commutators: $f([X,Y])=f(X)f(Y)f(X)^{-1}f(Y)^{-1}=1$. Applying this to (L5),
$$f\big(T_{ij}(ab)\big)=f\big([T_{ik}(a),T_{kj}(b)]\big)=1\qquad(n\ge 3). \tag{L6}$$
That is the **real reason** Step 2 forces $f\equiv1$ on transvections: they live in the commutator subgroup. (For $n\ge3$ the identity (L5) gives this in one line; the $n=2$ case has no third index, which is exactly why the note's Step 2 instead used the additive/idempotent argument $t=t^2$. Both routes reach $f=1$.)

This connects to the global structure:
$$[GL(n,C),\,GL(n,C)]=SL(n,C),\qquad\text{and the transvections generate } SL(n,C).$$
So $f$ trivial on transvections $\iff$ $f$ trivial on $SL(n,C)$ $\iff$ $f$ factors through the abelianization
$$GL(n,C)\big/SL(n,C)\;\xrightarrow{\ \det\ }\;C^*.$$
The whole note is an elementary, from-scratch proof that this quotient is $C^*$ and that the isomorphism is $\det$ — with **homogeneity (H2)** supplying the one extra normalization that selects $\det$ itself (not a power $\det^m$ or the sign-blind branch).

**Example ($n=2$, the $SL_2$ commutator at work).** Even though (L5) needs three indices, one can still exhibit a transvection as a commutator in $GL_2$ using the torus:
$$\begin{pmatrix}d&0\\0&d^{-1}\end{pmatrix}\begin{pmatrix}1&c\\0&1\end{pmatrix}\begin{pmatrix}d&0\\0&d^{-1}\end{pmatrix}^{-1}\begin{pmatrix}1&c\\0&1\end{pmatrix}^{-1}=\begin{pmatrix}1&(d^2-1)c\\0&1\end{pmatrix},$$
a transvection, written as a group commutator $[D,T_{12}(c)]$. Any homomorphism to an abelian group sends the left side to $1$, so $f(T_{12}((d^2-1)c))=1$ for all $d\neq0,\pm1$ — recovering Step 2 once more, now visibly as "transvections are commutators."

### 5. The torus, homogeneity, and where the answer comes from

Strip away the unipotent part and only the **maximal torus** $T=\{\operatorname{diag}(d_1,\dots,d_n)\}\cong (C^*)^n$ remains. A homomorphism $T\to C^*$ is a **character**, and the characters of $(C^*)^n$ are exactly the monomials
$$\operatorname{diag}(d_1,\dots,d_n)\longmapsto \prod_i d_i^{\,m_i},\qquad (m_1,\dots,m_n)\in\mathbb{Z}^n.$$
The Weyl group of $GL(n,C)$ is the symmetric group $S_n$, permuting the $d_i$ (this is the permutation-matrix conjugation of Step 3). A character that is **Weyl-invariant** must have all $m_i$ equal, $m_i=m$, i.e. it is $(\prod_i d_i)^m=(\det|_T)^m$. Homogeneity (H2), $f(\lambda I)=\lambda^n$, evaluates this at $d_i=\lambda$: $(\lambda^n)^m=\lambda^{nm}\overset{!}{=}\lambda^n$, forcing $m=1$. So:

- **Weyl-invariance** $\Rightarrow$ $f|_T=(\det|_T)^m$ — this is Step 3 ("position doesn't matter, $f(\operatorname{diag})=g(\prod d_i)$").
- **Homogeneity** $\Rightarrow$ $m=1$ — this is Layer 2 ("$g=\mathrm{id}$").

The note proves Weyl-invariance from scratch (permutation conjugation) and gets $m=1$ from the root property (every $w$ is an $n$-th power). The $C$-vs-$R$ subtlety lives entirely in this last point: over $C$ the only Weyl-invariant character matching (H2) is $\det$; over $R$ with even $n$ there is a second character of the disconnected torus $(R^*)^n$ — the sign-blind $\prod|d_i|$ — because $R^*$ is not divisible.

### Summary table

| Note's object | Lie-theoretic meaning |
|---|---|
| matrix unit $e_{ij}$ ($i\neq j$) | root vector for root $\alpha_{ij}=\varepsilon_i-\varepsilon_j$ in $\mathfrak{gl}(n,C)$ |
| diagonal $e_{ii}$ | basis of the Cartan subalgebra $\mathfrak{h}$ |
| transvection $T_{ij}(c)=I+c\,e_{ij}$ | $\exp(c\,e_{ij})$; element of the unipotent root subgroup $U_{ij}$ |
| $T_{ij}(c)T_{ij}(c')=T_{ij}(c+c')$ | one-parameter subgroup $C\to G$ |
| $D\,T_{ij}(c)\,D^{-1}=T_{ij}(c\,d_i/d_j)$ | adjoint action of the torus; eigenvalue $=$ exponentiated root |
| $f\equiv1$ on transvections (Step 2) | $f$ is trivial on $[G,G]=SL(n,C)$ (commutators) |
| permutation conjugation (Step 3) | Weyl group $S_n$ acting on the torus |
| $f(\operatorname{diag})=g(\prod d_i)$ | $f\rvert_T$ is a Weyl-invariant character of $(C^*)^n$ |
| homogeneity fixes $g=\mathrm{id}$ (Layer 2) | normalization selecting the character $\det$ (exponent $m=1$) |
| swap sign $f(S_{ij})=-1$ (Step 6) | longest Weyl element acts by $\operatorname{sgn}$; needs $-1\in(C^*)^n$-image |

In one sentence: **the determinant is the unique Weyl-invariant character of the maximal torus that is trivial on the unipotent root subgroups and normalized by homogeneity** — and the elementary note is precisely this statement with all the Lie theory unwound into bare-hands matrix computations.

---

## Part III — The same result, derived purely by Lie theory

The elementary derivation (Part I) and its dictionary (the previous chapter) suggest a second, completely different proof: differentiate $f$ once, recognize its differential as the **trace**, and integrate back. This is the Lie-theoretic route. It reaches the *same* endpoint — the Leibniz formula — but trades the hands-on row manipulations for the machinery of Lie groups, Lie algebras, and the exponential map. We work over $C$, where $G=GL(n,C)$ is a **connected** complex Lie group (its Lie algebra is $\mathfrak{g}=\mathfrak{gl}(n,C)=M_n(C)$), and the target $C^*$ is an abelian Lie group with Lie algebra $\operatorname{Lie}(C^*)=C$ (the bracket is zero). We assume $n\ge 2$ (for $n=1$, $GL(1,C)=C^*$ and $f=\mathrm{id}$ is immediate from (H2)).

### Assumptions for this part

We keep (H1) multiplicativity and (H2) homogeneity, and add one regularity hypothesis:

**(H3) Continuity.** $f:GL(n,C)\to C^*$ is continuous.

This is the analogue of "every $w$ has an $n$-th root": some extra input beyond the bare algebra is needed to bring analysis into play. Continuity is very mild and can be weakened (Lebesgue-measurable already suffices, by automatic-continuity theorems), but assuming it outright keeps the exposition clean. Note the *elementary* Part I assumed **no** regularity at all — that is its selling point; the Lie route deliberately trades a little regularity for conceptual transparency.

### Step 1 — Continuity upgrades to smoothness

> **Cartan–von Neumann automatic-smoothness theorem.** Every continuous homomorphism between Lie groups is real-analytic (in particular $C^\infty$).

Applied to $f$, hypothesis (H3) gives that $f$ is smooth. We may therefore differentiate it. (We do **not** assume $f$ is holomorphic; it is only smooth as a map of real manifolds. The footprint of this — a possible complex-conjugate term — appears in Step 3 and is removed by homogeneity in Step 4, exactly mirroring how the root property removed the $R$-vs-$C$ ambiguity in Part I.)

### Step 2 — The differential is a character of the Lie algebra

Let
$$\phi:=df_I:\mathfrak{gl}(n,C)\longrightarrow C=\operatorname{Lie}(C^*)$$
be the differential of $f$ at the identity. Two standard facts:

1. **$\phi$ is a Lie-algebra homomorphism**: $\phi([X,Y])=[\phi(X),\phi(Y)]$. Because the target $C$ is abelian, the right-hand side is $0$, so
$$\phi([X,Y])=0\qquad\text{for all }X,Y. \tag{$\Lambda$1}$$
2. **$f$ intertwines the exponentials**: $f(\exp X)=\exp(\phi(X))$ for all $X\in\mathfrak{gl}(n,C)$, where on the left $\exp$ is the matrix exponential and on the right it is $C\to C^*,\ z\mapsto e^{z}$. (Λ2)

Here $\phi$ is only $\mathbb{R}$-linear (we did not assume holomorphy), a point that matters in Step 3.

This is the precise Lie-theoretic shadow of Step 1–2 of Part I: conjugation-invariance and the transvection computation are the *group-level* expression of (Λ1) — that $\phi$ annihilates commutators.

### Step 3 — $\phi$ vanishes on $\mathfrak{sl}(n,C)$, hence is a multiple of the trace

By (Λ1), $\phi$ vanishes on the **derived subalgebra** $[\mathfrak{g},\mathfrak{g}]$. For $\mathfrak{gl}(n,C)$ this derived subalgebra is exactly the traceless matrices:
$$[\mathfrak{gl}(n,C),\mathfrak{gl}(n,C)]=\mathfrak{sl}(n,C). \tag{$\Lambda$3}$$
Indeed $\operatorname{tr}[X,Y]=0$ gives "$\subseteq$", while $e_{ij}=[e_{ii},e_{ij}]$ ($i\neq j$) and $e_{ii}-e_{jj}=[e_{ij},e_{ji}]$ produce a full basis of $\mathfrak{sl}(n,C)$, giving "$\supseteq$" (and incidentally that $\mathfrak{sl}(n,C)$ is **perfect** for $n\ge2$). So $\phi$ factors through the one-complex-dimensional quotient
$$\mathfrak{gl}(n,C)/\mathfrak{sl}(n,C)\;\xrightarrow{\ \sim\ }\;C,\qquad X\longmapsto \operatorname{tr}X.$$
An $\mathbb{R}$-linear functional on this quotient is an $\mathbb{R}$-linear functional of $\operatorname{tr}X\in C$, i.e. there are constants $a,b\in C$ with
$$\phi(X)=a\,\operatorname{tr}X+b\,\overline{\operatorname{tr}X}. \tag{$\Lambda$4}$$
The conjugate term is present precisely because $\phi$ is only real-linear; it is the infinitesimal trace of the second, "anti-holomorphic" solution $A\mapsto\overline{\det A}$.

**Example ($n=2$).** $\mathfrak{sl}(2,C)=\operatorname{span}\{h,e,f_-\}$ is spanned by the three commutators $[e,f_-]=h,\ [h,e]=2e,\ [h,f_-]=-2f_-$, so any commutator-annihilating $\phi$ already vanishes on all of it; only the trace direction $I=e_{11}+e_{22}$ survives.

### Step 4 — Homogeneity forces $\phi=\operatorname{tr}$

Write $\lambda=e^{z}$ ($z\in C$; the exponential $C\to C^*$ is onto). Then $\lambda I=\exp(zI)$, and by (Λ2) and (Λ4),
$$f(\lambda I)=\exp\!\big(\phi(zI)\big)=\exp\!\big(a\,\operatorname{tr}(zI)+b\,\overline{\operatorname{tr}(zI)}\big)=\exp\!\big(a\,nz+b\,n\bar z\big).$$
Homogeneity (H2) says $f(\lambda I)=\lambda^{n}=e^{nz}$. Hence
$$\exp\!\big(a\,nz+b\,n\bar z\big)=\exp(nz)\qquad\text{for all }z\in C.$$
The function $z\mapsto a n z+b n\bar z-nz$ is continuous, takes values in $2\pi i\,\mathbb{Z}$, and vanishes at $z=0$; by connectedness of $C$ it is identically $0$. Thus $a z+b\bar z=z$ for all $z\in C$, and since $z$ and $\bar z$ are $\mathbb{R}$-independent,
$$a=1,\qquad b=0,\qquad\text{i.e.}\qquad \boxed{\ \phi=\operatorname{tr}.\ } \tag{$\Lambda$5}$$

This is the exact counterpart of Layer 2 of Part I ("$g=\mathrm{id}$"). Homogeneity does one job in both proofs: it discards the spurious second solution — here the conjugate-trace term $b\,\overline{\operatorname{tr}}$ (whose group-level form is $\overline{\det}$), there the branch $g(-1)=+1$ (whose form is $|\det|$).

### Step 5 — Integrate: $f$ is the product of the eigenvalues

Combining (Λ2) and (Λ5),
$$f(\exp X)=\exp(\operatorname{tr}X)\qquad\text{for all }X\in\mathfrak{gl}(n,C). \tag{$\Lambda$6}$$
Because $G=GL(n,C)$ is **connected**, a continuous homomorphism is determined by its differential, so (Λ6) determines $f$ on all of $G$. We make it fully explicit. Over $C$ the matrix exponential $\exp:\mathfrak{gl}(n,C)\to GL(n,C)$ is **surjective**, so every invertible $A$ equals $\exp X$ for some $X$. If $X$ has eigenvalues $\mu_1,\dots,\mu_n$ (with multiplicity), then $A=\exp X$ has eigenvalues $\lambda_i=e^{\mu_i}$, and $\operatorname{tr}X=\sum_i\mu_i$, so (Λ6) gives
$$f(A)=\exp\!\Big(\sum_i\mu_i\Big)=\prod_i e^{\mu_i}=\prod_{i=1}^n\lambda_i(A). \tag{$\Lambda$7}$$
Thus **$f$ is the product of the eigenvalues** of $A$, counted with algebraic multiplicity — independent of the chosen $X$. (Surjectivity of $\exp$ over $C$ is the precise place the proof uses the complex field, just as the $n$-th-root property was in Part I; over $R$ it fails — e.g. $\operatorname{diag}(-1,-2)$ is not a real exponential — which is the analytic shadow of the missing real $n$-th roots.)

**Example ($n=2$).** For $A=\begin{pmatrix}2&1\\0&3\end{pmatrix}$, eigenvalues $2,3$, so $f(A)=6$. For a rotation-scaling $A=r\begin{pmatrix}\cos\theta&-\sin\theta\\\sin\theta&\cos\theta\end{pmatrix}=\exp\!\begin{pmatrix}\log r&-\theta\\\theta&\log r\end{pmatrix}$, $\operatorname{tr}=2\log r$, so $f(A)=e^{2\log r}=r^2$, matching $\lambda_1\lambda_2=(re^{i\theta})(re^{-i\theta})=r^2$.

### Step 6 — The top exterior power gives the Leibniz formula

It remains to write $\prod_i\lambda_i$ in coordinates. This is the natural job of the **top exterior power** $\Lambda^n(C^n)$, a one-dimensional space with basis $e_1\wedge\cdots\wedge e_n$. Any linear map $A$ induces a linear map $\Lambda^n A$ on this line, i.e. multiplication by a scalar $\delta(A)$:
$$(Ae_1)\wedge(Ae_2)\wedge\cdots\wedge(Ae_n)=\delta(A)\;e_1\wedge\cdots\wedge e_n. \tag{$\Lambda$8}$$
Two properties are immediate from functoriality of $\Lambda^n$: $\delta(AB)=\delta(A)\delta(B)$ (so $\delta$ is multiplicative and continuous, a polynomial in the entries), and on a diagonalizable $A$ with eigenvalues $\lambda_i$, choosing an eigenbasis, $\delta(A)=\prod_i\lambda_i$.

Now expand (Λ8) in coordinates. Writing the columns $Ae_k=\sum_{j} A_{jk}\,e_j$ and using multilinearity and antisymmetry of the wedge ($e_{j_1}\wedge\cdots\wedge e_{j_n}=0$ if any index repeats, and $=\operatorname{sgn}(\sigma)\,e_1\wedge\cdots\wedge e_n$ when $(j_1,\dots,j_n)=(\sigma(1),\dots,\sigma(n))$),
$$(Ae_1)\wedge\cdots\wedge(Ae_n)=\sum_{j_1,\dots,j_n}A_{j_1 1}\cdots A_{j_n n}\;e_{j_1}\wedge\cdots\wedge e_{j_n}
=\Big(\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{\sigma(k),k}\Big)e_1\wedge\cdots\wedge e_n.$$
Comparing with (Λ8),
$$\delta(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{\sigma(k),k}
=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)}, \tag{$\Lambda$9}$$
the two sums being equal by the substitution $\sigma\mapsto\sigma^{-1}$ (which preserves the sign). This is the **Leibniz formula**.

Finally, $\delta$ and $f$ are both continuous and, by (Λ7) and the eigenvalue computation above, agree on the **dense** set of diagonalizable invertible matrices (both equal $\prod_i\lambda_i$ there). Two continuous functions agreeing on a dense set agree everywhere, so $f=\delta$ on all of $GL(n,C)$:
$$\boxed{\,f(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}A_{i,\sigma(i)}\,.}$$

The Leibniz formula is recovered — now as the coordinate expression of the action on the top exterior power, i.e. of the one-dimensional representation $\Lambda^n$ of $GL(n,C)$.

### How the two proofs correspond

| Elementary (Part I) | Lie-theoretic (Part III) |
|---|---|
| conjugation invariance, $f$ trivial on transvections (Steps 1–2) | $\phi=df_I$ annihilates commutators (Λ1); vanishes on $[\mathfrak g,\mathfrak g]=\mathfrak{sl}_n$ (Λ3) |
| $f(\operatorname{diag})=g(\prod d_i)$, $g$ a homomorphism (Step 3) | $\phi=a\operatorname{tr}+b\,\overline{\operatorname{tr}}$ on the quotient $\mathfrak{gl}_n/\mathfrak{sl}_n\cong C$ (Λ4) |
| homogeneity $\Rightarrow g=\mathrm{id}$, using $n$-th roots in $C$ (Layer 2) | homogeneity $\Rightarrow \phi=\operatorname{tr}$ ($a=1,b=0$) (Λ5) |
| second branch $g(-1)=+1$ over $R$, giving $\lvert\det\rvert$ | conjugate term $b\,\overline{\operatorname{tr}}$, giving $\overline{\det}$ |
| $f$ multilinear & alternating in rows (Steps 5–6) | $f$ = action on $\Lambda^n$; antisymmetry of the wedge (Λ8) |
| basis expansion $\Rightarrow$ Leibniz (Step 7) | wedge expansion $\Rightarrow$ Leibniz (Λ9) |
| uses $n$-th roots in $C$ once (Layer 2) | uses $\exp$ surjective / $G$ connected over $C$ (Steps 4–5) |

Both proofs are the same story told at two levels: *kill the commutators, read off the one remaining degree of freedom on the torus / Cartan, and let homogeneity fix it.* The elementary version pays nothing in regularity but does the bookkeeping by hand; the Lie version assumes continuity and lets the exponential map and the top exterior power do the bookkeeping automatically.

---

## Part IV — Determinants of tensors and tensor densities

The note characterised the determinant on $GL(n,C)$ as the unique homogeneous homomorphism. Tensors fit the *same* machinery through a single notion — the **relative invariant** — whose multiplier is forced, by Layer 1, to be a character $g(\det S)$. This both extends "determinant" to tensors and resolves a familiar puzzle from differential geometry: why the determinant of a $(1,1)$-tensor $A^i{}_j$ is an honest invariant scalar, while the determinant of a $(0,2)$-tensor $A_{ij}$ — such as the metric $g_{\mu\nu}$ — is only a *density*, invariant up to a power of the Jacobian.

Throughout, $V=C^n$ with dual $V^*$, and a change of basis is a map $S\in GL(V)$. We use the passive convention: under the new basis $e'_i=S^j{}_i e_j$, contravariant (upper) components transform by $S^{-1}$ and covariant (lower) components by $S$. We write $\det$ for the operator determinant already derived in this note; the tensor determinants below are *built on top of it*.

### 1. Relative invariants and their multiplier

Call a scalar function $F$ of a tensor a **relative invariant** if, under a change of basis $S\in GL(V)$, it reproduces itself up to a scalar:
$$F(S\!\cdot\!A)=c(S)\,F(A),$$
where $S\!\cdot\!A$ is the transformation law of $A$ — which depends on its index type,
$$(1,1):\ S\!\cdot\!A=S^{-1}AS,\qquad (0,2):\ S\!\cdot\!A=S^{T}AS,\qquad (2,0):\ S\!\cdot\!A=S^{-1}AS^{-T},\ \dots$$
and $c(S)\in C^*$, the **multiplier**, depends only on $S$, not on $A$. A genuine tensor scalar — a *true* invariant — is the special case $c\equiv1$.

Not every scalar function qualifies. For example $F(A)=A_{11}$, a single component, is **not** a relative invariant: a change of basis mixes $A_{11}$ with the other entries, and no $A$-independent factor $c(S)$ can undo that. But $F=\det$, $F=\det g_{\mu\nu}$ (the metric determinant), and $F=\sqrt{|\det g_{\mu\nu}|}$ (the volume element) all are, as the subsections below verify.

**The multiplier is a character.** The transformations compose — they form an action of $GL(V)$, with $(ST)\!\cdot\!A=T\!\cdot\!(S\!\cdot\!A)$ (e.g. for $(0,2)$, $(ST)^{T}A(ST)=T^{T}(S^{T}AS)T$). Iterating the defining relation,
$$c(ST)\,F(A)=F\big((ST)\!\cdot\!A\big)=c(T)\,c(S)\,F(A),$$
so for $F\not\equiv0$, $c(ST)=c(S)c(T)$ ($C^*$ is abelian): **$c:GL(V)\to C^*$ is a homomorphism**. By **Layer 1** of Part I — every homomorphism $GL(V)\to C^*$ is trivial on transvections, hence factors through $\det$ —
$$\boxed{\,c(S)=g(\det S)\qquad\text{for some homomorphism }g:C^*\to C^*.\,}$$
We **cannot** invoke homogeneity to pin $g$ here, as we did for the determinant itself: $c$ is handed to us by the tensor type, with no normalization on scalar matrices to exploit. So $g$ stays general — a relative invariant's multiplier is an arbitrary character $g\circ\det$ of $GL(V)$.

**Classifying $g$ (continuity / measurability).** Adding the mild hypothesis that $g$ is continuous — equivalently measurable, by automatic continuity — the homomorphisms $C^*\to C^*$ are exactly those of the introduction,
$$g(w)=|w|^{s}\Big(\tfrac{w}{|w|}\Big)^{k}=w^{p}\,\bar w^{q},\qquad s\in C,\ k\in\mathbb Z,\quad p-q=k\in\mathbb Z.$$
Hence, with $w=\det S$, the possible multipliers are
$$c(S)=|\det S|^{s}\Big(\tfrac{\det S}{|\det S|}\Big)^{k}=(\det S)^{p}\,\overline{(\det S)}^{\,q},$$
the **characters** of $GL(V)$. Every relative invariant transforms by one of these, and the exponents — the pair $(p,q)$, equivalently $(s,k)$ — are its **weight**. (Without any regularity $g$ could be a wild abstract homomorphism; the factorization $c=g\circ\det$ still holds, and continuity is only what catalogues the $g$'s.)

The remaining subsections place each standard object at its point in this family: true scalars at $c\equiv1$, the determinants of $(1,1)$, $(0,2)$, $(2,0)$ tensors, the metric density $\det g_{\mu\nu}$, and the volume element $\sqrt{|\det g|}$.

### 2. $(1,1)$-tensors $A^i{}_j$: the determinant is an invariant scalar

A $(1,1)$-tensor *is* a linear map $V\to V$, and the contraction $A^i{}_kB^k{}_j$ *is* composition of maps. So both hypotheses of the note hold verbatim — $f(AB)=f(A)f(B)$ and $f(\lambda I)=\lambda^{n}$ — and produce $\det(A^i{}_j)$.

It is a *true scalar* — a relative invariant with $c\equiv1$. Under a change of basis a $(1,1)$-tensor transforms by **conjugation**, $S\!\cdot\!A=S^{-1}AS$, and Step 1 of the note (homomorphism $\Rightarrow$ conjugation invariance) gives
$$\det(S^{-1}AS)=\det(A),$$
so $c(S)=g(\det S)=1$ (here $g\equiv1$, the trivial character).
Intrinsically $\det(A^i{}_j)=\Lambda^{n}A\in\operatorname{End}(\Lambda^{n}V)=C$ is the scalar by which $A$ acts on the one-dimensional top exterior power. In index form,
$$\det(A)=\tfrac1{n!}\,\tilde\epsilon_{i_1\cdots i_n}\,\tilde\epsilon^{\,j_1\cdots j_n}\,A^{i_1}{}_{j_1}\cdots A^{i_n}{}_{j_n},$$
using one *covariant* permutation symbol (to saturate the upper indices of $A$) and one *contravariant* one (for the lower indices). As we count in §6 this is **weight $0$**, hence invariant — the determinant of an endomorphism needs no metric and no choice of basis.

### 3. $(0,2)$-tensors $A_{ij}$: the determinant is a weight-$2$ density

Now there is no composition: two lower-index tensors $A_{ij}$ and $B_{ij}$ cannot be contracted into a third $(0,2)$-tensor, so $f(AB)=f(A)f(B)$ has *no meaning*. The structure that *does* survive is the action of $GL(V)$ on bilinear forms by **congruence** — the way a $(0,2)$-tensor pulls back under a change of basis:
$$A\longmapsto S^{T}AS,\qquad (S^{T}AS)_{ij}=S^k{}_iS^l{}_jA_{kl}.$$
We characterise the form-determinant **by its properties**, exactly as the note characterised $\det$ on $GL$ — never by writing down a formula — and then *derive* existence and uniqueness. The two axioms are the direct analogues of (H1)–(H2), with "multiplicativity" now meaning multiplicativity under congruence:

- **(T1)** $f(S^{T}AS)=c(S)\,f(A)$ for all $S\in GL(V)$ (congruence-multiplicativity);
- **(T2)** $f(\lambda A)=\lambda^{n}f(A)$ (homogeneity).

**The weight is forced** (with no regularity, no Leibniz, no transpose identity). Applying (T1) twice and using $(ST)^{T}A(ST)=T^{T}(S^{T}AS)T$ gives $c(ST)=c(S)c(T)$: the multiplier $c$ is a *homomorphism* $GL(V)\to C^*$. By the note's own result — a homomorphism is trivial on transvections, hence on $SL$ — it factors through the determinant, $c=g\circ\det$ with $g:C^*\to C^*$ a homomorphism (§1). Homogeneity then pins $g$: taking $S=\mu I$, (T1) gives $f(\mu^{2}A)=c(\mu I)\,f(A)=g(\mu^{n})\,f(A)$ while (T2) gives $f(\mu^{2}A)=\mu^{2n}f(A)$, so $g(\mu^{n})=\mu^{2n}$; since $\mu\mapsto\mu^{n}$ is onto $C^*$ (divisibility), $g(w)=w^{2}$. Hence
$$\boxed{\ c(S)=\det(S)^{2},\qquad f(S^{T}AS)=\det(S)^{2}\,f(A).\ }$$
This is the divisibility argument of Layer 2 transplanted to forms. Without (T2) the homomorphism $c$ stays free — $c=|\det|^{2}$ (solution $f=|\det(A_{ij})|$) and $c=\overline{\det}^{\,2}$ ($f=\overline{\det(A_{ij})}$) also satisfy (T1) — and once again homogeneity is what selects the polynomial branch over the $|\det|$ one.

**Uniqueness.** Over $C$ every nondegenerate symmetric form is a single congruence orbit (Sylvester: $A=S^{T}IS$). If $f_1,f_2$ both obey (T1)–(T2) they share $c=\det^{2}$, so $f_i(A)=\det(S)^{2}f_i(I)$ and the ratio $f_1(A)/f_2(A)=f_1(I)/f_2(I)$ is constant. So $f$ is **unique up to overall scale**, fixed by the normalisation $f(I)=1$. (A general non-symmetric $A_{ij}$ falls into several congruence orbits; there the witness below is what ties the scales across orbits together — for a metric, one orbit suffices.)

**Existence.** One explicit function obeys the axioms, and — exactly as the note anchors the existence of $\det$ on the Leibniz *polynomial* $L$ (part 2 of Layer 1) — it serves only as a *witness*, not as the definition: the component determinant satisfies $\det(S^{T}AS)=\det(S^{T})\det(A)\det(S)=\det(S)^{2}\det(A)$ and $\det(\lambda A)=\lambda^{n}\det(A)$, with $c=\det^{2}$ and $\det(I)=1$.

So a form-determinant exists, is unique up to scale, and is a **relative invariant of weight $2$** — a density, not a scalar.

**Intrinsic home.** A form is a map $A:V\to V^*$ (namely $v\mapsto A(v,\cdot)$), so $\Lambda^{n}A:\Lambda^{n}V\to\Lambda^{n}V^*$ and therefore
$$\det(A_{ij})\in\operatorname{Hom}(\Lambda^{n}V,\Lambda^{n}V^*)=(\Lambda^{n}V^*)^{\otimes 2},$$
the **square of the volume line**. Choosing a basis trivialises this one-dimensional space by $(e^1\wedge\cdots\wedge e^n)^{\otimes2}$, and the *number* $\det(A_{ij})$ is the coefficient; the trivialisation changes by $\det(S)^{2}$, which is the weight. (Check: the component determinant scales by $\det(S)^{2}$ while the squared volume scales by $\det(S)^{-2}$, so $\det(A_{ij})\,(e^1\wedge\cdots\wedge e^n)^{\otimes2}$ is basis-independent.)

**The metric.** This is exactly why $\det(g_{\mu\nu})$ is a *scalar density*. Under a coordinate change $x\to x'$ with Jacobian $J=\det(\partial x'/\partial x)$, the metric transforms by congruence, $g'_{\mu\nu}=\frac{\partial x^\alpha}{\partial x'^\mu}\frac{\partial x^\beta}{\partial x'^\nu}g_{\alpha\beta}$ with $S=\partial x/\partial x'$, $\det S=J^{-1}$, so
$$\det(g'_{\mu\nu})=J^{-2}\det(g_{\mu\nu}).$$
It is invariant *up to* $J^{-2}$ — "weight $2$" (the word's sign convention varies; the transformation law does not). It is as invariant as the index structure permits, and no more.

### 4. A concrete construction: the square root / vielbein

Over $C$ every nondegenerate symmetric form is a single congruence class (Sylvester), so $A=S^{T}S$ for some $S$. Then
$$\det(A)=\det(S^{T}S)=\det(S)^{2},$$
and the form-determinant is literally the **square of an operator determinant** of a "frame" $S$ — making the weight $2$ manifest and reducing the new object to the old one. The ambiguity $S\mapsto OS$ with $O^{T}O=I$ rescales $\det(S)$ by $\det(O)=\pm1$, leaving $\det(S)^{2}$ untouched, so the construction is well defined.

In physics this is the vielbein/tetrad: $g=e^{T}e$, and the genuine **weight-$1$** density $\sqrt{|\det g|}=|\det e|$ is the square root that lives in a *single* volume line $\Lambda^{n}V^*$ (not its square). It is this weight-$1$ object that makes
$$\sqrt{|\det g|}\;d^{n}x$$
coordinate-invariant ($\sqrt{|g|}\to|J|^{-1}\sqrt{|g|}$ while $d^{n}x\to|J|\,d^{n}x$) — which is why $\sqrt{|g|}$, and not $\det g$ itself, is the integration measure.

### 5. Where the weights live: the homomorphism family, and $\sqrt{|g|}$

The weights above — $0$ for $A^i{}_j$, $\pm2$ for $A_{ij},A^{ij}$, and $1$ for $\sqrt{|\det g|}$ — are not independent oddities: each is the **weight** of a relative invariant, a point of the character family $c=g\circ\det$ with $g(w)=w^{p}\bar w^{q}$ of §1. Writing $w=\det S$:

| object | multiplier $c(S)$ | $g(w)$ | $(p,q)$ |
|---|---|---|---|
| $\det(A^i{}_j)$ | $1$ | $1$ | $(0,0)$ |
| $\det(g_{\mu\nu})$ | $\det(S)^{2}$ | $w^{2}$ | $(2,0)$ — holomorphic |
| $\overline{\det(g_{\mu\nu})}$ | $\overline{\det S}^{\,2}$ | $\bar w^{2}$ | $(0,2)$ |
| $\sqrt{\lvert\det g_{\mu\nu}\rvert}$ | $\lvert\det S\rvert$ | $\lvert w\rvert$ | $(\tfrac12,\tfrac12)$ — modulus |

The **determinant** sits in the holomorphic integer corner; the **volume density** $\sqrt{|\det g|}$ sits on the modulus diagonal $(\tfrac12,\tfrac12)$ — its weight is the character $|w|=w^{1/2}\bar w^{1/2}$. (As a bare function of $w=\det g$ it is $|w|^{1/2}=w^{1/4}\bar w^{1/4}$; the factor $2$ is just that $\det g$ already carries weight $2$. The structural object is the multiplier, at $(\tfrac12,\tfrac12)$.)

Two consequences are worth drawing out.

**The integrator uses exactly the branch the determinant discards.** Homogeneity, in isolating $\det$, *rejects* the modulus characters: $|\det|$ fails $f(\lambda I)=\lambda^{n}$ (it gives $|\lambda|^{n}$). But a measure *must* rescale by $|J|$, a positive real number, so the integration density is forced to be the modulus character $|\det S|=|J|^{-1}$ — precisely the discarded branch. The determinant's reject pile is the integrator's tool, and that is why the invariant volume element is $\sqrt{|\det g|}\,d^{n}x$ and nothing holomorphic in $\det g$.

**Single-valuedness is the $p-q\in\mathbb Z$ constraint once more.** A *holomorphic* square root $\det^{1/2}$ would be $(p,q)=(\tfrac12,0)$, with $p-q=\tfrac12\notin\mathbb Z$: multivalued — the metalinear / half-form obstruction. The *modulus* root $\sqrt{|\det g|}$ is $(\tfrac12,\tfrac12)$, with $p-q=0\in\mathbb Z$: single-valued. Taking the modulus restores integrality, which is exactly why $\sqrt{|g|}$ exists globally as an honest measure while $\det^{1/2}$ does not. (For a real metric this is the real shadow: the weight is the character $|\det|=|J|^{-1}$ on $GL(n,R)$, the $\mathbb R$-analogue of the point $(\tfrac12,\tfrac12)$.)

### 6. The general rule: weight $=$ (\#lower) $-$ (\#upper)

For a two-index tensor the determinant is always "the determinant of the underlying matrix"; only its **weight** changes, and the weight is read straight off the multiplicativity of $\det$: a basis change sends the component matrix to $M_1AM_2$ with $M_1,M_2\in\{S,S^{-1},S^{T},S^{-T}\}$ fixed by the index types, and $\det(M_1AM_2)=\det(M_1)\det(M_2)\det(A)$, so the weight is the total power of $\det(S)$. The cleanest bookkeeping is the Levi-Civita form: saturate each index of $A$ with a permutation symbol, using a *contravariant* symbol $\tilde\epsilon^{\,\cdots}$ (a weight $+1$ density) for each **lower** index of $A$, and a *covariant* symbol $\tilde\epsilon_{\cdots}$ (weight $-1$) for each **upper** index. The leftover weight is the sum of the symbols' weights:

| tensor | transformation | $\det$ in Levi-Civita form | weight | lives in |
|---|---|---|---|---|
| $A^i{}_j$ | $S^{-1}AS$ (conjugation) | $\tfrac1{n!}\,\tilde\epsilon_{i_1\cdots i_n}\,\tilde\epsilon^{\,j_1\cdots j_n}\prod A^{i}{}_{j}$ | $0$ | $C$ (scalar) |
| $A_{ij}$ | $S^{T}AS$ (congruence) | $\tfrac1{n!}\,\tilde\epsilon^{\,i_1\cdots i_n}\,\tilde\epsilon^{\,j_1\cdots j_n}\prod A_{ij}$ | $+2$ | $(\Lambda^{n}V^*)^{\otimes2}$ |
| $A^{ij}$ | $S^{-1}AS^{-T}$ | $\tfrac1{n!}\,\tilde\epsilon_{i_1\cdots i_n}\,\tilde\epsilon_{j_1\cdots j_n}\prod A^{ij}$ | $-2$ | $(\Lambda^{n}V)^{\otimes2}$ |

So $\det(A^i{}_j)$ is the invariant (metric-free) determinant; $\det(A_{ij})$ is the metric-type density (e.g. $\det g_{\mu\nu}$); and $\det(A^{ij})$ is the inverse-metric density (e.g. $\det g^{\mu\nu}=1/\det g_{\mu\nu}$). The "$+1/-1$ per index" is just the statement that $\Lambda^{n}$ contributes a factor $\det(S)^{-1}$ for each upper index of $A$ (a vector volume) and $\det(S)^{+1}$ for each lower index (a covector volume) — i.e. exactly the integer powers $\det(S)^{m}$ that multiplicativity produces. The symbol weights $\pm1$ are the standard ones, consistent with the Levi-Civita *tensor* $\epsilon_{i_1\cdots i_n}=\sqrt{|g|}\,\tilde\epsilon_{i_1\cdots i_n}$ being weight $0$ and $\sqrt{|g|}$ being weight $1$.

In one sentence: **the determinant of a $2$-index tensor transforms by a power of $\det(S)$ set by its index type — weight $=$ (\#lower) $-$ (\#upper) — directly from $\det(XY)=\det(X)\det(Y)$; these integer powers $\det^{m}$ are precisely the *polynomial* characters of $GL$, and tensor densities are the determinants valued in those lines.**

### 7. Higher-valence tensors

The clean story stops at two indices: a determinant of $A^i{}_j$ used both squareness (an $n\times n$ array) and the single character $\det$. A genuinely higher tensor such as $A_{ijk}$ has no analogous single-character invariant; the relevant objects are **hyperdeterminants** (Cayley), which are of higher degree and are relative invariants of a *product* $GL\times GL\times\cdots$ rather than characters of one $GL$. They fall outside the one-line mechanism above and need their own theory.

### 8. Reconciliation with the classical tensor-density zoo

Differential geometry classifies densities over the *reals*, $GL(n,R)$, where the only invariant of a change of basis is the real Jacobian $J:=\det S$. Textbooks then split densities four ways — and all four are special cases of the multiplier $c(S)=g(\det S)$ of §1. Two parallel labelling schemes are used for the behaviour under an *orientation-reversing* ($J<0$) change:

| scheme | no sign flip | sign flip |
|---|---|---|
| integer weight only | **(authentic)**, $c=J^{W}$ | **pseudo**, $c=\operatorname{sgn}(J)\,J^{W}$ |
| any real weight | **even**, $c=\lvert J\rvert^{W}$ | **odd**, $c=\operatorname{sgn}(J)\,\lvert J\rvert^{W}$ |

They agree for integer $W$ by parity (*authentic* $W$ is *even* for even $W$, *odd* for odd $W$; *pseudo* is the opposite). Named corners: an **ordinary/true tensor** is $W=0$ with no flip; an **absolute tensor** is any $W=0$; a **tensor capacity** has $W<0$; a bare "density" defaults to $W=+1$.

**The dictionary.** For real $S$ our character collapses to
$$c(S)=(\det S)^{p}\,\overline{(\det S)}^{\,q}=|J|^{\,p+q}\,\operatorname{sgn}(J)^{\,p-q},$$
so the two classical labels are *exactly*
$$\boxed{\,W=p+q\ \ (\text{weight}),\qquad \text{even}/\text{odd}=(p-q)\bmod 2\,}$$
— **no flip $\iff p-q$ even**, **flip $\iff p-q$ odd**. The whole four-way zoo is one weight $p+q$ plus one parity bit $p-q\bmod2$. (The signs match the standard convention: $\det g_{\mu\nu}\mapsto W{=}{+}2$, $\sqrt{-g}\mapsto W{=}{+}1$.)

**Real vs. complex.** Real densities see only $\big(p+q,\ (p-q)\bmod2\big)$ — the *parity* of the winding $p-q$, not its value. The complex character $(p,q)$ of §1 is strictly **finer**: it remembers the full $p-q\in\mathbb Z$, which collapses over $R$ because $J^{2}=|J|^{2}$. So each classical type is really a $\mathbb Z$-family $\{(p,q),(p{+}1,q{-}1),\dots\}$; e.g. $\det g_{\mu\nu}$ sits at the holomorphic $(2,0)$ in §5 but equals the even-density representative $(1,1)$ over $R$.

**General types**, with the simplest $(p,q)$ lift:

| classical type | factor $c$ | $W$ | parity | $(p,q)$ |
|---|---|---|---|---|
| ordinary (true) tensor | $1$ | $0$ | even | $(0,0)$ |
| even density, weight $W$ | $\lvert J\rvert^{W}$ | $W$ | even | $(\tfrac W2,\tfrac W2)$ |
| odd density, weight $W$ | $\operatorname{sgn}(J)\,\lvert J\rvert^{W}$ | $W$ | odd | $(\tfrac{W+1}2,\tfrac{W-1}2)$ |
| authentic, integer $W$ | $J^{W}$ | $W$ | $W\bmod2$ | $(W,0)$ |
| pseudo, integer $W$ | $\operatorname{sgn}(J)\,J^{W}$ | $W$ | $(W{+}1)\bmod2$ | $(\tfrac{W+1}2,\tfrac{W-1}2)$ |
| absolute tensor (even) | $1$ | $0$ | even | $(0,0)$ |
| pseudoscalar (odd, $W{=}0$) | $\operatorname{sgn}(J)$ | $0$ | odd | $(\tfrac12,-\tfrac12)$ |
| tensor capacity (even $W{=}{-}1$) | $\lvert J\rvert^{-1}$ | $-1$ | even | $(-\tfrac12,-\tfrac12)$ |
| scalar/vector density (default) | $\lvert J\rvert$ | $1$ | even | $(\tfrac12,\tfrac12)$ |

**Concrete objects:**

| object | factor $c$ | $W$ | parity | $(p,q)$ |
|---|---|---|---|---|
| $\det g_{\mu\nu}$ | $J^{2}=\lvert J\rvert^{2}$ | $2$ | even | $(1,1)\equiv(2,0)$ |
| $\sqrt{-g}=\sqrt{\lvert g\rvert}$ | $\lvert J\rvert$ | $1$ | even | $(\tfrac12,\tfrac12)$ |
| $1/\sqrt{-g}$ | $\lvert J\rvert^{-1}$ | $-1$ | even | $(-\tfrac12,-\tfrac12)$ |
| $\det g^{\mu\nu}=1/g$ | $J^{-2}=\lvert J\rvert^{-2}$ | $-2$ | even | $(-1,-1)\equiv(-2,0)$ |
| Levi-Civita symbol $\tilde\epsilon^{i_1\cdots i_n}$ | $\operatorname{sgn}(J)\,\lvert J\rvert$ | $+1$ | odd | $(1,0)$ |
| Levi-Civita symbol $\tilde\epsilon_{i_1\cdots i_n}$ | $\operatorname{sgn}(J)\,\lvert J\rvert^{-1}$ | $-1$ | odd | $(-1,0)$ |

In short: **the determinant, the metric density, the volume element, the Levi-Civita symbols, and the entire authentic/pseudo/even/odd taxonomy are one object — a character $(\det S)^{p}\overline{(\det S)}^{q}$ — read at different $(p,q)$.** Weight is $p+q$; the orientation sign-flip is the parity of $p-q$; and the refinement $p-q\in\mathbb Z$ is the piece the real classification cannot see.

### 9. Relation to the literature

None of the *theorems* above are new; the value is the ab-initio route and the single dictionary. For context:

- **Relative invariants are classical.** The defining relation $F(S\!\cdot\!A)=c(S)F(A)$, with $c$ a character, is exactly the notion of a *relative invariant* (or *semi-invariant*) in invariant theory — central, for instance, in Sato–Kimura's theory of prehomogeneous vector spaces and in the semi-invariants of quiver representations. That the multiplier $c$ must be a character is the standard first step there, and is our §1.
- **Characters of $GL$ are $\det$-powers.** The factorization $c=g\circ\det$ together with $g(w)=w^{p}\bar w^{q}$ is the (continuous) character group of $GL(n,C)$ as a real Lie group; its rational/holomorphic part is the character lattice $X(GL_n)=\mathbb Z\cdot\det$, a textbook fact of linear algebraic groups.
- **Densities are one-dimensional representations.** In differential geometry tensor densities are the sections of the line bundles associated to the characters $\det^{p}\overline{\det}^{q}$ (the theory of *natural bundles*); the even/odd dichotomy is the character of $\pi_0\,GL(n,R)=\mathbb Z/2$, i.e. orientation. The classical authentic/pseudo/even/odd taxonomy of §8 is this character group written in physics notation.

What the note adds is not a theorem but an organisation: **everything follows from the one axiom** $F(S\!\cdot\!A)=c(S)F(A)$ — determinant, metric density, $\sqrt{\lvert g\rvert}$, Levi-Civita symbols, and the whole zoo are one character $(\det S)^{p}\overline{(\det S)}^{q}$, with $(W,\text{parity})=(p+q,\,(p-q)\bmod2)$ over $R$ and a genuine $\mathbb Z$-refinement over $C$.

**The universal multiplier, three ways.** Everything rests on the single fact that *every* multiplier factors through $\det$ — equivalently that $GL/SL\xrightarrow{\ \det\ }C^*$ is the abelianisation. The note proves this three independent times, and any one suffices:

1. **Commutators** (Step 2 / Lie chapter §4): $c$ kills $[GL,GL]=SL$ because transvections are commutators and generate $SL$, so $c$ sees $S$ only through $\det S$.
2. **Trace** (Part III, (Λ1)–(Λ5); spelled out in §11): $dc_I$ vanishes on $[\mathfrak{gl}_n,\mathfrak{gl}_n]=\mathfrak{sl}_n$, so $dc_I=a\operatorname{tr}$ and $c=\det^{a}$ — trace is the only linear invariant, $\det=e^{\operatorname{tr}}$ its integral.
3. **Eigenvalues + Weyl** (Lie chapter §5): a torus character $\prod_i\lambda_i^{m_i}$ that is symmetric in the $\lambda_i$ has all $m_i$ equal, so it is $(\prod_i\lambda_i)^m=\det^m$.

In one line: $\det$ is the universal multiplier because it *generates the Weyl-invariant character lattice* — it is the abelianisation of $GL$, and a relative invariant can see nothing finer than $\det S$.

### 10. Beyond densities: other relative invariants

The definition $F(S\!\cdot\!A)=c(S)F(A)$ is far more general than tensor densities; densities are just its "$GL(n)$ acting on one tensor" slice. Three directions show what else it captures.

**Same group, richer objects.** Tensor densities exhaust the *scalar functions of one matrix-like tensor* (§1). On other $GL(n,C)$-representations the relative invariants are the staples of classical invariant theory — still with a $\det$-power multiplier, but genuinely new functions:

- **Pfaffian** — the polynomial square root of the determinant that the metalinear obstruction forbade for symmetric forms (§5). On *antisymmetric* forms ($A=-A^{T}$, $n=2m$), $\det A=\operatorname{Pf}(A)^{2}$ is a perfect square, so
$$\operatorname{Pf}(S^{T}AS)=\det(S)\,\operatorname{Pf}(A)$$
is a *single-valued* relative invariant of weight $1$, i.e. $(p,q)=(1,0)$ — half the weight of $\det A$, yet rational, because the antisymmetric locus is exactly where the square root rationalises. (Contrast $\sqrt{\det g}$ for symmetric $g$, which is *not* a perfect square and stays multivalued — needing the modulus $\sqrt{\lvert g\rvert}$ of §5.)
- **Discriminants and resultants** of forms. The discriminant of a binary quadratic $Q=ax^{2}+bxy+cy^{2}$ is $b^{2}-4ac=-4\det M$, where $M=\big(\begin{smallmatrix}a&b/2\\ b/2&c\end{smallmatrix}\big)$ is its symmetric coefficient matrix — a $(0,2)$-tensor. A change of variables $\binom{x}{y}=S\binom{x'}{y'}$ sends $M\mapsto S^{T}MS$ (congruence), so the discriminant is just $\det g_{\mu\nu}$ for $n=2$ and transforms by $(\det S)^{2}$. Concretely, $Q=x^{2}+y^{2}$ (disc $-4$) under $S=\operatorname{diag}(2,1)$ becomes $4x'^{2}+y'^{2}$ (disc $-16=2^{2}\!\cdot\!(-4)$). It is an *even* weight-$2$ density, $(p,q)=(2,0)$: $(\det S)^{2}>0$ even when $\det S<0$ (e.g. $S=\big(\begin{smallmatrix}1&2\\3&4\end{smallmatrix}\big)$, $\det S=-2$, scales any discriminant by $4$).
- **Maximal minors / Plücker brackets**, and $\det(SAT)=\det S\,\det A\,\det T$ — a relative invariant of $GL\times GL$.
- **Hyperdeterminants** (Cayley) for $A_{ijk}$ — relative invariants of $GL\times GL\times\cdots$ (cf. §7).

**Other groups, other multipliers.** Relative-invariance is group-relative: the multiplier ranges over $X(G)$, the character group of $G$.

- **$O(n)$:** $\det=\pm1$, so the one nontrivial character is **orientation**; weight-$1$ relative invariants are **pseudoscalars** (the cross product, the Levi-Civita tensor as an $O(n)$ object).
- **$SL(n,C)$, $Sp(2n,C)$ (perfect groups):** $X(G)=\{1\}$, so the *only* multiplier is trivial — **every relative invariant is absolute**. No nontrivial densities exist; the symplectic volume is a genuine invariant.
- **Torus $(C^*)^n$ and products:** characters are monomials $\prod_i d_i^{m_i}$, giving multi-weight relative invariants (weight vectors, minors).

**The principle.** A relative invariant is precisely a nonzero vector spanning a **$G$-stable line** — a one-dimensional subrepresentation, classically a *semi-invariant*. Its multiplier is a character, so
$$\boxed{\ \{\text{relative invariants}\}\ \longleftrightarrow\ \{\text{one-dimensional subreps}\}\ \longleftrightarrow\ X(G)\ \text{(characters)}.\ }$$
For $G=GL(n,C)$ this is $X=\mathbb Z\cdot\det$ — which is *why* every multiplier is a $\det$-power and "relative invariant of $GL$" means "density." Change the group and the catalogue changes with $X(G)$. Tensor densities are the $GL(n)$ slice of this one uniform statement.

### 11. The infinitesimal (trace) route, in detail

Route 2 of §9 — that a smooth multiplier $c:GL(n,C)\to C^*$ is a power of $\det$ — is worth spelling out, since it is the Lie-theoretic Part III run *without* the homogeneity normalisation. The idea: **differentiate** $c$ to the Lie algebra, where the statement is linear and immediate, then **integrate** back with $\exp$.

**Differentiate.** A smooth homomorphism has a derivative at the identity that is itself a Lie-algebra homomorphism,
$$\phi:=dc_I:\ \mathfrak{gl}_n=T_IGL(n)\ \longrightarrow\ \operatorname{Lie}(C^*)=C,$$
where $\mathfrak{gl}_n$ is all $n\times n$ matrices with $[X,Y]=XY-YX$, and the Lie algebra of $C^*$ is $C$ with **zero bracket** ($C^*$ is abelian). [Part III, (Λ1)–(Λ2).]

**The abelian target kills brackets.** Being a Lie-algebra map into a zero-bracket target,
$$\phi([X,Y])=[\phi(X),\phi(Y)]=0\qquad\text{for all }X,Y$$
— $\phi$ annihilates every commutator. (This is the infinitesimal shadow of "$c$ kills $[GL,GL]$" from route 1.)

**Commutators are exactly the traceless matrices.** The span of all brackets is $[\mathfrak{gl}_n,\mathfrak{gl}_n]=\mathfrak{sl}_n=\{\operatorname{tr}=0\}$:

* $\subseteq$ : $\operatorname{tr}[X,Y]=\operatorname{tr}(XY)-\operatorname{tr}(YX)=0$, so every commutator is traceless;
* $\supseteq$ : the matrix units realise all of $\mathfrak{sl}_n$ as brackets, $e_{ij}=[e_{ii},e_{ij}]$ ($i\ne j$) and $e_{ii}-e_{jj}=[e_{ij},e_{ji}]$.

So $\phi$ vanishes on the hyperplane $\mathfrak{sl}_n$. [Part III, (Λ3).]

**Hence $\phi$ is a multiple of the trace.** $\operatorname{tr}:\mathfrak{gl}_n\to C$ has kernel exactly $\mathfrak{sl}_n$, and $\mathfrak{gl}_n/\mathfrak{sl}_n\cong C$ is one-dimensional; a functional killing $\ker(\operatorname{tr})$ must be a scalar multiple of $\operatorname{tr}$:
$$\phi(X)=a\,\operatorname{tr}X,\qquad a\in C.$$
This is the precise sense in which **trace is the only linear invariant** — up to scale, the unique character of the Lie algebra. [Part III, (Λ4).]

**Integrate with $\exp$.** A homomorphism intertwines the exponential maps, $c(\exp X)=\exp(\phi(X))$ — the matrix exponential on the left, $z\mapsto e^z$ on the right. With the bridge identity $\det(\exp X)=e^{\operatorname{tr}X}$ (the eigenvalues of $\exp X$ are $e^{\mu_i}$, so $\det=\prod_i e^{\mu_i}=e^{\sum_i\mu_i}$),
$$c(\exp X)=e^{a\operatorname{tr}X}=(\det\exp X)^{a}.$$
Over $C$ the matrix exponential is onto $GL(n,C)$, so $c(S)=(\det S)^{a}$ for all $S$. [Part III, (Λ6)–(Λ7).] In a slogan: **$\det=e^{\operatorname{tr}}$ is the group integral of the trace** — $\operatorname{tr}$ generates the algebra's only character, and exponentiating it produces $\det$, the group's only character.

**The conjugate term restores $(p,q)$.** Because $c$ is only *smooth*, not holomorphic, $\phi$ is merely $R$-linear, so the general functional vanishing on $\mathfrak{sl}_n$ carries a conjugate piece,
$$\phi(X)=a\,\operatorname{tr}X+b\,\overline{\operatorname{tr}X}\ \Longrightarrow\ c(S)=(\det S)^{a}\,\overline{(\det S)}^{\,b},$$
which is exactly the $(p,q)=(a,b)$ character of §1/§5. So the Lie route *rederives the entire $(p,q)$ family*; the one extra ingredient Part III adds beyond this — homogeneity, (Λ5) — is what pins $a=1,b=0$ to select $\det$ itself.

So routes 1 and 2 are the same fact at two levels, joined by $\exp$: route 1 on the group ($SL=[GL,GL]$), this route on the algebra ($\mathfrak{sl}_n=[\mathfrak{gl}_n,\mathfrak{gl}_n]$). Route 1 needs no regularity; this one needs $c\in C^{1}$ to differentiate.

### 12. Connections: the affine (cocycle) cousin

Christoffel symbols are *not* relative invariants — they are not even tensors — yet they obey a law of exactly the same shape, with one addition: a translation term. They are the **affine upgrade** of a relative invariant, obtained by replacing the multiplicative target $C^*$ with the *affine group*.

**The equation.** A relative invariant scales, $F\xrightarrow{g}c(g)F$. A connection transforms the same way *plus a shift*:
$$\Gamma\ \xrightarrow{\ g\ }\ \rho(g)\,\Gamma+\beta(g),$$
where $\rho(g)$ is the linear $(1,2)$-tensor action and $\beta(g)$ — the "added constant" — is the inhomogeneous piece.

**Consistency makes $\beta$ a cocycle.** The shift is not free. Requiring that $g$ then $h$ agree with $gh$,
$$\rho(gh)\Gamma+\beta(gh)=g\!\cdot\!\big(\rho(h)\Gamma+\beta(h)\big)=\rho(gh)\Gamma+\rho(g)\beta(h)+\beta(g),$$
forces the **1-cocycle (crossed-homomorphism) condition**
$$\boxed{\ \beta(gh)=\rho(g)\,\beta(h)+\beta(g)\ }$$
— the inhomogeneous analogue of $c(gh)=c(g)c(h)$. Equivalently, $g\mapsto(\rho(g),\beta(g))$ is a homomorphism into the **affine group** $\operatorname{Aff}(V)=V\rtimes GL(V)$:

| object | homomorphism into | data |
|---|---|---|
| relative invariant / density | $C^{*}=GL_1$ | a **character** $c$ (multiplicative) |
| connection (Christoffel) | $\operatorname{Aff}(V)=V\rtimes GL(V)$ | linear part $\rho$ **+ cocycle** $\beta$ |

A relative invariant is the case $\beta=0$ with $V$ a line; turn on a translation cocycle and you get a connection. (For $\Gamma$ the group is the **$2$-jet** group of coordinate changes: $\rho$ sees only the $1$-jet $S=\partial x'/\partial x\in GL_n$, but $\beta$ needs the $2$-jet — the second derivatives.)

**Deriving the transformation.** The cocycle $\beta$ is pinned by a single demand — the one that motivates connections in the first place: **the covariant derivative must be a genuine tensor**, i.e. a relative invariant of weight $0$. With $\nabla_\mu V^\lambda=\partial_\mu V^\lambda+\Gamma^\lambda_{\mu\rho}V^\rho$, the ordinary derivative fails tensoriality by exactly a second-derivative term,
$$\partial'_\mu V'^\lambda=\frac{\partial x^\sigma}{\partial x'^\mu}\frac{\partial x'^\lambda}{\partial x^\rho}\,\partial_\sigma V^\rho+\underbrace{\frac{\partial x^\sigma}{\partial x'^\mu}\Big(\partial_\sigma\tfrac{\partial x'^\lambda}{\partial x^\rho}\Big)V^\rho}_{\text{non-tensorial}},$$
so for $\nabla V$ to transform as a $(1,1)$-tensor the shift is *forced* to be
$$\beta^\lambda_{\mu\nu}(g)=\frac{\partial x'^\lambda}{\partial x^\rho}\frac{\partial^{2}x^\rho}{\partial x'^\mu\partial x'^\nu},$$
exactly the inhomogeneous term of the Christoffel law $\Gamma'^\lambda_{\mu\nu}=\rho(g)\Gamma+\beta(g)$. So one *derives* how $\Gamma$ transforms by demanding relative invariance of the derivative; the cocycle condition then holds automatically (it is the canonical "soldering" cocycle of the jet group).

**Cohomological punchline.** Characters live in $\operatorname{Hom}(G,C^{*})$ (multiplicative — the relative-invariant data); connection shifts live in $Z^{1}(G,V)$ (the 1-cocycles — the affine data). Two connections differ by a **coboundary**, which is precisely a genuine $(1,2)$-tensor — so $\Gamma_1-\Gamma_2$ is a tensor and the space of connections is an affine torsor over that vector space. In one line:

> **A relative invariant is a homomorphism to $C^{*}$ (a character, a $0$-cocycle); a connection is a homomorphism to the affine group (a $1$-cocycle) — the same functional equation, one cohomological degree up.**

The two even meet: contracting the connection gives $\Gamma^\lambda_{\lambda\nu}=\partial_\nu\ln\sqrt{\lvert g\rvert}$, the connection $1$-form on the density line bundle. It is *not* a tensor — under a coordinate change it transforms as a covector *plus a gauge term*,
$$\Gamma'^{\lambda}_{\lambda\nu}=\frac{\partial x^\tau}{\partial x'^\nu}\,\Gamma^{\rho}_{\rho\tau}-\partial'_\nu\ln J,\qquad J=\det\!\Big(\tfrac{\partial x'}{\partial x}\Big),$$
the contraction having collapsed the linear part $\rho$ to the trivial scalar action while the cocycle $\beta$ survives as the pure-gauge $-\partial_\nu\ln J$. (Two such differ by a genuine covector — a coboundary; and $\Gamma_\nu\,dx^\nu=d\ln\sqrt{\lvert g\rvert}$ is closed, so this density connection is *flat*, $R^\lambda{}_{\lambda\mu\nu}=0$.) The covariant derivative of a weight-$w$ density then picks up the extra $-w\,\Gamma^\lambda_{\lambda\nu}$ — the affine cousin acting on the relative invariants of §1.
