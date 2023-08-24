%% Simulation Script
% This script serves as a starting point to simulate the simulink model of
% the boat and correctly assign PID parameters according to the BAS
% algorithm.
% 

function k = Simulation(doPlot)

n_dims = 3;             % search space dimension
d = 3;                  % antennae's sensing length
% d0 = 0.001;             % Constant
eta = 0.95;             % step factor
delta = 10;             % search step size
n= 100;                 % max number of iterations
k = zeros(n_dims, 1);   % set of PID parameters to evaluate ITAE

% Beetle position and orientation randomly initialized
sz = [n_dims, 1];
x = rand(sz);       % random position of beetle
x = x / norm(x);

% Data history
x_history = zeros(n_dims, n);
y_history = zeros(n, 1);        % history of itae in every traversed position
itaes = zeros(2,n);             % history of itaes computed

% First set of k_p, k_i, k_d
x_best = x;
k = x;
simOut = sim("System.slx", "SrcWorkspace", "current");
y_best = simOut.itae_test(end);
y_best_history = zeros(n,1);

% Iterations
for i=1:n
    % Data history
    y_best_history(i) = y_best;
    x_history(:,i) = x;
    y_history(i) = simOut.itae_test(end);

    % Random search direction
    b = rand(sz);
    b = b / norm(b);

    % Left and right antennae's position update
    x_r = x + d * b;
    x_l = x - d * b;

    % Evaluate ITAE cost function in x_r, x_l
    k = x_l;
    itaes(1,i) = sim("System.slx", "SrcWorkspace", "current").itae_test(end);
    k = x_r;
    itaes(2,i) = sim("System.slx", "SrcWorkspace", "current").itae_test(end);

    % Update beetle's position
    x = x + delta * sign(itaes(1,i) - itaes(2,i)) * b;
    k = x;
    simOut = sim("System.slx", 'SrcWorkspace', 'current');
    y = simOut.itae_test(end);

    if y < y_best
        y_best = y;
        x_best = x;
    end

    % Update d and delta
    % d = d * eta + d0;
    delta = delta * eta;
end

% Best parameters found
k = x_best;
display(['Best parameters found: ', num2str(k(1)), ', ', num2str(k(2)), ', ', num2str(k(3))]);

if doPlot == true
    %% Visualization
    figure;
    hold on;
    plot3(x_history(1,:), x_history(2,:), x_history(3,:), 'Color','r', 'LineStyle','-.');
    plot3(x_best(1), x_best(2), x_best(3), 'Color', 'black', 'Marker','x');
    plot3(x_history(1,end), x_history(2,end), x_history(3, end), 'Color','green', 'Marker', '*');
    hold off;
    xlabel('k_p');
    ylabel('k_i');
    zlabel('k_d');
    title('Beetle path');
    legend('Path','Local minimum', 'Final beetle position', 'Location','southeast');
    grid on;
    
    % Plot itae against iterations
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
