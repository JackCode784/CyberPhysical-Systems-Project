%% 
%

close all;
s = tf('s');
G = 21.99 / ((s+1)*s*(1+22.99*s));      % Plant tf
[k_bas, ~] = bas_itae(G);
