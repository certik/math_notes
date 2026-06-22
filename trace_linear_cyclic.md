# Trace From Linearity and Cyclicity

## Assumptions

- $M_n(\mathbb C)$ is the algebra of complex $n\times n$ matrices: a vector space under addition and scalar multiplication, and a (noncommutative) ring under matrix multiplication.
- $e_1,\dots,e_n$ is the standard basis of $\mathbb C^n$. The **matrix unit** $E_{ij}$ is the $n\times n$ matrix with a $1$ in row $i$, column $j$, and $0$ everywhere else. The $E_{ij}$ form a basis of $M_n(\mathbb C)$, and they multiply by
$$E_{ij}E_{kl}=\delta_{jk}\,E_{il}.$$
- $\operatorname{diag}(d_1,\dots,d_n)$ is the diagonal matrix with the listed entries.

We are given a function $f:M_n(\mathbb C)\to\mathbb C$ such that:

**(L) Linearity.** $f(A+B)=f(A)+f(B)$ and $f(cA)=c\,f(A)$ for all $A,B\in M_n(\mathbb C)$ and $c\in\mathbb C$.

**(C) Cyclicity.** $f(AB)=f(BA)$ for all $A,B\in M_n(\mathbb C)$.

The case $n=1$ is tautological: $M_1(\mathbb C)=\mathbb C$, (C) is automatic by commutativity, and (L) gives $f(a)=f(1)\,a$, a scalar multiple of the identity map. Hence assume $n\ge 2$ below.

We use only elementary linear algebra in the standard basis. We do **not** assume any prior trace theory, the identity $\operatorname{tr}(AB)=\operatorname{tr}(BA)$ as a known fact, eigenvalues, the spectral theorem, or that $f$ is continuous. The coordinate sum, when it appears below, is introduced as an explicit formula and its needed properties are proved directly. This note is the additive companion of [Determinant From Homomorphism](determinant_homomorphism.md): there the universal object is the **multiplicative** determinant on the group $GL(n,\mathbb C)$; here it is the **additive** trace on the whole algebra $M_n(\mathbb C)$.

---

## Step 1 — Conjugation invariance

For any invertible $P\in GL(n,\mathbb C)$ and any $A\in M_n(\mathbb C)$, apply (C) to the pair $(PA,\,P^{-1})$:
```{math}
:label: eq-tr-conjugation-invariance

f\big(PAP^{-1}\big)=f\big((PA)P^{-1}\big)=f\big(P^{-1}(PA)\big)=f\big(P^{-1}PA\big)=f(A).
```
So $f$ is invariant under conjugation. Only conjugation invariance by invertible **diagonal** and **permutation** matrices is used below — exactly the two families that drive Steps 2 and 3 of the determinant note; see the remark at the end on how this weaker hypothesis already suffices.

---

## Step 2 — $f$ vanishes on every off-diagonal matrix unit

Fix $i\neq j$. For an invertible diagonal $D=\operatorname{diag}(d_1,\dots,d_n)$ one computes entrywise
$$\big(D\,E_{ij}\,D^{-1}\big)_{kl}=d_k\,(E_{ij})_{kl}\,d_l^{-1}=d_k\,\delta_{ki}\delta_{lj}\,d_l^{-1}=\frac{d_i}{d_j}\,\delta_{ki}\delta_{lj},$$
that is,
```{math}
:label: eq-tr-diagonal-conjugation

D\,E_{ij}\,D^{-1}=\frac{d_i}{d_j}\,E_{ij}.
```
This is the same diagonal-conjugation formula used on transvections in Step 2 of the determinant note (there $T_{ij}(c)=I+c\,E_{ij}$ becomes $T_{ij}(c\,d_i/d_j)$). By conjugation invariance {eq}`eq-tr-conjugation-invariance` and homogeneity (L),
$$f(E_{ij})=f\big(D\,E_{ij}\,D^{-1}\big)=f\!\Big(\tfrac{d_i}{d_j}\,E_{ij}\Big)=\frac{d_i}{d_j}\,f(E_{ij}).$$
Since $i\neq j$ and $n\ge 2$, we may choose $D$ with $d_i\neq d_j$, so $d_i/d_j\neq 1$ and the relation $\big(1-\tfrac{d_i}{d_j}\big)f(E_{ij})=0$ forces
```{math}
:label: eq-tr-offdiagonal-vanishes

f(E_{ij})=0\qquad(i\neq j).
```

