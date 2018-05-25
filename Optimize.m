function guess = Optimize(f,direction,lowerBound,upperBound)
%f must be a function
%direction should be +- 1 (do you want to find minimum or maximum)
%Optimize returns the optimized input for f 
n = 10;%n must be >2 for this function to work 
%increasing n decreases your odds of getting trapped a local
%minimum/maximum, but also increases computational work required by a
%factor of n
numIterations = 100;%increase for accuracy. decrease for efficiency
for j = 1:numIterations
domain = linspace(lowerBound,upperBound,n);
output = domain;
for i = 1:length(domain)
    output(i) = f(domain(i));
end
if direction > 0
    [m,index] = max(output);
else
    [m,index] = min(output);
end
    if index == 1
        lowerBound = domain(1);
        upperBound  = domain(2);
    elseif index == length(domain)
        lowerBound = domain(end-1);
        upperBound = domain(end);
    else
        lowerBound = domain(index - 1);
        upperBound = domain(index + 1);
    end
end
guess = (upperBound+lowerBound)/2;
end