% % t=1;
% % S.x=[2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21;
% %     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
% % S.y=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
% %     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
% % S.v=1;
% % S.v_d=[1;2];
% % B.x=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
% % B.y=[10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10];
% % B.v=1;
% % B.v_d=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% % U.x=1;
% % U.y=20;
% % U.v=2;
% % a=20;
% % b=20;
% % c=1;
% % [Grid]=form_grid(a,b,c);
% % place=refresh_place(Grid,B,t);
% % place=refresh_place(place,S,t);
% % [L_go,L_go_t]=mypath1(t,S,B,U)
% % [L_return,L_return_t]=mypath2(t,L_go_t,S,B)
% % [weight]=L_go+L_return
% % L_t=L_return_t
% 
% weight=[inf 1 2 3;1 inf 2 3;1 2 inf 3;1 2 3 inf];
%  [L_best,R_best]=myaco_init(weight);
% S_visited=[1 2 0 0;
%      1 0 0 0];
%  S_visited_flag=[1 1 0 0];
%  R_best=[1 2 3 0;
%      1 4 0 0];
% %   S_visited=get_visited(S_visited_flag,R_best)
%  [L_best,R_best]=myaco(weight,S_visited,S_visited_flag)
%  weight=[1000 1000 100 10;1000 1000 1000 10;1000 1000 1000 1000;1000 1000 1000 1000]
% %  count=0;
% % for i=1:length(weight(1,:))
% %     temp=find(weight(:,i)==1000)
% %     if(length(temp)==length(weight(1,:)))
% %         count=count+1;
% %     end
% % end
% [L_best,R_best]=myaco_init(weight);
% R_best=[3 1 0 0;3 2 4 0;3 5 6 7];
% R_rt=[1 3 0 0;1 2 3 0;1 2 4 6];
% t=5;
%  [S_visited_flag]=get_visited_flag(t,R_rt,R_best)
global des_x1;
global des_x2;
global des_y1;
global des_y2;
global for_v1;
global for_v2;
global rdes_x2;
global rdes_y2;
rdes_x2=[];
rdes_y2=[];
global rdes_x1;
global rdes_y1;
rdes_x1=[];
rdes_y1=[];
global count;
count=1;
global count1;
count1=1;
global t1;
global t2;
t2=0;
t1=0;
des_x1=[27 40 20 40  19 40];
des_x2=[25 40 17 40]
des_y1=[11 11 28 28 24 24]
des_y2=[17  17 19 19]
% des_x1=[27 40 17 40  20 40];
% des_x2=[34 19 40 25 40]
% des_y1=[11 11 19 19 28 28]
% des_y2=[18 26 24 17 17]
for_v1=[3 1 3 1 3 1]
for_v2=[3 3 1 3 1 3 1]


