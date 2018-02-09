%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            航迹平滑1
%
%  输入: 待平滑的航迹（x1,y1,x2,y2,x3,y3）；
%        r是设置的无人机最小转弯半径；
%  输出：k的值
%  功能：确定圆C的位置
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
r=10;
q1=[x1(2)-x1(1) y1(2)-y1(1)];
q2=[x1(3)-x1(2) y1(3)-y1(2)];          %q1,q2为两条航迹的向量表示
mq1=sqrt(sum(q1.^2));
mq2=sqrt(sum(q2.^2));      %q1,q2的模
beta=acos((q1(1)*q2(1)+q1(2)*q2(2))/(mq1*mq2));  %两条航迹之间的夹角
small=0.8;
kfind=[0 0];
while(length(kfind)>1)
    k0=kfind(1);
    kfind=[];
    i=1;
    for k=k0:0.0001:1
        if abs(r*sqrt(4-(1+sin(beta/2)+k*(1-sin(beta/2))^2))+r*(1+k*(1/sin(beta/2)-1))*cos(beta/2)-...
                r*((pi-beta)/2+2*acos((1+sin(beta/2)+k*(1-sin(beta/2)))/2)))<small;
            kfind(i)=k;
            i=i+1;
        else
        end
    end
    small=small-0.001;
end
small=small
deta=r*sqrt(4-(1+sin(beta/2)+kfind*(1-sin(beta/2))^2))+r*(1+kfind*(1/sin(beta/2)-1))*cos(beta/2)-...
            r*((pi-beta)/2+2*acos((1+sin(beta/2)+kfind*(1-sin(beta/2)))/2))
        
        
        