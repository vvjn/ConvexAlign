%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load similarity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Score] = load_similarity(filename, nS, nT, mapS, mapT)
%
f_id = fopen(filename,'r');
rawpairs = textscan(f_id, ' %s %s %f \n ');
fclose(f_id);

[~,edges1] = ismember(rawpairs{1}, mapS);
[~,edges2] = ismember(rawpairs{2}, mapT);
kmap = (edges1~=0) & (edges2~=0);
Score = sparse(edges1(kmap), edges2(kmap), rawpairs{3}(kmap), nS, nT);
