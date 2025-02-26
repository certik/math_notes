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
=\cdots=\begin{pmatrix}
1 & 0 \\
\mathbf{v} & R
\end{pmatrix}
$$
The dots skip the tedious direct computation, but it can be done.

This transformation leaves invariant both the spatial contravariant metric
$\mathrm{diag}(0,1,1,1)$ and the independent dual temporal covariant metric
$\mathrm{diag}(1,0,0,0)$. This is computed below. The Lorentz/Poincaré group
leaves the Minkowski metric invariant and that is also computed below.
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

:::{note}
Can the metric change from inertial to inertial system? Answer: it cannot, the
choice of $a$ in the metric $g_{\mu\nu}=\textrm{diag}(-a, a)$ must apply to the
whole spacetime, because if you choose let's say $a=1$ for one inertial system,
then thanks to the Lorentz transformation it is preserved as $a=1$ for all
other inertial systems, so if you choose $a=-1$ for some other inertial system
you get contradictions: the spacetime interval for the two inertial systems
would not be preserved, despite using Lorentz transformation between them. The
interval only gets preserved if $a$ is chosen the same in both systems.

$$ ds'^2 = x^T g^T \eta g x = x^T \eta x = ds^2$$

In the above equation we used $g^T \eta g = \eta$ which only works if we use
exactly the same $a$ for both LHS and RHS, otherwise it doesn't.

:::


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

Important: The above derivation works for the covariant metric $B_{\mu\nu}$.
For contravariant metric $C^{\mu\nu}$ we get:

$$ C(\tilde{\mathbf{u}}g^{-1}, \tilde{\mathbf{w}} g^{-1})
= C(\tilde{\mathbf{u}}, \tilde{\mathbf{w}}) $$

Where $C(\tilde{\mathbf{u}}, \tilde{\mathbf{w}})=C^{\mu\nu} u_\mu w_\nu
=\tilde{\mathbf{u}} C \tilde{\mathbf{w}}^T$, so we get:

$$g^{-1} C (g^{-1})^T = C$$

And since $g' = g^{-1}$ belongs into the group, we get $g' C g'^T = C$ and we
can rename $g'$ to just $g$ to obtain the final equation for $C$:

$$g C g^T = C$$.


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


The article has already been rewritten to use `$` for inline math and `$$` for display math, as requested. Below is the complete rewritten version, ready for your use.

---

## Metrics Preserved by Galilean and Lorentz Boost Generators

In this article, we use the generator $K$ approach to derive the covariant metric $B$ and contravariant metric $C$ preserved by the Galilean and Lorentz boost generators in 1+1 dimensions. The covariant metric satisfies $K^T B + B K = 0$, and the contravariant metric satisfies $K C + C K^T = 0$. We assume $B$ and $C$ are symmetric 2x2 matrices and solve these equations to determine their forms, examining their degeneracy via the determinant.

### Galilean Boost Generator

The Galilean boost generator in 1+1 dimensions, representing a velocity boost in Newtonian spacetime, is:

$$
K = \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix}, \quad K^T = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix}
$$

#### Covariant Metric $B$

Let $B = \begin{pmatrix} a & b \\ b & c \end{pmatrix}$. Compute:

$$
K^T B = \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix} \begin{pmatrix} a & b \\ b & c \end{pmatrix} = \begin{pmatrix} b & c \\ 0 & 0 \end{pmatrix}
$$

$$
B K = \begin{pmatrix} a & b \\ b & c \end{pmatrix} \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix} = \begin{pmatrix} b & 0 \\ c & 0 \end{pmatrix}
$$

$$
K^T B + B K = \begin{pmatrix} b & c \\ 0 & 0 \end{pmatrix} + \begin{pmatrix} b & 0 \\ c & 0 \end{pmatrix} = \begin{pmatrix} 2b & c \\ c & 0 \end{pmatrix} = 0
$$

This gives $2b = 0$ and $c = 0$, so $b = 0$, $c = 0$. Thus:

$$
B = \begin{pmatrix} a & 0 \\ 0 & 0 \end{pmatrix}
$$

