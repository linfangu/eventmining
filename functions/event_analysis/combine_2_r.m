function ev_merge=combine_2_r(allt,tf,allt2,options)
% conbine events from 2 selections 
% input allt, allt2 (num array)
% tf (array of time point for second round)
% options - merge as middle or start of the event 
arguments 
    allt
    tf
    allt2
    options.position (1,1) string = 'start'
    options.k
end
if options.position == 'center'
    k=options.k;
    ev_merge=allt+k/2;
ev_merge=[ev_merge,tf(allt2)+k/2];
else 
ev_merge=allt;
ev_merge=[ev_merge,tf(allt2)];
end