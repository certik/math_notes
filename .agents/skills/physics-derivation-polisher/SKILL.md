---
name: physics-derivation-polisher
description: Polish, audit, rewrite, or extend physics notes so their derivations are explicit, mathematically complete, symmetry-first, assumption-minimal, and non-circular. Use this skill whenever a user asks to improve a physics derivation, add a new derivation to physics notes, expose hidden assumptions, derive a familiar law from principles, check whether a physics argument is circular or complete, compare relativistic and non-relativistic reasoning, or turn an informal physics explanation into an auditable step-by-step argument.
compatibility: Requires access to the physics note and any earlier notes or definitions on which it depends.
---

# Physics Derivation Polisher

## Purpose

Turn physics notes into auditable derivations. Postulate as little as possible,
derive as much as possible, and make the logical dependency chain explicit and
non-circular.

The goal is not merely to obtain a familiar formula. The note should explain
why that formula follows, which assumptions are responsible, whether other
solutions remain possible, and where any additional mathematical conditions
enter.

Before revising a substantial derivation, read
[`references/derivation-examples.md`](references/derivation-examples.md). It
contains paired examples of weak and strong derivations and explains the
failure modes this skill is designed to prevent.

## Workflow

### 1. Read the dependency chain

Read the target note and the earlier notes, definitions, or results it invokes.
Do not assess an argument in isolation when its assumptions may have been
established elsewhere.

Identify:

- the result being derived;
- the physical system and regime;
- the primitive objects and observables;
- the results imported from earlier work;
- every explicit and implicit assumption;
- the order in which the claims depend on one another.

### 2. Build an assumptions ledger

Classify each input as one of:

- **Physical principle:** an empirical or operational requirement such as
  relativity, isotropy, causality, locality, or conservation.
- **Mathematical assumption:** regularity, dimensionality, topology,
  differentiability, measurability, boundary conditions, or global structure.
- **Convention:** units, signs, normalization, coordinates, or notation.
- **Definition:** terminology introduced without asserting a physical law.
- **Imported theorem:** a result already proved elsewhere and cited at the
  exact point of use.
- **Derived conclusion:** anything that must not reappear as an assumption.

If an assumption is stronger than needed, weaken it. If it is equivalent to the
desired conclusion, replace it with genuinely prior input or identify the
argument as circular.

### 3. Reconstruct the derivation

Begin with the most general admissible ansatz. Translate each physical
principle into a precise equation, transformation law, invariance condition, or
inequality. Apply the conditions one at a time and show what each one removes.

Use the complete symmetry family rather than a convenient special
transformation. Keep alternative branches until a stated physical or
mathematical condition excludes them.

Do not silently assume the mathematical packaging that the derivation is meant
to produce. In particular, do not import a metric, action, conserved quantity,
four-vector, dispersion relation, connection, or transformation law merely
because the standard theory usually presents the result that way.

### 4. Audit the logic

Check that:

- every symbol is defined before use;
- every nontrivial equality has a stated reason;
- frame transformations apply to the entire physical process;
- local claims are not presented as global claims;
- Lie-algebra statements are not silently promoted to group-level statements;
- coordinate formulas have an invariant interpretation;
- existence and uniqueness are proved separately;
- all allowed ambiguities and branches are stated;
- regularity assumptions appear exactly where they are used;
- the conclusion is no stronger than the argument.

### 5. Validate the result

Check dimensions, signs, transformation properties, limiting regimes, special
cases, degeneracies, and consistency with the original assumptions. A familiar
answer is supporting evidence, not a substitute for the derivation.

### 6. Revise the note

Preserve the author's intended physical program and notation unless correction
is necessary. Add enough intermediate mathematics that a careful reader can
reproduce every step. Prefer equations and short explanatory paragraphs over
phrases such as "clearly", "obviously", or "it follows" when an actual argument
is needed.

For MyST Markdown in this repository:

- use `$...$` for inline mathematics;
- use `$$...$$` for display mathematics;
- use one level-one title and do not skip heading levels;
- keep prose, equations, and lists valid MyST Markdown.

## Meta-program

### Foundations

