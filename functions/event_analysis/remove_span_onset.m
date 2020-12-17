function [time,cells]=remove_span_onset(K,time,cells,onset,options)
% remove the events tht spans the trial onsets 
% input: K - num array; time,cells - cell array; onset (num array) binary 0/1 for onsets at each
% time point same as event time scale 
arguments
K
time
cells
onset
options.aligned (1,1) logical = 1
options.timefilter
end
for i=1:length(K)
    l=length(time{i});
    rmv=[];
    for j=1:l
        if options.aligned == 0
           t=find(options.timefilter);
           eve=t(time{i}(j));
        else
            eve=time{i}(j);
        end
        if sum(onset(eve:eve+K(i)))>0
            rmv=[rmv,j];
        end
    end
    if ~isempty(rmv)
    time{i}(rmv)=[];cells{i}(rmv)=[];
    end
end