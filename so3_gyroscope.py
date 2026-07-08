import sympy as sp

# 1. Define symbolic variables
delta, eta, psi = sp.symbols('delta eta psi', real=True)
d_delta, d_eta, d_psi = sp.symbols('d_delta d_eta d_psi', real=True)
dd_delta, dd_eta, dd_psi = sp.symbols('dd_delta dd_eta dd_psi', real=True)

I1, I3, m, cz, g = sp.symbols('I1 I3 m cz g', positive=True)

coords = [delta, eta, psi]
vels = [d_delta, d_eta, d_psi]
accels = [dd_delta, dd_eta, dd_psi]

# 2. Define the metric tensor g_μν (metric3)
# Row 0: delta
# Row 1: eta
# Row 2: psi
metric = sp.Matrix([
    [I1, 0, 0],
    [0, I1 * sp.cos(delta)**2 + I3 * sp.sin(delta)**2, I3 * sp.sin(delta)],
    [0, I3 * sp.sin(delta), I3]
])

print("--- Metric Tensor g_μν ---")
sp.pprint(metric)

# 3. Compute the inverse metric g^μν
inv_metric = sp.simplify(metric.inv())
print("\n--- Inverse Metric Tensor g^μν ---")
sp.pprint(inv_metric)

# 4. Compute Christoffel symbols of the first kind:
# Γ_αβγ = 0.5 * (dg_{βγ}/dx^α + dg_{αγ}/dx^β - dg_{αβ}/dx^γ)
# Note: we use indices 0, 1, 2 corresponding to delta, eta, psi.
def get_g_first(a, b, c):
    # partial derivatives
    term1 = sp.diff(metric[b, c], coords[a])
    term2 = sp.diff(metric[a, c], coords[b])
    term3 = sp.diff(metric[a, b], coords[c])
    return sp.simplify(0.5 * (term1 + term2 - term3))

# Compute Christoffel symbols of the second kind:
# Γ^μ_αβ = g^μγ * Γ_αβγ
def get_christoffel(mu, a, b):
    val = 0
    for gamma in range(3):
        val += inv_metric[mu, gamma] * get_g_first(a, b, gamma)
    return sp.simplify(val)

# 5. Compute geodesic acceleration term: sum_{a,b} Γ^mu_ab * dot{x}^a * dot{x}^b
geodesic_terms = []
for mu in range(3):
    term = 0
    for a in range(3):
        for b in range(3):
            term += get_christoffel(mu, a, b) * vels[a] * vels[b]
    geodesic_terms.append(sp.simplify(term))

# 6. Define the Potential Energy and compute Potential Forces
# V = m * g * cz * cos(delta) * cos(eta)
V = m * g * cz * sp.cos(delta) * sp.cos(eta)
print(f"\nPotential Energy V: {V}")

# F^μ = -g^μν * dV/dx^ν
dV = sp.Matrix([sp.diff(V, c) for c in coords])
potential_forces = sp.simplify(-inv_metric * dV)

# 7. Equations of motion: ddot{x}^μ + geodesic_term = F^μ
eom = []
for mu in range(3):
    lhs = accels[mu] + geodesic_terms[mu]
    rhs = potential_forces[mu]
    eom.append(sp.Eq(lhs, rhs))

print("\n--- Equations of Motion (3D Gyroscope) ---")
for idx, coord in enumerate(coords):
    print(f"\nCoordinate: {coord}")
    sp.pprint(eom[idx])

# 8. Devolve to 2D case by setting I3 -> 0, I1 -> cz^2, m -> 1
print("\n--- Devolved Equations of Motion (I3 -> 0, I1 -> cz^2, m -> 1) ---")
devol_subs = {I3: 0, I1: cz**2, m: 1}
devol_eom = []
for mu in range(2): # only delta and eta
    # solve the equations for accelerations dd_delta and dd_eta
    eq = eom[mu].subs(devol_subs)
    acc = accels[mu]
    sol = sp.solve(eq, acc)[0]
    devol_eom.append(sp.Eq(acc, sp.simplify(sol)))

for idx, coord in enumerate(coords[:2]):
    print(f"\nDevolved Coordinate: {coord}")
    sp.pprint(devol_eom[idx])

# 9. Verify against 2D Euler-Lagrange equations
# dd_delta == sin(delta) * (g/cz * cos(eta) - cos(delta) * d_eta**2)
# dd_eta == g/cz * sec(delta) * sin(eta) + 2 * tan(delta) * d_delta * d_eta
expected_dd_delta = sp.sin(delta) * ((g / cz) * sp.cos(eta) - sp.cos(delta) * d_eta**2)
expected_dd_eta = (g / cz) * (1 / sp.cos(delta)) * sp.sin(eta) + 2 * sp.tan(delta) * d_delta * d_eta

print("\n--- Verification against 2D Euler-Lagrange ---")
delta_match = sp.simplify(devol_eom[0].rhs - expected_dd_delta) == 0
eta_match = sp.simplify(devol_eom[1].rhs - expected_dd_eta) == 0
print(f"dd_delta matches: {delta_match}")
print(f"dd_eta matches: {eta_match}")
