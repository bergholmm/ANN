clear();

%genSepData();
genNonSepData();

hidden = 2;

iters = 100;
eta = 0.1;
alpha = 0.9;
error = zeros(1,100);

[insize, ~] = size(patterns);
[outsize, ndata] = size(targets);

w = randn(hidden, insize + 1);
v = randn(1, hidden + 1);

dw = 0;
dv = 0;

x = [patterns ; ones(1, ndata)];

figure;
subplot(1,2,1)

plot ( ...
    patterns(1, find(targets>0)), patterns(2, find(targets>0)), '*', ...
    patterns(1, find(targets<0)), patterns(2, find(targets<0)), '+' ...
)
title('Correct')
xlabel('x')
ylabel('y')
axis ([-2, 2, -2, 2], 'square');

for i = 1:iters
    % Forward
    h = [phi(w * x) ; ones(1, ndata)];
    o = phi(v * h);
    
    % Backward
    do = (o - targets) .* dPhi(o);
    dh = (v' * do) .* dPhi(h);
    dh = dh(1:hidden, :);
    
    % Weigth update
    dw = (dw .* alpha) - (dh * x') .* (1-alpha);
    dv = (dv .* alpha) - (do * h') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
    res = sign(o);
    error(i) = sum(sum(abs(res - targets)./2));

    subplot(1,2,2)
    plot ( ...
        patterns(1, find(res>0)), patterns(2, find(res>0)), '*', ...
        patterns(1, find(res<0)), patterns(2, find(res<0)), '+' ...
    )
    title(strcat('Epoch:', num2str(i)))
    xlabel('x')
    ylabel('y')
    axis ([-2, 2, -2, 2], 'square');
    drawnow;

end
disp(min(error));
disp('done');