function [ceve]=evecoverage(l,allt,allk)
% count total number of events 
% input: l (array) total time
% allt (cell array) time of events for each k 
ceve=zeros(1,l);
for i=1:length(allt)
    for k=1:length(allt{i})
        if length(allk{i})>1
            ceve(allt{i}(k):allt{i}(k)+allk{i}(k))=1;
        else
            ceve(allt{i}(k):allt{i}(k)+allk{i})=1;
        end
    end
end
