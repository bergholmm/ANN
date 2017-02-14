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

for i = 1:num_patterns
    W = W + patterns(i,:)'.*patterns(i,:) - eye(nodes);
end

W = W / num_patterns;



% Test energy at attactors

% all_patterns = de2bi(0:2^len_patterns-1);
% [num_test, len_test] = size(all_patterns); 
% 
% for i = 1:num_test
%     all_patterns = sgn(all_patterns*W);
% end
% 
% attractors = unique(all_patterns, 'rows');
% e = zeros(length(attractors), 1);
% len = length(attractors);
% 
% for i = 1:len
%     e(i) = energy(W, attractors(i,:));
% end
% disp(e);


% Test energy at distorted patterns

% x1d = vm([1 0 1 0 1 0 0 1]);
% x2d = vm([1 1 0 0 0 1 0 0]);
% x3d = vm([1 1 1 0 1 1 0 1]);
% test_patterns = [x1d; x2d; x3d];
% [num_test, len_test] = size(test_patterns);
% e = zeros(length(num_test), 1);
% 
% for i = 1:num_test
%     e(i) = energy(W, test_patterns(i,:));
% end
% disp(e);


% Follow the energy from iteration to iteration

% pattern = vm([1 1 1 0 1 1 0 1]);
% 
% for j = 1:10
%     i = randi([1 nodes], 1, 1);
%     pattern(i) = sgn(pattern*W(i,:)');
%     disp(energy(W,pattern));
% end


% W matrix with normal dist (non-symmetric and symetric)
W = -1 +(1+1)*rand(nodes, nodes);
W = 0.5*(W+W');

pattern = vm([0 0 0 0 0 0 0 0]);
iter = 1000;
e = zeros(iter, 1);

for j = 1:iter
    pattern = sgn(pattern*W);
    e(j) = energy(W,pattern);
end

[c, ia, ic] = unique(e);
c
ia