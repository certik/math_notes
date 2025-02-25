from sympy import Matrix, symbols, simplify, solve

# Define symbols for the symmetric matrix C
c00, c01, c02, c03 = symbols('c00 c01 c02 c03')
c11, c12, c13 = symbols('c11 c12 c13')
c22, c23, c33 = symbols('c22 c23 c33')

# Define C as a symmetric 4x4 matrix
C = Matrix([[c00, c01, c02, c03],
            [c01, c11, c12, c13],
            [c02, c12, c22, c23],
            [c03, c13, c23, c33]])

# Define rotation generators
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

# Define boost generators
K_x = Matrix([[0, 1, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0]])

K_y = Matrix([[0, 0, 1, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0]])

K_z = Matrix([[0, 0, 0, 1],
              [0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0]])

# Compute commutators
commutator_J_z = simplify(J_z * C - C * J_z)
commutator_J_y = simplify(J_y * C - C * J_y)
commutator_J_x = simplify(J_x * C - C * J_x)
commutator_K_x = simplify(K_x * C - C * K_x)
commutator_K_y = simplify(K_y * C - C * K_y)
commutator_K_z = simplify(K_z * C - C * K_z)

# Print intermediate results
print("Commutator [J_z, C]:")
print(commutator_J_z)
print("\nCommutator [J_y, C]:")
print(commutator_J_y)
print("\nCommutator [J_x, C]:")
print(commutator_J_x)
print("\nCommutator [K_x, C]:")
print(commutator_K_x)
print("\nCommutator [K_y, C]:")
print(commutator_K_y)
print("\nCommutator [K_z, C]:")
print(commutator_K_z)

# Collect equations from commutators
equations = []
for commutator in [commutator_J_z, commutator_J_y, commutator_J_x,
                   commutator_K_x, commutator_K_y, commutator_K_z]:
    for row in range(4):
        for col in range(4):
            if commutator[row, col] != 0:
                equations.append(commutator[row, col])

# Define variables to solve for
variables = [c00, c01, c02, c03, c11, c12, c13, c22, c23, c33]

# Solve the system
solutions = solve(equations, variables, dict=True)

# Print the solution
print("\nSolutions for the components of C:")
if solutions:
    print(solutions[0])
    # Construct and print the final matrix C
    sol_dict = solutions[0]
    C_solution = C.subs(sol_dict)
    print("\nFinal matrix C:")
    print(C_solution)
else:
    print("No solutions found.")
