# Lie

Your guess is exactly right, and it's worth seeing why. Let me explain it the way a physicist would build it, using the groups you already know. (Your `determinant_over_C.md` already contains this material in Part III and the "Lie-theoretic picture" chapter — what follows is the physics translation of it.)

## 1. $E_{ij}$ is a generator; $T_{ij}(c)$ is the finite transformation it generates

You know the pattern from the Lorentz group: a finite transformation is the exponential of a generator, $\Lambda = e^{\zeta K}$. The same here. Take the generator $E_{ij}$ ($i\neq j$). It's **nilpotent**: $E_{ij}^2 = 0$. So the exponential series terminates after two terms:

$$\exp(c\,E_{ij}) = I + c\,E_{ij} = T_{ij}(c).$$

A transvection is *literally* the exponential of the generator $E_{ij}$ — nothing fancier. And you already know a transvection from physics: a **Galilean boost**. Acting on $(x,t)$,

$$\begin{pmatrix}1 & v\\ 0 & 1\end{pmatrix}\begin{pmatrix}x\\ t\end{pmatrix} = \begin{pmatrix}x+vt\\ t\end{pmatrix},$$

which is $T_{12}(v) = \exp(v E_{12})$. The composition law $T_{ij}(c)T_{ij}(c') = T_{ij}(c+c')$ used in Step 2 of the note is just "boost velocities add" — the statement that $c \mapsto e^{cE_{ij}}$ is a one-parameter subgroup. Even the conjugation formula $D\,T_{ij}(c)\,D^{-1} = T_{ij}(c\,d_i/d_j)$ is the adjoint action you know from "a boost conjugated by a rotation is a boost in the rotated direction": here a boost conjugated by a scaling is a boost with rescaled velocity.

So the dictionary you suspected is exact:

| group level                                | algebra level                                                   |
| ------------------------------------------ | --------------------------------------------------------------- |
| $T_{ij}(c)$, $\;\det$, $\;GL(n,\mathbb C)$ | $E_{ij}$, $\;\operatorname{tr}$, $\;\mathfrak{gl}(n,\mathbb C)$ |

## 2. The trace is the generator of the determinant

A multiplicative $f: GL(n,\mathbb C)\to\mathbb C^*$ is, in physics language, a **one-dimensional representation** — it assigns each transformation a complex number (a "charge"/amplitude) that composes correctly, $f(AB)=f(A)f(B)$. Like any representation, it's determined near the identity by its generator: expand

$$f(I + \varepsilon X) = 1 + \varepsilon\,\phi(X) + O(\varepsilon^2),$$

where $\phi:\mathfrak{gl}(n)\to\mathbb C$ is linear. For $f=\det$ you know this expansion by heart:

$$\det(I + \varepsilon X) = 1 + \varepsilon \operatorname{tr}X + O(\varepsilon^2),$$

i.e. **the generator of $\det$ is $\operatorname{tr}$**. "Integrating" along a one-parameter flow gives the identity you use in one-loop effective actions and fermion determinants:

$$\det(e^X) = e^{\operatorname{tr}X} \qquad (\text{``}\log\det = \operatorname{Tr}\log\text{''}).$$

Why does $e^X$ appear inside the determinant? Because the expansion $\det(I+\varepsilon X)=1+\varepsilon\operatorname{tr}X+O(\varepsilon^2)$ is a statement only about matrices *infinitesimally* close to $I$. To learn anything about a finite matrix, build one out of infinitesimal pieces — and the matrix obtained by composing the *same* infinitesimal step $I+\frac{X}{N}$ over and over is, by definition, the exponential:

$$e^{X}=\lim_{N\to\infty}\Big(I+\tfrac{X}{N}\Big)^{N}$$

(matrix compound interest; a finite rotation built from $N$ tiny rotations). So $e^X$ is the unique finite transformation reached by flowing for unit time with constant generator $X$. Now apply $\det$ and let each hypothesis do its one job:

