function [Data] = load_dataset_interface(foldername, names)

%%%%% load number of input networks
%prompt = 'How many networks do you want to align? ';
%num_net = input(prompt);
num_net = length(names)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the networks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
networkFolderName = [foldername, '/Net/'];
%names={};
for i = 1 : num_net
    %prompt = sprintf('Name of %d network:',i);
    %Data.Network{i}.name = input(prompt,'s');
    Data.Network{i}.name = names{i};
    %names = [names,Data.Network{i}.name];
    [Data.Network{i}.G,Data.Network{i}.Map] = load_network([networkFolderName, Data.Network{i}.name, '.net']);
    sizes(i) = size(Data.Network{i}.G, 1);
end
Data.Map = names;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the similarity functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
similarityFolderName = [foldername, '/Sim/'];
temp = dir(similarityFolderName);
counter = 1;
for i = 1 : num_net
    for j = i+1 : num_net
        Data.Similarity{counter}.name = [i,'-',j];
        Data.Similarity{counter}.name = [Data.Network{i}.name,'-',Data.Network{j}.name,'.sim'];
        Data.Similarity{counter}.Score = load_similarity([similarityFolderName, Data.Similarity{counter}.name ], sizes(i), sizes(j), Data.Network{i}.Map, Data.Network{j}.Map);
        counter = counter + 1;
    end
end
