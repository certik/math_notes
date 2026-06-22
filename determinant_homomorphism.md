# Determinant From Homomorphism

:::{note} Lean formalization
The results in this note are formalized in Lean 4 + Mathlib in
[`DeterminantHomomorphism.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean),
reusing the $\mathbb C^*\to\mathbb C^*$ classification from
[`CstarHomomorphism.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/CstarHomomorphism.lean).
Each **Lean proof** dropdown below includes the corresponding declaration verbatim from the compiled
source, so the displayed code cannot drift from what is actually checked. Continuous integration runs
`lake build` (which fails on any error or `sorry`), so every displayed proof is guaranteed to
type-check.

The Lean statements are slightly more general than the note: they hold for every finite index type
`n` (the homomorphism is `f : GLₙ(ℂ) →* ℂˣ`, with `ℂˣ` mathlib's group of units of `ℂ`, i.e.
$\mathbb C^*$), and the one-variable factor `g` is read off at an arbitrary chosen diagonal slot
`i0 : n` rather than slot $1$. The single-valued determinant is mathlib's Leibniz determinant
`Matrix.det`.
:::

## Assumptions

- $\mathbb C^* = \mathbb C\setminus\{0\}$ under multiplication; $M_n(\mathbb C)$ all complex $n\times n$ matrices; $GL(n,\mathbb C)$ the invertible ones, a group under multiplication.
- $\operatorname{diag}(x_1,\dots,x_n)$ is the diagonal matrix with the listed entries.

We are given a function $f:GL(n,\mathbb C)\to \mathbb C^*$ such that:

**(H1) Multiplicativity.** $f(AB)=f(A)\,f(B)$ for all $A,B\in GL(n,\mathbb C)$.

The case $n=1$ is tautological: $GL(1,\mathbb C)=\mathbb C^*$, and the factorization is $f=g\circ\operatorname{id}$ with $g=f$. Hence assume $n\ge 2$ below.

We also use only elementary language about rows, spans, and multilinear functions. We do **not** assume any prior determinant theory, determinant multiplicativity, the polar decomposition, or the spectral theorem. When the Leibniz polynomial appears below, it is introduced as an explicit polynomial and its needed properties are proved directly.

Throughout, $e_1,\dots,e_n$ is the standard basis, and we view a matrix $A$ as its list of rows $r_1,\dots,r_n\in \mathbb C^n$. The **matrix unit** $E_{ij}$ is the $n\times n$ matrix with a $1$ in row $i$, column $j$, and $0$ everywhere else. We write $T_{ij}(c)=I+c\,E_{ij}$ (for $i\neq j$) for the **transvection** that adds $c$ times row $j$ to row $i$ under left multiplication.

---

## Step 1 — $f(I)=1$ and conjugation invariance

From $I\cdot I=I$ and (H1): $f(I)=f(I)^2$. Since $f(I)\in \mathbb C^*$ is nonzero, $f(I)=1$.

For any $P\in GL(n,\mathbb C)$, using (H1) and the commutativity of $\mathbb C^*$,
```{math}
:label: eq-dethom-conjugation-invariance

f(PAP^{-1})=f(P)f(A)f(P^{-1})=f(P)f(P^{-1})f(A)=f(PP^{-1})f(A)=f(A).
```
So $f$ is invariant under conjugation.

:::{dropdown} Lean proof: `hom_conj_eq`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-conjugation
:end-before: ANCHOR_END: dethom-conjugation
```
:::

---

## Step 2 — $f$ equals $1$ on every transvection

Fix $i\neq j$. Two observations.

**All nonzero $c$ give conjugate transvections.** For an invertible diagonal $D=\operatorname{diag}(d_1,\dots,d_n)$ one computes $D\,T_{ij}(c)\,D^{-1}=T_{ij}\!\big(c\,d_i/d_j\big)$. Choosing $d_i/d_j$ freely, the factor $c\,d_i/d_j$ ranges over all of $\mathbb C^*$. Hence all $T_{ij}(c)$ with $c\neq 0$ are conjugate, so by {eq}`eq-dethom-conjugation-invariance` the value $f(T_{ij}(c))=:t$ is the same for every $c\neq 0$.

:::{dropdown} Lean proof: `diagonal_conj_transvection`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-diag-conj
:end-before: ANCHOR_END: dethom-diag-conj
```
:::

