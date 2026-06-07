# Determinants (version 6)

*For now only for **real regular (invertible)** matrices.*

Throughout, $R$ denotes the real numbers and $R^* = R \setminus \{0\}$, regarded as a multiplicative group.

---

## 1. Homomorphisms $R^* \rightarrow R^*$

**Definition.** $R^* = R \setminus \{0\}$, regarded as a multiplicative group.

A *homomorphism* $R^* \rightarrow R^*$ is any real function $g$ such that
$$g(x\,y) = g(x)\,g(y).$$

**Task.** We want to determine the form of all homomorphisms $R^* \rightarrow R^*$.

**Theorem 1.** Let $g$ be a homomorphism $R^* \rightarrow R^*$ that is *regular* (continuous, or merely measurable / monotone on $R^*$). Then either
$$g(x) = |x|^{\alpha}, \qquad \text{or} \qquad g(x) = \operatorname{sign}(x)\,|x|^{\alpha},$$
where $\alpha \in R$.

*Proof.* See the separate text, chapters 2 and 3. (This should eventually be merged into a single proof for $R^*$ as a multiplicative group, without reference to the additive notation of chapter 2.)

> **Remark on regularity.** The conclusion of Theorem 1 requires a regularity hypothesis. Without it, a Hamel-basis construction produces pathological multiplicative homomorphisms of $R^*$ that are not of the stated form. We assume regularity throughout. $\qquad\Box$

---

## 2. Restriction of homomorphisms $GL(n) \rightarrow R^*$ to $GD(n)$

**Definitions.**

- $GL(n)$ is the group of all real regular (invertible) matrices.
- $GD(n)$ is the group of all real regular diagonal matrices; it is a subgroup of $GL(n)$.

A *homomorphism* $GL(n) \rightarrow R^*$ is any function $f$ such that
$$f(AB) = f(A)\,f(B). \tag{1}$$

**Proposition.** Let $g$ be a homomorphism $GL(n) \rightarrow R^*$. Then $g(I) = 1$ and $g(A^{-1}) = g(A)^{-1}$.

*Proof.*
$$g(I) = g(I)\cdot 1 = g(I)\,g(I)\,g(I)^{-1} = g(I\cdot I)\,g(I)^{-1} = g(I)\,g(I)^{-1} = 1,$$
$$g(A)\,g(A^{-1}) = g(A\,A^{-1}) = g(I) = 1, \quad\text{hence}\quad g(A^{-1}) = g(A)^{-1}. \qquad\Box$$

**Remark (conjugation invariance).** For any homomorphism,
$$
f(P\,A\,P^{-1}) = f(P)\,f(A)\,f(P^{-1}) = f(P)\,f(P^{-1})\,f(A) = f(P\,P^{-1})\,f(A) = f(I)\,f(A) = f(A), \tag{2}
$$
where we used that the codomain $R^*$ is commutative and that $f(I)=1$ from the previous Proposition.

**Theorem 2.** Let $f : GD(n) \rightarrow R^*$ be a homomorphism. Then $f$ can be expressed through a homomorphism $g : R^* \rightarrow R^*$ via
$$f(D) \equiv g\!\left(\textstyle\prod_i d_i\right).$$

*Proof.* Use the permutation matrices $P_i$ that swap rows/columns $1$ and $i$. $P_i$ arises from $I$ by swapping rows $1$ and $i$ (equivalently columns $1$ and $i$ — the result is the same). We have $P_i^{-1} = P_i$; left multiplication by $P_i$ swaps rows, right multiplication swaps columns, so for a diagonal matrix $D$ the operation $P_i\,D\,P_i^{-1}$ swaps the $1$st and $i$th diagonal entries.

