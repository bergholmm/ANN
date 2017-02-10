clear;
addpath ./stuff;

nodes = 8;

x1 = vm([0 0 1 0 1 0 0 1]);
x2 = vm([0 0 0 0 0 1 0 0]);
x3 = vm([0 1 1 0 0 1 0 1]);

patterns = [x1; x2; x3]';
W = zeros(nodes, nodes);

N = log(nodes);

for p = patterns
    W = W + p'.*p - eye(nodes);
end
              
%disp(t0(sgn(x1*W)))
%disp(t0(sgn(x2*W)))
%disp(t0(sgn(x3*W)))

%x1d = vm([1 0 1 0 1 0 0 1]);
%x2d = vm([1 1 0 0 0 1 0 0]);
%x3d = vm([1 1 1 0 1 1 0 1]);

%x = x3d;
%i = 0;

 x = de2bi(0:2^nodes-1);
 y = unique(t0(sgn(x*W)), 'rows')
