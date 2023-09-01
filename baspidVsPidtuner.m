%% BAS PID vs pidtuner step response comparison
%

close all;
s = tf('s');

% Various tfs for testing purposes 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% G = 21.99 / ((s+1)*s*(1+22.99*s));  % Plant tf, first paper
G = 0.12/ (s*(1+ 1.27*s));          % Plant tf, "asymmetric"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[k_bas, itae_bas] = bas_itae(G);    % Use BAS to find PID parameters
pid_bas = k_bas' * [1; 1/s; s];     % Instantiate PID with BAS PID parameters
S_bas = feedback(pid_bas * G, 1);   % Close the loop

pid_ideal = pidtune(G, 'PID');
k_ideal = [pid_ideal.Kp; pid_ideal.Ki; pid_ideal.Kd];

% WIP
% % % % % % % % % % % % % % % % % % % % % % % % % % % 
pid_ideal = k_ideal' * [1;1/s;s];
S_ideal = feedback(pid_ideal * G, 1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Closed loop step response with PID
t = 0:0.01:150;
figure;
hold on;
step(S_ideal, t);
step(S_bas, t);
plot([t(1), t(end)], [1, 1], 'k-.');
hold off;
title('CL step response with PID');
grid on;
legend('PID tuner', 'BAS PID');

% Closed loop poles and zeros
figure;
hold on;
pzplot(S_ideal);
pzplot(S_bas);
hold off;
title('CL system poles and zeroes');
legend('pidtuner', 'BAS');
grid on;

% Calcolo figure di merito uscita step PID BAS
info_step_pid_bas = stepinfo(S_bas);
rise_time_pid_bas = info_step_pid_bas.RiseTime;
overshoot_pid_bas = info_step_pid_bas.Overshoot;
settlingTime_pid_bas = info_step_pid_bas.SettlingTime;

% Calcolo figure di merito uscita step PIDTune
info_step_pid_ideal = stepinfo(S_ideal);
rise_time_pid_ideal = info_step_pid_ideal.RiseTime;
overshoot_pid_ideal = info_step_pid_ideal.Overshoot;
settlingTime_pid_ideal = info_step_pid_ideal.SettlingTime;