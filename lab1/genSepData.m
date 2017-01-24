classA(1,:) = randn(1,100) .* 0.5 + 1.0;
classA(2,:) = randn(1,100) .* 0.5 + 0.5;
classB(1,:) = randn(1,100) .* 0.5 - 1.0;
classB(2,:) = randn(1,100) .* 0.5 + 0.0;

targetA = ones(1, 100);
targetB = ones(1, 100) .*(-1);

patterns = [classA, classB];
targets = [targetA, targetB];

permute = randperm(200);
patterns = patterns(:, permute);
targets = targets(:, permute);

% plot ( ...
%     patterns(1, find(targets>0)), patterns(2, find(targets>0)), '*', ...
%     patterns(1, find(targets<0)), patterns(2, find(targets<0)), '+' ...
% );