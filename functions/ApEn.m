%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-22 14:13:51
% Last Author : Jie Li
% File Path   : /RlEn/functions/ApEn.m
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
function apen = ApEn(data, m, r)
apen = PhiMR(data, m, r) - PhiMR(data, m+1, r);
end