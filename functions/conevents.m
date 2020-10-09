function [eve,randeve,cabin]=conevents(data,evethre)
% continuous event mining including data pre-processing (OLD FUNCTION NO USE)
% inputs: data(2D matrix frame x cell), evethre(numaric) event threshold
% outputs:
% eve = (2D) m x k; randeve (2D) 100 x m x k; cabin (2D) cell x time,
% pre-processed calcium signal 
ca=data';
% 1-second time bins.
[nc,L]=size(ca); s=floor(L/30); cabin=zeros(nc,s);
for t=1:s
    cabin(:,t)=sum(ca(:,30*(t-1)+1:30*t),2);
end
% normalize to 0-1
cabin=(cabin-min(cabin,[],2))./(max(cabin,[],2)-min(cabin,[],2));
%% find events 
% If in columns t, t+1, t+2, ...,t+k of R we have m neurons such that each one is active
% in more than (k+1)/2 of the columns, we call it an [m, k]-event (at time point t).
[eve]=eventmining(cabin,120,evethre);
%% generate 100 shuffles 
randeve=zeros(100,nc,120);
for i=1:100 
    sh=round(size(cabin,2)*rand(1,nc));
    randdata=zeros(size(cabin));
    for c=1:nc
    randdata(c,:)=circshift(cabin(c,:),sh(c));
    end
    [randeve(i,:,:)]=eventmining(randdata,120,evethre);
end
end
