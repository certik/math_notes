# The determinant as the exponentiated trace

This note explains, in physics language, how the determinant arises from Lie theory: the trace is the generator, the determinant is the finite transformation built from it, and the Leibniz formula is derived at the end as a matrix element — never assumed. It is a companion to the elementary derivation in [determinant_homomorphism.md](determinant_homomorphism.md) (same result, no calculus, no continuity) and to Part III of [determinant_over_C.md](determinant_over_C.md) (same argument in mathematical language); proofs that appear verbatim there are referenced, not repeated.

## 1. The cast of characters: two groups, two algebras, two maps

There are **two** group/algebra pairs in play, and keeping them apart is most of the battle:

|  | source side | target side |
|---|---|---|
| **group** | $G=GL(n,\mathbb C)$: invertible $n\times n$ matrices, under matrix multiplication | $\mathbb C^*=GL(1,\mathbb C)$: nonzero numbers, under multiplication |
| **its Lie algebra** | $\mathfrak{gl}(n,\mathbb C)$ = **all** $n\times n$ matrices (not just invertible!), bracket $[X,Y]=XY-YX$ | $\mathbb C$ = all complex numbers, bracket $\equiv 0$ (abelian) |
| **exp map** | matrix exponential $X\mapsto e^X$ | ordinary $z\mapsto e^z$ |
| **basis ("generators")** | the $n^2$ matrix units $E_{ij}$ | the number $1$ |

Three clarifications, because the words are easy to mix up:

* **$\det$ is not a group; it is a map between groups.** Its *values* fill out the group $\mathbb C^*$, but $\det$ itself is a homomorphism $G\to\mathbb C^*$: it converts matrix multiplication into number multiplication. "One-dimensional representation" means exactly this: each group element $A$ is represented by an invertible $1\times1$ matrix — a nonzero number $f(A)$ — such that composition becomes multiplication, $f(AB)=f(A)f(B)$.
* **The $E_{ij}$ do not *have* a representation; they are *elements*.** They form a basis of the source algebra $\mathfrak{gl}(n,\mathbb C)$, the same way $J_i,K_i$ form a basis of the Lorentz algebra. A representation is a *map* defined on the whole algebra (or group).
* **There are two levels of representation, one per row of the square below.** Group level: $f:G\to\mathbb C^*$ with $f(AB)=f(A)f(B)$. Algebra level: its derivative at the identity, $\phi:=df_I:\mathfrak{gl}(n,\mathbb C)\to\mathbb C$, a linear map satisfying $\phi([X,Y])=[\phi(X),\phi(Y)]=0$ — the bracket on the right lives in the abelian target, hence vanishes. For $f=\det$ the algebra-level map will turn out to be $\phi=\operatorname{tr}$; on the basis: $\phi(E_{ij})=0$ for $i\neq j$, and $\phi(E_{ii})=1$ — each diagonal generator carries one unit of the single available "charge."

Everything in this note is the study of one **commuting square**:

$$
\begin{array}{ccc}
\mathfrak{gl}(n,\mathbb C) & \xrightarrow{\ \ \phi\,=\,\operatorname{tr}\ \ } & \mathbb C \\[4pt]
{\scriptstyle \exp}\Big\downarrow\ \ & & \ \ \Big\downarrow{\scriptstyle \exp} \\[4pt]
GL(n,\mathbb C) & \xrightarrow{\ \ f\,=\,\det\ \ } & \mathbb C^*
\end{array}
\qquad\qquad
f\big(e^{X}\big)=e^{\phi(X)}.
$$

Generators map to generators (top arrow), finite transformations map to finite transformations (bottom arrow), and exponentiation commutes with everything. The model you already know is $U(1)$: group $\{e^{i\theta}\}$, algebra $i\mathbb R$, representations $f_k(e^{i\theta})=e^{ik\theta}$ labeled by an integer charge $k$. The algebra-level map is "multiply by $k$," the group-level map is its exponentiation, and $k$ must be an *integer* for single-valuedness. The determinant is the same story with $G=GL(n,\mathbb C)$: the algebra-level map will be forced to be $a\cdot\operatorname{tr}$, single-valuedness will quantize the charge, and $\det$ is the charge-$1$ representation. The sections below derive every arrow of the square; in particular the bottom arrow (the Leibniz formula) is *constructed* in section 6, not assumed.

## 2. The bottom-left corner: $E_{ij}$ exponentiates to a transvection (a Galilean boost)

