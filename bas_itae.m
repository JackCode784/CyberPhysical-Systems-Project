%% BAS step
% Compute a step of BAS optimization algorithm.
%
% Input:
%   - sys: open loop plant transfer function
%
% Output:
%   - k_best: cost function's local minimum found
%   - itae_best: cost function value in the local minimum k_best
%

function [k_best, itae_best] = bas_itae(sys)

    % Parameters
    n = 100;        % number of iterations
    n_dims = 3;     % search space dimension
    eta = 0.95;     % step factor
    delta = 100;     % search step size. Tested values: 10, 100, 50
    d = 3;          % antennae's sensing length
    % d0 = 0.001;   % Constant
    
    % Beetle position and orientation randomly initialized
    sz = [n_dims, 1];
    k = rand(sz);       % random position of beetle
    k = k / norm(k);
    
    % Initialize best set of parameters
    k_best = k; 
    % Fix: compare ITAE in current position with itae_l, itae_r. If better,
    % skip an iteration
    itae_cur = compute_itae(k, sys, 1);
    itae_best = itae_cur;

    for i=1:n
        % Random search direction
        b = rand(sz);
        b = b / norm(b);

        % Left and right antennae's position update
        k_r = k + d * b;
        k_l = k - d * b;

        % Compute ITAEs for left and right position
        itae_l = compute_itae(k_l, sys, 1);
        itae_r = compute_itae(k_r, sys, 1);

        % Fix: compare ITAE in current position with itae_l, itae_r. If better,
        % skip an iteration
        if min([itae_r, itae_l]) > itae_cur
            continue;
        end

        % Update parameters
        k = k + delta * sign(itae_l - itae_r) * b;
        itae_cur = compute_itae(k, sys, 1);

        if itae_cur < itae_best
            k_best = k;
            itae_best = itae_cur;
        end

        % Update step size
        delta = delta * eta;
    end
end
