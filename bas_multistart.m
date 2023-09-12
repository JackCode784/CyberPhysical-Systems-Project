%% Multistart BAS
% Apply multistart to BAS algorithm to enhance performances.
% 
% Input:
%   - multi:    number of times the bas_itae function gets called
%   - sys:      open loop plant transfer function
% 
% Output:
%   - k:        matrix of PID parameters found for each start of bas_itae
%   - itaes:    matrix of itae cost function values for each start of
%               bas_itae
% 

function [k, itaes] = bas_multistart(multi, sys)

    k = zeros(3,multi);
    itaes = zeros(multi,1);
    
    for i=1:multi
        [k(:,i), itaes(i)] = bas_itae(sys);
    end

end
