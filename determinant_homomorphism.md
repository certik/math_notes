# Determinant From Homomorphism

## Assumptions

- $C^* = C\setminus\{0\}$ under multiplication; $M_n(C)$ all complex $n\times n$ matrices; $GL(n,C)$ the invertible ones, a group under multiplication.
- $\operatorname{diag}(x_1,\dots,x_n)$ is the diagonal matrix with the listed entries.

We are given a function $f:GL(n,C)\to C^*$ such that:

**(H1) Multiplicativity.** $f(AB)=f(A)\,f(B)$ for all $A,B\in GL(n,C)$.

The case $n=1$ is tautological: $GL(1,C)=C^*$, and the factorization is $f=g\circ\operatorname{id}$ with $g=f$. Hence assume $n\ge 2$ below.

We also use only elementary language about rows, spans, and multilinear functions. We do **not** assume the determinant, the Leibniz formula, the polar decomposition, or the spectral theorem.

Throughout, $e_1,\dots,e_n$ is the standard basis, and we view a matrix $A$ as its list of rows $r_1,\dots,r_n\in C^n$. The **matrix unit** $E_{ij}$ is the $n\times n$ matrix with a $1$ in row $i$, column $j$, and $0$ everywhere else. We write $T_{ij}(c)=I+c\,E_{ij}$ (for $i\neq j$) for the **transvection** that adds $c$ times row $j$ to row $i$ under left multiplication.

The permutation matrix swapping indices $i$ and $j$ can be written using
transvections and one diagonal matrix as:

$$S_{ij}=\operatorname{diag}(1,\dots,\underset{j}{-1},\dots,1)\,T_{ij}(1)\,T_{ji}(-1)\,T_{ij}(1)$$

It can be shown that $S_{ij} \in GL(n, C)$ and $S^{-1}_{ij} = S_{ji}$.


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

**The values multiply additively.** Since $E_{ij}^2=0$, we have $T_{ij}(c)\,T_{ij}(c')=T_{ij}(c+c')$, so by (H1) the map $c\mapsto f(T_{ij}(c))$ turns addition into multiplication. Taking $c=c'=1$: $t=f(T_{ij}(2))=f(T_{ij}(1))^2=t^2$. As $t\in C^*$, this forces $t=1$.

Therefore
$$f\big(T_{ij}(c)\big)=1\qquad\text{for all }c. \tag{2}$$
In particular, by (H1), **left- or right-multiplying by a transvection does not change $f$** — i.e. adding a multiple of one row (or column) to another leaves $f$ unchanged.

---

## Step 3 — The one-variable function $g$, and $f$ on diagonal matrices

Define
$$g(x):=f\big(\operatorname{diag}(x,1,\dots,1)\big),\qquad x\in C^*.$$

**$g$ is a homomorphism $C^*\to C^*$:** from $\operatorname{diag}(xy,1,\dots,1)=\operatorname{diag}(x,1,\dots,1)\operatorname{diag}(y,1,\dots,1)$ and (H1),
$$g(xy)=g(x)g(y). \tag{3}$$

**Position does not matter.** Let $P_1=I$, and for $i>1$ let $P_i=S_{1i}$ be the permutation matrix swapping coordinates $1$ and $i$ (so $P_i\in GL(n,C)$, $P_i^{-1}=P_i^{T}$). Explicitly, for $i>1$, $P_i=S_{1i}=I-E_{11}-E_{ii}+E_{1i}+E_{i1}$: the identity with rows (and columns) $1$ and $i$ interchanged.
This moves $x$ from slot $1$ to slot $i$. Then $\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)=P_i\operatorname{diag}(x,1,\dots,1)P_i^{-1}$, so by (1)
$$f\big(\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)\big)=g(x). \tag{4}$$

(More generally, conjugating any diagonal matrix by a permutation matrix permutes its diagonal entries: $P_\sigma\operatorname{diag}(d_1,\dots,d_n)P_\sigma^{-1}=\operatorname{diag}(d_{\sigma^{-1}(1)},\dots,d_{\sigma^{-1}(n)})$.)



**Product over the diagonal.** Writing $\operatorname{diag}(d_1,\dots,d_n)=\prod_{i=1}^n\operatorname{diag}(1,\dots,\underset{i}{d_i},\dots,1)$ and using (H1), (4), (3),
$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_{i=1}^n g(d_i)=g\!\Big(\prod_{i=1}^n d_i\Big). \tag{5}$$

