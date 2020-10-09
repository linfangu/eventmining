%% try parameters for binary/continuous, threshold for events 
for p=1:6
    for m=1:2
data=zscore(E{p}{m}.dFFCalciumTraces);
[em{1,1}.eve{p,m},em{1,1}.randeve{p,m},em{1,1}.cabin{p,m}]=binevents(data,0.4,0.9);
[em{1,2}.eve{p,m},em{1,2}.randeve{p,m},em{1,2}.cabin{p,m}]=binevents(data,0.5,0.9);
[em{1,3}.eve{p,m},em{1,3}.randeve{p,m},em{1,3}.cabin{p,m}]=binevents(data,0.6,0.9);
[em{2,1}.eve{p,m},em{2,1}.randeve{p,m},em{2,1}.cabin{p,m}]=conevents(data,0.4);
[em{2,2}.eve{p,m},em{2,2}.randeve{p,m},em{2,2}.cabin{p,m}]=conevents(data,0.5);
[em{2,3}.eve{p,m},em{2,3}.randeve{p,m},em{2,3}.cabin{p,m}]=conevents(data,0.6);
    end
end
em{3,1}="0.4";em{3,2}="0.5";em{3,3}="0.6";em{1,4}="bin";em{2,4}="con";
%% find M, K, time for each parameter setting (0.5% most significant combinations)
alp=0.005;
threshold = [0.4 0.5 0.6];
for bc=1:2
    for th=1:3
        cabin=em{bc,th}.cabin;eve=em{bc,th}.eve;randeve=em{bc,th}.randeve;
        M=cell(6,2);K=cell(6,2);cells=cell(6,2);time=cell(6,2);
        for p=1:6
            for m=1:2
                [p,m]
                nc=size(eve{p,m},1);r=floor(120*nc*alp);
                mc=ceil(size(eve{p,m},1)/3);
                % if no event in random trace set as 0.001
                randeve{p,1}(randeve{p,1}==0)=0.001;randeve{p,2}(randeve{p,2}==0)=0.001;
                rat=eve{p,m}(1:mc,:)./squeeze(mean(randeve{p,m}(:,1:mc,:),1));
                [~, ind] = maxk(rat(:), r);
                [M{p,m},K{p,m}]=ind2sub([mc,120],ind);
                cells{p,m}=cell(1,r);
                time{p,m}=cell(1,r);
                for k = 1:r
                    cells{p,m}{k}=[];time{p,m}{k}=[];
                    cnt=0;
                    for t=1:size(cabin{p,m},2)-K{p,m}(k)
                        cellind=sum(cabin{p,m}(:,t:t+K{p,m}(k)),2)>(K{p,m}(k)+1)*threshold(th);
                        if sum(cellind)>=M{p,m}(k) % at each time t to t+k if more than m neurons 
                            cnt=cnt+1;
                            cells{p,m}{k}(1:sum(cellind),cnt)=find(cellind);
                            time{p,m}{k}=[time{p,m}{k},t];
                        end
                    end
                end
            end
        end
        em{bc,th}.K=K;em{bc,th}.M=M;em{bc,th}.time=time;em{bc,th}.cells=cells;
    end
end
%% plot events 
p=6;
for bc=1:2
    for th=1:3
subplot(2,3,th+3*(bc-1))
cabin=em{bc,th}.cabin;eve=em{bc,th}.eve;randeve=em{bc,th}.randeve;
mc1=ceil(size(eve{p,1},1)/3);mc2=ceil(size(eve{p,2},1)/3);
d=[eve{p,1}(1:mc1,:);eve{p,2}(1:mc2,:)];
imagesc(d);yticks([0:20:mc1,mc1+20:20:mc1+mc2]);yticklabels([0:20:mc1,20:20:mc2]);
xlabel('Duration (k)');ylabel('Number of Cells (m)');title(sprintf('threshold %s',em{3,th}));
    end
end
%% plot ratio 
p=6;blk=3;
for bc=1:2
    for th=1:3
        subplot(2,3,th+3*(bc-1))
cabin=em{bc,th}.cabin;eve=em{bc,th}.eve;randeve=em{bc,th}.randeve;
mc1=ceil(size(eve{p,1},1)/3);mc2=ceil(size(eve{p,2},1)/3);
randeve{p,1}(randeve{p,1}==0)=0.001;randeve{p,2}(randeve{p,2}==0)=0.001;
rat1=eve{p,1}(1:mc1,:)./squeeze(mean(randeve{p,1}(:,1:mc1,:),1));rat2=eve{p,2}(1:mc2,:)./squeeze(mean(randeve{p,2}(:,1:mc2,:),1));
rat=[rat1;NaN(blk,120);rat2];
imagesc(rat,'AlphaData',~isnan(rat));set(gca,'color',[1 1 1]);xlabel('Duration (k)');ylabel('Number of Cells (m)')
title(sprintf('threshold %s',em{3,th}));yticks([0:20:mc1,mc1+20+blk:20:mc1+mc2+blk]);yticklabels([0:20:mc1,20:20:mc2]);colorbar;
    end
