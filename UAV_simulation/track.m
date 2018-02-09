function track(S,U,R_rt,R_best)
n=length(R_best(:,1));
global des_x1;
global des_x2;
global des_y1;
global des_y2;
global for_v1;
global for_v2;
global count;
global count1;
count1=1;
count=1;
global time;
time=1;
for i=2:length(R_rt(1,:))
if(R_best(1,i)~=0)
    des_x1(2*(i-1)-1)=S.x(R_best(1,i),R_rt(1,i));
    des_y1(2*(i-1)-1)=S.y(R_best(1,i),R_rt(1,i));
    for_v1(2*(i-1)-1)=10%U.v;
    des_x1(2*(i-1))=40;
    des_y1(2*(i-1))=S.y(R_best(1,i),R_rt(1,i));
    for_v1(2*(i-1))=10%U.v;
end
end

for i=2:length(R_rt(1,:))
if(R_best(2,i)~=0)
    des_x2(2*(i-1)-1)=S.x(R_best(2,i),R_rt(2,i));
    des_y2(2*(i-1)-1)=S.y(R_best(2,i),R_rt(2,i));
    for_v2(2*(i-1)-1)=10%U.v;
    des_x2(2*(i-1))=40;
    des_y2(2*(i-1))=S.y(R_best(2,i),R_rt(2,i));
    for_v2(2*(i-1))=10%U.v;
end
end

end