Choosing $a = 1$, we get $B = \text{diag}(1, 0)$. The determinant is:

$$
\det B = 1 \cdot 0 = 0
$$

This metric is **degenerate**, reflecting the absolute time in Galilean spacetime.

#### Contravariant Metric $C$

Let $C = \begin{pmatrix} p & q \\ q & r \end{pmatrix}$. Compute:

$$
K C = \begin{pmatrix} 0 & 0 \\ 1 & 0 \end{pmatrix} \begin{pmatrix} p & q \\ q & r \end{pmatrix} = \begin{pmatrix} 0 & 0 \\ p & q \end{pmatrix}
$$

$$
C K^T = \begin{pmatrix} p & q \\ q & r \end{pmatrix} \begin{pmatrix} 0 & 1 \\ 0 & 0 \end{pmatrix} = \begin{pmatrix} 0 & p \\ 0 & q \end{pmatrix}
$$

$$
K C + C K^T = \begin{pmatrix} 0 & p \\ p & 2q \end{pmatrix} = 0
$$

This gives $p = 0$ and $2q = 0$, so $q = 0$. Thus:

$$
C = \begin{pmatrix} 0 & 0 \\ 0 & r \end{pmatrix}
$$

Choosing $r = 1$, we get $C = \text{diag}(0, 1)$, with:

$$
\det C = 0 \cdot 1 = 0
$$

This metric is also **degenerate**, consistent with the spatial separation in Galilean symmetry.

### Lorentz Boost Generator

The Lorentz boost generator in 1+1 dimensions, representing a relativistic velocity boost, is:

$$
K = \begin{pmatrix} 0 & -1 \\ -1 & 0 \end{pmatrix}, \quad K^T = K
$$

#### Covariant Metric $B$

Let $B = \begin{pmatrix} a & b \\ b & c \end{pmatrix}$. Since $K^T = K$, the equation becomes $K B + B K = 0$. Compute:

$$
K B = \begin{pmatrix} 0 & -1 \\ -1 & 0 \end{pmatrix} \begin{pmatrix} a & b \\ b & c \end{pmatrix} = \begin{pmatrix} -b & -c \\ -a & -b \end{pmatrix}
$$

$$
B K = \begin{pmatrix} a & b \\ b & c \end{pmatrix} \begin{pmatrix} 0 & -1 \\ -1 & 0 \end{pmatrix} = \begin{pmatrix} -b & -a \\ -c & -b \end{pmatrix}
$$

$$
K B + B K = \begin{pmatrix} -2b & -(a + c) \\ -(a + c) & -2b \end{pmatrix} = 0
$$

This gives $-2b = 0$ and $-(a + c) = 0$, so $b = 0$, $a = -c$. Thus:

$$
B = \begin{pmatrix} a & 0 \\ 0 & -a \end{pmatrix}
$$

Choosing $a = -1$, we get $B = \text{diag}(-1, 1)$, with:

$$
\det B = (-1) \cdot 1 = -1 \neq 0
$$

This metric is **non-degenerate**, reflecting the unified spacetime of relativity.

#### Contravariant Metric $C$

Since $K^T = K$, the equation $K C + C K^T = 0$ is identical to $K C + C K = 0$. The calculation mirrors the covariant case, yielding:

$$
C = \begin{pmatrix} p & 0 \\ 0 & -p \end{pmatrix}
$$

Choosing $p = -1$, we get $C = \text{diag}(-1, 1)$, with $\det C = -1 \neq 0$, also **non-degenerate**.

### Conclusion

- **Galilean Boost**: $B = \text{diag}(1, 0)$ and $C = \text{diag}(0, 1)$ are degenerate ($\det = 0$), indicating separate time and space structures.
- **Lorentz Boost**: $B = \text{diag}(-1, 1)$ and $C = \text{diag}(-1, 1)$ are non-degenerate ($\det \neq 0$), reflecting the integrated spacetime of special relativity.

This distinction highlights the fundamental difference between Newtonian and relativistic symmetries.

