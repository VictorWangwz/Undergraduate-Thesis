function DrawCircle(R,X,Y,ang1,ang2)
ang=ang2-ang1;
if ang>0
    alpha=ang1:pi/200:ang2;
end;
if ang<0
    alpha=ang1:pi/200:ang2+2*pi;
end;
x=R*cos(alpha)+X;
y=R*sin(alpha)+Y;
plot(x,y,'r-','linewidth',1);
axis equal