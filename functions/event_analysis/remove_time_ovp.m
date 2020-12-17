function [ets_1]=remove_time_ovp(ets,k)
% remove events with >50% overlap with existing events 
% input: ets (num array) event times (start or center); k (num) event length 
thre=k/2;
ets_1=[];
for i=1:length(ets)
if ~any(abs(ets(i)-ets_1)<thre)
    ets_1=[ets_1, ets(i)];
end
end