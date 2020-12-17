function em=rem_onset_em(em,E)
% remove events that span through trial onsets 
[N,nm]=size(em{1,1}.ca_cl);
for p=1:N
    for m=1:nm
        onset = sum(reshape(E{p}{1}.BehaviorVectors(1:30*size(em{1,1}.ca_cl{p,1},2),4),30,size(em{1,1}.ca_cl{p,1},2)),1);
        [em{1,1}.time{p,m},em{1,1}.cells{p,m}]=remove_span_onset(em{1,1}.K{p,m},em{1,1}.time{p,m},em{1,1}.cells{p,m},onset);
        if size(em,1)==2
        [em{2,1}.time{p,m},em{2,1}.cells{p,m}]=remove_span_onset(em{2,1}.K{p,m},em{2,1}.time{p,m},em{2,1}.cells{p,m},onset,'aligned',0,'timefilter',em{2,1}.timefilter{p,m});
        end
    end
end