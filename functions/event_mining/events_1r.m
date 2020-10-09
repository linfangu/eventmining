function em=events_1r(ca_cl,options)
% first round event mining for multiple animals 
% inputs: ca_cl = (cell array each containing 2D matrix cell x time)calcium signal,
% options: "type" select from "eve" or "anti" 
% "thre" = (numeric)threshold for event mining (default is 0.5)
% output: 
% em: cell array, data kept at {1,1} - structure with events, randomized events, selected events with
% K,M,cells,time,ne(number of events at each time) 
arguments 
    ca_cl
    options.type (1,1) string = "eve"
    options.thre (1,1) {mustBeNumeric} = 0.5
end
type=options.type;thre=options.thre;
em=cell(1,1);[N,nm]=size(ca_cl);
eve=cell(N,nm);randeve=cell(N,nm);
parfor p=1:N
    for m=1:nm
        if type=="eve"
        [eve{p,m}]=eventmining(ca_cl{p,m},120,thre);
        % 100 random shuffles
        [randeve{p,m}]=randevent(ca_cl{p,m},100,120,thre);
        elseif type=="anti"
        [eve{p,m}]=antieventmining(ca_cl{p,m},120,thre); 
        % 100 random shuffles
        [randeve{p,m}]=randantievent(ca_cl{p,m},100,120,thre);
        end
    end
end
em{1,1}.eve=eve;em{1,1}.randeve=randeve;
em{1,1}.ca_cl=ca_cl;
% Find Most Significant Combinations 
alp=0.01; % the percentage of mk conbinations to include
[em{1,1}.K,em{1,1}.M,em{1,1}.time,em{1,1}.cells,em{1,1}.pvl]=findmk(eve,randeve,alp,ca_cl,thre,type);

% count number of Events at each time point 
time=em{1,1}.time;K=em{1,1}.K;
ne=cell(N,nm);
for p=1:N
    for m = 1:nm
        s=size(ca_cl{p,m},2);
        ne{p,m}=zeros(1,s);
        for r=1:length(time{p,m})% combi index
            for e=1:length(time{p,m}{r}) % events for this combi
                ne{p,m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))=ne{p,m}(time{p,m}{r}(e):time{p,m}{r}(e)+K{p,m}(r))+1;
                % for each event add one
            end
        end
    end
end
em{1,1}.ne=ne;