$$
\begin{aligned}
f(D)
&= f\big(\operatorname{diag}(d_1, 1, \dots, 1)\big)\, f\big(\operatorname{diag}(1, d_2, 1, \dots, 1)\big) \cdots f\big(\operatorname{diag}(1, \dots, 1, d_n)\big) \\
&= f\big(\operatorname{diag}(d_1, 1, \dots, 1)\big)\, f\big(P_2\,\operatorname{diag}(d_2, 1, \dots, 1)\,P_2^{-1}\big) \cdots f\big(P_n\,\operatorname{diag}(d_n, 1, \dots, 1)\,P_n^{-1}\big) \\
&= f\big(\operatorname{diag}(d_1, 1, \dots, 1)\big)\, f\big(\operatorname{diag}(d_2, 1, \dots, 1)\big) \cdots f\big(\operatorname{diag}(d_n, 1, \dots, 1)\big) \\
&= f\big(\operatorname{diag}(\textstyle\prod_i d_i,\, 1, \dots, 1)\big) \equiv g\!\left(\textstyle\prod_i d_i\right),
\end{aligned}
$$
where the third equality uses the conjugation invariance (2), and the last equality uses the homomorphism property together with
$$\operatorname{diag}(d_1,1,\dots,1)\,\operatorname{diag}(d_2,1,\dots,1)\cdots\operatorname{diag}(d_n,1,\dots,1) = \operatorname{diag}\big(\textstyle\prod_i d_i,\,1,\dots,1\big).$$

The map $g$ is a homomorphism: it is defined by $g(x) = f\big(\operatorname{diag}(x, 1, \dots, 1)\big)$, so
$$
\begin{aligned}
g(x\,y) &= f\big(\operatorname{diag}(xy, 1, \dots, 1)\big)
   = f\big(\operatorname{diag}(x, 1, \dots, 1)\, \operatorname{diag}(y, 1, \dots, 1)\big) \\
  &= f\big(\operatorname{diag}(x, 1, \dots, 1)\big)\,f\big(\operatorname{diag}(y, 1, \dots, 1)\big) = g(x)\,g(y). \qquad\Box
\end{aligned}
$$

**Corollary.** If $f$ is a homomorphism $GD(n) \rightarrow R^*$, then by Theorem 2 it can be written as $f(D) \equiv g(\prod_i d_i)$ with $g$ a homomorphism $R^* \rightarrow R^*$. Hence, by Theorem 1, either
$$f(D) \equiv g\!\left(\textstyle\prod_i d_i\right) = \big|\textstyle\prod_i d_i\big|^{\alpha}, \tag{h1}$$
or
$$f(D) \equiv g\!\left(\textstyle\prod_i d_i\right) = \operatorname{sign}\!\left(\textstyle\prod_i d_i\right)\big|\textstyle\prod_i d_i\big|^{\alpha}, \tag{h2}$$
where $\alpha \in R$.

---

## 3. Homomorphisms $GL(n) \rightarrow R^*$

**Task.** Find all homomorphisms $GL(n) \rightarrow R^*$.

**Theorem 3.** Every homomorphism on $GL(n)$ is uniquely determined by its restriction to the subgroup $GD(n)$.

*Proof.*

**(a)** If $C$ is diagonalizable over $R$, then $C = P\,D\,P^{-1}$ with $D$ diagonal and $P$ invertible, and by (2)
$$
f(C) = f(P\,D\,P^{-1}) = f(P)\,f(D)\,f(P^{-1}) = f(P)\,f(P^{-1})\,f(D) = f(P\,P^{-1})\,f(D) = f(D).
$$
The diagonal matrix $D$ is determined up to the order of its diagonal entries (which are the eigenvalues of $C$), so the number $\prod_i d_i$ is uniquely determined. Thus $f(C)$ depends only on $f\restriction_{GD(n)}$.

**(b)** For a general $A \in GL(n)$ use the **polar decomposition** $A = H\,U$, where $H = (A A^{\mathsf T})^{1/2}$ is symmetric positive definite and $U = H^{-1}A$ is orthogonal. Then
$$f(A) = f(H)\,f(U).$$

- $H$ is symmetric, hence **orthogonally diagonalizable over $R$**: $H = Q\,D_H\,Q^{\mathsf T}$ with $Q$ orthogonal and $D_H \in GD(n)$ (positive diagonal entries). By part (a), $f(H) = f(D_H)$, which is determined by $f\restriction_{GD(n)}$.

