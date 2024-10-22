%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-22 14:12:39
% Last Author : Jie Li
% File Path   : /RlEn/functions/ApEn_f.m
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

function apen = ApEn_f(data_vector)
%
% Syntax:
%    apen = ApEn_f(data_vector)
%
% Inputs:
%    data_vector - a time series (vector)
%
% Outputs:
%    apen -
%
% Example:
%
% See also:
%
m = 2;
r = std(data_vector);
apen = ApEn(data_vector, m, r);
end
