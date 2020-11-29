function [allt,allm,allk]=alltmk(klist,K,M,time)
% derive all event time and m information for specified klist
% input: (num vector)klist; (num vector)K; (num vector)M; (cell array)time
% output: allt (num vector) start time of output events; 
allt=cell(1,length(klist));allm=cell(1,length(klist));allk=cell(1,length(klist));
for l=1:length(klist)
    [Ks,Ms,times]=limitk(klist{l},K,M,time);
    for i = 1:length(Ms)
        allt{l}=[allt{l},times{i}];
        allm{l}=[allm{l},repelem(Ms(i),length(times{i}))];
        allk{l}=[allk{l},repelem(Ks(i),length(times{i}))];
    end
end