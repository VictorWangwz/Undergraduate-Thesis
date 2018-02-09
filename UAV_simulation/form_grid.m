function [Grid]=form_grid(a,b,c)
a=a/c;
b=b/c;
x = ones(a,b);
y = x;
y(end+1,end+1) = 0;
colormap([0 0 0;1 1 1]),pcolor(0.5:size(x,2)+0.5,0.5:size(x,1)+0.5,y)
set(gca,'XTick',1:size(x,2),'YTick',1:size(x,2))
axis image ij
Grid=x;
end