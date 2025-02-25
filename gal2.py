from sympy import Matrix, symbols, simplify, solve, pprint

# Define symbols for the components of C
c00, c01, c02, c03 = symbols('c00 c01 c02 c03')
c11, c12, c13 = symbols('c11 c12 c13')
c22, c23, c33 = symbols('c22 c23 c33')

# Define C as a symmetric 4x4 matrix
C = Matrix([[c00, c01, c02, c03],
            [c01, c11, c12, c13],
            [c02, c12, c22, c23],
            [c03, c13, c23, c33]])

# Define the rotation generators
J_z = Matrix([[0, 0, 0, 0],
              [0, 0, -1, 0],
              [0, 1, 0, 0],
              [0, 0, 0, 0]])

J_y = Matrix([[0, 0, 0, 0],
              [0, 0, 0, 1],
              [0, 0, 0, 0],
              [0, -1, 0, 0]])

J_x = Matrix([[0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, -1],
              [0, 0, 1, 0]])

# Compute the commutators J_i C - C J_i
commutator_z = simplify(J_z * C - C * J_z)
commutator_y = simplify(J_y * C - C * J_y)
commutator_x = simplify(J_x * C - C * J_x)
print(commutator_x)
print(commutator_y)
print(commutator_z)

# Collect equations by setting each commutator to zero
equations = []
for commutator in [commutator_z, commutator_y, commutator_x]:
    for row in range(4):
        for col in range(4):
            if commutator[row, col] != 0:  # Only add non-trivial equations
                equations.append(commutator[row, col])

# Solve the system of equations
variables = [c00, c01, c02, c03, c11, c12, c13, c22, c23, c33]
solutions = solve(equations, variables, dict=True)

# Display the solutions
if solutions:
    print("Solutions for C:")
    print(solutions[0])
else:
    print("No solutions found.")
