# Determinant by Multiplicativity: Real vs Complex

How many algebraic axioms does it take to single out the determinant among all functions on $n\times n$ matrices? Over $\mathbb C$ the answer is **two**; over $\mathbb R$ the same two **fail**, and a third — fixing the value on a single reflection — is needed. This note states both characterizations in their simplest form and explains the one structural reason for the difference.

:::{note} Lean formalization
The two boxed statements below are spliced verbatim from the compiled Lean sources, so they cannot drift from what is actually checked:
[`DeterminantHomomorphismMonoid.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/DeterminantHomomorphismMonoid.lean)
(complex) and
[`DeterminantHomomorphismReal.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/DeterminantHomomorphismReal.lean)
(real). Continuous integration runs `lake build` (which fails on any error or `sorry`), and both files are axiom-clean (`propext`, `Classical.choice`, `Quot.sound`). They build on the determinant factorization theorem of [Determinant From Homomorphism](determinant_homomorphism.md).
:::

## The two axioms

Throughout, $f$ is a function on $n\times n$ matrices (over $\mathbb C$ or $\mathbb R$), $I$ is the identity, and $\lambda I$ is the scalar matrix. We use:

- **(H1) Multiplicativity.** $f(AB)=f(A)\,f(B)$ for **all** matrices $A,B$ (singular ones included).
- **(H2) Homogeneity.** $f(\lambda I)=\lambda^{\,n}$ for every scalar $\lambda\neq 0$.

Both are satisfied by the determinant, since $\det(AB)=\det A\,\det B$ and $\det(\lambda I)=\lambda^n$.

## Complex: (H1) and (H2) are enough

Over $\mathbb C$, multiplicativity and homogeneity already force $f$ to be the determinant:

```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphismMonoid.lean
:language: lean
:start-after: ANCHOR: dethom-complex-fin
:end-before: ANCHOR_END: dethom-complex-fin
```

Here `f A = A.det` is `det` written via Mathlib's Leibniz formula
$$\det A=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\prod_{i=1}^n A_{i,\sigma(i)},$$
and the theorem says: **there is exactly one** multiplicative, homogeneous function on complex matrices, namely $\det$.

## Real: (H1) and (H2) are *not* enough

Over $\mathbb R$ the very same two axioms no longer pin $f$ down. For **even** $n$, the function $f(A)=|\det A|$ is a second solution: it is multiplicative ($|\det(AB)|=|\det A|\,|\det B|$) and homogeneous, because for even $n$
$$|\det(\lambda I)|=|\lambda^n|=|\lambda|^{\,n}=\lambda^{\,n}\qquad(n\text{ even}),$$
yet $|\det|\neq\det$ on any matrix of negative determinant. The Lean counterexample makes this precise:

```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphismReal.lean
:language: lean
:start-after: ANCHOR: dethom-real-counterexample
:end-before: ANCHOR_END: dethom-real-counterexample
```

The fix is one extra normalization on a **reflection** $T=\operatorname{diag}(-1,1,\dots,1)$, which has $\det T=-1$:

- **(H3) Reflection.** $f(T)=-1$.

This excludes $|\det|$ at a stroke (since $|\det T|=1\neq -1$) and restores uniqueness for **every** $n$:

```{literalinclude} math_notes_lean/MathNotesLean/DeterminantHomomorphismReal.lean
:language: lean
:start-after: ANCHOR: dethom-real-fin
:end-before: ANCHOR_END: dethom-real-fin
```

For odd $n$, (H3) is automatic — it adds nothing — so it is a clean, uniform hypothesis.

## Definition versus characterization

It is tempting to object: the determinant is the Leibniz polynomial $L(A)=\sum_\sigma\operatorname{sgn}(\sigma)\prod_i A_{i,\sigma(i)}$, *one explicit formula* valid over any commutative ring. We proved it exists and is unique over $\mathbb C$; the very same formula computes the determinant of a real matrix. So why isn't the complex result enough for real matrices, with $|\det|$ "excluded automatically" by the complex numbers?

The resolution is to separate two different roles the word *determinant* is playing.

- **Definition (transfers).** $L$ is a single formula. Defining $\det:=L$ works over $\mathbb R$ as the restriction of the complex $\det$: for a real matrix $A$, $\det_{\mathbb R}(A)=\det_{\mathbb C}(A)$. The $|\det|$ issue never touches the *definition*.

- **Characterization (does *not* transfer).** "$\det$ is the unique (H1)+(H2) function" is a statement about the **space of functions** over a given field — and that space is bigger over $\mathbb R$ (it contains $|\det|$ for even $n$) than over $\mathbb C$ (just $\det$).

The reason the complex characterization cannot be "imported" to the reals is that **a function on real matrices is not the restriction of a function on complex matrices.** Given a real $f$ with (H1)+(H2), there is no canonical complex extension, so the complex uniqueness theorem does not apply to it. Concretely, $|\det|$ is *invisible to the complex world*:

- every complex (H1)+(H2) function is $\det_{\mathbb C}$, whose restriction to real matrices is $\det_{\mathbb R}$ — **not** $|\det|$;
- $|\det|$ does extend to $|\det_{\mathbb C}|$, but that **fails complex (H2)**: $|\det_{\mathbb C}(\mu I)|=|\mu|^n\neq\mu^n$ for a general complex $\mu$. It slips past **real** (H2) only because a real $\mu^n\ge 0$ when $n$ is even.

In other words, real (H2) is the *same* equation quantified over *fewer* scalars, and $|\det|$ lives precisely in that gap.

## The one structural reason: $\mathbb C^\times$ is divisible, $\mathbb R^\times$ is not

Both characterizations reduce to the same final step. The factorization theorem gives $f(A)=g(\det A)$ for a homomorphism $g:K^\times\to K^\times$ read off the diagonal, and (H2) forces $g(u)^n=u^n$, i.e.
$$\varepsilon(u):=\frac{g(u)}{u}\in\mu_n(K)\quad\text{(the $n$-th roots of unity)},\qquad \varepsilon:K^\times\to\mu_n(K)\ \text{a homomorphism}.$$
Uniqueness is exactly the statement $\varepsilon\equiv 1$ (then $g=\operatorname{id}$ and $f=\det$). Now a homomorphism from a **divisible** group into a **finite** group is automatically trivial: if $w=z^n$ then $\varepsilon(w)=\varepsilon(z)^n=1$. So everything hinges on whether $K^\times$ is divisible — i.e. whether every element has an $n$-th root.

- **$\mathbb C^\times$ is divisible** — every nonzero complex number has an $n$-th root (this *is* algebraic closure). Hence $\varepsilon\equiv 1$ for free, and **(H1)+(H2) suffice**.
- **$\mathbb R^\times\cong\{\pm1\}\times\mathbb R_{>0}$ is *not* divisible.** The factor $\mathbb R_{>0}$ is divisible (so $\varepsilon=1$ there), but $\{\pm1\}$ is not: for even $n$, $\mu_n(\mathbb R)=\{\pm1\}$ and $\varepsilon(-1)$ may equal $-1$, giving $g=\operatorname{sign}$ and $f=|\det|$. **(H3) forces $\varepsilon(-1)=1$**, removing the last bit of freedom.

So the gap between the real and complex characterizations is not about the determinant formula at all — it is the failure of $\mathbb R$ to contain enough roots. The determinant *is* the same object over both fields; only the question "which axioms pin it down" is field-sensitive, and the missing roots of $\mathbb R$ are paid for by exactly one reflection.
