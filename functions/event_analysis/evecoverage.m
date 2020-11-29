function [ceve]=evecoverage(l,allt,allk)
% count total number of events 
% input: l (array) total time
% allt (cell array) time of events for each k 
% options.allt2 (cell array) second round - default is 0
ceve=zeros(1,l);
for i=1:length(allt)
    for k=1:length(allt{i})
        ceve(allt{i}(k):allt{i}(k)+allk{i}(k))=1;
    end
end
