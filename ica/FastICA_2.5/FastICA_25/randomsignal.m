%% random combination of signals of 3 sources
s1=10*rand(100,1);
s2=10*rand(100,1);
s3=10*rand(100,1);
s=[s1,s2,s3];
signal=[];
coef=[10*rand(1,8),rand(1,42);
rand(1,15),10*rand(1,5),rand(1,30);
rand(1,44),10*rand(1,6)];
signal=s*coef;
%% run fastica
[ic, A, W]=fastica(signal','numOfIC',3);
% ic=W*input; W = components x weights on cell
%% plot sources and ics
subplot(2,1,1)
plot(ic')
subplot(2,1,2)
plot([s1,s2,s3])
corr(ic',[s1,s2,s3])
%% check weights on cells
subplot(2,1,1)
plot(coef')
subplot(2,1,2)
plot(W')
corr(coef',W')