function place=refresh_place(grid,B,t)
n=length(B.x(:,1));
x=grid;
for i=1:n
    %%当运行在规定空间内时可以继续进行
    if((B.x(i,t)<=20)&&(B.x(i,t)>0)&&(B.y(i,t)>0)&&(B.y(i,t)<=20))
     x(B.x(i,t),B.y(i,t))=0;
    end
   
end
place=x;
y = x;
y(end+1,end+1) = 0;
%colormap([0 0 0;1 1 1]),pcolor(0.5:size(x,2)+0.5,0.5:size(x,1)+0.5,y)
%set(gca,'XTick',1:size(x,2),'YTick',1:size(x,2))
%hold on
%axis image ij
end