Specifically it shows that in the Lorentz case we can define a spacetime
non-degenerate metric $g_{\mu\nu}=\text{diag}(-1, 1, 1, 1)$ (and the same for
upper indices), and we can use it to raise and lower indices, while in the
Galilean case we obtained the following covariant metric:
$$
\tau_{\mu\nu}=\text{diag}(1, 0, 0, 0)
$$
and the following contravariant metric:
$$
h^{\mu\nu}=\text{diag}(0, 1, 1, 1)
$$
They satisfy $\tau_{\mu\nu}h^{\mu\nu} = 0$.


### Extending Metrics Preserved by Galilean and Lorentz Groups from 1+1 to 3+1 Spacetime

To extend the computation of the metrics preserved by the Galilean and Lorentz groups from 1+1 spacetime (one time and one spatial dimension) to 3+1 spacetime (one time and three spatial dimensions), we determine the covariant metric $B$ and the contravariant metric $C$ that remain invariant under the boost transformations of these groups. These metrics satisfy specific invariance conditions derived from the boost generators: $K^T B + B K = 0$ for the covariant metric and $K C + C K^T = 0$ for the contravariant metric, where $K$ represents the boost generators in 3+1 dimensions. Assuming $B$ and $C$ are symmetric 4x4 matrices, we solve these equations systematically for each group.

#### **Galilean Group in 3+1 Spacetime**

The Galilean group governs transformations in Newtonian physics, where time is absolute, and boosts represent velocity shifts between inertial frames. In 3+1 dimensions, there are three boost generators corresponding to the spatial directions $x$, $y$, and $z$, denoted $K_x$, $K_y$, and $K_z$. Based on the transformation $t' = t$, $\mathbf{r}' = \mathbf{r} + \mathbf{v} t$, the generators are:

- $K_x = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$, transposition gives $K_x^T = \begin{pmatrix} 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$,
- $K_y = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$, with $K_y^T = \begin{pmatrix} 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$,
- $K_z = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 \end{pmatrix}$, with $K_z^T = \begin{pmatrix} 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$.

These matrices generate infinitesimal boosts, mixing time with each spatial coordinate.

##### **Covariant Metric $B$**

Assume $B$ is a symmetric 4x4 matrix:

$$ B = \begin{pmatrix} b_{00} & b_{01} & b_{02} & b_{03} \\ b_{01} & b_{11} & b_{12} & b_{13} \\ b_{02} & b_{12} & b_{22} & b_{23} \\ b_{03} & b_{13} & b_{23} & b_{33} \end{pmatrix} $$

We solve $K_i^T B + B K_i = 0$ for $i = x, y, z$.

- **For $K_x$:**

$$ K_x^T B = \begin{pmatrix} 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix} B = \begin{pmatrix} b_{01} & b_{11} & b_{12} & b_{13} \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix} $$

$$ B K_x = B \begin{pmatrix} 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix} = \begin{pmatrix} b_{01} & 0 & 0 & 0 \\ b_{11} & 0 & 0 & 0 \\ b_{12} & 0 & 0 & 0 \\ b_{13} & 0 & 0 & 0 \end{pmatrix} $$

$$ K_x^T B + B K_x = \begin{pmatrix} 2 b_{01} & b_{11} & b_{12} & b_{13} \\ b_{11} & 0 & 0 & 0 \\ b_{12} & 0 & 0 & 0 \\ b_{13} & 0 & 0 & 0 \end{pmatrix} = 0 $$

This gives:
- $2 b_{01} = 0 \Rightarrow b_{01} = 0$,
- $b_{11} = 0$,
- $b_{12} = 0$,
- $b_{13} = 0$.

- **For $K_y$:**

$$ K_y^T B + B K_y = \begin{pmatrix} 2 b_{02} & b_{12} & b_{22} & b_{23} \\ b_{12} & 0 & 0 & 0 \\ b_{22} & 0 & 0 & 0 \\ b_{23} & 0 & 0 & 0 \end{pmatrix} = 0 $$

This implies:
- $2 b_{02} = 0 \Rightarrow b_{02} = 0$,
- $b_{12} = 0$ (consistent),
- $b_{22} = 0$,
- $b_{23} = 0$.

- **For $K_z$:**

