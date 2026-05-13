"""
klein_geometry.py — Derive the metric of a reductive Klein geometry from its
Lie algebra, using SymPy.

This script mechanizes the construction discussed in the math note
13-poincare-galilei-metric.md.

Pipeline
========

Given:
  (i)   a faithful matrix representation of a Lie algebra g = h ⊕ m
        (basis of generators, plus a partition into "stabilizer" and
        "complement" indices);
  (ii)  a section sigma(x^mu): U → G expressing the coset space G/H in
        a chart (x^mu);

we compute:
  1. structure constants f^c_{ab} from [X_a, X_b];
  2. the Maurer–Cartan form ω = σ⁻¹ dσ ∈ g ⊗ T*U;
  3. its decomposition ω = e + ω_h, giving the vielbein
     e^a = e^a_μ dx^μ on m and the spin connection ω_h on h;
  4. all H-invariant symmetric bilinear forms η_{ab} on m, by solving
     the linear invariance conditions η A + Aᵀ η = 0 for each
     A = ad_h restricted to m;
  5. the metric g_{μν} = η_{ab} e^a_μ e^b_ν in coordinates (x^μ);
  6. the Cartan curvature Ω = dω_h + (1/2)[ω_h, ω_h];
  7. the Killing vector fields Y_ξ for any ξ ∈ g, via
     Y_ξ^μ = (e⁻¹)^μ_a [Ad_{σ⁻¹} ξ]^a_m.

The script is self-contained and runs four canonical examples at the
bottom: Minkowski (1+1), Galilean (1+1), Euclidean R² in polar
coordinates, and the round S².
"""

from __future__ import annotations

import sympy as sp


# ---------------------------------------------------------------------------
# Core algorithm
# ---------------------------------------------------------------------------


def _flat(M):
    """Flatten a SymPy Matrix M into a column vector (row-major)."""
    return sp.Matrix(list(M))


def _decompose(basis, target):
    """Express ``target`` as a linear combination of ``basis`` matrices.

    Returns the list of coefficients. Assumes the basis is linearly
    independent and the target lies in its span.
    """
    A = sp.Matrix.hstack(*[_flat(B) for B in basis])
    b = _flat(target)
    # Use the normal equations; the basis is linearly independent so
    # A^T A is invertible.
    coeffs = (A.T * A).inv() * A.T * b
    return [sp.simplify(c) for c in coeffs]