---

## Step 3 — $f$ is constant on the diagonal matrix units

For $i\neq j$ let $P_{ij}=I-E_{ii}-E_{jj}+E_{ij}+E_{ji}$ be the permutation matrix that swaps $e_i\leftrightarrow e_j$ and fixes every other basis vector. Then $P_{ij}^2=I$, so $P_{ij}\in GL(n,\mathbb C)$ with $P_{ij}^{-1}=P_{ij}$. Conjugating a diagonal matrix unit just relabels the two basis vectors, so it carries $E_{ii}=e_ie_i^{\mathsf T}$ to $e_je_j^{\mathsf T}=E_{jj}$:
$$P_{ij}\,E_{ii}\,P_{ij}^{-1}=E_{jj}.$$
By conjugation invariance {eq}`eq-tr-conjugation-invariance`, $f(E_{ii})=f(E_{jj})$. Hence all $n$ diagonal units share one common value
```{math}
:label: eq-tr-diagonal-constant

\lambda:=f(E_{11})=f(E_{22})=\dots=f(E_{nn}).
```

---

## The component formula and the factorization $f=g\circ\operatorname{tr}$

Everything so far (Steps 1–3) used **only** that $f$ is linear (L) and cyclic (C). Expanding any $A=\sum_{i,j}a_{ij}E_{ij}$ by linearity and inserting {eq}`eq-tr-offdiagonal-vanishes` and {eq}`eq-tr-diagonal-constant`,
```{math}
:label: eq-tr-lambda-trace

f(A)=\sum_{i,j}a_{ij}\,f(E_{ij})=\sum_{i}a_{ii}\,\lambda=\lambda\sum_{i}a_{ii}.
```
So every linear cyclic functional is a fixed scalar times the sum of the diagonal entries. Introduce that sum as an explicit, everywhere-defined functional
```{math}
:label: eq-tr-component-formula

\operatorname{tr}(A):=\sum_{i=1}^{n}a_{ii},
```
single-valued by construction. Then {eq}`eq-tr-lambda-trace` reads $f=\lambda\,\operatorname{tr}$. Three facts complete the picture, in parallel with the determinant note's existence/uniqueness split.

**1. Existence.** The coordinate sum {eq}`eq-tr-component-formula` is manifestly linear (each $a_{ii}$ is linear in $A$), and it is cyclic by a direct index computation valid for **all** matrices — no invertibility, no domain caveat:
```{math}
:label: eq-tr-cyclic

\operatorname{tr}(AB)=\sum_{i}(AB)_{ii}=\sum_{i,k}a_{ik}b_{ki}=\sum_{k,i}b_{ki}a_{ik}=\sum_{k}(BA)_{kk}=\operatorname{tr}(BA).
```
Thus a linear cyclic functional with the normalization $\lambda=1$ exists; {eq}`eq-tr-cyclic` is the concrete fact underlying the abstract hypothesis (C).

**2. Uniqueness.** Equation {eq}`eq-tr-lambda-trace` pins the value of $f$ at **every** $A$ to $\lambda\sum_i a_{ii}$, where the single number $\lambda=f(E_{11})$ is read off from $f$ on one diagonal matrix unit (Step 3). So a linear cyclic functional has no freedom beyond that one value: two linear cyclic functionals $M_n(\mathbb C)\to\mathbb C$ that agree on a single diagonal matrix unit agree everywhere.

**3. Factorization.** Write $g:\mathbb C\to\mathbb C$ for the unique $\mathbb C$-linear map with $g(1)=\lambda$, namely $g(t)=\lambda t$. Since $\operatorname{tr}$ is surjective onto $\mathbb C$, equation {eq}`eq-tr-lambda-trace` is exactly
$$f(A)=g\big(\operatorname{tr}(A)\big).$$

In particular, suppose $f$ satisfies the normalization $f(E_{ii})=1$ for the diagonal units, i.e. $\lambda=1$ (equivalently $f(I)=n$). Then $g=\operatorname{id}$ and {eq}`eq-tr-lambda-trace` reads $f=\operatorname{tr}$. Combined with existence, this *characterizes* the trace:

