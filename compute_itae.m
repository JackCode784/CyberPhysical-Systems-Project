%% ITAE computation
% 
% Input:
%   - k:        set of parameters to instantiate PID
%   - sys:      open loop plant system
%   - y_ref:    expected output of closed loop system
% 
% Output:
%   - itae:     itae evaluation
% 

function itae = compute_itae(k, sys, y_ref)
    s = tf('s');
    p = k' * [1;1/s;s];
    time = 0:0.1:100;
    [y, t] = step(feedback(p * sys, 1), time);
    e = abs(y - y_ref);
    itae = sum(e .* t);
end
