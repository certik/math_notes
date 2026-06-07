# The determinant over $C$: definition and characterization

This is a short, self-contained note with two halves:

- **Part I** *defines* the determinant from scratch (by the Leibniz formula) and proves the few properties we need — including multiplicativity — directly.
- **Part II** runs an elementary diagonalization argument to show this determinant is the **unique homogeneous homomorphism** $GL(n,C)\to C^*$.

Nothing about the determinant is assumed; it is built and then characterized.

---

## Setup

- $C^* = C\setminus\{0\}$, the nonzero complex numbers under multiplication.
- $M_n(C)$: all complex $n\times n$ matrices; $GL(n,C)$: the invertible ones, a group under multiplication.
- $\operatorname{diag}(x_1,\dots,x_n)$: the diagonal matrix with the listed entries.

**Definition (homomorphism).** A function $f:GL(n,C)\to C^*$ is a *homomorphism* if $f(AB)=f(A)f(B)$ for all $A,B$.

**Definition (homogeneous).** A homomorphism $f$ is *homogeneous (of degree $n$)* if $f(\lambda I)=\lambda^{n}$ for all $\lambda\in C^*$.

**Goal.** Define $\det$ and prove it is the *only* homogeneous homomorphism.

---

# Part I — Defining the determinant

**Definition (Leibniz formula).** For $A\in M_n(C)$ with entries $A_{ij}$,
$$\det A \;:=\; \sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^{n}A_{i,\sigma(i)},$$
the sum running over all permutations $\sigma$ of $\{1,\dots,n\}$.

We regard $\det$ as a function of the $n$ **rows** $r_1,\dots,r_n\in C^n$ of $A$.

**Lemma A (basic properties).**

1. **Multilinear and alternating in the rows.** $\det$ is linear in each row separately, and $\det A=0$ whenever two rows of $A$ are equal. (Consequently, swapping two rows multiplies $\det$ by $-1$.)
2. **Values on diagonal matrices.** $\det\operatorname{diag}(d_1,\dots,d_n)=\prod_i d_i$; in particular $\det I=1$ and $\det(\lambda I)=\lambda^{n}$.
3. **Characterization.** Every function $\psi:M_n(C)\to C$ that is multilinear and alternating in the rows satisfies $\psi(A)=\psi(I)\,\det A$.

*Proof.* (1) Each term $\prod_i A_{i,\sigma(i)}$ contains exactly one factor from each row, giving linearity in each row. If rows $p\neq q$ are equal, pairing each $\sigma$ with $\sigma\cdot(p\,q)$ cancels the terms (they have opposite signs but equal products), so $\det A=0$.

(2) For a diagonal matrix only $\sigma=\mathrm{id}$ contributes, giving $\prod_i d_i$.

(3) Write each row as $r_i=\sum_{j}A_{ij}\,e_j$ in the standard basis. Multilinearity expands $\psi(A)$ into $\sum_{j_1,\dots,j_n}A_{1,j_1}\cdots A_{n,j_n}\,\psi(e_{j_1},\dots,e_{j_n})$. By the alternating property the term vanishes unless $j_1,\dots,j_n$ are distinct, i.e. form a permutation $\sigma$, and then $\psi(e_{\sigma(1)},\dots,e_{\sigma(n)})=\operatorname{sgn}(\sigma)\,\psi(I)$. Hence $\psi(A)=\psi(I)\sum_\sigma \operatorname{sgn}(\sigma)\prod_i A_{i,\sigma(i)}=\psi(I)\det A$. $\qquad\Box$

**Lemma B (multiplicativity).** $\det(AB)=\det(A)\,\det(B)$ for all $A,B\in M_n(C)$.

*Proof.* Fix $B$ and define $\psi(A):=\det(AB)$. Row $i$ of $AB$ equals $(\text{row }i\text{ of }A)\,B$, which is linear in row $i$ of $A$; so $\psi$ is multilinear in the rows of $A$. If two rows of $A$ are equal, the corresponding rows of $AB$ are equal, so $\psi(A)=0$; thus $\psi$ is alternating. By Lemma A(3),
$$\det(AB)=\psi(A)=\psi(I)\,\det A=\det(IB)\,\det A=\det(B)\det(A). \qquad\Box$$

**Corollary (consequences on $GL(n,C)$).**

- For invertible $A$, $\det(A)\det(A^{-1})=\det(I)=1$, so $\det A\neq 0$. Hence $\det$ restricts to a map $GL(n,C)\to C^*$, and by Lemma B it is a **homomorphism**, with $\det(A^{-1})=(\det A)^{-1}$.
- **Conjugation invariance:** $\det(PAP^{-1})=\det(P)\det(A)\det(P)^{-1}=\det A$ for $P\in GL(n,C)$.
- By Lemma A(2), $\det(\lambda I)=\lambda^n$, so $\det$ is **homogeneous**.

Thus $\det$ is *a* homogeneous homomorphism. Part II shows it is the only one.

---

# Part II — The determinant is the unique homogeneous homomorphism

