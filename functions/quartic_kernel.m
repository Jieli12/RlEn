%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:37:44
% Last Author : Jie Li
% File Path   : /RlEn/functions/quartic_kernel.m
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

function weight = quartic_kernel(u)
% QUAD_KERNEL description
%
% Syntax:
%    weight = quartic_kernel(u)
%
% Inputs:
%    u -
%
% Outputs:
%    weight -
%
% Example:
%
% See also:
%
weight = 15/16 * (1 - u.^2).^2;
u_ind = u >= -1 & u <= 1;
weight = weight .* u_ind;
end
