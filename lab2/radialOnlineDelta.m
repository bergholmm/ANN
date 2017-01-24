clear;
addpath ./info;

x = [0:0.1:2*pi]';
y = square(2*x);
units = 1;
fun = 'square';
eta = 1;

makerbf();
diter();