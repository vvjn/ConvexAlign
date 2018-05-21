%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load network
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [G, nodes] = load_network(filename)

f_id = fopen(filename,'r');
rawedges = textscan(f_id, ' %s %s \n ');
fclose(f_id);

nodes = unique([rawedges{1}', rawedges{2}']);
[~,edges] = ismember([rawedges{1}'; rawedges{2}'], nodes);
%M = containers.Map(nodes, 1:length(nodes));
%edges = cellfun(@(x)M(x), [rawedges{1}'; rawedges{2}']);
numV = max(max(edges));
G = sparse(edges(1,:), edges(2,:), ones(1, size(edges,2)), numV, numV);
G = G + G';
