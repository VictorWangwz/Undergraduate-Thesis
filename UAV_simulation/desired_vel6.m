function out=desired_vel1(in)
glob;

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
diatance_went = sqrt((x-desx)^2+(y-desy)^2);
if(diatance_went <for_v1/2)
desired_vel = diatance_went/2;
yaw = atan((desy-0)/(desx-20));
else
desired_vel =  for_v1;
yaw = atan((desy-0)/(desx-20));
end
distance_go = sqrt((x-20)^2+(y-0)^2); 

distance = sqrt((desx-20)^2+(desy-0)^2);
if(distance_go >distance )
    desired_vel = 0;
    yaw =0;
end
vel_x = desired_vel*(desx-20)/distance ;
vel_y = desired_vel*(desy-0)/distance ;
out(1)=vel_x;
out(2)=vel_y;
out(3)=0;