from sympy import Matrix, symbols, pprint

# Define symbolic variables for C
c11, c12, c13, c22, c23, c33 = symbols('c11 c12 c13 c22 c23 c33')

# Define J_z as a 4x4 matrix
J_z = Matrix([[0, 0, 0, 0],
              [0, 0, -1, 0],
              [0, 1, 0, 0],
              [0, 0, 0, 0]])

# Define C as a 4x4 symmetric matrix with zero time components
C = Matrix([[0, 0, 0, 0],
            [0, c11, c12, c13],
            [0, c12, c22, c23],
            [0, c13, c23, c33]])

# Compute J_z * C
J_z_C = J_z * C

# Compute C * J_z
C_J_z = C * J_z

# Display the results
pprint("J_z * C:")
pprint(J_z_C)
pprint("\nC * J_z:")
pprint(C_J_z)
