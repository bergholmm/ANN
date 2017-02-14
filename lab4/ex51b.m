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

all_patterns = de2bi(0:2^len_patterns-1);
[num_test, len_test] = size(all_patterns); 

% for i = 1:num_test
%     pattern = all_patterns(i,:);
%     for j = 1:N
%         pattern = sgn(pattern*W);
%     end
%     all_patterns(i,:) = pattern;
% end

for i = 1:num_test
    all_patterns = sgn(all_patterns*W);
end

attractors = unique(t0(all_patterns), 'rows');
disp(attractors);