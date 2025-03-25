from sympy import *

def kronecker_product(A, B):
    """
    Compute the Kronecker product of two SymPy matrices A and B.
    
    Parameters:
    A : SymPy Matrix (m x n)
    B : SymPy Matrix (p x q)
    
    Returns:
    Matrix : The Kronecker product A ⊗ B (mp x nq)
    """
    # Get dimensions of input matrices
    m, n = A.shape  # Rows and columns of A
    p, q = B.shape  # Rows and columns of B
    
    # Initialize the result matrix with zeros
    result = zeros(m * p, n * q)
    
    # Loop over each element of A
    for i in range(m):
        for j in range(n):
            # Extract the element A[i, j]
            a_ij = A[i, j]
            # Scale matrix B by this element
            block = a_ij * B
            # Calculate the position for this block in the result
            row_start = i * p
            row_end = row_start + p
            col_start = j * q
            col_end = col_start + q
            # Assign the block to the result matrix
            result[row_start:row_end, col_start:col_end] = block
    
    return result

# Define Pauli matrices
sigma_x = Matrix([[0, 1], [1, 0]])
sigma_y = Matrix([[0, -I], [I, 0]])
sigma_z = Matrix([[1, 0], [0, -1]])

# Identity matrix
I2 = eye(2)

# Compute A_i and B_i using tensor products
A_x = Rational(1, 2) * kronecker_product(sigma_x, I2)
A_y = Rational(1, 2) * kronecker_product(sigma_y, I2)
A_z = Rational(1, 2) * kronecker_product(sigma_z, I2)
B_x = Rational(1, 2) * kronecker_product(I2, sigma_x)
B_y = Rational(1, 2) * kronecker_product(I2, sigma_y)
B_z = Rational(1, 2) * kronecker_product(I2, sigma_z)

# Compute original generators J_i and K_i
J_x = A_x + B_x
J_y = A_y + B_y
J_z = A_z + B_z
K_x = -I * (A_x - B_x)
K_y = -I * (A_y - B_y)
K_z = -I * (A_z - B_z)

# Define the new basis vectors in the original basis
# Original basis order: |1/2,1/2>, |1/2,-1/2>, |-1/2,1/2>, |-1/2,-1/2>
# Indices:              0          1           2          3
# New basis:
# |t> = (|1> + |2>)/sqrt(2)
# |z> = (|1> - |2>)/sqrt(2)
# |x> = (|0> + |3>)/sqrt(2)
# |y> = -I * (|0> - |3>)/sqrt(2)

t = Matrix([0, 1/sqrt(2), 1/sqrt(2), 0])           # |t>
z = Matrix([0, 1/sqrt(2), -1/sqrt(2), 0])          # |z>
x = Matrix([1/sqrt(2), 0, 0, 1/sqrt(2)])          # |x>
y = -I * Matrix([1/sqrt(2), 0, 0, -1/sqrt(2)])    # |y>

# Construct transformation matrix U with columns in order |t>, |x>, |y>, |z>
# This order matches the standard (t, x, y, z) components
U = Matrix.hstack(t, x, y, z)

# Compute the conjugate transpose (adjoint) of U
U_dagger = U.adjoint()

# Transform all generators into the new basis
J_x_prime = U_dagger * J_x * U
J_y_prime = U_dagger * J_y * U
J_z_prime = U_dagger * J_z * U
K_x_prime = U_dagger * K_x * U
K_y_prime = U_dagger * K_y * U
K_z_prime = U_dagger * K_z * U

# Define standard generators for comparison
J_z_std = Matrix([[0, 0, 0, 0], [0, 0, -1, 0], [0, 1, 0, 0], [0, 0, 0, 0]])
K_z_std = Matrix([[0, 0, 0, 1], [0, 0, 0, 0], [0, 0, 0, 0], [1, 0, 0, 0]])

# Display results
print("Transformation matrix U:")
pprint(U)

print("\nTransformed J_x:")
pprint(J_x_prime)

print("\nTransformed J_y:")
pprint(J_y_prime)

print("\nTransformed J_z:")
pprint(J_z_prime)

print("\nTransformed K_x:")
pprint(K_x_prime)

print("\nTransformed K_y:")
pprint(K_y_prime)

print("\nTransformed K_z:")
pprint(K_z_prime)

print("\nStandard J_z for comparison:")
pprint(J_z_std)

print("\nStandard K_z for comparison:")
pprint(K_z_std)

# Verify unitarity of U (U^\dagger U should be identity)
unitarity_check = U_dagger * U
print()
print(r"U^\dagger U (should be identity matrix if U is unitary):")
pprint(unitarity_check)
