clear;
addpath ./info;

x = [0:0.1:2*pi]';
y = sin(2*x);

units = 40;
fun = 'sin';
eta = 2;

makerbf();
itermax = 4000;
diter();