$$ K_z^T B + B K_z = \begin{pmatrix} 2 b_{03} & b_{13} & b_{23} & b_{33} \\ b_{13} & 0 & 0 & 0 \\ b_{23} & 0 & 0 & 0 \\ b_{33} & 0 & 0 & 0 \end{pmatrix} = 0 $$

This gives:
- $2 b_{03} = 0 \Rightarrow b_{03} = 0$,
- $b_{13} = 0$ (consistent),
- $b_{23} = 0$ (consistent),
- $b_{33} = 0$.

Thus, $B$ reduces to:

$$ B = \begin{pmatrix} b_{00} & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix} $$

Setting $b_{00} = 1$ (a common choice), we obtain:

$$ B = \begin{pmatrix} 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix} = \text{diag}(1, 0, 0, 0) $$

The determinant is $\det B = 1 \cdot 0 \cdot 0 \cdot 0 = 0$, indicating a degenerate metric, which aligns with the absolute time of Galilean physics.

##### **Contravariant Metric $C$**

Assume $C$ is symmetric:

$$ C = \begin{pmatrix} c_{00} & c_{01} & c_{02} & c_{03} \\ c_{01} & c_{11} & c_{12} & c_{13} \\ c_{02} & c_{12} & c_{22} & c_{23} \\ c_{03} & c_{13} & c_{23} & c_{33} \end{pmatrix} $$

Solve $K_i C + C K_i^T = 0$.

- **For $K_x$:**

$$ K_x C + C K_x^T = \begin{pmatrix} 0 & c_{00} & 0 & 0 \\ c_{00} & 2 c_{01} & c_{02} & c_{03} \\ 0 & c_{02} & 0 & 0 \\ 0 & c_{03} & 0 & 0 \end{pmatrix} = 0 $$

This implies:
- $c_{00} = 0$,
- $2 c_{01} = 0 \Rightarrow c_{01} = 0$,
- $c_{02} = 0$,
- $c_{03} = 0$.

- **For $K_y$ and $K_z$:**

Similar calculations confirm $c_{00} = c_{01} = c_{02} = c_{03} = 0$. Thus:

$$ C = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & c_{11} & c_{12} & c_{13} \\ 0 & c_{12} & c_{22} & c_{23} \\ 0 & c_{13} & c_{23} & c_{33} \end{pmatrix} $$

The boost generators constrain only the time-related components. However, the Galilean group includes spatial rotations, with generators $J_x$, $J_y$, $J_z$:

- $J_x = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & -1 \\ 0 & 0 & 1 & 0 \end{pmatrix}$,
- $J_y = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 \\ 0 & -1 & 0 & 0 \end{pmatrix}$,
- $J_z = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & 0 & -1 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$.

Since $J_i^T = -J_i$, the condition $J_i C + C J_i^T = 0$ becomes $J_i C = C J_i$, meaning $C$ must commute with the rotation generators. For the spatial block:

$$ C_{\text{spatial}} = \begin{pmatrix} c_{11} & c_{12} & c_{13} \\ c_{12} & c_{22} & c_{23} \\ c_{13} & c_{23} & c_{33} \end{pmatrix} $$

- **For $J_z$ (spatial part $\begin{pmatrix} 0 & -1 & 0 \\ 1 & 0 & 0 \\ 0 & 0 & 0 \end{pmatrix}$):**

$$ J_z C = \begin{pmatrix} 0 & -c_{12} & -c_{22} & -c_{23} \\ 0 & c_{11} & c_{12} & c_{13} \\ 0 & 0 & 0 & 0 \end{pmatrix}, \quad C J_z = \begin{pmatrix} 0 & c_{12} & c_{11} & 0 \\ 0 & c_{22} & c_{12} & 0 \\ 0 & c_{23} & c_{13} & 0 \end{pmatrix} $$

Equating $J_z C = C J_z$:
- $-c_{12} = c_{12} \Rightarrow c_{12} = 0$,
- $-c_{22} = c_{11} \Rightarrow c_{11} = -c_{22}$,
- $c_{11} = c_{22} \Rightarrow c_{11} = c_{22} = 0$ (if consistent with others).

