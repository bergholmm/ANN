clear;
addpath ./info;

x = [0 0; 0 1; 1 0; 1 1];
y = [0 1 1 0]';
units = 2;

makerbf();
Phi = calcPhi(x, m, var);

w = Phi \ y; 
f = Phi * w;

rbfplot1(x, f, y, units);

s = sign(f-y)