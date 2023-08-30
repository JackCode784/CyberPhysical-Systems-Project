%% 
%
close all;
s = tf('s');
G = 21.99 / ((s+1)*s*(1+22.99*s));      % Plant tf
[k_bas, ~] = bas_itae(G);

pid_bas = k_bas' * [1; 1/s; s];    % Instantiate PID with BAS PID parameters
S_bas = feedback(pid_bas * G, 1);               % Close the loop

pid_ideal = pidtune(G, 'PID');
k_ideal = [pid_ideal.Kp; pid_ideal.Ki; pid_ideal.Kd];
S_ideal = feedback(G*pid_ideal, 1);

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


t = 1000;
% Closed loop step response with PID
figure;
hold on;
step(S_ideal, t);
step(S_bas,t);
hold off;
title('CL step response with PID');
grid on;
legend('PID tuner', 'BAS PID');

% Closed loop poles and zeros
figure;
pzplot(S_ideal);
title('CL system poles and zeroes PID tuner')
grid on;

figure;
pzplot(S_bas);
title('CL system poles and zeroes BAS PID');
grid on;