**The common value satisfies $t=t^2$.** Since $E_{ij}^2=0$, we have $T_{ij}(c)\,T_{ij}(c')=T_{ij}(c+c')$. Taking $c=c'=1$ and applying (H1): $t=f(T_{ij}(2))=f(T_{ij}(1))^2=t^2$. As $t\in \mathbb C^*$, this forces $t=1$. Together with $T_{ij}(0)=I$ and Step 1,
```{math}
:label: eq-dethom-transvection-value

f\big(T_{ij}(c)\big)=1\qquad\text{for all }c.
```
In particular, by (H1), **left- or right-multiplying by a transvection does not change $f$** — i.e. adding a multiple of one row (or column) to another leaves $f$ unchanged.

:::{dropdown} Lean proof: `hom_transvection_eq_one`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-transvection-value
:end-before: ANCHOR_END: dethom-transvection-value
```
:::

---

## Step 3 — The one-variable function $g$, and $f$ on diagonal matrices

Define
$$g(x):=f\big(\operatorname{diag}(x,1,\dots,1)\big),\qquad x\in \mathbb C^*.$$

**$g$ is a homomorphism $\mathbb C^*\to \mathbb C^*$:** from $\operatorname{diag}(xy,1,\dots,1)=\operatorname{diag}(x,1,\dots,1)\operatorname{diag}(y,1,\dots,1)$ and (H1),
```{math}
:label: eq-dethom-g-homomorphism

g(xy)=g(x)g(y).
```

:::{dropdown} Lean proof: `diagonalFactorOfHom_mul`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-g-hom
:end-before: ANCHOR_END: dethom-g-hom
```
:::

**Position does not matter.** For $i>1$ let
$$P_i=I-E_{11}-E_{ii}+E_{1i}+E_{i1},$$
the permutation matrix that sends $e_1\mapsto e_i$, $e_i\mapsto e_1$, and fixes every other basis vector. Then $P_i^2=I$, so $P_i\in GL(n,\mathbb C)$ with $P_i^{-1}=P_i$. Conjugating a diagonal matrix by $P_i$ just relabels the two basis vectors, so it swaps the diagonal entries in slots $1$ and $i$: $P_i\operatorname{diag}(x,1,\dots,1)P_i^{-1}=\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)$. By {eq}`eq-dethom-conjugation-invariance`
```{math}
:label: eq-dethom-diagonal-slot

f\big(\operatorname{diag}(1,\dots,\underset{i}{x},\dots,1)\big)=g(x).
```

:::{dropdown} Lean proof: `hom_oneSlotDiagonalGL_eq_g`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-diagonal-slot
:end-before: ANCHOR_END: dethom-diagonal-slot
```
:::

**Product over the diagonal.** Writing $\operatorname{diag}(d_1,\dots,d_n)=\prod_{i=1}^n\operatorname{diag}(1,\dots,\underset{i}{d_i},\dots,1)$ and using (H1), {eq}`eq-dethom-diagonal-slot`, and {eq}`eq-dethom-g-homomorphism`,
```{math}
:label: eq-dethom-diagonal-product

f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_{i=1}^n g(d_i)=g\!\Big(\prod_{i=1}^n d_i\Big).
```

:::{dropdown} Lean proof: `hom_diagonalGL_eq`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-diagonal-product
:end-before: ANCHOR_END: dethom-diagonal-product
```
:::

---

## The factorization theorem $f=g\circ\det$ (multiplicativity only)

Everything so far (Steps 1–3) used **only** that $f$ is a homomorphism (H1). Three facts are all we shall use:

* (H1) $f$ is a homomorphism $GL(n,\mathbb C)\to \mathbb C^*$;
* {eq}`eq-dethom-transvection-value`: $f\big(T_{ij}(c)\big)=1$ for every transvection;
* {eq}`eq-dethom-diagonal-product`: $f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=g\!\big(\prod_i d_i\big)$, with $g:\mathbb C^*\to \mathbb C^*$ the homomorphism of Step 3.

