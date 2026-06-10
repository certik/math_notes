# Determinant From Homomorphism

## Assumptions

- $C^* = C\setminus\{0\}$ under multiplication; $M_n(C)$ all complex $n\times n$ matrices; $GL(n,C)$ the invertible ones, a group under multiplication.
- $\operatorname{diag}(x_1,\dots,x_n)$ is the diagonal matrix with the listed entries.

We are given a function $f:GL(n,C)\to C^*$ such that:

**(H1) Multiplicativity.** $f(AB)=f(A)\,f(B)$ for all $A,B\in GL(n,C)$.

We also use only elementary language about rows, spans, and multilinear functions. We do **not** assume the determinant, the Leibniz formula, the polar decomposition, or the spectral theorem.

Throughout, $e_1,\dots,e_n$ is the standard basis, and we view a matrix $A$ as its list of rows $r_1,\dots,r_n\in C^n$. The **matrix unit** $E_{ij}$ is the $n\times n$ matrix with a $1$ in row $i$, column $j$, and $0$ everywhere else. We write $T_{ij}(c)=I+c\,E_{ij}$ (for $i\neq j$) for the **transvection** that adds $c$ times row $j$ to row $i$ under left multiplication.

The permutation matrix swapping indicies $i$ and $j$ can be written using
transvections as:

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

## The factorization theorem $f=g\circ\det$ (multiplicativity only)

Everything so far (Steps 1–3) used **only** that $f$ is a homomorphism (H1);
Three facts are all we shall use:

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

**2. Existence: the Leibniz polynomial.** Before drawing any conclusion about the abstract $f$, exhibit one *explicit* function we can evaluate unambiguously. Let
$$L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n a_{i,\sigma(i)},$$
a polynomial defined for **every** matrix by this formula — hence single-valued by construction. The following are **formal identities in the entries**, valid for all $A$ (singular included) and checked directly on the sum:

* (a) $L(I)=1$, and more generally $L\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i$ — only $\sigma=\mathrm{id}$ survives;
* (b) **two equal rows $\Rightarrow L=0$**: pairing each $\sigma$ with $\sigma\circ(\text{transposition of the two equal rows})$ cancels the sum term by term (using $\operatorname{char}C=0$);
* (c) $L$ is **linear in each row** — every summand is.

From (b) and (c), adding a multiple of one row to another leaves $L$ unchanged, $L\big(T_{ij}(c)\,X\big)=L(X)$; taking $X=I$ and using (a) gives in particular $L(T_{ij}(c))=1$. Thus $L$ satisfies $L(T_{ij}(c))=1$ and $L(\operatorname{diag}(d_1,\dots,d_n))=\prod_i d_i$ outright — and, unlike the abstract $f$ on $GL$, with **no domain caveat**, because $L$ is everywhere-defined and (b) is a genuine polynomial identity even though "two equal rows" is a singular configuration. 

Feed $L$ a factorization (19). Peeling the transvections of $E$ off one at a time by $L(T_{ij}(c)X)=L(X)$, then applying (a),
$$L(A)=L(E\,D)=L(D)=\prod_i d_i. \tag{20}$$

**3. $\prod_i d_i$ is well-defined.** A priori the product in (20) could depend on the factorization (19) chosen, and the concrete $L$ is exactly what rules this out. If a second factorization $A=E'D'$ gave a different product $\prod_i d_i'$, then (20) applied to *it* would read $L(A)=\prod_i d_i'$ as well; but $L(A)$ is one unambiguous number, so $\prod_i d_i=\prod_i d_i'$. Hence every factorization of $A$ yields the same product, an function of $A$ alone, which we write $p(A):=\prod_i d_i=L(A)$. (Note we proved independence *using* the single-valued $L$ — never assuming it beforehand.)

**4. Uniqueness: every homomorphism $f$ equals $g\circ L$.**  Let $f$ be *any* homomorphism — the given $f$ of Steps 1–3 is one such. For any factorization (19), using (H1), then (2) (so $f(E)=1$), then (5) (so $f(D)=g(\prod_i d_i)$),
$$f(A)=f(E)\,f(D)\overset{(2)}{=}f(D)\overset{(5)}{=}g\!\Big(\prod_i d_i\Big)=g\big(p(A)\big)=g\big(L(A)\big),$$
where $p(A)=\prod_i d_i$ is unambiguous and equals $L(A)$ by (20). This is the **factorization theorem**:
$$\boxed{\,f(A)=g(L(A)),\qquad L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)} \equiv \det A \qquad(A\in GL(n,C)),\,}$$
for some homomorphism $g:C^*\to C^*$ — **derived from multiplicativity alone**, with no homogeneity, continuity, measurability, or Zariski density. The single-valued determinant is the explicit polynomial $L$, well-definedness of $p(A)=\det A$ is anchored on $L$, and the factorization $f=g\circ\det$.

Conversely, every $g\circ\det$ with $g\in\operatorname{Hom}(C^*,C^*)$ *is* a homomorphism $GL(n,C)\to C^*$, so these are **exactly** all of them: the determinant is the universal homomorphism, and every other is a "rescaling" $g$ of it. The factor $g$ is genuinely free here — continuity or measurability would narrow it to $g(w)=|w|^s(w/|w|)^k$, and homogeneity pins it to the identity.
