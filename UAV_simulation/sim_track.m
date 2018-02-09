function out=sim_track(in)
global des_x1;
global des_y1;
global for_v1;
% global des_x;
% global des_y;
% global for_v;
global count;

global rdes_x1;
global rdes_y1;

global t1;
t1=t1+1;
%count=1;
% global des_x;
% global des_y;
% n=(length(in)-2)/3;
% des_x=in(1:n);
% des_y=in(n+1:2*n);
% for_v=in(2*n+1:3*n);
% real_x=in(3*n+1);
% real_y=in(3*n+2);
if count==1
des_x1(1)=des_x1(1)-0.0002;
des_y1(1)=des_y1(1)-0.0002;
end
if count<=3
    des_x1(3)=des_x1(3)+0.0003;
des_y1(3)=des_y1(3)-0.0003;
end
if count<=5
des_x1(5)=des_x1(5)+0.0002;
des_y1(5)=des_y1(5)-0.0002;
end
des_x=des_x1;
des_y=des_y1;
for_v=for_v1;
real_x=in(1);
real_y=in(2);

  
  

if (count<=length(des_x))
    
   x=des_x(count);
    y=des_y(count);
    v=for_v(count);   
    temp1=abs(des_x(count)-real_x)<=1.5;%for_v(count,1);
    temp2=abs(des_y(count)-real_y)<=1.5;%for_v(count,1);
if(temp1&&temp2)
    count=count+1;
    x=des_x(count);
    y=des_y(count);
    v=for_v(count);
    des_y1(2)=des_y1(1);
    des_y1(4)=des_y1(3);
    des_y1(6)=des_y1(5);
end
% else
% x=des_x(count1)+time/100;
%     y=des_y(count1);
%     v=for_v(count1);   
end
rdes_x1(t1)=x;
rdes_y1(t1)=y;
%figure 1
% scatter(in(3*n+1),in(3*n+2),'r');
% scatter(x,y,'y+');
% axis([0 50 0 50]);
% hold on;
% des_x1=x;
out(1)=floor(x);
% des_y1=y;
out(2)=floor(y);
% for_v1=v;
out(3)=floor(v);


end