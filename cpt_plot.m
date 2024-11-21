load('RealExample1RlEn.mat')
K = 52;
m = 5;
rlen = zeros(K, 1);

for k = 1:K
    rlen(k, :) = task_outputs{k, 1}.rlen;
end

figure('Position', [500 500 336 252]);
set(0, 'DefaultLineLineWidth', 2)
ipt = findchangepts(rlen, 'MaxNumChanges', 2, 'Statistic', 'mean');
figname = 'rlen_change_points.png';
findchangepts(rlen, 'MaxNumChanges', 2, 'Statistic', 'mean');
xlabel("Indices")
ylabel("RlEn")
xlim([0, K + 1])
hold on
txt = [num2str(ipt(1)), ' \rightarrow ', ];
text(ipt(1), 4.1, txt, 'FontSize', 14, 'HorizontalAlignment', 'right')
hold on
txt = ['\leftarrow ', num2str(ipt(2))];
text(ipt(2), 4.9, txt, 'FontSize', 14)
saveas(gcf, figname)

%% plot the contraction data
load('data40clean.mat')
cp1 = ipt(1);
cp2 = ipt(2);

f1 = figure('Position', [500 500 336 252]);
% plot the first idx contractions
plot(CtraMat(:, 1:cp1 - 1))
ylim([20, 150])
xlim([0, 5000])
xlabel('Time');
ylabel('Torque (N.m)')
group1name = 'group1.png';
saveas(f1, group1name)

f2 = figure('Position', [500 500 336 252]);
% plot the first idx contractions
plot(CtraMat(:, cp1:cp2 - 1))
ylim([20, 150])
xlim([0, 5000])
xlabel('Time');
ylabel('Torque (N.m)')
group2name = 'group2.png';
saveas(f2, group2name)

f3 = figure('Position', [500 500 336 252]);
% plot the first idx contractions
plot(CtraMat(:, cp2:end))
ylim([20, 150])
xlim([0, 5000])
xlabel('Time');
ylabel('Torque (N.m)')
group3name = 'group3.png';
saveas(f3, group3name)