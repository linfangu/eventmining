%% open arena - binary 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
[E,~]=remove_contamination(E,dis_th); % remove contamination
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca_cl{p,m}=normalizeca(ca,'type',"binary"); % set binary at 90%
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold, at time that does not have event in the first round
em{2,1}=em2{1,1};
save("em_arena_binary_th0.5.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05); % 1st round antievents at 0.05 threshold
save("em_arena_antievent_binary_0.05.mat",'anti');
%% open arena - continuous with max limit 
% Remove contamination and transform data 
load('HC_SYN_10Psocial_R1_030119_UPD.mat');
N=10;
dis_th=40;
[E,~]=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca_cl{p,m}=normalizeca(ca); 
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save("em_arena_th0.5.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05); 
save("em_arena_antievent_0.05.mat",'anti');
%% tube - binary 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
[E,~]=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca_cl{p,m}=normalizeca(ca,'type','binary'); 
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save('em_18p_binary_th0.5.mat','em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05);
save("em_18p_antievent_binary_0.05.mat",'anti');
%% tube - continuous with max limit 
% Remove contamination and Binarize data 
load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat');
N=18;
dis_th=40;
[E,~]=remove_contamination(E,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        ca=zscore(E{p}{m}.dFFCalciumTraces);
        ca_cl{p,m}=normalizeca(ca); 
    end
end
% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
save('em_18p_th0.5.mat','em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05);
save("em_18p_antievent_0.05.mat",'anti');