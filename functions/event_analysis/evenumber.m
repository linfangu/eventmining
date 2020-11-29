function [neve]=evenumber(allt,options)
% count total number of events 
% input: allt (cell array) time of events for each k 
% options.allt2 (cell array) second round - default is 0
arguments
    allt
    options.allt2 cell = {NaN}
end
neve=0;
for i=1:length(allt)
neve=neve+length(allt{i});
if ~isnan(options.allt2{1,1})
neve=neve+length(options.allt2{i});
end
end