$$\det(e^X)=\lim_{N\to\infty}\det\Big(I+\tfrac{X}{N}\Big)^{N}
=\lim_{N\to\infty}\Big(1+\tfrac{\operatorname{tr}X}{N}+O(\tfrac{1}{N^{2}})\Big)^{N}
=e^{\operatorname{tr}X}.$$

The first equality is multiplicativity ($\det$ of a product of $N$ slices is the product of $N$ numbers), the second is the trace expansion applied to each slice with $\varepsilon=1/N$; the $O(1/N^2)$ error per slice totals $O(1/N)$ and vanishes in the limit. This is the same time-slicing mechanism as in a path integral.

The same computation as a differential equation: let $u(t):=\det(e^{tX})$. Since $tX$ and $\varepsilon X$ commute (multiples of the *same* $X$ — no Baker–Campbell–Hausdorff needed), $e^{(t+\varepsilon)X}=e^{\varepsilon X}e^{tX}$, so
$$u(t+\varepsilon)=\det(e^{\varepsilon X})\,u(t)=\big(1+\varepsilon\operatorname{tr}X+O(\varepsilon^2)\big)\,u(t)
\quad\Longrightarrow\quad \dot u=(\operatorname{tr}X)\,u,\quad u(0)=1,$$
whose solution is $u(t)=e^{t\operatorname{tr}X}$; setting $t=1$ gives the boxed identity. Physically this is **Liouville's formula**: the linear flow $\dot x=Xx$ has flow map $e^{tX}$, the determinant of the flow map is the volume-expansion factor of a comoving blob, and $\operatorname{tr}X=\partial_i(Xx)_i=\nabla\cdot v$ is the divergence of the velocity field — "volume grows at rate $\nabla\cdot v$" integrates to $e^{t\operatorname{tr}X}$. The determinant is the finite-time volume factor; the trace is its instantaneous rate.

That's the precise sense in which "det is the integrated trace."

## 3. Why trace is the *only* possible generator

Here's the structural heart, and it's a one-line physics argument. The target $\mathbb C^*$ is **abelian**. An abelian charge cannot see commutators: $f(ABA^{-1}B^{-1}) = f(A)f(B)f(A)^{-1}f(B)^{-1} = 1$. Infinitesimally that says

$$\phi([X,Y]) = 0 \quad\text{for all } X, Y.$$

Now ask: which matrices are commutators? Cyclicity of trace gives $\operatorname{tr}[X,Y]=0$, so commutators are traceless. The converse also holds, and your $E_{ij}$ are exactly the witnesses:

$$E_{ij} = [E_{ii}, E_{ij}]\;(i\neq j), \qquad E_{ii}-E_{jj} = [E_{ij}, E_{ji}],$$

and these span *all* traceless matrices. So $[\mathfrak{gl}_n,\mathfrak{gl}_n] = \mathfrak{sl}_n$ exactly, and $\phi$ must vanish on every traceless matrix. A linear functional that kills the traceless part can only depend on the trace:

$$\phi(X) = a\operatorname{tr}X.$$

