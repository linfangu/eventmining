function th = cor_threshold(corvec,disvec)
% input: vector form of correlation and distance matrix 
% output: th =(numaric)optimized threshold of correlation to consider when examining
% duplicating cells
close=disvec<50;
far=disvec>=50;
for th=0.2:0.01:0.6
    ab=corvec>th;
    pcl=sum(ab&close)/sum(ab);
    pf=sum(ab&far)/sum(ab);
    if pcl>=5*pf
        break
    end
end