- $U$ is orthogonal. In general an orthogonal matrix is **not** diagonalizable over $R$ (e.g. a rotation has complex eigenvalues), so we do **not** diagonalize $U$ directly. Instead, by the **Cartan–Dieudonné theorem**, $U$ is a product of at most $n$ reflections in hyperplanes,
$$U = S_1\,S_2 \cdots S_k.$$
Each reflection $S_j$ is symmetric and orthogonal with eigenvalues $(1,\dots,1,-1)$, hence orthogonally diagonalizable over $R$:
$$S_j = Q_j\,\operatorname{diag}(1,\dots,1,-1)\,Q_j^{-1}.$$
By part (a), $f(S_j) = f\big(\operatorname{diag}(1,\dots,1,-1)\big) =: r$, a value fixed by $f\restriction_{GD(n)}$. Since $\operatorname{diag}(1,\dots,1,-1)^2 = I$ we have $r^2 = f(I) = 1$, so $r = \pm 1$. Therefore
$$f(U) = r^{\,k},$$
which depends only on the parity of $k$, i.e. only on $\det U = (-1)^k = \pm 1$, and hence is determined by $f\restriction_{GD(n)}$.

Combining the two factors,
$$f(A) = f(H)\,f(U) = f(D_H)\cdot r^{\,k}, \tag{AD}$$
which is completely determined by the restriction $f\restriction_{GD(n)}$ (through the two values $f(D_H)$ and $r = f(\operatorname{diag}(1,\dots,1,-1))$). This argument stays entirely within the real numbers; it does not require complex diagonalization.

Hence the extension of a homomorphism from $GD(n)$ to $GL(n)$ is unique. $\qquad\Box$

**Conclusion (using Theorem 1).** Write $\prod_i d_i := \det A$ (the common value of the diagonal product in any diagonal form obtained above; note $\det H = |\det A|$ and $\det U = (-1)^k$). All homomorphisms $GL(n) \rightarrow R^*$ then have the form: either
$$f(A) = \big|\textstyle\prod_i d_i\big|^{\alpha}, \tag{h11}$$
or
$$f(A) = \operatorname{sign}\!\left(\textstyle\prod_i d_i\right)\big|\textstyle\prod_i d_i\big|^{\alpha}, \tag{h22}$$
where $\alpha \in R$. Indeed, with $f(D_H) = g(|\det A|)$ and $r = g(-1)$:
- case $g(x) = |x|^{\alpha}$ gives $r = 1$ and $f(A) = |\det A|^{\alpha}$, i.e. (h11);
- case $g(x) = \operatorname{sign}(x)|x|^{\alpha}$ gives $r = -1$ and $f(A) = |\det A|^{\alpha}(-1)^k = \operatorname{sign}(\det A)\,|\det A|^{\alpha}$, i.e. (h22),

using $\operatorname{sign}(\det A) = \operatorname{sign}(\det U) = (-1)^k$.

---

## 4. Homogeneous homomorphisms $GL(n) \rightarrow R^*$

**Definition.** A homomorphism $f : GL(n) \rightarrow R^*$ is called *homogeneous (of degree $n$)* if for all $\lambda \in R^*$
$$f(\lambda I) = \lambda^{n}. \tag{homo}$$

**Remark.** From this definition, $f(\lambda A) = f((\lambda I) A) = f(\lambda I)\,f(A) = \lambda^{n} f(A)$.

**Definition.** A homomorphism $f : GL(n) \rightarrow R^*$ is called *positively homogeneous* if equality (homo) holds for all $\lambda > 0$.

**Remark.**
- For even $n$ the two definitions coincide.
- For odd $n$ positive homogeneity is only a necessary condition for homogeneity.

**Theorem 4.1.** Both homomorphisms (h11) and (h22) are positively homogeneous on $GL(n)$ if and only if $\alpha = 1$.

*Proof* (verifying (homo) for $\lambda > 0$, where $\prod_i d_i = \lambda^n$):
$$f(\lambda I) = \big|\lambda^{n}\big|^{\alpha} = (\lambda^{n})^{\alpha}, \tag{hi1}$$
respectively
$$f(\lambda I) = \operatorname{sign}(\lambda^{n})\,\big|\lambda^{n}\big|^{\alpha} = (\lambda^{n})^{\alpha}. \tag{hi2}$$
For all $\lambda > 0$ we have $(\lambda^{n})^{\alpha} = \lambda^{n\alpha}$, which equals $\lambda^{n}$ for all $\lambda$ iff $\alpha = 1$. $\qquad\Box$

**Theorem 4.2.** Every homogeneous homomorphism $f : GL(n) \rightarrow R^*$ has, for **even** $n$, either the form
$$f(A) = \big|\textstyle\prod_i d_i\big|, \tag{h111}$$
or
$$f(A) = \textstyle\prod_i d_i = \operatorname{sign}\!\left(\textstyle\prod_i d_i\right)\big|\textstyle\prod_i d_i\big|, \tag{h222}$$
and for **odd** $n$ only the form (h222).