We show these force $f=g\circ\det$, the determinant being supplied — single-valued — by the Leibniz polynomial. We work entirely inside $GL(n,\mathbb C)$, never evaluating $f$ on a singular matrix, with no appeal to continuity, exterior algebra, or Zariski density.

**1. Transvections and diagonal matrices generate $GL(n,\mathbb C)$.**
*Lemma.* Every $A\in GL(n,\mathbb C)$ factors as
```{math}
:label: eq-dethom-transvection-diagonal-factorization

A=E\,D,\qquad E=\text{a product of transvections},\quad D=\operatorname{diag}(d_1,\dots,d_n),\quad d_i\in \mathbb C^*.
```
*Proof.* Row-reduce $A$ using only transvections — no row swaps, no pivot normalization. Adding $c$ times row $j$ to row $i$ is left multiplication by $T_{ij}(c)$, and every intermediate matrix is invertible, being a product of invertible matrices.

Proceed column by column. Suppose columns $1,\dots,k-1$ have already been reduced to nonzero diagonal entries with all their other entries cleared. In column $k$, at least one entry in rows $k,\dots,n$ is nonzero: otherwise column $k$ would be supported in rows $1,\dots,k-1$, hence a linear combination of columns $1,\dots,k-1$ (which are nonzero multiples of $e_1,\dots,e_{k-1}$), contradicting invertibility. If the pivot entry $a_{kk}$ is zero, pick $\ell>k$ with $a_{\ell k}\neq 0$ and add row $\ell$ to row $k$ (one transvection $T_{k\ell}(1)$); this makes the pivot equal to $a_{\ell k}\neq 0$, and it disturbs nothing in columns $1,\dots,k-1$, where row $\ell$ has only zeros. Now, with pivot $\alpha=a_{kk}\neq 0$, for each row $\ell\neq k$ add $-a_{\ell k}/\alpha$ times row $k$ to row $\ell$ to clear the rest of column $k$; this leaves the earlier pivot columns untouched because row $k$ has zeros there.

After column $n$ this yields transvections $T_1,\dots,T_m$ with
$$T_m\cdots T_1 A=D,$$
$D$ invertible diagonal. Since $T_{ij}(c)^{-1}=T_{ij}(-c)$ is again a transvection,
$$A=T_1^{-1}\cdots T_m^{-1}\,D$$
is a factorization of the required form. $\square$

:::{dropdown} Lean proof: `exists_transvec_diagonal_factorization`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-generation
:end-before: ANCHOR_END: dethom-generation
```
:::

**2. Existence: the Leibniz polynomial.** Before drawing any conclusion about the abstract $f$, exhibit one *explicit* function we can evaluate unambiguously. Let
$$L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n a_{i,\sigma(i)},$$
a polynomial defined for **every** matrix by this formula — hence single-valued by construction. The following are **formal identities in the entries**, valid for all $A$ (singular included) and checked directly on the sum:

* (a) $L(I)=1$, and more generally $L\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i$ — only $\sigma=\mathrm{id}$ survives;
* (b) **two equal rows $\Rightarrow L=0$**: if rows $p$ and $q$ are equal and $\tau=(p\ q)$, then pairing each $\sigma$ with $\sigma\circ\tau$ gives equal products with opposite signs, so the sum cancels pair by pair;
* (c) $L$ is **linear in each row** — every summand is.

From (b) and (c), adding a multiple of one row to another leaves $L$ unchanged. Explicitly, write $L(r_1,\dots,r_n)$ for $L$ evaluated on the matrix with rows $r_1,\dots,r_n$. If $i\neq j$, then multilinearity in the $i$-th row gives
$$
\begin{aligned}
L(r_1,\dots,\underset{i}{r_i+c r_j},\dots,r_n)
&=L(r_1,\dots,\underset{i}{r_i},\dots,r_n)\\
&\quad+c\,L(r_1,\dots,\underset{i}{r_j},\dots,r_n)\\
&=L(r_1,\dots,\underset{i}{r_i},\dots,r_n),
\end{aligned}
$$
because the second term has rows $i$ and $j$ equal. Hence
$L\big(T_{ij}(c)\,X\big)=L(X)$; taking $X=I$ and using (a) gives in particular $L(T_{ij}(c))=1$. Thus $L$ satisfies $L(T_{ij}(c))=1$ and $L(\operatorname{diag}(d_1,\dots,d_n))=\prod_i d_i$ outright — and, unlike the abstract $f$ on $GL$, with **no domain caveat**, because $L$ is everywhere-defined and (b) is a genuine polynomial identity even though "two equal rows" is a singular configuration.

Feed $L$ a factorization {eq}`eq-dethom-transvection-diagonal-factorization`. Peeling the transvections of $E$ off one at a time by $L(T_{ij}(c)X)=L(X)$, then applying (a),
```{math}
:label: eq-dethom-leibniz-factorization

