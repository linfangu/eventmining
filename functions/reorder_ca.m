function c=reorder_ca(cells,nc)
% reorder calcium signals according to the cells identified in events 
% input: nc (numeric) number of cells; cells (cell array) list of cells for
% each combination 
% output: c (vector) new sequence of cells 
c=[1:nc]';
for i=1:length(cells)
    c=[cells{i}(:);c];
end
c=unique(c,'stable');c=c(c~=0);
end