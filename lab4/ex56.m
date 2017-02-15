clear;
addpath ./stuff;

max_bias = 1;
step_size = 0.1;
err = zeros(max_bias/step_size, 1);
x = [0.1:step_size:max_bias];
it = 1;
for bias = 0.1:step_size:max_bias
    nodes = 100;
    N = log(nodes);
    W = zeros(nodes, nodes);
    rho = 0.1;
    p = 18;
    patterns = zeros(p, nodes);

    for i = 1:p
        for j = 1:nodes*rho
            index = randperm(nodes, 1);
            patterns(i,index) = 1;
        end
    end


    [num_patterns, len_patterns] = size(patterns); 

    for i = 1:num_patterns
        W = W + (patterns(i,:) - rho)'.*(patterns(i,:) - rho);
    end

    W = W - diag(diag(W));
    W = W / num_patterns;

    patterns2 = patterns;

    for j = 1:N+20
        patterns2 = 0.5 + 0.5 .* sgn(patterns2 * W - bias);
    end
    a = sum(abs(patterns2-patterns), 2);
    a = a(a==0);
    [rows, cols] = size(a);
    err(it) = rows;
    
    %err(it) = sum((sum(abs(patterns2-patterns)) ./ nodes ) .* 100) / length(patterns2);
    it = it + 1;
end

plot(x, err);