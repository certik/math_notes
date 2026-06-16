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

**Why these are the natural axioms.** A $(0,2)$ tensor is an element of $V^{*}\otimes V^{*}$, whose two covariant slots are *a priori* independent copies of $V^{*}$. Axiom I says the determinant scales by one factor of $\det$ in **each** slot separately — precisely as a volume form is multilinear and alternating in each of its arguments. Setting $A=B=P$, Axiom I already contains the weight-2 density law $D(P^{\mathsf T}MP)=(\det P)^2D(M)$ of Section 2; but it says strictly more, and that surplus is exactly what makes the determinant unique. (The weight-2 law *by itself* does not pin $D$ down — it leaves room for impostors that depend on the mismatch between the two slots. Axiom I closes that gap.) Axiom II only fixes the overall scale. The usual change-of-basis law is only the *diagonal* case $A=B=P$; why one is entitled to transform the two slots **independently** is taken up in Appendix D.

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

- **Axiom I is not a primitive assumption — it can be derived.** The factors $\det(A),\det(B)$ on its right-hand side are determinants of the *endomorphisms* $A,B:V\to V$, i.e. the ordinary scalar determinant. Taking that as the only primitive and *defining* the tensor determinant functorially, $d(T):=\bigwedge^{n}\phi_T$, turns Axiom I into a theorem. This is carried out in the Appendix.

---

## Appendix: Deriving Axiom I from the determinant of endomorphisms

Axiom I can be proved rather than assumed, once we grant the **one** genuinely primitive notion: the determinant of an *endomorphism* (a map $V\to V$). We recall it, define the tensor determinant constructively, and then Axiom I drops out of functoriality.

**A.1 The primitive: determinant of an endomorphism.** The top exterior power $\bigwedge^{n}V$ is *one*-dimensional. Any endomorphism $g:V\to V$ induces a linear map $\bigwedge^{n}g:\bigwedge^{n}V\to\bigwedge^{n}V$, which — being a linear map of a line to itself — is multiplication by a scalar. *Define* that scalar to be $\det(g)$:
$$
\textstyle\bigwedge^{n}g=\det(g)\cdot\mathrm{id}_{\bigwedge^{n}V}.
$$
Concretely, expanding multilinearly and using antisymmetry of $\wedge$,
$$
g(e_1)\wedge\cdots\wedge g(e_n)=\Big(\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_i g^{\,i}{}_{\sigma(i)}\Big)\,e_1\wedge\cdots\wedge e_n,
$$
so this scalar is the usual Leibniz determinant of the matrix of $g$. Two properties are immediate from the fact that $\bigwedge^{n}$ is a **functor** (it respects composition and identities):
$$
\det(g\circ h)=\det(g)\det(h),\qquad \det(\mathrm{id})=1.
$$
This is the only determinant we take for granted — the ordinary scalar one, for maps of a space to *itself*.

**A.2 The construction: tensor determinant via the top exterior power.** A $(0,2)$ tensor $T$ is the same data as the linear "lowering" map
$$
\phi_T:V\to V^{*},\qquad \phi_T(v):=T(v,\cdot).
$$
Applying the functor $\bigwedge^{n}$ to it gives a map between the two *lines* $\bigwedge^{n}V$ and $\bigwedge^{n}V^{*}$:
$$
d(T):=\textstyle\bigwedge^{n}\phi_T:\ \bigwedge^{n}V\longrightarrow\bigwedge^{n}V^{*}.
$$
In the bases $e_1\wedge\cdots\wedge e_n$ and $e^1\wedge\cdots\wedge e^n$, the matrix of $\phi_T$ is $M^{\mathsf T}$, so $d(T)$ is multiplication by $\det(M^{\mathsf T})=\det(M)$ — it is exactly $\det(T_{ij})$, now seen as the canonical element of the weight-2 density line $\operatorname{Hom}\!\big(\bigwedge^{n}V,\bigwedge^{n}V^{*}\big)$.

