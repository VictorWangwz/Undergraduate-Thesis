%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            航迹平滑2
%
%  输入: 待平滑的航迹（x1,y1,x2,y2,x3,y3）；
%        r是设置的无人机最小转弯半径；
%  输出：CL、CR的值；
%  功能：确定CL与CR的位置
%
%
%                     程序设计：郜晨  日期：2013/02/23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc
load x1.dat;
load x2.dat;
load x3.dat;
load y1.dat;
load y2.dat;
load y3.dat;
r=1;
l1=[x3(3) y3(3);x3(4) y3(4)];
l2=[x3(4) y3(4);x3(5) y3(5)];
q1=[x3(4)-x3(3) y3(4)-y3(3)];
q2=[x3(5)-x3(4) y3(5)-y3(4)];
vq1=q1(1)+q1(2)*i;
vq2=q2(1)+q2(2)*i;
vq1=vq1/abs(vq1);
vq2=vq2/abs(vq2);
% mq1=sqrt(sum(q1.^2));
% mq2=sqrt(sum(q2.^2));      %q1,q2的模
% beta=acos((q1(1)*q2(1)+q1(2)*q2(2))/(mq1*mq2));  %两条航迹之间的夹角
plot(l1(:,1),l1(:,2),'b-',l2(:,1),l2(:,2),'b-')  %绘制两条航迹
axis([42 42.5 24.8 25]);
hold on;
c=(l1(2,1)+l1(2,2)*i)+r*(vq2-vq1)/abs((vq2-vq1))
                                                 %圆C的圆心坐标
x=real(c);
y=imag(c);
circle(x,y,r)
circle(x,y,2*r)
tk1=-1*q1(2)/q1(1);
tk2=-1*q2(2)/q2(1);
% l11=l1+[0 r*sqrt(1+tk1^2);0 r*sqrt(1+tk1^2)];
% l22=l2+[0 r*sqrt(1+tk2^2);0 r*sqrt(1+tk2^2)];
l11=l1+[r*sqrt(1+1/tk1^2) 0;r*sqrt(1+1/tk1^2) 0];
l22=l2+[0 r*sqrt(1+tk2^2);0 r*sqrt(1+tk2^2)];
plot(l11(:,1),l11(:,2),'r-',l22(:,1),l22(:,2),'r-')
[x,y] = ginput(1)
circle(x,y,r)
% axis([41.5 43.6 23.8 24.1]);
% [x,y] = ginput(1)
% circle(x,y,r)
axis([41.5 43.6 23.8 24.1]);
[x,y] = ginput(15)
smooth1(:,1)=x;
smooth1(:,2)=y;
% axis([36.2 37.2 24.5 24.7]);
% [x,y] = ginput(15)
% smooth2(:,1)=x;
% smooth2(:,2)=y;
save smooth1.dat smooth1 -ASCII;
% save smooth2.dat smooth2 -ASCII;
% axis([20 40 20 40])