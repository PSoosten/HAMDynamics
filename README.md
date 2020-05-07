# HAMDynamics

These scripts are tools to visualize the density renormalization in the hierarchical Anderson model. Details on the mathematical background can be found in the following papers:

[Transition between localized and extended states in the hierarchical Anderson model - Metz, Leuzzi, Parisi, Sacksteder](https://arxiv.org/abs/1303.2012)

[The renormalization flow of the hierarchical Anderson model at weak disorder - Metz, Leuzzi, Parisi](https://arxiv.org/abs/1311.0780)

[Renormalization Group Analysis of the Hierarchical Anderson Model - von Soosten, Warzel](https://arxiv.org/abs/1608.01602)

`MakeRho.m` creates a vector of samples from the density rho_n at the n-th steps of the dynamics. The implementation is recursive, memory-demanding and terribly inefficient...

`Dynamics.m` produces a video showing the evolution of the density under the dynamics.

`MakePlots.m` creates a plot of the final density and tries to fit it to a Cauchy distribution.

`Movie.mp4` is a sample movie created by `Dynamics.m`.