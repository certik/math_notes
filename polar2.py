import numpy as np
from scipy.linalg import polar
#A = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
#A = np.array([
#[0, 1, 0, 0],
#[11, 6, -4, -4],
#[22, 15, -8, -9],
#[-3, -2, 1, 2]])
A = np.array([
[0, 4, 3],
[0, 20, 16],
[0, -25, -20]])

U, H = polar(A, side="left")
print("A")
print(A)
print("H")
print(H)
print("U")
print(U)
print("inv(U)")
print(np.linalg.inv(U))
print("dot(U, U.T)")
print(np.dot(U, U.T))
print("HU")
print(np.dot(H, U))
DH, PH = np.linalg.eig(H)
DH = np.diag(DH)
print("DH, PH")
print(DH)
print(PH)
print("PH DH inv(PH)")
print(np.dot(PH, np.dot(DH, np.linalg.inv(PH))))

DU, PU = np.linalg.eig(U)
DU = np.diag(DU)
print("DU, PU")
print(DU)
print(PU)
print("PU DU inv(PU)")
print(np.dot(PU, np.dot(DU, np.linalg.inv(PU))))
print("D = DH DU")
D = np.dot(DH, DU)
print(D)

print("det(A)")
print(np.linalg.det(A))
print("det(D)")
print(np.linalg.det(D))
