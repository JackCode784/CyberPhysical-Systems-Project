%% Cost function for BAS algorithm.
% Denotes the opposite of the concentration of odour at position x. 
% Minimum value of x corresponds to the source of the odour. Vectors are
% given as columns.

function y = cost_fun(x)
% Michalewicz function
sz = size(x);
d = diag(1:sz(1));
m = 10;
y = -sum(sin(x) .* (sin(d * (x .^ 2) / pi) .^ (2 * m)));    % Correct
y = y'; % column vector

% Alternatively
% d = (1:sz(1))' * ones(1,sz(2));
% y = -sum(sin(x) .* (sin(d .* (x .^ 2) / pi) .^ (2 * m)));

end
