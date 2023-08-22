%% Using pidTuner function to tune PID parameters
% 

s = tf('s');
G = -21.99 / ((s+1)*s*(-22.96*s+1));
Gf = feedback(G, 1);

% Closed loop step response
step(Gf);
% ylim([0 2]);

% Root locus open loop system
figure;
rlocus(G);

% Use PID
R = pidtune(G, 'PID');
S = feedback(G*R, 1);

% Closed loop step response with PID
figure;
step(S);

% Complete system root locus
figure;
rlocus(S);
