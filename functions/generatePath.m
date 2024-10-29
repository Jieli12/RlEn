%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2020-10-21 20:25:28
% Last Edited : 2024-10-25 10:02:01
% Last Author : Jie Li
% File Path   : /RlEn/functions/generatePath.m
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

function pathData = generatePath(initial1, initial2, p1, p2, n)
%generatePath - This function generates the path data. The two model comes from
%P.325 in the book Nonlinear Time Series (Fan and Yao, 2003)
%
% Syntax: pathData = generatePath(initial1, initial2, p1, p2, n)
%
% Long description
a1 = 0.138;
a2 = 0.316;
a3 = 0.982;
c = -3.89;
b1 = -0.437;
b2 = 0.659;
b3 = 1.260;
p = p1 + p2;
pathData = zeros(p, n+1);
ind1 = 1:p1;
ind2 = (p1+1):p;
pathData(ind1, 1) = initial1 * ones(p1, 1);
pathData(ind2, 1) = initial2 * ones(p2, 1);
for i = 1:n
    j = i+1;
    x1 = pathData(ind1, i);
    x2 = pathData(ind2, i);
    x1 = a1 + (a2 + a3 .* x1) .* exp(c .* x1.^2);
    x2 = b1 - (b2 + b3 .* x2) .* exp(c .* x2.^2);
    pathData(:, j) = [x1; x2] + normrnd(0, 0.2, p, 1);
end
pathData(:, 1) = [];
end