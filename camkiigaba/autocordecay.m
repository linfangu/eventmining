function d=autocordecay(ca,nlag)
% calculate distribution of the number of lags until autocorrelogram decays
% to 1/e
% input: ca (2D mat) neuron x signal, nlag - number of lags in
% autocorrelogram
%!note: if autocorrelation never reach 1/e, decay is set as nlag.
d=[];
for n=1:size(ca,1)
    acf=autocorr(ca(n,:),'NumLags',nlag);
    if sum(acf<(1/exp(1)))>0
        d(n)=find(acf<(1/exp(1)),1);
    else
        d(n)=nlag;
    end
end