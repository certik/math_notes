import sympy as sp

# Define symbolic constants
sqrt2 = sp.sqrt(2)
i = sp.I
pi = sp.pi

# Define the ladder operators and J_z for j=1
J_plus = sp.Matrix([
    [0, sqrt2, 0],
    [0, 0, sqrt2],
    [0, 0, 0]
])

J_minus = sp.Matrix([
    [0, 0, 0],
    [sqrt2, 0, 0],
    [0, sqrt2, 0]
])

J_z = sp.Matrix([
    [1, 0, 0],
    [0, 0, 0],
    [0, 0, -1]
])

# Compute J_x and J_y
J_x = (J_plus + J_minus) / 2
J_y = (J_plus - J_minus) / (2 * i)

theta = -pi/2
U = sp.exp(i*theta*J_z)

n1 = 0
n2 = 1
n3 = 0
V = n1*J_x + n2*J_y + n3*J_z

# Compute U dagger (conjugate transpose)
U_dagger = U.conjugate().T

# Apply the transformation
V_prime = U * V * U_dagger

# Display results
print("J_x:")
sp.pprint(J_x)
print("\nJ_y:")
sp.pprint(J_y)
print("\nJ_z:")
sp.pprint(J_z)

print("\nU:")
sp.pprint(U)
print("\nV:")
sp.pprint(V)
print("\nV':")
sp.pprint(V_prime)
