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
eta = 0.95;     % learning rate?
delta = 1;      % search step size


% Beetle position and orientation randomly initialized
dim = [3, 1];
x = rand(dim);      % random position of beetle
x = x / norm(x);

% Data history for visualization
x_history = zeros(dim) * ones(1, n);
y_history = zeros(1, n); 

% Evaluate fitness function in current position
y_best = fitness_fun(x);
x_best = x;

for i=1:n
    % Data history for visualization
    x_history(:, i) = x_best;
    y_history(i) = y_best;

    % Random search direction
    b = rand(dim);      
    b = b / norm(b);

    % Left and right antennae's position update
    x_r = x + d * b;
    x_l = x - d * b;
    
    % Update beetle's position
    x = x + delta * sign(fitness_fun(x_r) - fitness_fun(x_l)) * b;
    
    y_curr = fitness_fun(x);
    if  y_curr < y_best
        y_best = y_curr;
        x_best = x;
    end
    
    % Update d and delta
    % Comment next two lines to set d and delta as constants
    d = d * eta + 0.01;
    delta = delta * eta;
end
if doPlot == true

end

end


% Fitness function: denotes concentration of odour at position x. Maximum
% value of x corresponds to the source of the odour.
function [x_bst, y_bst] = fitness_fun(x) 

% theta=x;
% x=theta(1);
% y=theta(2);

% % Michalewicz function
% y_bst = -sin(x).*(sin(x.^2/pi)).^20-sin(y).*(sin(2*y.^2/pi)).^20;

end