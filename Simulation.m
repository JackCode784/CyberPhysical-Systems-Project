%% Simulation Script
% This script serves as a starting point to simulate the simulink model of
% the boat and correctly assign PID parameters according to the BAS
% algorithm.
% 
% n= 100;
% y = zeros(1,n);
% for i=1:n
%     Out = sim('System.slx')
%     y(i) = Out;
% end