# Thomas-Fermi-Dirac Theory

There are two ways to derive equations for Thomas-Fermi-Dirac theory. One way
is to start from grand potential and derive all equations from it. The other
way is to start with low level equations and build our way up. Will start with
the former.

## Top Down Approach

The full interacting grand partition function is:

$$
\Xi = \sum_{N=0}^\infty \frac{z^N}{N!} \int \prod_{i=1}^N \frac{d^3 r_i \, d^3 p_i}{(2\pi \hbar)^3} \, \exp\left( -\beta \left[ \sum_{i=1}^N \frac{p_i^2}{2m} + U(\mathbf{r}_1, \mathbf{r}_2, \dots, \mathbf{r}_N) \right] \right).
$$

We are approximating it with a trial grand potential that is non-interacting:

$$
\Omega_\mathrm{trial}[\beta, \mu]
    = -\sum_i {1\over\beta}
        \log\left(\sum_{N=0}^1 e^{-\beta\left(N\epsilon_i - N\mu\right)}\right)
    =
$$
$$
    = -\sum_i {1\over\beta}
        \log\left(1 + e^{-\beta\left(\epsilon_i - \mu\right)}\right) =
$$
$$
    = -{1\over\beta}
        \int \int {2\,\mathrm{d}^3 x \,\mathrm{d}^3 p \over (2\pi)^3} \log\left(1 +
            e^{-\beta\left(H_\mathrm{trial}(\mathbf{p}, \mathbf{x}) - \mu\right)}\right) =
$$
$$
    = -{1\over\beta}
        \int \int {2\,\mathrm{d}^3 x \,\mathrm{d}^3 p \over (2\pi)^3} \log\left(1 +
            e^{-\beta\left({p^2\over 2} + V({\bf x}) - \mu\right)}\right)\,.
$$

And the relation between the two is:

$$
\Omega[\beta, \mu]
= \Omega_\mathrm{trial}[\beta, \mu]
+\langle H - H_\mathrm{trial} \rangle_\mathrm{trial}
$$

Where the full Hamiltonian contains:

$$H = \sum_i \left({p_i^2\over 2} + V_{en}({\bf x}_i)\right) + {1\over2}\sum_{i \ne j} {1\over |\mathbf{x}_i - \mathbf{x}_j|}$$

And the non-interacting trial Hamiltonian is for each particle (the total
Hamiltonian is a sum of these):

$$H_\mathrm{trial}(\mathbf{p}, \mathbf{x}) = {p^2\over 2} + V({\bf x})$$

where:
$V({\bf x}) = V_{en}({\bf x}) + V_{ee}({\bf x}) + V_{xc}({\bf x})$.

Now, evaluate the correction $\langle H - H_{\text{trial}} \rangle_{\text{trial}}$. The true $H$ includes Hartree $U_H = \frac{1}{2} \sum_{i \neq j} \frac{1}{|\mathbf{r}_i - \mathbf{r}_j|}$ and exchange-correlation (approximated as LDA for simplicity). In the mean-field:

- Hartree: $\langle U_H \rangle_{\text{trial}} \approx E_{ee} = \frac{1}{2} \int n_e(\mathbf{r}) V_{ee}(\mathbf{r}) \, d^3 r$, and $\langle \sum_i V_{ee}(\mathbf{r}_i) \rangle_{\text{trial}} = \int n_e V_{ee} \, d^3 r = 2 E_{ee}$, so contribution: $E_{ee} - 2 E_{ee} = -E_{ee}$.

- Dirac exchange: $E_{xc} = \int \epsilon_{xc}(n_e(\mathbf{r})) n_e(\mathbf{r}) \, d^3 r$, with $\epsilon_{xc} \propto -n^{1/3}$. Then $V_{xc} = \frac{\delta E_{xc}}{\delta n_e} = \frac{4}{3} \epsilon_{xc}$, so $\langle \sum_i V_{xc}(\mathbf{r}_i) \rangle_{\text{trial}} = \int n_e V_{xc} \, d^3 r = \frac{4}{3} E_{xc}$, and contribution: $E_{xc} - \frac{4}{3} E_{xc} = -\frac{1}{3} E_{xc}$.

