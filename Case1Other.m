%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-22 16:21:49
% Last Edited : 2024-10-22 23:47:39
% Last Author : Jie Li
% File Path   : /RlEn/Case1Other.m
% Description :
%
%
%
%
%
%
%
%
% Copyright (c) 2024, Jie Li, jl725@kent.ac.uk
% All Rights Reserved.
%%
clear;
funs_path = 'functions';
addpath(funs_path);

% random seed
rng(1234);
p1 = 30;
p2 = 70;
N1 = 400;
P = p1 + p2;
J = 150;
alpha = unifrnd(1, 2, [J, 1]);
ApEn = zeros(P, J);
CP = zeros(J, 1);
CP_mean = zeros(J, 1);
CP_var = zeros(J, 1);
sigma1 = 0.4;
sigma2 = 0.5;
m = 2;
for j = 1:J
    xData = generatePath2Rep(1, 1, p1, p2, N1, alpha(j),sigma1,sigma2);
    X = xData';
    apen = zeros(P, 1);
    x_mean = zeros(P, 1);
    x_var = zeros(P, 1);
    
    for i = 1:P
        data_vector = X(:, i);
        apen(i) = approximateEntropy(data_vector, [], m);
        x_mean(i) = mean(data_vector);
        x_var(i) = var(data_vector);
    end
    
    ApEn(:, j) = apen;
    cp = findchangepts(apen, 'MaxNumChanges', 1, 'Statistic', 'mean');
    cp_mean = findchangepts(x_mean, 'MaxNumChanges', 1, 'Statistic', 'mean');
    cp_var = findchangepts(x_var, 'MaxNumChanges', 1, 'Statistic', 'mean');
    
    if cp >= 0
        CP(j) = cp;
    end
    if cp_mean >= 0
        CP_mean(j) = cp_mean;
    end
    if cp_var >= 0
        CP_var(j) = cp_var;
    end
    
    fprintf('Trial loop j= %3d\n', j);
end
tabulate(CP)
% tabulate(CP_mean)
% tabulate(CP_var)

save('Case1Other.mat')