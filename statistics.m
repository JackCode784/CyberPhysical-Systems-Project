%% BAS and BSAS performance statistics
% This script estimates mean, standard deviation and variance of the local
% minima found by BAS and BSAS algorithms for both transfer functions used
% in the project.
% 

s = tf('s');
G = [];
% Various transfer functions for testing purposes 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G = [G, 21.99 / ((s+1)*s*(1+22.99*s))];     % Plant tf, first paper
G = [G, 0.12/ (s*(1+ 1.27*s))];             % Plant tf, "asymmetric"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample = 50;        % sample size
n = 2;              % number of test transfer functions
multistart = 5;
itaes_bas = zeros(n,sample);
itaes_bas_multi = zeros(n,sample);
itaes_bsas = zeros(n,sample);
for i=1:2
    for j=1:sample
        [~, itaes_bas(i,j)] = bas_itae(G(i));
        [~, itae_temp] = bas_multistart(multistart, G(i));
        itaes_bas_multi(i,j) = min(itae_temp);
        [~, itaes_bsas(i,j)] = bsas_itae(G(i));
    end
end

[bas_var, bas_mean] = var(itaes_bas');
[bas_multi_var, bas_multi_mean] = var(itaes_bas_multi');
[bsas_var, bsas_mean] = var(itaes_bsas');


