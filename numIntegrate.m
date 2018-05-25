function outvar = numIntegrate(x,y)
if size(x) ~= size(y)
    error('dimension mismatch')
end

outvar = 0;

for i = 2:length(x)
outvar = outvar + (x(i)-x(i-1))*(y(i)-y(i-1))/2+(x(i)-x(i-1))*y(i-1);
end
end