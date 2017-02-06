addpath ./som;

cities;
[numCities, numAttr] = size(city); 
nodes = 10;
W = rand(nodes, numAttr);
eta = 0.2;
epochs = 20;
neighbours = 2;

for epoch = 1:epochs
    for i = 1:numCities
        c = city(i,:);
        diff = ones(nodes, 1) * c - W;
        dist = sum(diff.^2, 2);
        [value, index] = min(dist);

        if index - neighbours < 1
            low = 1;
            high = index + neighbours;
            overflow = nodes + (index - neighbours);
            neighbourhood = [low:high, overflow:nodes];
        elseif index + neighbours > nodes
            low = index - neighbours;
            high = nodes;
            overflow = mod(index + neighbours, nodes);
            neighbourhood = [low:high, 1:overflow];
        else
            low = index - neighbours;
            high = index + neighbours;
            neighbourhood = [low:high];

        end
        
        for j = neighbourhood
            W(j, :) = W(j, :) + eta * (c - W(j, :));
        end
    end

    if epoch == 10
        neighbours = 1;
    elseif epoch == 15 
        neighbours = 0;
    end
end

tour = [W;W(1,:)];
plot(tour(:,1), tour(:,2), 'b-*', city(:,1), city(:,2), '+')

