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

Generators map to generators (top arrow), finite transformations map to finite transformations (bottom arrow), and exponentiation commutes with everything.

Because the same letters tend to blur together, here is every symbol of this note with its type. In particular, $\phi$ is **not** a Lie algebra — it is a linear *map between* the two Lie algebras (the top arrow of the square), exactly as $\det$ is a map between the two groups (the bottom arrow):

| symbol | type |
|---|---|
| $GL(n,\mathbb C)$, $\;\mathbb C^*$ | the two **groups** |
| $\mathfrak{gl}(n,\mathbb C)$, $\;\mathbb C$ | their two **Lie algebras** |
| $A$, $\;T_{ij}(c)$, $\;\operatorname{diag}(d_1,\dots,d_n)$ | **group elements**, in $GL(n,\mathbb C)$ |
| $X$, $\;E_{ij}$, $\;\log A$ | **algebra elements** (generators), in $\mathfrak{gl}(n,\mathbb C)$ |
| $\lambda$, $\;f(A)$, $\;\det A$, $\;w$ | group elements of the target, in $\mathbb C^*$ |
| $z$, $\;\phi(X)$, $\;\operatorname{tr}X$ | algebra elements of the target, in $\mathbb C$ |
| $f$, $\;\det$, $\;g$ | **group homomorphisms** — horizontal arrows between groups |
| $\phi$, $\;\operatorname{tr}$, $\;\bar\phi$ | **Lie-algebra homomorphisms** — horizontal arrows between algebras (linear maps with $\phi([X,Y])=0$) |
| $\exp$ (both legs) | the vertical arrows, algebra $\to$ group | The model you already know is $U(1)$: group $\{e^{i\theta}\}$, algebra $i\mathbb R$, representations $f_k(e^{i\theta})=e^{ik\theta}$ labeled by an integer charge $k$. The algebra-level map is "multiply by $k$," the group-level map is its exponentiation, and $k$ must be an *integer* for single-valuedness. The determinant is the same story with $G=GL(n,\mathbb C)$: the algebra-level map will be forced to be $a\cdot\operatorname{tr}$, single-valuedness will quantize the charge, and $\det$ is the charge-$1$ representation. The sections below derive every arrow of the square; in particular the bottom arrow (the Leibniz formula) is *constructed* in section 6, not assumed.

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

Here is the structural heart. The group-level statement is a one-liner: the target $\mathbb C^*$ is **abelian**, and an abelian charge cannot see group commutators,

$$f\big(ABA^{-1}B^{-1}\big)=f(A)\,f(B)\,f(A)^{-1}f(B)^{-1}=1,$$

because the four values are *numbers* and numbers commute. The algebra-level consequence is $\phi([X,Y])=0$ — but getting there requires a bridge between the group commutator $ABA^{-1}B^{-1}$ and the Lie bracket $[X,Y]=XY-YX$. We build the bridge first (4.1), cross it carefully (4.2), and then ask which matrices are brackets (4.3).

### 4.1 The Lie bracket is the infinitesimal group commutator

Run the flow of $X$ for a small time $s$, the flow of $Y$ for a small time $t$, then undo both, in order:

$$C(s,t):=e^{sX}\,e^{tY}\,e^{-sX}\,e^{-tY}.$$

If $X$ and $Y$ commuted as matrices, the four factors would reorder and cancel, $C=I$. In general, expand every exponential, keeping all terms up to total degree $2$ in $(s,t)$:

$$e^{\pm sX}=I\pm sX+\tfrac{s^2}{2}X^2+O(s^3),\qquad e^{\pm tY}=I\pm tY+\tfrac{t^2}{2}Y^2+O(t^3).$$

Multiply the left pair and the right pair:

$$e^{sX}e^{tY}=I+\underbrace{(sX+tY)}_{u_1}+\underbrace{\Big(st\,XY+\tfrac{s^2}{2}X^2+\tfrac{t^2}{2}Y^2\Big)}_{u_2}+(\text{deg}\ge3),$$

