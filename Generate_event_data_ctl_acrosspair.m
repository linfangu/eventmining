%% shuffle mice index
% only shuffle the second animal means that relatively keep one dominate
% and one subordinate 
tt=18+randperm(18);% random sequence from 18-36
tt=[(1:18)',tt'];
while any((tt(:,2)-tt(:,1))==18) % make sure no real pair come together 
    tt=18+randperm(18);tt=[(1:18)',tt'];
end
ar=10+randperm(10);ar=[(1:10)',ar'];
while any((ar(:,2)-ar(:,1))==10)
    ar=10+randperm(10);ar=[(1:10)',ar'];
end
%% open arena - binary 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        [p0,m0]=ind2sub([N,2],ar(p,m)); % get real signal mouse index
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca,'type',"binary"); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    l=min(size(ca1{1},2),size(ca1{2},2));
    ca2{p}=[ca1{1}(:,1:l);ca1{2}(:,1:l)];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em{1,1}.ncellspermouse=ncellspermouse;
em{1,1}.randseq=ar;
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("ctl_arena_binary_2m.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("ctl_arena_antievent_binary_2m.mat",'anti');
%% open arena - continuous with max limit 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        [p0,m0]=ind2sub([N,2],ar(p,m)); % get real signal mouse index
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    l=min(size(ca1{1},2),size(ca1{2},2));
    ca2{p}=[ca1{1}(:,1:l);ca1{2}(:,1:l)];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em{1,1}.ncellspermouse=ncellspermouse;
em{1,1}.randseq=ar;
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("ctl_arena_2m.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("ctl_arena_antievent_2m.mat",'anti');
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
        [p0,m0]=ind2sub([N,2],tt(p,m)); % get real signal mouse index
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca,'type',"binary"); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    l=min(size(ca1{1},2),size(ca1{2},2));
    ca2{p}=[ca1{1}(:,1:l);ca1{2}(:,1:l)];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em{1,1}.ncellspermouse=ncellspermouse;
em{1,1}.randseq=tt;
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("ctl_tube_binary_2m.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("ctl_tube_antievent_binary_2m.mat",'anti');
% tube - continuous with max limit 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
remov=remove_contamination(E,dis_th);
ca2=cell(N,1);ncellspermouse=zeros(N,2);
for p =1:N
    ca1=cell(1,2);
    for m =1:2
        [p0,m0]=ind2sub([N,2],tt(p,m)); % get real signal mouse index
        ca=zscore(E{p0}{m0}.dFFCalciumTraces);
        ca(:,remov{p0,m0})=[]; % remove contamination
        ca1{1,m}=normalizeca(ca); % set binary at 90%
        ncellspermouse(p,m)=size(ca1{m},1);
    end
    l=min(size(ca1{1},2),size(ca1{2},2));
    ca2{p}=[ca1{1}(:,1:l);ca1{2}(:,1:l)];
end
% ------------- events ---------------------
em=events_1r(ca2); % 1st round events at 0.5 threshold
em{1,1}.ncellspermouse=ncellspermouse;
em{1,1}.randseq=tt;
em2=events_2r(ca2,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("ctl_tube_2m.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca2,"type","anti","thre",0.05); % 1st round events at 0.5 threshold
save("ctl_tube_antievent_2m.mat",'anti');