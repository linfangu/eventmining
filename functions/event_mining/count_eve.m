function [ne]=count_eve(K,time,total_l)
% count number of event at each time point
% input: K -num.vector; time -cell array containing num. vectors;
% total_l - (num.) total length of time
% output - num. array 1D
ne=zeros(1,total_l);
for r=1:length(time)% combi index
    for e=1:length(time{r}) % events for this combi
        ne(time{r}(e):time{r}(e)+K(r))=ne(time{r}(e):time{r}(e)+K(r))+1;
        % for each event add one
    end
end
end