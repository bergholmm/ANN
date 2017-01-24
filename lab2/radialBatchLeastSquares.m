clear;
addpath ./info;

x = [0:0.1:2*pi]';
y = square(2*x);
units = 50;

makerbf();
Phi = calcPhi(x, m, var);

w = Phi \ y;
f = Phi * w;

rbfplot1(x, f, y, units);