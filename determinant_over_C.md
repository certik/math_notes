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

## Step 4 — Homogeneity forces $g=\mathrm{id}$

Apply (5) to $\lambda I=\operatorname{diag}(\lambda,\dots,\lambda)$ and compare with (H2):
$$g(\lambda^n)=f(\lambda I)=\lambda^n\qquad\text{for all }\lambda\in C^*.$$
Given any $w\in C^*$, pick an $n$-th root $\lambda$ with $\lambda^n=w$ (fact (R)); then $g(w)=g(\lambda^n)=\lambda^n=w$. Hence
$$g=\mathrm{id}_{C^*}. \tag{6}$$

Note: this does *not* hold for $R^*$, for example $w=-1$ has no real $\lambda$
such that $\lambda^2 = w$.

Two immediate consequences, used below: from (5) and (6) it follows
$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=g(\prod_i d_i) = \prod_i d_i, \tag{5$'$}$$
and, since left-multiplying by $\operatorname{diag}(1,\dots,\underset{i}{\lambda},\dots,1)$ scales row $i$ by $\lambda$,
so scaling a single row by $\lambda$ multiplies $f$ by $\lambda$:
$$f\big(\operatorname{diag}(1,\dots,\underset{i}\lambda\dots,1)A\big)
=f\big(\operatorname{diag}(1,\dots,\underset{i}\lambda\dots,1)\big)f(A)
=\lambda f(A)$$



---

## The main derivation — from $GL(n,C)$ to the Leibniz formula

Everything so far (Steps 1–4) takes place on $GL(n,C)$, where $f$ is genuinely defined, and three facts about $f$ are all we shall use:

* (H1) $f$ is a homomorphism $GL(n,C)\to C^*$;
* (2) $f\big(T_{ij}(c)\big)=1$ for every transvection;
* (5$'$) $f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i$.

We show these pin $f$ down **uniquely** and reproduce the **Leibniz formula**, working entirely inside $GL$ — never evaluating $f$ on a singular matrix, and with no appeal to continuity, exterior algebra, or Zariski density. (The optional Steps 5–7 below develop the classical multilinear/alternating viewpoint of $f$; the present derivation does **not** use them. The one ingredient missing for $f$ on $GL$ — the *alternating* property — enters here only as a formal identity about a polynomial, where the singular-matrix obstruction simply does not arise.)

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

From (b) and (c), adding a multiple of one row to another leaves $L$ unchanged, $L\big(T_{ij}(c)\,X\big)=L(X)$; taking $X=I$ and using (a) gives in particular $L(T_{ij}(c))=1$. Thus $L$ obeys (2) and (5$'$) outright — and, unlike the abstract $f$ on $GL$, with **no domain caveat**, because $L$ is everywhere-defined and (b) is a genuine polynomial identity even though "two equal rows" is a singular configuration. The obstruction that blocked the alternating property for $f$ has been transferred to $L$, where it evaporates.

Feed $L$ a factorization (19). Peeling the transvections of $E$ off one at a time by $L(T_{ij}(c)X)=L(X)$, then applying (a),
$$L(A)=L(E\,D)=L(D)=\prod_i d_i. \tag{20}$$

**3. $\prod_i d_i$ is well-defined.** A priori the product in (20) could depend on the factorization (19) chosen, and the concrete $L$ is exactly what rules this out. If a second factorization $A=E'D'$ gave a different product $\prod_i d_i'$, then (20) applied to *it* would read $L(A)=\prod_i d_i'$ as well; but $L(A)$ is one unambiguous number, so $\prod_i d_i=\prod_i d_i'$. Hence every factorization of $A$ yields the same product, an honest function of $A$ alone, which we write $p(A):=\prod_i d_i$. (Note we proved independence *using* the single-valued $L$ — never assuming it beforehand.)

**4. Every $f$ obeying (H1),(2),(5$'$) equals $L$.** Now let $f$ be *any* function satisfying the three properties — the given $f$ of Steps 1–4 is one such. For any factorization (19), using only those three properties,
$$f(A)=f(E)\,f(D)\overset{(\mathrm{H1})}{=}f(E)\prod_i d_i\overset{(2)}{=}\prod_i d_i=p(A),$$
the value $p(A)$ being unambiguous by part 3. By (20), the concrete polynomial $L$ satisfies $L(A)=p(A)$ as well. Therefore $f$ and $L$ take the identical value $p(A)$ at every $A$:
$$\boxed{\,f(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)}=\prod_i d_i\qquad(A\in GL(n,C)).\,}$$
This is the **Leibniz formula — derived, not postulated**. It also shows there is **at most one** function on $GL(n,C)$ obeying (H1),(2),(5$'$): every such function equals $p$ pointwise (part 4), so any two coincide; the given $f$ is one of them, and it equals the explicit polynomial $L$. The grounding is fully transparent: existence/single-valuedness is the explicit polynomial $L$ (part 2), well-definedness of the forced value $p(A)$ is anchored on $L$ (part 3), and the identification $f=p=L$ is part 4. We needed neither multiplicativity of $L$, nor continuity, nor exterior algebra, nor Zariski density.

One may now *define* $\det:=L$, a polynomial on all of $M_n(C)$; then "$f=\det$ on $GL$" is the complete statement about $f$ (recall $f$ was only ever defined on $GL$). Continuity or Zariski density would furnish alternative *extensions* of the identity to singular matrices, but are not needed for the result.

---

## Optional — the multilinear and alternating viewpoint

The two sections that follow (Steps 5–6) develop the classical multilinear and sign properties of $f$, and Step 7 expands them into the Leibniz formula. **None of this is used by the main derivation above** — it is the traditional textbook route, recorded for context and referenced by the Lie-theoretic correspondence in Part III. A reader after the shortest path may stop here.

---

## Step 5 — $f$ is multilinear in the rows

Fix all rows of an invertible matrix except row $i$; call the others $r_1,\dots,\widehat{r_i},\dots,r_n$ (they are linearly independent, since the matrix is invertible). View $f$ as a function of the single varying row $r_i$.

- By Step 2, adding any multiple of another row $r_k$ ($k\neq i$) to $r_i$ leaves $f$ unchanged. Hence $f$ depends on $r_i$ **only through its class modulo** $V:=\operatorname{span}\{r_k:k\neq i\}$. Because the other rows are independent, $\dim V=n-1$, so the quotient $C^n/V$ is **one-dimensional**, and the matrix is invertible exactly when the class of $r_i$ is nonzero.
- By (7), $f$ is homogeneous of degree $1$ in $r_i$: replacing $r_i$ by $\lambda r_i$ multiplies $f$ by $\lambda$.

A function on the one-dimensional space $C^n/V$ that is homogeneous of degree $1$ is **linear**. Concretely, fix a nonzero class $z_0$ and let $c$ be the value of $f$ there. Every nonzero class is $t\,z_0$ for a unique scalar $t\in C^*$, and degree-$1$ homogeneity forces the value to be exactly $t\,c$. This rule $t\,z_0\mapsto t\,c$ is linear by the field arithmetic of $C$ (no Hamel-basis pathologies can arise in dimension one). Pulling back, $f$ is an additive (indeed linear) function of $r_i$:
$$f(\dots,\,u+v\,,\dots)=f(\dots,u,\dots)+f(\dots,v,\dots),\qquad f(\dots,\lambda u,\dots)=\lambda\,f(\dots,u,\dots).$$
Since $i$ was arbitrary, **$f$ is multilinear in the rows.** $\tag{8}$

---

## Step 6 — Swapping two rows changes the sign

Work in the plane of coordinates $i,j$ (everything else is left fixed). The factorization
$$S_{ij}=\operatorname{diag}(1,\dots,\underset{j}{-1},\dots,1)\cdot T_{ij}(1)\,T_{ji}(-1)\,T_{ij}(1)$$
holds (it reduces to the $2\times2$ identity verified in the Appendix), where $S_{ij}$ is the permutation matrix swapping coordinates $i$ and $j$. By (H1), (2) and (5$'$)/(6),
$$f(S_{ij})=g(-1)\cdot 1=-1. \tag{9}$$
Since left-multiplication by $S_{ij}$ swaps rows $i$ and $j$, (9) and (H1) say: for every invertible $A$, swapping two of its rows multiplies $f$ by $-1$,
$$f(S_{ij}A)=-f(A)\qquad(A\in GL(n,C)). \tag{10}$$
This **antisymmetry** is a genuine statement about $GL$: a swap sends invertible matrices to invertible matrices. One is tempted to conclude at once that $f=0$ whenever two rows coincide — equate the two rows, swap them, and $f=-f$. But a matrix with two equal rows is **singular**, where $f$ is not defined, so the *alternating* property is **not** available on $GL$; the main derivation above supplies it in the only place it is needed, as a formal identity about the Leibniz polynomial.
Finally, any permutation matrix $P_\sigma$ is a product of swaps, so by (9)
$$f(P_\sigma)=\operatorname{sgn}(\sigma). \tag{11}$$

(Here is the only place the choice of branch mattered: (9) used $g(-1)=-1$ from Step 4. Had $g(-1)=+1$ — the situation that survives over $R$ for even $n$ — we would get the sign-blind "permanent" instead. Homogeneity, through (6), is exactly what selects the alternating sign.)

---

## Step 7 — The same formula via the classical basis expansion (optional)

The main derivation above already derived the boxed formula rigorously and elementarily. The familiar textbook route reaches it a different way — by expanding $f$ multilinearly over the standard basis — and is worth recording, with one caveat that the main derivation was designed to handle.

Multilinearity (8) lets one expand each row $r_i=\sum_{j}A_{ij}\,e_j$:
$$f(A)=\sum_{j_1,\dots,j_n}A_{1,j_1}\cdots A_{n,j_n}\;f(e_{j_1},\dots,e_{j_n}).$$
The surviving terms are those where $(j_1,\dots,j_n)=(\sigma(1),\dots,\sigma(n))$ for a permutation $\sigma$, contributing $f(P_\sigma)=\operatorname{sgn}(\sigma)$ by (11), and one recovers
$$\boxed{\,f(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}A_{i,\sigma(i)}\,,}$$
the **Leibniz formula**, in agreement with the main derivation.

A word on the basis expansion. The intermediate tuples $f(e_{j_1},\dots,e_{j_n})$ with a *repeated* index correspond to **singular** matrices, where $f$ was never defined — so the step "these terms vanish" cannot be justified by the abstract $f$ alone (this is the same gap that blocked the alternating property in Step 6). The clean fix is the one used in the main derivation: read every term as a value of the everywhere-defined polynomial $L(A)=\sum_\sigma\operatorname{sgn}(\sigma)\prod_i A_{i,\sigma(i)}$, whose vanishing on repeated indices is the *formal* identity (b) of the main derivation (part 2), with no domain caveat. The expansion is then a convenient mnemonic for the rigorous generating-set derivation above — and needs neither continuity nor Zariski density.

---

## Conclusion

> **Theorem.** Over $C$, any homogeneous homomorphism $f:GL(n,C)\to C^*$ is given by the Leibniz formula; i.e. $f$ is the determinant, and it is the unique such function.

Two remarks:

- **No regularity, no spectral theory.** We never assumed $f$ continuous or measurable, and never used eigenvalues, the polar decomposition, or the determinant itself. Everything came from (H1), (H2), and one use of (R).
- **Where $C$ was essential.** The single step that needed $C$ rather than $R$ is Step 4: every $w\in C^*$ — in particular $-1=i^2$ — has an $n$-th root, which forces $g=\mathrm{id}$ and hence $g(-1)=-1$, the sign in Step 6. Over $R$ with even $n$ the value $-1$ has no real $n$-th root, $g(-1)=\pm1$ stays free, and the choice $g(-1)=+1$ yields a second, sign-blind solution (the permanent-like $|\det|$). Over $C$ that ambiguity cannot occur.

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
- **Homogeneity** $\Rightarrow$ $m=1$ — this is Step 4 ("$g=\mathrm{id}$").

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
| $f(\operatorname{diag})=g(\prod d_i)$ | $f|_T$ is a Weyl-invariant character of $(C^*)^n$ |
| homogeneity fixes $g=\mathrm{id}$ (Step 4) | normalization selecting the character $\det$ (exponent $m=1$) |
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
$$\phi([X,Y])=0\qquad\text{for all }X,Y. \tag{Λ1}$$
2. **$f$ intertwines the exponentials**: $f(\exp X)=\exp(\phi(X))$ for all $X\in\mathfrak{gl}(n,C)$, where on the left $\exp$ is the matrix exponential and on the right it is $C\to C^*,\ z\mapsto e^{z}$. $\tag{Λ2}$

Here $\phi$ is only $\mathbb{R}$-linear (we did not assume holomorphy), a point that matters in Step 3.

This is the precise Lie-theoretic shadow of Step 1–2 of Part I: conjugation-invariance and the transvection computation are the *group-level* expression of (Λ1) — that $\phi$ annihilates commutators.

### Step 3 — $\phi$ vanishes on $\mathfrak{sl}(n,C)$, hence is a multiple of the trace

By (Λ1), $\phi$ vanishes on the **derived subalgebra** $[\mathfrak{g},\mathfrak{g}]$. For $\mathfrak{gl}(n,C)$ this derived subalgebra is exactly the traceless matrices:
$$[\mathfrak{gl}(n,C),\mathfrak{gl}(n,C)]=\mathfrak{sl}(n,C). \tag{Λ3}$$
Indeed $\operatorname{tr}[X,Y]=0$ gives "$\subseteq$", while $e_{ij}=[e_{ii},e_{ij}]$ ($i\neq j$) and $e_{ii}-e_{jj}=[e_{ij},e_{ji}]$ produce a full basis of $\mathfrak{sl}(n,C)$, giving "$\supseteq$" (and incidentally that $\mathfrak{sl}(n,C)$ is **perfect** for $n\ge2$). So $\phi$ factors through the one-complex-dimensional quotient
$$\mathfrak{gl}(n,C)/\mathfrak{sl}(n,C)\;\xrightarrow{\ \sim\ }\;C,\qquad X\longmapsto \operatorname{tr}X.$$
An $\mathbb{R}$-linear functional on this quotient is an $\mathbb{R}$-linear functional of $\operatorname{tr}X\in C$, i.e. there are constants $a,b\in C$ with
$$\phi(X)=a\,\operatorname{tr}X+b\,\overline{\operatorname{tr}X}. \tag{Λ4}$$
The conjugate term is present precisely because $\phi$ is only real-linear; it is the infinitesimal trace of the second, "anti-holomorphic" solution $A\mapsto\overline{\det A}$.

**Example ($n=2$).** $\mathfrak{sl}(2,C)=\operatorname{span}\{h,e,f_-\}$ is spanned by the three commutators $[e,f_-]=h,\ [h,e]=2e,\ [h,f_-]=-2f_-$, so any commutator-annihilating $\phi$ already vanishes on all of it; only the trace direction $I=e_{11}+e_{22}$ survives.

### Step 4 — Homogeneity forces $\phi=\operatorname{tr}$

Write $\lambda=e^{z}$ ($z\in C$; the exponential $C\to C^*$ is onto). Then $\lambda I=\exp(zI)$, and by (Λ2) and (Λ4),
$$f(\lambda I)=\exp\!\big(\phi(zI)\big)=\exp\!\big(a\,\operatorname{tr}(zI)+b\,\overline{\operatorname{tr}(zI)}\big)=\exp\!\big(a\,nz+b\,n\bar z\big).$$
Homogeneity (H2) says $f(\lambda I)=\lambda^{n}=e^{nz}$. Hence
$$\exp\!\big(a\,nz+b\,n\bar z\big)=\exp(nz)\qquad\text{for all }z\in C.$$
The function $z\mapsto a n z+b n\bar z-nz$ is continuous, takes values in $2\pi i\,\mathbb{Z}$, and vanishes at $z=0$; by connectedness of $C$ it is identically $0$. Thus $a z+b\bar z=z$ for all $z\in C$, and since $z$ and $\bar z$ are $\mathbb{R}$-independent,
$$a=1,\qquad b=0,\qquad\text{i.e.}\qquad \boxed{\ \phi=\operatorname{tr}.\ } \tag{Λ5}$$

This is the exact counterpart of Step 4 of Part I ("$g=\mathrm{id}$"). Homogeneity does one job in both proofs: it discards the spurious second solution — here the conjugate-trace term $b\,\overline{\operatorname{tr}}$ (whose group-level form is $\overline{\det}$), there the branch $g(-1)=+1$ (whose form is $|\det|$).

### Step 5 — Integrate: $f$ is the product of the eigenvalues

Combining (Λ2) and (Λ5),
$$f(\exp X)=\exp(\operatorname{tr}X)\qquad\text{for all }X\in\mathfrak{gl}(n,C). \tag{Λ6}$$
Because $G=GL(n,C)$ is **connected**, a continuous homomorphism is determined by its differential, so (Λ6) determines $f$ on all of $G$. We make it fully explicit. Over $C$ the matrix exponential $\exp:\mathfrak{gl}(n,C)\to GL(n,C)$ is **surjective**, so every invertible $A$ equals $\exp X$ for some $X$. If $X$ has eigenvalues $\mu_1,\dots,\mu_n$ (with multiplicity), then $A=\exp X$ has eigenvalues $\lambda_i=e^{\mu_i}$, and $\operatorname{tr}X=\sum_i\mu_i$, so (Λ6) gives
$$f(A)=\exp\!\Big(\sum_i\mu_i\Big)=\prod_i e^{\mu_i}=\prod_{i=1}^n\lambda_i(A). \tag{Λ7}$$
Thus **$f$ is the product of the eigenvalues** of $A$, counted with algebraic multiplicity — independent of the chosen $X$. (Surjectivity of $\exp$ over $C$ is the precise place the proof uses the complex field, just as the $n$-th-root property was in Part I; over $R$ it fails — e.g. $\operatorname{diag}(-1,-2)$ is not a real exponential — which is the analytic shadow of the missing real $n$-th roots.)

**Example ($n=2$).** For $A=\begin{pmatrix}2&1\\0&3\end{pmatrix}$, eigenvalues $2,3$, so $f(A)=6$. For a rotation-scaling $A=r\begin{pmatrix}\cos\theta&-\sin\theta\\\sin\theta&\cos\theta\end{pmatrix}=\exp\!\begin{pmatrix}\log r&-\theta\\\theta&\log r\end{pmatrix}$, $\operatorname{tr}=2\log r$, so $f(A)=e^{2\log r}=r^2$, matching $\lambda_1\lambda_2=(re^{i\theta})(re^{-i\theta})=r^2$.

### Step 6 — The top exterior power gives the Leibniz formula

It remains to write $\prod_i\lambda_i$ in coordinates. This is the natural job of the **top exterior power** $\Lambda^n(C^n)$, a one-dimensional space with basis $e_1\wedge\cdots\wedge e_n$. Any linear map $A$ induces a linear map $\Lambda^n A$ on this line, i.e. multiplication by a scalar $\delta(A)$:
$$(Ae_1)\wedge(Ae_2)\wedge\cdots\wedge(Ae_n)=\delta(A)\;e_1\wedge\cdots\wedge e_n. \tag{Λ8}$$
Two properties are immediate from functoriality of $\Lambda^n$: $\delta(AB)=\delta(A)\delta(B)$ (so $\delta$ is multiplicative and continuous, a polynomial in the entries), and on a diagonalizable $A$ with eigenvalues $\lambda_i$, choosing an eigenbasis, $\delta(A)=\prod_i\lambda_i$.

Now expand (Λ8) in coordinates. Writing the columns $Ae_k=\sum_{j} A_{jk}\,e_j$ and using multilinearity and antisymmetry of the wedge ($e_{j_1}\wedge\cdots\wedge e_{j_n}=0$ if any index repeats, and $=\operatorname{sgn}(\sigma)\,e_1\wedge\cdots\wedge e_n$ when $(j_1,\dots,j_n)=(\sigma(1),\dots,\sigma(n))$),
$$(Ae_1)\wedge\cdots\wedge(Ae_n)=\sum_{j_1,\dots,j_n}A_{j_1 1}\cdots A_{j_n n}\;e_{j_1}\wedge\cdots\wedge e_{j_n}
=\Big(\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{\sigma(k),k}\Big)e_1\wedge\cdots\wedge e_n.$$
Comparing with (Λ8),
$$\delta(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{\sigma(k),k}
=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)}, \tag{Λ9}$$
the two sums being equal by the substitution $\sigma\mapsto\sigma^{-1}$ (which preserves the sign). This is the **Leibniz formula**.

Finally, $\delta$ and $f$ are both continuous and, by (Λ7) and the eigenvalue computation above, agree on the **dense** set of diagonalizable invertible matrices (both equal $\prod_i\lambda_i$ there). Two continuous functions agreeing on a dense set agree everywhere, so $f=\delta$ on all of $GL(n,C)$:
$$\boxed{\,f(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}A_{i,\sigma(i)}\,.}$$

The Leibniz formula is recovered — now as the coordinate expression of the action on the top exterior power, i.e. of the one-dimensional representation $\Lambda^n$ of $GL(n,C)$.

### How the two proofs correspond

| Elementary (Part I) | Lie-theoretic (Part III) |
|---|---|
| conjugation invariance, $f$ trivial on transvections (Steps 1–2) | $\phi=df_I$ annihilates commutators (Λ1); vanishes on $[\mathfrak g,\mathfrak g]=\mathfrak{sl}_n$ (Λ3) |
| $f(\operatorname{diag})=g(\prod d_i)$, $g$ a homomorphism (Step 3) | $\phi=a\operatorname{tr}+b\,\overline{\operatorname{tr}}$ on the quotient $\mathfrak{gl}_n/\mathfrak{sl}_n\cong C$ (Λ4) |
| homogeneity $\Rightarrow g=\mathrm{id}$, using $n$-th roots in $C$ (Step 4) | homogeneity $\Rightarrow \phi=\operatorname{tr}$ ($a=1,b=0$) (Λ5) |
| second branch $g(-1)=+1$ over $R$, giving $|\det|$ | conjugate term $b\,\overline{\operatorname{tr}}$, giving $\overline{\det}$ |
| $f$ multilinear & alternating in rows (Steps 5–6) | $f$ = action on $\Lambda^n$; antisymmetry of the wedge (Λ8) |
| basis expansion $\Rightarrow$ Leibniz (Step 7) | wedge expansion $\Rightarrow$ Leibniz (Λ9) |
| uses $n$-th roots in $C$ once (Step 4) | uses $\exp$ surjective / $G$ connected over $C$ (Steps 4–5) |

Both proofs are the same story told at two levels: *kill the commutators, read off the one remaining degree of freedom on the torus / Cartan, and let homogeneity fix it.* The elementary version pays nothing in regularity but does the bookkeeping by hand; the Lie version assumes continuity and lets the exponential map and the top exterior power do the bookkeeping automatically.
