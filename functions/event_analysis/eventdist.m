function dist=eventdist(ev1,ev2)
% calculate the distance between each event in ev1 and the closest event in
% ev2 
% input: ev1 (num. array) event time of first animal;ev2 (num. array) event time of second animal
% output: dist (num. array) distance array 
 dist=[];
for e=1:length(ev1)
 dist=[dist,min(abs(ev1(e)-ev2))];
end
end