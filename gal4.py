from sympy import Matrix, symbols, simplify, solve, pprint

# Define symbols for a general symmetric 4x4 matrix C
c00, c01, c02, c03 = symbols('c00 c01 c02 c03')
c11, c12, c13 = symbols('c11 c12 c13')
c22, c23, c33 = symbols('c22 c23 c33')

# Construct the symmetric matrix C
C = Matrix([[c00, c01, c02, c03],
            [c01, c11, c12, c13],
            [c02, c12, c22, c23],
            [c03, c13, c23, c33]])

# Define rotation generators (acting on spatial coordinates x, y, z)
J_x = Matrix([[0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, -1],
              [0, 0, 1, 0]])

J_y = Matrix([[0, 0, 0, 0],
              [0, 0, 0, 1],
              [0, 0, 0, 0],
              [0, -1, 0, 0]])

J_z = Matrix([[0, 0, 0, 0],
              [0, 0, -1, 0],
              [0, 1, 0, 0],
              [0, 0, 0, 0]])

# Define boost generators (mixing time t with x, y, z)
K_x = Matrix([[0, 0, 0, 0],
              [1, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0]])

K_y = Matrix([[0, 0, 0, 0],
              [0, 0, 0, 0],
              [1, 0, 0, 0],
              [0, 0, 0, 0]])

K_z = Matrix([[0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 0, 0],
              [1, 0, 0, 0]])

# A is the transformation matrix, g is the metric, K is the generator:
# For covariant metric g_ij:
# A^T g A = g
# K^T g + g K = 0
# For g^ij:
# A g A^T = g
# K g + g K^T = 0
# Compute generator invariance conditions for g^{ij}:
cond_J_x = simplify(J_x * C + C * J_x.T)
cond_J_y = simplify(J_y * C + C * J_y.T)
cond_J_z = simplify(J_z * C + C * J_z.T)
cond_K_x = simplify(K_x * C + C * K_x.T)
cond_K_y = simplify(K_y * C + C * K_y.T)
cond_K_z = simplify(K_z * C + C * K_z.T)

# Collect all equations by setting each matrix element to zero
equations = []
for matrix in [cond_J_x, cond_J_y, cond_J_z, cond_K_x, cond_K_y, cond_K_z]:
    for i in range(4):
        for j in range(4):
            if matrix[i, j] != 0:
                equations.append(matrix[i, j])

print("The following termsa are all equal to 0:")
pprint(equations)

# Variables to solve for
variables = [c00, c01, c02, c03, c11, c12, c13, c22, c23, c33]

# Solve the system of equations
solutions = solve(equations, variables, dict=True)

# Output the results
print("Solutions for the components of C:")
if solutions:
    sol_dict = solutions[0]
    print(sol_dict)
    # Substitute the solution into C
    C_solution = C.subs(sol_dict)
    print("\nFinal matrix C:")
    pprint(C_solution)
else:
    print("No solutions found.")
