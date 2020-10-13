% validate remove duplicate event function... 
% need to embed in the events mining functions 

time=em{1,1}.time;K=em{1,1}.K;M=em{1,1}.M;
N=18;nm=2;
for p=1:N
    for m = 1:nm
        [time{p,m}]=remove_dup_event(K{p,m},M{p,m},time{p,m});
    end
end