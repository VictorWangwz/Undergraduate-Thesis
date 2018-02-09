function out=sim_track1(in)
global des_x2;
global des_y2;
global for_v2;
% global des_x;
% global des_y;
% global for_v;
global count1;
%count1=1;
global rdes_x2;
global rdes_y2;

global t2;
t2=t2+1;
% n=(length(in)-2)/3;
% des_x=in(1:n);
% des_y=in(n+1:2*n);
% for_v=in(2*n+1:3*n);
% real_x=in(3*n+1);
% real_y=in(3*n+2);

% des_x2(1)=des_x2(1)-0.0003;
% if(abs(in(1)-34)<1&&count1==1)
%     count1=count1+1;
% end
des_x2(1)=des_x2(1)-0.0002;
des_y2(3)=des_y2(3)-0.0002;
% if count1<=2
% des_y2(2)=des_y2(2)-0.0002;
% des_x2(2)=des_x2(2)-0.0002;
% end
% if count1<=4
% des_x2(4)=des_x2(4)-0.0003;
% end
des_x=des_x2;
des_y=des_y2;
for_v=for_v2;
real_x=in(1);
real_y=in(2);

  
  

if (count1<=length(des_x))
    
   x=des_x(count1);
    y=des_y(count1);
    v=for_v(count1);   
    temp1=abs(x-real_x)<=1.5;%for_v(count1,1);
    temp2=abs(y-real_y)<=1.5;%for_v(count1,1);
if(temp1&&temp2)
    count1=count1+1;
    x=des_x(count1);
    y=des_y(count1);
    v=for_v(count1);
    des_y2(3)=des_y2(2);
    des_y2(5)=des_y2(4);
end
% else
%    x=des_x(count1-1);
%     y=des_y(count1-1);
%     v=for_v(count1-1);    
end

rdes_x2(t2)=x;
rdes_y2(t2)=y;
% scatter(in(3*n+1),in(3*n+2),'g*');
% scatter(x,y,'bo');
% axis([0 50 0 50]);
% hold on;
% des_x1=x;
out(1)=floor(x);
% des_y1=y;
out(2)=floor(y);
% for_v1=v;
out(3)=floor(v);


end