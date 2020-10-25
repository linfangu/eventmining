 function [time]=remove_dup_event(K,M,time)
% at same time point and k only keep event of biggest m (one animal)
% input: K,M (1D array) list of signigicant km combinations
% time (cell array) each cell containing start times of events for each
% combination
uni_k = unique(K);
for i = 1:length(uni_k)
    ind=find((K==uni_k(i))); % same k index
    [~,temp]=sort(M(ind),'descend'); % sorted index of M of the same K
    mlist=ind(temp); % original sorted index
    all_time=[];
    for k= 1:length(mlist) 
        if ~isempty(intersect(all_time,time{mlist(k)}))
            [~,~,ib]=intersect(all_time,time{mlist(k)});
            time{mlist(k)}(ib)=[]; % remove time if there already exist event at the same time  of higher m
        end
        all_time = [all_time,time{mlist(k)}];
    end
    % check no duplicate in all_time 
    % sprintf('check duplicate %d',~isequal(all_time,unique(all_time,'stable')))
end
