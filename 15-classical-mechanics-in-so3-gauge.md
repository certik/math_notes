---
date: 2026-07-07
authors:
  - name: Brian Beckman
  - name: Ondřej Čertík
exports:
  - format: docx
  - format: pdf
  - format: tex
  - format: typst
bibliography:
  - references.bib
---

# SO(3) Gauge Theory for Classical Mechanics

## Abstract

We analyze the classical mechanics of the inverted spherical pendulum (ISP) and of the symmetrical (Lagrange) top as gauge theories in $SO(3)$, the Lie group of rotations in three dimensions. We show that the equations of motion can be derived as geodesic equations on a curved manifold, $SO(3)$, fibred over ordinary spacetime. This derivation is short and direct, standing in contrast to the more standard and elaborate delivery. 

Adding a third angle $\psi$, representing twist about the baton axis, introduces gyroscopic coupling that physically stabilizes the pendulum and converts the problem into that of the symmetrical top. 

This formulation directly mirrors Yang-Mills theory and general relativity, showing that classical Newtonian mechanics can be elegantly expressed in terms of differential geometry. 

The original version of this article in Wolfram Mathematica is published in [@beckman2026wolfram].

## Introduction

Gauge theory and gauge-covariant derivatives are the mathematical backbone of the Standard Model of particle physics, describing electromagnetic, weak, and strong interactions as connections on principal fiber bundles. Covariant derivatives on spacetime itself are the mathematical backbone of general relativity and gravitation. It is a seldom-mentioned, yet remarkable fact that exactly the same mathematical machinery pertains to classical Newtonian mechanics! 

The unifying fact, promoted to a slogan, is:

> **"Forces arise as connection coefficients in covariant derivatives."**

Standard physics curricula derive the equations of motion for rotating rigid bodies using coordinate-heavy Euler-Lagrange equations written in Euler angles (yaw, pitch, and roll). This traditional approach—found in classic textbooks such as Goldstein's *Classical Mechanics* [@goldstein2002classical], Landau and Lifshitz's *Mechanics* [@landau1976mechanics], or Arnol'd's *Mathematical Methods of Classical Mechanics* [@arnold2013mathematical]—tends to obscure the overarching geometric structure.

In this article, we reformulate the classical inverted spherical pendulum (ISP) and Lagrange top geometrically, revealing the equations of motion following from a **gauge-covariant absolute derivative** along the system's trajectory:

$$
D_t \dot{x}^\mu \;\stackrel{\text{def}}{=}\; \frac{d\dot{x}^\mu}{dt} + \Gamma^\mu_{\alpha\beta} \dot{x}^\alpha \dot{x}^\beta = F^\mu
$$

where $D_t$ is the absolute covariant derivative and the $\Gamma$'s are the **connection coefficients** of the specific gauge manifold we choose. In this article, the gauge manifold / gauge group is $SO(3)$. In a future note, we will choose $SU(2)$, specifically to avoid gimbal lock. 

This is *exactly* the same kind of computation performed under the banner of _gauge invariance_ in the Standard Model. Rather than postulating Coriolis or gyroscopic forces ad-hoc, they emerge naturally as the Christoffel connection coefficients $\Gamma^\mu_{\alpha\beta}$ of a curved manifold ($SO(3)/SO(2)$ or $SO(3)$) fibred over ordinary time. _Inertial forces arise from connection coefficients_.

This formulation directly mirrors:
1. **General Relativity**: Where the gravitational force is replaced entirely by geodesic motion (vanishing covariant acceleration) in a curved 4D spacetime manifold.
2. **Yang-Mills Gauge Theory**: Where the gyroscopic off-diagonal coupling terms act exactly as a gauge potential $A_\mu$, and the resulting Coriolis and gyroscopic precession forces emerge directly from the gauge-covariant derivative.

It is a remarkable fact that physics of all kinds—classical and quantum, relativistic and Newtonian—are concisely and elegantly unified through differential geometry. This note aims to furnish a concise, accessible bridge for physics undergraduates to see how gauge theory operates even in a simple, concrete classical system.

We accompany this note with:
1. A formal verification in Lean 4 verifying the algebraic properties of the 2D quotient metric and its singularity.
2. A symbolic verification in SymPy computing the Christoffel symbols, geodesic equations, and their $I_3 \to 0$ limit, whereby the Lagrange top converges to the inverted spherical pendulum.

## 1. Lagrangian Formulation & Singularity

Consider a rigid-rod pendulum of uniform density with mass $m$ and length $2 c_z$, with its center of mass located at distance $c_z$ from the pivot, fixed to the 2D floor. We measure its angular position with two coordinates:
* $\delta$ (pitch), measuring co-latitude from the North pole.
* $\eta$ (cone-roll), measuring rotation around the original $X$-axis.

The position of the center of mass in Cartesian coordinates is:

