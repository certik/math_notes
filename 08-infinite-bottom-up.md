# Derivation of L, X and P Operators from Commutation Relations

This document provides a bottom-up derivation starting with the commutation
relations of the operators for position $X_i$, momentum $P_i$, and angular
momentum $L_i$. We compute their form, demonstrate their infinite-dimensional
nature, and prove their uniqueness in the Hilbert space $L^2(\mathbb{R}^3)$.

## Commutation Relations

The four fundamental commutation relations are:

1. $[L_i, L_j] = i \hbar \epsilon_{ijk} L_k$
2. $[L_i, X_j] = i \hbar \epsilon_{ijk} X_k$
3. $[L_i, P_j] = i \hbar \epsilon_{ijk} P_k$
4. $[X_i, P_j] = i \hbar \delta_{ij}$

All generators are Hermitian. The relation 1. describes the angular momentum
Lie algebra, relations 2. and 3. indicate that $X_i$ and $P_i$ are vector
operators with repsect to $L_i$. The relation 4. is the canonical commutation
relation for position and momentum.

Here, $\epsilon_{ijk}$ is the Levi-Civita symbol, $\delta_{ij}$ is the Kronecker delta, and $\hbar$ is the reduced Planck constant.

## Infinite-Dimensional Nature of $X_i$ and $P_i$

The operators $X_i$ and $P_i$ must be infinite-dimensional due to the commutation relation $[X_i, P_j] = i \hbar \delta_{ij}$. In a finite-dimensional Hilbert space of dimension $n$, the trace of a commutator $[A, B]$ is zero:

$$\text{Tr}([A, B])
=\text{Tr}(AB-BA)
=\text{Tr}(AB)-\text{Tr}(BA)
=\text{Tr}(AB)-\text{Tr}(AB)
=0\,.
$$
Thus:

- Left side: $\text{Tr}([X_i, P_j]) = 0$.
- Right side: $\text{Tr}(i \hbar \delta_{ij} I) = i \hbar \delta_{ij} n$, which is non-zero for $i = j$ and $n \neq 0$.

This contradiction implies that $n$ cannot be finite; hence, the Hilbert space must be infinite-dimensional, such as $L^2(\mathbb{R}^3)$.

Both $X_i$ and $P_i$ must be infinite-dimensional, and consequently also $L_i$,
otherwise the commutators like $[L_i, X_j]$ would not make sense. All the
generators must be from the same space. When infinite-dimensional space is
needed, the $L^2(\mathbb{R}^3)$ is usually used, so we will use it as well.

## Form of $X_i$ and $P_i$

The Stone-von Neumann theorem says that $X_i$ and $P_i$ are uniquely determined
as below, except a unitary transformation.

In the position representation on $L^2(\mathbb{R}^3)$:

- **Position Operator**: $X_i \psi(x) = x_i \psi(x)$, where $x_i$ is the $i$-th coordinate.
- **Momentum Operator**: $P_i = -i \hbar \frac{\partial}{\partial x_i}$.

To verify:

$$
[X_i, P_j] \psi(x) = X_i P_j \psi(x) - P_j X_i \psi(x) = x_i \left(-i \hbar \frac{\partial \psi}{\partial x_j}\right) - \left(-i \hbar \frac{\partial}{\partial x_j} (x_i \psi)\right)
$$

Using the product rule:

$$
= -i \hbar x_i \frac{\partial \psi}{\partial x_j} + i \hbar \left( \frac{\partial x_i}{\partial x_j} \psi + x_i \frac{\partial \psi}{\partial x_j} \right) = -i \hbar x_i \frac{\partial \psi}{\partial x_j} + i \hbar \delta_{ij} \psi + i \hbar x_i \frac{\partial \psi}{\partial x_j} = i \hbar \delta_{ij} \psi
$$

Thus, $[X_i, P_j] = i \hbar \delta_{ij}$, confirming the forms.

## Unitary Rotation Operator $U$

In a previous chapter we derived for any vector operator (we will use the
vector operator $X_i$):

$$
U X_i U^{-1} = R^j{}_i X_j\,.
$$

Now we can write, using the known properties of $X_i$ derived above:

$$
X_i |x\rangle = x_i |x\rangle\,,
$$
$$
U X_i |x\rangle = U x_i |x\rangle\,,
$$
$$
U X_i |x\rangle = x_i U |x\rangle\,,
$$
$$
R^j{}_i X_j U |x\rangle = x_i U |x\rangle\,,
$$
$$
X_j U |x\rangle = (R^{-1})_j{}^i x_i U |x\rangle\,.
$$

Comparing with $X_i |x'\rangle = x_i' |x'\rangle$ we get
$U |x\rangle=|x'\rangle$ and $x_i' = (R^{-1})_j{}^i x_i$, so:
$$
U |x\rangle=|x'\rangle = | R^{-1} x\rangle\,.
$$

Then we can compute:

$$\langle x | \psi' \rangle
=\psi'(x)
= U\psi(x)
= \langle x | U | \psi' \rangle
= \langle R^{-1} x | \psi' \rangle
= \psi(R^{-1} x)\,.
$$

So we derived:

$$ U\psi(x) = \psi(R^{-1} x)\,. $$

For a rotation by angle $\theta$ around axis $\mathbf{n}$, the unitary operator $U$ is:

$$
U = \exp\left(-\frac{i}{\hbar} \theta n^k L_k\right)
$$

Acting on a wave function:

$$
U \psi(x) = \psi(R^{-1} x)
$$

where $R$ is the rotation matrix, and $R^{-1}$ is its inverse.

## Derivation of $L_i$