**A.3 Deriving Axiom I.** Compute the lowering map of $T_{A,B}$. For any $v,w$,
$$
\phi_{T_{A,B}}(v)(w)=T_{A,B}(v,w)=T(Av,Bw)=\phi_T(Av)(Bw)=\big(B^{*}\phi_T(Av)\big)(w),
$$
where $B^{*}:V^{*}\to V^{*}$ is the dual map, $(B^{*}\xi)(w):=\xi(Bw)$. Hence, as maps $V\to V^{*}$,
$$
\phi_{T_{A,B}}=B^{*}\circ\phi_T\circ A .
$$
Apply the functor $\bigwedge^{n}$ and use $\bigwedge^{n}(g\circ h)=\bigwedge^{n}g\circ\bigwedge^{n}h$ together with A.1 (noting $\det(B^{*})=\det(B)$, since the matrix of $B^{*}$ is $B^{\mathsf T}$):
$$
d(T_{A,B})=\textstyle\bigwedge^{n}\phi_{T_{A,B}}
=\bigwedge^{n}B^{*}\circ\bigwedge^{n}\phi_T\circ\bigwedge^{n}A
=\det(B)\,\det(A)\;\bigwedge^{n}\phi_T
=\det(A)\det(B)\,d(T).
$$
This **is** Axiom I. $\qquad\blacksquare$

So the two-slot law is a consequence of a single fact — that the determinant of an endomorphism is its action on the top exterior power — propagated through the functoriality of $\bigwedge^{n}$. Nothing about $(0,2)$ tensors had to be assumed beyond the definition $d(T)=\bigwedge^{n}\phi_T$.

**Remark (an equivalent, purely matrix-level answer).** If one prefers to avoid exterior algebra, Axiom I is also equivalent — given $D(I)=1$ — to the classical characterization of $\det$ as *the unique function that is multilinear and alternating in the columns* (or rows) of $M$. From that characterization $D=\det$, and then $D(A^{\mathsf T}MB)=\det(A)\det(B)D(M)$ follows from multiplicativity. Either way, Axiom I is not an independent leap: it is equivalent to the standard determinant axioms and provable from them.

---

## Appendix B: An alternative axiom set — multiplicativity and homogeneity

Axiom I can also be replaced by the more familiar pair (here $K=\mathbb{C}$, and $D\not\equiv0$):

- **(M) Multiplicativity.** $D(MN)=D(M)\,D(N)$ for all $M,N$.
- **(H) Homogeneity.** $D(\lambda M)=\lambda^{n}D(M)$ for all $\lambda\in\mathbb{C}$.

**Step 1 — multiplicativity alone gives $D=g\circ\det$.** On $GL(n,\mathbb{C})$ the map $D$ takes values in $\mathbb{C}^{*}$ — if $D$ vanished at one invertible $M_0$, then $D(I)=D(M_0)D(M_0^{-1})=0$ and hence $D\equiv0$ — so $D:GL(n,\mathbb{C})\to\mathbb{C}^{*}$ is a group homomorphism. The factorization theorem of [Determinant From Homomorphism](determinant_homomorphism.md) then yields
$$
D(M)=g(\det M)\qquad\text{on }GL(n,\mathbb{C}),
$$
for some homomorphism $g:\mathbb{C}^{*}\to\mathbb{C}^{*}$. (There $\det$ is the Leibniz polynomial, proved single-valued and multiplicative on $GL(n,\mathbb{C})$.) Thus multiplicativity *by itself* already determines $D$ up to the single character $g$.

**Step 2 — homogeneity fixes $g=\mathrm{id}$.** Apply (H) at $M=I$: on one hand $D(\lambda I)=\lambda^{n}D(I)=\lambda^{n}$, on the other $D(\lambda I)=g(\det(\lambda I))=g(\lambda^{n})$. Hence
$$
g(\lambda^{n})=\lambda^{n}\qquad\text{for all }\lambda\in\mathbb{C}^{*}.
$$
Because $\mathbb{C}$ is algebraically closed, every $t\in\mathbb{C}^{*}$ is an $n$-th power, so $g(t)=t$ for all $t$: $g=\mathrm{id}$ and $D=\det$ on $GL(n,\mathbb{C})$.

**Step 3 — singular matrices.** If $\det M=0$, column-reduce: choose invertible $Q$ so that $MQ$ has a zero column, say the last. Then $\Lambda_\mu:=\operatorname{diag}(1,\dots,1,\mu)$ satisfies $MQ\,\Lambda_\mu=MQ$, so $D(MQ)=D(MQ)\,D(\Lambda_\mu)=D(MQ)\,\mu$. Taking $\mu\neq1$ forces $D(MQ)=0$, hence $D(M)=D(MQ)\,D(Q^{-1})=0=\det M$. So $D=\det$ everywhere. $\qquad\blacksquare$

