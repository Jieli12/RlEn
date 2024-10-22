%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-21 23:18:44
% Last Edited : 2024-10-21 23:33:51
% Last Author : Jie Li
% File Path   : /RlEn/Case1Repeat.m
% Description : Case 1 in paper with 150 replications
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
M = 5;
h_lower = 0.001;
h_upper = 0.2;
h_lower_rlen = 0.005;
h_upper_rlen = 1;
J = 150;
alpha = unifrnd(1, 2, [J, 1]);
RlEn = zeros(P, J);
M_est = zeros(J, 1);
CP = zeros(J, 1);
ncore = 10;
pooljob = parpool('local', ncore);
% ncore = 48;
% pooljob = parpool('SlurmProfile1', ncore);
parfor j = 1:J
    xData = generatePath2Rep(1, 1, p1, p2, N1, alpha(j));
    X = xData';
    X = 1 ./ (1 + exp(-X));
    [mk, h_opt1, h_opt2, rlen, cp] = Case1Cp(X, M, h_lower, h_upper, ...
        h_lower_rlen, h_upper_rlen);
    M_est(j) = mk;
    RlEn(:, j) = rlen;
    CP(j) = cp;
    fprintf('Trial loop j= %3d\n', j);
end

delete(pooljob);
save('Case1ParforRep.mat')
