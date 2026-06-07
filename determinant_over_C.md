# Deriving the determinant from homogeneity and multiplicativity

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

Throughout, $e_1,\dots,e_n$ is the standard basis, and we view a matrix $A$ as its list of rows $r_1,\dots,r_n\in C^n$. The **matrix unit** $e_{ij}$ is the $n\times n$ matrix with a $1$ in row $i$, column $j$, and $0$ everywhere else. We write $T_{ij}(c)=I+c\,e_{ij}$ (for $i\neq j$) for the **transvection** that adds $c$ times row $j$ to row $i$ under left multiplication.

---

## Step 1 — $f(I)=1$ and conjugation invariance

From $I\cdot I=I$ and (H1): $f(I)=f(I)^2$. Since $f(I)\in C^*$ is nonzero, $f(I)=1$.

For any $P\in GL(n,C)$, using (H1) and the commutativity of $C^*$,
$$f(PAP^{-1})=f(P)f(A)f(P^{-1})=f(P)f(P^{-1})f(A)=f(PP^{-1})f(A)=f(A). \tag{1}$$
So $f$ is invariant under conjugation.

---

## Step 2 — $f$ is $1$ on every transvection

Fix $i\neq j$. Two observations.

**All nonzero $c$ give conjugate transvections.** For a diagonal $D=\operatorname{diag}(d_1,\dots,d_n)$ one computes $D\,T_{ij}(c)\,D^{-1}=T_{ij}\!\big(c\,d_i/d_j\big)$. Choosing $d_i/d_j$ freely, the factor $c\,d_i/d_j$ ranges over all of $C^*$. Hence all $T_{ij}(c)$ with $c\neq 0$ are conjugate, so by (1) the value $f(T_{ij}(c))=:t$ is the same for every $c\neq 0$.

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

**Position does not matter.** Let $P_i$ be the permutation matrix swapping coordinates $1$ and $i$ (so $P_i\in GL(n,C)$, $P_i^{-1}=P_i$). Then $\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)=P_i\operatorname{diag}(x,1,\dots,1)P_i^{-1}$, so by (1)
$$f\big(\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)\big)=g(x). \tag{4}$$

**Product over the diagonal.** Writing $\operatorname{diag}(d_1,\dots,d_n)=\prod_{i=1}^n\operatorname{diag}(1,\dots,\underset{i}{d_i},\dots,1)$ and using (H1), (4), (3),
$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_{i=1}^n g(d_i)=g\!\Big(\prod_{i=1}^n d_i\Big). \tag{5}$$

---

## Step 4 — Homogeneity forces $g=\mathrm{id}$

Apply (5) to $\lambda I=\operatorname{diag}(\lambda,\dots,\lambda)$ and compare with (H2):
$$g(\lambda^n)=f(\lambda I)=\lambda^n\qquad\text{for all }\lambda\in C^*.$$
Given any $w\in C^*$, pick an $n$-th root $\lambda$ with $\lambda^n=w$ (fact (R)); then $g(w)=g(\lambda^n)=\lambda^n=w$. Hence
$$g=\mathrm{id}_{C^*}. \tag{6}$$

Two immediate consequences, used below:
$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i, \tag{5$'$}$$
and, since left-multiplying by $\operatorname{diag}(1,\dots,\underset{i}{\lambda},\dots,1)$ scales row $i$ by $\lambda$,
$$\textbf{scaling a single row by }\lambda\textbf{ multiplies }f\textbf{ by }\lambda. \tag{7}$$

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
Since left-multiplication by $S_{ij}$ swaps rows $i$ and $j$, (9) and (H1) say: **swapping two rows multiplies $f$ by $-1$.** Combined with multilinearity (8), if two rows are equal then swapping them both fixes the matrix and negates $f$, so
$$f=0\ \text{whenever two rows coincide (alternating).} \tag{10}$$
Finally, any permutation matrix $P_\sigma$ is a product of swaps, so by (9)
$$f(P_\sigma)=\operatorname{sgn}(\sigma). \tag{11}$$

(Here is the only place the choice of branch mattered: (9) used $g(-1)=-1$ from Step 4. Had $g(-1)=+1$ — the situation that survives over $R$ for even $n$ — we would get the sign-blind "permanent" instead. Homogeneity, through (6), is exactly what selects the alternating sign.)

---

## Step 7 — Expanding in the basis: the Leibniz formula

Multilinearity (8) lets us extend $f$ to **all** of $M_n(C)$: a multilinear function of $n$ rows is determined by its values on tuples of basis vectors, and the alternating property (10) fixes those values — $0$ when a basis vector repeats, and $\operatorname{sgn}(\sigma)$ on the permutation matrices by (11). Expanding each row $r_i=\sum_{j}A_{ij}\,e_j$ by multilinearity,
$$f(A)=\sum_{j_1,\dots,j_n}A_{1,j_1}\cdots A_{n,j_n}\;f(e_{j_1},\dots,e_{j_n}).$$
By (10) every term with a repeated index vanishes; the surviving terms are those where $(j_1,\dots,j_n)=(\sigma(1),\dots,\sigma(n))$ for a permutation $\sigma$, contributing $f(P_\sigma)=\operatorname{sgn}(\sigma)$ via (11). Therefore
$$\boxed{\,f(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}A_{i,\sigma(i)}\,.}$$

This is the **Leibniz formula** — derived, not assumed.

A word on the basis expansion. The intermediate tuples $f(e_{j_1},\dots,e_{j_n})$ with a repeated index correspond to *singular* matrices, where $f$ was not originally defined. This causes no trouble: by Step 5, $f$ is multilinear in the rows on $GL(n,C)$, so it extends **uniquely** to a multilinear function $F$ on all of $M_n(C)$, and the alternating property (10) pins down its basis values ($0$ on repeats, $\operatorname{sgn}(\sigma)$ on permutations). Both $F$ and the Leibniz polynomial are polynomial in the entries and agree on the boxed formula above; since they coincide on the (Zariski-dense) set $GL(n,C)$, they coincide everywhere. So the expansion is fully rigorous.

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
