function outvar = interpol(x1,y1,x2,y2,x)
[m,b] = mxb(x1,y1,x2,y2);
outvar = m*x+b;
end