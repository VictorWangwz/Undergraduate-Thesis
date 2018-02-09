function out=desired_vel1(in)
glob;
global des_x1;
global des_y1;
% ********* Operational Conditions *********
roll=in(1);     % [rad]
dotroll=in(2);  % [rad/s]
pitch=in(3);
dotpitch=in(4);
yaw=in(5);
dotyaw=in(6);
z=in(7);        % [m]
dotz=in(8);     % [m/s]
x=in(9);
dotx=in(10);
y=in(11);
doty=in(12);
desx=in(13);
desy=in(14);
for_v1=in(15);

global count;
x0=40;
y0=20;
if(count~=1)
    x0=des_x1(count-1);
    y0=des_y1(count-1);
end

diatance_went = sqrt((x-desx)^2+(y-desy)^2);
if(diatance_went <for_v1/2)
desired_vel = diatance_went/2;
yaw = atan((desy-y0)/(desx-x0));
else
desired_vel =  for_v1;
yaw = atan((desy-y0)/(desx-x0));
end
distance_go = sqrt((x-x0)^2+(y-y0)^2); 

distance = sqrt((desx-x0)^2+(desy-y0)^2);
if(distance_go >distance )
    desired_vel = 0;
    yaw = 0;
end
vel_x = desired_vel*(desx-x0)/distance ;
vel_y = desired_vel*(desy-y0)/distance ;
out(1)=vel_x;
out(2)=vel_y;
out(3)=0;