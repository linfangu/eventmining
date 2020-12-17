function [rs]=constitutional_eventplot_arena(em,klist,ev_merge,distwithin,distbetween,p)
% 9 plots combination for raster, events and event distance
% outputs: rs (num array) p values for each k tested
rs=NaN(3,1,2);
% first raster 
subplot(3,4,[1 2])
S0=em{1,1}.ca_cl{p,2};
ops.iPC=1:35;
[isort1, ~, ~] = mapTmap(S0, ops);
imagesc(S0(isort1,:))
% event
subplot(3,4,[5 6])
totalt=size(em{1,1}.ca_cl{p,1},2);
et1=ev_merge{p,1};et2=ev_merge{p,2};
maxy=eventplot_singleline(et1,klist,totalt,'position','center');
hold on 
maxy=eventplot_singleline(et2,klist,totalt,'y0',maxy,"col",[0.8500 0.3250 0.0980],'position','center');
hold off
xlim([0 totalt]);ylim([0 maxy]);yticklabels({});
title(sprintf('pair%d',p))
% second raster
subplot(3,4,[9 10])
S0=em{1,1}.ca_cl{p,1};
[isort1, ~, ~] = mapTmap(S0, ops);
imagesc(S0(isort1,:))
pind{1}=[11,12,8];pind{2}=[3,4,7]; % subplot index for hist
for k=1:3
    for m=1:2
        subplot(3,4,pind{m}(k))
        if isempty(distwithin{p,m}{k}(:))
            continue
        end
        ecdf(distbetween{p,m}{k}(:));
        hold on
        ecdf(distwithin{p,m}{k}(:));
        legend({'Between','Within'})
        rs(k,1,m)=ranksum(distbetween{p,m}{k}(:),distwithin{p,m}{k}(:),'tail',"right");
        title(sprintf('M%d,K=%d,p=%.2g',m,klist{k},rs(k,1,m)))
    end
end