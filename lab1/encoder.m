clear();

patterns = eye(8) * 2 - 1;
targets = patterns;

iters = 1:2000;
hidden = 3;
eta = 0.1;
alpha = 0.9;
error = [];

[insize, ~] = size(patterns);
[outsize, ndata] = size(targets);

w = randn(hidden, insize + 1);
v = randn(insize, hidden + 1);

dw = 0;
dv = 0;

x = [patterns ; ones(1, ndata)];
for i = iters
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
    
    disp(w);
    disp(sign(w));
    
    res = sign(o);
    r = res == targets;
    disp(r);
    error(i) = sum(sum(abs(res - targets)./2));

end

plot(iters, error);
disp('done');