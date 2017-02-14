clear;
addpath ./stuff;

nodes = 1024;
N = log(nodes);
W = zeros(nodes, nodes);

pict;
patterns = [p1; p2; p3; p4;];
[num_patterns, len_patterns] = size(patterns); 

for i = 1:num_patterns
    W = W + patterns(i,:)'.*patterns(i,:) - eye(nodes);
end

W = W / num_patterns;

pattern = p4;

for j = 1:N
    %i = randi([1 len_patterns], 1, 1);
    %pattern(i) = sgn(pattern*W(i,:)');
    pattern = sgn(pattern*W);
    if mod(j,100) == 0
        vis(pattern);
        pause(0.1);
    end
end
vis(pattern);