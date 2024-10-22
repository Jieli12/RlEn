%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:31:36
% Last Author : Jie Li
% File Path   : /RlEn/functions/Case1Cp.m
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

function [mk, h_opt1, h_opt2, rlen, cp] = Case1Cp(X, M, h_lower, h_upper, ...
    h_lower_rlen, h_upper_rlen)
% CASE1CP detect the lag order m and find the change point.
%
% Syntax:
%    [mk, h_opt1, h_opt2, rlen, cp] = Case1Cp(X, M, h_lower, h_upper, ...
%        h_lower_rlen, h_upper_rlen)
%
% Inputs:
%    X - the data, size N * K
%    M - the candidates of lag order
%
% Outputs:
%    mk - the lag order
%    h_opt1 - the bandwidth for lag order
%    h_opt2 - the bandwidth for rlen
%    rlen - the rlen
%    cp - the change point
%
% Example:
%
% See also:
%

[N, K] = size(X);
h_opt1 = zeros(K, M);
bic = zeros(K, M);

for k = 1:K
    xk = X(:, k);
    
    for m = 1:M
        n = N - m;
        y = xk(m + 1:N);
        x_mat = zeros(n, m);
        
        for i = 1:m
            x_mat(:, i) = xk(i:(i + n - 1));
        end
        
        myfun = @(h)mSelectCV(y, x_mat, h);
        h_temp = fminbnd(myfun, h_lower, h_upper);
        h_opt1(k, m) = h_temp;
        [v, sigma_e] = degreeAndSigma(y, x_mat, h_temp);
        bic(k, m) = n * log(sigma_e) + v * log(n);
        
    end
    
end

[~, mk] = min(mean(bic), [], 2);
h_opt2 = zeros(K, 1);
rlen = zeros(K, 1);

for k = 1:K % P=100 paths
    Xk = X(:, k);
    myfun = @(h) - Inmh(Xk, mk, h);
    [h_temp, fval_opt] = fminbnd(myfun, h_lower_rlen, h_upper_rlen);
    h_opt2(k) = h_temp;
    rlen(k) = -fval_opt;
end

cp = findchangepts(rlen, 'MaxNumChanges', 1, 'Statistic', 'mean');
end
