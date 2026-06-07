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
- For **even** $n$, this gives $g(\lambda) = \pm\lambda$ pointwise. Writing $g(\lambda) = \lambda\,s(\lambda)$ with $s(\lambda) = \pm 1$, the homomorphism property forces $s(\lambda\mu) = s(\lambda)s(\mu)$, i.e. $s$ is a (regular) homomorphism $R^* \to \{\pm 1\}$. The only such homomorphisms are $s \equiv 1$ and $s = \operatorname{sign}$, giving $g(\lambda) = \lambda$ or $g(\lambda) = |\lambda|$.

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

## Open questions

It still remains to check that $R^*$ can be replaced by $C^*$, and then (by some continuity argument?) to extend the definition to singular matrices as well.

---

## Appendix

**Proposition.** The composition $f \circ g$ of two homomorphisms $f$ and $g$ is a homomorphism.

*Proof.*
$$(f\circ g)(x_1 x_2) = f\big(g(x_1 x_2)\big) = f\big(g(x_1)\,g(x_2)\big) = f\big(g(x_1)\big)\,f\big(g(x_2)\big) = (f\circ g)(x_1)\,(f\circ g)(x_2). \qquad\Box$$