*Proof.*

**(a) Without Theorem 1.** For any $\lambda$, Theorem 2 gives
$$f(\lambda D) \equiv g\!\left(\textstyle\prod_i (\lambda d_i)\right) = g\!\left(\lambda^{n}\textstyle\prod_i d_i\right) = g(\lambda^{n})\,g\!\left(\textstyle\prod_i d_i\right) = g(\lambda)^{n}\,f(D).$$
At the same time, by homogeneity $f(\lambda D) = \lambda^{n} f(D)$. Since $f(D) \neq 0$, we get
$$g(\lambda)^{n} = \lambda^{n}.$$

- For **odd** $n$, the map $x \mapsto x^n$ is injective on $R$, so $g(\lambda) = \lambda$.
- For **even** $n$, this gives $g(\lambda) = \pm\lambda$ pointwise. Writing $g(\lambda) = \lambda\,s(\lambda)$ with $s(\lambda) = \pm 1$, the homomorphism property forces $s(\lambda\mu) = s(\lambda)s(\mu)$, i.e. $s$ is a homomorphism $R^* \to \{\pm 1\}$. There are exactly two of these — $s \equiv 1$ and $s = \operatorname{sign}$ — and *no regularity hypothesis is needed* to see this: $R_{>0}$ is divisible (every positive real is a square), so any homomorphism $R_{>0} \to \{\pm 1\}$ is trivial; hence $s$ is determined by $s(-1) \in \{\pm 1\}$. This gives $g(\lambda) = \lambda$ or $g(\lambda) = |\lambda|$.

Hence $f(D) = \prod_i d_i$ or $f(D) = |\prod_i d_i|$.

**(b) Using Theorem 1.** For **even** $n$ the claim follows from Theorem 4.1 together with the fact that for even $n$ positive homogeneity implies homogeneity. For **odd** $n$ the case $\lambda^{n} < 0$ can occur (when $\lambda < 0$), which excludes variant (h111) (its values are always non-negative, whereas $f(\lambda I) = \lambda^n$ must be negative); homogeneity again forces $\alpha = 1$ via Theorem 4.1, leaving only (h222). $\qquad\Box$

---

## 5. Definition of the determinant on $GL(n)$

On $GD(n)$ we define the determinant as a *homogeneous homomorphism* $GD(n) \rightarrow R^*$.

By Theorem 4.2:

- For **odd** $n$ the definition is **unique**, and
$$\det(D) = \textstyle\prod_i d_i. \tag{detD}$$
This agrees with the standard definition of the determinant.

- For **even** $n$ the homogeneous homomorphism is **not** unique: Theorem 4.2 leaves the two options (h111) and (h222). To fix the standard determinant we add one further condition.

**Additional condition (reflections, fixing the even-$n$ case).** We require that a *pure reflection in a hyperplane* has determinant $-1$. A reflection in a hyperplane is a diagonal matrix with all entries equal to $1$ except a single $-1$, i.e. $\operatorname{diag}(1,\dots,1,-1)$ (any hyperplane reflection is orthogonally conjugate to this one, so by the conjugation invariance (2) the value does not depend on the chosen hyperplane). We impose
$$\det\big(\operatorname{diag}(1,\dots,1,-1)\big) = -1.$$

This selects the correct branch:
- option (h111) gives $\big|\prod_i d_i\big| = |-1| = +1$;
- option (h222) gives $\prod_i d_i = -1$.

So the condition picks out (h222) $= \prod_i d_i$, the standard determinant, and makes the definition on $GD(n)$ unique for even $n$ as well.

**Odd vs. even $n$.** For **odd** $n$ this condition is automatically satisfied: it follows from **homogeneity** (not merely from being a homomorphism). Indeed, a bare homomorphism may give $+1$ on a reflection even for odd $n$ — for instance $f = |\det|^{\alpha}$, or the trivial $f \equiv 1$ — but Theorem 4.2 shows that the unique *homogeneous* homomorphism for odd $n$ is $\prod_i d_i$, which already gives $-1$. For **even** $n$ both options (h111) and (h222) are homogeneous, so the reflection condition is a genuine extra assumption needed to single out the determinant.

