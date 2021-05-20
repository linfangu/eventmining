function eventplot_arena(em1,em2,em2filter,antieve,beh,sbename,opbeh,opbename,options)
% plot event and behaviours on time line 
% inputs: em1/2/antieve - (col array) number of event at time line for 1st
% round, 2nd round, antievents respectively; em2filter - filter applied
% from original time line to 2nd round event detection
% ons - vector of trial onset; beh - 3 vectors of behaviors
% options - (logical) whether to show first round events (event1); second round
% event (event2); anti events (anti); trial onset (trial); logscale:
% transform No events to log scale
arguments
    em1
    em2
    em2filter
    antieve
    beh
    sbename
    opbeh
    opbename
    options.logscale (1,1) logical = 0
end
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
% ----------------------- %
if options.logscale
    em1=log(em1);
end
plot(em1','--');xlabel('Time(s)');ylabel('log(nEvents)');
hold on
if options.logscale
    em2=log(em2);
end
plot(find(em2filter),em2','Color',[0 0.4470 0.7410]); % second round
if options.logscale
    antieve=log(antieve);
end
plot(antieve','Color',[0.8500 0.3250 0.0980]);yl=ylim;
col={'r','b'}; % color for social and non-social behaviour
for b = [2 1]
    bhonset=find(sbbin(:,b));
    for i=1:length(bhonset)
        line([bhonset(i) bhonset(i)],[0 -yl(2)/5],'Color',col{b})
    end
    oponset=find(obbin(:,b));
    for i=1:length(oponset)
        line([oponset(i) oponset(i)],[-yl(2)/5 -2*yl(2)/5],'Color',col{b})
    end
end
legend({'1st round','2nd round','Anti'},'Location',"best",'Orientation',"horizontal")
ylim([-2*yl(2)/5 yl(2)]); xlim([1 length(em1)])
line(xlim,[0 0],'Color','k','HandleVisibility','off');line(xlim,[-yl(2)/5 -yl(2)/5],'Color','k','HandleVisibility','off')
hold off
end