The pattern is the one from the Lorentz group: a finite transformation is the exponential of a generator, $\Lambda=e^{\zeta K}$. Take the off-diagonal generator $E_{ij}$ ($i\neq j$). It is **nilpotent**, $E_{ij}^2=0$, so the exponential series terminates after two terms:

$$\exp(c\,E_{ij}) = I + c\,E_{ij} = T_{ij}(c).$$

A transvection is *literally* the exponential of the generator $E_{ij}$ — nothing fancier. And you already know a transvection from physics: a **Galilean boost**. Acting on $(x,t)$,

$$\begin{pmatrix}1 & v\\ 0 & 1\end{pmatrix}\begin{pmatrix}x\\ t\end{pmatrix} = \begin{pmatrix}x+vt\\ t\end{pmatrix},$$

which is $T_{12}(v)=\exp(vE_{12})$. The composition law $T_{ij}(c)T_{ij}(c')=T_{ij}(c+c')$, used in Step 2 of `determinant_homomorphism.md`, is just "boost velocities add" — the statement that $c\mapsto e^{cE_{ij}}$ is a one-parameter subgroup. The conjugation formula $D\,T_{ij}(c)\,D^{-1}=T_{ij}(c\,d_i/d_j)$ is the adjoint action you know from "a boost conjugated by a rotation is a boost in the rotated direction": here a boost conjugated by a scaling is a boost with rescaled velocity.

The diagonal generators exponentiate just as explicitly: $e^{t\,E_{ii}}=\operatorname{diag}(1,\dots,\underset{i}{e^{t}},\dots,1)$, a scaling of one axis. So there are **two families of finite transformations whose generators we fully control** — transvections (nilpotent generators, boost-like) and diagonal matrices (commuting generators, scaling-like) — and they will carry the entire derivation.

## 3. Differentiating the bottom arrow: the generator of $f$, and the flow formula

Given a smooth one-dimensional representation $f$, its generator-level map is defined by expanding near the identity:

$$f(I+\varepsilon X) = 1 + \varepsilon\,\phi(X) + O(\varepsilon^2),$$

with $\phi:\mathfrak{gl}(n,\mathbb C)\to\mathbb C$ linear. For $f=\det$ you know this expansion by heart:

$$\det(I+\varepsilon X) = 1 + \varepsilon\operatorname{tr}X + O(\varepsilon^2),$$

i.e. **the generator of $\det$ is $\operatorname{tr}$** — that is the top arrow of the square evaluated on the known example.

The compatibility $f(e^X)=e^{\phi(X)}$ (the statement that the square commutes) is not an extra assumption; it *follows* from multiplicativity, and the mechanism is worth seeing twice. First as time slicing: the finite transformation built by composing the same infinitesimal step $I+\frac{X}{N}$ over and over is, by definition, the exponential,

$$e^{X}=\lim_{N\to\infty}\Big(I+\tfrac{X}{N}\Big)^{N}$$

(matrix compound interest; a finite rotation from $N$ tiny rotations). Apply $f$ and let each hypothesis do its one job:

$$f(e^X)=\lim_{N\to\infty} f\Big(I+\tfrac{X}{N}\Big)^{N}
=\lim_{N\to\infty}\Big(1+\tfrac{\phi(X)}{N}+O(\tfrac{1}{N^{2}})\Big)^{N}
=e^{\phi(X)}.$$

The first equality is multiplicativity ($f$ of a product of $N$ slices is the product of $N$ numbers), the second is the defining expansion of $\phi$ applied to each slice with $\varepsilon=1/N$; the $O(1/N^2)$ error per slice totals $O(1/N)$ and vanishes. Same mechanism as time-slicing a path integral.

Second, as a differential equation: let $u(t):=f(e^{tX})$. Since $tX$ and $\varepsilon X$ commute (multiples of the *same* $X$ — no Baker–Campbell–Hausdorff needed), $e^{(t+\varepsilon)X}=e^{\varepsilon X}e^{tX}$, so

$$u(t+\varepsilon)=f(e^{\varepsilon X})\,u(t)=\big(1+\varepsilon\,\phi(X)+O(\varepsilon^2)\big)\,u(t)
\quad\Longrightarrow\quad \dot u=\phi(X)\,u,\quad u(0)=1,$$

whose solution is $u(t)=e^{t\phi(X)}$. We call this the **flow formula**:

$$f\big(e^{tX}\big)=e^{t\,\phi(X)}.$$