$$
\mathbf{r} = R_x(\eta) R_y(\delta) \begin{pmatrix} 0 \\ 0 \\ c_z \end{pmatrix}
$$

:::{figure} figures/non_quantum_so3_coordinates.png
:label: fig-non-quantum-so3-coordinates
:align: center
:width: 80%

3D visualization of the inverted spherical pendulum showing the pitch ($\delta$) and cone-roll ($\eta$) coordinate system.
:::


The velocity is $\mathbf{v} = \dot{\mathbf{r}}$, leading to the kinetic energy:

$$
T = \frac{1}{2} m \mathbf{v} \cdot \mathbf{v} = \frac{1}{2} m c_z^2 \left( \dot{\delta}^2 + \cos^2\delta \, \dot{\eta}^2 \right)
$$

The potential energy under gravity pointing in the $-Z$ direction is:

$$
V = m g z_h = m g c_z \cos\delta \cos\eta
$$

With the Lagrangian $L = T - V$, the Euler-Lagrange equations yield:

$$
\ddot{\delta} = \sin\delta \left( \frac{g}{c_z} \cos\eta - \cos\delta \, \dot{\eta}^2 \right)
$$

$$
\ddot{\eta} = \frac{g}{c_z} \sec\delta \sin\eta + 2 \tan\delta \, \dot{\delta} \, \dot{\eta}
$$

### The Coordinate Singularity

The equation for $\ddot{\eta}$ contains the term $\sec\delta \sin\eta = \frac{\sin\eta}{\cos\delta}$, which diverges at the equator $\delta \to \pm \pi/2$ ($\cos\delta \to 0$) for almost all values of $\eta$. This is the mathematical manifestation of gimbal lock. 

We can analyze the limits of the gravitational term at the equator:
* **Typical Points ($\eta \neq 0, \pi$)**: If the pendulum is tilted away from the $y$-$z$ plane ($\sin\eta \neq 0$), the force term diverges:
  $$
  \lim_{\delta \to \pi/2} \sec\delta \sin\eta = \pm \infty
  $$
  This drives infinite azimuthal acceleration $\ddot{\eta} \to \infty$.
* **Exceptional Points ($\eta = 0, \pi$)**: If the pendulum swings purely within the $y$-$z$ plane, then $\sin\eta = 0$ exactly. In this case, we have:
  $$
  \lim_{\delta \to \pi/2} \sec\delta \sin(0) = 0
  $$
  The force remains finite (and vanishes) at the equator because the gravity vector has no projection along the direction of azimuthal change. These trajectories can pass through the equator smoothly.
* **Indeterminate Limits**: For general paths where $(\delta, \eta) \to (\pi/2, 0)$, the limit $\lim \frac{\sin\eta}{\cos\delta}$ is an indeterminate $0/0$ form and is path-dependent, reflecting the topological fact that the coordinate direction is undefined at the poles of the rotated coordinate system.

This gimbal-lock problem will be fully resolved in an upcoming note by performing the entire geometric computation again in $SU(2)$, the double-cover rotation group that is completely coordinate-singularity-free. A side-by-side video demonstration showing $SO(3)$ gimbal-lock divergence vs $SU(2)$ singularity-free stability is available in [@beckman2026euler]. A second video showing the mathematical equivalence of $SO(3)$ and $SU(2)$ trajectories away from the gimbal lock equator is available in [@beckman2026equivalence]. We thank the Wolfram Community for hosting these video attachments.

We formally define this metric and verify the vanishing of its determinant at the singularity in Lean 4:

:::{dropdown} Lean definition: `metricSO3`
```{literalinclude} math_notes_lean/MathNotesLean/ClassicalMechanicsSO3Flow.lean
:language: lean
:start-after: ANCHOR: metric-so3-def
:end-before: ANCHOR_END: metric-so3-def
```
:::

:::{dropdown} Lean proof: `det_metricSO3`
```{literalinclude} math_notes_lean/MathNotesLean/ClassicalMechanicsSO3Flow.lean
:language: lean
:start-after: ANCHOR: metric-so3-det
:end-before: ANCHOR_END: metric-so3-det
```
:::

## 2. Geometric Derivation via Kinetic-Energy Metric

Instead of the Euler-Lagrange formalism, we can derive the equations of motion geometrically. The kinetic energy defines a Riemannian metric tensor $g_{\mu\nu}$ on the $2$D configuration space:

$$
g_{\mu\nu} = \begin{pmatrix} I_1 & 0 \\ 0 & I_1 \cos^2\delta \end{pmatrix}
$$

where $I_1 = m c_z^2$. The inverse (contravariant) metric $g^{\mu\nu}$ is:

$$
g^{\mu\nu} = \begin{pmatrix} \frac{1}{I_1} & 0 \\ 0 & \frac{1}{I_1 \cos^2\delta} \end{pmatrix}
$$

