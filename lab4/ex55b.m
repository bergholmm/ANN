clear;
addpath ./stuff;

nodes = 1024;
N = log(nodes);
W = zeros(nodes, nodes);

pict;
patterns_max = 300;
acc = zeros(patterns_max, 1);
for p = 1:patterns_max
    for i = 1:p
        patterns(i,:) = sgn(randn(1, nodes));
    end

    [num_patterns, len_patterns] = size(patterns); 

    for i = 1:num_patterns
        W = W + patterns(i,:)'.*patterns(i,:) - eye(nodes);
    end

    W = W / num_patterns;
    patterns2 = patterns;

%     for i = 1:num_patterns
%         patterns2(i,:) = fp(patterns(i,:), int64(0.1*nodes));
%     end

    for j = 1:N
        %i = randi([1 len_patterns], 1, 1);
        patterns2 = sgn(patterns2*W);
    end

    err_avg = sum((sum(abs(patterns2-patterns)) ./ nodes ) .* 100) / length(patterns2);
    acc(p) = err_avg;
end

plot([1:patterns_max], acc)