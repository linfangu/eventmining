%% Exp - continuous event mining 
% Remove contamination and transform data 
% load('dTT_SYN_6pair_sep_exp_ROI.mat')
% load('CMK_dTT_PCA.mat')
load('GABA_dTT_PCA.mat')
N=length(Ee);
dis_th=40;
[Ee,~]=remove_contamination(Ee,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        ca=zscore(Ee{p}{m}.dFFCalciumTraces);
        ca_cl{p,m}=normalizeca(ca); 
    end
end
%% ------------- events ---------------------
em=events_1r(ca_cl); % 1st round events at 0.5 threshold
em2=events_2r(ca_cl,em{1,1}.ne); % 2nd round at 0.5 threshold
em{2,1}=em2{1,1};
% save("exp_tube_con.mat",'em');
% save("cam_tube_con.mat",'em');
save("ga_tube_con.mat",'em');
% ------------ anti events -----------------
anti=events_1r(ca_cl,"type","anti","thre",0.05); 
% save("exp_tube_con_anti.mat",'anti');
% save("cam_tube_con_anti.mat",'anti');
save("ga_tube_con_anti.mat",'anti');
%% Separation - continuous event mining
% Remove contamination and Binarize data 
dis_th=40;
[Es,~]=remove_contamination(Es,dis_th);
ca_cl=cell(N,2);
for p =1:N
    for m =1:2
        ca=zscore(Es{p}{m}.dFFCalciumTraces);
        ca_cl{p,m}=normalizeca(ca); 
    end
end
% ------------- events ---------------------
em_sep=events_1r(ca_cl); % 1st round events at 0.5 threshold
%%
em2=events_2r(ca_cl,em_sep{1,1}.ne); % 2nd round at 0.5 threshold
em_sep{2,1}=em2{1,1};
%save("sep_tube_con.mat",'em_sep');
%save("cam_sep_tube_con.mat",'em_sep');
save("ga_sep_tube_con.mat",'em_sep');
% ------------ anti events -----------------
anti_sep=events_1r(ca_cl,"type","anti","thre",0.05); 
%save("sep_tube_con_anti.mat",'anti_sep');
%save("cam_sep_tube_con_anti.mat",'anti_sep');
save("ga_sep_tube_con_anti.mat",'anti_sep');