# The determinant as the unique homogeneous homomorphism over $C$

This is a short, self-contained derivation: from a few clearly stated assumptions we show that **the determinant is the only homogeneous homomorphism $GL(n,C)\to C^*$.** The argument is elementary — it reduces a general matrix to a diagonal one (using the polar decomposition) and then to a single scalar.

---

## Setup

- $C^* = C\setminus\{0\}$, the nonzero complex numbers under multiplication.
- $GL(n,C)$: the group of invertible complex $n\times n$ matrices under matrix multiplication.
- $\operatorname{diag}(x_1,\dots,x_n)$ is the diagonal matrix with the listed entries.

**Definition (homomorphism).** A function $f:GL(n,C)\to C^*$ is a *homomorphism* if
$$f(AB)=f(A)\,f(B)\qquad\text{for all }A,B\in GL(n,C).$$

**Definition (homogeneous).** A homomorphism $f$ is *homogeneous (of degree $n$)* if
$$f(\lambda I)=\lambda^{n}\qquad\text{for all }\lambda\in C^*.$$

**Goal.** Prove that the only homogeneous homomorphism is $f=\det$.

### Assumptions (standard facts used without proof)

1. **Polar decomposition.** Every $A\in GL(n,C)$ factors as $A=H\,U$, where $H$ is Hermitian positive definite and $U$ is unitary.
2. **Spectral theorem.** Hermitian matrices and unitary matrices are *normal*, hence unitarily diagonalizable: each can be written $W\,\Lambda\,W^{-1}$ with $W$ unitary and $\Lambda$ diagonal.
3. **Roots in $C$.** Every $w\in C^*$ has an $n$-th root: there is $\lambda\in C^*$ with $\lambda^{n}=w$.
4. **Determinant basics.** $\det(AB)=\det(A)\det(B)$ and $\det(\lambda I)=\lambda^{n}$.

Throughout, $f$ is a homogeneous homomorphism, fixed once and for all.

---

## Step 1 — Two elementary consequences

**(1a) $f(I)=1$.** From $I\cdot I=I$ we get $f(I)=f(I)\,f(I)$, and since $f(I)\in C^*$ is nonzero we may cancel: $f(I)=1$.

**(1b) Conjugation invariance.** For any $P\in GL(n,C)$,
$$f(P A P^{-1})=f(P)\,f(A)\,f(P^{-1})=f(P)\,f(P^{-1})\,f(A)=f(P P^{-1})\,f(A)=f(I)\,f(A)=f(A),$$
where we used that the values lie in the commutative group $C^*$, and $f(P)f(P^{-1})=f(PP^{-1})=f(I)=1$.

---

## Step 2 — On diagonal matrices: $f(D)=g(\det D)$

Define the single-variable function
$$g(x):=f\big(\operatorname{diag}(x,1,\dots,1)\big),\qquad x\in C^*.$$

**$g$ is a homomorphism $C^*\to C^*$:** since $\operatorname{diag}(xy,1,\dots,1)=\operatorname{diag}(x,1,\dots,1)\,\operatorname{diag}(y,1,\dots,1)$,
$$g(xy)=f\big(\operatorname{diag}(xy,1,\dots,1)\big)=f\big(\operatorname{diag}(x,1,\dots,1)\big)\,f\big(\operatorname{diag}(y,1,\dots,1)\big)=g(x)\,g(y).$$

**Position does not matter.** Let $P_i$ be the permutation matrix swapping coordinates $1$ and $i$ (it is its own inverse, and lies in $GL(n,C)$). Conjugating moves the entry $x$ from slot $1$ to slot $i$:
$$\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)=P_i\,\operatorname{diag}(x,1,\dots,1)\,P_i^{-1}.$$
By conjugation invariance (1b),
$$f\big(\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)\big)=f\big(\operatorname{diag}(x,1,\dots,1)\big)=g(x).$$

**Putting the slots together.** Any diagonal matrix is the product of its one-entry pieces,
$$D=\operatorname{diag}(d_1,\dots,d_n)=\prod_{i=1}^{n}\operatorname{diag}(1,\dots,\underset{i}{d_i},\dots,1),$$
so, applying $f$ and then the homomorphism property of $g$,
$$f(D)=\prod_{i=1}^{n} g(d_i)=g\!\Big(\prod_{i=1}^{n} d_i\Big)=g(\det D).$$

Thus on diagonal matrices $f$ depends only on the product of the entries, i.e. on $\det D$.

---

## Step 3 — On all of $GL(n,C)$: $f(A)=g(\det A)$

Let $A\in GL(n,C)$ be arbitrary and write its polar decomposition $A=H\,U$ (Assumption 1).

By the spectral theorem (Assumption 2), $H=W\,\Lambda\,W^{-1}$ with $\Lambda$ diagonal; by conjugation invariance (1b) and Step 2,
$$f(H)=f(\Lambda)=g(\det\Lambda)=g(\det H).$$
The same argument applied to the unitary matrix $U$ gives $f(U)=g(\det U)$. Therefore
$$f(A)=f(H)\,f(U)=g(\det H)\,g(\det U)=g(\det H\cdot\det U)=g(\det A),$$
using that $g$ is a homomorphism and $\det A=\det H\,\det U$. Hence
$$\boxed{\,f(A)=g(\det A)\quad\text{for every }A\in GL(n,C).\,}$$

This is the key reduction: the matrix homomorphism $f$ is completely captured by the single scalar homomorphism $g$ composed with the determinant.

---

## Step 4 — Homogeneity forces $g=\mathrm{id}$, hence $f=\det$

Apply $f(A)=g(\det A)$ to $A=\lambda I$ and use homogeneity together with $\det(\lambda I)=\lambda^{n}$:
$$\lambda^{n}=f(\lambda I)=g\big(\det(\lambda I)\big)=g(\lambda^{n})\qquad\text{for all }\lambda\in C^*.$$

So $g(\lambda^{n})=\lambda^{n}$. Now take any $w\in C^*$. By Assumption 3 it has an $n$-th root $\lambda$ with $\lambda^{n}=w$, and then
$$g(w)=g(\lambda^{n})=\lambda^{n}=w.$$
Since $w$ was arbitrary, $g$ is the identity on all of $C^*$. Substituting back,
$$f(A)=g(\det A)=\det A.$$

---

## Conclusion

The determinant **is** a homogeneous homomorphism: $\det(AB)=\det A\det B$ and $\det(\lambda I)=\lambda^{n}$ (Assumption 4). Step 4 shows it is the **only** one. Therefore

> **Theorem.** Over $C$, the determinant is the unique homogeneous homomorphism $GL(n,C)\to C^*$, for every $n$.

Two features worth noting:

- **No regularity assumption.** Nowhere did we assume $g$ is continuous or measurable. Homogeneity already forces $g(w)=w$ at *every* point $w$, because every $w$ is an $n$-th power in $C$ (Assumption 3). The result holds even among abstract group homomorphisms.
- **Why $C$ and not $R$.** The single place that used $C$ rather than $R$ is Assumption 3: in $C$ every number — in particular $-1=i^{2}$ — has an $n$-th root, so $g$ is pinned down everywhere. Over $R$ with even $n$, the number $-1$ has no real $n$-th root, $g(-1)=\pm1$ remains free, and a second homomorphism $f=|\det|$ survives. (That real ambiguity needs an extra normalization; over $C$ it simply does not arise.)
