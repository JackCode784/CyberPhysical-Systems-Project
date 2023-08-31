%% BAS.m function test script
% 

n = 100;    % Number of minima that will be found
minima = zeros(n,1);

for i=1:n
    [~, minima(i)] = BAS(false);
end

mean_minima = mean(minima);
display(['Mean of minima found: ', num2str(mean_minima)]);
