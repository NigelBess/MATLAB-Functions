
clear;
clc;
syms fxy lxy dxy uxy gxy hxy edxy rexy pxy rxy htot hmaj
%%
h = fxy*lxy/dxy*(uxy)^2/(2*gxy);
X = [fxy lxy dxy uxy gxy];
names = ["f" "L_{e}" "D" "U" "g"];
fname = "H_{major}";
texError(h,fname,X,names,'');

%%
f = edxy + rexy;
X = [edxy rexy];
names = ["\frac{\epsilon}{D}","Re"];
fname = "f";
texError(f,fname,X,names,'p');

%%
htot = pxy/(rxy*gxy);
X = [pxy rxy gxy];
names = ["P","\rho","g"];
fname = "H_{total}";
texError(htot,fname,X,names,'');
%%
hmin = htot - hmaj;
x = [htot hmaj];
names = ["H_{total}","H_{major}"];
fname = "H_{minor}";
texError(hmin,fname,x,names);