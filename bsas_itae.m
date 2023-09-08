%% BSAS algorithm function
% Beetle antennae search (BAS) is an efficient metaheuristic algorithm.
% However, the convergent results of BAS rely heavily on the random beetle
% direction in every iterations. More specifically, different random seeds
% may cause different optimized results. Besides, the step-size update
% algorithm of BAS cannot guarantee objective become smaller in iterative
% process. Beetle Swarm Antennae Search Algorithm (BSAS) combines swarm
% intelligence algorithm with feedback-based step-size update strategy.
% BSAS employs k beetles to find more optimal position in each moving
% rather than one beetle. The step-size updates only when k beetles return
% without better choices. BSAS algorithm is designed to avoid influence of
% random direction of Beetle. The estimation errors decrease as the beetles
% number goes up.
%
% This version of BSAS is already implemented to evaluate the best
% parameters for PID to regulate a plant.
%
% Input:
%     - sys: open loop plant transfer function
%
% Output:
%     - k_best: cost function's local minimum found
%     - itae_best: cost function value in the local minimum k_best
%

function [k_best, itae_best] = bsas_itae(sys)

% Parameters (BAS)
n = 100;        % number of iterations
n_dims = 3;     % search space dimensions
eta = 0.95;     % step factor
delta = 100;    % search step size
d = 3;          % antennae's sensing length
d0 = 0.001;     % constant
% delta0 = 0.01;  % constant

% Parameters (BSAS)
n_beetles = 50;     % number of beetles
proba = 0.1;        % probability constant

% Beetle position and orientation randomly initialized
sz = [n_dims, 1];
k = rand(sz) - 0.5;
k = k / norm(k);
k_best = k;
itae_cur = compute_itae(k, sys, 1);
itae_best = itae_cur;
k = k * ones(1,n_beetles);

for i=1:n
    % Random search directions
    b = rand([n_dims, n_beetles]) - 0.5;
    b = b ./ vecnorm(b);

    % Left and right antennae's position update
    k_r = k + d * b;
    k_l = k - d * b;

    % Compute ITAEs for left and right position
    % itae will have one column for each beetle
    itae_l = compute_itae(k_l, sys, 1);
    itae_r = compute_itae(k_r, sys, 1);

    % Update position
    k = k + delta * sign(itae_l - itae_r) .* b;
    itae_cur = compute_itae(k,sys,1);

    if min(itae_cur) < itae_best
        itae_best = min(itae_cur);
        k_best = k(:,itae_best == itae_cur);
        k = k_best * ones(1,n_beetles);
    elseif rand(1) > proba
        d = d * eta + d0;
        delta = delta * eta;
    end
end

end