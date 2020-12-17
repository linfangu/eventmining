% video analysis for events and anti-events
%% pre-processing
% get simplified events and antievents
load('em_18p_th0.5.mat')
load('em_18p_antievent_0.05.mat')
load('dTT_SYN_18Pair_R3_10032020.mat')
em=rem_dup_em(em);
anti=rem_dup_em(anti,'nround',1);
[N,nm]=size(em{1,1}.eve);
%% remove events that span through trial onsets 
for p=1:N
    for m=1:nm
        onset = sum(reshape(E{p}{1}.BehaviorVectors(1:30*size(em{1,1}.ca_cl{p,1},2),4),30,size(em{1,1}.ca_cl{p,1},2)),1);
        [em{1,1}.time{p,m},em{1,1}.cells{p,m}]=remove_span_onset(em{1,1}.K{p,m},em{1,1}.time{p,m},em{1,1}.cells{p,m},onset);
        [em{2,1}.time{p,m},em{2,1}.cells{p,m}]=remove_span_onset(em{2,1}.K{p,m},em{2,1}.time{p,m},em{2,1}.cells{p,m},onset,'aligned',0,'timefilter',em{2,1}.timefilter{p,m});
        [anti{1,1}.time{p,m},anti{1,1}.cells{p,m}]=remove_span_onset(anti{1,1}.K{p,m},anti{1,1}.time{p,m},anti{1,1}.cells{p,m},onset);
    end
end
% find events separately for 4 Ks
klist={5,20,40,100};
% events
for r=1:2
    allt=cell(N,nm);allm=cell(N,nm);allk=cell(N,nm);
    for p=1:N
        for m=1:nm
            [allt{p,m},allm{p,m},allk{p,m}]=alltmk(klist,em{r,1}.K{p,m},em{r,1}.M{p,m},em{r,1}.time{p,m});
        end
    end
    em{r,1}.allt=allt;em{r,1}.allm=allm;em{r,1}.klist=klist;em{r,1}.allk=allk;
end
% antievents
allt=cell(N,nm);allm=cell(N,nm);allk=cell(N,nm);
for p=1:N
    for m=1:nm
        [allt{p,m},allm{p,m},allk{p,m}]=alltmk(klist,anti{1,1}.K{p,m},anti{1,1}.M{p,m},anti{1,1}.time{p,m});
    end
end
anti{1,1}.allt=allt;anti{1,1}.allm=allm;anti{1,1}.klist=klist;anti{1,1}.allk=allk;
% get frames of events
evecov=cell(N,nm);anticov=cell(N,nm);
for p=1:N
    for m=1:2
        l=size(em{1,1}.ca_cl{p,m},2);
        [evecov{p,m}]=evecoverage(l,em{1,1}.allt{p,m},em{1,1}.allk{p,m});
        % second round
        s=find(em{2,1}.timefilter{p,m}); % time label of the second round
        evecov2=[];
        [evecov2]=evecoverage(length(s),em{2,1}.allt{p,m},em{2,1}.allk{p,m});
        evecov{p,m}(s(logical(evecov2)))=1; % binary array of event coverage at all time
        % expand from second to frame
        evecov{p,m}=repelem(evecov{p,m},1,30);
        anticov{p,m}=evecoverage(l,anti{1,1}.allt{p,m},anti{1,1}.allk{p,m});
        anticov{p,m}=repelem(anticov{p,m},1,30);
    end
end
%% clip videos 
p=14;
load('dTT_remap_idx.mat')
reader=F{p}{2}.expInfo;
tubev = VideoReader(sprintf('%s_behavCam_concatenated.avi',reader));
keep{1}=unique(F{p}{1, 1}.mapTsM.R2B(logical(evecov{p,1})&~logical(evecov{p,2})));
keep{2}=unique(F{p}{1, 1}.mapTsM.R2B(logical(evecov{p,2})&~logical(evecov{p,1})));
keep{3}=unique(F{p}{1, 1}.mapTsM.R2B(logical(evecov{p,1})&logical(evecov{p,2})));
keep{4}=unique(F{p}{1, 1}.mapTsM.R2B(logical(anticov{p,1})&~logical(anticov{p,2})));
keep{5}=unique(F{p}{1, 1}.mapTsM.R2B(logical(anticov{p,2})&~logical(anticov{p,1})));
keep{6}=unique(F{p}{1, 1}.mapTsM.R2B(logical(anticov{p,1})&logical(anticov{p,2})));
keep{7}=unique(F{p}{1, 1}.mapTsM.R2B(logical(evecov{p,1})&logical(anticov{p,1})));
keep{8}=unique(F{p}{1, 1}.mapTsM.R2B(logical(evecov{p,2})&logical(anticov{p,2})));
names={sprintf('pair%deve1.avi',p),sprintf('pair%deve2.avi',p),sprintf('pair%deve12.avi',p),sprintf('pair%danti1.avi',p),sprintf('pair%danti2.avi',p),sprintf('pair%danti12.avi',p),sprintf('pair%dco1.avi',p),sprintf('pair%dco2.avi',p)};
tubev.CurrentTime=0;
for i=1:length(keep)
eve = VideoWriter(names{i});
open(eve)
CurFrame = 0;
GetFrame =keep{i};
for f=1:length(keep{i})
    CurImage = read(tubev,keep{i}(f));
    writeVideo(eve,CurImage)