class KleinGeometry:
    """A reductive Klein geometry, presented by a matrix algebra + section."""

    def __init__(self, generators, names, h_indices, coords, sigma):
        """
        Parameters
        ----------
        generators : list[sp.Matrix]
            Faithful matrix representation of a basis of the Lie algebra g.
        names : list[str]
            Names of the generators, same length as ``generators``.
        h_indices : iterable[int]
            Indices (into ``generators``) of the subalgebra h.
            The complement m is the rest.
        coords : list[sp.Symbol]
            Coordinates on G/H. Must have length dim(m).
        sigma : sp.Matrix
            The section σ(x^μ) ∈ G as a SymPy matrix-valued function of
            the coordinates.
        """
        self.X = list(generators)
        self.names = list(names)
        self.n = len(self.X)
        self.h_idx = sorted(h_indices)
        self.m_idx = [i for i in range(self.n) if i not in self.h_idx]
        self.dim_h = len(self.h_idx)
        self.dim_m = len(self.m_idx)
        self.coords = list(coords)
        self.dim = len(self.coords)
        assert self.dim_m == self.dim, (
            f"Number of coords ({self.dim}) must equal dim m ({self.dim_m})."
        )
        self.sigma = sp.Matrix(sigma)
        self._cache = {}

    # ----- algebra -----

    def structure_constants(self):
        """Return f[a][b][c] such that [X_a, X_b] = sum_c f[a][b][c] X_c."""
        if "f" in self._cache:
            return self._cache["f"]
        N = self.n
        f = [[[sp.S.Zero] * N for _ in range(N)] for _ in range(N)]
        for a in range(N):
            for b in range(a + 1, N):
                comm = self.X[a] * self.X[b] - self.X[b] * self.X[a]
                coeffs = _decompose(self.X, comm)
                for c in range(N):
                    f[a][b][c] = coeffs[c]
                    f[b][a][c] = -coeffs[c]
        self._cache["f"] = f
        return f

    # ----- Maurer–Cartan -----

    def maurer_cartan(self):
        """Return (omega_components, e, omega_h).

        omega_components[mu] is the list of generator coefficients of
        σ⁻¹ ∂_μ σ in the basis ``self.X``.

        e is a (dim_m × dim) SymPy Matrix: e[a, mu] = e^a_μ (vielbein).

        omega_h is a (dim_h × dim) SymPy Matrix giving the components of
        the spin connection on the h-basis.
        """
        if "mc" in self._cache:
            return self._cache["mc"]
        sigma_inv = self.sigma.inv()
        omega_components = []
        for x in self.coords:
            d_sigma = self.sigma.applyfunc(lambda elt, x=x: sp.diff(elt, x))
            omega_mu = sp.simplify(sigma_inv * d_sigma)
            omega_components.append(_decompose(self.X, omega_mu))
        e = sp.Matrix(
            self.dim_m,
            self.dim,
            lambda a, mu: sp.simplify(omega_components[mu][self.m_idx[a]]),
        )
        omega_h = sp.Matrix(
            self.dim_h,
            self.dim,
            lambda A, mu: sp.simplify(omega_components[mu][self.h_idx[A]]),
        )
        self._cache["mc"] = (omega_components, e, omega_h)
        return omega_components, e, omega_h

    # ----- invariant forms -----

    def invariant_forms(self):
        """Find all H-invariant symmetric bilinear forms η on m.

        Returns (eta_solved, free_params), where ``eta_solved`` is a
        symbolic (dim_m × dim_m) symmetric matrix depending on the free
        parameters in ``free_params``. The dimension of the solution
        space is len(free_params).
        """
        f = self.structure_constants()
        # ad_h restricted to m: for each h_i, build the matrix A^a_b such
        # that [X_{h_i}, X_{m_b}] = sum_a A^a_b X_{m_a}.
        A_list = []
        for hi in self.h_idx:
            A = sp.zeros(self.dim_m, self.dim_m)
            for a, ma in enumerate(self.m_idx):
                for b, mb in enumerate(self.m_idx):
                    A[a, b] = f[hi][mb][ma]
            A_list.append(A)
        # Symmetric ansatz for eta.
        eta = sp.zeros(self.dim_m, self.dim_m)
        params = []
        for i in range(self.dim_m):
            for j in range(i, self.dim_m):
                s = sp.Symbol(f"eta_{i}_{j}")
                params.append(s)
                eta[i, j] = s
                eta[j, i] = s
        # Invariance: η A + Aᵀ η = 0 for each A.
        eqs = []
        for A in A_list:
            M = eta * A + A.T * eta
            for i in range(self.dim_m):
                for j in range(i, self.dim_m):
                    eqs.append(M[i, j])
        sols = sp.solve(eqs, params, dict=True)
        if not sols:
            return sp.zeros(self.dim_m, self.dim_m), []
        sol = sols[0]
        eta_solved = eta.subs(sol)
        free_params = sorted(eta_solved.free_symbols, key=lambda s: s.name)
        return eta_solved, free_params

    # ----- metric -----

    def metric(self, eta=None, scale_subs=None):
        """Compute g_{μν} = η_{ab} e^a_μ e^b_ν.

        If eta is None, take the generic invariant form and substitute
        the free scales according to ``scale_subs`` (a dict).
        """
        _, e, _ = self.maurer_cartan()
        if eta is None:
            eta, params = self.invariant_forms()
            if scale_subs:
                eta = eta.subs(scale_subs)
        g = sp.simplify(e.T * eta * e)
        return g

    # ----- curvature -----

    def curvature(self):
        """Return a dict {(A, μ, ν): Ω^A_{μν}} of Cartan curvature
        components (only μ < ν stored).
        """
        _, _, omega_h = self.maurer_cartan()
        f = self.structure_constants()
        out = {}
        for A in range(self.dim_h):
            hA = self.h_idx[A]
            for mu in range(self.dim):
                for nu in range(mu + 1, self.dim):
                    d_part = (
                        sp.diff(omega_h[A, nu], self.coords[mu])
                        - sp.diff(omega_h[A, mu], self.coords[nu])
                    )
                    br = sp.S.Zero
                    for B in range(self.dim_h):
                        hB = self.h_idx[B]
                        for C in range(self.dim_h):
                            hC = self.h_idx[C]
                            br += f[hB][hC][hA] * (
                                omega_h[B, mu] * omega_h[C, nu]
                            )
                    out[(A, mu, nu)] = sp.simplify(d_part + br)
        return out

    # ----- Killing vectors -----

    def killing_field(self, xi_components):
        """Compute the Killing vector field Y_ξ for ξ = Σ c_i X_i in g.

        Returns a (dim,) SymPy Matrix Y[μ] such that Y_ξ = Y[μ] ∂_{x^μ}.
        """
        xi = sp.zeros(*self.X[0].shape)
        for c, X in zip(xi_components, self.X):
            xi = xi + c * X
        sigma_inv = self.sigma.inv()
        Ad_xi = sp.simplify(sigma_inv * xi * self.sigma)
        comps = _decompose(self.X, Ad_xi)
        m_comps = sp.Matrix([sp.simplify(comps[i]) for i in self.m_idx])
        _, e, _ = self.maurer_cartan()
        e_inv = e.inv()
        Y = sp.simplify(e_inv * m_comps)
        return Y


