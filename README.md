# HAMDynamics

These scripts are tools to visualize the density renormalization in the hierarchical Anderson model. Details on the mathematical background can be found in these papers: [[1]](https://arxiv.org/abs/1303.2012) [[2]](https://arxiv.org/abs/1311.0780) [[3]](https://arxiv.org/abs/1608.01602).

`MakeRho.m` creates a vector of samples from the density rho_n at the n-th steps of the dynamics. The implementation is recursive, memory-demanding and terribly inefficient...

`Dynamics.m` produces a video showing the evolution of the density under the dynamics.

`MakePlots.m` creates a plot of the final density and tries to fit it to a Cauchy distribution.

`Movie.mp4` is a sample movie created by `Dynamics.m`.
