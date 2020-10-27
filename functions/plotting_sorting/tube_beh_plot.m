function tube_beh_plot(beh,opbeh,position,opposition)
% ---self-behaviour------ %
L=size(beh,1); s=floor(L/30); % 1s bin
sbbin=zeros(s,3);
for t=1:s
    sbbin(t,:)=sum(beh(30*(t-1)+1:30*t,1:3),1);
end
% ---oppo-behaviour------ %
obbin=zeros(s,3);
for t=1:s
    obbin(t,:)=sum(opbeh(30*(t-1)+1:30*t,1:3),1);
end
% ----self-position--------- %
sp=zeros(1,s);
for t=1:s
    sp(t)=mean(position(30*(t-1)+1:30*t));
end
% ----opponent-position ----%
op=zeros(1,s);
for t=1:s
    op(t)=1-mean(opposition(30*(t-1)+1:30*t));
end
% --- plot position----------- %
p1=plot(sp,'-');hold on
p2 = plot(op,'-');
yl=[0 1];
col={'r','b','g'}; % color for push, approach, retreat
for b = 1:3
    bhonset=find(sbbin(:,b));
    for i=1:length (bhonset)
        line([bhonset(i) bhonset(i)],[0 -yl(2)/5],'Color',col{b},'HandleVisibility','off')
    end
    oponset=find(obbin(:,b));
    for i=1:length (oponset)
        line([oponset(i) oponset(i)],[-yl(2)/5 -2*yl(2)/5],'Color',col{b},'HandleVisibility','off')
    end
end
%set(legend, 'NumColumns' ,2)
xlim([0 s])
line(xlim,[0 0],'Color','k','HandleVisibility','off');line(xlim,[-yl(2)/5 -yl(2)/5],'Color','k','HandleVisibility','off')
hold off
ylim([-2*yl(2)/5 yl(2)]);yticks([-0.3 -0.1 0 0.5 1]);yticklabels({"Opo","Self","0",'0.5','1'})
legend([p1 p2],{'self','opponent'})
end
