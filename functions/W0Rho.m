%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:36:15
% Last Author : Jie Li
% File Path   : /RlEn/functions/W0Rho.m
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

function y = W0Rho(r)
% W0RHO Compute the w_0(\rho)
%
% Syntax:
%    y = W0Rho(r)
%
% Inputs:
%    r -
%
% Outputs:
%    y -
%
% Example:
%
% See also:
%
y = ((r + 1)^3 * (3 * r^2 - 9 * r + 8)) / 16;
end
