function outvar = whereCross(xSpace,space1,space2)
if nargin == 2
dx = 1;
end
if length(space1) ~= length(space2) || length(xSpace)~= length(space2)
    error('length mismatch')
end
for i = 2:length(space1)
    if space2(i) == space1(i)
        y = space1(i);
        x = i*dx;
        outvar = send(nargin,y,x);
        return
    end
    if sign(space2(i)-space1(i)) ~= sign(space2(i-1)-space1(i-1))
        x = xSpace(i);
        dx = xSpace(i)- xSpace(i-1);
        m1 = (space1(i)-space1(i-1))/dx;
        b1 = space1(i)-x*m1;
        m2 = (space2(i)-space2(i-1))/dx;
        b2 = space2(i)-x*m2;
        x = (b2-b1)/(m1-m2);
        y = m1*x+b1;
        outvar = send(nargin,y,x);
        return
    end

end
    error('the lines never cross');
end
function outvar = send(args,y,x)
if args == 2
            outvar = y;
        else
            outvar = [x,y];
end
end