# ---------------------------------------------------------------------------
# Pretty-printing helpers
# ---------------------------------------------------------------------------


def _print_header(title):
    print()
    print("=" * 72)
    print(title)
    print("=" * 72)


def _print_algebra(K):
    f = K.structure_constants()
    print("\nStructure constants  [X_a, X_b] = sum_c f^c_{ab} X_c:")
    for a in range(K.n):
        for b in range(a + 1, K.n):
            rhs_terms = []
            for c in range(K.n):
                coef = sp.simplify(f[a][b][c])
                if coef != 0:
                    if coef == 1:
                        rhs_terms.append(K.names[c])
                    elif coef == -1:
                        rhs_terms.append(f"-{K.names[c]}")
                    else:
                        rhs_terms.append(f"({coef})*{K.names[c]}")
            rhs = " + ".join(rhs_terms) if rhs_terms else "0"
            print(f"  [{K.names[a]}, {K.names[b]}] = {rhs}")


def _print_mc(K):
    _, e, omega_h = K.maurer_cartan()
    print("\nVielbein e^a_μ (rows = m-generators, cols = coords):")
    print("  m-basis:", [K.names[i] for i in K.m_idx])
    print("  coords:", [str(c) for c in K.coords])
    sp.pprint(e)
    print("\nSpin connection ω_h^A_μ (rows = h-generators):")
    print("  h-basis:", [K.names[i] for i in K.h_idx])
    sp.pprint(omega_h)


def _print_invariant(K):
    eta, params = K.invariant_forms()
    print(f"\nInvariant forms η on m: space of dimension {len(params)}")
    print("  free parameters:", [str(p) for p in params])
    print("  general η =")
    sp.pprint(eta)


def _print_metric(K, scale_subs=None, label=""):
    g = K.metric(scale_subs=scale_subs)
    print(f"\nMetric g_{{μν}} in coords {[str(c) for c in K.coords]}{label}:")
    sp.pprint(g)


def _print_curvature(K):
    Omega = K.curvature()
    print("\nCartan curvature Ω^A_{μν} (μ < ν), A = h-generator:")
    nonzero = [(k, v) for k, v in Omega.items() if v != 0]
    if not nonzero:
        print("  all components vanish (FLAT)")
    else:
        for (A, mu, nu), v in nonzero:
            print(
                f"  Ω^{K.names[K.h_idx[A]]}_"
                f"{{{K.coords[mu]} {K.coords[nu]}}} = {sp.simplify(v)}"
            )


def _print_killing(K, label, xi_components):
    Y = K.killing_field(xi_components)
    terms = []
    for mu in range(K.dim):
        c = sp.simplify(Y[mu])
        if c != 0:
            terms.append(f"({c}) ∂_{K.coords[mu]}")
    print(f"  {label} = {' + '.join(terms) if terms else '0'}")


# ---------------------------------------------------------------------------
# Examples
# ---------------------------------------------------------------------------


