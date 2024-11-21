load('DATA_ALL.mat')
load('RlEn_DATA_ALL.mat')
N = 5000;
i = 10;
rlen = RlEn{i, 1};
figure('Position', [500 500 336 252]);
set(0, 'DefaultLineLineWidth', 2)
ipt = findchangepts(rlen, 'MaxNumChanges', 1, 'Statistic', 'mean');
CtraMat = DATA_ALL{i, 1}.Contraction;
figname = 'rlen_1.png';
plot(CtraMat(:, 1:(ipt -1)))
ylim([min(min(CtraMat)) - 10, max(max(CtraMat)) + 10]);
xlim([1, N]);
xlabel('Time (ms)')
ylabel('Torque (N \cdot m)')
saveas(gcf, figname)

figure('Position', [500 500 336 252]);
figname = 'rlen_2.png';
plot(CtraMat(:, ipt:end))
ylim([min(min(CtraMat)) - 10, max(max(CtraMat)) + 10]);
xlim([1, N]);
xlabel('Time (ms)')
ylabel('Torque (N \cdot m)')
saveas(gcf, figname)


load("RlEn_DATA_ALL_apen.mat")
N = 5000;
i = 10;
apen = ApEn_cell{i, 1};
figure('Position', [500 500 336 252]);
set(0, 'DefaultLineLineWidth', 2)
ipt = findchangepts(apen, 'MaxNumChanges', 1, 'Statistic', 'mean');
CtraMat = DATA_ALL{i, 1}.Contraction;
figname = 'apen_1.png';
plot(CtraMat(:, 1:(ipt -1)))
ylim([min(min(CtraMat)) - 10, max(max(CtraMat)) + 10]);
xlim([1, N]);
xlabel('Time (ms)')
ylabel('Torque (N \cdot m)')
saveas(gcf, figname)

figure('Position', [500 500 336 252]);
figname = 'apen_2.png';
plot(CtraMat(:, ipt:end))
ylim([min(min(CtraMat)) - 10, max(max(CtraMat)) + 10]);
xlim([1, N]);
xlabel('Time (ms)')
ylabel('Torque (N \cdot m)')
saveas(gcf, figname)