# The Determinant of a $(0,2)$ Tensor from Relative Invariance

Starting from relative-invariance (covariance) equations for a scalar attached to a covariant rank-2 tensor, we derive — with no skipped steps — that the scalar must be the ordinary component determinant $\det(M_{ij})$ in any basis.

## Setup

Let $V$ be an $n$-dimensional vector space over $\mathbb{C}$ and $T$ a $(0,2)$ tensor, i.e. a bilinear form $T:V\times V\to\mathbb{C}$. Fix a basis $e_1,\dots,e_n$ and form the component (Gram) matrix
$$
M_{ij}=T(e_i,e_j).
$$
We seek a scalar $D(M)\in\mathbb{C}$ built from these components. For $A,B\in GL(V)$ (matrices in the chosen basis; repeated indices summed), transforming each argument of $T$ separately gives
$$
T(Av,w):\quad M_{ij}\mapsto T(Ae_i,e_j)=A_{ki}M_{kj}=(A^{\mathsf T}M)_{ij},
$$
$$
T(v,Bw):\quad M_{ij}\mapsto T(e_i,Be_j)=B_{lj}M_{il}=(MB)_{ij}.
$$

## Assumptions

$D$ is a **relative scalar in each slot**: a change of basis in one argument rescales $D$ by a factor depending only on that change. That is, there exist $\alpha,\beta:GL(V)\to\mathbb{C}$ with
$$
\textbf{(R)}\qquad D(A^{\mathsf T}M)=\alpha(A)\,D(M),\qquad D(MB)=\beta(B)\,D(M)\qquad(\forall M,\ \forall A,B\in GL(V)),
$$
and $D\not\equiv 0$. We also fix the degree and scale:
$$
\textbf{(H)}\ \ D(\lambda M)=\lambda^{n}D(M)\ \ (\lambda\in\mathbb{C}),\qquad\qquad \textbf{(N)}\ \ D(I)=1 .
$$

## Step 1: the two-slot law, and $\alpha,\beta$ are characters

The two operations commute, $A^{\mathsf T}(MB)=(A^{\mathsf T}M)B$, so applying (R) twice,
$$
D(A^{\mathsf T}MB)=\alpha(A)\,D(MB)=\alpha(A)\beta(B)\,D(M).
$$
Hence
$$
\boxed{\,D(A^{\mathsf T}MB)=\chi(A,B)\,D(M),\qquad \chi(A,B):=\alpha(A)\,\beta(B).\,}
$$

The factors are multiplicative. Since $(A_2A_1)^{\mathsf T}M=A_1^{\mathsf T}(A_2^{\mathsf T}M)$, the first equation of (R) gives
$$
\alpha(A_2A_1)\,D(M)=D\big(A_1^{\mathsf T}(A_2^{\mathsf T}M)\big)=\alpha(A_1)\alpha(A_2)\,D(M);
$$
evaluating at $M=I$ and using (N), $\alpha(A_2A_1)=\alpha(A_1)\alpha(A_2)$, and likewise $\beta(B_1B_2)=\beta(B_1)\beta(B_2)$. Each factor is nonzero: from $D(M)=D\big((A^{-1})^{\mathsf T}A^{\mathsf T}M\big)=\alpha(A^{-1})\alpha(A)D(M)$ at $M=I$, $\alpha(A^{-1})\alpha(A)=1$. Thus
$$
\alpha,\beta:GL(n,\mathbb{C})\to\mathbb{C}^{*}\ \text{ are group homomorphisms.}
$$

## Step 2: $\chi(A,B)=\det(A)\det(B)$

A homomorphism $GL(n,\mathbb{C})\to\mathbb{C}^{*}$ factors through the determinant: by the factorization theorem of [Determinant From Homomorphism](determinant_homomorphism.md),
$$
\alpha=g_1\circ\det,\qquad \beta=g_2\circ\det,
$$
for homomorphisms $g_1,g_2:\mathbb{C}^{*}\to\mathbb{C}^{*}$, where $\det$ is the explicit Leibniz polynomial. We pin $g_1,g_2$ with (H). Since $(\lambda I)^{\mathsf T}M=\lambda M$, the first equation of (R) gives $D(\lambda M)=\alpha(\lambda I)\,D(M)$; comparing with (H) at $M=I$,
$$
\alpha(\lambda I)=\lambda^{n}.
$$
But $\alpha(\lambda I)=g_1(\det(\lambda I))=g_1(\lambda^{n})$, so $g_1(\lambda^{n})=\lambda^{n}$ for every $\lambda\in\mathbb{C}^{*}$. Every $t\in\mathbb{C}^{*}$ is an $n$-th power, hence $g_1=\operatorname{id}$ and $\alpha=\det$. The same argument with $M(\lambda I)=\lambda M$ gives $\beta=\det$. Therefore
$$
\boxed{\,\chi(A,B)=\det(A)\,\det(B).\,}
$$

## Step 3: $D(M)=\det(M)$

**Invertible $M$.** Apply the second equation of (R) with base point $I$ and multiplier $M$, using $\beta=\det$ and (N):
$$
D(M)=D(I\cdot M)=\beta(M)\,D(I)=\det(M)\cdot 1=\det(M).
$$

**Singular $M$.** If $\det M=0$ there is a vector $u\neq0$ with $Mu=0$. Pick a covector $w^{\mathsf T}$ with $w^{\mathsf T}u=c$ where $c\neq 0,-1$, and set $B=I+u\,w^{\mathsf T}$, which is invertible with $\det B=1+w^{\mathsf T}u=1+c\neq1$. Since $Mu=0$,
$$
MB=M+(Mu)\,w^{\mathsf T}=M,
$$
so the second equation of (R) gives $D(M)=D(MB)=\beta(B)D(M)=\det(B)\,D(M)=(1+c)\,D(M)$, forcing $D(M)=0=\det(M)$.

Hence in every basis
$$
\boxed{\,D(M)=\det(M_{ij})=\sum_{\sigma\in S_n}\operatorname{sgn}(\sigma)\,M_{1\sigma(1)}\cdots M_{n\sigma(n)}.\,}
$$
The relative-invariance equations (R), together with the degree (H) and scale (N), force the determinant of a $(0,2)$ tensor to be the ordinary component determinant. $\qquad\blacksquare$