On $GL(n)$ we define the determinant as the extension from the subgroup $GD(n)$, which by Theorem 3 is unique and given by
$$\det(A) = \det(D), \tag{detA}$$
where $D$ is any diagonal form obtained in (AD).

**Theorem 5.** The above definition of the determinant on $GL(n)$ agrees with the standard definition.

*Proof.* With the reflection condition fixing the even-$n$ branch, the standard determinant and our determinant agree on $GD(n)$ (both equal $\prod_i d_i$ there). Both the standard determinant and our determinant are homomorphisms $GL(n) \rightarrow R^*$ extending this common restriction from $GD(n)$ to $GL(n)$. By Theorem 3, the extension of a homomorphism from $GD(n)$ to $GL(n)$ is unique. Hence the two definitions must coincide. $\qquad\Box$

---

## 6. Passing from $R^*$ to $C^*$

We now redo the construction with complex matrices $GL(n,C)$ and codomain $C^*$. The pleasant surprise is that the theory becomes **simpler**: the even/odd dichotomy and the reflection condition of Section 5 both disappear, and the determinant becomes the *unique* homogeneous homomorphism for every $n$.

### Why the even/odd split disappears

It is tempting to attribute this to "complex continuity being a stronger assumption", but that is **not** the reason. The regularity hypothesis (continuity / measurability) plays exactly the same role over $C$ as it does over $R$ in Theorem 1: it only serves to exclude the pathological Hamel-basis homomorphisms. What really changes is the **algebra and topology of the group $K^*$ itself** ($K = R$ or $C$).

Recall where the ambiguity came from (Theorem 4.2): homogeneity forces, for the underlying homomorphism $g : K^* \to K^*$,
$$g(\lambda)^{n} = \lambda^{n}.$$
If $g_1, g_2$ are two solutions, their ratio $\chi = g_1/g_2$ satisfies $\chi(\lambda)^n = 1$, i.e. $\chi$ is a homomorphism into the group $\mu_n(K)$ of $n$-th roots of unity in $K$. Hence the set of homogeneous-compatible $g$ is a torsor under
$$\operatorname{Hom}(K^*,\, \mu_n(K)),$$
and the determinant is unique **iff this group is trivial**. Two equivalent ways to see what it is:

- **Algebraically**: $g(\lambda)^n = \lambda^n$ only constrains $g$ on the subgroup $(K^*)^n$ of $n$-th powers, and leaves it free on $K^*/(K^*)^n$.
  - $K = R$: $(R^*)^n = R^*$ for odd $n$ (odd powers are surjective), but $(R^*)^n = R_{>0}$ for even $n$ — a **proper** subgroup. So $R^*/(R^*)^n$ is trivial for odd $n$ and $\cong \{\pm 1\}$ for even $n$. The leftover freedom is precisely the sign character, i.e. the choice $g(\lambda)=\lambda$ vs. $g(\lambda)=|\lambda|$, equivalently $\det$ vs. $|\det|$.
  - $K = C$: every nonzero complex number has an $n$-th root, so $(C^*)^n = C^*$ and $C^*/(C^*)^n$ is **trivial for every $n$**. No freedom remains.

- **Topologically**: $\operatorname{Hom}_{\mathrm{cont}}(K^*, \mu_n)$ consists of continuous maps from $K^*$ into a *discrete* finite group $\mu_n$, which must be constant on connected components. So it is nontrivial only when $K^*$ is **disconnected**.
  - $R^*$ has **two** connected components ($\pm$), and the nontrivial character is exactly $\operatorname{sign}$ — present only when $\mu_n \ni -1$, i.e. for even $n$.
  - $C^*$ is **connected**, so the only such character is trivial, for all $n$.

In one sentence: **the even/odd ambiguity is the sign character of the disconnected group $R^*$; over the connected group $C^*$ there is no sign to choose, so it vanishes.** This is a statement about $-1$ being a square in $C$ but not in $R$, not about the strength of the continuity assumption.

### The construction over $C$

