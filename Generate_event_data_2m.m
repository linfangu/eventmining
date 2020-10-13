% generate event data with two mice concatenated 
%% open arena - binary 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);
ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca(:,remov{p,m})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca,'type',"binary"); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    ca2{p}=[ca1{1};ca1{2}];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em{1,1}.ncellspermouse=ncellspermouse;
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("em_arena_binary_2m.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("em_arena_antievent_binary_2m.mat",'anti');
% open arena - continuous with max limit 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca(:,remov{p,m})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    ca2{p}=[ca1{1};ca1{2}];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
em{1,1}.ncellspermouse=ncellspermouse;
save("em_arena_2m.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("em_arena_antievent_2m.mat",'anti');
%% tube - binary 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca(:,remov{p,m})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca,'type',"binary"); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    ca2{p}=[ca1{1};ca1{2}];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
em{1,1}.ncellspermouse=ncellspermouse;
save('em_18p_binary_2m.mat','em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05);
save("em_18p_antievent_binary_2m.mat",'anti');
%% tube - continuous with max limit 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca(:,remov{p,m})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    ca2{p}=[ca1{1};ca1{2}];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
em{1,1}.ncellspermouse=ncellspermouse;
save('em_18p_2m.mat','em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05);
save("em_18p_antievent_2m.mat",'anti');