%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:32:27
% Last Author : Jie Li
% File Path   : /RlEn/functions/mSelectCV.m
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


function cv = mSelectCV(y, x, h)
%mSelectCV - this function compute the cross-validation values using leave one out method to select the lag order%
% Syntax:
%    cv = mSelectCV(y, x, h)
%
% Inputs:
%    y - size N \times 1
%    x - size N \tiems m
%    h - bandwidth
%
% Outputs:
%    cv -
%
% Example:
%
% See also:
%
[n, m] = size(x);
ind = ~eye(n);
y_est = zeros(n, 1);

for i = 1:n
    x0 = x(i, :);
    x_delete = x(ind(:, i), :);
    y_delete = y(ind(:, i));
    kernel = zeros(n - 1, m);
    
    for j = 1:m
        kernel(:, j) = JackknifeKernel(x_delete(:, j), x0(j), h);
    end
    
    weight = prod(kernel, 2);
    weight = weight' / sum(weight);
    y_est(i) = weight * y_delete;
    
end

y_residual = y - y_est;
cv = mean(y_residual.^2);
end
