import numpy as np

# Define the ladder operators for j=1 in the basis |m> where m = 1, 0, -1
sqrt2 = np.sqrt(2)

# J_+ (raising operator)
J_plus = np.array([
    [0, sqrt2, 0],
    [0, 0, sqrt2],
    [0, 0, 0]
], dtype=complex)

# J_- (lowering operator)
J_minus = np.array([
    [0, 0, 0],
    [sqrt2, 0, 0],
    [0, sqrt2, 0]
], dtype=complex)

# J_z (z-component)
J_z = np.array([
    [1, 0, 0],
    [0, 0, 0],
    [0, 0, -1]
], dtype=complex)

# Compute J_x and J_y from ladder operators
J_x = 0.5 * (J_plus + J_minus)
J_y = (0.5 / 1j) * (J_plus - J_minus)

# Print the original angular momentum operators
print("Original J_x:\n", J_x)
print("Original J_y:\n", J_y)
print("Original J_z:\n", J_z)

# Define the unitary transformation U
U = np.array([
    [-1/np.sqrt(2), 1j/np.sqrt(2), 0],
    [0, 0, 1],
    [1/np.sqrt(2), 1j/np.sqrt(2), 0]
], dtype=complex)

# Compute the conjugate transpose of U (U dagger)
U_dagger = np.conj(U.T)

# Apply the transformation to get J_x', J_y', J_z'
J_x_prime = U_dagger @ J_x @ U
J_y_prime = U_dagger @ J_y @ U
J_z_prime = U_dagger @ J_z @ U

# Print the transformed angular momentum operators
print("\nTransformed J_x':\n", J_x_prime)
print("Transformed J_y':\n", J_y_prime)
print("Transformed J_z':\n", J_z_prime)

# Verify that i * J_i' are real skew-symmetric matrices
i_J_x_prime = 1j * J_x_prime
i_J_y_prime = 1j * J_y_prime
i_J_z_prime = 1j * J_z_prime

print("\ni * J_x':\n", i_J_x_prime)
print("i * J_y':\n", i_J_y_prime)
print("i * J_z':\n", i_J_z_prime)

# Check if i * J_i' are real and skew-symmetric
print("\nVerification:")
print("Is i * J_x' real and skew-symmetric?", 
      np.allclose(i_J_x_prime, i_J_x_prime.real) and np.allclose(i_J_x_prime, -i_J_x_prime.T))
print("Is i * J_y' real and skew-symmetric?", 
      np.allclose(i_J_y_prime, i_J_y_prime.real) and np.allclose(i_J_y_prime, -i_J_y_prime.T))
print("Is i * J_z' real and skew-symmetric?", 
      np.allclose(i_J_z_prime, i_J_z_prime.real) and np.allclose(i_J_z_prime, -i_J_z_prime.T))
