function no_eve = rem_eve_time(eve,min_int)
% remove times where events occured to allow second round of event
% detection
% input: event time, miminum interval between two events
% output: no_eve (logical) time when no event occured 
has_eve=eve~=0;
dif=diff([0 has_eve]);
onset=find(dif==1);offset=find(dif==-1);
keep=(onset(2:end)-offset(1:length(onset)-1))>min_int; % merge if two event groups are less than 5 seconds apart
onset(find(keep==0)+1)=[];offset(find(keep==0))=[];
dif_m=zeros(size(dif));dif_m(onset)=1;dif_m(offset)=-1;
eveind=cumsum(dif_m);%index of event time
no_eve=~eveind;