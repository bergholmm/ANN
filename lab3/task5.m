addpath som

% Init
cvotes;
eta = 0.2;
epochs = 20;
nodes = 100;
neigh = 50;
[nlabels, ndim] = size(votes);
w = rand(nodes, ndim);

%
% PRE: Load votes data. Init: eta, epocvhs, nodes, neigh, nlabels, ndim
% and w.
% POS: weight matrix w, where each row represents a node,
% and each column represents its weight in the nth input space.
%
for epoch = 1:epochs
    % for each city
    for row = 1:nlabels
        % Difference between the properties of city and all node weights
        % Each row i of diff is the difference between the actual animal
        % attributes and the weight of row i
        diff = votes(row,:) - w;
        
        % Square diff (remove negatives)
        % Summarise row-vise (total distance)
        dist = sum(diff.^2, 2);
        
        % Get value and row index of smallest distance
        [val, p] = min(dist);
        
        % Calculate slice indices of neighbours to be updated
        min_neigh = p-neigh;
        max_neigh = p+neigh;
        neighborhood = [];
        
        % Circularity
        if min_neigh < 1
            min_overflow = nodes - abs(min_neigh);
            neighborhood = [neighborhood,[1:p-1], [min_overflow:nodes]];
        else 
            neighborhood = [neighborhood,[min_neigh:p-1]];
        end
        if max_neigh > nodes
            max_overflow = max_neigh - nodes;
            neighborhood = [neighborhood,[p+1:nodes], [1:max_overflow]];
        else
            neighborhood = [neighborhood,[p+1:max_neigh]];
        end
        
        neighborhood = [neighborhood,[p]];
       
        
        % Update weights of winning nodes and its neighbours
        for j=neighborhood
            w(j,:) = w(j,:) + eta*(votes(row,:)-w(j,:));
        end
    end
    
    % Gradually smaller
    neigh = uint8(neigh * ((epochs-epoch)/epochs));
end

% Calculate minimum distance of node and attribute vector.
pos = ones(1, nlabels);
for row = 1:nlabels
    diff = votes(row,:) - w;
    dist = sum(diff.^2, 2);
    
    [val, p] = min(dist);
    
    % Save that node!
    pos(row) = p;
end

% Create 2d mesh from nodes
% [x, y] = meshgrid([1:sqrt(nodes)], [1:sqrt(nodes)]);

% 10x10 vector as 1x100 vector
% xpos = reshape(x, 1, nodes);
% ypos = reshape(y, 1, nodes);

% Create vector a that has a length corresponding to the number of nodes.
% Input data corresponding to number of inputs.
a = ones(1, nodes) * nlabels+1;
% Interesting part! Let's combine the vector a with the pos vector. What we
% do, is to match the column index of a with the column index with pos having that value. 
% Why?
% This gives us an [1:nodes] vector, where every column represents a node,
% and every data entry is the the entry triggering that node. Where 325
% indicates that this node was never triggered.
a(pos) = 1:nlabels;

cmpparty;
cmpsex;
cmpdistrict;

% p = the party that each person belongs to. row index = person, row value
% = party.
p = [mpparty;0];
% reshape(a, 10, 10) transforms 1x100 vector to 10x10 matrix column-wise.
% p(reshape(a, 10, 10) takes value in (reshape(a, 10, 10)) and exchanges
% the value to the value of the corresponding row in p.
image(p(reshape(a, 10, 10))+1);