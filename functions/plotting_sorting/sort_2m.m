function [ca_con,ind]=sort_2m(ca1,ca2)
% sort cells from two mice together
% input: 2D matrix cell x time of two mice
% output: ca_con 2D matrix,concatenated data with last 30 rows represeting
% mouse index (0 is ca1, 1 is ca2)
% ind: (array) index of sorting 
    ca_con=[ca1;ca2];
    ops.iPC=1:30;
    [ind,~,~]=mapTmap(ca_con,ops);
    ca_con(:,end+1:end+30)=1;ca_con(1:size(ca1,1),end-29:end)=0;
    ca_con=ca_con(ind,:);
end