The normalization $f(\lambda I)=\lambda^n$ then forces $a=1$. (Over $\mathbb C$ viewed as a real manifold there's also a $b\,\overline{\operatorname{tr}X}$ term — the anti-holomorphic branch whose integrated form is $\overline{\det}$; homogeneity kills it too. This is the Lie-side shadow of the free homomorphism $g$ in your factorization theorem.)

Compare with the groups you know: for $SU(2)$ or the Lorentz group, *every* generator is itself a commutator ($[J_i,J_j]=\epsilon_{ijk}J_k$...), the algebra is "all commutator," and so there is **no** nontrivial det-like function on them — their only 1-dim rep is trivial. $GL(n)$ is special precisely because $\mathfrak{gl}_n = \mathfrak{sl}_n \oplus \mathbb C\cdot I$ has exactly **one abelian direction** — overall scaling, measured by the trace. The determinant exists because of, and only because of, that one direction.

## 4. Integrating back up: from $\phi(X)=a\operatorname{tr}X$ to $f=g\circ L$, step by step

We now reconstruct $f$ on the whole group from its generator, constructively, assuming nothing about determinants. What we have in hand:

* (H1) $f(AB)=f(A)f(B)$, with $f$ smooth;
* the **flow formula**: $f(e^{X})=e^{\phi(X)}$ — proved by the same ODE argument as in section 2, verbatim, with $\phi$ in place of $\operatorname{tr}$: $u(t)=f(e^{tX})$ satisfies $\dot u=\phi(X)\,u$, $u(0)=1$;
* section 3's result: $\phi(X)=a\operatorname{tr}X+b\,\overline{\operatorname{tr}X}$ for some constants $a,b\in\mathbb C$.

The plan is what a physicist would do anyway: evaluate $f$ on the finite transformations whose generators we control (transvections and diagonals), reach *every* $A$ by composing those, and finally construct one explicit single-valued function of $A$ — the totally antisymmetric singlet — that ties the answer back to the entries of $A$. The Leibniz formula will be *derived* in that last step, as a matrix element.

### 4.1 $f$ on transvections: automatically $1$

The off-diagonal generators are traceless, $\operatorname{tr}E_{ij}=0$ for $i\neq j$, so the flow formula gives

$$f\big(T_{ij}(c)\big)=f\big(e^{cE_{ij}}\big)=e^{\phi(cE_{ij})}=e^{a\cdot 0+b\cdot\bar 0}=1.$$

Step 2 of the elementary notes falls out in one line: an abelian charge cannot register a traceless (boost-like) generator. By (H1), multiplying by transvections never changes $f$.

### 4.2 $f$ on diagonal matrices: the homomorphism $g$ appears, quantized

Every $d_k\in\mathbb C^*$ is an exponential: pick logs $z_k$ with $d_k=e^{z_k}$ (any branch). Then $\operatorname{diag}(d_1,\dots,d_n)=\exp\big(\operatorname{diag}(z_1,\dots,z_n)\big)$, and since $\operatorname{tr}\operatorname{diag}(z)=\sum_k z_k$, the flow formula gives

$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\exp\Big(a\sum_k z_k+b\,\overline{\textstyle\sum_k z_k}\Big).$$

Now a consistency check with physical content. The left side is one fixed number; it cannot depend on which branches of $\log$ we chose. Shift any single $z_k\to z_k+2\pi i$: the right side picks up the factor $e^{2\pi i(a-b)}$. Single-valuedness therefore **forces the quantization**

$$a-b=:k\in\mathbb Z$$

— the same mechanism that quantizes angular momentum ($e^{ik\varphi}$ must be single-valued on the circle). Given this, the recipe

$$g(w):=e^{a\log w+b\,\overline{\log w}}=|w|^{\,a+b}\Big(\frac{w}{|w|}\Big)^{a-b},\qquad s:=a+b\in\mathbb C,\quad k:=a-b\in\mathbb Z,$$

does not depend on the branch of $\log w$ (a branch shift changes the exponent by $2\pi i m(a-b)\in 2\pi i\,\mathbb Z$), and $g$ is a continuous homomorphism $\mathbb C^*\to\mathbb C^*$ — precisely the family $|w|^s(w/|w|)^k$ derived independently in `cstar_homomorphism.md`, now reconstructed from the two real-linear components of $\phi$. Since $\sum_k z_k$ is a log of the product $d_1\cdots d_n$, the display above says exactly

$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=g\big(d_1 d_2\cdots d_n\big).$$

This is Step 3 of the elementary notes: the trace doesn't care which diagonal slot a number sits in, so $f$ sees only the product.

### 4.3 Reaching every $A$: Gauss factorization

So far $f$ is known on transvections and on diagonals. Plain row reduction (the Lemma of `determinant_homomorphism.md` — no determinants, just "add a multiple of one row to another" and the invertibility of $A$) factors **every** invertible matrix as

$$A=E\,D,\qquad E=\text{product of transvections},\quad D=\operatorname{diag}(d_1,\dots,d_n),$$

so by (H1), 4.1 and 4.2,

$$f(A)=f(E)\,f(D)=g\big(d_1\cdots d_n\big).$$

Almost done — but not yet a formula in $A$: the pivot product $d_1\cdots d_n$ was read off a *chosen* factorization, and a priori a different row reduction could give a different product. We need one explicit, single-valued function of $A$ alone that equals it. We build that function next, and it is here that Leibniz emerges.

### 4.4 The antisymmetric singlet: Leibniz derived, not assumed

We want an explicitly constructed function whose generator is $\operatorname{tr}$ — "an integral of the trace" that manifestly depends only on $A$. The physicist's candidate is the $\varepsilon$-tensor. In $n$ dimensions, a totally antisymmetric object with $n$ indices has exactly **one** independent component: $\psi_{i_1\cdots i_n}=c\,\varepsilon_{i_1\cdots i_n}$. Equivalently, the wedge $e_1\wedge\cdots\wedge e_n$ spans a one-dimensional space (the "singlet"). Let $A$ act on every slot. The result is again totally antisymmetric, hence a multiple of the singlet, and that multiple is a number we *define* as $L(A)$:

$$(Ae_1)\wedge(Ae_2)\wedge\cdots\wedge(Ae_n)=:L(A)\;e_1\wedge\cdots\wedge e_n.$$

Now just expand in components, $Ae_k=\sum_j A_{jk}\,e_j$, using multilinearity of the wedge:

$$(Ae_1)\wedge\cdots\wedge(Ae_n)=\sum_{j_1,\dots,j_n}A_{j_1 1}\cdots A_{j_n n}\;e_{j_1}\wedge\cdots\wedge e_{j_n}.$$

A wedge with a repeated vector vanishes by antisymmetry, so only tuples $(j_1,\dots,j_n)$ that are permutations $\sigma$ of $(1,\dots,n)$ survive, and reordering costs the parity sign: $e_{\sigma(1)}\wedge\cdots\wedge e_{\sigma(n)}=\operatorname{sgn}(\sigma)\,e_1\wedge\cdots\wedge e_n$. Hence

$$L(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{\sigma(k),k}
=\varepsilon^{\,j_1\cdots j_n}A_{j_1 1}\cdots A_{j_n n}.$$

**This is the Leibniz formula — derived, not posited**: it is nothing but the single matrix element of $A$ acting on the one-dimensional antisymmetric singlet. (The row form $\sum_\sigma\operatorname{sgn}(\sigma)\prod_k A_{k,\sigma(k)}$ is the same sum under $\sigma\mapsto\sigma^{-1}$, which preserves the sign.) Its properties now cost one line each, with no determinant theory anywhere:

* **Multiplicative.** Slot-wise action of $B$ maps the singlet line to itself with scalar $L(B)$; following with $A$ multiplies by $L(A)$; the composite is the slot-wise action of $AB$. Scalars on a line compose by multiplication: $L(AB)=L(A)L(B)$.
* **Diagonals.** $\operatorname{diag}(d)\,e_k=d_k e_k$, so each slot contributes its factor: $L\big(\operatorname{diag}(d)\big)=d_1\cdots d_n$.
* **Transvections.** $T_{ij}(c)$ fixes every $e_k$ except $e_j\mapsto e_j+c\,e_i$; the extra term inserts a *second* copy of $e_i$ into the wedge and is killed by antisymmetry: $L\big(T_{ij}(c)\big)=1$.
* **Generator.** Expanding each slot of $(I+\varepsilon X)e_1\wedge\cdots\wedge(I+\varepsilon X)e_n$ to first order, the slot-$k$ term $Xe_k=\sum_j X_{jk}e_j$ survives the wedge only for $j=k$ (all other basis vectors are already present), so $L(I+\varepsilon X)=1+\varepsilon\sum_k X_{kk}+O(\varepsilon^2)=1+\varepsilon\operatorname{tr}X$. So $L$ **is** an integral of the trace — the explicit polynomial with $dL_I=\operatorname{tr}$, and by the flow argument $L(e^X)=e^{\operatorname{tr}X}$.

### 4.5 Assembly: $f=g\circ L$

Feed any Gauss factorization $A=ED$ to $L$ and peel with the one-line properties:

$$L(A)=L(E)\,L(D)=1\cdot d_1\cdots d_n.$$

The left side is one unambiguous polynomial in the entries of $A$ — so *every* factorization yields the same pivot product, and that product equals $L(A)$. Substituting into 4.3:

$$\boxed{\,f(A)=g\big(L(A)\big),\qquad L(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{k,\sigma(k)}.\,}$$

Every ingredient was constructed, none assumed: $a,b$ came from differentiating $f$; the quantization $a-b\in\mathbb Z$ from single-valuedness on the diagonal torus; $g$ was built from $(a,b)$; $L$ was built as the antisymmetric singlet; and the equality used only row reduction and multiplicativity. Finally, imposing homogeneity $f(\lambda I)=\lambda^n$: with $\lambda=e^z$, the flow formula gives $f(\lambda I)=e^{n(az+b\bar z)}\overset{!}{=}e^{nz}$ for all $z$, forcing $a=1,\ b=0$, i.e. $g=\mathrm{id}$ and

$$f=L=\det.$$

(Aside: the eigenvalue formula $f(A)=\prod_i\lambda_i(A)$ of Part III, Step 5 in `determinant_over_C.md` expresses the same thing, but needs the surjectivity of $\exp$ over $\mathbb C$. The route above trades that analytic input for the algebraic Gauss factorization — the same trade the elementary note makes — and produces the Leibniz formula constructively along the way.)

## 5. How this maps onto the elementary derivation

The derivation in `determinant_homomorphism.md` is **the same argument run at the group level, without ever differentiating** — which is exactly why it needs no continuity assumption:

- **Step 2 ($f=1$ on transvections)** is the global version of "$\phi$ kills the traceless generators." In fact for $n\ge3$ transvections are themselves *group* commutators: the bracket $[E_{ik},E_{kj}]=E_{ij}$ exponentiates to $T_{ik}(a)\,T_{kj}(b)\,T_{ik}(a)^{-1}T_{kj}(b)^{-1}=T_{ij}(ab)$, and an abelian charge can't see commutators. Globally: transvections generate $SL(n,\mathbb C) = [GL,GL]$, the group-level "traceless part" ($\det = 1$), so $f$ is blind to it and can only depend on $A$ modulo $SL$ — i.e. on $\det A$.
- **Step 3 ($f(\operatorname{diag})=g(\prod d_i)$)** is the global version of "$\phi = a\operatorname{tr}$ on the diagonal direction": $\operatorname{diag}(d) = \exp(\operatorname{diag}(\log d))$ and $e^{\sum\log d_i} = \prod d_i$. The free homomorphism $g$ is the global counterpart of the free constant $a$ (with continuity, $g(w)=|w|^s(w/|w|)^k$ corresponds exactly to the $a,b$ pair).
- **The Gauss factorization $A = ED$** is the elementary substitute for "$\exp$ is surjective": both write an arbitrary group element in terms of pieces where $f$ is already pinned down.
- **The Leibniz polynomial $L$** plays the role that $\exp$ and eigenvalues play in the Lie route: the explicit, single-valued object that anchors everything.

One sentence for the road: *the determinant is to the trace what a finite transformation is to its generator; it exists because $GL(n)$ has exactly one abelian direction (overall scaling), every abelian charge must vanish on the boost-like nilpotent generators $E_{ij}$ spanning the rest, and the unique charge normalized by $f(\lambda I)=\lambda^n$ is $\det = \exp\circ\operatorname{tr}\circ\log$.*

Your note's table at "How the two proofs correspond" (`determinant_over_C.md:456`) lists this dictionary line by line. If you'd like, I can add a physics-flavored section like the above (Galilean boost = transvection, "no det for semisimple groups", U(1)-charge language) to one of the notes.
