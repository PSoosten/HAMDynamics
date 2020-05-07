function [] = MakePlots()
    % Parameters
    Type = 'Normal';
    Mu = 0;
    Sigma = 1/4;
    P = @(n) 2^(-n/3);
    
    % Number of Sample Points to Use
    NSamples = 1e6;
    
    % Total Number of Steps to Perform
    NSteps = 6;
    

    fprintf('Computing the %d Iterations of the Dynamics for:\n', NSteps)
    fprintf('\tRho0 = %s(%3.2f, %3.2f)\n', Type, Mu, Sigma);
    fprintf('\tP(n) = 2^(-%3.2f*n)\n', 1/3);
    fprintf('With %1.0e Sample Points\n\n', NSamples);
    
    % Initial Rho
    Rho = MakeRho(0, NSamples, Type, Mu, Sigma, P);
    Handle = MakeFigure(Rho);
    close(Handle);
    
    for N = 0:(NSteps-1)
        fprintf('Now Computing N=%d\n', N);
        
        % Make Independent Copy of Rho
        RhoPrime = MakeRho(N, NSamples, Type, Mu, Sigma, P);
        
        % Perform the Recursion
        Rho = (2*(Rho.*RhoPrime))./(Rho + RhoPrime);
        Rho = Rho + P(N);
    end
    
    Handle = MakeFigure(Rho);
    saveas(Handle, './Figures/5Steps', 'eps');
    saveas(Handle, './Figures/5Steps', 'png');
    close(Handle);
    
    [Mu, Sigma] = FindCauchy(Rho);
    fprintf('\nConverges to Cauchy(%3.2f, %3.2f)\n', Mu, Sigma);
    Rho = MakeRho(0, NSamples, 'Cauchy', Mu, Sigma, P);
    Handle = MakeFigure(Rho);
    saveas(Handle, './Figures/Cauchy', 'eps');
    saveas(Handle, './Figures/Cauchy', 'png');
    close(Handle);
end




function [Handle] = MakeFigure(Rho)
    % Graphics Settings
    HistogramBoxes = 1000;
    Size1 = 300;
    Size2 = 500;
    
    
    TextSizes.DefaultAxesFontSize = 20;
    TextSizes.DefaultTextFontSize = 20;
    set(0, TextSizes);
    
    Handle = figure('Position', [1 Size1 Size2 Size1]);
    
    Domain = linspace(-5, 5, HistogramBoxes + 1)';
    Weight = sum(hist(Rho, Domain))*(Domain(2) - Domain(1));
    Rho = Rho(abs(Rho) <= 5);
    Values = hist(Rho, Domain);
    Values = Values(1:end-1)'/Weight;
    
    plot(Domain(round(0.5:0.5:length(Domain))), [0; Values(round(0.5:0.5:length(Values))); 0],...
        '-','color', [0, 0, 0]);
    
    xlim([-5,5]);
    set(gca, 'xtick', [-5, 0, 5]);
    ylim([0, 2]);
    set(gca, 'ytick', [0, 1, 2]);
end

function [Mu, Sigma] = FindCauchy(Rho)
    HistogramBoxes = 1000;
        
    Domain = linspace(-5, 5, HistogramBoxes + 1)';
    Weight = sum(hist(Rho, Domain))*(Domain(2) - Domain(1));
    Values = hist(Rho, Domain);
    Values = Values(1:end-1)'/Weight;
    
    [M,I] = max(Values);
    Sigma = 1/(pi*M);
    Mu = Domain(I(1));
end
