function new_eve_plot_tube(et1,et2,klist,totalt,options)
% plot events in as few lines as possible, plot trail onsets 
% inputs of trial onsets are the original 30Hz vector 
arguments
    et1
    et2
    klist
    totalt
    options.ons 
end
maxy=eventplot_singleline(et1,klist,totalt,'position','center');
hold on 
maxy=eventplot_singleline(et2,klist,totalt,'y0',maxy,"col",[0.8500 0.3250 0.0980],'position','center');
% mark trial onsets 
if isfield(options,'ons')
L=length(options.ons); s=floor(L/30); % 1s bin
onsbin = zeros(1,s);
for t=1:s
    onsbin(t)=sum(options.ons(30*(t-1)+1:30*t));
end
onsbin=logical(onsbin);
allonset=find(onsbin);
for i=1:sum(onsbin) % mark trial onsets
    line([allonset(i) allonset(i)],[0 maxy],'Color','k','LineStyle','--','HandleVisibility','off')
end
end
hold off
xlim([0 totalt]);ylim([0 maxy]);yticklabels({});

