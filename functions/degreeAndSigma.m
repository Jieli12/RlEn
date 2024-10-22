%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:40:18
% Last Author : Jie Li
% File Path   : /RlEn/functions/degreeAndSigma.m
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

function [v, sigma_e] = degreeAndSigma(y, x, h)
%degreeAndSigma - this function computes the effective degrees of freedon and
%the residual variance estimator.
%
% Syntax: [v, sigma_e] = degreeAndSigma(y, x, h)
%
% Inputs:
%    y - size N \times 1
%    x - size N \tiems m
%    h - bandwidth
%
% Outputs:
%    v - degree
%    sigma_e - variance
%
% Example:
%
% See also:
%
[n, m] = size(x);
L = zeros(n);

for i = 1:n
    x0 = x(i, :);
    kernel = zeros(n, m);
    
    for j = 1:m
        kernel(:, j) = JackknifeKernel(x(:, j), x0(j), h);
    end
    
    weight = prod(kernel, 2);
    weight = weight' / sum(weight);
    L(i, :) = weight;
    
end

v = trace(L);
y_residual = y - L * y;
sigma_e = mean(y_residual.^2);
end
