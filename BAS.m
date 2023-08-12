%% BAS Algorithm script
% The BAS algorithm is a new bionic algorithm. The
% biological principle is that when a beetle searches for food, it
% is unknown where the food is located at first, but searches
% for food according to the strength of the food smell. The
% beetle has two long antennae. If the intensity of the odor
% received by the left antennae is greater than that of the right
% antennae, then the beetle will fly to the left and vice versa.
% According to this simple principle, beetle can find food
% efficiently.

function [x_best, y_best] = BAS(doPlot)
% Parameters
d = 3;          % antennae's sensing length
n = 100;        % Max number of iterations
eta = 0.95;     % step factor
delta = 10;     % search step size


% Beetle position and orientation randomly initialized
dim = [3, 1];
x = rand(dim);      % random position of beetle
x = x / norm(x);

% Data history for visualization
x_history = zeros(dim) * ones(1, n);
y_history = zeros(1, n);

% First cost function value
x_best = x;
y_best = cost_fun(x);

% Iterations
for i=1:n
    % Data history for visualization
    y = cost_fun(x);     % evaluate cost function in current position
    x_history(:, i) = x;
    y_history(i) = y;

    % Random search direction
    b = rand(dim);      
    b = b / norm(b);

    % Left and right antennae's position update
    x_r = x + d * b;
    x_l = x - d * b;
    
    % Update beetle's position
    x = x + delta * sign(cost_fun(x_l) - cost_fun(x_r)) * b;
    y = cost_fun(x);

    if  y < y_best
        y_best = y;
        x_best = x;
    end
    
    % Update d and delta
    % Comment next two lines to set d and delta as constants
    d = d * eta + 0.01;
    delta = delta * eta;
end

% Visualization
if doPlot == true
    
end

end


% Cost function: denotes concentration of odour at position x. Maximum
% value of x corresponds to the source of the odour.
function y = cost_fun(x) 

% Michalewicz function
y = -sin(x).*(sin(x.^2/pi)).^20-sin(y).*(sin(2*y.^2/pi)).^20;

end