- External: Cancels exactly (included in both $H$ and $H_{\text{trial}}$).

Thus the correction that must be applied is:

$$
E_{en} + E_{ee} + E_{xc} - \int n_e({\bf x}) V({\bf x})\,\,\mathrm{d}^3 x =
$$
$$
    = \int n_e({\bf x})\left(
        (e_{en}-V_{en})
        +(e_{ee}-V_{ee})
        +(e_{xc}-V_{xc})
        \right)\,\,\mathrm{d}^3 x =
$$
$$
    = \int n_e({\bf x})\left(
        0
        +\left({1\over2} V_{ee}-V_{ee}\right)
        +\left({3\over 4}V_{xc}-V_{xc}\right)
        \right)\,\,\mathrm{d}^3 x =
$$
$$
    = \int n_e({\bf x})\left(
        -{1\over2} V_{ee}
        -{1\over 4}V_{xc}
        \right)\,\,\mathrm{d}^3 x =
$$
$$
    = -{1\over2}\int n_e({\bf x}) V_{ee} \,\mathrm{d}^3 x
    - {1\over 3}{3\over 4}\int n_e({\bf x}) V_{xc} \,\mathrm{d}^3 x =
$$
$$
    = -E_{ee} - {1\over 3} E_{xc}
$$


We start with a grand potential for non-interacting fermions (they interact in
terms of the mean field potential $V({\bf x})$, but not directly), and add to
it the corrections above:

$$
\Omega[\beta, \mu]
    = -\sum_i {1\over\beta}
        \log\left(\sum_{N=0}^1 e^{-\beta\left(N\epsilon_i - N\mu\right)}\right)
            -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -\sum_i {1\over\beta}
        \log\left(1 + e^{-\beta\left(\epsilon_i - \mu\right)}\right)
            -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -{1\over\beta}
        \int \int {2\,\mathrm{d}^3 x \,\mathrm{d}^3 p \over (2\pi)^3} \log\left(1 +
            e^{-\beta\left({p^2\over 2} + V({\bf x}) - \mu\right)}\right)
            -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -{2\over\beta}
        \int \,\mathrm{d}^3 x \int_0^\infty{ 4\pi p^2 \,\mathrm{d} p \over (2\pi)^3} \log\left(1 +
            e^{-\beta\left({p^2\over 2} + V({\bf x}) - \mu\right)}\right)
            -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -{1\over \pi^2 \beta}
        \int \,\mathrm{d}^3 x \int_0^\infty p^2 \log\left(1 +
            e^{-\beta\left({p^2\over 2} + V({\bf x}) - \mu\right)}\right) \,\mathrm{d} p
            -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int \,\mathrm{d}^3 x \int_0^\infty {u^{3\over2} \over
            1 + e^{u-\beta\left(\mu-V({\bf x})\right)}} \,\mathrm{d} u
                -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}\left(\beta\left(\mu-V({\bf x})\right)\right) \,\,\mathrm{d}^3 x
        -E_{ee} - {1\over3}E_{xc} =
$$
$$
    = -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}\left(\beta\left(\mu-V({\bf x})\right)\right) \,\,\mathrm{d}^3 x
        -E_{ee} - {1\over3}E_{xc}
$$

The potential
$V({\bf x}) = V_{en}({\bf x}) + V_{ee}({\bf x}) + V_{xc}({\bf x})$
is the total potential that the electrons experience (it contains nuclear,
Hartree, and XC terms) and $E_{ee}$ is the Hartree energy:

$$
E_{en} = \int n_e({\bf x}) V_{en}({\bf x})\,\,\mathrm{d}^3 x\,,
$$
$$
E_{ee}
    = {1\over2} \int n_e(\mathbf{x}) V_{ee}(\mathbf{x}) \,\mathrm{d}^3 x\,,
$$
$$
E_{xc} = {3\over 4}\int n_e({\bf x}) V_{xc}({\bf x})\,\,\mathrm{d}^3 x\,.
$$

For simplicity, we assume here that $V_{xc}$ only contains the exchange of the
homogeneous electron gas. For a general XC functional, the relation is
nonlinear and one must simply numerically calculate the XC energy density
$e_{xc}({\bf x})$ and calculate the XC energy using:

$$
E_{xc} = \int n_e({\bf x}) e_{xc}({\bf x})\,\,\mathrm{d}^3 x\,.
$$

In our case here, we have $e_{xc} = {3\over4}V_{xc}({\bf x})$, which is only
true for the exchange in homogeneous electron gas. Otherwise the relation is
nonlinear.

The density is a functional derivative with respect to
$\mu$:

$$
n_e({\bf x}) = - {\delta \Omega[\beta, \mu] \over \delta \mu}
    = {2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        {\partial \over \partial \mu}
            I_{3\over2}\left(\beta\left(\mu-V({\bf x})\right)\right)
    = {2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \beta {3\over 2} I_{1\over2}
            \left(\beta\left(\mu-V({\bf x})\right)\right) =
$$
$$
    = {\sqrt2 \over \pi^2 \beta^{3\over2}} I_{1\over2}
            \left(\beta\left(\mu-V({\bf x})\right)\right)
$$

By defining the function $\Phi(n_e({\bf x}))$:

$$
\Phi(n_e({\bf x})) = \beta\left(\mu-V({\bf x})\right)
    = I_{1\over2}^{-1}\left(
            {\pi^2 \beta^{3\over2} \over \sqrt 2} n_e({\bf x})
        \right)
$$

we can express the grand potential using $n_e$ as follows:

$$
\Omega[\beta, n_e]
    = -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
      - {1\over2} \int n_e(\mathbf{x}) V_{ee}(\mathbf{x}) \,\mathrm{d}^3 x
      - {1\over 4} \int n_e(\mathbf{x}) V_{xc}(\mathbf{x}) \,\mathrm{d}^3 x\,.
$$

Now we can calculate the free energy:

$$
F_e[\beta, n_e] = \Omega[\beta, n_e] + \mu N
    = \Omega[\beta, n_e] + \mu \int n_e({\bf x}) \,\,\mathrm{d}^3 x =
$$
$$
    = \int \left(-{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
          I_{3\over2}(\Phi(n_e({\bf x})))
        + \mu n_e({\bf x})
        - n_e(\mathbf{x}) \left(
            {1\over2} V_{ee}(\mathbf{x})
            +{1\over 4} V_{xc}(\mathbf{x})
            \right)
            \right)\,\mathrm{d}^3 x =
$$
$$
    = \int \left(-{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
          I_{3\over2}(\Phi(n_e({\bf x})))
        + {1\over \beta} n_e({\bf x}) \Phi(n_e({\bf x}))
            + n_e({\bf x}) V({\bf x})
            - n_e(\mathbf{x}) \left(
                {1\over2} V_{ee}(\mathbf{x})
                +{1\over 4} V_{xc}(\mathbf{x})
                \right)
            \right)\,\mathrm{d}^3 x =
$$
$$
    = \int \left(-{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
          I_{3\over2}(\Phi(n_e({\bf x})))
        + {1\over \beta} n_e({\bf x}) \Phi(n_e({\bf x}))
            + n_e({\bf x})\left( V_{en}({\bf x})
              +{1\over2} V_{ee}(\mathbf{x})
              + {3\over 4} V_{xc}(\mathbf{x}) \right)
            \right)\,\mathrm{d}^3 x\,,
$$

where we used the fact that $\mu = {1\over \beta} \Phi(n_e({\bf x})) + V({\bf
x})$, i.e. the left hand side $\mu$ is a constant, thus the sum of the terms on
the right hand side is also constant (even though the individual terms are
not).

We can calculate the entropy
$S=-\left(\partial\Omega\over\partial T\right)_{V,\mu}$ as follows:

$$
TS
    =-T \left(\partial\Omega\over\partial T\right)_{V,\mu} =
$$
$$
    =\beta \left(\partial\Omega\over\partial \beta\right)_{V,\mu} =
$$
$$
    =\beta {\partial\over\partial \beta}\left(
        -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        - E_{ee} - {1\over3}E_{xc}
    \right) =
$$
$$
    =\beta {\partial\over\partial \beta}\left(
        -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
    \right) =
$$
$$
    =\beta \left(
        {5\over2}{2\sqrt2 \over 3 \pi^2 \beta^{7\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int {3\over2} I_{1\over2}(\Phi(n_e({\bf x})))
            {\partial\Phi(n_e({\bf x}))\over\partial\beta}
        \, \,\mathrm{d}^3 x
    \right) =
$$
$$
    =\beta \left(
        {5\over2}{2\sqrt2 \over 3 \pi^2 \beta^{7\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        -{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int {3\over2} I_{1\over2}(\Phi(n_e({\bf x})))
            (\mu-V({\bf x}))
        \, \,\mathrm{d}^3 x
    \right) =
$$
$$
    = {5\over2}{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        - \int n_e({\bf x}) (\mu-V({\bf x})) \, \,\mathrm{d}^3 x =
$$
$$
    = {5\over3}{\sqrt2 \over \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        -\mu N + E_{en}+2E_{ee} + {4\over 3}E_{xc}
$$


The total energy is then equal to:

$$
E = \Omega + \mu N + TS =
$$
$$
    = \left(-{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        - E_{ee} - {1\over3}E_{xc}\right)
        + \mu N
        +{5\over3}{\sqrt2 \over \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        -\mu N + E_{en}+2E_{ee} + {4\over 3}E_{xc} =
$$
$$
    = {\sqrt2 \over \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
        + E_{en} + E_{ee} + E_{xc}
$$

From which we can see that the kinetic energy $E_{kin}$ is equal to:

$$
E_{kin} = E - (E_{en} + E_{ee} + E_{xc}) =
$$
$$
    = {\sqrt2 \over \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
$$

The relation between the total energy and free energy can be also written as:

$$
E = F + TS = F +
    \beta \left(\partial\Omega\over\partial \beta\right)_{V,\mu} =
$$
$$
    = F + \beta \left(\partial F\over\partial \beta\right)_{V,\mu}
    = \left(\partial (\beta F)\over\partial \beta\right)_{V,\mu}
$$

But it gives the same result as we obtained above.

To determine the kinetic part of the free energy, we set all potentials equal
to zero ($V({\bf x}) = V_{en}({\bf x}) = V_{ee}({\bf x}) = V_{xc}({\bf x}) =
0$) and obtain:

$$
F_{kin}[\beta, n_e]
    = \int \left(-{2\sqrt2 \over 3 \pi^2 \beta^{5\over2}}
          I_{3\over2}(\Phi(n_e({\bf x})))
        + {1\over \beta} n_e({\bf x}) \Phi(n_e({\bf x}))
            \right)\,\mathrm{d}^3 x\,.
$$

If the potentials are zero, then the pressure can be calculated
from:

$$
P = -{1\over V}\Omega[\beta, n_e]
    = {2\sqrt2 \over 3 \pi^2 \beta^{5\over2}V}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \,\,\mathrm{d}^3 x =
$$
$$
    = {2\sqrt2 \over 3 \pi^2 \beta^{5\over2}V}
        \int I_{3\over2}(\beta\mu) \,\,\mathrm{d}^3 x
    = {2\sqrt2 \over 3 \pi^2 \beta^{5\over2}} I_{3\over2}(\beta\mu) \,.
$$

If the potentials are not zero, then one can calculate the pressure using:

$$
P = - \left(\partial\Omega\over\partial V\right)_{\mu,T}
    = - \left(\partial F\over\partial V\right)_{T,N} =
$$
$$
    = - {\partial \over\partial V} \int f \,\mathrm{d}^3 x =
$$
$$
    = - \left[f+e_{ee}\right]_b
        - \int {\partial f\over\partial n_e}
          {\partial n_e\over\partial V}
          \,\mathrm{d}^3 x =
$$
$$
    = - \left[f+e_{ee}\right]_b
        - \mu \int {\partial n_e\over\partial V} \,\mathrm{d}^3 x =
$$
$$
    = - \left[f+e_{ee}\right]_b
        + \mu [n_e]_b =
$$
$$
    = \left[(-f)-e_{ee}+\mu n_e \right]_b =
$$
$$
    = \left[\left({2\over3}e_{kin} + e_{ee} + {1\over3}e_{xc}-\mu n_e\right)
        -e_{ee}+\mu n_e \right]_b =
$$
$$
    = \left[{2\over3}e_{kin} + {1\over3}e_{xc}\right]_b =
$$
$$
    = {1\over 3V} \int_b \left( {2\over3}e_{kin} + {1\over3}e_{xc}
        \right) {\bf x}\cdot{\bf n}\,\,\mathrm{d} S =
$$
$$
    = {1\over 3V} \int \left( {2\over3}e_{kin} + {1\over3}e_{xc}
        \right) \nabla\cdot{\bf x}\,\,\mathrm{d}^3 x
        +
    {1\over 3V} \int {\bf x}\cdot\nabla \left(
        {2\over3}e_{kin} + {1\over3}e_{xc}
        \right) \,\,\mathrm{d}^3 x =
$$
$$
    = {1\over 3V} (2E_{kin} + E_{xc})
        +
    {1\over 3V} \int {\bf x}\cdot \left(
        -n_e({\bf x})\nabla V({\bf x})
        + \nabla{1\over3}e_{xc}
        \right) \,\,\mathrm{d}^3 x =
$$
$$
    = {1\over 3V} (2E_{kin} + E_{xc})
        +
    {1\over 3V} (E_{en}+E_{ee}) =
$$
$$
    = {1\over 3V}(2E_{kin} + E_{en} + E_{ee} + E_{xc})
$$

Summary:

$$
\Omega = -{2\over 3} E_{kin} - E_{ee} - {1\over3}E_{xc}
$$
$$
F_e = \Omega + \mu N = -{2\over 3} E_{kin} - E_{ee} - {1\over3}E_{xc}
    + \mu N
$$
$$
TS = {5\over3} E_{kin} + E_{en} + 2 E_{ee} + {4\over3}E_{xc} - \mu N
$$
$$
E = F + TS = \Omega + \mu N + TS = E_{kin} + E_{en} + E_{ee} + E_{xc}\,,
$$

where:

$$
E_{kin} = {\sqrt2 \over \pi^2 \beta^{5\over2}}
        \int I_{3\over2}(\Phi(n_e({\bf x}))) \, \,\mathrm{d}^3 x
$$
$$
E_{en} = \int n_e({\bf x}) V_{en}({\bf x})\, \,\mathrm{d}^3 x
$$
$$
E_{ee} = {1\over2} \int n_e({\bf x}) V_{ee}({\bf x})\, \,\mathrm{d}^3 x
$$
$$
E_{xc} = {3\over4}\int n_e({\bf x}) V_{xc}({\bf x})\, \,\mathrm{d}^3 x
$$
$$
n_e({\bf x}) = {\sqrt2 \over \pi^2 \beta^{3\over2}}
        I_{1\over2}\left( \beta\left(\mu-V({\bf x})\right) \right)
$$
$$
\Phi(n_e({\bf x})) = \beta\left(\mu-V({\bf x})\right)
    = I_{1\over2}^{-1}\left(
            {\pi^2 \beta^{3\over2} \over \sqrt 2} n_e({\bf x})
        \right)
$$
$$
N = \int n_e({\bf x})\, \,\mathrm{d}^3 x
$$
$$
\mu = {1\over \beta} \Phi(n_e({\bf x})) + V({\bf x})
$$

and $\mu N$ is calculated as follows:

$$
\mu N = \int \mu n_e({\bf x})\, \,\mathrm{d}^3 x =
$$
$$
    = {1\over \beta} \int \Phi(n_e({\bf x})) n_e({\bf x})\, \,\mathrm{d}^3 x
        + \int V({\bf x}) n_e({\bf x})\, \,\mathrm{d}^3 x =
$$
$$
    = {1\over \beta} \int \Phi(n_e({\bf x})) n_e({\bf x})\, \,\mathrm{d}^3 x
        + E_{en} + 2 E_{ee} + {4\over3} E_{xc} \,.
$$

So $F_e$ can also be expressed as:

$$
F_e = -{2\over 3} E_{kin} - E_{ee} - {1\over3}E_{xc} + \mu N =
$$
$$
    = -{2\over 3} E_{kin}
       + {1\over \beta} \int \Phi(n_e({\bf x})) n_e({\bf x})\, \,\mathrm{d}^3 x
        + E_{en} + E_{ee} + E_{xc} \,.
$$