$$e^{-sX}e^{-tY}=I+\underbrace{(-sX-tY)}_{v_1}+\underbrace{\Big(st\,XY+\tfrac{s^2}{2}X^2+\tfrac{t^2}{2}Y^2\Big)}_{v_2}+(\text{deg}\ge3)$$

(note $v_2=u_2$: both signs flip, and the cross term $(-sX)(-tY)=st\,XY$ comes out the same). Now multiply the two halves and collect by degree:

$$C(s,t)=(I+u_1+u_2)(I+v_1+v_2)=I+(u_1+v_1)+(u_2+v_2+u_1v_1)+(\text{deg}\ge3).$$

Degree $1$: $u_1+v_1=0$ — to first order the flows *do* commute; whatever survives is second order. Degree $2$:

$$u_1v_1=-(sX+tY)^2=-s^2X^2-st\,(XY+YX)-t^2Y^2,$$

$$u_2+v_2+u_1v_1=\big(2st\,XY+s^2X^2+t^2Y^2\big)-s^2X^2-st\,XY-st\,YX-t^2Y^2=st\,(XY-YX).$$

The pure $s^2$ and $t^2$ terms cancel identically — only the *bilinear* term survives, and it is exactly the bracket:

$$\boxed{\ e^{sX}\,e^{tY}\,e^{-sX}\,e^{-tY}=I+st\,[X,Y]+(\text{total degree}\ge3).\ }$$

