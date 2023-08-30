%% Testing differences between PID tuner's and BAS PID parameters in step responses
% 

close all;

s = tf('s');
%G = 21.99 / ((s+1)*s*(22.96*s+1));      % Boat's transfer function
%G = (s+0.25) / (s*(s+1)*(6*s+1));
%G = 0.12 / (s*(1+1.27*s)); 
Gf = feedback(G, 1);                    % Close the loop without PID

% Closed loop without PID step response
step(Gf);
title('CL no PID step response');
grid on;

% Root locus open loop system
figure;
rlocus(G);
title('OL root locus');
grid on;

% Use PID tuner
pid_ideal = pidtune(G, 'PID');
k_ideal = [pid_ideal.Kp; pid_ideal.Ki; pid_ideal.Kd];
S_ideal = feedback(G*pid_ideal, 1);

% Closed loop step response with PID
figure;
step(S_ideal);
title('CL ideal PID step response');
grid on;

% Complete system pz map
figure;
pzplot(S_ideal);
title('CL ideal system poles and zeroes');
grid on;

%% BAS PID step response test
k_bas = Simulation(false);                      % PID parameters found with BAS
pid_bas = pid(k_bas(1), k_bas(2), k_bas(3));    % Instantiate PID with BAS PID parameters
S_bas = feedback(pid_bas * G, 1);               % Close the loop

% Poles and zeroes plot
figure;
pzplot(S_bas);
title('BAS PID regulated system poles and zeroes');
grid on;

% BAS PID step response
figure;
step(S_bas);
title('BAS PID step response');
grid on;

%% Handmade PID
pid_hand_ideal = k_ideal' * [1; 1/s; s];
pid_hand_bas = k_bas' * [1; 1/s; s];

% Handmade systems
S_hand_ideal = feedback(pid_hand_ideal * G, 1);
S_hand_bas = feedback(pid_hand_bas * G, 1);

% Step responses
figure;
hold on;
step(S_hand_ideal);
step(S_hand_bas);
hold off;
title('Handmade PIDs step responses');
grid on;
legend('PID tuner', 'BAS PID');
