function [eserie,mergedc]=overlapmerge(time,K,cells,threshold,s)
% merge events that overlap in time with defined threshold

% inputs: time = (cell arary) time that each event occur; K = (cell arary)length of event (t to
% t+k);cells = (cell arary)cells that contribute to events; threshold = the percentage
% of overlap required for a new event to merge into old event, s = total
% time in seconds of the session

% outputs: eserie: 2Dmarix event x time ; mergedc: cells in the events
[~,ind]=sort(K); % take longest events first
eserie=zeros(1,s); cnt=0;
for r=ind'
    for e=1:length(time{r}) % event index
        ful=zeros(1,s);
        ful(time{r}(e):time{r}(e)+K(r))=1; % current event
        if all(sum(eserie==1&repmat(ful,size(eserie,1),1)==1,2)<=K(r)*threshold)
            eserie=[eserie;ful]; % if no overlap create new event
            cnt=cnt+1;
            mergedc{cnt}=cells{r}(:,e)';
        else  % if overlap update overlapping event
            ol=sum(eserie==1&repmat(ful,size(eserie,1),1)==1,2)>K(r)*threshold;
            eserie(ol,time{r}(e):time{r}(e)+K(r))=1;
            mergedc{find(ol,1)-1}=unique([mergedc{find(ol,1)-1},cells{r}(:,e)']);
        end
    end
end
eserie=eserie(2:end,:);% remove the first empty event
for i=1:length(mergedc) % remove 0 cell index 
    mergedc{i}(mergedc{i}==0)=[];
end