**(i) Diagonalization now works directly.** Over $C$, the polar decomposition $A = H\,U$ has $H = (A A^{*})^{1/2}$ **Hermitian** positive definite and $U = H^{-1}A$ **unitary**. Both are *normal*, hence **unitarily diagonalizable over $C$**:
$$H = Q\,D_H\,Q^{*}, \qquad U = W\,D_U\,W^{*}, \qquad D_H, D_U \in GD(n,C).$$
So the diagonalization proof of Theorem 3 goes through verbatim — the very step that failed over $R$ (a real orthogonal matrix need not be $R$-diagonalizable) is fine over $C$. This is exactly what was meant by "checking that $R^*$ can be replaced by $C^*$"; it is an independent alternative to the Cartan–Dieudonné fix used in Section 3.

**(ii) Classification of homomorphisms $C^* \rightarrow C^*$** (analog of Theorem 1). Writing $z = |z|\,e^{i\theta}$, the continuous homomorphisms are exactly
$$g(z) = |z|^{c}\left(\tfrac{z}{|z|}\right)^{k}, \qquad c \in C,\; k \in \mathbb{Z}.$$
If one additionally requires $g$ to be **holomorphic**, then $c = k$ and $g(z) = z^{k}$, $k \in \mathbb{Z}$.

**(iii) Conceptual shortcut.** For any infinite field $K$ one has $[GL(n,K), GL(n,K)] = SL(n,K)$, so the determinant induces an isomorphism $GL(n,K)^{\mathrm{ab}} \cong K^*$. Consequently **every** homomorphism $f : GL(n,K) \rightarrow K^*$ factors uniquely as $f = g \circ \det$ with $g : K^* \rightarrow K^*$. The elementary "restrict to $GD(n)$, classify, extend" program of Sections 2–3 simply rebuilds this factorization with the regularity needed to write down $g$ explicitly.

**Theorem 6.** Over $C$ the determinant is the **unique** homogeneous homomorphism $GL(n,C) \rightarrow C^*$, for **every** $n$.

*Proof.* By (iii) (or, elementarily, by (i) together with Theorem 2), $f = g \circ \det$ for some homomorphism $g : C^* \rightarrow C^*$. Homogeneity gives $g(\lambda^n) = g(\det(\lambda I)) = f(\lambda I) = \lambda^n$ for all $\lambda \in C^*$. Since $\lambda \mapsto \lambda^n$ is surjective onto $C^*$, every $w \in C^*$ is of the form $\lambda^n$, so $g(w) = w$ for all $w$, i.e. $g = \mathrm{id}$ and $f = \det$. No reflection normalization is needed.

Note this argument is purely algebraic: it uses neither the classification (ii) nor any regularity (continuity / measurability) hypothesis on $g$. The same is in fact true over $R$ — the *homogeneous* characterization never needs regularity, because homogeneity already pins $g$ to the identity on the $n$-th powers $(K^*)^n$: for any $w$ admitting an $n$-th root $\lambda = w^{1/n}$ one has $g(w) = g(\lambda^n) = \lambda^n = w$, with no appeal to regularity. (Regularity enters only in Theorem 1, which classifies the *non*-homogeneous homomorphisms, where $g$ on $R_{>0}$ would otherwise range over a wild Hamel-basis family.)

The genuine $C$-versus-$R$ difference is therefore **not** regularity but whether $\lambda \mapsto \lambda^n$ is surjective, i.e. whether $K^*/(K^*)^n$ is trivial. Over $C$ every $w$ — including $-1 = i^2$ — has an $n$-th root, so $g(w) = w$ is forced **everywhere** and the determinant is unique even among abstract homomorphisms. Over $R$ with even $n$, the value $-1$ has no real $n$-th root, so $g(-1) = \pm 1$ escapes the homogeneity constraint; that single escaped sign is exactly the $\det$-versus-$|\det|$ ambiguity, removed by the reflection condition of Section 5. $\qquad\Box$

---

## 7. Extension to singular matrices

**The obstruction.** The homomorphism framework cannot, by itself, reach singular matrices: the codomain is the *group* $R^*$ (or $C^*$), and a group homomorphism never takes the value $0 \notin R^*$. To include singular matrices we must change the setting — either algebraically (enlarge to a monoid) or topologically (use density). Both routes agree, and both single out the genuine polynomial determinant.

### (A) Algebraic route: the multiplicative monoid $M_n$

Drop invertibility and ask for $f(AB) = f(A)\,f(B)$ for **all** $A, B \in M_n$ (the full multiplicative monoid of $n \times n$ matrices). The standard determinant satisfies this, since $\det(AB) = \det(A)\det(B)$ holds for all square matrices.

