---
date: 2025-01-15
authors:
  - name: Ondřej Čertík
exports:
  - format: docx
  - format: pdf
  - format: tex
  - format: typst
bibliography:
  - references.bib
---
# Determinant

## Multiplicative Property

In this section we assume the usual definition of a determinant, from which one
can derive the following properties that we will need:
$$
\det \mathrm{diag}(d_1, d_2, \dots, d_n)=d_1 d_2 \dots d_n\,,
$$
$$
\det AB = \det A \det B\,,
$$
$$
\det \lambda A = \lambda^n \det A\,.
$$

Now our task is to find all functions $f(A)$ from matrices to real numbers 
that satisfy the multiplicative property:
$$
\label{multiplicative1}
f(AB) = f(A)f(B)\,.
$$
We will use [](#multiplicative1) repeatedly in the following calculation. For
now we will make an assumption that the matrix $A$ can be written as $A=P D
P^{-1}$ where $D$ is diagonal. Later we will try to generalize it for any
matrix $A$ using a Jordan form. We will also need matrices $P_i$ that are unit
matrices with the 1st and $i$-th rows permuted. Now we can compute:
$$
f(A)
= f(P D P^{-1})
= f(P) f(D) f(P^{-1})
= f(P) f(P^{-1}) f(D)=
$$
$$
= f(P P^{-1} D)
= f(D)=
$$
$$
= f(\mathrm{diag}(d_1,1,1,\dots))
f(\mathrm{diag}(1,d_2,1,\dots))
\dots
f(\mathrm{diag}(1,\dots,1,d_n))=
$$
$$
= f(P_1\mathrm{diag}(d_1,1,1,\dots)P_1^{-1})
f(P_2\mathrm{diag}(d_2,1,1,\dots)P_2^{-1})
\dots
$$
$$
\dots f(P_n\mathrm{diag}(d_n,1,1,\dots)P_n^{-1})=
$$
$$
= f(\mathrm{diag}(d_1,1,1,\dots)
\mathrm{diag}(d_2,1,1,\dots)
\dots
\mathrm{diag}(d_n,1,1,\dots))=
$$
$$
= f(\mathrm{diag}(d_1 d_2 \dots d_n,1,1,\dots))=
$$
$$
= f(\mathrm{diag}(\det D,1,1,\dots))=
$$
$$
= g(\det D)= g(\det P D P^{-1}) = g(\det A)\,,
$$
where we defined a function $g(x)$ using
$$
g(x) = f(\mathrm{diag}(x,1,1,\dots))\,.
$$
Let's compute the functional equation for $g(x)$:
$$
g(x y) = f(\mathrm{diag}(xy,1,1,\dots))=
$$
$$
=f(\mathrm{diag}(x,1,1,\dots)\mathrm{diag}(y,1,1,\dots))=
$$
$$
=f(\mathrm{diag}(x,1,1,\dots)) f(\mathrm{diag}(y,1,1,\dots))=
$$
$$
=g(x) g(y)\,.
$$
In the above computations we have only used [](#multiplicative1) and no other
assumptions.

Let's summarize our results. From [](#multiplicative1) it follows that:
$$
\label{multiplicative1_result}
f(A) = g(\det A)\,,
$$
$$
\label{multiplicative2}
g(xy) = g(x)g(y)\,,
$$
for numbers $x$, $y$.

The equation [](#multiplicative2) can be solved in several different ways.

Approach 1: With some extra smoothness assumptions one can show that the only
solutions are $g(x)=0$, $g(x)=x^s$ and $g(x)=|x|^s$. Consequently the only
nonzero solution to [](#multiplicative1) is a power of a determinant.

Approach 2: Instead of assuming some smoothness assumptions, we can instead
assume homogeneity:
$$
\label{homogeneity}
f(\lambda A) = \lambda^n f(A)
$$
Using [](#multiplicative1_result) and [](#multiplicative2) we get:
$$
f(\lambda A) = g(\det \lambda A)
=g(\lambda^n \det A)
=g(\lambda^n) g(\det A)
=g(\lambda^n) f(A)
$$
Comparing to [](#homogeneity) we get:
$$
\label{glambda}
g(\lambda^n)=\lambda^n\,.
$$
Since $\lambda$ can be any real (or complex) number, we get:
$$
g(x)=x
$$
and from [](#multiplicative1_result) we get:
$$
\label{multiplicative1_result2}
f(A) = \det A\,.
$$

Summary: assuming equations [](#multiplicative1) and [](#homogeneity) we
obtained [](#multiplicative1_result2) as the only nonzero solution. That means
that we can define a determinant using [](#multiplicative1) and [](#homogeneity) and no other assumptions.

:::{warning} TODO
The transition from $\lambda^n$ to $x$ in [](#glambda) might require better
treatment, there might be some hidden assumptions about continuity on $g(x)$.
Maybe there is a way to derive $g(x) = x$ more directly.
:::

:::{warning} TODO
We assumed that the matrix $A$ is diagonalizable. Remove this assumption by
using Jordan form.
:::
