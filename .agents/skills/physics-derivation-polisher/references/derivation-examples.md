# Good and Bad Physics Derivations

Use these examples as audit patterns. They are deliberately generic: the point
is the quality and ordering of the reasoning, not the particular formula.

## 1. Circular use of an action

### Bad

> A free particle has Lagrangian $L=\frac12 m v^2$. The Euler-Lagrange equation
> gives $\dot{\mathbf v}=0$. Therefore symmetry requires free particles to move
> at constant velocity, and hence the free-particle Lagrangian must be
> $L=\frac12 m v^2$.

This argument uses the proposed Lagrangian to obtain the dynamics and then uses
those dynamics to justify the same Lagrangian. It proves only that the
Lagrangian is compatible with the result, not that either is forced or unique.

### Good

1. State the most general local second-order free-particle law in an inertial
   frame:

   $$
   \dot{\mathbf v}=\mathbf F(\mathbf x,\mathbf v,t).
   $$

2. Translate spatial and temporal homogeneity into independence from
   $\mathbf x$ and $t$.
3. Translate isotropy into the most general rotationally equivariant form.
4. Impose the full family of inertial-frame transformations and solve the
   resulting constraint.
5. Only after the equation of motion has been obtained, ask whether an action
   exists whose Euler-Lagrange equation reproduces it.
6. Analyze the action's normalization and total-derivative ambiguity separately
   from its existence.

The good version prevents the variational formalism from supplying the very
dynamics it is later claimed to derive uniquely.

## 2. Importing a mature theory without deriving its prerequisites

### Bad

> By Noether's theorem, translation invariance gives momentum conservation.
> Therefore momentum is $m\mathbf v$.

The first sentence presupposes an action and a specified realization of
translations on the dynamical variables. No action has been established, and
Noether's theorem alone does not determine the displayed formula.

### Good

1. Define operationally what process is being compared and what quantity is
   conserved.
2. Write the most general candidate momentum compatible with the stated
   isotropy and additivity assumptions.
3. Compare the complete process in every admissible inertial frame.
4. Derive the functional constraint on the candidate momentum.
5. State the regularity condition needed to solve that constraint.
6. Derive the allowed momentum law.
7. If an action is established later, verify that its Noether charge agrees
   with the independently derived quantity.

The mature theory becomes a consistency check or later representation, not an
unannounced premise.

## 3. Skipping the functional-equation argument

### Bad

> The quantity doubles quadratically, $E(2v)=4E(v)$, so necessarily
> $E(v)=Cv^2$.

The conclusion does not follow. A single scaling identity can admit additional
log-periodic or nonregular solutions.

### Good

1. Derive the relation produced by an arbitrary transformation parameter, not
   only one special value.
2. Show explicitly how that relation implies integer and rational scaling.
3. State whether continuity, measurability, boundedness, or another regularity
   condition is required.
4. Use density plus the stated regularity to extend the result from rational to
   real arguments.
5. Mention the pathological family excluded by the regularity assumption.

The good derivation identifies both the algebraic content of symmetry and the
separate analytical input needed for uniqueness.

## 4. Hidden assumptions inside a "general" ansatz

### Bad

> The most general invariant line element is
> $ds^2=-A\,dt^2+B\,d\mathbf x^2$.

Calling this expression "most general" already assumes a nondegenerate metric,
a split into time and space, the absence of cross terms, and particular
transformation properties.

### Good

1. Specify the group, subgroup fixing the chosen basepoint, and tangent
   representation.
2. Begin with a completely general bilinear form or tensor of the intended
   variance.
3. Impose invariance generator by generator.
4. Solve for every component, allowing degeneracy.
5. State which structures do not arise from the invariant bilinear form and
   whether independent covariant or contravariant tensors remain.
6. Interpret the resulting branches only after the algebraic classification.

The good version lets symmetry determine whether a metric exists and what type
of geometric structure is available.

## 5. Transforming only part of a physical process

### Bad

> Boost the incoming velocities in the collision formula while leaving the
> final state and heat unchanged. The transformed equation gives the desired
> energy law.