For $f=\det$, $\phi=\operatorname{tr}$, it is the identity used in one-loop effective actions and fermion determinants, $\det(e^X)=e^{\operatorname{tr}X}$, "$\log\det=\operatorname{Tr}\log$". Physically it is **Liouville's formula**: the linear flow $\dot x=Xx$ has flow map $e^{tX}$, the determinant of the flow map is the volume-expansion factor of a comoving blob, and $\operatorname{tr}X=\partial_i(Xx)_i=\nabla\cdot v$ is the divergence of the velocity field — "volume grows at rate $\nabla\cdot v$" integrates to $e^{t\operatorname{tr}X}$. The determinant is the finite-time volume factor; the trace is its instantaneous rate.

## 4. The top arrow is forced: $\phi = a\operatorname{tr} + b\,\overline{\operatorname{tr}}$

Here is the structural heart, and it is a one-line physics argument. The target $\mathbb C^*$ is **abelian**. An abelian charge cannot see commutators: $f(ABA^{-1}B^{-1})=f(A)f(B)f(A)^{-1}f(B)^{-1}=1$. Infinitesimally,

$$\phi([X,Y])=0\qquad\text{for all }X,Y.$$

Which matrices are commutators? Cyclicity of the trace gives $\operatorname{tr}[X,Y]=0$, so commutators are traceless. The converse also holds, and the $E_{ij}$ are exactly the witnesses:

$$E_{ij}=[E_{ii},E_{ij}]\ (i\neq j),\qquad E_{ii}-E_{jj}=[E_{ij},E_{ji}],$$

and these span *all* traceless matrices. So $[\mathfrak{gl}_n,\mathfrak{gl}_n]=\mathfrak{sl}_n$ exactly, and $\phi$ must vanish on every traceless matrix — on the basis, $\phi(E_{ij})=0$ for $i\neq j$ and all $\phi(E_{ii})$ equal (their differences are commutators). A functional that kills the traceless part can only depend on the trace. If $\phi$ were complex-linear that would already give $\phi(X)=a\operatorname{tr}X$; smoothness of $f$ only guarantees *real*-linearity, which admits one more term:

$$\phi(X)=a\operatorname{tr}X+b\,\overline{\operatorname{tr}X},\qquad a,b\in\mathbb C$$

— the $b$ term is the anti-holomorphic branch, whose integrated form will be $\overline{\det}$.

Compare with the groups you know: for $SU(2)$ or the Lorentz group, *every* generator is itself a commutator ($[J_i,J_j]=\epsilon_{ijk}J_k$, …), the algebra is "all commutator," and so there is **no** nontrivial det-like function on them — their only one-dimensional representation is trivial. $GL(n)$ is special precisely because $\mathfrak{gl}_n=\mathfrak{sl}_n\oplus\mathbb C\cdot I$ has exactly **one abelian direction** — overall scaling, measured by the trace. The determinant exists because of, and only because of, that one direction.

## 5. Down the right leg: $\det=\exp\circ\operatorname{tr}\circ\log$, and the quantization of the charge

At this point one is tempted to declare victory. The flow formula plus $\phi=a\operatorname{tr}+b\,\overline{\operatorname{tr}}$ says: *to evaluate $f$ on $A$, find any generator $X$ that reaches it ($e^X=A$, a logarithm of $A$), apply $\phi$, exponentiate.* For the normalized case this is the direct formula

$$\boxed{\ \det A = e^{\operatorname{tr}\log A}\ }$$

and it is worth checking on transformations you know:

* $A=\operatorname{diag}(d_1,d_2)$: take $X=\operatorname{diag}(\log d_1,\log d_2)$, so $\operatorname{tr}X=\log d_1+\log d_2$ and $e^{\operatorname{tr}X}=d_1d_2$. ✓
* a rotation $R(\theta)=e^{\theta(E_{21}-E_{12})}$: the generator is traceless, so $\det R=e^0=1$ — rotations preserve volume *because their generator is traceless*. Same for boosts/transvections.

But two honest gaps separate the boxed formula from a theorem. **Gap (i):** $\log A$ is multivalued — the recipe must not depend on which $X$ we pick. **Gap (ii):** the formula is not closed-form — it requires producing a logarithm, and even the statement "every $A\in GL(n,\mathbb C)$ has one" is a theorem. This section closes gap (i) by integrating the two generator families of section 2 by hand; section 6 closes gap (ii).

### 5.1 Transvections: $f=1$, automatically

The off-diagonal generators are traceless, $\operatorname{tr}E_{ij}=0$, so the flow formula gives

$$f\big(T_{ij}(c)\big)=f\big(e^{cE_{ij}}\big)=e^{\phi(cE_{ij})}=e^{a\cdot 0+b\cdot\bar 0}=1.$$

