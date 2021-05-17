function [em,ev_merge]=tmk_main(klist,em,options)
% find events for length in the klist, merge if there are two rounds, and
% remove highly overlapped event in time 
% input and output are both specified em files 
arguments
    klist
    em
    options.nround (1,1)=2
end
[N,nm]=size(em{1,1}.eve);
ev_merge=cell(N,nm);
% events
for p=1:N
    for m=1:nm
        for r=1:options.nround % two rounds
            [allt,allm,allk]=alltmk(klist,em{r,1}.K{p,m},em{r,1}.M{p,m},em{r,1}.time{p,m});
            em{r,1}.allt{p,m}=allt;em{r,1}.allm{p,m}=allm;em{r,1}.klist=klist;em{r,1}.allk{p,m}=allk;
        end
        ev_merge{p,m}=cell(1,4);
        for k=1:4
            if options.nround==2
                % merge events from the two rounds of detection
                ev_merge{p,m}{k}=combine_2_r(em{1,1}.allt{p,m}{k},find(em{2,1}.timefilter{p,m}),em{2,1}.allt{p,m}{k},'position','center',"k",klist{k});
            elseif options.nround==1
                ev_merge{p,m}{k}=allt{p,m}{k}+klist{k}/2;
            end
            ev_merge{p,m}{k}=remove_time_ovp(ev_merge{p,m}{k},klist{k}); % remove highly overlapped events
        end
    end
end