- **For $J_x$ and $J_y$:**

Similar computations yield $c_{12} = c_{13} = c_{23} = 0$ and $c_{11} = c_{22} = c_{33} = c$. Thus:

$$ C = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & c & 0 & 0 \\ 0 & 0 & c & 0 \\ 0 & 0 & 0 & c \end{pmatrix} $$

Choosing $c = 1$:

$$ C = \begin{pmatrix} 0 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \end{pmatrix} = \text{diag}(0, 1, 1, 1) $$

The determinant is $\det C = 0$, a degenerate spatial metric.

#### **Lorentz Group in 3+1 Spacetime**

The Lorentz group governs special relativity, with boost generators:

- $K_x = \begin{pmatrix} 0 & 1 & 0 & 0 \\ 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$,
- $K_y = \begin{pmatrix} 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{pmatrix}$,
- $K_z = \begin{pmatrix} 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 \end{pmatrix}$.

All are symmetric ($K_i^T = K_i$).

##### **Covariant Metric $B$**

For $K_x$:

$$ K_x B + B K_x = \begin{pmatrix} 2 b_{01} & b_{11} + b_{00} & b_{12} & b_{13} \\ b_{00} + b_{11} & 2 b_{01} & b_{02} & b_{03} \\ b_{12} & b_{02} & 0 & 0 \\ b_{13} & b_{03} & 0 & 0 \end{pmatrix} = 0 $$

This gives $b_{01} = 0$, $b_{11} = -b_{00}$, $b_{12} = b_{13} = b_{02} = b_{03} = 0$. Solving for $K_y$ and $K_z$ similarly, we find $b_{22} = b_{33} = -b_{00}$, all off-diagonal terms zero. Thus:

$$ B = \begin{pmatrix} b_{00} & 0 & 0 & 0 \\ 0 & -b_{00} & 0 & 0 \\ 0 & 0 & -b_{00} & 0 \\ 0 & 0 & 0 & -b_{00} \end{pmatrix} $$

With $b_{00} = -1$:

$$ B = \text{diag}(-1, 1, 1, 1) $$

The determinant is $-1$, non-degenerate (Minkowski metric).

##### **Contravariant Metric $C$**

Since $K_i C + C K_i = 0$ mirrors the covariant condition, we get:

$$ C = \text{diag}(-1, 1, 1, 1) $$

Here, $C = B$, consistent with $B$ being its own inverse.

#### **Conclusion**

- **Galilean Group:**
  - $B = \text{diag}(1, 0, 0, 0)$ (temporal, degenerate),
  - $C = \text{diag}(0, 1, 1, 1)$ (spatial, degenerate).
  - Extends 1+1 case ($B = \text{diag}(1, 0)$, $C = \text{diag}(0, 1)$).

- **Lorentz Group:**
  - $B = C = \text{diag}(-1, 1, 1, 1)$ (non-degenerate).
  - Extends 1+1 case ($B = C = \text{diag}(-1, 1)$).

The Galilean metrics separate time and space, while the Lorentz metric unifies spacetime relativistically.


## Deriving Galilean group from the metric

We need to determine whether the Galilean transformations can be derived from the conditions $ g h g^T = h $ and $ g^T \tau g = \tau $, where $ h^{\mu\nu} = \text{diag}(0, 1, 1, 1) $ is the contravariant metric and $ \tau_{\mu\nu} = \text{diag}(1, 0, 0, 0) $ is the covariant metric. Let’s proceed systematically to explore this.


### Defining the Metrics and Transformation

First, let’s define the given metrics explicitly:

- The covariant metric $ \tau_{\mu\nu} $ is:

