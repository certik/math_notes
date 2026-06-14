# The Determinant of a $(0,2)$ Tensor

*A short, self-contained axiomatic derivation: from two natural axioms we show that the determinant of an arbitrary covariant rank-2 tensor is forced to be the determinant of its component matrix.*

## 1. Setup

Let $V$ be an $n$-dimensional vector space over a field $K$ (think $K=\mathbb{R}$ or $\mathbb{C}$), and let $T$ be a **$(0,2)$ tensor** on $V$ — i.e. a bilinear form
$$
T:V\times V\to K .
$$
No symmetry is assumed: $T$ is completely arbitrary. Fix a basis $\{e_1,\dots,e_n\}$. The **components** of $T$ form the $n\times n$ **Gram matrix**
$$
M=(M_{ij}),\qquad M_{ij}:=T(e_i,e_j).
$$
We ask: what scalar deserves to be called the *determinant* of $T$, and is it uniquely forced?

## 2. How the components transform

Change basis by $P\in GL(V)$, writing $e'_j=\sum_i P^{i}{}_{j}\,e_i$. Then
$$
M'_{kl}=T(e'_k,e'_l)=\sum_{i,j}P^{i}{}_{k}P^{j}{}_{l}\,T(e_i,e_j)=(P^{\mathsf T}MP)_{kl},
$$
so the components transform by
$$
M'=P^{\mathsf T}MP .
$$
Taking determinants, $\det M'=(\det P)^2\det M$. Thus $\det M$ is **not** a basis-independent number: under a change of basis it is multiplied by $(\det P)^2$. An object transforming this way is a **scalar density of weight $2$**. The most we can hope to characterize is therefore a weight-2 density; the goal is to show it is unique.

## 3. The natural operation on a bilinear form

Because $T$ takes *two independent* arguments, any pair of linear maps $A,B\in GL(V)$ yields a new bilinear form
$$
T_{A,B}(v,w):=T(Av,\,Bw).
$$
Its components are
$$
(T_{A,B})_{ij}=T(Ae_i,Be_j)=\sum_{k,l}A^{k}{}_{i}\,B^{l}{}_{j}\,M_{kl}=(A^{\mathsf T}MB)_{ij},
$$
so the Gram matrix of $T_{A,B}$ is $A^{\mathsf T}MB$. The change of basis of Section 2 is exactly the **diagonal** special case $A=B=P$.

## 4. The axioms

We seek a rule $D$ that assigns to each bilinear form — equivalently, to its Gram matrix $M$ — a scalar $D(M)\in K$, subject to just two requirements.

**Axiom I (bilinear weight law).** Transforming the two slots independently multiplies the answer by the corresponding determinants:
$$
D(A^{\mathsf T}MB)=\det(A)\,\det(B)\,D(M)\qquad\text{for all }A,B\in GL(V).
$$

**Axiom II (normalization).**
$$
D(I)=1 .
$$

**Why these are the natural axioms.** A $(0,2)$ tensor is an element of $V^{*}\otimes V^{*}$, whose two covariant slots are *a priori* independent copies of $V^{*}$. Axiom I says the determinant scales by one factor of $\det$ in **each** slot separately — precisely as a volume form is multilinear and alternating in each of its arguments. Setting $A=B=P$, Axiom I already contains the weight-2 density law $D(P^{\mathsf T}MP)=(\det P)^2D(M)$ of Section 2; but it says strictly more, and that surplus is exactly what makes the determinant unique. (The weight-2 law *by itself* does not pin $D$ down — it leaves room for impostors that depend on the mismatch between the two slots. Axiom I closes that gap.) Axiom II only fixes the overall scale.

## 5. Derivation

We show Axioms I–II force $D=\det$, in two short steps. Assume $K$ has more than two elements (e.g. $\mathbb{R}$ or $\mathbb{C}$).

**Step 1 — nondegenerate forms.** Let $M$ be invertible. Apply Axiom I to the reference matrix $I$, with $A=I$ and $B=M$. Since $I^{\mathsf T}\,I\,M=M$,
$$
D(M)=D\!\left(I^{\mathsf T}\,I\,M\right)=\det(I)\,\det(M)\,D(I)=\det(M),
$$
the last equality by Axiom II. Hence $D(M)=\det(M)$ for **every** invertible $M$.

**Step 2 — degenerate forms.** Let $M$ be singular; we show $D(M)=0$ without any extra axiom. Since $\det M=0$, the map $M$ has a nontrivial kernel: there is a column vector $u\neq 0$ with $Mu=0$. Pick a row vector $w^{\mathsf T}$ with $w^{\mathsf T}u=c$, where $c\neq 0$ and $c\neq -1$ (possible: $u\neq0$, so $w^{\mathsf T}u$ can be scaled to any value, and $K$ has an element outside $\{0,-1\}$). Set
$$
B:=I+u\,w^{\mathsf T}\in GL(V),\qquad \det B=1+w^{\mathsf T}u=1+c\neq 0 .
$$
Because $Mu=0$,
$$
MB=M\bigl(I+u\,w^{\mathsf T}\bigr)=M+(Mu)\,w^{\mathsf T}=M .
$$
Now apply Axiom I with $A=I$:
$$
D(M)=D\!\left(I^{\mathsf T}MB\right)=\det(B)\,D(M)=(1+c)\,D(M).
$$
As $1+c\neq 1$, this forces $D(M)=0=\det(M)$.

Combining the two steps, $D(M)=\det(M)$ for **all** $M$. $\qquad\blacksquare$

## 6. Existence

Uniqueness is only meaningful if a solution exists at all — and the determinant itself is one:
$$
\det(A^{\mathsf T}MB)=\det(A)\det(M)\det(B),\qquad \det(I)=1,
$$
the first equality by multiplicativity of $\det$. So $D=\det$ is the **one and only** rule satisfying Axioms I–II.

## 7. Conclusion

For an arbitrary $(0,2)$ tensor $T$ with components $M_{ij}=T(e_i,e_j)$, the determinant is forced to be
$$
\boxed{\,d(T)=\det\bigl(T_{ij}\bigr)\,},
$$
and, by Section 2, it is not a scalar but a **density of weight $2$**, transforming as $d(T)\mapsto(\det P)^2\,d(T)$ under a change of basis $P$.

Two closing remarks:

- **Nothing used any symmetry of $M$.** The derivation applies verbatim to symmetric, antisymmetric, and fully general bilinear forms alike. No regularity hypothesis (polynomiality, continuity, …) was needed: Axiom I is strong enough on its own because the operation $M\mapsto A^{\mathsf T}MB$ already reaches every invertible matrix from $I$.

- **Axiom I is the functorial determinant in coordinates.** Let $\phi_T:V\to V^{*}$, $\phi_T(v):=T(v,\cdot)$. Applying the top exterior power gives a map $\bigwedge^{n}\phi_T:\bigwedge^{n}V\to\bigwedge^{n}V^{*}$. Since $\phi_{T_{A,B}}=A^{*}\circ\phi_T\circ B$, functoriality yields
$$
\textstyle\bigwedge^{n}\phi_{T_{A,B}}=\det(A)\,\det(B)\,\bigwedge^{n}\phi_T ,
$$
which is exactly Axiom I. Defining the determinant as $d(T):=\bigwedge^{n}\phi_T$ therefore builds the axiom in for free.
