function [Rho] = MakeRho(N, NSamples, Type, Mu, Sigma, P)
    if N ~= 0
        X = MakeRho(N-1, NSamples, Type, Mu, Sigma, P);
        Y = MakeRho(N-1, NSamples, Type, Mu, Sigma, P);
        Rho = (2*(X.*Y))./(X+Y);
        Rho = Rho + P(N);
    else
        if strcmp(Type, 'Normal')
            Rho = randn(1, NSamples);
        elseif strcmp(Type, 'Cauchy')
            Rho = tan(pi*rand(1, NSamples) - pi/2);
        elseif strcmp(Type, 'Uniform')
            Rho = rand(1, NSamples) - 0.5;
        end
        Rho = Sigma*Rho + Mu;
    end
end