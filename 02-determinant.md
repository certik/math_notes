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
We will use [](#multiplicative1) repeatedly in the following calculation. First
we decompose the matrix $A=HU$ using a polar decomposition, where $H$ is
Hermitian and $U$ is unitary. Both $H$ and $U$ are individually diagonalizable
(but not mutually diagonalizable, since $A$ is not in general diagonalizable).
For any matrix $C$ that is diagonalizable, we can write
$C=P D P^{-1}$ where $D$ is diagonal and $P$ is invertible. Then:
$$
f(C)
= f(P D P^{-1})
= f(P) f(D) f(P^{-1})
= f(P) f(P^{-1}) f(D)=
$$
$$
= f(P P^{-1} D)
= f(D)\,.
$$
That means that if a matrix is diagonalizable, then $f$ applied to that matrix
is equal to $f$ applied to the diagonal matrix.

Below we will use matrices $P_i$ that are unit
matrices with the 1st and $i$-th rows permuted. Now we can compute, using the
fact that $H$ and $U$ can be decomposed into diagonal matrices $D_H$ and $D_U$,
and their product is also a diagonal matrix $D=D_H D_U$:
$$
f(A)
= f(HU)
= f(H)f(U)
= f(D_H)f(D_U)
= f(D_H D_U)
= f(D) =
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
= g(\det D)= g(\det D_H D_U)
= g(\det D_H \det D_U)= g(\det H \det U) =
$$
$$
=g(\det HU) = g(\det A)\,,
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

Approach 1: Assuming that $f(A)$ (and thus $g(x)$) is measurable, we show below
that the only solutions are $g(x)=0$, $g(x)=|\mathrm{sign}(x)|$, $g(x)=|x|^s$
and $g(x)=\mathrm{sign}(x)|x|^s$. Consequently the only nonzero solution to
[](#multiplicative1) is a power of a determinant (optionally multiplied with
the signum function). If $f(A)$ is not measurable then we also get highly
pathological solutions (see the section below). The above is thus the most
general solution.

Approach 2: Instead of assuming measurability, we can instead
assume homogeneity:
$$
\label{homogeneity}
f(\lambda A) = \lambda^n f(A)\,,
$$
where $n$ is the (integer) dimension of the matrix $A$.
Using [](#multiplicative1_result) and [](#multiplicative2) we get:
$$
f(\lambda A) = g(\det \lambda A)
=g(\lambda^n \det A)
=g(\lambda^n) g(\det A)
=g(\lambda^n) f(A)\,.
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

Summary:
* Assuming equations [](#multiplicative1) and [](#homogeneity) we obtained
  [](#multiplicative1_result2) as the only nonzero solution. That means that we
  can define a determinant using [](#multiplicative1) and [](#homogeneity) and
  no other assumptions.
* Alternatively, if we only assume [](#multiplicative1) and that $f(A)$ is
  measurable, then the only nonzero solution is a power of a determinant
  (optionally multiplied with the signum function).

:::{warning} TODO
The transition from $\lambda^n$ to $x$ in [](#glambda) might require better
treatment, there might be some hidden assumptions about continuity on $g(x)$.
Maybe there is a way to derive $g(x) = x$ more directly.
We can maybe use $g(\lambda^n) = g(\lambda)^n = \lambda^n$.
For $n=2$, we get: $g(\lambda)^2 = \lambda^2$, which also has a solution
$g(x)=|x|$. But if we allow $\lambda$ to be complex, then likely the only
solution is $g(x)=x$ without any additional assumptions.
:::

## Cauchy's Additive Functional Equation

The Cauchy's functional equation (@wiki:CauchyFunctionalEquation) usually means
the additive equation of this form:
$$
\label{additive}
f(x+y) = f(x) + f(y)\,.
$$
There are other related equations, such as the Cauchy's multiplicative
functional equation in the next section.

For integer $n$ we get:
$$
f(nx)
= f(\underbrace{x+x+\dots+x}_{n})
= \underbrace{f(x)+f(x)+\dots+f(x)}_{n}
= nf(x)\,.
$$
By substituting $y=nx$ we get $f(y)=nf(y/n)$, from which
$f(y/n)=(1/n)f(y)$. Using these two relations for multiplication and division
by an integer we obtain for any rational number $q={p\over q}$, where $p$, $q$
are integers:
$$
f(qx)
=f\left({p \over q}x\right)
=pf\left({x\over q}\right)
={p\over q}f(x)
=q f(x)
\,.
$$
We also have to prove it for $p\le 0$ which we can using $f(0)=f(0)+f(0)$ which
implies $f(0)=0$ and using $0=f(0)=f(x-x)=f(x)+f(-x)$ from which follows
$f(-x)=-f(x)$. Setting $x=1$ we get for all rational $q$:
$$
f(q) = q f(1) = c q\,.
$$
where $c=f(1)$ is any real constant. If we assume that $f(x)$ is continuous,
then this implies that $f(x)=c x$ for all real $x$, since the rational numbers
are dense in real numbers. It turns out that one can relax the continuity
requirement to only require that $f(x)$ is measurable. Since $f(x)=c x$ is
linear, we get:

:::{tip} Theorem
Additive, measurable functions are linear.
:::

A linear function $f(x)=ax+b$ can be substituted into [](#additive) and one
obtains that $b=0$. So this theorem is a simple way to remember the solutions
to the Cauchy's additive functional equation.

:::{note} Proof
To prove this theorem, we introduce $g(x)=f(x)-f(1)x$ and prove that $g(x)=0$,
from which it follows that $f(x)=f(1)x=c x$. We have:
$$
g(x+y)=f(x+y)-f(1)(x+y)=f(x)-f(1)x + f(y)-f(1)y = g(x)+g(y)\,,
$$
so $g(x)$ is also additive. For rational $q$ we have:
$$
g(q)=f(q)-f(1)q=q f(1) - f(1)q = 0\,.
$$
Also we get:
$$
g(x+q)=g(x)+g(q)=g(x)\,,
$$
so $g(x)$ is periodic with a period $q$. It can be shown from this periodicity
and function $g(x)$ being measurable that $g(x)$ is essentially bounded. Now we
can compute the following integral which is exists and is finite:
$$
\int_0^1 g(x) dx
=\int_0^1 g(x+y) dx
=\int_0^1 g(x) dx +\int_0^1 g(y) dx
=\int_0^1 g(x) dx +g(y)\,,
$$
so $g(y)=0$ for all real $y$. Here we have used the dominated convergence
theorem for $g(x)=g(x+q_n)$ where a sequence of rational $q_n$ is converging
towards the real $y$.
:::

:::{note}
If we do not require a measurable function, then there are infinitely many
solutions to [](#additive) that are nonlinear and their graphs are dense. They
are highly pathological functions and these solutions are all excluded by
requiring that $f(x)$ is measurable.
:::

## Cauchy's Multiplicative Functional Equation

The Cauchy's multiplicative functional equation is:
$$
f(xy) = f(x)f(y)\,.
$$
There are only 3 cases that can happen:
* $f(x) = 0\,.$
* $f(x) = 1\,.$
* $f(x) = \begin{cases}
        h(x) & \text{if } x > 0\,,\\
        0 & \text{if } x = 0\,,\\
        \pm h(|x|) & \text{if } x < 0\,.\\
    \end{cases} $

In the last case the function $h(x)$ is positive $h(x) > 0$ and defined only
for $x>0$. The $x < 0$ case has two options for even and odd $f(x)$. We can
equivalently write the two cases explicitly as follows:

* Even: $f(x) = \begin{cases}
        0 & \text{if } x = 0\,,\\
        h(|x|) & \text{if } x \ne 0\,.\\
    \end{cases} $
* Odd: $f(x) = \begin{cases}
        0 & \text{if } x = 0\,,\\
        \mathrm{sign}(x) h(|x|) & \text{if } x \ne 0\,.\\
    \end{cases} $

As a special case for $h(x)=1$ we get:

* Even: $f(x) = |\mathrm{sign}(x)| = \begin{cases}
        0 & \text{if } x = 0\,,\\
        1 & \text{if } x \ne 0\,.
    \end{cases} $
* Odd: $f(x) = \mathrm{sign}(x) = \begin{cases}
        0 & \text{if } x = 0\,,\\
        1 & \text{if } x > 0\,,\\
        -1 & \text{if } x < 0\,.
    \end{cases} $

We can then use the substitution $g(x)=\log f(e^x)$ to convert
the multiplicative equation into an additive equation from the previous
section:
$$
g(x+y)
= \log f(e^{x+y})
= \log f(e^x e^y)
= \log(f(e^x) f(e^y))=
$$
$$
= \log f(e^x) + \log f(e^y)
= g(x) + g(y)\,.
$$
We find the solution using the previous section, and then
we compute $h(x)$ using $h(x)=\exp(g(\log x))$, which satisfies:
$$
h(xy)
=\exp(g(\log(xy)))
=\exp(g(\log x + \log y))
=\exp(g(\log x) + g(\log y))=
$$
$$
=\exp(g(\log x))\exp(g(\log y))
=h(x)h(y)\,.
$$

For measurable $g(x)$ the solution to the additive equation is $g(x) = cx$, so
we assume $f(x)$ is measurable (which implies $g(x)$ is measurable) and
we get $h(x)=\exp(c\log x)=\exp(\log(x^c))=x^c$ and the four solutions are
* $f(x) = 0\,.$
* $f(x) = 1\,.$
* $f(x) = \begin{cases}
        0 & \text{if } x = 0\,,\\
        h(|x|) & \text{if } x \ne 0\,,\\
    \end{cases}
  = \begin{cases}
        0 & \text{if } x = 0\,,\\
        |x|^c & \text{if } x \ne 0\,.\\
    \end{cases} $
* $f(x) = \begin{cases}
        0 & \text{if } x = 0\,,\\
        \mathrm{sign}(x) h(|x|) & \text{if } x \ne 0\,,\\
    \end{cases}
  = \begin{cases}
        0 & \text{if } x = 0\,,\\
        \mathrm{sign}(x) |x|^c & \text{if } x \ne 0\,.\\
    \end{cases} $

The solutions can be equivalently written as:
* $f(x)=0\,.$
* $f(x) = |\mathrm{sign}(x)| = \begin{cases}
        0 & \text{if } x = 0\,,\\
        1 & \text{if } x \ne 0\,.
    \end{cases}$
* $f(x)=|x|^c$, with $f(0)=0$ (needed for $c < 0)$.
* $f(x)=\mathrm{sign}(x)|x|^c$, with $f(0)=0$ (needed for $c < 0)$.

The solution $f(x)=1$ is already included in $|x|^c$ for $c=0$.
If $c$ is an integer, then the last two solutions can always be written (for
both even and odd integers) as $f(x)=x^c$ and $f(x)=\mathrm{sign}(x) x^c$.

Some examples are: $0$, $1$, $\mathrm{sign}(x)$, $|\mathrm{sign}(x)|$, $x$,
$|x|$, $x^2$, $\mathrm{sign}(x) x^2$, $x^3$, $|x|^3$, $1\over x$, $1\over
|x|$,$1\over x^2$,${\mathrm{sign}(x)\over x^2}={|x|\over x^3}$, $1\over x^3$,
$\sqrt{|x|}$, $1\over\sqrt{|x|^3}$, etc.

:::{note}
The function $h(x)$ is only defined for positive $x$ and that is all we need.
But if we are curious how the formula evaluates for $x \le 0$, we get the
following.
For $c>0$ and $x=0^+$ we get:
$$
h(x)=\exp(c \log 0^+)=\exp(-c\,\infty)=0\,.
$$
For $x<0$ we get:
$$
h(x)
=\exp(c (\log |x| + i \arg x))
=\exp(c (\log(-x) + i \pi))=
$$
$$
=\exp(\log((-x)^c))\exp(i c \pi)
=(-x)^c \exp(i c \pi)\,.
$$
For an even integer $c$ we have $\exp(ic\pi)=1$ and $h(x)=(-x)^c=x^c$, for an
odd integer $c$ we have $\exp(ic\pi)=-1$ and $h(x)=-(-x)^c=x^c$ and for
non-integer $c$ we get some complex number. For example, for $c=1$ (which is an
odd integer) we get:
$$
h(x) = (-x) (-1) = x\,.
$$

Due to the discontinuity at $x=0$, we can stitch solutions there, and extend
$h(x)$ as even or odd functions.
:::
