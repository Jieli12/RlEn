%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:41:08
% Last Author : Jie Li
% File Path   : /RlEn/functions/MultiJackKernel.m
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

function [f, g, g1] = MultiJackKernel(x, y, h)
% MULTIJACKKERNEL compute the multivariate kernel density
%
% Syntax:
%    density = MultiJackKernel(x,y,h)
%
% Inputs:
%    x - size: 1 x m
%    y - size: n x m
%    h - bandwidth
%
% Outputs:
%    f - density estimator f
%    g - density estimator g
%    g1 - density estimator g1
%
% Example:
%
% See also:
%
[n, m] = size(y);
kernel = zeros(n, m);

for i = 1:m
    kernel(:, i) = JackknifeKernel(y(:, i), x(i), h);
end

%     f_prod = prod(kernel, 2);
g_prod = prod(kernel(:, 1:m - 1), 2);
g1_prod = kernel(:, m);
f_prod = g_prod .* g1_prod;
f = mean(f_prod);
g = mean(g_prod);
g1 = mean(g1_prod);
end
