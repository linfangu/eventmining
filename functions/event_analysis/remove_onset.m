function eve=remove_onset(evetime,onset,sec,k)
% remove events that occur within certain time after onset 
% inputs: evetime (num array) event start time 
%          onset (num array) time of onsets 
%          sec (num) time in seconds after onsets where events are removed 
% output: eve (num array) event start time 
eve=evetime;
rmv=[];
for i = 1:length(evetime)
    if any(evetime(i)-onset>-k&evetime(i)-onset<sec)
        rmv=[rmv,i];
    end
end
eve(rmv)=[];