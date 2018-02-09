clc;
% clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%1.初始化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% m=input('请输入无人机的个数');
% n=input('请输入地面目标的个数');
t=1;
m=2;
n=5;
 [S,U,B]=initialize(m,n,t);
dt=40;
%%初始化时间参数

S_visited=[];
S_visited_flag=zeros(1,n);
% %%%test set%%%
% U.x=[20,20];
% U.y=[1;2];
% U.v=3;
% S.x=[1;2;3];
% S.y=[10;15;15];
% S.v=1;
% S.v_d=[1;2;4];
% B.x=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1;
%     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1;
%     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% B.y=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1;
%     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
%     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1];
% %%%%


% %%%%%%%%%%%%%%%%%
%%此处是为了仿真而在每次都对实际目标态势进行求得。需要设计场景可在此更改S_t
%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:dt
    S=forsee_SB(S,t,i);
end
write_S(S);
load S_t.mat;
for i=1:length(S.x(:,1))
    
    for j=1:length((S.x(1,:)))
        out_flag=judge_flag(S.x(i,j),S.y(i,j));
        if(out_flag(1)==0)
            S_t.x(i,j)=nan;
            S_t.y(i,j)=nan;
            S_t.v_d(i,j)=nan;
        else
            S_t.x(i,j)=S.x(i,j);
            S_t.y(i,j)=S.y(i,j);
            S_t.v_d(i,j)=S.v_d(i,j);
        end
        
    end
end
S_t.v_d(3,3)=4;

for i=1:dt
    S_t=forsee_SB(S_t,3,i);
end
S_t.v_d(2,5)=5;
for i=1:dt
    S_t=forsee_SB(S_t,5,i);
end
S_t.v_d(1,7)=3;
for i=1:dt
    S_t=forsee_SB(S_t,7,i);
end
save('S_t','S_t');



% %%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%2.获取预测信息，建立S预测结构体
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%对最新地面机器人情况进行获取与预测
[S,flag]=refresh_S(t,S);
for i=1:dt
    S=forsee_SB(S,t,i);
end
write_S(S);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%3.得到初始化之后的出事权重信息，与初始任务分配情况
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%获取t=1时刻的初始信息，与初始权重矩阵
[weight,L_t]=myweight(U,S,B,t);



%%求得初始任务规划结
[L_best,R_best]=myaco_init(weight);
%%求得完成每个点时对应的时间
[R_rt]=reach_t(R_best,L_t);
value=max(max(R_rt));
for i=1:value-t
          S=forsee_SB(S,t,i);
end
[x,y]=DrawSimpleRoute(R_best,S,U,R_rt);
% %test set
% L_best=80;
% R_best(:,:,1)=[3 2 0;3 1 0];
% %%
track(S,U,R_rt,R_best)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%4.在时间推进的过程中，对S进行更新，并判断是否进行重规划直到任务结束
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%根据每两秒的采样数据，对得到的任务进行在线修正
endflag=0;
while(endflag~=1)
  t=t+1;
  %%保持对未来20s时间域的预测
  S=forsee_SB(S,t,dt);
  write_S(S);
  [S,flag]=refresh_S(t,S);
    %%当前时刻如果某个目标已经驱逐完成，则更新后的数据为nan，用以下flag记录已经驱逐完成的目标
  %[S,S_visited_flag]=get_visited_flag(S,t);
  [S,S_visited_flag]=get_visited_flag(t,S,R_rt,R_best);
  %%提取之前得到的最优路径中的已经驱逐完成的部分
  S_visited=get_visited(S_visited_flag,R_best(:,:,1));
  %%flag表示的异常应该不包括已经访问过的目标
%   if(t~=2)
%   flag=flag-S_visited_flag;
%   end
%%test set
%   flag=1;
%   S_visited=[1 2 0;1 3 0];
%   S_visited_flag=[1 1 1];
  %%%
  flag2=find(R_rt(:)==t);
  %%如果flag不全为0时，即需要重规划，需要完成1.对未来20秒重新预测，2.得到新的权重，3.重规划
  if (~all(flag(:)==0)||~isempty(flag2))
      for i=1:20
          S=forsee_SB(S,t,i);
      end
      write_S(S);
  [weight,L_t]=myweight(U,S,B,t);%得到预测时间的权重
  [L_best,R_best]=myaco(weight,S_visited,S_visited_flag)%flag标志为1时进行任务重新分配。
  
  [R_rt]=reach_t(R_best,L_t);
value=max(max(R_rt));
for i=1:value-t
          S=forsee_SB(S,t,i);
end
[x,y]=DrawSimpleRoute(R_best,S,U,R_rt);
  end
  endflag=all(S_visited_flag(:)==1);
  
end

