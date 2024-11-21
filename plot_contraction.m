clear;
load("Data40.mat");

% Add functions path
funs_path = 'functions';
addpath(funs_path);

%% set useful variables

torqueThreshold = 20; % the threshold value for torque
dt = Time(2) - Time(1);
sfreq = 1 / dt; % the sampling frequency
forder = 2; % the order of filter
cfreq = 20; % cutoff frequency
fQuadTorque = Filtmat(dt, cfreq, forder, Quads);

figname = 'allquad.pdf';
Time = Time * sfreq;
%plot all quad
figure('Position', [500 500 448 336]);
plot(Time, fQuadTorque)
axis([Time(1) Time(end) 0 (1.2 * max(fQuadTorque))])
xlabel('Time (ms)');
ylabel('Torque (N.m)')
saveas(gcf, figname)

ind = 1:8000;
% ind = 4000:5000;
f1 = figure('Position', [500 500 448 336]);
plot(Time(ind), Quads(ind), 'r');
hold on;
plot(Time(ind), fQuadTorque(ind), 'b');
hold off;
xlabel('Time (ms)');
ylabel('Torque (N.m)')
legend('Raw', 'Filtered', 'Location', 'northwest')
figname = 'OneContraction.pdf';
saveas(f1, figname)

[contractStart, contractEnd] = separateContraction(fQuadTorque, Time, ...
    torqueThreshold, sfreq);

%% delete the contractions length <= 4999, user can define this value

idx = (contractEnd - contractStart) > 4999;
contractStart = contractStart(idx);
contractEnd = contractEnd(idx);

numContractions = length(contractStart);

% extract the contractions
n = 5000;
CtraMat = zeros(n, numContractions);

for k = 1:numContractions
    contraction = fQuadTorque(contractStart(k):contractEnd(k));
    contractionSteady = draw_min_var(contraction, n);
    CtraMat(:, k) = contractionSteady;
end
save('data40clean.mat', 'CtraMat', 'sfreq')

figure('Position', [500 500 336 252]);
plot(CtraMat)
xlabel('Time (ms)');
ylabel('Torque (N.m)')
title(" "," ")
figname = 'extractions.png';
saveas(gcf, figname)