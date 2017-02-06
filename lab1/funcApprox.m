clear();
x = [-5:1:5]';
y = x;
z = exp(-x .* x * 0.1) * exp(-y .* y * 0.1)' - 0.5;

figure;
subplot(1,2,1)
mesh(x, y, z)
title('Correct')
xlabel('x')
ylabel('y')
axis([-5 5 -5 5 -0.7 0.7]);


[xdata, ~] = size(x);
[ydata, ~] = size(y);
ndata = xdata * ydata;

targets = reshape(z, 1, ndata);
[xx, yy] = meshgrid(x,y);
patterns = [reshape(xx, 1, ndata) ; reshape(yy, 1, ndata)];

iters = 1:300;
hidden = 10;
eta = 0.1;
alpha = 0.9;
error = zeros(1,100);

[insize, ~] = size(patterns);
[outsize, ndata] = size(targets);

w = randn(hidden, insize + 1);
v = randn(1, hidden + 1);

dw = 0;
dv = 0;

in = [patterns ; ones(1, ndata)];

for i = iters
    % Forward
    h = [phi(w * in) ; ones(1, ndata)];
    o = phi(v * h);
    
    % Backward
    do = (o - targets) .* dPhi(o);
    dh = (v' * do) .* dPhi(h);
    dh = dh(1:hidden, :);
    
    % Weigth update
    dw = (dw .* alpha) - (dh * in') .* (1-alpha);
    dv = (dv .* alpha) - (do * h') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
    res = sign(o);
    error(i) = sum(sum(abs(res - targets)./2));

    zz = reshape(o, xdata, xdata);
    subplot(1,2,2)
    mesh(x,y,zz)
    title(strcat('Epoch:', num2str(i)))
    xlabel('x')
    ylabel('y')
    axis([-5 5 -5 5 -0.7 0.7]);
    drawnow;
end

disp('done');