No ambiguity arises (the answer is the same for every choice), and Step 2 of the elementary note falls out in one line: an abelian charge cannot register a traceless, boost-like generator. By multiplicativity, multiplying any matrix by transvections never changes $f$.

### 5.2 Diagonal matrices: the multivaluedness bites, and quantizes the charge

Every $d_k\in\mathbb C^*$ is an exponential: pick logs $z_k$ with $d_k=e^{z_k}$ — **here the branch choice is genuinely free**, $z_k\to z_k+2\pi i$ gives the same $d_k$. Then $\operatorname{diag}(d_1,\dots,d_n)=\exp\big(\operatorname{diag}(z_1,\dots,z_n)\big)$, and since $\operatorname{tr}\operatorname{diag}(z)=\sum_k z_k$, the flow formula gives

$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=\exp\Big(a\sum_k z_k+b\,\overline{\textstyle\sum_k z_k}\Big).$$

The left side is one fixed number; it cannot depend on which branches we chose. Shift a single $z_k\to z_k+2\pi i$: the right side picks up the factor $e^{2\pi i(a-b)}$. Single-valuedness therefore **forces the quantization**

$$a-b=:k\in\mathbb Z$$

— the same mechanism that quantizes angular momentum ($e^{ik\varphi}$ must be single-valued on the circle) and the $U(1)$ charge of section 1. The topology responsible: $\mathbb C^*\cong\mathbb R_{>0}\times U(1)$ contains a circle, $GL(n,\mathbb C)$ contains a non-contractible loop (wind the phase of one diagonal entry by $2\pi$), and a representation must map winding numbers to winding numbers integrally. This is global information that the algebra — which only sees an infinitesimal neighborhood of $I$ — cannot know; it is exactly what the bare generator analysis of section 4 was missing.

Given the quantization, the recipe

$$g(w):=e^{a\log w+b\,\overline{\log w}}=|w|^{\,a+b}\Big(\frac{w}{|w|}\Big)^{a-b},
\qquad s:=a+b\in\mathbb C,\quad k:=a-b\in\mathbb Z,$$

does not depend on the branch of $\log w$ (a branch shift changes the exponent by $2\pi i m(a-b)\in 2\pi i\,\mathbb Z$), and $g$ is a continuous homomorphism $\mathbb C^*\to\mathbb C^*$ — precisely the family $|w|^s(w/|w|)^k$ derived independently in [cstar_homomorphism.md](cstar_homomorphism.md), now reconstructed from the two real-linear components of $\phi$. Since $\sum_k z_k$ is a log of the product $d_1\cdots d_n$, the display above says exactly

$$f\big(\operatorname{diag}(d_1,\dots,d_n)\big)=g\big(d_1d_2\cdots d_n\big).$$

This is Step 3 of the elementary note: the trace doesn't care which diagonal slot a number sits in, so $f$ sees only the product.

## 6. Closing gap (ii): the antisymmetric singlet derives the Leibniz formula

The boxed formula $e^{\operatorname{tr}\log A}$ requires a logarithm of $A$. We now construct **the same function in closed form** — an explicit polynomial in the entries of $A$ whose generator is $\operatorname{tr}$ — so that no logarithm is ever needed. The physicist's candidate is the $\varepsilon$-tensor.

In $n$ dimensions, a totally antisymmetric object with $n$ indices has exactly **one** independent component: $\psi_{i_1\cdots i_n}=c\,\varepsilon_{i_1\cdots i_n}$. Equivalently, the wedge $e_1\wedge\cdots\wedge e_n$ spans a one-dimensional space (the "singlet"). Let $A$ act on every slot. The result is again totally antisymmetric, hence a multiple of the singlet, and that multiple is a number we *define* as $L(A)$:

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
* **Generator.** Expanding each slot of $(I+\varepsilon X)e_1\wedge\cdots\wedge(I+\varepsilon X)e_n$ to first order, the slot-$k$ term $Xe_k=\sum_j X_{jk}e_j$ survives the wedge only for $j=k$ (all other basis vectors are already present), so $L(I+\varepsilon X)=1+\varepsilon\sum_k X_{kk}+O(\varepsilon^2)=1+\varepsilon\operatorname{tr}X$. So $L$ **is** an integral of the trace — the explicit polynomial with $dL_I=\operatorname{tr}$ — and by the flow formula of section 3, $L(e^X)=e^{\operatorname{tr}X}$: on the image of $\exp$, $L$ coincides with $e^{\operatorname{tr}\log A}$, with no branch to choose.

## 7. Patching the square together on the whole group