Consider an infinitesimal rotation by $\delta \theta$ around $\mathbf{n}$. The rotation matrix approximates as $R_{ij} \approx \delta_{ij} + \delta \theta \epsilon_{ijk} n_k$, and:

$$
R^{-1} x_i \approx x_i - \delta \theta (\mathbf{n} \times \mathbf{x})_i, \quad (\mathbf{n} \times \mathbf{x})_i = \epsilon_{ijk} n_j x_k
$$

Expand $\psi(R^{-1} x)$:

$$
\psi(R^{-1} x) \approx \psi(x) - \delta \theta \epsilon_{ijk} n_j x_k \frac{\partial \psi}{\partial x_i}
$$

For $U$:

$$
U \approx 1 - \frac{i}{\hbar} \delta \theta n_m L_m, \quad U \psi(x) \approx \psi(x) - \frac{i}{\hbar} \delta \theta n_m L_m \psi(x)
$$

Equate:

$$
\psi(x) - \frac{i}{\hbar} \delta \theta n_m L_m \psi = \psi(x) - \delta \theta \epsilon_{ijk} n_j x_k \partial_i \psi
$$

Subtract $\psi(x)$ and simplify:

$$
\frac{i}{\hbar} n_m L_m \psi = \epsilon_{ijk} n_j x_k \partial_i \psi
$$

Since this holds for all $\mathbf{n}$, equate coefficients:

$$
\frac{i}{\hbar} L_i \psi = \epsilon_{ijk} x_k \partial_j \psi
$$

Substitute $P_j = -i \hbar \partial_j$, so $\partial_j \psi = \frac{1}{-i \hbar} P_j \psi = \frac{i}{\hbar} P_j \psi$:

$$
\frac{i}{\hbar} L_i \psi = \epsilon_{ijk} x_k \left( \frac{i}{\hbar} P_j \psi \right) = \frac{i}{\hbar} \epsilon_{ijk} X_k P_j \psi
$$

Multiply by $\frac{\hbar}{i}$:

$$
L_i \psi = \epsilon_{ijk} X_j P_k \psi
$$

Thus, $L_i = \epsilon_{ijk} X_j P_k$.

## Uniqueness of $L_i$

Suppose $L_i'$ also satisfies the commutation relations. Define $D_i = L_i - L_i'$:

- $[D_i, X_j] = [L_i, X_j] - [L_i', X_j] = 0$
- $[D_i, P_j] = [L_i, P_j] - [L_i', P_j] = 0$

$D_i$ commutes with all $X_j$ and $P_j$. In the irreducible representation on $L^2(\mathbb{R}^3)$, Schur’s lemma implies $D_i = c_i I$. Check the algebra:

$$
[L_i, L_j] = [L_i' + D_i, L_j' + D_j] = [L_i', L_j'] = i \hbar \epsilon_{ijk} L_k', \quad [L_i, L_j] = i \hbar \epsilon_{ijk} (L_k' + c_k I)
$$

Thus, $c_k = 0$, so $D_i = 0$, and $L_i = L_i'$.

## Summary

The four commutation relations uniquely determine the generators:

- $X_i = x_i$ (position operator)
- $P_i = -i \hbar \frac{\partial}{\partial x_i}$ (momentum operator)
- $L_i = \epsilon_{ijk} X_j P_k$ (angular momentum operator)
- Acting in the infinite-dimensional Hilbert space $L^2(\mathbb{R}^3)$

No other solution is possible. One can then extend this Hilbert space for
example to also include spin, but in the smallest space $L^2(\mathbb{R}^3)$ the
above solution is unique.

## Group

To determine the group elements, we can define:

$$
T(a) = e^{i {\bf a}\cdot{\bf P}}\,.
$$
That's a translation operator: $T(a)\psi(x) = \psi(x+a)$.
We derived that ${\bf P}$ is a translation generator.

Next we compute from BCH:

$$
e^{i {\bf a}\cdot{\bf X}}
P_j
e^{-i {\bf a}\cdot{\bf X}}
=P_j - a_j
$$

This is a momentum translation element, generated by a momentum translation
generator ${\bf X}$.

Finally:

$$U = \exp\left(-\frac{i}{\hbar} \theta n^k L_k\right)$$

is an operator of rotation, due to $U\psi(x) = \psi(R^{-1} x)$.

## Explicit Example: Rotation Operator Around the Z-Axis

For a rotation by angle $\theta$ around the z-axis, with $\mathbf{n} = (0, 0, 1)$:

### Angular Momentum Operator $L_z$
$$
L_z = -i \hbar \left( x \frac{\partial}{\partial y} - y \frac{\partial}{\partial x} \right)
$$
In cylindrical coordinates: $L_z = -i \hbar \frac{\partial}{\partial \phi}$

### Rotation Operator $U$
$$
U = \exp\left(-\frac{i}{\hbar} \theta L_z\right)
$$
Explicitly:
- Cartesian: $U = \exp\left(-\theta \left( x \frac{\partial}{\partial y} - y \frac{\partial}{\partial x} \right)\right)$
- Cylindrical: $U = \exp\left(-\theta \frac{\partial}{\partial \phi}\right)$

### Action on Wave Function
$$
(U \psi)(x, y, z) = \psi(x \cos \theta + y \sin \theta, -x \sin \theta + y \cos \theta, z)
$$
$$
(U \psi)(\rho, \phi, z) = \psi(\rho, \phi - \theta, z)
$$

Matches $\psi(R^{-1} \mathbf{x})$, where:
$$
R = \begin{pmatrix} \cos \theta & -\sin \theta & 0 \\ \sin \theta & \cos \theta & 0 \\ 0 & 0 & 1 \end{pmatrix}
$$
