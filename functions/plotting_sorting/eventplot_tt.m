function eventplot_tt(em1,em2,em2filter,antieve,ons,beh,opbeh,options)
% plot event and behaviours on time line for tube test
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
    ons
    beh
    opbeh
    options.event1 (1,1) logical = 1
    options.event2 (1,1) logical = 1
    options.anti (1,1) logical = 1
    options.trial (1,1) logical = 1
    options.logscale (1,1) logical = 0
end


if options.event1
    if options.logscale
        em1=log(em1);
    end
    p1=plot(em1,'--');xlabel('Time(s)');ylabel('log(nEvents)');
    legend(p1,'1st events');
    hold on
end
if options.event2
    if options.logscale
        em2=log(em2);
    end
    p2=plot(find(em2filter),em2,'Color',[0 0.4470 0.7410]); % second round
    legend(p2,'2nd events');
    hold on
end
if options.anti
    if options.logscale
        antieve=log(antieve);
    end
    p3=plot(antieve,'Color',[0.8500 0.3250 0.0980]);
    legend(p3,'anti-events');
    hold on
end
legend('Location',"best",'Orientation',"horizontal")
yl=ylim;
if options.trial
    L=length(ons); s=floor(L/30); % 1s bin
    onsbin = zeros(1,s);
    for t=1:s
        onsbin(t)=sum(ons(30*(t-1)+1:30*t));
    end
    onsbin=logical(onsbin);
    allonset=find(onsbin);
    for i=1:sum(onsbin) % mark trial onsets
        line([allonset(i) allonset(i)],yl,'Color','k','LineStyle','--','HandleVisibility','off')
    end
end
% ---self-behaviour------ %
L=size(beh,1); s=floor(L/30); % 1s bin
sbbin=zeros(s,3);
for t=1:s
    sbbin(t,:)=sum(beh(30*(t-1)+1:30*t,1:3),1);
end
% ---oppo-behaviour------ %
obbin=zeros(s,3);
for t=1:s
    obbin(t,:)=sum(opbeh(30*(t-1)+1:30*t,1:3),1);
end
% ----------------------- %
col={'r','b','g'}; % color for push, approach, retreat
for b = 1:3
    bhonset=find(sbbin(:,b));
    for i=1:length (bhonset)
        line([bhonset(i) bhonset(i)],[0 -yl(2)/5],'Color',col{b},'HandleVisibility','off')
    end
    oponset=find(obbin(:,b));
    for i=1:length (oponset)
        line([oponset(i) oponset(i)],[-yl(2)/5 -2*yl(2)/5],'Color',col{b},'HandleVisibility','off')
    end
end
%set(legend, 'NumColumns' ,2)
line(xlim,[0 0],'Color','k','HandleVisibility','off');line(xlim,[-yl(2)/5 -yl(2)/5],'Color','k','HandleVisibility','off')
ylim([-2*yl(2)/5 yl(2)]); xlim([1 length(em1)])
hold off

end