**Two caveats — and why this set is less natural than Axiom I.**

- **The same even-$n$ subtlety over $\mathbb{R}$.** Over $\mathbb{R}$, Step 2 only gives $g(t)=t$ on the $n$-th powers $(\mathbb{R}^{*})^{n}$. For $n$ *odd* that is all of $\mathbb{R}^{*}$, so $D=\det$. For $n$ *even* it is only $\mathbb{R}_{>0}$, leaving $g(-1)\in\{\pm1\}$ free: $g=\mathrm{id}$ gives $\det$, while $g(t)=|t|$ gives the impostor $D=|\det|$ — genuinely multiplicative and homogeneous of even degree. One extra sign normalization (e.g. $D(\operatorname{diag}(-1,1,\dots,1))=-1$) removes it. This is the very same $|\det|$ ambiguity met in Sections 7.5 of the companion document.

- **Multiplicativity is a *consequence*, not a more primitive axiom.** For a $(0,2)$ tensor the product $MN$ of two Gram matrices is **not** a tensorial operation: under a change of basis $M\mapsto P^{\mathsf T}MP$, $N\mapsto P^{\mathsf T}NP$, the product transforms as $MN\mapsto P^{\mathsf T}M(PP^{\mathsf T})NP\neq P^{\mathsf T}(MN)P$ unless $P$ is orthogonal. So (M) silently invokes the endomorphism structure, whereas the two-slot law $D(A^{\mathsf T}MB)=\det(A)\det(B)D(M)$ is basis-natural. Indeed (M) *follows* from our result: once $D=\det$ (Sections 4–5), $D(MN)=\det(MN)=\det(M)\det(N)$, the multiplicativity of the Leibniz polynomial. So the answer to "can we prove $D(MN)=D(M)D(N)$?" is **yes — it is a theorem for every $D$ satisfying the axioms of Section 4**; one may instead *assume* it (with (H)) as a starting point, at the price of the field caveat and a less tensor-native hypothesis.


---

## Appendix C: Deriving Axiom I from relative invariance

Axiom I prescribes the *exact* multiplier $\det(A)\det(B)$. We now assume far less — only that *some* multiplier works — and **derive** that it must be the determinants. This is the most tensor-native route: it asks merely that $D$ be a *relative invariant* of the natural symmetry group, with the character left completely unspecified.

**The bare hypothesis (relative invariance).** Say $D$ (with $D\not\equiv0$) is a **relative invariant** of the two-slot action if there is *some* function $\chi:GL(V)\times GL(V)\to K^{*}$ with
$$
D(A^{\mathsf T}MB)=\chi(A,B)\,D(M)\qquad\text{for all }A,B\in GL(V)\text{ and all }M.
$$
Nothing about $\chi$ is presupposed — this is just the statement that the symmetry group rescales $D$ by a scalar, the defining property of a density / relative invariant.

**Step 1 — the character separates and is multiplicative.** Put $\alpha(A):=\chi(A,I)$ and $\beta(B):=\chi(I,B)$. Writing $A^{\mathsf T}MB=A^{\mathsf T}(MB)$ and applying the hypothesis one slot at a time,
$$
D(A^{\mathsf T}MB)=\alpha(A)\,D(MB)=\alpha(A)\beta(B)\,D(M),\qquad\text{so}\qquad \chi(A,B)=\alpha(A)\,\beta(B).
$$
Moreover $\alpha$ is a homomorphism: from $(A_1A_2)^{\mathsf T}=A_2^{\mathsf T}A_1^{\mathsf T}$,
$$
\alpha(A_1A_2)\,D(M)=D\!\big(A_2^{\mathsf T}A_1^{\mathsf T}M\big)=\alpha(A_2)\alpha(A_1)\,D(M),
$$
so $\alpha(A_1A_2)=\alpha(A_1)\alpha(A_2)$; likewise $\beta$. Thus $\alpha,\beta:GL(V)\to K^{*}$ are multiplicative characters.

