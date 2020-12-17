function [maxy]=eventplot_lines(etime1,allk,xvalues1,options)
% plot events as lines on the time line 
% inputs: etime1 - (cell array) event 'start'/'center' times (default is start time)
% (event, 2nd round or anti event),each cell for one k in klist
% allk - (cell array) all ks in the k list - one k each cell or same size as events; 
% xvalues1 - (num vector) the corresponding x value in event time
% options.y0 - (num) start y after last plot
% options.col - color of lines
arguments
    etime1
    allk
    xvalues1
    options.y0 (1,1) = 0;
    options.col (1,:) = [0 0.4470 0.7410];
    options.position = 'start'
end
y=0;
for k = 1:length(allk)
    ne=length(etime1{k});
    if isequal(options.position, 'center')
        etime1{k}=etime1{k}-allk{k}/2;
    end
    for n=1:ne
        y=y+1;
        x=etime1{k}(n);
        if length(allk{k})>1
            line([xvalues1(x) xvalues1(x)+allk{k}(n)],[options.y0+y options.y0+y],'color',options.col)
        else
            line([xvalues1(x) xvalues1(x)+allk{k}],[options.y0+y options.y0+y],'color',options.col)
        end
    end
end
maxy=options.y0+y;