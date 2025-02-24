---
date: 2025-02-23
authors:
  - name: Ondřej Čertík
exports:
  - format: docx
  - format: pdf
  - format: tex
  - format: typst
bibliography:
  - references.bib
---
# Lie Groups

## Summary

Main properties:

* SO(3) Group -> so(3) algebra <=> SU(2) simply connected lie group (unique).
* Find extensions to non-simply connected SO(3). 
* Add discrete group to create a group of disconnected parts O(3) = Z_2 x SO(3). Probably can be extended in many other groups.

Galilei, generators show matrices. 

Lorentz, generators, matrices:
4 disconnected parts.

## Galilean Group

The homogeneous Galilean group is:
$$
\begin{pmatrix}
t' \\
\mathbf{r}'
\end{pmatrix}
=
\begin{pmatrix}
1 & 0 \\
\mathbf{v} & R
\end{pmatrix}
\begin{pmatrix}
t \\
\mathbf{r}
\end{pmatrix}
$$

The generators are:
$$
J_1 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & -1 \\
0 & 0 & 1 & 0
\end{pmatrix}, \quad
J_2 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 \\
0 & -1 & 0 & 0
\end{pmatrix}, \quad
J_3 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & -1 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}
$$
$$
K_1 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}, \quad
K_2 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0
\end{pmatrix}, \quad
K_3 = \begin{pmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0
\end{pmatrix}
$$

They satisfy the following commutation relations:

$$
[J_i, J_j] = \epsilon_{ijk} J_k, \quad [J_i, K_j] = \epsilon_{ijk} K_k, \quad [K_i, K_j] = 0
$$