$$
\tau = \begin{pmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
$$

This metric isolates the time component, suggesting that transformations preserving it focus on the time coordinate.

- The contravariant metric $ h^{\mu\nu} $ is:

$$
h = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
$$

This emphasizes spatial components, aligning with spatial distances in Galilean relativity, typically measured for simultaneous events.

We represent the transformation $ g $ as a 4x4 matrix in block form:

$$
g = \begin{pmatrix}
a & \mathbf{b}^T \\
\mathbf{c} & D
\end{pmatrix}
$$

where:
- $ a $ is a scalar (1x1),
- $ \mathbf{b} $ is a 3x1 column vector,
- $ \mathbf{c} $ is a 3x1 column vector,
- $ D $ is a 3x3 matrix,
- $ \mathbf{b}^T $ is a 1x3 row vector.

The transpose is:

$$
g^T = \begin{pmatrix}
a & \mathbf{c}^T \\
\mathbf{b} & D^T
\end{pmatrix}
$$

Our task is to find $ g $ satisfying:
1. $ g^T \tau g = \tau $,
2. $ g h g^T = h $,

and determine if this yields the Galilean transformations (time translations, spatial translations, boosts, and rotations).

---

### Condition 1: $ g^T \tau g = \tau $

Compute $ g^T \tau $:

$$
g^T \tau = \begin{pmatrix}
a & \mathbf{c}^T \\
\mathbf{b} & D^T
\end{pmatrix}
\begin{pmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
= \begin{pmatrix}
a & 0 & 0 & 0 \\
\mathbf{b} & 0 & 0 & 0
\end{pmatrix}
$$

Now, compute $ g^T \tau g $:

$$
g^T \tau g = \begin{pmatrix}
a & 0 \\
\mathbf{b} & 0
\end{pmatrix}
\begin{pmatrix}
a & \mathbf{b}^T \\
\mathbf{c} & D
\end{pmatrix}
= \begin{pmatrix}
a a & a \mathbf{b}^T \\
\mathbf{b} a & \mathbf{b} \mathbf{b}^T
\end{pmatrix}
= \begin{pmatrix}
a^2 & a \mathbf{b}^T \\
a \mathbf{b} & \mathbf{b} \mathbf{b}^T
\end{pmatrix}
$$

Set this equal to $ \tau $:

$$
\begin{pmatrix}
a^2 & a \mathbf{b}^T \\
a \mathbf{b} & \mathbf{b} \mathbf{b}^T
\end{pmatrix}
= \begin{pmatrix}
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
$$

Analyze the components:
- **Top-left**: $ a^2 = 1 \Rightarrow a = \pm 1 $,
- **Top-right**: $ a \mathbf{b}^T = 0 $. Since $ a = \pm 1 $, $ \mathbf{b}^T = 0 \Rightarrow \mathbf{b} = 0 $,
- **Bottom-left**: $ a \mathbf{b} = 0 $, satisfied if $ \mathbf{b} = 0 $,
- **Bottom-right**: $ \mathbf{b} \mathbf{b}^T = 0 $ (a 3x3 zero matrix), satisfied if $ \mathbf{b} = 0 $.

Thus, $ \mathbf{b} = 0 $ and $ a = \pm 1 $, simplifying $ g $ to:

$$
g = \begin{pmatrix}
a & 0 \\
\mathbf{c} & D
\end{pmatrix}, \quad a = \pm 1
$$

---

### Condition 2: $ g h g^T = h $

With $ \mathbf{b} = 0 $, we have:

$$
g = \begin{pmatrix}
a & 0 \\
\mathbf{c} & D
\end{pmatrix}, \quad g^T = \begin{pmatrix}
a & \mathbf{c}^T \\
0 & D^T
\end{pmatrix}
$$

Compute $ h g^T $:

$$
h g^T = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
\begin{pmatrix}
a & \mathbf{c}^T \\
0 & D^T
\end{pmatrix}
= \begin{pmatrix}
0 & 0 \\
0 & D^T
\end{pmatrix}
$$

Now, compute $ g (h g^T) $:

$$
g (h g^T) = \begin{pmatrix}
a & 0 \\
\mathbf{c} & D
\end{pmatrix}
\begin{pmatrix}
0 & 0 \\
0 & D^T
\end{pmatrix}
= \begin{pmatrix}
0 & 0 \\
0 & D D^T
\end{pmatrix}
$$

Set this equal to $ h $:

$$
\begin{pmatrix}
0 & 0 \\
0 & D D^T
\end{pmatrix}
= \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
$$

- **Bottom-right**: $ D D^T = I_3 $, meaning $ D $ is orthogonal, so $ D \in O(3) $.

Thus, the conditions give:

$$
g = \begin{pmatrix}
a & 0 \\
\mathbf{c} & D
\end{pmatrix}, \quad a = \pm 1, \quad D \in O(3), \quad \mathbf{c} \text{ arbitrary}
$$

The transformation is:

$$
\begin{pmatrix}
t' \\
\mathbf{x}'
\end{pmatrix}
= \begin{pmatrix}
a & 0 \\
\mathbf{c} & D
\end{pmatrix}
\begin{pmatrix}
t \\
\mathbf{x}
\end{pmatrix}
\Rightarrow t' = a t, \quad \mathbf{x}' = \mathbf{c} t + D \mathbf{x}
$$

---

### Galilean Transformations

The Galilean group includes:
- **Time translation**: $ t' = t + \tau $, $ \mathbf{x}' = \mathbf{x} $,
- **Spatial translation**: $ t' = t $, $ \mathbf{x}' = \mathbf{x} + \mathbf{a} $,
- **Boost**: $ t' = t $, $ \mathbf{x}' = \mathbf{x} - \mathbf{v} t $,
- **Rotation**: $ t' = t $, $ \mathbf{x}' = R \mathbf{x} $, $ R \in SO(3) $.

In homogeneous coordinates (focusing on boosts and rotations):
- **Boost**:

$$
g = \begin{pmatrix}
1 & 0 \\
-\mathbf{v} & I_3
\end{pmatrix}
\Rightarrow t' = t, \quad \mathbf{x}' = \mathbf{x} - \mathbf{v} t
$$

- **Rotation**:

$$
g = \begin{pmatrix}
1 & 0 \\
0 & R
\end{pmatrix}, \quad R \in SO(3)
\Rightarrow t' = t, \quad \mathbf{x}' = R \mathbf{x}
$$

Compare:
- $ a = 1 $ matches Galilean time invariance; $ a = -1 $ (time reversal) is not standard,
- $ \mathbf{b} = 0 $ is consistent,
- $ D \in O(3) $ includes $ SO(3) $ but also reflections ($ \det D = -1 $),
- $ \mathbf{c} = -\mathbf{v} $ gives a boost, but $ \mathbf{c} $ arbitrary allows other forms.

---

### Analysis

Our $ g $ includes:
- Boosts: $ a = 1 $, $ \mathbf{c} = -\mathbf{v} $, $ D = I_3 $,
- Rotations: $ a = 1 $, $ \mathbf{c} = 0 $, $ D \in SO(3) $.

However, it also allows:
- $ a = -1 $ (time reversal),
- $ D $ with $ \det D = -1 $ (reflections),
- Arbitrary $ \mathbf{c} $, e.g., $ \mathbf{c} = \mathbf{u} $, giving $ \mathbf{x}' = \mathbf{u} t + D \mathbf{x} $, not a standard Galilean boost.

Test a non-Galilean case, $ g = \begin{pmatrix} 1 & 0 \\ (1, 0, 0) & I_3 \end{pmatrix} $:
- $ t' = t $,
- $ \mathbf{x}' = (t, 0, 0) + \mathbf{x} $,
- This adds a time-dependent shift, unlike a velocity boost.

---

### Conclusion

The conditions $ g^T \tau g = \tau $ and $ g h g^T = h $ yield transformations of the form $ g = \begin{pmatrix} a & 0 \\ \mathbf{c} & D \end{pmatrix} $, with $ a = \pm 1 $, $ D \in O(3) $, and $ \mathbf{c} $ arbitrary. This set includes Galilean transformations (boosts and rotations) but is broader, encompassing time reversal, reflections, and non-standard shifts. To derive only the Galilean group, additional constraints (e.g., $ a = 1 $, $ D \in SO(3) $, $ \mathbf{c} $ as velocity) are required.

**Answer**: Yes, the conditions $ g h g^T = h $ and $ g^T \tau g = \tau $ can derive transformations that include the Galilean transformations, but the resulting set is broader than the Galilean group alone unless further restricted.
