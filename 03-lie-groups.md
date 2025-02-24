---
date: 2025-02-23
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
# Lie Groups

## Summary

Main properties:

* SO(3) Group -> so(3) algebra <=> SU(2) simply connected lie group (unique).
* Find extensions to non-simply connected SO(3). 
* Add discrete group to create a group of disconnected parts O(3) = Z_2 x SO(3). Probably can be extended in many other groups.

Galilei, generators show matrices. 

Lorentz, generators, matrices:
4 disconnected parts.

## Galilean Group

The homogeneous Galilean group is:

$$
\begin{pmatrix}
t' \\
\mathbf{r}'
\end{pmatrix}
=
\begin{pmatrix}
1 & 0 \\
\mathbf{v} & R
\end{pmatrix}
\begin{pmatrix}
t \\
\mathbf{r}
\end{pmatrix}
$$

The two coordinate systems have the same spatial and temporal origin
(the point $t=0$, $\mathbf{r}=0$ is the same as $t'=0$, $\mathbf{r}'=0$), but
can be rotated with the rotation $R$. This homogeneous Galilean group
corresponds to the Lorentz group. The full Galilean group then also adds
spatial and temporal translations (and it corresponds to the Poincaré group),
but those cannot be expressed as 4x4 matrices. Expanding the equations out we
get:
$$
t' = t\,,
$$
$$
\mathbf{r}' = \mathbf{v} t + R \mathbf{r}\,.
$$
These equations connect two inertial systems that are moving with respect to
each other with velocity $\mathbf{v}$ (but share the coordinate origin).

The homogeneous Galilean group is a Lie group and can be expressed using
generators as follows:

$$
\label{Gexp1}
\begin{pmatrix}
1 & 0 \\
\mathbf{v} & R
\end{pmatrix}
= e^{\phi_1 J_1 + \phi_2 J_2 + \phi_3 J_3 + v_1 K_1 + v_2 K_2 + v_3 K_3}
$$

Where the 6 parameters of the Lie group are the three rotation angles for the
rotation matrix R: 
$(\phi_1, \phi_2, \phi_3)$ and the components of the velocity
$\mathbf{v}=(v_1, v_2, v_3)$. The corresponding 6 generators are:
$$
J_1 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & -1 \\
0 & 0 & 1 & 0
\end{pmatrix}, \quad
J_2 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 \\
0 & -1 & 0 & 0
\end{pmatrix}, \quad
J_3 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & -1 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
$$
$$
K_1 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}, \quad
K_2 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}, \quad
K_3 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0
\end{pmatrix}
$$

They satisfy the following commutation relations, the Lie algebra of the
Galilean group:

$$
\label{Gcommut}
[J_i, J_j] = \epsilon_{ijk} J_k, \quad [J_i, K_j] = \epsilon_{ijk} K_k, \quad [K_i, K_j] = 0
$$

The $J_i$ are generators of rotations, and $K_i$ are Galilean boosts.

Let's compute the exponential in [](Gexp1):
$$
e^{\phi_1 J_1 + \phi_2 J_2 + \phi_3 J_3 + v_1 K_1 + v_2 K_2 + v_3 K_3}
=...
$$

This transformation leaves invariant both the spatial
metric $\mathrm{diag}(0,1,1,1)$ and the independent dual temporal metric
$\mathrm{diag}(1,0,0,0)$. This can be computed. The Lorentz/Poincaré group
leaves the Minkowski metric invariant and that can also be computed.
Furthermore, from the metric one can derive the transformation also.

The commutation relations [](Gcommut) allow many representations of the
Galilean group.

We postulated the Galilean transformations above. But rather we actually want
to derive them from the principle of relativity. We start with $A(u)A(v)=A(w)$
and show that the transformations must for a Lie group. Then we derive all
possible groups from assuming isotropy of space. About 11+ groups. Then we
impose further conditions, for example homogeneity. Then we get just Galilean,
Lorentz O(3,1) and rotations O(4). Separately we use compactness in time, that
gets rid of O(4).

So we get Galilean and Lorentz, and we compute what metrics they satisfy, and
derive them back from the metric, thus showing that the corresponding metric is
equivalent to them.

It's instructive to keep O(4), since metric can be done ($\mathrm{diag}(1,1,1,1)$) and it's good to write the Lie algebra, and keep calling the corresponding rotations as boosts. I think just the $[K_i, K_j] = 0$ is replaced by
$[K_i, K_j] = \epsilon_{ijk} K_k$, but let's check everything. For Lorentz it
is replaced by $[K_i, K_j] = -\epsilon_{ijk} J_k$.

Also write this done in 1+1 space time, the groups must still differ, but it's
not clear right now how in the Lie algebra, since there is only one boost.

Now go over our derivation from the principle of relativity, side-by-side the
possible kinematic groups paper. Write down both derivations side-by-side.
Maybe the difficulty is in showing that it is a Lie group, or in going from the
Lie algebra back to the group. When working with the generators it seems there
are just a few options how they can be written, it seems simpler than our
derivation, let's understand if we are missing anything, or it is just the Lie
groups machinery which is superior.

Either way, the logic is:

* Principle of relativity
* Few other assumptions like: isotropy, compactness/causality, homogeneity
* Only two groups remain
* Compute the metric that they keep invariant; show it is equivalent;
* Inertial frames are thus such frames that have this invariant metric.
* We formulate the theory to work in any metric (any reference
  frame/coordinates), "covariant". Locally one can always transform to the
  local inertial frame.

All physics can be formulated to be invariant to the Galilean group, including
electromagnetism, but it's more complex and not unique, and quantum mechanics
(Schroedinger equation), and gravity (Newton-Cartan).

Can the metric change from inertial to inertial system? Answer: as long as the
Galilean or Lorentz transformation leaves it invariant, then yes, otherwise no.
Usually in the derivations we assume the same metric in both systems. Can we
change, say, the signature of the metric? Let's write the Lorentz
transformation for it and an example. But it seems the metric is only useful if
it is exactly the same metric for both.
