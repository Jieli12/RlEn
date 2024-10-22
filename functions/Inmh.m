%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:40:32
% Last Author : Jie Li
% File Path   : /RlEn/functions/Inmh.m
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

function rlen = Inmh(x, m, h)
% INMH compute the leave-one-out entropy
%
% Syntax:
%    rlen = Inmh(x,m,h)
%
% Inputs:
%    x -
%    m -
%    h -
%
% Outputs:
%    rlen -
%
% Example:
%
% See also:
%
N = length(x);
n = N - m;
x_matrix = zeros(n, m + 1);

for i = 1:m + 1
    x_matrix(:, i) = x(i:(i + n - 1));
end

ind = ~eye(n);
rlen = 0;

for i = 1:n
    xi = x_matrix(i, :);
    yi = x_matrix(ind(:, i), :);
    [fi, gi, g1i] = MultiJackKernel(xi, yi, h);
    
    if fi > 0 && gi > 0 && g1i > 0
        rlen = rlen + log(fi / gi / g1i);
    end
    
end

rlen = rlen / n;
end
