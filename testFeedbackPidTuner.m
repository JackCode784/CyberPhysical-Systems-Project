%% Using pidTuner function to tune PID parameters
% 

s = tf('s');
G = -21.99 / ((s+1)*s*(-22.96*s+1));
Gf = feedback(G, 1);

% Closed loop step response
step(Gf);
% ylim([0 2]);
grid on;

% Root locus open loop system
figure;
rlocus(G);
grid on;

% Use PID
R = pidtune(G, 'PID');
S = feedback(G*R, 1);

% Set PID params
k = [R.Kp, R.Ki, R.Kd];

% Closed loop step response with PID
figure;
step(S);
grid on;

% Complete system root locus
figure;
rlocus(S);
grid on;
