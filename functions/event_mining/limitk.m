function [K,M,time]=limitk(klist,K,M,time)
% only keep events with selected k 
% input: klist (num. row array); K/M (num. col. vector); time (cell array corresponding to event start time fro each combination)
% output: K/M/time same format after k selection 
ind=zeros(1,length(K));
for k=1:length(klist)
    index = K==klist(k);
    ind(index)=1;
end
ind=logical(ind);
    K=K(ind);M=M(ind);time=time(1,ind);
end