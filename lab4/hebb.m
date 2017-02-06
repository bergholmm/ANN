clear;
addpath ./stuff;

x1 = vm([0 0 1 0 1 0 0 1]);
x2 = vm([0 0 0 0 0 1 0 0]);
x3 = vm([0 1 1 0 0 1 0 1]);

patterns = [x1; x2; x3]';
W = zeros(8,8);

for p = patterns
    W = W + p'.*p - eye(8);
end
              
disp(t0(sgn(x1*W)))
disp(t0(sgn(x2*W)))
disp(t0(sgn(x3*W)))