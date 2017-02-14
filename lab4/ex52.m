clear;
addpath ./stuff;

nodes = 1024;
N = log(nodes);
W = zeros(nodes, nodes);

pict;
patterns = [p1; p2; p3];
[num_patterns, len_patterns] = size(patterns); 

for i = 1:num_patterns
    W = W + patterns(i,:)'.*patterns(i,:) - eye(nodes);
end

W = W / num_patterns;

pattern = p22;
for j = 1:N
    pattern = sgn(pattern*W);
end
vis(pattern);