**Theorem 7.** Let $f : M_n \rightarrow R$ be multiplicative on all of $M_n$, restricting on $GL(n)$ to a homomorphism that is non-constant on the diagonal matrices (e.g. any homogeneous determinant). Then $f$ vanishes on every singular matrix, and this extension is unique.

*Proof.* Any matrix of rank $r$ has the normal form $A = P\,E_r\,Q$ with $P, Q \in GL(n)$ and $E_r = \operatorname{diag}(1, \dots, 1, 0, \dots, 0)$ ($r$ ones), so $f(A) = f(P)\,f(E_r)\,f(Q)$; thus $f$ on singular matrices is determined by the idempotents $E_r$, $r < n$. Each $E_r$ is idempotent, $E_r^2 = E_r$, so $f(E_r)^2 = f(E_r)$ and $f(E_r) \in \{0, 1\}$. Finally, from $E_{n-1}\,\operatorname{diag}(1, \dots, 1, t) = E_{n-1}$ we get
$$f(E_{n-1})\,\big(1 - f(\operatorname{diag}(1, \dots, 1, t))\big) = 0 \quad \text{for all } t \in R^*.$$
As $f$ is non-constant on these diagonals (e.g. $f(\operatorname{diag}(1,\dots,1,t)) = t \neq 1$ for the determinant), this forces $f(E_{n-1}) = 0$, and then $f(E_r) = f(E_r)\,f(E_{n-1}) = 0$ for every $r < n$. Hence $f \equiv 0$ on all singular matrices. $\qquad\Box$

So for the determinant the value $0$ on singular matrices is **forced** — no continuity argument is even required.

### (B) Topological route: density of $GL(n)$

The set of singular matrices is the zero set of the polynomial $\det$, a closed subset of measure zero; for any $A$, the matrix $A + \varepsilon I$ is invertible for all but finitely many $\varepsilon$. Hence $GL(n)$ is **dense** in $M_n$. The genuine determinant is a **polynomial**, therefore the unique *continuous* extension of $\det\restriction_{GL(n)}$ to $M_n$, and it equals $0$ on singular matrices. This is the "continuity argument", and it agrees with the algebraic one.

### Remarks

- **Only the genuine determinant extends polynomially.** Among the homomorphisms $|\det A|^{\alpha}$ ($\alpha \ne 1$) some extend continuously to $0$ (those with $\alpha > 0$) and some blow up ($\alpha < 0$); the trivial $g \equiv 1$ even admits *two* monoid extensions (the constant $1$, or the indicator of $GL(n)$). Only $\alpha = 1$, $k = 1$ — the genuine, sign-preserving determinant — extends as a polynomial. This singles it out canonically.
- **Cleanest picture (combining Sections 6 and 7).** Over $C$, the determinant is the unique homogeneous multiplicative map $M_n(C) \rightarrow (C, \cdot)$ that vanishes on singular matrices, for all $n$ — no even/odd split, no reflection normalization, no separate continuity hypothesis needed.

---

## 8. Classical derivation of Theorem 6

The conceptual shortcut (iii) of Section 6 is entirely classical: Theorem 6 is a one-line corollary of the structure theory of the general linear group, namely the computation of its commutator subgroup and abelianization. We spell this out and give references. Throughout, $K$ is an infinite field (in particular $K = R$ or $C$) and $n \ge 2$.

### Step 1 — Transvections generate $SL(n,K)$

An *elementary transvection* is $E_{ij}(\lambda) = I + \lambda\,e_{ij}$ with $i \ne j$, where $e_{ij}$ is the matrix unit. Gaussian elimination (row/column reduction) shows that every matrix of determinant $1$ is a product of transvections; equivalently, the transvections generate $SL(n,K)$. This is standard — see E. Artin, *Geometric Algebra* (1957), Ch. IV, or Hahn–O'Meara, *The Classical Groups and K-Theory* (1989), §2.1.

### Step 2 — Every transvection is a commutator in $GL(n,K)$

