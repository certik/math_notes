# Lie Groups IV: Three Rotations

The goal is to prove the following identity for Pauli matrices:


$$e^{-i{\theta_1\over2} \sigma_1} e^{-i{\theta_2\over2} \sigma_2} e^{-i{\theta_3\over2} \sigma_3}
= e^{-i {\theta\over2}\left({\bf n}\cdot {\bf\sigma} \right)}$$

We will do this by expanding both the Left-Hand Side (LHS) and the Right-Hand Side (RHS) of the equation and then comparing the resulting expressions.

### Key Identities

The proof relies on two main properties of Pauli matrices (σ1,σ2,σ3):

1. **Euler's Identity for Pauli Matrices:** For any unit vector v and angle α, the exponential is given by:
$$e^{-i {\alpha\over2}\left({\bf v}\cdot {\bf\sigma} \right)} = \cos\left({\alpha\over 2}\right)I - i \sin\left({\alpha\over2}\right) \left({\bf v}\cdot {\bf\sigma} \right)$$
where $I$ is the 2x2 identity matrix.

2. **Pauli Matrix Algebra:**
   * $\sigma_k^2 = I$ for $k=1, 2, 3$
   * $\sigma_i \sigma_j = i \epsilon_{ijk} \sigma_k$ for $i \neq j$ (e.g., $\sigma_1\sigma_2 = i\sigma_3$, $\sigma_2\sigma_3 = i\sigma_1$, $\sigma_3\sigma_1 = i\sigma_2$)
   * $\sigma_i \sigma_j = -\sigma_j \sigma_i$ for $i \neq j$

For notational simplicity, we will use $c_k = \cos(\theta_k/2)$ and $s_k = \sin(\theta_k/2)$.

### Step 1: Expand the Left-Hand Side (LHS)

We start by expanding each factor on the LHS:
* $e^{-i{\theta_1\over2} \sigma_1} = c_1 I - i s_1 \sigma_1$
* $e^{-i{\theta_2\over2} \sigma_2} = c_2 I - i s_2 \sigma_2$
* $e^{-i{\theta_3\over2} \sigma_3} = c_3 I - i s_3 \sigma_3$

First, let's multiply the first two terms:

$$(c_1 I - i s_1 \sigma_1)(c_2 I - i s_2 \sigma_2) = c_1 c_2 I - i c_1 s_2 \sigma_2 - i s_1 c_2 \sigma_1 - s_1 s_2 \sigma_1 \sigma_2$$

Using the property $\sigma_1 \sigma_2 = i\sigma_3$, this becomes:

$$c_1 c_2 I - i s_1 c_2 \sigma_1 - i c_1 s_2 \sigma_2 - s_1 s_2 (i\sigma_3) = c_1 c_2 I - i s_1 c_2 \sigma_1 - i c_1 s_2 \sigma_2 - i s_1 s_2 \sigma_3$$

Next, we multiply this result by the third term, $(c_3 I - i s_3 \sigma_3)$:

$$(c_1 c_2 I - i s_1 c_2 \sigma_1 - i c_1 s_2 \sigma_2 - i s_1 s_2 \sigma_3)(c_3 I - i s_3 \sigma_3)$$

Expanding this product term−by−term gives:

$$c_1 c_2 c_3 I - i c_1 c_2 s_3 \sigma_3 - i s_1 c_2 c_3 \sigma_1 - s_1 c_2 s_3 \sigma_1 \sigma_3 - i c_1 s_2 c_3 \sigma_2 - c_1 s_2 s_3 \sigma_2 \sigma_3 - i s_1 s_2 c_3 \sigma_3 - s_1 s_2 s_3 \sigma_3^2$$

Now we use the Pauli algebra rules to simplify the products:

* $\sigma_1 \sigma_3 = -i\sigma_2$
* $\sigma_2 \sigma_3 = i\sigma_1$
* $\sigma_3^2 = I$

Substituting these into our expression:

$$c_1 c_2 c_3 I - i c_1 c_2 s_3 \sigma_3 - i s_1 c_2 c_3 \sigma_1 - s_1 c_2 s_3 (-i\sigma_2) - i c_1 s_2 c_3 \sigma_2 - c_1 s_2 s_3 (i\sigma_1) - i s_1 s_2 c_3 \sigma_3 - s_1 s_2 s_3 I$$

Finally, we group the coefficients for the identity matrix $I$ and each Pauli matrix $\sigma_k$:

* **Coefficient of** $I$**:** $c_1 c_2 c_3 - s_1 s_2 s_3$
* **Coefficient of** $\sigma_1$**:** $- i s_1 c_2 c_3 - i c_1 s_2 s_3 = -i(s_1 c_2 c_3 + c_1 s_2 s_3)$
* **Coefficient of** $\sigma_2$**:** $+ i s_1 c_2 s_3 - i c_1 s_2 c_3 = -i(c_1 s_2 c_3 - s_1 c_2 s_3)$
* **Coefficient of** $\sigma_3$**:** $- i c_1 c_2 s_3 - i s_1 s_2 c_3 = -i(c_1 c_2 s_3 + s_1 s_2 c_3)$

So, the fully expanded LHS is:

$$\text{LHS} = (c_1 c_2 c_3 - s_1 s_2 s_3)I - i \left[ (s_1 c_2 c_3 + c_1 s_2 s_3)\sigma_1 + (c_1 s_2 c_3 - s_1 c_2 s_3)\sigma_2 + (c_1 c_2 s_3 + s_1 s_2 c_3)\sigma_3 \right]$$

### Step 2: Expand the Right-Hand Side (RHS)

The RHS is $e^{-i {\theta\over2}\left({\bf n}\cdot {\bf\sigma} \right)}$. Using Euler's identity for Pauli matrices, this expands to:

$$\text{RHS} = \cos\left({\theta\over 2}\right)I - i \sin\left({\theta\over2}\right) \left({\bf n}\cdot {\bf\sigma} \right)$$

where $\mathbf{n} = (n_1, n_2, n_3)$ is a unit vector. Expanding the dot product ${\bf n}\cdot {\bf\sigma} = n_1\sigma_1 + n_2\sigma_2 + n_3\sigma_3$, we get:

$$\text{RHS} = \cos\left({\theta\over 2}\right)I - i \sin\left({\theta\over2}\right)(n_1\sigma_1 + n_2\sigma_2 + n_3\sigma_3)$$

### Step 3: Equate LHS and RHS and Verify

For the LHS and RHS to be equal, the coefficients of the identity matrix $I$ and each Pauli matrix $\sigma_k$ must be equal, as these matrices are linearly independent.

Let's define the scalar coefficients derived from the LHS:
* $C_0 = c_1 c_2 c_3 - s_1 s_2 s_3$
* $C_1 = s_1 c_2 c_3 + c_1 s_2 s_3$
* $C_2 = c_1 s_2 c_3 - s_1 c_2 s_3$
* $C_3 = c_1 c_2 s_3 + s_1 s_2 c_3$

Comparing the LHS expression with the RHS, we find the following relations:
1. $\cos(\frac{\theta}{2}) = C_0$
2. $\sin(\frac{\theta}{2}) n_1 = C_1$
3. $\sin(\frac{\theta}{2}) n_2 = C_2$
4. $\sin(\frac{\theta}{2}) n_3 = C_3$

To confirm that these relations are always valid, we must show that they satisfy the fundamental trigonometric identity $\cos^2(\alpha) + \sin^2(\alpha) = 1$. Given that $\bf n$ is a unit vector ($n_1^2+n_2^2+n_3^2=1$), we need to prove that $C_0^2 + C_1^2 + C_2^2 + C_3^2 = 1$.

