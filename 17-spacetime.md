# Spacetime

Spacetime is a 4-dimensional manifold in which the three spatial coordinates and one time coordinate are unified as follows:

* A conversion factor with dimensions of speed allows the time coordinate to be expressed in units of length, treating it on the same footing as the spatial coordinates.
* All equations are invariant under arbitrary smooth 4-dimensional diffeomorphisms, which may mix the time and space coordinates.

Any manifold equipped with a torsion-free affine connection admits local coordinates in which the connection coefficients vanish at a chosen point. Their derivatives need not vanish, so the Riemann tensor (and curvature) may still be nonzero. Whatever geometric structure is present can be brought to a standard form at that point.

The concrete geometric structure is fixed solely by symmetries and general properties. Homogeneity implies that transformations between inertial frames are linear. Combined with spatial isotropy, the existence of the ten generators corresponding to spatial rotations, spatial translations, boosts and time translation, and mild causality requirements, the only consistent possibilities are the Poincaré group and the Galilei group. (Fully Euclidean rotations that erase any distinction between space and time are excluded by causality.)

Via the associated Klein geometries these groups determine the possible invariant geometric structures: a non-degenerate metric of signature $(-+++)$ or a degenerate pair consisting of a temporal 1-form and a spatial co-metric.

Any spacetime theory consistent with the stated assumptions must therefore be based on one of these two local structures (possibly equipped with a dynamical connection compatible with that structure). The construction itself remains agnostic about which structure is realized and about the presence or absence of curvature.

Note: all 4 coordinates are equal in a sense that they are just labels, we
cannot tell by looking at a metric or particular coordinates which one is time
and which space. We must do a computation with a particular spacetime structure
to figure it out.

## Example I

In Galilean space time we can have the following equation of motion
$$
\nabla^2\Phi=4\pi G\rho.
$$

This equation is invariant with respect to any spatial coordinate
transformation, as well as time translation. But it is not invariant with
respect to making local time space dependent (such as timezones on Earth). It's
a tensor equation in the spatial 3D space, but not a tensor equation in the
full 4D spacetime. To make it invariant, one must write it as:

$$ R_{\mu\nu} = 4\pi G\rho\,\tau_\mu\tau_\nu \,.$$

This equation is fully invariant with respect to any 4D coordinate
transformation, including space-dependent time.

The Poisson example can thus be written in a tensor form.

## Example II

Here is an example equation that cannot be written in a tensor form:

$\frac{d^2\mathbf{x}}{dt_{\rm abs}^2} = -\nabla\Phi + \mathbf{f}(t_{\rm abs}, \mathbf{v})$

This equation is invariant with respect to any spatial transformation, time
translation and Galilean transformation. It is however not invariant to
space-dependent time transformation (such as local time zones) and cannot be
written in an invariant tensor form.

As such, one can construct a local experiment in a freely falling "elevator" that
can determine the $f$ term and thus the preferred frame: the residual force
depends on when they do the experiment and on their velocity relative to the
absolute space.

As such, the requirement to be invariant to space-dependent time coordinate
transformations is not an artificial requirement, but rather a fundamental
invariance requirement: without it we can determine a "local time zone" from
local experiments, which is unphysical (against the strong equivalence
principle). Thus the strong equivalence principle requires that physical laws
be invariant to any 4D transformation including space-dependent time
coordinates.

In fact, the converse is also true: such tensor laws in 4D spacetime plus some
mild additional assumptions automatically imply the strong equivalence
principle.

## Summary

The conclusion is that we can assume the strong equivalence principle (SEP) as
the starting point. Technically we could derive everything from a slightly
weaker assumption as well, but for the initial treatment we'll assume the full
SEP.

From SEP it strictly follows that all physical laws must be written in tensor
form, invariant to any 4D transformation of spacetime, including
space-dependent time coordinate transformations.

Mathematically, the equations must be invariant under the full diffeomorphism
group $\mathrm{Diff}(M)$.

Note: there is a separate additional assumption that one can impose: background
independence. Background independence goes one step further from SEP: it also
discards absolute structures that have no effect at all on any experiment.
Those inert structures are already invisible to the SEP, so removing them is
not required for the covariance argument above. It is an additional theoretical
cleanliness condition, not a logical necessity for deriving 4D tensorial form.
It requires that no fixed, non-dynamical geometric structure may appear in the
field equations. Every geometric object that determines free-fall trajectories,
causal structure, or the coupling of matter to gravity must itself be dynamical
(it must transform under diffeomorphisms and, typically, satisfy its own field
equation). The background independence is typically used to greatly restrict
the possible forms of the field equations (Einstein's equations in GR and the
Newton equations in NC). However the background independence is not used to
derive the requirement that all physical laws must be tensor equations, or
other properties of spacetime above.
