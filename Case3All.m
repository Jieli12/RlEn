%%
% Author         : Jie Li, Ph.D. Candidate, SMSAS, University of Kent.
% Date           : 2021-01-28 16:06:02
% Last Revision  : 2021-01-28 16:13:23
% Last Author    : Jie Li
% File Path      : /SportsDataProject/Matlab/Case3All.m
% Description    :
%
%
%
% Copyright (c) 2021 by Jie Li, jl705@kent.ac.uk
% All Rights Reserved.
%%

% Add functions path
clear;
funs_path = 'functions';
addpath(funs_path);

% set up the parameters of AR(2)

%% random seed
rng(1234)
N = 500;
P1 = 160;
P2 = 80;
P = P1 + P2;
J = 150;
M = 8;
RlEn = zeros(P, J, M);
h_lower_rlen = 0.005;
h_upper_rlen = 1;
ncore = 32;
pooljob = parpool('SlurmProfile1', ncore);

parfor j = 1:J
    X = generatePath(0, 0, P1, P2, N);
    X = X';
    X = 1 ./ (1 + exp(-X));
    % in order to reduce transient effects, we only take the last N observations
    h_opt2 = zeros(P, M);
    rlen = zeros(P, M);
    apen = zeros(P, M);
    r_opt = zeros(P, M);

    for k = 1:P% P=100 paths
        Xk = X(:, k);

        for m = 1:M
            % RlEn
            myfun = @(h) -Inmh(Xk, m, h);
            [h_temp, fval_opt] = fminbnd(myfun, h_lower_rlen, h_upper_rlen)
            h_opt2(k, m) = h_temp;
            rlen(k, m) = -fval_opt;
            % ApEn
            n = N - m;
            x_m = zeros(n, m);

            for i = 1:m
                x_m(:, i) = X(i:(i + n - 1), k);
            end

            x_m1 = [x_m, X(m + 1:N, k)];
            S_vec = pdist(x_m, "chebychev");
            s_vec = pdist(x_m1, "chebychev");
            S = zeros(n, n, 2);
            S(:, :, 1) = squareform(S_vec);
            S(:, :, 2) = squareform(s_vec);
            h_temp = 0.2 * mean(std(x_m));
            fval = ApEn_pinus(h_temp, S, m, n);
            r_opt(k, m) = h_temp;
            apen(k, m) = fval;

        end

    end

    RlEn(:, j, :) = rlen;
    ApEn(:, j, :) = apen;
    fprintf('Trial loop j= %3d\n', j);
end

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

save('Case3Parfor.mat')
