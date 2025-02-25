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

Let's compute the exponential in [](#Gexp1):
$$
e^{\phi_1 J_1 + \phi_2 J_2 + \phi_3 J_3 + v_1 K_1 + v_2 K_2 + v_3 K_3}
=...
$$

This transformation leaves invariant both the spatial
metric $\mathrm{diag}(0,1,1,1)$ and the independent dual temporal metric
$\mathrm{diag}(1,0,0,0)$. This can be computed. The Lorentz/Poincaré group
leaves the Minkowski metric invariant and that can also be computed.
Furthermore, from the metric one can derive the transformation also.

The commutation relations [](#Gcommut) allow many representations of the
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

### Galilean and Lorentz Groups in 1+1 Dimensions

To gain further insight into the properties of the Galilean and Lorentz groups, it is instructive to consider them in 1+1 dimensions, where the spatial dimension is reduced to one. In this simplified setting, we can more easily compare their structures and understand how they act on space-time, providing a foundation for understanding their behavior in higher dimensions.

The homogeneous Lorentz group in 1+1 dimensions is SO(1,1), which consists of
transformations that preserve the Minkowski metric $\text{diag}(-1,1)$. A general element of SO(1,1) can be written as:

$$
A = \begin{pmatrix} \cosh \eta & \sinh \eta \\ \sinh \eta & \cosh \eta \end{pmatrix}
$$

where $\eta$ is the rapidity parameter. This represents a hyperbolic rotation, or a boost, in 1+1 dimensions.

On the other hand, the homogeneous Galilean group in 1+1 dimensions consists of transformations of the form:

$$
A = \begin{pmatrix} 1 & 0 \\ v & 1 \end{pmatrix}
$$

where $v$ is the relative velocity between two inertial frames. This transformation corresponds to a Galilean boost.

Interestingly, both groups have a single generator for boosts, and their Lie
algebras share the same commutation relation. Specifically, for both groups,
the boost generator $K$ satisfies:

$$
[K, K] = 0
$$

since there is only one generator, and any element commutes with itself. Thus, the Lie algebras are Abelian.

For the Lorentz group SO(1,1), the generator can be taken as:

$$
K_{\text{Lorentz}} = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}
$$

and for the Galilean group:

$$
K_{\text{Gal}} = \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}
$$

Both generators satisfy $[K, K] = 0$, but they are distinct matrices and lead to different group actions.

Exponentiating these generators, we obtain the group elements:

For the Lorentz group:

$$
\exp(\eta K_{\text{Lorentz}}) = \begin{pmatrix} \cosh \eta & \sinh \eta \\ \sinh \eta & \cosh \eta \end{pmatrix}
$$

For the Galilean group:

$$
\exp(v K_{\text{Gal}}) = \begin{pmatrix} 1 & 0 \\ v & 1 \end{pmatrix}
$$

These exponentials show that the Lorentz group acts hyperbolically, while the Galilean group acts linearly.

Despite having isomorphic Lie algebras (both are isomorphic to $\mathbb{R}$,
the one-dimensional Abelian Lie algebra), the groups themselves are isomorphic
as well, since they are both simply connected and isomorphic to $\mathbb{R}$. However, their actions on space-time are fundamentally different, as evidenced by the distinct forms of their group elements and the metrics they preserve.

To see this difference explicitly, we can determine the metrics preserved by
each group. A group $G$ preserves a bilinear form $B$ if:

$$
g^T B g = B \quad \text{for all } g \in G
$$

Equivalently, for the Lie algebra, the generators $K$ must satisfy:

$$
K^T B + B K = 0
$$

Let us solve this condition for both groups.

#### Lorentz Group

For $K_{\text{Lorentz}} = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}$, and
assuming $B = \begin{pmatrix} a & b \\ b & c \end{pmatrix}$, the condition becomes:

$$
\begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} \begin{pmatrix} a & b \\ b & c \end{pmatrix} + \begin{pmatrix} a & b \\ b & c \end{pmatrix} \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}
$$

Computing the left-hand side:

$$
\begin{pmatrix} b & c \\ a & b \end{pmatrix} + \begin{pmatrix} b & a \\ c & b \end{pmatrix} = \begin{pmatrix} 2b & c + a \\ a + c & 2b \end{pmatrix} = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}
$$

