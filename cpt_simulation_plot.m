clear
load('RealExample1RlEnSim.mat')
K = 52;
m = 5;
rlen = zeros(K, 1);

for k = 1:K
    rlen(k, :) = task_outputs{k, 1}.rlen;
end

figure('Position', [500 500 336 252]);
set(0, 'DefaultLineLineWidth', 2)
ipt = findchangepts(rlen, 'MaxNumChanges', 2, 'Statistic', 'mean');
figname = 'rlen_change_pointsSim.png';
findchangepts(rlen, 'MaxNumChanges', 2, 'Statistic', 'mean');
xlabel("Indices")
ylabel("RlEn")
xlim([0, K + 1])
hold on
txt = [num2str(ipt(1)), ' \rightarrow '];
text(ipt(1), 4.1, txt, 'FontSize', 14, 'HorizontalAlignment', 'right')
hold on
txt = ['\leftarrow ', num2str(ipt(2))];
text(ipt(2), 4.9, txt, 'FontSize', 14)

saveas(gcf, figname)