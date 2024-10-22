%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-22 14:14:00
% Last Author : Jie Li
% File Path   : /RlEn/functions/PhiMR.m
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
function Phi = PhiMR(data, m, r)
% this routine computes the phi^m(r) defined in Pincus (1991)  Proc. Natl.
% Acad. Sci.  88,2297-2301.
%
% INPUT
% data      the time series;
% m         lag order;
% r         the threshold value;
%
%
% OUTPUT
%
% Phi       the value of phi^m(r);

N = length(data);
n = N - m + 1;
x = zeros(n, m);
for i = 1:m
    x(:, i) = data(i:(i+n-1), :);
end
log_c = zeros(n, 1);
for i = 1:n
    xdiff = x - repmat(x(i, :), n, 1);
    max_dist = max(abs(xdiff),[], 2);
    ci = sum(max_dist <= r) / n;
    log_c(i) = log(ci);
end
Phi = mean(log_c);
end