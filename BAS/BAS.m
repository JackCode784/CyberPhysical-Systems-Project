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
% 
% Input:
%   - doPlot: boolean to visualize data
% 
% Output:
%   - x_best: cost function's local minimum found
%   - y_best: cost function value in the local minimum x_best
% 

function [x_best, y_best] = BAS(doPlot)
close all;

% Parameters
n_dims = 3;     % search space dimension
d = 3;          % antennae's sensing length
% d0 = 0.001;     % Constant
eta = 0.95;     % step factor
delta = 10;     % search step size
n = 100;        % max number of iterations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing
% n_dims = 2;
% d = 2;
% delta = 0.8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Beetle position and orientation randomly initialized
sz = [n_dims, 1];
x = rand(sz);       % random position of beetle
x = x / norm(x);

% Data history for visualization
x_history = zeros(n_dims, n);
y_history = zeros(n, 1);

% First cost function value
x_best = x;
y_best = cost_fun(x);
y_best_history = zeros(n,1);

% Iterations
for i=1:n
    % Data history for visualization
    y_best_history(i) = y_best;
    y = cost_fun(x);        % evaluate cost function in current position
    x_history(:, i) = x;    
    y_history(i) = y;

    % Random search direction
    b = rand(sz);      
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
    % d = d * eta + d0;
    delta = delta * eta;
    
end

% Visualization
if doPlot == true
    % Testing in 2 dimensions
    if n_dims == 2
        x_star = [2.20319; 1.57049];
        y_star = cost_fun(x_star);

        % Plot
        % Plot beetle path, global minimum in 2D, local minimum found and
        % final position of the beetle
        figure;
        hold on;
        plot(x_history(1,:), x_history(2,:), '-o');
        plot(x_star(1), x_star(2), 'r*');
        plot(x_best(1), x_best(2), 'b+');
        plot(x_history(1,end), x_history(2,end), 'kx');
        hold off;
        xlabel('x_1');
        ylabel('x_2');
        title('Beetle path');
        legend('Beetle path', 'Global minimum', 'Local minimum', 'Final position')
        grid on;

        % Plot cost function
        figure;
        hold on;
        plot(1:n, y_history, '-o');
        plot([1 n], [y_best y_best], 'Color','k', 'LineStyle',':');
        plot([1 n], [y_star y_star], "Color","g", "LineStyle","--");
        hold off;
        xlabel('Iterations');
        ylabel('Cost function');
        title('Cost function exploration');
        legend('Cost function', 'Local minimum', 'Global minimum');
        grid on;
    elseif n_dims == 3
        % Plot for 3-dimensional cost function
        figure;
        hold on;
        plot3(x_history(1,:), x_history(2,:), x_history(3,:), 'Color', 'r', LineStyle='-.');
        plot3(x_best(1), x_best(2), x_best(3), 'Color', 'black', 'Marker','x');
        plot3(x_history(1,end), x_history(2,end), x_history(3, end), 'Color','green', 'Marker', '*');
        hold off;
        xlabel('k_p');
        ylabel('k_i');
        zlabel('k_d');
        title('Beetle path');
        legend('Path','Local minimum', 'Final beetle position', 'Location','southeast');
        grid on;

        % Plot cost function vs iterations
        figure;
        hold on;
        plot(1:n, y_history);
        plot(1:n, y_best_history, 'LineStyle','-.', 'Color','r');
        hold off;
        xlabel('Iteration');
        ylabel('Cost function');
        title('Cost function vs iterations');
        legend('Cost func', 'Minimum found');
        grid on;
    end
end

end