Sections 5.1–5.2 evaluated $f$ on the two generator families; $L$ of section 6 is defined everywhere outright. What remains is to connect them on an *arbitrary* $A\in GL(n,\mathbb C)$, and for that we borrow exactly one result from the elementary note — the Gauss factorization Lemma of [determinant_homomorphism.md](determinant_homomorphism.md) (plain row reduction, no determinants used; we do not repeat the proof):

$$A=E\,D,\qquad E=\text{product of transvections},\quad D=\operatorname{diag}(d_1,\dots,d_n).$$

Apply $f$ using multiplicativity, 5.1 and 5.2:

$$f(A)=f(E)\,f(D)=g\big(d_1\cdots d_n\big).$$

Apply $L$ using its one-line properties (peel the transvections, then the diagonal):

$$L(A)=L(E)\,L(D)=d_1\cdots d_n.$$

The second display does double duty: it shows the pivot product $d_1\cdots d_n$ — a priori dependent on the chosen row reduction — equals the unambiguous polynomial $L(A)$, hence is the *same* for every factorization; and substituting it into the first display gives the final result:

$$\boxed{\,f(A)=g\big(L(A)\big),\qquad L(A)=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{k=1}^n A_{k,\sigma(k)}.\,}$$

Every ingredient was constructed, none assumed: $a,b$ came from differentiating $f$ (sections 3–4); the quantization $a-b\in\mathbb Z$ from single-valuedness on the diagonal subgroup (section 5.2); $g$ was built from $(a,b)$; $L$ was built as the antisymmetric singlet (section 6); and the patching used only row reduction and multiplicativity. Finally, imposing homogeneity $f(\lambda I)=\lambda^n$: with $\lambda=e^z$, the flow formula gives $f(\lambda I)=e^{n(az+b\bar z)}\overset{!}{=}e^{nz}$ for all $z$, forcing $a=1$, $b=0$, i.e. $g=\mathrm{id}$ and

$$f=L=\det.$$

(Aside: the eigenvalue formula $f(A)=\prod_i\lambda_i(A)$ of Part III, Step 5 in `determinant_over_C.md` expresses the same result, but needs the surjectivity of $\exp$ over $\mathbb C$ — gap (ii) closed by analysis instead of algebra. The route above trades that analytic input for the Gauss factorization, the same trade the elementary note makes, and produces the Leibniz formula constructively along the way.)

## 8. Dictionary: the Lie picture vs. the elementary derivation

The derivation in `determinant_homomorphism.md` is **the same argument run entirely at the group level, without ever differentiating** — which is exactly why it needs no continuity assumption:

- **Step 2 there ($f=1$ on transvections)** is the global version of "$\phi$ kills the traceless generators" (here 5.1). In fact for $n\ge3$ transvections are themselves *group* commutators: the bracket $[E_{ik},E_{kj}]=E_{ij}$ exponentiates to $T_{ik}(a)\,T_{kj}(b)\,T_{ik}(a)^{-1}T_{kj}(b)^{-1}=T_{ij}(ab)$, and an abelian charge can't see commutators. Globally: transvections generate $SL(n,\mathbb C)=[GL,GL]$, the group-level "traceless part" ($\det=1$), so $f$ is blind to it and can only depend on $A$ modulo $SL$ — i.e. on $\det A$.
- **Step 3 there ($f(\operatorname{diag})=g(\prod d_i)$)** is the global version of 5.2. The free homomorphism $g$ of the elementary note is the global counterpart of the constants $(a,b)$; with continuity the correspondence is exact, $g(w)=|w|^{a+b}(w/|w|)^{a-b}$.
- **The Gauss factorization $A=ED$** is the elementary substitute for "$\exp$ is surjective": both write an arbitrary group element in terms of pieces where $f$ is already pinned down.
- **The Leibniz polynomial $L$** plays the same anchoring role in both: the explicit, single-valued, everywhere-defined object. The elementary note *posits* the polynomial and verifies its properties; here it was *derived* as the matrix element of the antisymmetric singlet, the unique one-dimensional representation whose generator is $\operatorname{tr}$.

One sentence for the road: *the determinant is to the trace what a finite transformation is to its generator; it exists because $GL(n)$ has exactly one abelian direction (overall scaling), every abelian charge must vanish on the boost-like nilpotent generators $E_{ij}$ spanning the rest, and the unique charge consistent with $f(\lambda I)=\lambda^n$ is $\det=\exp\circ\operatorname{tr}\circ\log$ — made polynomial by the $\varepsilon$-tensor singlet.*

The table "How the two proofs correspond" in [determinant_over_C.md](determinant_over_C.md) lists this dictionary line by line.