This is what "the Lie bracket is the infinitesimal group commutator" means: the bracket measures the leading failure of two flows to close. You know it from rotations — a small rotation about $x$, a small one about $y$, then undoing both leaves a small rotation about $z$ of angle $st$: that is $[J_x,J_y]=J_z$ made tangible. (Same phenomenon as parallel parking: "steer" and "drive" don't commute, and their commutator is the sideways translation you actually want.)

### 4.2 Crossing the bridge: $\phi([X,Y])=0$, every step

The cleanest complete derivation goes through conjugation; the direct second-order route is at the end.

**Step 1 (group level: the charge is conjugation-blind).** For any $g,h\in GL(n,\mathbb C)$:

$$f\big(g\,h\,g^{-1}\big)=f(g)\,f(h)\,f(g)^{-1}=f(h),$$

since the values are commuting numbers. (This is Step 1 of `determinant_homomorphism.md`, reappearing.)

**Step 2 (conjugation of an exponential is the exponential of the conjugated generator).** For any invertible $g$ and any matrix $M$, $(gMg^{-1})^k=gM^kg^{-1}$ — the interior $g^{-1}g$ pairs cancel. Apply this to every term of the exponential series:

$$g\,e^{tY}g^{-1}=g\Big(\sum_k \tfrac{t^k}{k!}Y^k\Big)g^{-1}=\sum_k\tfrac{t^k}{k!}\,(gYg^{-1})^k=e^{\,t\,gYg^{-1}}.$$

**Step 3 (transfer to the algebra: $\phi$ is conjugation-invariant).** Apply $f$ to Step 2 and use Step 1 on the left, the flow formula of section 3 on both sides:

$$e^{\,t\,\phi(gYg^{-1})}=f\big(e^{\,t\,gYg^{-1}}\big)=f\big(g\,e^{tY}g^{-1}\big)=f\big(e^{tY}\big)=e^{\,t\,\phi(Y)}\qquad\text{for all }t.$$

Two exponentials of linear functions of $t$ that agree for *all* $t$ have equal slopes at $t=0$ (differentiate), so

$$\phi\big(gYg^{-1}\big)=\phi(Y)\qquad\text{for every invertible }g.$$

**Step 4 (Hadamard's lemma — the physicist's $e^{A}Be^{-A}$ formula).** Take $g=e^{sX}$ and expand the conjugated generator in $s$. Let $G(s):=e^{sX}\,Y\,e^{-sX}$, a curve of matrices in $\mathfrak{gl}(n,\mathbb C)$. Differentiate:

$$G'(s)=X\,e^{sX}Ye^{-sX}-e^{sX}Ye^{-sX}\,X=[X,\,G(s)],\qquad G(0)=Y.$$

In particular $G'(0)=[X,Y]$, so the Taylor expansion is

$$e^{sX}\,Y\,e^{-sX}=Y+s\,[X,Y]+O(s^2)$$

(iterating gives the full series $Y+s[X,Y]+\tfrac{s^2}{2}[X,[X,Y]]+\cdots=e^{s\,\mathrm{ad}_X}Y$, the adjoint action — "$\mathrm{Ad}=\exp(\mathrm{ad})$" — but the first-order term is all we need).

**Step 5 (conclude).** Insert Step 4 into Step 3 and use linearity of $\phi$:

$$\phi(Y)=\phi\big(e^{sX}Ye^{-sX}\big)=\phi\big(Y+s[X,Y]+O(s^2)\big)=\phi(Y)+s\,\phi([X,Y])+O(s^2)\qquad\text{for all }s.$$

The coefficient of $s$ must vanish:

$$\boxed{\ \phi([X,Y])=0\qquad\text{for all }X,Y.\ }$$

$\square$

*The second-order route, for comparison.* One can instead apply $f$ directly to the group commutator of 4.1. Define $F(s,t):=f\big(C(s,t)\big)$. By multiplicativity and commuting values (the one-liner at the top of this section), $F(s,t)=1$ **exactly**, for all $s,t$. On the other hand, by 4.1 and the defining expansion of $\phi$,

$$F(s,t)=f\big(I+st[X,Y]+\cdots\big)=1+st\,\phi([X,Y])+(\text{deg}\ge3),$$

and a function identically equal to $1$ has all Taylor coefficients zero — in particular the $st$ coefficient, $\phi([X,Y])=0$. (Pedantic check that no second-derivative-of-$f$ terms pollute the $st$ coefficient: along the axes the commutator is trivial, $C(s,0)=C(0,t)=I$ identically, so both first partials of $C$ vanish at the origin and the mixed partial of $F$ is $\phi$ applied to the mixed partial of $C$, which is $[X,Y]$.) The conjugation route of Steps 1–5 is the same argument reorganized so that only *first*-order expansions are ever needed.

### 4.3 Which matrices are brackets: $[\mathfrak{gl}_n,\mathfrak{gl}_n]=\mathfrak{sl}_n$

Cyclicity of the trace gives $\operatorname{tr}[X,Y]=0$, so brackets are traceless. The converse also holds, and the $E_{ij}$ are exactly the witnesses:

$$E_{ij}=[E_{ii},E_{ij}]\ (i\neq j),\qquad E_{ii}-E_{jj}=[E_{ij},E_{ji}],$$

and these span *all* traceless matrices. So $[\mathfrak{gl}_n,\mathfrak{gl}_n]=\mathfrak{sl}_n$ exactly, and $\phi$ must vanish on every traceless matrix — on the basis, $\phi(E_{ij})=0$ for $i\neq j$ and all $\phi(E_{ii})$ equal (their differences are commutators). A functional that kills the traceless part can only depend on the trace. If $\phi$ were complex-linear that would already give $\phi(X)=a\operatorname{tr}X$; smoothness of $f$ only guarantees *real*-linearity, which admits one more term:

$$\phi(X)=a\operatorname{tr}X+b\,\overline{\operatorname{tr}X},\qquad a,b\in\mathbb C$$

— the $b$ term is the anti-holomorphic branch, whose integrated form will be $\overline{\det}$.

Compare with the groups you know: for $SU(2)$ or the Lorentz group, *every* generator is itself a commutator ($[J_i,J_j]=\epsilon_{ijk}J_k$, …), the algebra is "all commutator," and so there is **no** nontrivial det-like function on them — their only one-dimensional representation is trivial. $GL(n)$ is special precisely because $\mathfrak{gl}_n=\mathfrak{sl}_n\oplus\mathbb C\cdot I$ has exactly **one abelian direction** — overall scaling, measured by the trace. The determinant exists because of, and only because of, that one direction.

## 5. Down the right leg: $\det=\exp\circ\operatorname{tr}\circ\log$, and the quantization of the charge

Take stock of which arrows of the square are now known. The top arrow is **known**: section 4 forced $\phi=a\operatorname{tr}+b\,\overline{\operatorname{tr}}$. The two vertical legs are **known**: they are the exponentials. The bottom arrow $f$ is the **unknown** we are after. But a square that commutes lets you compute a missing side by going around the other way: instead of crossing the bottom directly ($A\mapsto f(A)$, unknown), go *up* the left leg, *across* the known top, and *down* the right leg. Explicitly, to evaluate $f(A)$:

1. **Up the left leg** (the only hard step — the leg must be traversed *backwards*). Find a generator that reaches $A$: a matrix $X\in\mathfrak{gl}(n,\mathbb C)$ with $e^X=A$. Any such $X$ is called a logarithm of $A$ and written $X=\log A$. Mind the types: $A$ is a group element; $\log A$ is an **algebra element** — an honest $n\times n$ matrix (generally not unique; that is gap (i) below).
2. **Across the top arrow.** Apply the known map $\phi$ to it: the number $\phi(X)=a\operatorname{tr}X+b\,\overline{\operatorname{tr}X}\in\mathbb C$. (Recall from the type table of section 1: $\phi$ is not a Lie algebra — it is the linear map $\mathfrak{gl}(n,\mathbb C)\to\mathbb C$, the algebra-level shadow of $f$.)
3. **Down the right leg.** Exponentiate the number: $e^{\phi(X)}\in\mathbb C^*$.
4. **The square commutes**, so the detour lands on the right answer: by the flow formula of section 3, $f(A)=f(e^X)=e^{\phi(X)}$.

For the normalized charge $a=1,\ b=0$ (i.e. $\phi=\operatorname{tr}$) the detour reads, symbol by symbol,

$$A\ \xrightarrow{\ \log\ }\ \underbrace{\log A}_{\text{matrix }\in\,\mathfrak{gl}(n,\mathbb C)}\ \xrightarrow{\ \operatorname{tr}\ }\ \underbrace{\operatorname{tr}\log A}_{\text{number }\in\,\mathbb C}\ \xrightarrow{\ \exp\ }\ \underbrace{e^{\operatorname{tr}\log A}}_{\in\,\mathbb C^*},$$

i.e. the direct formula

$$\boxed{\ \det A = e^{\operatorname{tr}\log A}\ }$$

— three known maps composed, replacing the one unknown map. It is worth checking on transformations you know:

* $A=\operatorname{diag}(d_1,d_2)$: take $X=\operatorname{diag}(\log d_1,\log d_2)$, so $\operatorname{tr}X=\log d_1+\log d_2$ and $e^{\operatorname{tr}X}=d_1d_2$. ✓
* a rotation $R(\theta)=e^{\theta(E_{21}-E_{12})}$: the generator is traceless, so $\det R=e^0=1$ — rotations preserve volume *because their generator is traceless*. Same for boosts/transvections.
* a rotation–scaling $A=r\begin{pmatrix}\cos\theta&-\sin\theta\\ \sin\theta&\cos\theta\end{pmatrix}$: one checks $A=e^X$ with $X=\begin{pmatrix}\log r&-\theta\\ \theta&\log r\end{pmatrix}$, so $\operatorname{tr}X=2\log r$ and $\det A=e^{2\log r}=r^2$ — the area-expansion factor of the spiral map, with the rotation angle dropping out of the trace.

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

## 8. The role of $g$: the charge of the representation

The derivation above did not — and could not — produce $f=\det$ outright: the boxed result of section 7 is $f=g\circ L$, and only the normalization $f(\lambda I)=\lambda^n$ collapsed $g$ to the identity. This is not a defect of the method; the factor $g$ has a precise Lie-theoretic identity, worth spelling out. **$g$ is the charge of the representation** — a one-dimensional representation of the *target* group $\mathbb C^*$ itself. The determinant carries no freedom; it is the universal, canonical piece. All the freedom of $f$ lives in $g$.

### 8.1 The square factors into two stacked squares

What sections 4–7 actually established is that the commuting square of section 1 splits in the middle:

$$
\begin{array}{ccccc}
\mathfrak{gl}(n,\mathbb C) & \xrightarrow{\ \operatorname{tr}\ } & \mathbb C & \xrightarrow{\ z\,\mapsto\, az+b\bar z\ } & \mathbb C\\[4pt]
{\scriptstyle\exp}\big\downarrow\ \ & & \big\downarrow{\scriptstyle\exp} & & \big\downarrow{\scriptstyle\exp}\\[4pt]
GL(n,\mathbb C) & \xrightarrow{\ \det\ } & \mathbb C^* & \xrightarrow{\ \ g\ \ } & \mathbb C^*
\end{array}
$$

Top row: $\phi=\bar\phi\circ\operatorname{tr}$, where $\bar\phi(z)=az+b\bar z$ is a functional on the **one-dimensional quotient** $\mathfrak{gl}_n/\mathfrak{sl}_n\cong\mathbb C$. Bottom row: $f=g\circ\det$. The *left* square is rigid — no parameters, the same for every $f$; it is pure structure ($[\mathfrak{gl},\mathfrak{gl}]=\mathfrak{sl}$, and the trace is the quotient map). The *right* square is where the entire $(a,b)$ freedom sits, and its bottom arrow is $g$. So $g$ is literally "the part of $f$ that remains after the universal part has been factored out."

### 8.2 Group level: $g$ is $f$ seen on the quotient

The commutator argument forces $f$ to be trivial on $SL(n,\mathbb C)=[GL,GL]$. A function trivial on $SL$ depends on $A$ only through its coset $A\cdot SL$ — i.e., it **descends to the quotient group** $GL(n,\mathbb C)/SL(n,\mathbb C)$. The determinant is exactly the identification of that quotient with $\mathbb C^*$. So the statement $f=g\circ\det$ decomposes as

$$f \;=\; \underbrace{\big(\text{the descended map on the quotient}\big)}_{=\;g\;:\;\mathbb C^*\to\,\mathbb C^*}\ \circ\ \underbrace{\big(\text{the quotient map}\big)}_{=\;\det}.$$

This is the most Lie-theoretic answer to "where does $g$ come from": **group theory can prove that $f$ factors through the abelianization, and can identify the abelianization with $\mathbb C^*$ — but it cannot choose a representation *of* $\mathbb C^*$.** The target group has many self-homomorphisms ($w\mapsto w^2$, $w\mapsto\bar w$, $w\mapsto|w|^s(w/|w|)^k$, …), all equally lawful, and composing any homomorphism with one of them produces another homomorphism. No structural principle prefers $w\mapsto w$ among them. That residual choice *is* $g$.

### 8.3 Charge level: $g$ is the pair $(s,k)$ — and physics uses the nontrivial ones

At the generator level $g$ is just two numbers: $\phi=a\operatorname{tr}+b\,\overline{\operatorname{tr}}$ with the quantization $a-b\in\mathbb Z$ of section 5.2. Writing $s=a+b\in\mathbb C$ and $k=a-b\in\mathbb Z$,

$$g(w)=|w|^{\,s}\Big(\frac{w}{|w|}\Big)^{k}.$$

Compare with $\mathbb C^*\cong\mathbb R_{>0}\times U(1)$: on the circle factor, $k$ is the integer **winding charge** (quantized, exactly as for $U(1)$ representations); on the contractible $\mathbb R_{>0}$ factor, $s$ is a continuous **scaling dimension** (no quantization — nothing to wind around). A one-dimensional representation of $GL(n,\mathbb C)$ is thus labeled by a charge $(s,k)$, exactly as a representation of $U(1)$ is labeled by $k$, and "$f=g\circ\det$" says: *every representation is the universal one, taken to the power of its charge.*

The $g\neq\mathrm{id}$ members are not exotica — physics uses them constantly: **tensor densities of weight $w$** transform with the extra factor $(\det J)^{-w}$ or $|\det J|^{-w}$, which is precisely a nontrivial choice of $g$; the $\sqrt{|g_{\mu\nu}|}$ in the invariant volume element is the member $g(w)=|w|^{1/2}$. This is the subject of Part IV of [determinant_over_C.md](determinant_over_C.md): the "weight" of a density is its charge.

### 8.4 So in what sense was $f=\det$ "derived"?

In two layers, which mirror Layer 1/Layer 2 of the elementary derivation exactly:

1. **Forced by Lie theory:** $f=g\circ\det$ for *some* charge $g$. Equivalently, $\det$ is the **universal** one-dimensional representation — every other factors through it. This part contains no choices.
2. **A normalization, imposed from outside:** homogeneity $f(\lambda I)=\lambda^n$ forces $a=1,\ b=0$, i.e. charge $(s,k)=(1,1)$, i.e. $g=\mathrm{id}$, i.e. $f=\det$. This is not Lie theory — it is the *definition* of which member of the family we agree to call "the determinant," just as "the electron has charge $1$" is a normalization, not a theorem about $U(1)$.

## 9. Dictionary: the Lie picture vs. the elementary derivation

The derivation in `determinant_homomorphism.md` is **the same argument run entirely at the group level, without ever differentiating** — which is exactly why it needs no continuity assumption:

- **Step 2 there ($f=1$ on transvections)** is the global version of "$\phi$ kills the traceless generators" (here 5.1). In fact for $n\ge3$ transvections are themselves *group* commutators: the bracket $[E_{ik},E_{kj}]=E_{ij}$ exponentiates to $T_{ik}(a)\,T_{kj}(b)\,T_{ik}(a)^{-1}T_{kj}(b)^{-1}=T_{ij}(ab)$, and an abelian charge can't see commutators. Globally: transvections generate $SL(n,\mathbb C)=[GL,GL]$, the group-level "traceless part" ($\det=1$), so $f$ is blind to it and can only depend on $A$ modulo $SL$ — i.e. on $\det A$.
- **Step 3 there ($f(\operatorname{diag})=g(\prod d_i)$)** is the global version of 5.2. The free homomorphism $g$ of the elementary note is the global counterpart of the constants $(a,b)$; with continuity the correspondence is exact, $g(w)=|w|^{a+b}(w/|w|)^{a-b}$.
- **The Gauss factorization $A=ED$** is the elementary substitute for "$\exp$ is surjective": both write an arbitrary group element in terms of pieces where $f$ is already pinned down.
- **The Leibniz polynomial $L$** plays the same anchoring role in both: the explicit, single-valued, everywhere-defined object. The elementary note *posits* the polynomial and verifies its properties; here it was *derived* as the matrix element of the antisymmetric singlet, the unique one-dimensional representation whose generator is $\operatorname{tr}$.

One sentence for the road: *the determinant is to the trace what a finite transformation is to its generator; it exists because $GL(n)$ has exactly one abelian direction (overall scaling), every abelian charge must vanish on the boost-like nilpotent generators $E_{ij}$ spanning the rest, and the unique charge consistent with $f(\lambda I)=\lambda^n$ is $\det=\exp\circ\operatorname{tr}\circ\log$ — made polynomial by the $\varepsilon$-tensor singlet.*

The table "How the two proofs correspond" in [determinant_over_C.md](determinant_over_C.md) lists this dictionary line by line.
