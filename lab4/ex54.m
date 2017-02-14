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


for p = 0.1:0.05:0.9
    disp(int64(p*nodes));
    pattern = fp(p1, int64(p*nodes));
    vis(pattern);
    pause(1);
    for j = 1:5000
        i = randi([1 1024], 1, 1);
        pattern(i) = sgn(pattern*W(i,:)');
        if mod(j,100) == 0
            vis(pattern);
            pause(0.1);
        end
    end
end
vis(pattern);