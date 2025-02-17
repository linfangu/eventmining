function em=rem_dup_em(em,options)
% remove duplicated events by keeping only events with largest M 
% when k and start time are same 
% inputs: em (cell array) events in the format generated by events function
% options.nround: (num.) number of event detection rounds default is 2
arguments
em
options.nround (1,1) {mustBeNumeric} = 2
end
time=em{1,1}.time;K=em{1,1}.K;M=em{1,1}.M;
[N,nm]=size(K);
ne=cell(N,nm);
for p=1:N
    for m = 1:nm
        % --- remove duplicate events of smaller m ---- 
        [time{p,m}]=remove_dup_event(K{p,m},M{p,m},time{p,m});
        % --- count events at each time --- 
        s=size(em{1,1}.ca_cl{p,m},2);
        ne{p,m}=zeros(1,s);
        for r=1:length(time{p,m})% combi index
            for e=1:length(time{p,m}{r}) % events for this combi
                ne{p,m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))=ne{p,m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))+1;
                % for each event add one
            end
        end
    end
end
em{1,1}.ne=ne;em{1,1}.time=time;
if options.nround==2
time=em{2,1}.time;K=em{2,1}.K;M=em{2,1}.M;
[N,nm]=size(K);
ne=cell(N,nm);
for p=1:size(K,1)
    for m = 1:nm
        % --- remove duplicate events of smaller m ---- 
        [time{p,m}]=remove_dup_event(K{p,m},M{p,m},time{p,m});
        % --- count events at each time --- 
        s=sum(em{2,1}.timefilter{p,m});
        ne{p,m}=zeros(1,s);
        for r=1:length(time{p,m})% combi index
            for e=1:length(time{p,m}{r}) % events for this combi
                ne{p,m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))=ne{p,m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))+1;
                % for each event add one
            end
        end
    end
end
em{2,1}.ne=ne;em{2,1}.time=time;
end