which we formally define in Lean 4 as:

:::{dropdown} Lean definition: `invMetricSO3`
```{literalinclude} math_notes_lean/MathNotesLean/ClassicalMechanicsSO3Flow.lean
:language: lean
:start-after: ANCHOR: metric-so3-inv-def
:end-before: ANCHOR_END: metric-so3-inv-def
```
:::

We prove in Lean that the inverse is valid as long as we are away from the singularity:

:::{dropdown} Lean proof: `metricSO3_mul_inv`
```{literalinclude} math_notes_lean/MathNotesLean/ClassicalMechanicsSO3Flow.lean
:language: lean
:start-after: ANCHOR: metric-so3-inv-proof
:end-before: ANCHOR_END: metric-so3-inv-proof
```
:::

The Christoffel symbols of the second kind are computed from the metric via:

$$
\Gamma^\mu_{\alpha\beta} = \frac{1}{2} g^{\mu\gamma} \left( \partial_\alpha g_{\beta\gamma} + \partial_\beta g_{\alpha\gamma} - \partial_\gamma g_{\alpha\beta} \right)
$$

The non-vanishing independent Christoffel symbols are:

$$
\Gamma^\delta_{\eta\eta} = \cos\delta \sin\delta, \quad \Gamma^\eta_{\delta\eta} = -\tan\delta
$$

The geodesic equation of motion incorporating the potential gradient force is:

$$
\ddot{x}^\mu + \Gamma^\mu_{\alpha\beta} \dot{x}^\alpha \dot{x}^\beta = F^\mu
$$

where the force vector $F^\mu = -g^{\mu\nu} \partial_\nu V$. This matches the Euler-Lagrange equations exactly.

## 3. Gyroscopic Fibration via $SO(3)$

To include gyroscopic effects, we add a third angle $\psi$, representing twist or spin around the long axis of the baton. The configuration space is now the full Lie group $SO(3)$, viewed as a circle bundle (fibration) over the $2$D sphere.

Let $I_3$ be the moment of inertia around the spin axis, and $I_1$ be the transverse moment of inertia. The $3$D metric tensor is:

$$
g_{\mu\nu} = \begin{pmatrix} I_1 & 0 & 0 \\ 0 & I_1 \cos^2\delta + I_3 \sin^2\delta & I_3 \sin\delta \\ 0 & I_3 \sin\delta & I_3 \end{pmatrix}
$$

Its inverse (contravariant) metric tensor $g^{\mu\nu}$ is:

$$
g^{\mu\nu} = \begin{pmatrix} \frac{1}{I_1} & 0 & 0 \\ 0 & \frac{\sec^2\delta}{I_1} & -\frac{\sec^2\delta \sin\delta}{I_1} \\ 0 & -\frac{\sec^2\delta \sin\delta}{I_1} & \frac{1}{I_3} + \frac{\tan^2\delta}{I_1} \end{pmatrix}
$$

The off-diagonal elements of the metric tensor represent the $SO(3)$ gauge potential. As the baton moves along the cone-roll coordinate $\eta$, the motion leaks into the twist coordinate $\psi$ via the gauge connection, physically manifesting as Coriolis and gyroscopic precession forces.

The resulting equations of motion are:

$$
I_1 \ddot{\delta} + (I_1 - I_3)\cos\delta\sin\delta \, \dot{\eta}^2 - I_3 \cos\delta \, \dot{\eta} \, \dot{\psi} = m g c_z \sin\delta \cos\eta
$$

$$
I_1 \ddot{\eta} + \dot{\delta} \left( I_3 \dot{\psi} \sec\delta + (-2 I_1 + I_3) \tan\delta \, \dot{\eta} \right) = m g c_z \sec\delta \sin\eta
$$

$$
I_1 \ddot{\psi} + \dot{\delta} \left( \left(I_1 \cos\delta + (2 I_1 - I_3) \sin\delta \tan\delta\right) \dot{\eta} - I_3 \tan\delta \, \dot{\psi} \right) = -m g c_z \sin\eta \tan\delta
$$

When $I_3 \to 0$, the first two equations devolve exactly to the 2D quotient equations of motion.

## 4. SymPy Symbolic Verification

We implement the metrics, Christoffel symbol computations, and covariant derivative equations of motion in Python using SymPy. The script verifies all algebraic steps and confirms the correctness of the $I_3 \to 0$ limit against the 2D Euler-Lagrange equations.

```{literalinclude} so3_gyroscope.py
:language: python
```

## 5. Numerical Solution and Visualization

We leave numerical solution and visualization to a future update of this note. Those were accomplished in (the original Wolfram version)[https://community.wolfram.com/groups/-/m/t/3647724?p_p_auth=JjVao8Bx]. We need merely to port them to SymPy and NumPy.