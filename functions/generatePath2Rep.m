%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:30:44
% Last Author : Jie Li
% File Path   : /RlEn/functions/generatePath2Rep.m
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

function pathData = generatePath2Rep(initial1, initial2, p1, p2, n, alpha)
%generatePath - This function generates the path data. The two model comes from
%P.343 in the book Nonlinear Time Series (Fan and Yao, 2003)
%
% Syntax: pathData = generatePath2(initial1, initial2, p1, p2, n, alpha)
%
% Long description

p = p1 + p2;
pathData = zeros(p, n + 2);
ind1 = 1:p1;
ind2 = (p1 + 1):p;
pathData(ind1, 1:2) = initial1 * ones(p1, 2);
pathData(ind2, 1:2) = initial2 * ones(p2, 2);

for i = 1:n
    j = i + 2;
    x12 = pathData(ind1, i);
    x11 = pathData(ind1, i + 1);
    x22 = pathData(ind2, i);
    x21 = pathData(ind2, i + 1);
    x1 = -x12 .* exp(-x12.^2/2) + 1 ./ (1 + x12.^2) .* cos(alpha * x12) .* x11;
    x2 = -x22 .* exp(-x22.^2/2) + 1 ./ (1 + x22.^2) .* sin(alpha * x22) .* x21;
    % x1 = 1 ./ (1 + x12.^2) .* sin(pi * x12) .* x11;
    % x2 = 1 ./ (1 + x22.^2) .* cos(pi * x22) .* x21;
    pathData(:, j) = [x1; x2] + [normrnd(0, 0.1, p1, 1);normrnd(0,0.15, p2,1)];
end

pathData(:, 1:2) = [];
end
