function [remov]=remove_contamination_single(ca,distmat,dis_th)
% remove highly correlated close-by cells for single mouse data
% inputs: ca: (2D mat)]time x cell matrix of calcium signal, dis_th: (numeric)threshold of distance within which to be considered
% contamination 
% output: remov, cell array containing list of cells that need to be removed for
% each animal 
        cormat=corrcoef(ca);
        cormat(1:length(cormat)+1:end)=0;
        cormat_v=squareform(cormat); % correlation matrix in the vector form
        th = cor_threshold(cormat_v,distmat); % obtain threshold for correlation map
        cormat(cormat<=th)=0;cormat(squareform(distmat)>dis_th)=0; % remove smaller than threshold and big distance
        [remov]=greedy_remove(cormat,0);
        % how many cells were removed?
        sprintf('%d(%.2g%%) cells removed',length(remov),100*length(remov)/size(ca,2))
end