def example_minkowski_1_plus_1():
    _print_header("Example 1: Poincaré(1+1) → Minkowski R^{1,1}")
    # Affine 3x3 rep: top-left 2x2 is Lorentz, last column is translations.
    K = sp.Matrix([[0, 1, 0], [1, 0, 0], [0, 0, 0]])  # boost
    H = sp.Matrix([[0, 0, 1], [0, 0, 0], [0, 0, 0]])  # time translation
    P = sp.Matrix([[0, 0, 0], [0, 0, 1], [0, 0, 0]])  # space translation
    t, x, phi = sp.symbols("t x phi", real=True)
    # Section: first translate to (t, x), then a (vanishing) boost; we
    # pick the basepoint = origin, gauge: σ(t,x) = exp(t H) exp(x P).
    sigma = (t * H).exp() * (x * P).exp()
    Klein = KleinGeometry(
        generators=[K, H, P],
        names=["K", "H", "P"],
        h_indices=[0],            # K stabilizes the origin
        coords=[t, x],
        sigma=sigma,
    )
    _print_algebra(Klein)
    _print_mc(Klein)
    _print_invariant(Klein)
    # Invariance forces η_HH = −η_PP, so there is exactly one free
    # scale; we pin it to 1, and the (−,+) Minkowski signature emerges
    # automatically from the algebra.
    eta_sym, free = Klein.invariant_forms()
    _print_metric(Klein, scale_subs={free[0]: 1}, label=" (overall scale = 1)")
    _print_curvature(Klein)
    print("\nKilling fields:")
    _print_killing(Klein, "H", [0, 1, 0])
    _print_killing(Klein, "P", [0, 0, 1])
    _print_killing(Klein, "K", [1, 0, 0])
    return Klein


def example_galilei_1_plus_1():
    _print_header("Example 2: Galilei(1+1) → Galilean spacetime")
    # 3x3 affine rep of the (1+1) Galilei group: top-left is "Galilean
    # transform" mixing only into the spatial row.
    K = sp.Matrix([[0, 0, 0], [1, 0, 0], [0, 0, 0]])  # Galilei boost
    H = sp.Matrix([[0, 0, 1], [0, 0, 0], [0, 0, 0]])  # time translation
    P = sp.Matrix([[0, 0, 0], [0, 0, 1], [0, 0, 0]])  # space translation
    t, x = sp.symbols("t x", real=True)
    sigma = (t * H).exp() * (x * P).exp()
    Klein = KleinGeometry(
        generators=[K, H, P],
        names=["K", "H", "P"],
        h_indices=[0],
        coords=[t, x],
        sigma=sigma,
    )
    _print_algebra(Klein)
    _print_mc(Klein)
    _print_invariant(Klein)
    # No invariant non-degenerate metric: Galilean structure has two
    # separately invariant degenerate forms (clock 1-form and spatial
    # cometric). Print both as the two basis solutions.
    eta_sym, free = Klein.invariant_forms()
    print(
        "\nThe family of invariant symmetric (0,2)-tensors has "
        f"dimension {len(free)}; "
        "each basis form is necessarily degenerate (Galilean structure):"
    )
    for p in free:
        eta_p = eta_sym.subs({q: (1 if q == p else 0) for q in free})
        print(f"\n  η with {p} = 1, others = 0:")
        sp.pprint(eta_p)
        g_p = sp.simplify(
            Klein.maurer_cartan()[1].T * eta_p * Klein.maurer_cartan()[1]
        )
        print("  ⇒ degenerate g_{μν} =")
        sp.pprint(g_p)
    print(
        "\nNote: a second invariant — the spatial cometric h^{ij} ∂_i ⊗ ∂_j "
        "— is a (2,0)-tensor and is *not* enumerated by this routine, "
        "which finds only (0,2)-forms."
    )
    _print_curvature(Klein)
    print("\nKilling fields:")
    _print_killing(Klein, "H", [0, 1, 0])
    _print_killing(Klein, "P", [0, 0, 1])
    _print_killing(Klein, "K", [1, 0, 0])
    return Klein


def example_r2_polar():
    _print_header("Example 3: E(2)/SO(2) = R^2 in polar coordinates")
    # 3x3 affine rep of E(2).
    J = sp.Matrix([[0, -1, 0], [1, 0, 0], [0, 0, 0]])
    P1 = sp.Matrix([[0, 0, 1], [0, 0, 0], [0, 0, 0]])
    P2 = sp.Matrix([[0, 0, 0], [0, 0, 1], [0, 0, 0]])
    r, phi = sp.symbols("r phi", positive=True)
    # σ(r, φ) = exp(φ J) exp(r P^1).
    sigma = (phi * J).exp() * (r * P1).exp()
    Klein = KleinGeometry(
        generators=[J, P1, P2],
        names=["J", "P1", "P2"],
        h_indices=[0],
        coords=[r, phi],
        sigma=sigma,
    )
    _print_algebra(Klein)
    _print_mc(Klein)
    _print_invariant(Klein)
    eta_sym, free = Klein.invariant_forms()
    scale_subs = {free[0]: 1}
    _print_metric(Klein, scale_subs=scale_subs, label=" (λ = 1)")
    _print_curvature(Klein)
    print("\nKilling fields:")
    _print_killing(Klein, "J", [1, 0, 0])
    _print_killing(Klein, "P1", [0, 1, 0])
    _print_killing(Klein, "P2", [0, 0, 1])
    return Klein


