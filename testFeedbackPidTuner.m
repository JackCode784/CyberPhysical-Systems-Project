%% Using pidTuner function to tune PID parameters
% 

s = tf('s');
G = -21.99 / ((s+1)*s*(-22.96*s+1));    % Boat's transfer function
Gf = feedback(G, 1);

% Closed loop step response
step(Gf);
grid on;

% Root locus open loop system
figure;
rlocus(G);
grid on;

% Use PID
R_ideal = pidtune(G, 'PID');
S_ideal = feedback(G*R_ideal, 1);

% Set PID params
k_ideal = [R_ideal.Kp, R_ideal.Ki, R_ideal.Kd];

% Closed loop step response with PID
figure;
step(S_ideal);
title('Ideal PID step response');
grid on;

% Complete system root locus
figure;
rlocus(S_ideal);
grid on;

%% BAS PID step response test

k_bas = Simulation(false);                      % PID parameters found with BAS
bas_pid = pid(k_bas(1), k_bas(2), k_bas(3));
S_bas = feedback(bas_pid * G, 1);
figure;
step(S_bas);
title('BAS PID step response');
grid on;
