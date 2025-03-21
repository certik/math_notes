import sympy as sp

# Define symbolic constants
sqrt2 = sp.sqrt(2)
i = sp.I  # Imaginary unit

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

# Define the unitary transformation U
U = sp.Matrix([
    [-1 / sqrt2, i / sqrt2, 0],
    [0, 0, 1],
    [1 / sqrt2, i / sqrt2, 0]
])

# Compute U dagger (conjugate transpose)
U_dagger = U.conjugate().T

# Apply the transformation
J_x_prime = U_dagger * J_x * U
J_y_prime = U_dagger * J_y * U
J_z_prime = U_dagger * J_z * U

# Simplify the transformed matrices
J_x_prime = sp.simplify(J_x_prime)
J_y_prime = sp.simplify(J_y_prime)
J_z_prime = sp.simplify(J_z_prime)

# Compute i * J_i'
i_J_x_prime = sp.simplify(i * J_x_prime)
i_J_y_prime = sp.simplify(i * J_y_prime)
i_J_z_prime = sp.simplify(i * J_z_prime)

# Function to check if a matrix is real and skew-symmetric
def is_real_skew_symmetric(M):
    is_real = all(sp.im(M[row, col]) == 0 for row in range(3) for col in range(3))
    is_skew_symmetric = M == -M.T
    return is_real and is_skew_symmetric

# Display results
print("Original J_x:")
sp.pprint(J_x)
print("\nOriginal J_y:")
sp.pprint(J_y)
print("\nOriginal J_z:")
sp.pprint(J_z)

print("\nTransformed J_x':")
sp.pprint(J_x_prime)
print("\nTransformed J_y':")
sp.pprint(J_y_prime)
print("\nTransformed J_z':")
sp.pprint(J_z_prime)

print("\ni * J_x':")
sp.pprint(i_J_x_prime)
print("\ni * J_y':")
sp.pprint(i_J_y_prime)
print("\ni * J_z':")
sp.pprint(i_J_z_prime)

print("\nVerification:")
print("Is i * J_x' real and skew-symmetric?", is_real_skew_symmetric(i_J_x_prime))
print("Is i * J_y' real and skew-symmetric?", is_real_skew_symmetric(i_J_y_prime))
print("Is i * J_z' real and skew-symmetric?", is_real_skew_symmetric(i_J_z_prime))

print("Ji^2:")
sp.pprint(i_J_x_prime**2)
sp.pprint(i_J_y_prime**2)
sp.pprint(i_J_z_prime**2)
sp.pprint(i_J_x_prime**2 + i_J_y_prime**2 + i_J_z_prime**2)
