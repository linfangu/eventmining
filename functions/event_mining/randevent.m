function [randeve]=randevent(cabin,nsh,km,evethre)
% generate events using random shuffled data as control 
% input cabin: 2D matrix cell x time, calcium data ;
% nsh: number of shuffle; evethre: event threshold; km: limit on the
% duration of event 
% output: random events (3D matrix, n x cell x length)
    nc=size(cabin,1);
    randeve=zeros(nsh,nc,km);
for i=1:nsh
    sh=round(size(cabin,2)*rand(1,nc));
    randdata=zeros(size(cabin));
    for c=1:nc
    randdata(c,:)=circshift(cabin(c,:),sh(c));
    end
    [randeve(i,:,:)]=eventmining(randdata,km,evethre);
end