This mixes descriptions from different frames. Whether heat is unchanged is
itself an assumption, and the final state must be transformed along with the
initial state.

### Good

1. Describe one physical event completely in a chosen frame.
2. Transform every initial and final state into the second frame.
3. State explicitly which scalars or dissipative quantities are assumed to be
   frame-independent.
4. Write the conservation or balance law independently in both frames.
5. Compare the two complete equations and derive the resulting constraint.

The comparison is meaningful because both equations describe the same event.

## 6. Confusing covariance with physical symmetry

### Bad

> The equation is written with indices, so it is invariant under every
> coordinate transformation and therefore represents a physical symmetry.

Index notation alone does not establish tensoriality. Moreover, a passive
coordinate change, an active physical symmetry, and a gauge redundancy are
different claims.

### Good

1. Identify the geometric objects and their transformation laws.
2. Show that both sides of the equation are tensors of the same type.
3. State whether the transformation is:
   - a passive coordinate re-description;
   - an active map between physically equivalent states;
   - a gauge redundancy;
   - or a physical transformation producing a distinct state.
4. Use only the consequences appropriate to that category.

## 7. Claiming uniqueness from one successful example

### Bad

> This formula satisfies all the stated conditions. Therefore it is the unique
> answer.

Verification proves existence, not uniqueness.

### Good

1. Parameterize the full admissible solution space.
2. Apply every condition to the general candidate.
3. Solve the resulting equations.
4. List the surviving normalization, sign, additive, gauge, boundary, or
   total-derivative freedoms.
5. Distinguish freedoms fixed by convention from freedoms requiring new
   physics.
6. State uniqueness only modulo the freedoms actually proved irrelevant.

## 8. Suppressing alternative branches

### Bad

> Solving the constraint gives the standard branch, so we discard the other
> root.

No reason has been given for discarding it. Familiarity is not a physical
selection principle.

### Good

1. Retain every mathematical branch produced by the assumptions.
2. Check each branch for regularity, causality, positivity, dimensional
   consistency, boundary behavior, and the required limiting regime.
3. Identify exactly which additional principle excludes a branch.
4. If no stated principle excludes it, report that the derivation is not
   unique.

## 9. Hiding a local-to-global leap

### Bad

> The connection vanishes at one point in a suitable coordinate system.
> Therefore the spacetime is globally flat.

A pointwise normal-coordinate statement does not imply vanishing curvature or
global triviality.

### Good

1. State the domain of the coordinate construction.
2. Distinguish vanishing connection coefficients at a point from vanishing
   curvature on a neighborhood.
3. Identify any topology, completeness, integrability, or exponential-map
   hypotheses needed for a global claim.
4. Make only the strongest conclusion supported by those hypotheses.

## 10. Omitting algebra while claiming a derivation

### Bad

> Applying symmetry and conservation, one immediately obtains the result.

This is a summary, not a derivation. The reader cannot determine which symmetry
condition was used, whether all variables were transformed, or whether an
additional assumption entered.

### Good

Present the chain explicitly:

1. write the general candidate;
2. write each transformation;
3. substitute it into the governing condition;
4. simplify line by line;
5. identify the equation produced by each assumption;
6. solve the equations without skipping nontrivial steps;
7. verify the final expression against the original conditions.

Compact prose is welcome only after the mathematics remains reproducible.

## 11. A complete derivation template

A strong derivation normally has the following visible structure:

### Claim

State the exact result and its domain.

### Inputs

List physical principles, mathematical assumptions, conventions, definitions,
and imported theorems separately.

### General candidate

Write the broadest object allowed before imposing the principles.

### Constraints

Translate each principle into mathematics and apply the constraints one at a
time.

### Solution

Solve the resulting algebraic, differential, variational, or functional
equations with all intermediate steps needed for reproduction.

### Branches and uniqueness

Classify alternatives and state exactly what remains free.

### Checks

Verify dimensions, transformations, limits, special cases, and degeneracies.

### Dependency statement

End by stating which assumptions produced which parts of the result and which
later conclusions may safely use it.