**Step 2 — every character of $GL$ factors through $\det$.** By the factorization theorem of [Determinant From Homomorphism](determinant_homomorphism.md) (taking $K=\mathbb{C}$), $\alpha=g_1\circ\det$ and $\beta=g_2\circ\det$ for homomorphisms $g_1,g_2:\mathbb{C}^{*}\to\mathbb{C}^{*}$. Hence the multiplier is *forced* to be built from the two determinants:
$$
\chi(A,B)=g_1(\det A)\,g_2(\det B).
$$
This is the whole point: relative invariance alone already says the factor can only depend on $A,B$ through $\det A$ and $\det B$.

**Step 3 — reach $M$ from $I$, and $g_1=g_2$.** For invertible $M$, normalize $D(I)=1$ and compute $D(M)$ two ways. Through the second slot, $M=I^{\mathsf T}\,I\,M$ gives $D(M)=\beta(M)=g_2(\det M)$; through the first slot, $M=(M^{\mathsf T})^{\mathsf T}\,I$ gives $D(M)=\alpha(M^{\mathsf T})=g_1(\det M)$. Equating, $g_1=g_2=:g$, and
$$
D(M)=g(\det M)\qquad\text{on }GL(V).
$$

**Step 4 — homogeneity fixes $g=\mathrm{id}$.** Assume $D$ is homogeneous of degree $n$ (the only natural choice: $\det$ of an $n\times n$ matrix has degree $n$). Then $D(\lambda I)=\lambda^{n}=g(\lambda^{n})$ for all $\lambda$, and since every element of $\mathbb{C}^{*}$ is an $n$-th power, $g=\mathrm{id}$. Therefore
$$
\chi(A,B)=\det(A)\,\det(B),\qquad D(M)=\det(M)\ \text{ on }GL(V),
$$
which is exactly Axiom I, now *derived*. The degenerate case $D=0=\det$ follows as in Section 5 (or Appendix B, Step 3). $\qquad\blacksquare$

**Why the group must be the full two-slot $GL\times GL$ — not just change of basis.** It is tempting to apply the same idea to the genuine basis-change group, i.e. *congruence* $A=B=P$, asking only that $D(P^{\mathsf T}MP)=\chi(P)\,D(M)$. The homomorphism theorem again gives $\chi(P)=g(\det P)$ — with degree $n$ this is the **weight-2 density law** $D(P^{\mathsf T}MP)=(\det P)^{2}D(M)$. But congruence does **not** act transitively on the invertible matrices, so Step 3 collapses and $D$ is *not* determined: the cosquare impostors of the companion document,
$$
D(M)=\det(M)\,\exp\!\big(\operatorname{tr}\,\beta(S+S^{-1})\big),\qquad S=M^{-\mathsf T}M,
$$
are genuine weight-2 relative invariants of congruence ($D(P^{\mathsf T}MP)=(\det P)^2D(M)$ holds exactly) yet differ from $\det$. They are *not* relative invariants of the two-slot action — the ratio $D(A^{\mathsf T}MB)/D(M)$ depends on $M$ when $A\neq B$ — which is precisely why enlarging congruence to the full two-slot group rescues the derivation. In the language of prehomogeneous vector spaces, $\big(GL(V)\times GL(V),\ \mathrm{Mat}_n,\ M\mapsto A^{\mathsf T}MB\big)$ has a dense orbit (the invertible matrices), and its relative invariants form the free group generated by a single irreducible one — the determinant. Relative invariance therefore *characterizes* $\det$, provided it is imposed for the two independent slots that the tensor $T\in V^{*}\otimes V^{*}$ actually has.

---

## Appendix D: Deriving the relative-invariance equation from covariance in each slot

The equation
$$
D(A^{\mathsf T}MB)=\chi(A,B)\,D(M)
$$
is a pure *rescaling* (covariance) statement: it says the two-slot operation multiplies $D$ by a number independent of $M$. It contains no antisymmetry. So it ought to be derived from a covariance hypothesis — not by writing down the antisymmetric determinant and verifying, which only confirms it for the one function we already suspected. Here is a derivation whose single ingredient is relative invariance itself, imposed one slot at a time.

