function [remlist]=greedy_remove(cormat,th)
% use greedy algorithm to remove nodes with highest degree until no nodes
% with degree higher than threshold
% (all non-zero elements are considered edges)
% input: Cormat (square matrix) edge between all nodes
% remlist: (1D array) remove list 
deg=sum(cormat~=0); % degrees for each node
remlist=[];
indall=1:length(deg);
while sum(deg)>th
    [~,ind]=maxk(deg,1);
    remlist=[remlist,indall(ind)];
    cormat(ind,:)=[];cormat(:,ind)=[];indall(ind)=[];
    deg=sum(cormat~=0);
end