# Statistical Mechanics

## Fermi-Dirac Distribution

The grand canonical potential for non-interacting fermions:

$$
\Omega[\beta, \mu]
    = -\sum_i {1\over\beta}
        \log\left(\sum_{N=0}^1 e^{-\beta\left(N\epsilon_i - N\mu\right)}\right)
    =
$$
$$
    = -\sum_i {1\over\beta}
        \log\left(1 + e^{-\beta\left(\epsilon_i - \mu\right)}\right) =
$$
$$
    = \sum_i \Omega_i\,,
$$
Where $\Omega_i$ is the grand canonical potential for a single particle state:
$$
\Omega_i = - {1\over\beta}
        \log\left(1 + e^{-\beta\left(\epsilon_i - \mu\right)}\right)\,.
$$
The total (average) number of particles in the state $i$ is:
$$
N_i = -\left(\partial\Omega_i\over\partial\mu\right)_{T,V} =
$$
$$
= -{\partial \left(- {1\over\beta} \log\left(1 + e^{-\beta\left(\epsilon_i - \mu\right)}\right) \right)\over\partial\mu} =
$$
$$
= {1\over\beta} {1\over 1 + e^{-\beta(\epsilon_i - \mu)}}
  e^{-\beta(\epsilon_i - \mu)}
  \beta =
$$
$$
= {1\over e^{\beta(\epsilon_i - \mu)} + 1}
  \,.
$$