1. **State the target precisely.** Identify exactly what is being derived and
   what would count as existence, uniqueness, or classification.

2. **Maintain an assumptions ledger.** Separate physical principles,
   mathematical regularity assumptions, conventions and units, definitions,
   imported theorems, and derived conclusions.

3. **Use minimal assumptions.** Remove assumptions that are redundant, stronger
   than necessary, or equivalent to the desired conclusion.

4. **Never assume the structure being derived.** Do not silently introduce a
   metric, action, conserved quantity, transformation law, four-vector,
   dispersion relation, or geometric interpretation if deriving it is part of
   the goal.

5. **Start from operational physics.** Explain assumptions through possible
   measurements, frame comparisons, experiments, or observable distinctions,
   not only through formal terminology.

6. **Translate physical principles into precise mathematics.** Express
   homogeneity, isotropy, relativity, causality, covariance, conservation, and
   locality as equations or invariance conditions.

### Derivation

7. **Begin with the most general admissible ansatz.** Apply each principle
   systematically and show how it removes degrees of freedom.

8. **Use the full symmetry, not a convenient special case.** A single boost,
   rotation, scaling relation, or coordinate system may suggest the answer but
   cannot establish it.

9. **Distinguish physical symmetry, coordinate covariance, and gauge
   redundancy.** Do not use these notions interchangeably.

10. **Derive geometry from symmetry when possible.** Identify the symmetry
    group, stabilizer, homogeneous space, tangent representation, and invariant
    tensors rather than postulating geometric structures.

11. **Make branch choices explicit.** If the assumptions permit multiple
    groups, stabilizers, signatures, geometries, or solution families, classify
    them and identify the additional physical input selecting a branch.

12. **Preserve non-circular ordering.** Prefer a chain such as

    $$
    \text{physical principles}
    \longrightarrow
    \text{symmetry}
    \longrightarrow
    \text{geometry}
    \longrightarrow
    \text{dynamics}
    \longrightarrow
    \text{action}
    \longrightarrow
    \text{conserved quantities}.
    $$

13. **Introduce variational principles only after dynamics when feasible.**
    First determine the allowed equations of motion; then establish whether an
    action exists and how uniquely it represents them.

14. **Prove existence separately from uniqueness.** Showing that a familiar
    formula works does not show that it is forced. State all permitted
    ambiguities, such as normalization, total derivatives, or additive
    constants.

15. **Establish completeness.** Explain why no nonstandard, non-variational,
    degenerate, or otherwise overlooked alternatives satisfy the same
    assumptions.

16. **State regularity assumptions exactly where needed.** Continuity,
    differentiability, measurability, analyticity, locality, and global
    hypotheses must not be hidden inside a functional-equation argument.

17. **Separate local from global claims.** Distinguish Lie-algebraic from
    group-level results, pointwise normal forms from global coordinates, and
    local covariance from global topology.

18. **Compare the same physical process across frames.** Transform the entire
    setup consistently, including states, conserved quantities, and dissipative
    terms, rather than transforming isolated formulas.

19. **Prefer invariant or tensorial statements.** Coordinate formulas should be
    derived representations of an underlying geometric statement, not the
    foundation of the argument.

### Verification and exposition

20. **Test every derivation structurally.** Check dimensions, transformation
    laws, limiting regimes, special cases, degeneracies, and consistency with
    the original assumptions.

21. **Expose rejected alternatives.** Explain why tempting shorter arguments
    fail, what extra freedom they leave, and which principle removes it.

22. **Avoid overclaiming.** Mark conjectural steps, imported theorems,
    additional physical assumptions, and unresolved global issues explicitly.

23. **Present the logical flow visibly.** Each section should say what is
    assumed, what is proved, and which later steps depend on it. The reader
    should be able to audit the derivation as a dependency graph.

## Completion standard

A polished derivation is complete only when a careful reader can:

1. list every assumption without reverse-engineering the prose;
2. reproduce each mathematical step;
3. identify where each physical principle enters;
4. see why competing solutions or branches are retained or excluded;
5. distinguish existence, uniqueness, and convention;
6. verify that the argument does not use its conclusion as an input.