end
%% plot events with time
p=6;
for bc=1:2
    for th=1:3
        K=em{bc,th}.K;time=em{bc,th}.time;
for m = 1:2
    L=size(E{p}{m}.dFFCalciumTraces,1);
s=floor(L/30);
    eserie{m}=[];
    for r=1:length(time{p,m})
        for e=1:length(time{p,m}{r})
            ful=zeros(1,s);
            ful(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))=1;
            eserie{m}=[eserie{m};ful];
        end
        if size(eserie{m},1)>500
            break
        end
    end
end
 subplot(2,3,th+3*(bc-1))
 l1=min(size(eserie{1},1),500);l2=min(size(eserie{2},1),500);
 esecom=[eserie{1}(1:l1,:);NaN(20,size(eserie{1},2));eserie{2}(1:l2,:)];
    imagesc(esecom,'AlphaData',~isnan(esecom));xlabel('Time(s)');ylabel('Events');
    yticks([20:80:l1,l1+40:80:l1+l2+20]);yticklabels([20:80:l1,20:80:l2]);
title(sprintf('threshold %s',em{3,th}));
    end
end
%% frequency at each time 
p=6;
for bc=1:2
    for th=1:3
        K=em{bc,th}.K;time=em{bc,th}.time;
for m = 1:2
    L=size(E{p}{m}.dFFCalciumTraces,1);
    s=floor(L/30);
    eserie{m}=zeros(1,s);
    for r=1:length(time{p,m})
        for e=1:length(time{p,m}{r})
            eserie{m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))=eserie{m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))+1;
        end
    end
end
   subplot(2,3,th+3*(bc-1))
   d=[eserie{1};eserie{2}];
    plot(d');xlabel('Time(s)');ylabel('nEvents');legend({'Mouse1','Mouse2'})
title(sprintf('threshold %s',em{3,th}));
end
end
%% remove >50% overlapping events 
for bc=1:2
    for th=1:3
        K=em{bc,th}.K;time=em{bc,th}.time;
for m = 1:2
    L=size(E{p}{m}.dFFCalciumTraces,1);
    s=floor(L/30);
    eserie{m}=zeros(1,s);
    for r=1:length(time{p,m})
        for e=1:length(time{p,m}{r})
            ful=zeros(1,s);
            ful(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))=1;
            if all(sum(eserie{m}==1&repmat(ful,size(eserie{m},1),1)==1,2)<=sum(eserie{m},2)./2)
            eserie{m}=[eserie{m};ful];
            end
        end
    end
    eserie{m}=eserie{m}(2:end,:);
end
figure(1)
subplot(2,3,th+3*(bc-1))
 l1=min(size(eserie{1},1),100);l2=min(size(eserie{2},1),100);
 bin=floor(l1/2);
 esecom=[eserie{1}(1:l1,:);NaN(2,size(eserie{1},2));eserie{2}(1:l2,:)];
    imagesc(esecom,'AlphaData',~isnan(esecom));xlabel('Time(s)');ylabel('Events');
    yticks([bin:bin:l1,l1+2+bin:bin:l1+l2+2]);yticklabels([bin:bin:l1,bin:bin:l2]);
title(sprintf('threshold %s',em{3,th}));
figure(2)
   subplot(2,3,th+3*(bc-1))
   d=[sum(eserie{1});sum(eserie{2})];
    plot(d');xlabel('Time(s)');ylabel('nEvents');legend({'Mouse1','Mouse2'})
title(sprintf('threshold %s',em{3,th}));
     end
end
%% plot reordered calcium signals
p=6;
c=cell(1,2);
for bc=1:2
for th=1:3
    cabin=em{bc,th}.cabin;cells=em{bc,th}.cells;
for m=1:2
    nc=size(eve{p,m},1);
c{m}=[1:nc]';
for i=1:length(cells{p,m})
    c{m}=[cells{p,m}{i}(:);c{m}];
end
c{m}=unique(c{m},'stable');c{m}=c{m}(c{m}~=0);
end
 subplot(2,3,th+3*(bc-1))
 d=[cabin{p,1}(c{1},:);NaN(2,size(cabin{p,m},2));cabin{p,2}(c{2},:)];
imagesc(d,'AlphaData',~isnan(d));xlabel('Time(s)');ylabel('Cell');
nc1=size(cabin{p,1},1);nc2=size(cabin{p,2},1);bin=40;
yticks([bin:bin:nc1,nc1+2+bin:bin:nc1+nc2+2]);yticklabels([bin:bin:nc1,bin:bin:nc2]);
title(sprintf('threshold %s',em{3,th}));
end
end

%%
