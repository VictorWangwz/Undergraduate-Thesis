function y=ArcLen(R,ang1,ang2)
ang=ang2-ang1;
if ang<0
    ang=ang+pi*2;
end;
y=R*ang;
end