# Spacetime

Spacetime is a 4D manifold where the 3 spatial and 1 time coordinates are
unified in the following sense:

* The time coordinate can be multiplied with a conversion factor ($c$) of units
  of speed to measure it in units of distance and treat it as an equal
  coordinate to the spatial coordinates.

* All equations are invariant to arbitrary (smooth) 4D transformations, mixing
  time and space in arbitrary manner.

For any manifold equipped with a torsion-free affine connection, it can be
shown that:

* Locally one can always transform the coordinates in such a way to obtain
  locally flat space, where at the point all connection coefficients disappear.
  Their derivatives in general do not, so the Riemann tensor is non-zero and
  the curvature is still there.
  If the metric is not degenerate, it will be diagonal. If it is degenerate,
  both metrics will be diagonal as well.

The specific metric structure and signature is determined from spacetime
symmetries:

* We assume isotropy and homogeneity symmetries
* We assume 10 generators (3 spatial rotations, 3 spatial translations, 3
  boosts, 1 time translation)
* From symmetries we derive Lie algebra brackets, many of which are set (such
  as $[J, J] = J$, $[J, K] = K$, $[J, P] = P$, etc.)
* We enumerate / classify all options. Under very mild assumptions we can prove
  there just three kinematical groups:
  * Rotation translation group
  * Poincaré group
  * Galileo group
* We assume very mild assumptions about causality, which excludes the
  O(4) rotations

So only Poincaré and Galileo groups are allowed by symmetries. From their Lie
algebra one can derive the corresponding metric via Klein construction. One
obtains Minkowski metric for Poincaré, with signature -1, and the degenerate
pair of metric for Galileo.

As a result the spacetime is then fully determined.
