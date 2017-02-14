clear;
addpath ./stuff;

nodes = 8;
N = log(nodes);

x1 = vm([0 0 1 0 1 0 0 1]);
x2 = vm([0 0 0 0 0 1 0 0]);
x3 = vm([0 1 1 0 0 1 0 1]);

patterns = [x1; x2; x3];
[num_patterns, len_patterns] = size(patterns); 
W = zeros(nodes, nodes);

N = log(nodes);

for i = 1:num_patterns
    W = W + patterns(i,:)'.*patterns(i,:) - eye(nodes);
end

W = W / num_patterns;
              
disp(t0(sgn(x1*W)))
disp(t0(sgn(x2*W)))
disp(t0(sgn(x3*W)))

