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

and define a matrix function $f(t)$ by:

$$ f(t) = \mathrm{Ad}_{e^{tX}}(Y) = e^{tX} Y e^{-tX}\,. $$

Differentiate $f(t)$:

$$
f'(t) = {d\over d t} \mathrm{Ad}_{e^{tX}}(Y)
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

We apply it recursively for the second derivative:

$$
f''(t) = {d^2\over d t^2} \mathrm{Ad}_{e^{tX}}(Y)
= {d^2\over d t^2} e^{tX} Y e^{-tX} =
$$

$$
= {d\over d t} e^{tX} [X, Y] e^{-tX} =
$$

$$
= e^{tX} [X, [X, Y]] e^{-tX}\,. 
$$

We evaluate these derivatives at $t=0$:
$$
f(0)=Y\,,
$$
$$
f'(0)=[X, Y]\,,
$$
$$
f''(0)=[X, [X, Y]]\,.
$$

We expand $f(h)$ using a Taylor series:

$$
f(h)= f(0)
+ {1\over 1!}f'(0) h
+ {1\over 2!}f''(0) h^2
+ {1\over 3!}f'''(0) h^3
+ \cdots
$$
and we get:

$$
f(h) = e^{hX} Y e^{-hX} = Y
+ {1\over 1!} [X,Y] h
+ {1\over 2!} [X,[X,Y]] h^2
+ {1\over 3!} [X,[X,[X,Y]]] h^3
+ \cdots
$$

We can set $h=1$:

$$
f(1) = e^{X} Y e^{-X} = Y
+ {1\over 1!} [X,Y]
+ {1\over 2!} [X,[X,Y]]
+ {1\over 3!} [X,[X,[X,Y]]]
+ \cdots
$$

## Old Notes

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

$$
= e^{tX} Y e^{-tX} t^0
+ {1\over 1!}{d \over dt} e^{tX} Y e^{-tX} t^1
+ {1\over 2!}{d^2 \over dt^2} e^{tX} Y e^{-tX} t^2
+ {1\over 3!}{d^3 \over dt^3} e^{tX} Y e^{-tX} t^3
+ \cdots |_{t=0} =
$$

$$
= \exp(e^{tX} Y e^{-tX} +t) |_{t=0}
$$
