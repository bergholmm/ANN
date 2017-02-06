clear();

genSepData();
%genNonSepData();

[insize, ndata1] = size(patterns);
[outsize, ndata2] = size(targets);

x = [patterns ; ones(1, ndata1)];
w = randn(outsize, insize + 1);
eta = 0.001;
iters = 100;

for i = 1:iters
    deltaW = -eta * ((w * x) - targets) * x';
    w = w + deltaW;
    
    p = w(1,1:2);
    k = -w(1, insize + 1) / (p*p');
    l = sqrt(p*p');
    plot ( ...
        patterns(1, find(targets>0)), patterns(2, find(targets>0)), '*', ...
        patterns(1, find(targets<0)), patterns(2, find(targets<0)), '+', ...
        [p(1), p(1)]*k + [-p(2), p(2)]/l, [p(2), p(2)]*k + [p(1), -p(1)]/l, '-' ...
    )
    title(strcat('Epoch:', num2str(i)))
    xlabel('x')
    ylabel('y')
    axis ([-2, 2, -2, 2], 'square');
    drawnow;
end

disp('done');