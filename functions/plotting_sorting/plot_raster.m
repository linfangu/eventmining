function [order]=plot_raster(ca,options)
% order cells according to pair-wise correlation, plot rasters
% input: ca (num matrix) two dimensional: (cell,time points)
% optionally bin signals (default is true (1)); default bin rate is 30frame (1s)
% output: order (num array) cell order index used in raster 
arguments
    ca
    options.bin (1,1) logical = 1
    options.binrate (1,1) = 30
    options.ncomp (1,1)=30 % must be smaller than the total number of cells
end
if options.bin==1
    [nc,L]=size(ca); s=floor(L/options.binrate); cabin=zeros(nc,s);
for t=1:s
    cabin(:,t)=mean(ca(:,options.binrate*(t-1)+1:options.binrate*t),2);
end
else 
    cabin=ca;
end
ops.iPC=1:options.ncomp;
[order, ~, ~] = mapTmap(cabin, ops);
imagesc(cabin(order,:))
end

% example use:
% (1) without preprocessing 
% ca=zscore(E{1, 1}{1, 1}.dFFCalciumTraces);
% plot_raster(ca'); 
% (2) normalize signal 
% ca=zscore(E{1, 1}{1, 1}.dFFCalciumTraces);
% cabin=normalizeca(ca);
% plot_raster(cabin,'bin',0);