---

## The factorization theorem $f=g\circ\det$ (multiplicativity only)

Everything so far (Steps 1–3) used **only** that $f$ is a homomorphism (H1). Three facts are all we shall use:

* (H1) $f$ is a homomorphism $GL(n,C)\to C^*$;
* (2) $f\big(T_{ij}(c)\big)=1$ for every transvection;
* (5) $f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=g\!\big(\prod_i d_i\big)$, with $g:C^*\to C^*$ the homomorphism of Step 3.

We show these force $f=g\circ\det$, the determinant being supplied — single-valued — by the Leibniz polynomial. We work entirely inside $GL$, never evaluating $f$ on a singular matrix, with no appeal to continuity, exterior algebra, or Zariski density. (The one ingredient missing for $f$ on $GL$ — the *alternating* property — enters here only as a formal identity about a polynomial, where the singular-matrix obstruction simply does not arise.)

**1. Transvections and diagonal matrices generate $GL$.**
*Lemma.* Every $A\in GL(n,C)$ factors as
$$A=E\,D,\qquad E=\text{a product of transvections},\quad D=\operatorname{diag}(d_1,\dots,d_n),\quad d_i\in C^*. \tag{6}$$
*Proof.* Use Gauss-Jordan row reduction, without normalizing pivots. Adding $c$ times row $j$ to row $i$ is left multiplication by $T_{ij}(c)$. Since $A$ is invertible, a nonzero pivot can be chosen in each column; if the needed pivot is not already in place, bring it up by a row swap, then use row additions to clear every other entry in that pivot column. The row swap is the purely algebraic identity
$$S_{ij}=\operatorname{diag}(1,\dots,\underset{j}{-1},\dots,1)\,T_{ij}(1)\,T_{ji}(-1)\,T_{ij}(1)$$
— transvections times a diagonal. Thus there are row-operation matrices $R_1,\dots,R_m$, each a transvection or a product of transvections and an invertible diagonal matrix, such that
$$R_m\cdots R_1 A=D_0$$
with $D_0$ an invertible diagonal matrix. Hence
$$A=R_1^{-1}\cdots R_m^{-1}D_0,$$
and this is a product of transvections and invertible diagonal matrices, because $T_{ij}(c)^{-1}=T_{ij}(-c)$ and the inverse of an invertible diagonal matrix is diagonal.

It remains only to collect all diagonal factors on the right. If $\Delta=\operatorname{diag}(\delta_1,\dots,\delta_n)$ is invertible, then
$$\Delta\,T_{ij}(c)
=\Delta\,T_{ij}(c)\Delta^{-1}\Delta
=T_{ij}(c\,\delta_i/\delta_j)\Delta.$$
So whenever a diagonal factor stands immediately to the left of a transvection, it can be slid past it, turning that transvection into another transvection. Repeating this finitely many times moves all diagonal factors to the far right; their product is a single invertible diagonal matrix $D$, and the remaining left-hand factors form a product $E$ of transvections. This gives (6). $\square$

**2. Existence: the Leibniz polynomial.** Before drawing any conclusion about the abstract $f$, exhibit one *explicit* function we can evaluate unambiguously. Let
$$L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n a_{i,\sigma(i)},$$
a polynomial defined for **every** matrix by this formula — hence single-valued by construction. The following are **formal identities in the entries**, valid for all $A$ (singular included) and checked directly on the sum:

* (a) $L(I)=1$, and more generally $L\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i$ — only $\sigma=\mathrm{id}$ survives;
* (b) **two equal rows $\Rightarrow L=0$**: if rows $p$ and $q$ are equal and $\tau=(p\ q)$, then pairing each $\sigma$ with $\sigma\circ\tau$ gives equal products with opposite signs, so the sum cancels term by term (using $\operatorname{char}C=0$);
* (c) $L$ is **linear in each row** — every summand is.

From (b) and (c), adding a multiple of one row to another leaves $L$ unchanged, $L\big(T_{ij}(c)\,X\big)=L(X)$; taking $X=I$ and using (a) gives in particular $L(T_{ij}(c))=1$. Thus $L$ satisfies $L(T_{ij}(c))=1$ and $L(\operatorname{diag}(d_1,\dots,d_n))=\prod_i d_i$ outright — and, unlike the abstract $f$ on $GL$, with **no domain caveat**, because $L$ is everywhere-defined and (b) is a genuine polynomial identity even though "two equal rows" is a singular configuration.

