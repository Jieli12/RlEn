%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2024-10-20 23:33:11
% Last Edited : 2024-10-21 23:34:59
% Last Author : Jie Li
% File Path   : /RlEn/functions/JackknifeKernel.m
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

function weight = JackknifeKernel(x, x0, h)
% JACKKNIFEKERNEL compute the Jackknife kernel.
%
% Syntax:
%    weight = JackknifeKernel(x,x0,h)
%
% Inputs:
%    x - vector
%    x0 - center
%    h - bandwidth
%
% Outputs:
%    weight -
%
% Example:
%
% See also:
%
if x0 < h
    rho = x0 / h;
    alpha = 2 - rho;
    rho_alpha = rho / alpha;
    u = (x0 - x) / h;
    u_alpha = u / alpha;
    w0_rho = W0Rho(rho);
    w0_rho_alpha = W0Rho(rho_alpha);
    w1_rho = W1Rho(rho);
    w1_rho_alpha = W1Rho(rho_alpha);
    r1_rho = w1_rho / w0_rho;
    r1_rho_alpha = w1_rho_alpha / w0_rho_alpha;
    beta_rho = r1_rho / (alpha * r1_rho_alpha - r1_rho);
    
    ku = quartic_kernel(u);
    ku_alpha = quartic_kernel(u_alpha);
    k_rho_u = (1 + beta_rho) / w0_rho * ku - beta_rho / w0_rho_alpha / ...
        alpha * ku_alpha;
    weight = k_rho_u / h;
elseif x0 > 1 - h
    rho = (1 - x0) / h;
    alpha = 2 - rho;
    rho_alpha = rho / alpha;
    u = (x0 - x) / h;
    u_alpha = u / alpha;
    w0_rho = W0Rho(rho);
    w0_rho_alpha = W0Rho(rho_alpha);
    w1_rho = W1Rho(rho);
    w1_rho_alpha = W1Rho(rho_alpha);
    r1_rho = w1_rho / w0_rho;
    r1_rho_alpha = w1_rho_alpha / w0_rho_alpha;
    beta_rho = r1_rho / (alpha * r1_rho_alpha - r1_rho);
    
    ku = quartic_kernel(u);
    ku_alpha = quartic_kernel(u_alpha);
    k_rho_u = (1 + beta_rho) / w0_rho * ku - beta_rho / w0_rho_alpha / ...
        alpha * ku_alpha;
    weight = k_rho_u / h;
else
    u = (x0 - x) / h;
    weight = quartic_kernel(u) / h;
end

end
