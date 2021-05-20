function arena_beh_plot(E)
sbename=E{1}.BehaviorNames;opbename=E{2}.BehaviorNames;
        beh=E{1}.BehaviorVectors; % self behaviour 
        opbeh=E{2}.BehaviorVectors; % opponent behaviours 
social=["approach","sniffing",'socialgrooming','mount','chase','attack','defend','escape']; % index for all social behaviours 
% ---self-behaviour------ %
[~,ID]=intersect(sbename,social); % find overlap with social behaviour
[L,nb]=size(beh); s=floor(L/30); % 1s bin
sbbin=zeros(s,2);
for t=1:s
    sbbin(t,1)=any(beh(30*(t-1)+1:30*t,ID'),'all');
    sbbin(t,2)=any(beh(30*(t-1)+1:30*t,setdiff(1:nb,ID)),'all');
end
% ---oppo-behaviour------ %
obbin=zeros(s,2);
[~,ID]=intersect(opbename,social);
for t=1:s
    [~,nb]=size(opbeh);
    obbin(t,1)=any(opbeh(30*(t-1)+1:30*t,ID'),'all');
    obbin(t,2)=any(opbeh(30*(t-1)+1:30*t,setdiff(1:nb,ID)),'all');
end
col={'r','b'}; % color for social and non-social behaviour
for b = [2 1]
    bhonset=find(sbbin(:,b));
    for i=1:length(bhonset)
        line([bhonset(i) bhonset(i)],[0 1],'Color',col{b})
    end
    oponset=find(obbin(:,b));
    for i=1:length(oponset)
        line([oponset(i) oponset(i)],[1 2],'Color',col{b})
    end
end
xlim([1 s])