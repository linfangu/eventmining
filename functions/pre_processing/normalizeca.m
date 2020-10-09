function cabin=normalizeca(ca,options)
% pre-processing of calcium signal including bin 30 frames / 1s and
% transformation and normalization
% input: ca = frame x cell 2D matrix; optional inputs:
% 'type' select from
%   -"normlimit" (default) = first set maximum at 95th percentile and normalize to 0,1
%   -"continuous" = normalize to [0 1]
%   -"binary" = set 1 above 90th percentile, 0 otherwise
% 'bin' the number of frames in time bin: 1 = no bin; 30 (default) = 1s
arguments
    ca double
    options.type (1,1) string = "normlimit"
    options.bin (1,1) {mustBeNumeric} = 30
end
bin = options.bin;
[L,nc]=size(ca); s=floor(L/bin); cabin=zeros(s,nc);
for t=1:s
    cabin(t,:)=sum(ca(bin*(t-1)+1:bin*t,:),1);
end
if options.type=="normlimit"
    % set maximun at the 95% percentile
    bny=prctile(cabin,95);
    for i=1:size(cabin,2)
        cabin(cabin(:,i)>bny(i),i)=bny(i);
    end
    % normalize to 0-1
    cabin=(cabin-min(cabin))./(max(cabin)-min(cabin));
    cabin=cabin'; % cell x length
elseif options.type=="continuous"
    cabin=(cabin-min(cabin))./(max(cabin)-min(cabin));
    cabin = cabin';
elseif options.type=="binary"
    bny=prctile(cabin,90);
    cabin=(cabin>=bny);
    cabin=cabin';
end