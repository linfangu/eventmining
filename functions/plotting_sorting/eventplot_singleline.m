function [maxy]=eventplot_singleline(etime,allk,len,options)
% plot events of each k as 1 or 2 lines on the time line 
% inputs: etime - (cell array) event 'start'/'center' times (default is start time)
% (event, 2nd round or anti event),each cell for one k in klist
% allk - (cell array) all ks in the k list - one k each cell; 
% len - (num) total length of time
% options.y0 - (num) start y after last plot
% options.col - color of lines
arguments
    etime
    allk
    len
    options.y0 (1,1) = 0;
    options.col (1,:) = [0 0.4470 0.7410];
    options.position = 'start'
end
y=0;
for k = 1:length(allk)
    ne=length(etime{k});
    if ne==0
        continue
    end
    if isequal(options.position, 'center')
        etime{k}=etime{k}-allk{k}/2;
    end
    timeline=zeros(1,len);
    for n=1:ne
        ovp=sum(timeline(:,etime{k}(n):etime{k}(n)+allk{k}),2);
        if all(ovp~=0)
            timeline=[timeline;zeros(1,len)];
            l=size(timeline,1);
        else
            l=find(ovp==0,1);
        end
        timeline(l,etime{k}(n):etime{k}(n)+allk{k})=1;
        line([etime{k}(n) etime{k}(n)+allk{k}],[options.y0+y+l,options.y0+y+l],'color',options.col,'LineWidth',2.5)
    end
    y=y+size(timeline,1);
end
maxy=options.y0+y;