function [eve]=eventmining(cabin,km,thre)
% input cabin:(2D matrix, cell x time) calcium data; km: (numaric)limit for k length; thre: (numaric)threshold for which a cell
% is counted into an event 
% output: number of event for each m and k combi (2D matrix, ncell x length)
[nc,L]=size(cabin);
eve=zeros(nc,km); % number of events for each [m,k] combination 
cs=cumsum(cabin,2);thremat=repmat(thre*(1:km),nc,1);
    for t=1:L-km
        % find all cells that are active for the period 
        cellind=cs(:,1:km)>thremat; 
        allk=sum(cellind)-1;
        for k = find(allk)
        eve(1:allk(k),k)=eve(1:allk(k),k)+1;
        end
        cs=cs(:,2:end)-cs(:,1);
    end
end