Feed $L$ a factorization (6). Peeling the transvections of $E$ off one at a time by $L(T_{ij}(c)X)=L(X)$, then applying (a),
$$L(A)=L(E\,D)=L(D)=\prod_i d_i. \tag{7}$$
In particular, $L(A)\in C^*$ for $A\in GL(n,C)$.

**3. $\prod_i d_i$ is well-defined.** A priori the product in (7) could depend on the factorization (6) chosen, and the concrete $L$ is exactly what rules this out. If a second factorization $A=E'D'$ gave a different product $\prod_i d_i'$, then (7) applied to *it* would read $L(A)=\prod_i d_i'$ as well; but $L(A)$ is one unambiguous number, so $\prod_i d_i=\prod_i d_i'$. Hence every factorization of $A$ yields the same product, a function of $A$ alone, which we write $p(A):=\prod_i d_i=L(A)$. (Note we proved independence *using* the single-valued $L$ — never assuming it beforehand.)

**4. $L$ is multiplicative on $GL(n,C)$.** Let $A,B\in GL(n,C)$. Choose factorizations
$$A=E_A D_A,\qquad B=E_B D_B,$$
with $E_A,E_B$ products of transvections and
$$D_A=\operatorname{diag}(a_1,\dots,a_n),\qquad D_B=\operatorname{diag}(b_1,\dots,b_n).$$
Then
$$AB=E_A\,D_A\,E_B\,D_B
=E_A\,(D_AE_BD_A^{-1})\,D_AD_B.$$
If $E_B=T_1\cdots T_m$ is a product of transvections, then
$$D_AE_BD_A^{-1}=(D_AT_1D_A^{-1})\cdots(D_AT_mD_A^{-1}),$$
and each factor $D_AT_kD_A^{-1}$ is again a transvection by the diagonal-conjugation formula above. Therefore the displayed expression for $AB$ is a factorization of the form (6), with diagonal factor $D_AD_B=\operatorname{diag}(a_1b_1,\dots,a_nb_n)$. Applying (7) to the chosen factorizations of $A$, $B$, and $AB$ gives
$$L(AB)=\prod_i a_i b_i=\Big(\prod_i a_i\Big)\Big(\prod_i b_i\Big)=L(A)L(B). \tag{8}$$
Thus the Leibniz polynomial is multiplicative on $GL(n,C)$.

**5. Every homomorphism $f$ factors as $g\circ\det$.**  Let $f$ be *any* homomorphism — the given $f$ of Steps 1–3 is one such. For any factorization (6), using (H1), then (2) (so $f(E)=1$), then (5) (so $f(D)=g(\prod_i d_i)$),
$$f(A)=f(E)\,f(D)\overset{(2)}{=}f(D)\overset{(5)}{=}g\!\Big(\prod_i d_i\Big)=g\big(p(A)\big)=g\big(L(A)\big),$$
where $p(A)=\prod_i d_i$ is unambiguous and equals $L(A)$ by (7). This is the **factorization theorem**:
$$\boxed{\,f(A)=g(L(A)),\qquad L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)} \equiv \det A \qquad(A\in GL(n,C)),\,}$$
for some homomorphism $g:C^*\to C^*$ — **derived from multiplicativity alone**, with no continuity, measurability, or Zariski density. The single-valued determinant is the explicit polynomial $L$, the well-definedness of $p(A)=\det A$ is anchored on $L$, and the factorization is $f=g\circ\det$.

Conversely, every $g\circ\det$ with $g\in\operatorname{Hom}(C^*,C^*)$ *is* a homomorphism $GL(n,C)\to C^*$: by (8), $L(AB)=L(A)L(B)$ on $GL(n,C)$, and then $g(L(AB))=g(L(A))g(L(B))$. Hence these are **exactly** all of them: the determinant is the universal homomorphism, and every other is a "rescaling" $g$ of it. The factor $g$ is genuinely free — continuity or measurability would narrow it to $g(w)=|w|^s(w/|w|)^k$, the determinant itself being the case $g=\mathrm{id}$.
