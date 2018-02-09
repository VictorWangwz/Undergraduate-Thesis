
% clear all;
% clc ;
% 
% 
% formation1=[0 5;-5 0;5 0;0 -5];
% formation2=[-5 5;5 5;-5 -5;5 -5];
% 
% [Shortest_Route,Shortest_Length]=myaco(formation1,formation2);

clear all;
global des_x1;
global des_y1;
global des_x2;
global des_y2;
global des_x3;
global des_y3;
global des_x4;
global des_y4;
global des_x5;
global des_y5;
global des_x6;
global des_y6;

global for_v1;
global for_v2 ;
global for_v3;
global for_v4 ;
global for_v5;
global for_v6;

% for1=[6 12;4 8 ;8 8 ;2 4 ;6 4;10 4; 0 0;4 0; 8 0;12 0];%三角形十个
% for2=[0 12;4 12; 8 12; 12 12; 0 8; 12 8;0 4 ;12 4;0 0;12 0];%正方形边框
% for1=[4 8;0 4 ;4 4 ;8 4 ;0 0;4 0; 8 0];%三角形十个
% for2=[0 8;8 8; -4 4; 4 4; 12 4; 0 0;8 0];%正方形边框
% for1=[8 8;4 4 ;12 4;0 0;16 0];%三角形十个
% for2=[8 8;4 4; 8 4; 12 4;8 0;];%正方形边框
 for1=[-10 0;0 0 ;10 0 ;-10 -10 ;0 -10;10 -10];%三角形十个
 for2=[-20 25;-22 23; -18 23; -24 21; -20 21; -16 21];%正方形边框
[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=myaco(for1,for2,20,10,5,1,0.2,1);
% R0=1;
% R1=1;
% P=[1030 970];Phi1=pi/2;
% G=[0 0];Phi0=pi/3;
% [a,b,c]=DubinsRL(R0,Shortest_Route(1,i,1),1,G(2),Phi0,R1,P(1),P(2),Phi1,1);
for i=1:6
if (Shortest_Route(1,i,1)) ==1
des_x1 = for2(Shortest_Route(1,i,2),1);
des_y1 = for2(Shortest_Route(1,i,2),2);
else if (Shortest_Route(1,i,1)) ==2
des_x2 = for2(Shortest_Route(1,i,2),1);
des_y2 = for2(Shortest_Route(1,i,2),2);
else if (Shortest_Route(1,i,1)) ==3
des_x3 = for2(Shortest_Route(1,i,2),1);
des_y3 = for2(Shortest_Route(1,i,2),2);
else if (Shortest_Route(1,i,1)) ==4
des_x4 = for2(Shortest_Route(1,i,2),1);
des_y4 = for2(Shortest_Route(1,i,2),2);
else if (Shortest_Route(1,i,1)) ==5
des_x5 = for2(Shortest_Route(1,i,2),1);
des_y5 = for2(Shortest_Route(1,i,2),2);
else if (Shortest_Route(1,i,1)) ==6
des_x6 = for2(Shortest_Route(1,i,2),1);
des_y6 = for2(Shortest_Route(1,i,2),2);
    end
    end
    end
    end
    end
end
end

save('matlab1','des_x1');
save('matlab1','des_y1');
save('matlab1','des_x2');
save('matlab1','des_y2');
save('matlab1','des_x3');
save('matlab1','des_y3');
save('matlab1','des_x4');
save('matlab1','des_y4');
save('matlab1','des_x5');
save('matlab1','des_y5');
save('matlab1','des_x6');
save('matlab1','des_y6');
distance1 = sqrt ((for1(1,1) -des_x1 )^2 + (for1(1,2) -des_y1 )^2);
distance2 = sqrt ((for1(2,1) -des_x2 )^2 + (for1(2,2) -des_y2 )^2);
distance3 = sqrt ((for1(3,1) -des_x3 )^2 + (for1(3,2) -des_y3 )^2);
distance4 = sqrt ((for1(4,1) -des_x4 )^2 + (for1(4,2) -des_y4 )^2);
distance5 = sqrt ((for1(5,1) -des_x5 )^2 + (for1(5,2) -des_y5 )^2);
distance6 = sqrt ((for1(6,1) -des_x6 )^2 + (for1(6,2) -des_y6 )^2);
max_distance = max([distance1 distance3 distance3 distance4 distance5  distance6]);
time1 = max_distance/2 +1;
for_v1 = distance1 /(time1 - 1);
for_v2 = distance2 /(time1 - 1);
for_v3 = distance3 /(time1 - 1);
for_v4 = distance4 /(time1 - 1);
for_v5 = distance5 /(time1 - 1);
for_v6 = distance6 /(time1 - 1);
save('matlab1','for_v1');
save('matlab1','for_v2');
save('matlab1','for_v3');
save('matlab1','for_v4');
save('matlab1','for_v5');
save('matlab1','for_v6');
