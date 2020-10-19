function [K,M,time]=limitk(klist,K,M,time)
% only keep events with selected k 
% input: klist (num. row array); K/M (num. col. vector); time (cell array corresponding to event start time fro each combination)
% output: K/M/time same format after k selection 
    [~,ind] = min(abs(K - klist));
    keep=[]; % keep all combis for the k closest to defined value
    for i=1:length(ind)
        indk=find(K==K(ind(i)));
        keep=[keep indk'];
    end
    K=K(unique(keep));M=M(unique(keep));time=time(1,unique(keep));
end