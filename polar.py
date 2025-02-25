import sympy as sp
A = sp.Matrix([[1, 2], [3, 4]])
# Compute H = √(AA†)
AA_T = A * A.T.conjugate()
H = sp.Matrix.zeros(AA_T.rows, AA_T.cols)
for eigenval, multiplicity, basis in AA_T.eigenvects():
    for eigenvect in basis:
        H += sp.sqrt(eigenval) * eigenvect * eigenvect.T.conjugate() / eigenvect.norm()**2
# Compute U = H⁻¹ * A
U = H.inv() * A

print("Matrix A:")
sp.pprint(A)
print("\nHermitian matrix H:")
sp.pprint(H.n())
print("\nUnitary matrix U:")
sp.pprint(U.n())
print("\nHU:")
sp.pprint((H*U).n())
