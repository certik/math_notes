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

We expand $f(t)$ using a Taylor series around the point $t=0$:

$$
f(t)= f(0)
+ {1\over 1!}f'(0) t
+ {1\over 2!}f''(0) t^2
+ {1\over 3!}f'''(0) t^3
+ \cdots
$$
and we get:

$$
f(t) = e^{tX} Y e^{-tX} = Y
+ {1\over 1!} [X,Y] t
+ {1\over 2!} [X,[X,Y]] t^2
+ {1\over 3!} [X,[X,[X,Y]]] t^3
+ \cdots
$$

We can set $t=1$:

$$
f(1) = e^{X} Y e^{-X} = Y
+ {1\over 1!} [X,Y]
+ {1\over 2!} [X,[X,Y]]
+ {1\over 3!} [X,[X,[X,Y]]]
+ \cdots
$$