> $\operatorname{tr}$ is the **unique** linear cyclic functional $M_n(\mathbb C)\to\mathbb C$ whose value on every diagonal matrix unit $E_{ii}$ is $1$ (equivalently, with $\operatorname{tr}(I)=n$).

For a general $f$, this is the **factorization theorem**:
$$\boxed{\,f(A)=g\big(\operatorname{tr}(A)\big)=\lambda\sum_{i=1}^{n}a_{ii},\qquad g(t)=\lambda t,\quad \lambda=f(E_{11})\quad(A\in M_n(\mathbb C)),\,}$$
for a single free scalar $\lambda\in\mathbb C$ — **derived from linearity and cyclicity alone**, with no continuity, eigenvalues, or spectral theory.

Conversely, every $\lambda\,\operatorname{tr}$ *is* a linear cyclic functional: it is linear because $\operatorname{tr}$ is, and cyclic by {eq}`eq-tr-cyclic`. Hence these are **exactly** all of them: the trace is the universal linear cyclic functional, and every other is obtained by post-composing it with a $\mathbb C$-linear endomorphism $g$ of $\mathbb C$ — that is, multiplication by a scalar.

---

## Remarks

**Conjugation invariance already suffices.** Steps 2 and 3 used only that $f$ is invariant under conjugation by invertible diagonal and permutation matrices, together with linearity. So the conclusion $f=\lambda\,\operatorname{tr}$ already follows from **(L)** plus conjugation invariance, a hypothesis weaker than full cyclicity (C). Since $\lambda\,\operatorname{tr}$ is in turn cyclic by {eq}`eq-tr-cyclic`, the two families
$$\{\text{linear, cyclic}\}=\{\text{linear, conjugation-invariant}\}=\{\lambda\,\operatorname{tr}:\lambda\in\mathbb C\}$$
coincide. Step 1 is what bridges the stated hypothesis (C) to the conjugation invariance actually used, exactly as Step 1 of the determinant note bridges multiplicativity to conjugation invariance.

**Direct route from cyclicity.** One can also bypass conjugation entirely and read both vanishing facts straight off the matrix-unit products $E_{ij}E_{kl}=\delta_{jk}E_{il}$. For $i\neq j$, from $E_{ij}E_{jj}=E_{ij}$ and $E_{jj}E_{ij}=0$ (here $\delta_{ji}=0$), cyclicity (C) gives
$$f(E_{ij})=f(E_{ij}E_{jj})=f(E_{jj}E_{ij})=f(0)=0.$$
For the diagonal, $E_{ij}E_{ji}=E_{ii}$ and $E_{ji}E_{ij}=E_{jj}$, so cyclicity gives
$$f(E_{ii})=f(E_{ij}E_{ji})=f(E_{ji}E_{ij})=f(E_{jj}).$$
These reproduce {eq}`eq-tr-offdiagonal-vanishes` and {eq}`eq-tr-diagonal-constant` in two lines, after which {eq}`eq-tr-lambda-trace` finishes as before. The conjugation argument in Steps 1–3 is kept as the spine because it parallels the determinant note tool for tool: diagonal conjugation {eq}`eq-tr-diagonal-conjugation` and permutation matrices.

**Parallel with the determinant.** The free factor $g$ here — a $\mathbb C$-linear map $\mathbb C\to\mathbb C$, i.e. multiplication by the scalar $\lambda$ — is the additive analog of the free homomorphism $g\in\operatorname{Hom}(\mathbb C^*,\mathbb C^*)$ in [Determinant From Homomorphism](determinant_homomorphism.md). There, post-composition is with a multiplicative homomorphism of $\mathbb C^*$ and the universal object is $\det$ on $GL(n,\mathbb C)$; here, post-composition is with a linear endomorphism of $(\mathbb C,+)$ and the universal object is $\operatorname{tr}$ on $M_n(\mathbb C)$. In both cases the structural hypothesis (multiplicativity there, linearity-plus-cyclicity here) determines the invariant up to that single free post-composition. If the homogeneity half of (L) is dropped and only additivity is kept, $g$ may be any additive endomorphism of $(\mathbb C,+)$, a solution of Cauchy's additive functional equation — pinned down to multiplication by a scalar once continuity or measurability is imposed, exactly as in [Homomorphisms $\mathbb C^*\to\mathbb C^*$](cstar_homomorphism.md).
