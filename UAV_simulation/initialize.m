%初始化
function [S,U,B]=initialize(m,n,t)
a=20;
b=20;
%%定义无人机结构体，表示无人机的位置，速度，速度方向。
U.x=40;
U.y=20;
U.v=3;
save('U','U');
%U=U_information(t,m);%调用函数得到无人机初始时刻信息
%%定义地面机器人结构体，表示机器人的位置，速度，速度方向。
S.x=[];
S.y=[];
S.v=[];
S.v_d=[];
% for i=1:n
%     S.x(i,t)=floor(unifrnd(1,40));
%     S.y(i,t)=floor(unifrnd(1,40));
%     S.v_d(i,t)=floor(unifrnd(1,8));
S.x(:,1)=[32 36 11 38 38]';
S.y(:,1)=[36 25 22 7 19]';
S.v_d(:,1)=[1 1 7 7 6]'
% end
S.v=1;
save('S','S');

%S=S_information(t,n);
%%定义障碍物结构体，表示障碍物的位置，速度，速度方向。
B.x=[];
B.y=[];
load Bx.mat;
load By.mat;
B.x=Bx;
B.y=By;

end