
%% test the limitk function 
for p=1:N
for m=1:2
[K,M,time]=limitk(klist,em{1,1}.K{p,m},em{1,1}.M{p,m},em{1,1}.time{p,m});
s=size(ca_cl{p,m},2);
[ne_klist{p,m}]=count_eve(K{p,m},time{p,m},s);
end
end
em{1,1}.ne_klist=ne_klist;em{1,1}.klist=klist;