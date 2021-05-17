function new_eve_plot_arena(et1,et2,klist,totalt)
% plot events in as few lines as possible 
maxy=eventplot_singleline(et1,klist,totalt,'position','center');
hold on 
maxy=eventplot_singleline(et2,klist,totalt,'y0',maxy,"col",[0.8500 0.3250 0.0980],'position','center');
hold off
xlim([0 totalt]);ylim([0 maxy]);yticklabels({});

