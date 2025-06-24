# Derivation of the Galilei Group


## Commutation Relations

The four fundamental commutation relations for L, X, P from the previous
section are:

1. $[L_i, L_j] = i \hbar \epsilon_{ijk} L_k$
2. $[L_i, X_j] = i \hbar \epsilon_{ijk} X_k$
3. $[L_i, P_j] = i \hbar \epsilon_{ijk} P_k$
4. $[X_i, P_j] = i \hbar \delta_{ij}$

We first add the zero commutators for P and X, it is interesting that they were
not needed before:

5. $[X_i, X_j] = 0$
6. $[P_i, P_j] = 0$

Now we add a generator of time translation $H$:

7. $[H, L_i] = 0$
8. $[H, X_i] = 0$
9. $[H, P_i] = ?/m$

Finally we introduce $M$, a central element that commutes with every other
element:

10. $[M, H] = 0$, $[M, L_i] = 0$, $[H, X_i] = 0$ and $[M, P_i] = 0$

Then we introduce the innertial transformation generator:

$$
K_i = mx_i - tP_i
$$

Now we compute commutation relations for $K_i$. By doing so we derive the
Galileian Algebra.

We can also go from Galileian algebra back to the above algebra.
