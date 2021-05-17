function [K,M,time,cells,pvl]=findmk(eve,randeve,alp,ca_cl,thre,type)
% Find K,M,start time, cells and p values for each significant combination
% inputs: (cell array containing 2D matrix m x k)event, (cell array containing 3D matrix 100 x m x k)random event control, alp(the percentage of mk conbinations to include)
% ca_cl: (2D matrix cell x time)calcium signal; thre: threshold of event mining
% type:  (string)select from "eve" event or "anti" anti-event 
% outputs: K/M: (cell array)each cell contain list of significant m/k for
% each animal 
% cells: cell array containing cell arrays keeping cell index for each
% m&k combinations
% time: cell array containing cell arrays keeping time of event start time
% for each m&k combinations
% pvl: cell array with each cell containing array of p value of each m/k
% combinations
[N,nm]=size(eve);
M=cell(N,nm);K=cell(N,nm);cells=cell(N,nm);time=cell(N,nm);pvl=cell(N,nm);
for p=1:N
    for m=1:nm
        nc=size(eve{p,m},1);r=floor(120*nc*alp); % number of combination to take
        randeve{p,m}(randeve{p,m}==0)=0.001; % if no event in random trace set as 0.001
        rat=eve{p,m}./squeeze(mean(randeve{p,m},1));
        [~, ind] = maxk(rat(:), r);
        [M{p,m},K{p,m}]=ind2sub([nc,120],ind);
        cells{p,m}=cell(1,r);time{p,m}=cell(1,r);pvl{p,m}=[];
        for k = 1:r % combinations
            % check p value
            pvl{p,m}(k)=sum(randeve{p,m}(:,M{p,m}(k),K{p,m}(k))>eve{p,m}(M{p,m}(k),K{p,m}(k)))/100;
            if pvl{p,m}(k)>0.05 % skip combi if not significant
                % sprintf('p%dm%dcombination%d,p=%.2f',p,m,k,pvl{p,m}(k))
                continue
            end
            if type =="eve"
                [cells{p,m}{k},time{p,m}{k}]=mkeve(M{p,m}(k),K{p,m}(k),ca_cl{p,m},thre);
            elseif type =="anti"
                [cells{p,m}{k},time{p,m}{k}]=mkantieve(M{p,m}(k),K{p,m}(k),ca_cl{p,m},thre);
            end
        end
    end
end