L(A)=L(E\,D)=L(D)=\prod_i d_i.
```
In particular, $L(A)\in \mathbb C^*$ for $A\in GL(n,\mathbb C)$.

:::{dropdown} Lean proof: `detGL_factorization`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-leibniz-factorization
:end-before: ANCHOR_END: dethom-leibniz-factorization
```
:::

**3. $\prod_i d_i$ is well-defined.** A priori the product in {eq}`eq-dethom-leibniz-factorization` could depend on the factorization {eq}`eq-dethom-transvection-diagonal-factorization` chosen, and the concrete $L$ is exactly what rules this out: any two factorizations $A=ED=E'D'$ both satisfy {eq}`eq-dethom-leibniz-factorization`, so both diagonal products equal the one unambiguous number $L(A)$.

**4. $L$ is multiplicative on $GL(n,\mathbb C)$.** Let $A,B\in GL(n,\mathbb C)$. Choose factorizations
$$A=E_A D_A,\qquad B=E_B D_B,$$
with $E_A,E_B$ products of transvections and
$$D_A=\operatorname{diag}(a_1,\dots,a_n),\qquad D_B=\operatorname{diag}(b_1,\dots,b_n).$$
Then
$$AB=E_A\,D_A\,E_B\,D_B
=E_A\,(D_AE_BD_A^{-1})\,D_AD_B.$$
If $E_B=T_1\cdots T_m$ is a product of transvections, then
$$D_AE_BD_A^{-1}=(D_AT_1D_A^{-1})\cdots(D_AT_mD_A^{-1}),$$
and each factor $D_AT_kD_A^{-1}$ is again a transvection by the diagonal-conjugation formula of Step 2. Therefore the displayed expression for $AB$ is a factorization of the form {eq}`eq-dethom-transvection-diagonal-factorization`, with diagonal factor $D_AD_B=\operatorname{diag}(a_1b_1,\dots,a_nb_n)$. Applying {eq}`eq-dethom-leibniz-factorization` to the chosen factorizations of $A$, $B$, and $AB$ gives
```{math}
:label: eq-dethom-leibniz-multiplicativity

L(AB)=\prod_i a_i b_i=\Big(\prod_i a_i\Big)\Big(\prod_i b_i\Big)=L(A)L(B).
```
Thus the Leibniz polynomial is multiplicative on $GL(n,\mathbb C)$. This note deliberately restricts the determinant derivation to $GL(n,\mathbb C)$, not all matrices, to keep the foundational factorization theorem completely internal to invertible matrices. Multiplicativity and other determinant facts on singular matrices can be developed separately when needed; the rock-solid $GL(n,\mathbb C)$ factorization theorem is the piece used in many applications in separate notes.

