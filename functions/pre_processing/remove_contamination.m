function [E,remov]=remove_contamination(E,dis_th)
% remove highly correlated close-by cells
% inputs: E: signal in the original Hong lab format, dis_th: (numeric)threshold of distance within which to be considered
% contamination 
% output: remov, cell array containing list of cells that need to be removed for
% each animal 
N=length(E);
for p=1:N
    for m=1:2 % pair and mouse index
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        roi=E{p}{m}.ROIs;
        [~,nc]=size(ca);
        cormat=corrcoef(ca);distmat=pdist(roi);
        cormat(1:length(cormat)+1:end)=0;
        cormat_v=squareform(cormat); % correlation matrix in the vector form
        th(p,m) = cor_threshold(cormat_v,distmat); % obtain threshold for correlation map
        cormat(cormat<=th(p,m))=0;cormat(squareform(distmat)>dis_th)=0; % remove smaller than threshold and big distance
        [remov{p,m}]=greedy_remove(cormat,0);
        E{p}{m}.dFFCalciumTraces(:,remov{p,m})=[];
        % how many cells were removed?
        sprintf('Pair%d,Mouse%d,%d(%.2g%%) cells removed',p,m,length(remov{p,m}),100*length(remov{p,m})/nc)
    end
end