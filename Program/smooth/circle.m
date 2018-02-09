function circle(x,y,r)
alpha=0:pi/100:2*pi; 
x=r*cos(alpha)+x; 
y=r*sin(alpha)+y; 
plot(x,y,'-') 
% axis equal 
axis square