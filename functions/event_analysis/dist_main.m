function [distwithin,distbetween]=dist_main(ev_merge)
% calculate the within pair and between pair distance from events 
[N,nm]=size(ev_merge);
distwithin=cell(N,nm);distbetween=cell(N,nm);
for p=1:N
    for m=1:2
        distwithin{p,m}=cell(1,4);distbetween{p,m}=cell(1,4);
        for k=1:4
            if isempty(ev_merge{p,m}{k})
               continue 
            end
            % within pair
            distwithin{p,m}{k}=eventdist(ev_merge{p,m}{k},ev_merge{p,setdiff([1 2],m)}{k}); 
            distbetween{p,m}{k}=[];
            for p1=setdiff(1:N,p) % exclude the same pair index
                for m1=1:2
                    if isempty(ev_merge{p1,m1}{k})
                        continue 
                    end
                    distbetween{p,m}{k}(end+1,:)=eventdist(ev_merge{p,m}{k},ev_merge{p1,m1}{k}); 
                end
            end
        end
    end 
end