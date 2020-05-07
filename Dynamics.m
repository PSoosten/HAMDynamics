clear all; clc;

% Number of Sample Points to Use
NSamples = 1e7;

% Initial Distribution Parameters
Type = 'Normal';
Mu = 0;
Sigma = 3;

% Values of p_n
c = 0.5; P = @(n) 2^(-c*n);

% Total Number of Steps to Perform
NSteps = 8;

% Graphics Settings
HistogramBoxes = 300;
MovieFile = 'Movie';
Linux = false;

fprintf('Computing the %d Iterations of the Dynamics for:\n', NSteps)
fprintf('\tRho0 = %s(%3.2f, %3.2f)\n', Type, Mu, Sigma);
fprintf('\tP(n) = 2^(-%3.2f*n)\n', c);
fprintf('With %1.0e Sample Points\n\n', NSamples);

% Setup Graphics
if Linux
    MWHandle = VideoWriter(MovieFile, 'Motion JPEG AVI');
else
    MWHandle = VideoWriter(MovieFile, 'MPEG-4');
end
MWHandle.FrameRate = 1;
MWHandle.Quality = 100;
MWHandle.open;
scrsz = get(groot, 'ScreenSize');
Size1 = 2*round(scrsz(4)/(2*1.3));
Size2 = 2*round(scrsz(3)/(2*1.3));
figure('Position', [1 Size1 Size2 Size1], 'Tag', 'RhoHist');

% Initial Rho
Rho = MakeRho(0, NSamples, Type, Mu, Sigma, P);
RegRho = Rho(abs(Rho) <= 20);
histogram(RegRho, HistogramBoxes, 'Normalization', 'pdf');
frame = getframe(findobj('Tag', 'RhoHist'));
for Counter = 1:3
    writeVideo(MWHandle, frame);
end

for N = 0:(NSteps-1)
    
    fprintf('Now Computing N=%d\n', N);
    
    % Make Another Independent Copy of Rhow
    RhoPrime = MakeRho(N, NSamples, Type, Mu, Sigma, P);
    
    % Perform the Recursion
    Rho = (2*(Rho.*RhoPrime))./(Rho + RhoPrime);
    Rho = Rho + P(N);
    
    % Chop Off Outliers and Plot
    RegRho = Rho(abs(Rho) <= 20);
    histogram(RegRho, HistogramBoxes, 'Normalization', 'pdf');
    frame = getframe(findobj('Tag', 'RhoHist'));
    writeVideo(MWHandle, frame);
    
end

% Clean Up Graphics
MWHandle.close;
close(findobj('Tag', 'RhoHist'));