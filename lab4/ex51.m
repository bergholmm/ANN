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

x1d = vm([1 0 1 0 1 0 0 1]);
x2d = vm([1 1 0 0 0 1 0 0]);
x3d = vm([1 1 1 0 1 1 0 1]);
test_patterns = [x1d; x2d; x3d];
[num_test, len_test] = size(test_patterns); 

for i = 1:num_test
    pattern = test_patterns(i,:);
    for j = 1:N
        pattern = sgn(pattern*W);
    end
    disp(t0(pattern));
end