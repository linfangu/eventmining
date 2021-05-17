% load('dTT_SYN_18Pair_R3_042619_UPD_cellROIs.mat')
% remove contamination
dis_th=40;
[E,~]=remove_contamination(E,dis_th);
%%
i=0;
for p=1:6
    for m=1:2
        i=i+1;
X = zscore(compressMatrix(E{p}{m}.dFFCalciumTraces, 30, 1))';
[U,V,x,cx,rst1tr,rst1te,rst2tr,rst2te]=stability_dimensions(X);
figure(1)
subplot(3,4,i)
plot(cx, 'o-')
title(sprintf('experiment %d mouse %d', p, m))
hold on, plot(xlim, [0 0], 'k--'); hold off
figure(2)
subplot(3,4,i)
scatter( corr([U(:, 1)' * rst1tr]', rst2tr'), corr([U(:, 1)' * rst1te]', rst2te'))
xlabel('correlation of 2nd population neurons with PC1 trajectory, 1st half')
ylabel('correlation of 2nd population neurons with PC1 trajectory, 2nd half')
    end
end