Conjugating a transvection by a diagonal matrix $D = \operatorname{diag}(d_1, \dots, d_n)$ gives
$$D\,E_{ij}(\lambda)\,D^{-1} = E_{ij}\!\left(\lambda\,\tfrac{d_i}{d_j}\right),$$
hence the multiplicative commutator
$$\big[D,\, E_{ij}(\lambda)\big] = D\,E_{ij}(\lambda)\,D^{-1}\,E_{ij}(\lambda)^{-1} = E_{ij}\!\left(\lambda\big(\tfrac{d_i}{d_j} - 1\big)\right).$$
Since $K$ is infinite (it suffices that $|K| \ge 4$) we may pick $D$ with $d_i/d_j \ne 1$, so $d_i/d_j - 1$ is a unit; letting $\lambda$ range over $K$, the right-hand side runs over **all** transvections $E_{ij}(\mu)$. Thus every transvection is a commutator, so by Step 1
$$SL(n,K) \subseteq \big[GL(n,K),\, GL(n,K)\big].$$
The reverse inclusion is immediate, since $\det$ is abelian-valued and so $\det[A,B] = 1$, i.e. every commutator lies in $SL(n,K)$. Therefore
$$\big[GL(n,K),\, GL(n,K)\big] = SL(n,K).$$
(For finite fields the only exceptions are $SL(2,\mathbb F_2)$ and $SL(2,\mathbb F_3)$; over $R$ and $C$ there are none. See Artin, *Geometric Algebra*, Ch. IV; Dieudonné, *La géométrie des groupes classiques* (1955); Rotman, *An Introduction to the Theory of Groups* (4th ed., 1995), Thm. 8.9; for the stable/$K$-theoretic version, Whitehead's Lemma in Milnor, *Introduction to Algebraic K-theory* (1971), §3.)

### Step 3 — Abelianization and the universal property of $\det$

The determinant is a surjection $\det : GL(n,K) \twoheadrightarrow K^*$ with kernel $SL(n,K)$. By Step 2 this kernel is exactly the commutator subgroup, so $\det$ realizes the abelianization:
$$GL(n,K)^{\mathrm{ab}} = GL(n,K)\big/\big[GL(n,K),GL(n,K)\big] = GL(n,K)/SL(n,K) \;\xrightarrow{\ \cong\ }\; K^*.$$
Consequently $\det$ has the following universal property: for **every** abelian group $B$ and every homomorphism $f : GL(n,K) \to B$, the map $f$ kills all commutators, hence factors **uniquely** through the determinant,
$$f = g \circ \det, \qquad g : K^* \to B \text{ a homomorphism.} \tag{$\ast$}$$

### Step 4 — Specialization to Theorem 6

Take $B = C^*$ and $K = C$. By $(\ast)$, every homomorphism $f : GL(n,C) \to C^*$ is $f = g \circ \det$ for a unique homomorphism $g : C^* \to C^*$. If $f$ is moreover *homogeneous*, then for all $\lambda \in C^*$
$$g(\lambda^n) = g(\det(\lambda I)) = f(\lambda I) = \lambda^n.$$
Because $\lambda \mapsto \lambda^n$ is surjective onto $C^*$, this gives $g = \mathrm{id}_{C^*}$, whence $f = \det$. This is exactly **Theorem 6**. $\qquad\Box$

**Remark (recovering the real case).** Applying $(\ast)$ with $K = B = R$ recovers the entire structure of Sections 2–5 without diagonalization: every homomorphism $GL(n,R) \to R^*$ is $g \circ \det$, and the regularity of $g$ (Theorem 1) yields the explicit forms $|\det A|^\alpha$ and $\operatorname{sign}(\det A)|\det A|^\alpha$. The even/odd dichotomy reappears precisely as $\operatorname{Hom}(R^*, \mu_n) = \operatorname{Hom}(R^*, \{\pm1\})$ being nontrivial for even $n$, in agreement with Section 6.

> Theorem 6 is therefore not new: it is folklore, an immediate corollary of the classical identification $[GL(n,K),GL(n,K)] = SL(n,K)$ and $GL(n,K)^{\mathrm{ab}} \cong K^*$. The contribution of these notes is the elementary, diagonalization-based route to the same facts and the $R$-versus-$C$ comparison via $K^*/(K^*)^n$.

---


**Proposition.** The composition $f \circ g$ of two homomorphisms $f$ and $g$ is a homomorphism.

*Proof.*
$$(f\circ g)(x_1 x_2) = f\big(g(x_1 x_2)\big) = f\big(g(x_1)\,g(x_2)\big) = f\big(g(x_1)\big)\,f\big(g(x_2)\big) = (f\circ g)(x_1)\,(f\circ g)(x_2). \qquad\Box$$
