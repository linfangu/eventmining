function [maxy]=eventplot_lines(etime1,allk,xvalues1,options)
% plot events as lines on the time line 
% inputs: etime1 - (cell array) event times
% (event, 2nd round or anti event),each cell for one k in klist
% allk - (cell array) all ks in the k list; 
% xvalues1 - (num vector) the corresponding x value in event time
% options.y0 - (num) start y after last plot
% options.col - color of lines
arguments
    etime1
    allk
    xvalues1
    options.y0 (1,1) = 0;
    options.col (1,:) = [0 0.4470 0.7410];
end
y=0;
for k = 1:length(allk)
    ne=length(etime1{k});
    for n=1:ne
        y=y+1;
        x=etime1{k}(n);
        line([xvalues1(x) xvalues1(x)+allk{k}(n)],[options.y0+y options.y0+y],'color',options.col)
        hold on
    end
end
maxy=options.y0+y;