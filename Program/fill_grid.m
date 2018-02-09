function [Gridm]=fill_grid(a,b,c,X,t)
t=t/2;
a=a/c;
b=b/c;
x = ones(a,b);

for i=1:length(X.x(2))
    if (X.x(i,t)~=0||X.y(i,t)~=0)
        x1=floor(X.x(i,t));%%向下取整
        y1=ceil(X.y(i,t));%向上取整
        x(x1,y1)=0;
    end
end

y = x;
y(end+1,end+1) = 0;
% colormap([0 0 0;1 1 1]),pcolor(0.5:size(x,2)+0.5,0.5:size(x,1)+0.5,y)
% set(gca,'XTick',1:size(x,2),'YTick',1:size(x,2))
% axis image ij
end