---
authors:
  - name: Ondřej Čertík
bibliography:
  - references.bib
---
# Divisibility by any prime

There is a delightful determinant test for divisibility by a prime, due to
Watson [@watson2003divisibility] and popularized by John D. Cook in
[*Divisibility by any prime*](https://www.johndcook.com/blog/2021/02/17/divisibility-by-any-prime/).
To test whether an integer $n$ is divisible by a prime $p$, split off the last
digit, writing $n=10a+b$, and evaluate a small $2\times 2$ determinant

```{math}
\begin{vmatrix} a & b \\ k & 1 \end{vmatrix} = a - kb,
```

where $k$ is a fixed number depending only on $p$. Then $n$ is divisible by $p$
if and only if this determinant is. Because the determinant is a smaller number,
one simply iterates until divisibility is obvious.

This note explains *why* the test works, pins down the recipe for $k$, and
formalizes everything in Lean 4 + Mathlib.

:::{note} Lean formalization
The results in this note are formalized in Lean 4 + Mathlib in
[`DivisibilityByPrimeFlow.lean`](https://github.com/certik/math_notes/blob/main/math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean),
a flow-faithful development that reproduces the note's derivations in order and
depends only on Mathlib. Each **Lean proof** dropdown below splices the
corresponding declaration verbatim from the compiled source, so the displayed
code cannot drift from what is actually checked. Continuous integration runs
`lake build` (which fails on any error or `sorry`), and the file is axiom-clean
(`propext`, `Classical.choice`, `Quot.sound`).

Lean's kernel guarantees each *proof* is correct. Whether a Lean *statement*
faithfully captures the informal claim is a human judgement, so each dropdown is
placed next to the statement it formalizes, for direct comparison.
:::

(div-examples)=
## The test in action

Take $p=31$ and $n=2759$. Here $31$ ends in $1$, and the recipe below gives
$k=3$. Peel off the last digit and evaluate the determinant, then repeat:

```{math}
\begin{vmatrix} 275 & 9 \\ 3 & 1 \end{vmatrix} = 275 - 3\cdot 9 = 248,
\qquad
\begin{vmatrix} 24 & 8 \\ 3 & 1 \end{vmatrix} = 24 - 3\cdot 8 = 0.
```

The chain ends in $0$, which is divisible by $31$, so $2759$ is divisible by
$31$.

For a negative answer, take $p=61$ and $n=75273$. Again $61$ ends in $1$, giving
$k=6$:

```{math}
\begin{vmatrix} 7527 & 3 \\ 6 & 1 \end{vmatrix} = 7509,\quad
\begin{vmatrix} 750 & 9 \\ 6 & 1 \end{vmatrix} = 696,\quad
\begin{vmatrix} 69 & 6 \\ 6 & 1 \end{vmatrix} = 33.
```

Since $33$ is not divisible by $61$, neither is $75273$.

The determinant is literally $a-kb$; the Lean statement below checks this against
Mathlib's own $2\times 2$ determinant.

:::{dropdown} Lean proof: `det_eq`
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-det
:end-before: ANCHOR_END: flow-div-det
```
:::

(div-why)=
## Why it works

Let $p$ be an integer and split $n=10a+b$. Suppose $k$ is chosen so that
```{math}
:label: eq-div-cert

10k+1=mp \qquad\text{for some integer } m,
```
i.e. $10k\equiv-1\pmod p$. The whole test rests on one algebraic identity:
```{math}
:label: eq-div-identity

10\,(a-kb)=(10a+b)-(10k+1)\,b.
```
Indeed, expanding the right-hand side gives $10a+b-10kb-b=10a-10kb=10(a-kb)$.

**The equivalence.** Working modulo $p$, the term $(10k+1)b$ vanishes by
{eq}`eq-div-cert`, so {eq}`eq-div-identity` says
$$
10\,(a-kb)\equiv 10a+b=n \pmod p.
$$
Now $10$ is invertible modulo $p$ — the certificate {eq}`eq-div-cert` rearranges
to $(-k)\cdot 10+m\cdot p=1$, a Bézout identity proving $\gcd(10,p)=1$ — so
multiplying by $10$ neither creates nor destroys divisibility by $p$. Therefore
```{math}
:label: eq-div-claim

p \mid (10a+b) \iff p \mid (a-kb).
```
Read left to right: if $p\mid 10a+b$ then $p$ divides the right-hand side of
{eq}`eq-div-identity`, hence $p\mid 10(a-kb)$, and coprimality gives $p\mid a-kb$.
Read right to left: if $p\mid a-kb$ then $p\mid 10(a-kb)$, and adding the multiple
$(10k+1)b$ of $p$ gives $p\mid 10a+b$; this direction needs no coprimality.

:::{dropdown} Lean proof: `dvd_iff` and its determinant form `dvd_iff_dvd_det`
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-core
:end-before: ANCHOR_END: flow-div-core
```
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-det-form
:end-before: ANCHOR_END: flow-div-det-form
```
The Lean `dvd_iff` takes the single hypothesis `10 * k + 1 = m * p` and returns
{eq}`eq-div-claim`; `key` is exactly the identity {eq}`eq-div-identity`.
:::

Note that {eq}`eq-div-claim` used nothing about $p$ except that {eq}`eq-div-cert`
has a solution — equivalently, that $\gcd(10,p)=1$. Primality is not needed for
the equivalence itself; it enters only when we guarantee a $k$ exists and is easy
to compute.

:::{dropdown} Lean proof: coprimality is automatic — `isCoprime_ten`
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-coprime
:end-before: ANCHOR_END: flow-div-coprime
```
The certificate $10k+1=mp$ *is* the Bézout witness $(-k)\cdot 10+m\cdot p=1$, so
Lean derives `IsCoprime 10 p` from it directly, with no separate assumption.
:::

(div-finding-k)=
## Finding $k$

We need $k$ with $10k\equiv-1\pmod p$. Since $\gcd(10,p)=1$ exactly when the last
digit of $p$ is $1,3,7,9$, these four cases cover all odd primes except $5$. In
each case there is a small multiplier $m$ with $mp\equiv 1\pmod{10}$ — namely the
inverse of the last digit modulo $10$, using $1\cdot1\equiv3\cdot7\equiv9\cdot9\equiv1$ — and
then $k=\lfloor mp/10\rfloor$, so that $10k+1=mp$ is a multiple of $p$:

| last digit of $p$ | multiplier $m$ | $k$ | certificate $10k+1$ |
| --- | --- | --- | --- |
| $1$ | $1$ | $\lfloor p/10\rfloor$ | $1\cdot p$ |
| $3$ | $7$ | $\lfloor 7p/10\rfloor$ | $7\cdot p$ |
| $7$ | $3$ | $\lfloor 3p/10\rfloor$ | $3\cdot p$ |
| $9$ | $9$ | $\lfloor 9p/10\rfloor$ | $9\cdot p$ |

For example, if $p$ ends in $3$ then $7p$ ends in $1$ (because $7\cdot 3=21$), so
$7p=10\lfloor 7p/10\rfloor+1$; taking $k=\lfloor 7p/10\rfloor$ gives $10k+1=7p$,
a multiple of $p$. The other rows are identical with $7$ replaced by the relevant
multiplier. This is where the earlier example $k=3$ for $p=31$ comes from
($\lfloor 31/10\rfloor=3$), and $k=6$ for $p=61$ ($\lfloor 61/10\rfloor=6$).

:::{dropdown} Lean proof: the four constructions of $k$ — `k_digit_one/three/seven/nine`
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-k-cases
:end-before: ANCHOR_END: flow-div-k-cases
```
Each states the certificate {eq}`eq-div-cert` for the prescribed $k$; `omega`
discharges the floor-division arithmetic.
:::

Feeding each certificate into the core equivalence gives four ready-to-use tests.

:::{dropdown} Lean proof: the four divisibility tests — `test_digit_one/three/seven/nine`
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-tests
:end-before: ANCHOR_END: flow-div-tests
```
For instance, `test_digit_seven` says that for $p$ ending in $7$,
$p\mid 10a+b \iff p\mid a-\lfloor 3p/10\rfloor\,b$.
:::

(div-worked)=
## The worked examples, formalized

The same reductions used above can be run inside Lean. Applying the core
equivalence with the explicit certificate at each step turns the divisibility
question into a chain of equivalences ending in an obvious case.

For $p=37$ (which ends in $7$, so $k=\lfloor 3\cdot 37/10\rfloor=11$) and
$n=3293$, this is Cook's headline example:

```{math}
\begin{vmatrix} 329 & 3 \\ 11 & 1 \end{vmatrix} = 296,\qquad
\begin{vmatrix} 29 & 6 \\ 11 & 1 \end{vmatrix} = 29 - 66 = -37,
```

and $-37$ is divisible by $37$. (The blog writes the last determinant as $37$;
its sign is irrelevant because we only ask about divisibility.)

:::{dropdown} Lean proof: worked reductions — `reduce_2759`, `reduce_3293`, `reduce_75273`
```{literalinclude} math_notes_lean/MathNotesLean/DivisibilityByPrimeFlow.lean
:language: lean
:start-after: ANCHOR: flow-div-example
:end-before: ANCHOR_END: flow-div-example
```
`reduce_2759` reduces $31\mid 2759$ to $31\mid 0$, `reduce_3293` reduces
$37\mid 3293$ to $37\mid -37$, and `reduce_75273` reduces $61\mid 75273$ to
$61\mid 33$ — from which `dvd_2759`, `dvd_3293`, and `not_dvd_75273` read off the
answers.
:::

(div-summary)=
## Summary

To test $n=10a+b$ for divisibility by a prime $p$ ending in $1,3,7,9$: pick $k$
from the table in [Finding $k$](#div-finding-k), replace $n$ by the determinant
$a-kb$, and repeat. The number $n$ is divisible by $p$ if and only if the final
determinant is. The mechanism is the single identity
{eq}`eq-div-identity` together with the fact that $10$ is invertible modulo any
$p$ coprime to $10$, which the last-digit condition guarantees.