:::{dropdown} Lean proof: `detGL_mul`
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-leibniz-mult
:end-before: ANCHOR_END: dethom-leibniz-mult
```
:::

**5. Uniqueness: $f$ is determined by its values on diagonal matrices, and $f=g\circ\det$.** Points 2–4 were the *existence* half: the explicit homomorphism $L$ exists, is single-valued, and is multiplicative on $GL(n,\mathbb C)$. Now the *uniqueness* half. For any factorization {eq}`eq-dethom-transvection-diagonal-factorization`, using (H1), then {eq}`eq-dethom-transvection-value` (so $f(E)=1$), then {eq}`eq-dethom-diagonal-product`,
$$f(A)=f(E)\,f(D)=f(D)=g\!\Big(\prod_i d_i\Big)=g\big(L(A)\big),$$
the last equality by {eq}`eq-dethom-leibniz-factorization`. This forces the value of $f$ at **every** $A\in GL(n,\mathbb C)$: it must equal $g(L(A))$, where $g$ is read off from $f$ on the matrices $\operatorname{diag}(x,1,\dots,1)$ (Step 3). So a homomorphism has no freedom beyond its values on diagonal matrices — two homomorphisms $GL(n,\mathbb C)\to\mathbb C^*$ that agree on the invertible diagonal matrices agree everywhere — and every homomorphism factors as $f=g\circ L$.

:::{dropdown} Lean proof: `hom_eq_of_eq_on_oneSlot` (and `hom_eq_detGL_of_normalized`)
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-uniqueness
:end-before: ANCHOR_END: dethom-uniqueness
```
:::

In particular, suppose $f$ satisfies the normalization $f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\prod_i d_i$, i.e. $g=\operatorname{id}$. Then the displayed equation reads $f(A)=L(A)$ for all $A$. Combined with existence, this *characterizes* the determinant:

> $L=\det$ is the **unique** homomorphism $GL(n,\mathbb C)\to\mathbb C^*$ whose value on every invertible diagonal matrix is the product of its diagonal entries.

For a general $f$, this is the **factorization theorem**:
$$\boxed{\,f(A)=g(L(A)),\qquad L(A):=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)} \equiv \det A \qquad(A\in GL(n,\mathbb C)),\,}$$
for some homomorphism $g:\mathbb C^*\to \mathbb C^*$ — **derived from multiplicativity alone**, with no continuity, measurability, or Zariski density. The single-valued determinant is the explicit polynomial $L$, the well-definedness of $\prod_i d_i=\det A$ is anchored on $L$, and the factorization is $f=g\circ\det$.

:::{dropdown} Lean proof: `hom_factor_det` (the boxed $f=g\circ\det$)
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-factorization
:end-before: ANCHOR_END: dethom-factorization
```
:::

:::{dropdown} Lean proof: `determinant_leibniz_formula` ($L\equiv\det$ is the Leibniz polynomial)
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-leibniz-formula
:end-before: ANCHOR_END: dethom-leibniz-formula
```
:::

Conversely, every $g\circ\det$ with $g\in\operatorname{Hom}(\mathbb C^*,\mathbb C^*)$ *is* a homomorphism $GL(n,\mathbb C)\to \mathbb C^*$: by {eq}`eq-dethom-leibniz-multiplicativity`, $L(AB)=L(A)L(B)$ on $GL(n,\mathbb C)$, and then $g(L(AB))=g(L(A))g(L(B))$. Hence these are **exactly** all of them: the determinant is the universal homomorphism, and every other homomorphism is obtained by post-composing it with an arbitrary group homomorphism $g:\mathbb C^*\to\mathbb C^*$. The factor $g$ is genuinely free; as derived in [Homomorphisms $\mathbb C^*\to\mathbb C^*$](cstar_homomorphism.md), if one additionally requires continuity, or merely Borel measurability, then
$$g(w)=|w|^s\left(\frac{w}{|w|}\right)^k,\qquad s\in\mathbb C,\quad k\in\mathbb Z,$$
with the determinant itself corresponding to $g(w)=w$, i.e. $s=1$ and $k=1$.

:::{dropdown} Lean proof: `hom_eq_postcomposeDetGL` (converse: every $g\circ\det$ is a homomorphism)
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-converse
:end-before: ANCHOR_END: dethom-converse
```
:::

:::{dropdown} Lean proof: `hom_factor_det_cstar` (measurable $g$ gives the polar form; $\det$ is $s=1,k=1$)
```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphism.lean
:language: lean
:start-after: ANCHOR: dethom-cstar
:end-before: ANCHOR_END: dethom-cstar
```
:::
