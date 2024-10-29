%%
% Author      : Jie Li, School of Mathematics Statistics and Actuarial Science,
% 				University of Kent.
% Date        : 2021-02-06 17:34:11
% Last Edited : 2024-10-25 09:55:38
% Last Author : Jie Li
% File Path   : /RlEn/Case2All.m
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

% Add functions path
clear;
funs_path = 'functions';
addpath(funs_path);

% set up the parameters of AR(2)

syms gamma0 gamma1 gamma2 gamma3 phi1 phi2 phi3 sigma2 rho1 rho2 rho3 real
R = [1, rho1, rho2; rho1, 1, rho1; rho2, rho1, 1];
Phi = [phi1; phi2; phi3];
Rho = [rho1; rho2; rho3];
eqns = Rho == R * Phi;
[rho1, rho2, rho3] = solve(eqns, [rho1 rho2 rho3]);
Rho = [rho1, rho2, rho3];
gamma0 = sigma2 / (1 - Rho * Phi);
% variance model1
coef1 = [0.8, -0.3, 0.1];
s1 = subs(gamma0, [phi1, phi2, phi3, sigma2], [coef1, sym('v1')]);
coef2 = [0.7, -0.3, 0.1];
s2 = subs(gamma0, [phi1, phi2, phi3, sigma2], [coef2, sym('v2')]);
eqn = s1 == s2;
syms v1 v2 real
v2 = solve(eqn, v2);

var1 = 0.1;
var2 = double(subs(v2, v1, var1));

Mdl1 = arima('Constant', 0, 'AR', coef1, 'Variance', var1);
Mdl2 = arima('Constant', 0, 'AR', coef2, 'Variance', var2);

% relative_entropy_mdl1 = -0.5 * (log(sigmaEps2_mdl1) - log(sigma2_mdl1));
% relative_entropy_mdl2 = -0.5 * (log(sigmaEps2_mdl2) - log(sigma2_mdl2));
%% random seed
rng(1234)
N = 500;
N_sample = 800;
P = 100;
P1 = 60;
P2 = P - P1;
J = 150;
M = 6;
RlEn = zeros(P, J, M);
h_lower_rlen = 0.005;
h_upper_rlen = 1;
% ncore = 5;
% pooljob = parpool('local', ncore);
ncore = 32;
pooljob = parpool('SlurmProfile1', ncore);

parfor j = 1:J
    d0_temp = zeros(P, 1);
    d1_temp = zeros(P, 1);
    X1 = simulate(Mdl1, N_sample, 'NumPaths', P1);
    X2 = simulate(Mdl2, N_sample, 'NumPaths', P2);
    % in order to reduce transient effects, we only take the last N observations
    X1 = X1((N_sample - N + 1):end, :);
    X2 = X2((N_sample - N + 1):end, :);
    X0 = [X1, X2];
    X1 = 1 ./ (1 + exp(-X0));
    h_opt2 = zeros(P, M);
    rlen = zeros(P, M);
    apen = zeros(P, M);
    r_opt = zeros(P, M);
    
    for k = 1:P% P=100 paths
        Xk0 = X0(:, k);
        Xk1 = X1(:, k);
        
        d0_temp(k)=adftest(Xk0);
        d1_temp(k)=adftest(Xk1);
        
        for m = 1:M
            % RlEn
            myfun = @(h) -Inmh(Xk1, m, h);
            [h_temp, fval_opt] = fminbnd(myfun, h_lower_rlen, h_upper_rlen);
            h_opt2(k, m) = h_temp;
            rlen(k, m) = -fval_opt;
            % ApEn
            apen(k, m) = approximateEntropy(Xk0, [], m);
            
        end
        
    end
    p0_stationary(j) = mean(d0_temp);
    p1_stationary(j) = mean(d1_temp);
    
    RlEn(:, j, :) = rlen;
    ApEn(:, j, :) = apen;
    fprintf('Trial loop j= %3d\n', j);
end
mean(p0_stationary)
mean(p1_stationary)
delete(pooljob);
ipt_rlen = zeros(J, M);
ipt_apen = zeros(J, M);

for j = 1:J
    
    for m = 1:M
        
        ipt_rlen_temp = findchangepts(RlEn(:, j, m), 'MaxNumChanges', 1, 'Statistic', 'mean');
        ipt_apen_temp = findchangepts(ApEn(:, j, m), 'MaxNumChanges', 1, 'Statistic', 'mean');
        
        if isempty(ipt_rlen_temp)
            ipt_rlen(j, m) = NaN;
        else
            ipt_rlen(j, m) = ipt_rlen_temp;
        end
        
        if isempty(ipt_apen_temp)
            ipt_apen(j, m) = NaN;
        else
            ipt_apen(j, m) = ipt_apen_temp;
        end
        
    end
    
end

save('Case2Parfor.mat')
mad_rlen = mean(abs(ipt_rlen - 61))
sum(isnan(ipt_apen))
mad_apen = mean(abs(ipt_apen - 61),'omitnan')
exact_rlen = mean(abs(ipt_rlen - 61) ==0)
exact_apen = mean(abs(ipt_apen - 61) ==0)