Let's compute the sum of the squares of the coefficients:
* $C_0^2 = (c_1 c_2 c_3 - s_1 s_2 s_3)^2 = c_1^2 c_2^2 c_3^2 - 2c_1c_2c_3s_1s_2s_3 + s_1^2 s_2^2 s_3^2$
* $C_1^2 = (s_1 c_2 c_3 + c_1 s_2 s_3)^2 = s_1^2 c_2^2 c_3^2 + 2s_1c_1c_2c_3s_2s_3 + c_1^2 s_2^2 s_3^2$
* $C_2^2 = (c_1 s_2 c_3 - s_1 c_2 s_3)^2 = c_1^2 s_2^2 c_3^2 - 2c_1s_1c_2s_2c_3s_3 + s_1^2 c_2^2 s_3^2$
* $C_3^2 = (c_1 c_2 s_3 + s_1 s_2 c_3)^2 = c_1^2 c_2^2 s_3^2 + 2c_1s_1c_2c_3s_2s_3 + s_1^2 s_2^2 c_3^2$

Summing these four equations, the cross-product terms ($2c_1s_1c_2s_2c_3s_3$) cancel each other out. The remaining terms are:

$$C_0^2 + C_1^2 + C_2^2 + C_3^2 = (c_1^2 c_2^2 c_3^2 + s_1^2 c_2^2 c_3^2) + (c_1^2 s_2^2 c_3^2 + s_1^2 s_2^2 c_3^2) + (c_1^2 c_2^2 s_3^2 + s_1^2 c_2^2 s_3^2) + (c_1^2 s_2^2 s_3^2 + s_1^2 s_2^2 s_3^2)$$

Now,we can factor these terms:

$$ c_2^2 c_3^2(c_1^2+s_1^2) + s_2^2 c_3^2(c_1^2+s_1^2) + c_2^2 s_3^2(c_1^2+s_1^2) + s_2^2 s_3^2(c_1^2+s_1^2)$$

Since $c_1^2+s_1^2 = \cos^2(\theta_1/2)+\sin^2(\theta_1/2) = 1$, this simplifies to:

$$c_2^2 c_3^2 + s_2^2 c_3^2 + c_2^2 s_3^2 + s_2^2 s_3^2$$

Factoring again: 

$$c_3^2(c_2^2+s_2^2) + s_3^2(c_2^2+s_2^2)$$

Using $c_2^2+s_2^2 = 1$, we get:

$$c_3^2(1) + s_3^2(1) = c_3^2 + s_3^2 = 1$$

### Conclusion

We have shown that the coefficients derived from expanding the LHS satisfy the condition $C_0^2 + C_1^2 + C_2^2 + C_3^2 = 1$. This proves that the product of the three exponential matrices is indeed another exponential matrix of the same form.

We have constructively found the parameters for the equivalent single rotation:

* The rotation angle $\theta$ is determined by:

$$\cos\left(\frac{\theta}{2}\right) = \cos\left(\frac{\theta_1}{2}\right)\cos\left(\frac{\theta_2}{2}\right)\cos\left(\frac{\theta_3}{2}\right) - \sin\left(\frac{\theta_1}{2}\right)\sin\left(\frac{\theta_2}{2}\right)\sin\left(\frac{\theta_3}{2}\right)$$

* The axis of rotation $\mathbf{n} = (n_1, n_2, n_3)$ is determined by:

$$\sin\left(\frac{\theta}{2}\right) \mathbf{n}
= \begin{pmatrix}
\sin(\frac{\theta_1}{2})\cos(\frac{\theta_2}{2})\cos(\frac{\theta_3}{2}) + \cos(\frac{\theta_1}{2})\sin(\frac{\theta_2}{2})\sin(\frac{\theta_3}{2}) \\
\cos(\frac{\theta_1}{2})\sin(\frac{\theta_2}{2})\cos(\frac{\theta_3}{2}) - \sin(\frac{\theta_1}{2})\cos(\frac{\theta_2}{2})\sin(\frac{\theta_3}{2}) \\
\cos(\frac{\theta_1}{2})\cos(\frac{\theta_2}{2})\sin(\frac{\theta_3}{2}) + \sin(\frac{\theta_1}{2})\sin(\frac{\theta_2}{2})\cos(\frac{\theta_3}{2}) \end{pmatrix}$$

This completes the constructive proof.