end
close(eve)
end
%% take examples
% merge events from the two rounds of detection 
ev_merge=cell(N,nm); % center of all events 
for p=1:N
    for m=1:nm
        ev_merge{p,m}=cell(1,4);
        for k=1:4
            ev_merge{p,m}{k}=combine_2_r(em{1,1}.allt{p,m}{k},find(em{2,1}.timefilter{p,m}),em{2,1}.allt{p,m}{k});
            ev_merge{p,m}{k}=remove_time_ovp(ev_merge{p,m}{k},klist{k}); % remove highly overlapped events
            anti{1,1}.allt{p,m}{k}=remove_time_ovp(anti{1,1}.allt{p,m}{k},klist{k}); % remove highly overlapped antievents
        end
    end
end
%% plot clips
% synchronized event 
p=12;
totalt=size(em{1,1}.ca_cl{p,1},2);
figure(1) % syn events 
et1=ev_merge{p,1};et2=ev_merge{p,2};
maxy=eventplot_singleline(et1,klist,totalt,'position','start');
hold on 
maxy=eventplot_singleline(et2,klist,totalt,'y0',maxy,"col",[0.8500 0.3250 0.0980],'position','start');
% plot top line to be overlap 
ovp=sum(reshape(logical(evecov{p,1})&logical(evecov{p,2}),30,totalt));
plot(find(ovp>0),repelem(maxy+1,1,length(find(ovp>0))),'.k','MarkerSize',12);
% plot onset 
onset = sum(reshape(E{p}{1}.BehaviorVectors(1:30*totalt,4),30,totalt),1); % mark event onset
plot(repmat(find(onset),2,1),repmat([0;maxy],1,length(find(onset))),'--','Color',0.5*[1,1,1])
hold off
xlim([0 totalt]);ylim([0 maxy+1]);yticklabels({});
title(sprintf('pair%dSynEve',p))
%% syn antievents 
figure(2) 
p=15;
totalt=size(em{1,1}.ca_cl{p,1},2);
et1=anti{1,1}.allt{p,1};et2=anti{1,1}.allt{p,2};
maxy=eventplot_singleline(et1,klist,totalt,'position','start');
hold on 
maxy=eventplot_singleline(et2,klist,totalt,'y0',maxy,"col",[0.8500 0.3250 0.0980],'position','start');
% plot top line to be overlap 
ovp=sum(reshape(logical(anticov{p,1})&logical(anticov{p,2}),30,totalt));
plot(find(ovp>0),repelem(maxy+1,1,length(find(ovp>0))),'.k','MarkerSize',12);
% plot onset 
onset = sum(reshape(E{p}{1}.BehaviorVectors(1:30*totalt,4),30,totalt),1); % mark event onset
plot(repmat(find(onset),2,1),repmat([0;maxy],1,length(find(onset))),'--','Color',0.5*[1,1,1])
hold off
xlim([0 totalt]);ylim([0 maxy+1]);yticklabels({});
title(sprintf('pair%dSynAnti',p))
%% co-eve and anti-eve
p=15;m=1;
%eve
figure(3)
totalt=size(em{1,1}.ca_cl{p,1},2);
maxy=eventplot_singleline(ev_merge{p,m},klist,totalt,'position','start');
hold on 
%anti
maxy=eventplot_singleline(anti{1,1}.allt{p,m},klist,totalt,'y0',maxy,"col",[0.8500 0.3250 0.0980],'position','start');
% plot top line to be overlap 
ovp=sum(reshape(logical(evecov{p,m})&logical(anticov{p,m}),30,totalt));
plot(find(ovp>0),repelem(maxy+1,1,length(find(ovp>0))),'.k','MarkerSize',12);
% plot onset 
onset = sum(reshape(E{p}{1}.BehaviorVectors(1:30*totalt,4),30,totalt),1); % mark event onset
plot(repmat(find(onset),2,1),repmat([0;maxy],1,length(find(onset))),'--','Color',0.5*[1,1,1])
hold off
xlim([0 totalt]);ylim([0 maxy+1]);yticklabels({});
title(sprintf('Pair%dMouse%d Event(blue) Anti(Red)',p,m))
