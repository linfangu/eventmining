%% shuffle mice index
tt=randperm(36);tt=reshape(tt,18,2);
while any(abs(tt(:,1)-tt(:,2))==18) % make sure no real pair come together 
    tt=randperm(36);tt=reshape(tt,18,2);
end
ar=randperm(20);ar=reshape(ar,10,2);
while any(abs(ar(:,1)-ar(:,2))==10)
    ar=randperm(20);tt=reshape(ar,10,2);
end
%% open arena - binary 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        [p0,m0]=ind2sub([N,2],ar(p,m)); % get real signal mouse index
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca_cl{p,m}=normalizeca(ca,'type',"binary"); % set binary at 90%
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("ctl_em_arena_binary_th0.5.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("ctl_em_arena_antievent_binary_0.05.mat",'anti');
%% open arena - continuous with max limit 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        [p0,m0]=ind2sub([N,2],ar(p,m));
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca_cl{p,m}=normalizeca(ca); 
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("ctl_em_arena_th0.5.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("ctl_em_arena_antievent_0.05.mat",'anti');
%% tube - binary 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        [p0,m0]=ind2sub([N,2],tt(p,m));
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca_cl{p,m}=normalizeca(ca,'type','binary'); 
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save('ctl_em_18p_binary_th0.5.mat','em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05);
save("ctl_em_18p_antievent_binary_0.05.mat",'anti');
%% tube - continuous with max limit 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        [p0,m0]=ind2sub([N,2],tt(p,m));
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca_cl{p,m}=normalizeca(ca); 
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save('ctl_em_18p_th0.5.mat','em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05);
save("ctl_em_18p_antievent_0.05.mat",'anti');