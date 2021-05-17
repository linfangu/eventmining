function [ev_merge,em]=selectkmerge(klist,em,options)
% use k list to find events, merge 2 rounds if there are, and remove highly
% overlapped events within each k 
arguments
klist
em
options.nround (1,1) = 2
end
[N,nm]=size(em{1,1}.ca_cl);ev_merge=cell(N,nm);
for p=1:N
    for m=1:nm
        if options.nround==2
        for r=1:2 % two rounds
            [allt,allm,allk]=alltmk(klist,em{r,1}.K{p,m},em{r,1}.M{p,m},em{r,1}.time{p,m});
            em{r,1}.allt{p,m}=allt;em{r,1}.allm{p,m}=allm;em{r,1}.klist=klist;em{r,1}.allk{p,m}=allk;
        end 
        else 
            r=1;
            [allt,allm,allk]=alltmk(klist,em{r,1}.K{p,m},em{r,1}.M{p,m},em{r,1}.time{p,m});
            em{r,1}.allt{p,m}=allt;em{r,1}.allm{p,m}=allm;em{r,1}.klist=klist;em{r,1}.allk{p,m}=allk;
        end
        ev_merge{p,m}=cell(1,4);
        for k=1:4
            % merge events from the two rounds of detection
            if options.nround==2
            ev_merge{p,m}{k}=combine_2_r(em{1,1}.allt{p,m}{k},find(em{2,1}.timefilter{p,m}),em{2,1}.allt{p,m}{k},'position','center',"k",klist{k});
            elseif options.nround==1
                ev_merge{p,m}{k}=em{1,1}.allt{p,m}{k}+klist{k}/2;
            end
            ev_merge{p,m}{k}=remove_time_ovp(ev_merge{p,m}{k},klist{k}); % remove highly overlapped events
        end
    end
end