Thus, we have:

$$
2b = 0 \implies b = 0
$$

$$
c + a = 0 \implies c = -a
$$

So, $B = \begin{pmatrix} a & 0 \\ 0 & -a \end{pmatrix}$, which is proportional
to the Minkowski metric $\text{diag}(1, -1)$ or $\text{diag}(-1, 1)$,
depending on the sign of $a$. This is a non-degenerate metric, with
determinant $\det B = -a^2$ (assuming $a \neq 0$).

#### Galilean Group

For $K_{\text{Gal}} = \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}$, and again
$B = \begin{pmatrix} a & b \\ b & c \end{pmatrix}$, the condition is:

$$
\begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix} \begin{pmatrix} a & b \\ b & c \end{pmatrix} + \begin{pmatrix} a & b \\ b & c \end{pmatrix} \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix} = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}
$$

Since $K_{\text{Gal}}^T = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix}$, we have:

$$
\begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix} \begin{pmatrix} a & b \\ b & c \end{pmatrix} = \begin{pmatrix} b & c \\ 0 & 0 \end{pmatrix}, \quad \begin{pmatrix} a & b \\ b & c \end{pmatrix} \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix} = \begin{pmatrix} b & 0 \\ c & 0 \end{pmatrix}
$$

Thus,

$$
\begin{pmatrix} b & c \\ 0 & 0 \end{pmatrix} + \begin{pmatrix} b & 0 \\ c & 0 \end{pmatrix} = \begin{pmatrix} 2b & c \\ c & 0 \end{pmatrix} = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}
$$

So,

$$
2b = 0 \implies b = 0
$$

$$
c = 0
$$

Therefore, $B = \begin{pmatrix} a & 0 \\ 0 & 0 \end{pmatrix}$, which is
degenerate, with determinant $\det B = 0$.

Hence, the Galilean group preserves a degenerate bilinear form, specifically
the temporal metric $\text{diag}(1,0)$, while the Lorentz group preserves a
non-degenerate metric $\text{diag}(1,-1)$.

This illustrates that even though the Lie algebras are isomorphic, the specific representations of the groups on space-time lead to different invariant structures. In the case of the Lorentz group, it preserves a non-degenerate metric, which defines the causal structure of special relativity. For the Galilean group, the invariant structure is degenerate, reflecting the absolute time in Newtonian physics.

Furthermore, in 1+1 dimensions, both groups are simply connected and isomorphic
to $\mathbb{R}$, but their actions are distinct. This distinction becomes more pronounced in higher dimensions, where the Lie algebras themselves differ, as seen in the 3+1 dimensional case discussed earlier.

It is also worth noting that these groups can be extended by including discrete transformations, such as time reversal or space inversion, leading to disconnected groups like O(1,1) for the Lorentz group, which includes both proper and improper transformations.

In summary, while the Lie algebras of the homogeneous Galilean and Lorentz groups in 1+1 dimensions are isomorphic, their representations and the structures they preserve on space-time are fundamentally different, highlighting the distinct physical theories they underlie.

#### Connection to Higher Dimensions

In higher dimensions, such as 3+1, the Lie algebras of the Galilean and Lorentz
groups differ. For the Lorentz group SO(3,1), the commutation relations include
$[K_i, K_j] = -\epsilon_{ijk} J_k$, introducing non-commutativity among the
boost generators, whereas for the Galilean group, $[K_i, K_j] = 0$, as shown in the main text. This difference leads to distinct group structures and representations, further emphasizing the unique characteristics of each group in describing physical symmetries.

#### Additional Notes on Group Extensions

As mentioned, one can consider extensions of these groups by including discrete transformations. For example, in the Lorentz group, adding space inversion or time reversal leads to the full orthochronous Lorentz group or the complete Lorentz group, which have multiple connected components. Similarly, for the Galilean group, one can include reflections to obtain a larger group. These extensions are important for understanding the full symmetry group of physical theories, including parity and time-reversal symmetries.

However, for the purposes of this discussion, we focus on the connected components containing the identity, which are the homogeneous groups discussed above.

## Preserving a Metric

