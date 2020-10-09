function [cells,time]=mkantieve(M,K,ca_cl,threshold)
% find events for specific m,k combi
% input: M,K = numeric 
%  ca_cl: 2D matrix (cell x time)calcium data
% threshold: (numeric) thershold at event mining 
% output: cells (2D array) cell index x event index 
% time: 1D array tim of events 
cells=[];time=[];
cnt=0;
for t=1:size(ca_cl,2)-K
    cellind=sum(ca_cl(:,t:t+K),2)<(K+1)*threshold;
    if sum(cellind)>=M % at each time t to t+k if more than m neurons active, take as event
        cnt=cnt+1;
        cells(1:sum(cellind),cnt)=find(cellind);
        time=[time,t];
    end
end
end