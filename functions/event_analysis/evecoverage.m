function [ceve]=evecoverage(l,allt,allk,options)
% count total number of events 
% input: l (array) total time
% allt (cell array) time of events for each k 
arguments
    l
    allt
    allk
    options.position (1,1)='c'
end
ceve=zeros(1,l);
for i=1:length(allt)
    for k=1:length(allt{i})
        if options.position=='c'
        if length(allk{i})>1
            ceve(allt{i}(k)-allk{i}(k)/2:allt{i}(k)+allk{i}(k)/2)=1;
        else
            ceve(allt{i}(k)-allk{i}/2:allt{i}(k)+allk{i}/2)=1;
        end
        else 
            if length(allk{i})>1
            ceve(allt{i}(k):allt{i}(k)+allk{i}(k))=1;
        else
            ceve(allt{i}(k):allt{i}(k)+allk{i})=1;
            end
        end
    end
end
