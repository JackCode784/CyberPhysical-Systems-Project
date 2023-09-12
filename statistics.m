%% BAS and BSAS performance statistics
% This script estimates mean, standard deviation and variance of the local
% minima found by BAS and BSAS algorithms for both transfer functions used
% in the project.
% 

s = tf('s');
G = [];
% Various transfer functions for testing purposes 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% G = [G, 21.99 / ((s+1)*s*(1+22.99*s))];     % Plant tf, first paper
G = [G, 0.12/ (s*(1+ 1.27*s))];             % Plant tf, "asymmetric"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample = 100;       % sample size
n = numel(G);       % number of test transfer functions
multistart = 5;
% itaes_bas = zeros(n,sample);
itaes_bas_multi = zeros(n,sample);
itaes_bsas = zeros(n,sample);
for i=1:n
    for j=1:sample
        % [~, itaes_bas(i,j)] = bas_itae(G(i));
        [~, itae_temp] = bas_multistart(multistart, G(i));
        itaes_bas_multi(i,j) = min(itae_temp);
        [~, itaes_bsas(i,j)] = bsas_itae(G(i));
    end
end

% [bas_var, bas_mean] = var(itaes_bas, 0, 2);
[bas_multi_var, bas_multi_mean] = var(itaes_bas_multi, 0, 2);
[bsas_var, bsas_mean] = var(itaes_bsas, 0, 2);

%% Visualization
% 
figure;
x = 1:length(itaes_bas_multi);
hold on;
% scatter(x, itaes_bas_multi, 'filled');
scatter(x, itaes_bsas, 'filled');
% plot([x(1), x(end)], [bas_multi_mean, bas_multi_mean]);
plot([x(1), x(end)], [bsas_mean, bsas_mean]);
hold off;
grid on;
title('BSAS scatter plot')
xlabel('Execution');
ylabel('ITAE value');
legend('BSAS', 'ITAE mean');