**The primitive: $D$ is a relative scalar in each slot.** A $(0,2)$ tensor has two independent arguments — it is bilinear. Recombining the **first** argument by an invertible $A$, i.e. replacing $T(v,w)$ by $T(Av,w)$, changes the components by
$$
M_{ij}\ \longmapsto\ T(Ae_i,e_j)=A_{ki}M_{kj}=(A^{\mathsf T}M)_{ij},
$$
and recombining the **second** argument by $B$, i.e. $T(v,w)\mapsto T(v,Bw)$, gives $M\mapsto MB$. Each of these is a change of basis *within one slot*. The defining property of a density (a relative scalar) attached to the tensor is that such a change of basis rescales it by a factor that depends only on the change, not on the tensor:
$$
D(A^{\mathsf T}M)=\alpha(A)\,D(M),\qquad D(MB)=\beta(B)\,D(M). \tag{$\dagger$}
$$
This is the natural covariance assumption. It mentions no antisymmetry and builds nothing; it is the same *kind* of statement as "a weight-$w$ density transforms by $(\det P)^{w}$", written before the factor is known. (It is also genuinely non-trivial: setting $M=I$ already gives $D(A^{\mathsf T})=\alpha(A^{\mathsf T})\,D(I)$, so $D$ on invertible matrices is essentially the factor itself — relative invariance in even one slot is nearly as strong as being the determinant. That strength is unavoidable, by Appendix C; what we *can* choose is to assume it as a clean covariance law rather than to construct it.)

**Two-slot invariance is the product of the two.** The first- and second-slot operations are independent and commute, $A^{\mathsf T}(MB)=(A^{\mathsf T}M)B$, so applying both and using ($\dagger$) twice,
$$
D(A^{\mathsf T}MB)=D\big(A^{\mathsf T}(MB)\big)=\alpha(A)\,D(MB)=\alpha(A)\,\beta(B)\,D(M).
$$
Hence
$$
\boxed{\,D(A^{\mathsf T}MB)=\chi(A,B)\,D(M),\qquad \chi(A,B):=\alpha(A)\,\beta(B)\,,}
$$
with $\chi$ manifestly independent of $M$. The two-slot equation is nothing but per-slot covariance imposed in each of the two arguments — no antisymmetric contraction anywhere, as befits an equation that is not antisymmetric in anything.

**The factors are automatically multiplicative.** Composition within one slot forces $\alpha$ and $\beta$ to be characters. Recombining the first argument by $A_1$ and then by $A_2$ is recombining it by $A_2A_1$; since $(A_2A_1)^{\mathsf T}M=A_1^{\mathsf T}(A_2^{\mathsf T}M)$,
$$
\alpha(A_2A_1)\,D(M)=D\big(A_1^{\mathsf T}(A_2^{\mathsf T}M)\big)=\alpha(A_1)\,\alpha(A_2)\,D(M),
$$
so $\alpha(A_1A_2)=\alpha(A_1)\alpha(A_2)$, and likewise $\beta(B_1B_2)=\beta(B_1)\beta(B_2)$. Thus $\alpha,\beta:GL(V)\to K^{*}$ are multiplicative characters — a derived consequence, not an assumption.

**What remains.** We now have the relative-invariance equation with $\chi=\alpha\beta$ and $\alpha,\beta$ characters, obtained from covariance alone. Appendix C finishes the job: the homomorphism theorem forces $\alpha=g\circ\det$ and $\beta=g\circ\det$, and homogeneity fixes $g=\operatorname{id}$, giving $\chi(A,B)=\det(A)\det(B)$ and $D=\det$. The determinant is therefore the value of the factor, never an input.

**Why per-slot, and not change of basis.** Imposing ($\dagger$) in each slot treats the two arguments independently, $A$ and $B$ unrelated — legitimate precisely because $T$ is bilinear. An honest change of basis of the single space $V$ ties the slots together, $A=B=P$, and yields only $D(P^{\mathsf T}MP)=\alpha(P)\beta(P)D(M)$ — the weight law of Section 2. That diagonal case is strictly weaker and does **not** give back ($\dagger$): the cosquare impostors of Appendix C obey it yet fail to be relatively invariant slot by slot. All the force is in allowing $A\neq B$, i.e. in reading the bilinearity of $T$ as covariance in each argument on its own.