We now take an **arbitrary** homogeneous homomorphism $f:GL(n,C)\to C^*$ and prove $f=\det$. We use three standard linear-algebra facts:

1. **Polar decomposition.** Every $A\in GL(n,C)$ factors as $A=H\,U$ with $H$ Hermitian positive definite and $U$ unitary.
2. **Spectral theorem.** Hermitian and unitary matrices are normal, hence unitarily diagonalizable: each is $W\Lambda W^{-1}$ with $W$ unitary and $\Lambda$ diagonal.
3. **Roots in $C$.** Every $w\in C^*$ has an $n$-th root $\lambda\in C^*$ with $\lambda^n=w$.

### Step 1 — Elementary consequences for $f$

**(1a)** From $I\cdot I=I$: $f(I)=f(I)^2$, and $f(I)\in C^*$, so $f(I)=1$.

**(1b) Conjugation invariance.** For $P\in GL(n,C)$, using commutativity of $C^*$,
$$f(PAP^{-1})=f(P)f(A)f(P^{-1})=f(P)f(P^{-1})f(A)=f(PP^{-1})f(A)=f(A).$$

### Step 2 — On diagonal matrices: $f(D)=g(\det D)$

Define $g(x):=f\big(\operatorname{diag}(x,1,\dots,1)\big)$ for $x\in C^*$.

**$g$ is a homomorphism $C^*\to C^*$:** since $\operatorname{diag}(xy,1,\dots,1)=\operatorname{diag}(x,1,\dots,1)\operatorname{diag}(y,1,\dots,1)$,
$$g(xy)=f\big(\operatorname{diag}(x,1,\dots,1)\big)f\big(\operatorname{diag}(y,1,\dots,1)\big)=g(x)g(y).$$

**Position does not matter.** Let $P_i$ be the permutation matrix swapping coordinates $1$ and $i$ (it lies in $GL(n,C)$ and $P_i^{-1}=P_i$). Then $\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)=P_i\operatorname{diag}(x,1,\dots,1)P_i^{-1}$, so by (1b)
$$f\big(\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)\big)=f\big(\operatorname{diag}(x,1,\dots,1)\big)=g(x).$$

**Combine the slots.** Since $D=\operatorname{diag}(d_1,\dots,d_n)=\prod_{i=1}^n \operatorname{diag}(1,\dots,\underset{i}{d_i},\dots,1)$,
$$f(D)=\prod_{i=1}^n g(d_i)=g\!\Big(\prod_{i=1}^n d_i\Big)=g(\det D),$$
using that $g$ is a homomorphism and $\det D=\prod_i d_i$ (Lemma A(2)).

### Step 3 — On all of $GL(n,C)$: $f(A)=g(\det A)$

Let $A\in GL(n,C)$, with polar decomposition $A=HU$ (Fact 1). By the spectral theorem (Fact 2), $H=W\Lambda W^{-1}$ with $\Lambda$ diagonal; by (1b) and Step 2,
$$f(H)=f(\Lambda)=g(\det\Lambda)=g(\det H),$$
since $\det\Lambda=\det H$ (conjugation invariance of $\det$, Corollary in Part I). The same applied to the unitary $U$ gives $f(U)=g(\det U)$. Therefore, using that $g$ is a homomorphism and $\det A=\det H\,\det U$ (Lemma B),
$$f(A)=f(H)f(U)=g(\det H)g(\det U)=g(\det H\cdot\det U)=g(\det A).$$
So $f(A)=g(\det A)$ for **every** $A\in GL(n,C)$.

### Step 4 — Homogeneity forces $g=\mathrm{id}$, hence $f=\det$

Apply $f(A)=g(\det A)$ to $A=\lambda I$ and use homogeneity together with $\det(\lambda I)=\lambda^n$:
$$\lambda^n=f(\lambda I)=g\big(\det(\lambda I)\big)=g(\lambda^n)\qquad(\lambda\in C^*).$$
For any $w\in C^*$, pick an $n$-th root $\lambda$ (Fact 3), $\lambda^n=w$; then $g(w)=g(\lambda^n)=\lambda^n=w$. Hence $g=\mathrm{id}_{C^*}$, and
$$f(A)=g(\det A)=\det A.$$

---

## Conclusion

> **Theorem.** Over $C$, the determinant — defined by the Leibniz formula in Part I — is the **unique** homogeneous homomorphism $GL(n,C)\to C^*$, for every $n$.

Two remarks:

- **No regularity assumption.** We never assumed $g$ continuous or measurable. Homogeneity forces $g(w)=w$ at *every* $w$, because every $w$ is an $n$-th power in $C$ (Fact 3). The result holds even among abstract group homomorphisms.
- **Why $C$ and not $R$.** The only place $C$ (rather than $R$) was essential is Fact 3: in $C$ every number — in particular $-1=i^2$ — has an $n$-th root, so $g$ is pinned down everywhere. Over $R$ with even $n$, the value $-1$ has no real $n$-th root, $g(-1)=\pm1$ stays free, and a second homomorphism $f=|\det|$ survives (removable only by an extra normalization). Over $C$ that ambiguity simply does not arise.
