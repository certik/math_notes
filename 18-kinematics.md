# Free Particle Dynamics from Spacetime Symmetries

*Non-relativistic and relativistic cases side by side, without circularity.*

We work throughout with a local inertial frame. In that frame the geometry is flat and the symmetry group is either the Galilei group (non-relativistic) or the Poincaré group (relativistic). All arguments are direct; no variational principle is assumed until the equation of motion has already been fixed uniquely by symmetry.

---

## 1. Unique equation of motion from symmetries alone

Assume the most general equation of motion for a free particle can be written

**Non-relativistic**  
$$
\mathbf{a}=\mathbf{F}(\mathbf{x},\mathbf{v},t).
$$

**Relativistic**  
$$
\frac{d\mathbf{v}}{dt}=\mathbf{F}(\mathbf{x},\mathbf{v},t)
$$
(or, covariantly, an expression for the four-acceleration $a^\mu$).

### Homogeneity of space and time
No point and no instant is preferred. Therefore the force cannot depend on position or time:

**NR**  
$$
\mathbf{a}=\mathbf{F}(\mathbf{v}).
$$

**GR**  
$$
\frac{d\mathbf{v}}{dt}=\mathbf{F}(\mathbf{v}).
$$

### Isotropy
No direction is preferred. The only vector that can be constructed from $\mathbf{v}$ alone is proportional to $\mathbf{v}$ itself:

**NR**  
$$
\mathbf{a}=f(v^2)\,\mathbf{v}.
$$

**GR**  
$$
\frac{d\mathbf{v}}{dt}=f(v^2)\,\mathbf{v}.
$$

### Boost invariance
The functional form of the law must be the same in every inertial frame, and acceleration transforms in a definite way under boosts.

**NR (Galilean boosts)**  
Under $\mathbf{v}\to\mathbf{v}+\mathbf{u}$ one has $\mathbf{a}'=\mathbf{a}$. The only function compatible with this for arbitrary constant $\mathbf{u}$ is $f\equiv0$.

**GR (Lorentz boosts)**  
Under a Lorentz boost the three-acceleration transforms non-trivially. The only function compatible with the transformation law for arbitrary boosts is again $f\equiv0$.

Covariantly: the only four-vector orthogonal to the four-velocity $u^\mu$ that can be built from $u^\mu$ alone is zero. Hence the four-acceleration vanishes.

### Conclusion
In a local inertial frame the unique free-particle equation of motion is

**NR**  
$$
\mathbf{a}=0.
$$

**GR**  
$$
\frac{d^2x^\mu}{d\tau^2}=0
\quad\bigl(\text{or }a^\mu=0\bigr).
$$

No other equation of motion—variational or non-variational—is compatible with the symmetries.

---

## 2. Existence and uniqueness of a Lagrangian

We now construct a Lagrangian that reproduces the equation of motion already obtained. The same symmetries fix the Lagrangian uniquely (up to total derivatives).

**NR**  
The unique Lagrangian compatible with Galilei (Bargmann) symmetry is
$$
L=\frac12 m v^2.
$$
(Its Euler–Lagrange equation is precisely $\mathbf{a}=0$.)

**GR**  
The unique Lagrangian compatible with Poincaré symmetry is
$$
L=-mc\sqrt{1-v^2/c^2}
$$
(or, in covariant form, $L=-mc\,ds/d\lambda$). Its Euler–Lagrange equation is precisely $a^\mu=0$.

Because both existence and uniqueness have been established, the Lagrangian generates *all* dynamics allowed by the symmetries; nothing is left out.

---

## 3. Conserved quantities from Noether’s theorem

With the unique Lagrangian in hand, continuous symmetries yield conserved charges.

### Spatial translations
**NR**  
$$
\mathbf{p}=\frac{\partial L}{\partial\mathbf{v}}=m\mathbf{v}.
$$

**GR**  
$$
\mathbf{p}=\frac{\partial L}{\partial\mathbf{v}}=\gamma m\mathbf{v},\qquad\gamma=(1-v^2/c^2)^{-1/2}.
$$

### Time translations
**NR**  
$$
E=\mathbf{v}\cdot\frac{\partial L}{\partial\mathbf{v}}-L=\frac12 m v^2.
$$

**GR**  
$$
E=\mathbf{v}\cdot\frac{\partial L}{\partial\mathbf{v}}-L=\gamma mc^2.
$$
Kinetic energy is the excess over rest energy: $T=(\gamma-1)mc^2$.

### Mass-shell relation (GR only)

$$
E^2-\mathbf{p}^2c^2=m^2c^4.
$$

---

## 4. Passage to arbitrary coordinates – the geodesic equation

The equation of motion must remain a tensor equation under the full diffeomorphism group (already required by the strong equivalence principle). The unique second-order tensorial equation that reduces to zero acceleration in every local inertial frame is the geodesic equation

**NR (Newton–Cartan)**  
$$
\frac{d^2x^\lambda}{dt^2}+\Gamma^\lambda_{\mu\nu}\frac{dx^\mu}{dt}\frac{dx^\nu}{dt}=0
$$
(with the Newton–Cartan connection compatible with $\tau_\mu$ and $h^{\mu\nu}$).

**GR**  
$$
\frac{d^2x^\lambda}{d\tau^2}+\Gamma^\lambda_{\mu\nu}\frac{dx^\mu}{d\tau}\frac{dx^\nu}{d\tau}=0
$$
(with the Levi-Civita connection of the metric).

In both cases free particles follow geodesics of the spacetime connection.

---

## 5. Continuum conservation laws

When matter is described by fields, diffeomorphism invariance of the matter action implies the covariant conservation law

**NR**  
the Newton–Cartan analogue of $\nabla\cdot T=0$ (conservation of mass current and energy-momentum with respect to the NC connection).

**GR**  
$$
\nabla_\mu T^{\mu\nu}=0.
$$

These identities follow from symmetry alone; the gravitational field equations are not required.

---

## Summary table

| Step                              | Non-relativistic (Galilei)              | Relativistic (Poincaré)                  |
|-----------------------------------|-----------------------------------------|------------------------------------------|
| Unique EOM in inertial frame      | $\mathbf{a}=0$                          | $a^\mu=0$                                |
| Unique Lagrangian                 | $\frac12 m v^2$                         | $-mc\sqrt{1-v^2/c^2}$                    |
| Momentum                          | $m\mathbf{v}$                           | $\gamma m\mathbf{v}$                     |
| Energy                            | $\frac12 m v^2$                         | $\gamma mc^2$                            |
| General-coordinate EOM            | NC geodesic equation                    | metric geodesic equation                 |
| Continuum conservation            | NC covariant conservation               | $\nabla_\mu T^{\mu\nu}=0$                |

All results follow from spacetime symmetries by a strictly non-circular chain: symmetries fix the equation of motion, the equation of motion admits a unique Lagrangian, and the Lagrangian yields the conserved charges via Noether’s theorem.
