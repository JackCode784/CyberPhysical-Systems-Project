%% BAS.m function test script
% 

n = 100;    % Number of minima that will be found
minima = zeros(n,2);

for i=1:n
    [~, minima(i,1)] = BAS(false);
    [minima(i,2)] = BAS2();
end

mean_minima = mean(minima);
display(['Mean of minima implemented: ', num2str(mean_minima(1))]);
display(['Mean of minima original: ', num2str(mean_minima(2))]);
