clear();
x = [-5:1:5]';
y = x;
z = exp(-x .* x * 0.1) * exp(-y .* y * 0.1)' - 0.5;

[xdata, ~] = size(x);
[ydata, ~] = size(y);
ndata = xdata * ydata;

n = 25;

targets = reshape(z, 1, ndata);
[xx, yy] = meshgrid(x,y);
patterns = [reshape(xx, 1, ndata) ; reshape(yy, 1, ndata)];

trainTargets = targets(1, 1:n);
trainPatterns(1, :) = patterns(1, 1:n);
trainPatterns(2, :) = patterns(2, 1:n);

iters = 1:200;
hidden = 25;
eta = 0.1;
alpha = 0.9;
error = zeros(1,100);

[insize, ~] = size(patterns);
[outsize, ndata] = size(targets);

w = randn(hidden, insize + 1);
v = randn(1, hidden + 1);

dw = 0;
dv = 0;

in = [patterns(:, n+1:ndata) ; ones(1, ndata-n)];
inTrain = [trainPatterns ; ones(1, n)];

for i = iters
    % Forward in train
    h = [phi(w * inTrain) ; ones(1, n)];
    o = phi(v * h);
    
    % Backward on train
    do = (o - trainTargets) .* dPhi(o);
    dh = (v' * do) .* dPhi(h);
    dh = dh(1:hidden, :);
    
    % Weigth update
    dw = (dw .* alpha) - (dh * inTrain') .* (1-alpha);
    dv = (dv .* alpha) - (do * h') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
    % Forward on test
    htest = [phi(w * in) ; ones(1, ndata-n)];
    otest = phi(v * htest);
    
    error(i) = sum(sum(abs(otest - targets(:, n+1:ndata))./2));
end

disp(min(error));
plot(iters, error);
disp('done');