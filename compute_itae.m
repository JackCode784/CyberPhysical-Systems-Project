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
    
    pid = k' * [1;1/s;s];
    T = pid;
    l = length(pid);
    for i=1:l
        T(i) = feedback(pid(i) * sys, 1);
    end

    % y has as many columns as rows in pid
    time = 0:0.01:100;
    [y, t] = step(T, time);
    e = abs(y - y_ref);
    itae = sum(e .* t);
end
