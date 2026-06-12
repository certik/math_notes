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

## 4. Integrating back up, and why Leibniz comes out

Knowing the generator, reconstruct the rep: $f(e^X) = e^{\phi(X)} = e^{\operatorname{tr}X}$. Over $\mathbb C$, every invertible matrix *is* an exponential ($\exp$ is onto $GL(n,\mathbb C)$ — this fails over $\mathbb R$, e.g. $\operatorname{diag}(-1,-2)$), so this determines $f$ on the whole group: if $X$ has eigenvalues $\mu_i$, then $A=e^X$ has eigenvalues $e^{\mu_i}$ and

$$f(A) = e^{\sum_i \mu_i} = \prod_i \lambda_i(A) = \det A.$$

The Leibniz sum appears at the very end as a coordinate bookkeeping device: the 1-dim rep generated by $\operatorname{tr}$ is the totally antisymmetric top wedge $\Lambda^n\mathbb C^n$ (the "singlet" built with the $\varepsilon$-tensor), and writing $(Ae_1)\wedge\cdots\wedge(Ae_n) = \det A\; e_1\wedge\cdots\wedge e_n$ in components is exactly $\varepsilon^{i_1\cdots i_n}A_{1 i_1}\cdots A_{n i_n}$ — the Leibniz formula. This is Part III, Steps 5–6 of your note.

## 5. How this maps onto the elementary derivation

The derivation in `determinant_homomorphism.md` is **the same argument run at the group level, without ever differentiating** — which is exactly why it needs no continuity assumption:

- **Step 2 ($f=1$ on transvections)** is the global version of "$\phi$ kills the traceless generators." In fact for $n\ge3$ transvections are themselves *group* commutators: the bracket $[E_{ik},E_{kj}]=E_{ij}$ exponentiates to $T_{ik}(a)\,T_{kj}(b)\,T_{ik}(a)^{-1}T_{kj}(b)^{-1}=T_{ij}(ab)$, and an abelian charge can't see commutators. Globally: transvections generate $SL(n,\mathbb C) = [GL,GL]$, the group-level "traceless part" ($\det = 1$), so $f$ is blind to it and can only depend on $A$ modulo $SL$ — i.e. on $\det A$.
- **Step 3 ($f(\operatorname{diag})=g(\prod d_i)$)** is the global version of "$\phi = a\operatorname{tr}$ on the diagonal direction": $\operatorname{diag}(d) = \exp(\operatorname{diag}(\log d))$ and $e^{\sum\log d_i} = \prod d_i$. The free homomorphism $g$ is the global counterpart of the free constant $a$ (with continuity, $g(w)=|w|^s(w/|w|)^k$ corresponds exactly to the $a,b$ pair).
- **The Gauss factorization $A = ED$** is the elementary substitute for "$\exp$ is surjective": both write an arbitrary group element in terms of pieces where $f$ is already pinned down.
- **The Leibniz polynomial $L$** plays the role that $\exp$ and eigenvalues play in the Lie route: the explicit, single-valued object that anchors everything.

One sentence for the road: *the determinant is to the trace what a finite transformation is to its generator; it exists because $GL(n)$ has exactly one abelian direction (overall scaling), every abelian charge must vanish on the boost-like nilpotent generators $E_{ij}$ spanning the rest, and the unique charge normalized by $f(\lambda I)=\lambda^n$ is $\det = \exp\circ\operatorname{tr}\circ\log$.*

Your note's table at "How the two proofs correspond" (`determinant_over_C.md:456`) lists this dictionary line by line. If you'd like, I can add a physics-flavored section like the above (Galilean boost = transvection, "no det for semisimple groups", U(1)-charge language) to one of the notes.
