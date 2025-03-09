---
date: 2025-03-09
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
# Lie Groups II

## Adjoint Representation

We define $\mathrm{Ad}_{X}(Y)$ by:

$$ \mathrm{Ad}_{X}(Y) = X Y X^{-1} $$

and compute:

$$ \mathrm{Ad}_{e^{tX}}(Y) = e^{tX} Y e^{-tX} $$

Differentiate:

$$
{d\over d t} \mathrm{Ad}_{e^{tX}}(Y)
= {d\over d t} e^{tX} Y e^{-tX} =
$$

$$
= X e^{tX} Y e^{-tX} - e^{tX} Y X e^{-tX} =
$$

$$
= e^{tX} X Y e^{-tX} - e^{tX} Y X e^{-tX} =
$$

$$
= e^{tX} (XY - YX) e^{-tX} =
$$

$$
= e^{tX} [X, Y] e^{-tX}\,.
$$

Now we apply it recursively for the second derivative:

$$
{d^2\over d t^2} \mathrm{Ad}_{e^{tX}}(Y)
= {d^2\over d t^2} e^{tX} Y e^{-tX} =
$$

$$
= {d\over d t} e^{tX} [X, Y] e^{-tX} =
$$

$$
= e^{tX} [X, [X, Y]] e^{-tX}\,. 
$$

Now we can compute:

$$
\mathrm{Ad}_{e^{X}}(Y)
= e^{X} Y e^{-X} =
$$

Not quite:

$$
= \exp(e^{tX} Y e^{-tX}) |_{t=1}
$$

Let's start from the RHS:

$$
Y + [X, Y] + {1\over 2!}[X, [X, Y]] + {1\over 3!}[X, [X, [X, Y]]] + \cdots =
$$

$$
= e^{tX} \left(Y + [X, Y] + {1\over 2!}[X, [X, Y]] + {1\over 3!}[X, [X, [X, Y]]] + \cdots\right) e^{-tX} |_{t=0} =
$$

$$
= e^{tX} Y e^{-tX}
+ {d \over dt} e^{tX} Y e^{-tX}
+ {1\over 2!}{d^2 \over dt^2} e^{tX} Y e^{-tX}
+ {1\over 3!}{d^3 \over dt^3} e^{tX} Y e^{-tX}
+ \cdots |_{t=0} =
$$