A **metric** $B$ is a bilinear form on $\mathbb{R}^n$, defined by $B(\mathbf{u}, \mathbf{w}) = \mathbf{u}^T B \mathbf{w}$, where $B$ is an $n \times n$ matrix. A group $G$ of matrices **preserves the metric** if the following condition holds for all $\mathbf{u}, \mathbf{w} \in \mathbb{R}^n$ and $g \in G$:

$$ B(g \mathbf{u}, g \mathbf{w}) = B(\mathbf{u}, \mathbf{w}) $$

This ensures that the metric’s “measurement” remains invariant under transformations in $G$.

### Derivation of $g^T B g = B$

We begin with the preservation condition:

$$ B(g \mathbf{u}, g \mathbf{w}) = B(\mathbf{u}, \mathbf{w}) $$

Express this in coordinates using the definition of the metric:

$$ (g \mathbf{u})^T B (g \mathbf{w}) = \mathbf{u}^T B \mathbf{w} $$

Since $(g \mathbf{u})^T = \mathbf{u}^T g^T$ (by transpose properties), substitute into the left-hand side:

$$ \mathbf{u}^T g^T B g \mathbf{w} = \mathbf{u}^T B \mathbf{w} $$

This equality must hold for all vectors $\mathbf{u}$ and $\mathbf{w}$. For two matrices to produce the same bilinear form for all inputs, they must be equal. Thus:

$$ g^T B g = B $$

This condition must be satisfied by any matrix $B$ that is preserved by all
transformations $g \in G$.

Alternatively, this condition defines the group $G = \{ g \mid g^T B g = B \}$,
the set of all matrices preserving the metric $B$. So once we find $B$, we can
also start from $B$ and derive $G$, thus show that the metric $B$ and the group
$G$ are equivalent and one can be derived from the other.

:::{note}
The above can be derived using indices also, using:

$$ B(g \mathbf{u}, g \mathbf{w}) = B(\mathbf{u}, \mathbf{w}) $$

$$ (g\mathbf{u})^\mu B_{\mu\nu} (g\mathbf{w})^\nu = u^\mu B_{\mu\nu} w^\nu $$

$$ g^\mu{}_\alpha u^\alpha B_{\mu\nu} g^\nu{}_\beta w^\beta
= u^\alpha B_{\alpha\beta} w^\beta $$

$$ u^\alpha \left( (g^T)_\alpha{}^\mu B_{\mu\nu} g^\nu{}_\beta \right) w^\beta
= u^\alpha B_{\alpha\beta} w^\beta $$

This must hold for any $u^\alpha$, $w^\beta$, so we get:

$$ (g^T)_\alpha{}^\mu B_{\mu\nu} g^\nu{}_\beta = B_{\alpha\beta} $$

Or:

$$ g^T B g = B $$
:::

### Derivation of $K^T B + B K = 0$

Now consider an infinitesimal transformation near the identity, parameterized as $g(\epsilon) = I + \epsilon K$, where $K$ is a matrix in the Lie algebra of $G$, and $\epsilon$ is a small parameter. This must satisfy the preservation condition:

$$ g(\epsilon)^T B g(\epsilon) = B $$

Substitute $g(\epsilon) = I + \epsilon K$:

$$ (I + \epsilon K^T) B (I + \epsilon K) = B $$

Expand the expression, collecting terms up to first order in $\epsilon$:

$$ B + \epsilon (K^T B + B K) + O(\epsilon^2) = B $$

Subtract $B$ from both sides:

$$ \epsilon (K^T B + B K) + O(\epsilon^2) = 0 $$

For this to hold as $\epsilon \to 0$, the first-order term in $\epsilon$ must vanish (since $O(\epsilon^2)$ becomes negligible):

$$ K^T B + B K = 0 $$

This condition characterizes the generators $K$ of the Lie algebra associated with $G$.

### Summary

- **Finite condition**: $g^T B g = B$ defines the group $G$ that preserves the metric $B$.
- **Infinitesimal condition**: $K^T B + B K = 0$ defines the Lie algebra generators of $G$.

These results apply to groups like the Lorentz group, where $B = \text{diag}(-1, 1, 1, 1)$, preserving the spacetime metric in special relativity.
