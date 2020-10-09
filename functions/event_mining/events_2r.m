function em=events_2r(ca_cl,ne_1,options)
% second round event mining for multiple animals 
% inputs: ca_cl = (cell array each containing 2D matrix cell x time)calcium signal, ne_1 = (cell array each containing number of events at each time point)event from first round
% options: "type" select from "eve" or "anti" 
% "thre" = (numeric) threshold for event mining (default is 0.5)
% output: 
% em: cell array,results kept at {1,1} structure with time filter (used to remove 1round event, events), randomized events, selected events with
% K,M,cells,time,ne(number of events at each time in the new time line) 
arguments 
    ca_cl
    ne_1
    options.type (1,1) string = "eve"
    options.thre (1,1) {mustBeNumeric} = 0.5
end
type=options.type;thre=options.thre;
em=cell(1,1);[N,nm]=size(ca_cl);
eve=cell(N,nm);randeve=cell(N,nm);
no_eve=cell(N,nm);ca_2=cell(N,nm);
parfor p=1:N
    for m=1:nm
        no_eve{p,m} = rem_eve_time(ne_1{p,m},5);% merge events with less than 5s interval
        ca_2{p,m}=ca_cl{p,m}(:,no_eve{p,m}); % remove time of the events
        if type=="eve"
        [eve{p,m}]=eventmining(ca_2{p,m},120,thre); % re-run the events
        % 100 random shuffles
        [randeve{p,m}]=randevent(ca_2{p,m},100,120,thre);
        elseif type=="anti"
        [eve{p,m}]=antieventmining(ca_2{p,m},120,thre); % re-run the events
        % 100 random shuffles
        [randeve{p,m}]=randantievent(ca_2{p,m},100,120,thre);
        end
    end
end
em{1,1}.eve=eve;em{1,1}.randeve=randeve;em{1,1}.timefilter=no_eve;

% Find Most Significant Combinations 
alp=0.01; % the percentage of mk conbinations to include
[em{1,1}.K,em{1,1}.M,em{1,1}.time,em{1,1}.cells,em{1,1}.pvl]=findmk(eve,randeve,alp,ca_2,thre,type);

% count number of Events at each time point 
time=em{1,1}.time;K=em{1,1}.K;
ne=cell(N,nm);
for p=1:N
    for m = 1:nm
        s=sum(em{1,1}.timefilter{p,m});
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