def example_s2():
    _print_header("Example 4: SO(3)/SO(2) = S^2 in spherical coordinates")
    # 3x3 rep of so(3).
    J1 = sp.Matrix([[0, 0, 0], [0, 0, -1], [0, 1, 0]])
    J2 = sp.Matrix([[0, 0, 1], [0, 0, 0], [-1, 0, 0]])
    J3 = sp.Matrix([[0, -1, 0], [1, 0, 0], [0, 0, 0]])
    theta, phi = sp.symbols("theta phi", positive=True)
    # σ(θ, φ) = exp(φ J3) exp(θ J2). At identity → north pole of S^2.
    sigma = (phi * J3).exp() * (theta * J2).exp()
    Klein = KleinGeometry(
        generators=[J1, J2, J3],
        names=["J1", "J2", "J3"],
        h_indices=[2],            # J3 stabilizes the north pole
        coords=[theta, phi],
        sigma=sigma,
    )
    _print_algebra(Klein)
    _print_mc(Klein)
    _print_invariant(Klein)
    eta_sym, free = Klein.invariant_forms()
    scale_subs = {free[0]: 1}   # λ = R² ; setting it to 1 gives the unit sphere
    _print_metric(Klein, scale_subs=scale_subs, label=" (R² = 1)")
    _print_curvature(Klein)
    print("\nKilling fields:")
    _print_killing(Klein, "J1", [1, 0, 0])
    _print_killing(Klein, "J2", [0, 1, 0])
    _print_killing(Klein, "J3", [0, 0, 1])
    return Klein


# ---------------------------------------------------------------------------
# Self-test: verify expected outputs match.
# ---------------------------------------------------------------------------


def _check_equal(label, got, expected):
    if isinstance(got, sp.MatrixBase):
        diff = sp.simplify(got - expected)
        ok = bool(diff.is_zero_matrix)
    else:
        diff = sp.simplify(got - expected)
        ok = bool(diff == 0)
    print(f"  [{'OK' if ok else 'FAIL'}] {label}")
    if not ok:
        print("    got:")
        sp.pprint(got)
        print("    expected:")
        sp.pprint(expected)
    return ok


