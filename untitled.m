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