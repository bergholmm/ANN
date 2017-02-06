addpath ./som;

cvotes;
[numMps, numAttr] = size(votes); 
nodes = 100;
W = rand(nodes, numAttr);
eta = 0.2;
epochs = 20;
neighbours = 2;

for epoch = 1:epochs
    for i = 1:numMps
        c = votes(i,:);
        diff = ones(nodes, 1) * c - W;
        dist = sum(diff.^2, 2);
        [value, index] = min(dist);

        if index - neighbours < 1
            low = 1;
            high = index + neighbours;
        elseif index + neighbours > nodes
            low = index - neighbours;
            high = nodes;
        else
            low = index - neighbours;
            high = index + neighbours;
        end
        W(low:high, :) = W(low:high, :) + eta * (c - W(low:high, :));
    end

    if epoch == 10
        neighbours = 1;
    elseif epoch == 15 
        neighbours = 0;
    end
end

[x, y] = meshgrid([1:10], [1:10]);
xpos = reshape(x, 1, 100);
ypos = reshape(y, 1, 100);

cmpparty;
cmpsex;
cmpdistrict;

pos = zeros(349, 1);
party = zeros(nodes, 8);

for i = 1:numMps
    c = votes(i,:);
    diff = ones(nodes, 1) * c - W;
    dist = sum(diff.^2, 2);
    [value, index] = min(dist);

    pos(i) = index;
    party(index, mpparty(i)+1) = party(index, mpparty(i)+1) + 1;
end

a = ones(1, nodes)*350;
a(pos) = 1:349;

p = [mpdistrict;0];
image(p(reshape(a,10,10))+1);