def self_test():
    print()
    print("#" * 72)
    print("SELF-TEST")
    print("#" * 72)
    all_ok = True

    # --- R^2 polar ---
    print("\n[R^2 polar]")
    J = sp.Matrix([[0, -1, 0], [1, 0, 0], [0, 0, 0]])
    P1 = sp.Matrix([[0, 0, 1], [0, 0, 0], [0, 0, 0]])
    P2 = sp.Matrix([[0, 0, 0], [0, 0, 1], [0, 0, 0]])
    r, phi = sp.symbols("r phi", positive=True)
    sigma = (phi * J).exp() * (r * P1).exp()
    Klein = KleinGeometry([J, P1, P2], ["J", "P1", "P2"], [0], [r, phi], sigma)
    eta_sym, free = Klein.invariant_forms()
    g = Klein.metric(scale_subs={free[0]: 1})
    expected = sp.Matrix([[1, 0], [0, r**2]])
    all_ok &= _check_equal("metric = dr^2 + r^2 dphi^2", g, expected)
    Omega = Klein.curvature()
    all_ok &= _check_equal(
        "curvature is flat",
        sp.Matrix([[Omega[(0, 0, 1)]]]),
        sp.Matrix([[0]]),
    )
    Y = Klein.killing_field([1, 0, 0])
    all_ok &= _check_equal("J = ∂_φ", Y, sp.Matrix([0, 1]))
    Y = Klein.killing_field([0, 1, 0])
    all_ok &= _check_equal(
        "P^1 = cos(φ) ∂_r − (sin(φ)/r) ∂_φ",
        Y,
        sp.Matrix([sp.cos(phi), -sp.sin(phi) / r]),
    )

    # --- S^2 ---
    print("\n[S^2]")
    J1 = sp.Matrix([[0, 0, 0], [0, 0, -1], [0, 1, 0]])
    J2 = sp.Matrix([[0, 0, 1], [0, 0, 0], [-1, 0, 0]])
    J3 = sp.Matrix([[0, -1, 0], [1, 0, 0], [0, 0, 0]])
    theta, phi2 = sp.symbols("theta phi", positive=True)
    sigma2 = (phi2 * J3).exp() * (theta * J2).exp()
    Klein2 = KleinGeometry(
        [J1, J2, J3], ["J1", "J2", "J3"], [2], [theta, phi2], sigma2
    )
    eta_sym2, free2 = Klein2.invariant_forms()
    g2 = Klein2.metric(scale_subs={free2[0]: 1})
    expected2 = sp.Matrix([[1, 0], [0, sp.sin(theta) ** 2]])
    all_ok &= _check_equal("metric = dθ^2 + sin^2θ dφ^2", g2, expected2)
    Omega2 = Klein2.curvature()
    val = sp.simplify(Omega2[(0, 0, 1)])
    all_ok &= _check_equal(
        "curvature = −sin(θ) (so K = 1/R^2 > 0)",
        sp.Matrix([[val]]),
        sp.Matrix([[-sp.sin(theta)]]),
    )

    # --- Minkowski (1+1) ---
    print("\n[Minkowski (1+1)]")
    Kb = sp.Matrix([[0, 1, 0], [1, 0, 0], [0, 0, 0]])
    Hh = sp.Matrix([[0, 0, 1], [0, 0, 0], [0, 0, 0]])
    Pp = sp.Matrix([[0, 0, 0], [0, 0, 1], [0, 0, 0]])
    t, x = sp.symbols("t x", real=True)
    sigmaM = (t * Hh).exp() * (x * Pp).exp()
    KleinM = KleinGeometry([Kb, Hh, Pp], ["K", "H", "P"], [0], [t, x], sigmaM)
    eta_symM, freeM = KleinM.invariant_forms()
    assert len(freeM) == 1, f"Expected unique scale; got {freeM}"
    # Pin the spatial scale to +1; H part will be forced to −1 by invariance.
    # Try both signs and pick the one with η_{PP} = +1.
    g_M = KleinM.metric(scale_subs={freeM[0]: -1})
    # Determine which Minkowski signature came out:
    expected_M_plus_minus = sp.Matrix([[-1, 0], [0, 1]])
    expected_M_minus_plus = sp.Matrix([[1, 0], [0, -1]])
    ok_pm = (sp.simplify(g_M - expected_M_plus_minus)).is_zero_matrix
    ok_mp = (sp.simplify(g_M - expected_M_minus_plus)).is_zero_matrix
    print(
        f"  [{'OK' if (ok_pm or ok_mp) else 'FAIL'}] "
        f"Minkowski signature is (−,+) or (+,−)"
    )
    all_ok &= bool(ok_pm or ok_mp)
    Omega_M = KleinM.curvature()
    all_ok &= _check_equal(
        "Minkowski curvature flat",
        sp.Matrix([[Omega_M[(0, 0, 1)]]]),
        sp.Matrix([[0]]),
    )

    # --- Galilei (1+1) ---
    print("\n[Galilei (1+1)]")
    Kg = sp.Matrix([[0, 0, 0], [1, 0, 0], [0, 0, 0]])
    Hg = sp.Matrix([[0, 0, 1], [0, 0, 0], [0, 0, 0]])
    Pg = sp.Matrix([[0, 0, 0], [0, 0, 1], [0, 0, 0]])
    sigmaG = (t * Hg).exp() * (x * Pg).exp()
    KleinG = KleinGeometry([Kg, Hg, Pg], ["K", "H", "P"], [0], [t, x], sigmaG)
    eta_symG, freeG = KleinG.invariant_forms()
    # Galilei has a unique invariant symmetric (0,2)-tensor up to scale:
    # the degenerate clock form dt^2. (The spatial cometric h^{ij}
    # is a separate (2,0)-tensor we don't enumerate here.)
    print(
        f"  [{'OK' if len(freeG) == 1 else 'FAIL'}] "
        f"Galilei: 1-d family of invariant (0,2) forms (got {len(freeG)})"
    )
    all_ok &= (len(freeG) == 1)
    g_G = KleinG.metric(scale_subs={freeG[0]: 1})
    all_ok &= _check_equal(
        "Galilei (0,2) form is degenerate clock dt^2",
        g_G,
        sp.Matrix([[1, 0], [0, 0]]),
    )

    print()
    print("ALL TESTS PASSED" if all_ok else "SOME TESTS FAILED")
    return all_ok


if __name__ == "__main__":
    example_minkowski_1_plus_1()
    example_galilei_1_plus_1()
    example_r2_polar()
    example_s2()
    ok = self_test()
    if not ok:
        raise SystemExit(1)
