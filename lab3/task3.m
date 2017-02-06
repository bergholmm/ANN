addpath ./som;

animals;
[numAnim, numAttr] = size(props); 
W = rand(100, 84);
eta = 0.2;
epochs = 20;
neighbours = 50;

for epoch = 1:epochs
    for i = 1:numAnim
        animal = props(i,:);
        diff = ones(100, 1) * animal - W;
        dist = sum(diff.^2, 2);
        [value, index] = min(dist);
        if index - neighbours <= 1
            low = 1;
            high = index + neighbours;
        elseif index + neighbours > 100
            low = index - neighbours;
            high = 100;
        else
            low = index - neighbours;
            high = index + neighbours;
        end
        W(low:high, :) = W(low:high, :) + eta * (animal - W(low:high, :));
    end

    if epoch < 10
        neighbours = neighbours - epoch;
    elseif epoch == 11 
        neighbours = neighbours - 4;
    end
end


pos = zeros(1, numAnim);
for i = 1:numAnim
    animal = props(i,:);
    diff = ones(100, 1) * animal - W;
    dist = sum(diff.^2, 2);
    [value, index] = min(dist);
    pos(i) = index;
end

[dummy, order] = sort(pos);
snames(order)'
