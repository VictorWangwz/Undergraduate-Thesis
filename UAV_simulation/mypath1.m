function [L_best,L_go_t]=mypath1(t,S,B,U)%%采用A*算法求解
% function [Shortest_Route,Shortest_Length]=myaco(s,e,weight,flag0)
NC_max=50;                           %迭代次数
%m表示蚂蚁结构体包涵八个方向,代表不同方向的蚂蚁
m.x=zeros(1,8);
m.y=zeros(1,8);
n=length(S.x(:,1));
a=40;
b=40;
c=1;
dt=20;
%更新S最新位置
%S=refresh_S(t,S);
S_temp=S;
Uv=floor(0.7*U.v);%沿斜边走时距离不是整U.v
grid=form_grid(a,b,c);
t_ori=t;
r_cost=U.v;%r_cost为因为有障碍物而等待的时间所能行驶的距离
endflag=0;                            %终止标志（当到达目标点时为1）
Route=zeros(1,8);%记录每次迭代各方向的路径长度
Tabu=zeros(n,n);                     %存储并记录路径的生成
Tabu_t=zeros(n,n);
NC=1;      %迭代计数器
out_flag=ones(1,8);%判断是否超出活动范围的边界，1为没有
L_best=inf.*ones(n,n);          %各代最佳路线的长度
L_go_t=inf.*ones(n,n);
%while NC<=NC_max                     %停止条件之一：达到最大迭代次数
    for i=1:length(S.x(:,1))
        for j=1:length(S.x(:,1))
           if(i~=j)
%                for t_temp=1:20
%                     S_temp=forsee_SB(S_temp,t,t_temp);
% 
%                end
            for p=1:8
            m.x(p)=b;
            m.y(p)=S.y(i,t);
            end
            while(endflag==0)
                S_temp=forsee_SB(S_temp,t,1);
                t=t+1;
                m.x(1)=m.x(1)+U.v;
                m.x(2)=m.x(2)+Uv;m.y(2)=m.y(2)-Uv;
                m.y(3)=m.y(3)-U.v;
                m.x(4)=m.x(4)-Uv;m.y(4)=m.y(4)-Uv;
                m.x(5)=m.x(5)-U.v;
                m.x(6)=m.x(6)-Uv;m.y(6)=m.y(6)+Uv;
                m.y(7)=m.y(7)+U.v;
                m.x(8)=m.x(8)+Uv;m.y(8)=m.y(8)+Uv;
                out_flag=judge_flag(m.x,m.y);%判断是否出界
                for p=1:8
                    if (out_flag(p))
                    place=refresh_place(grid,B,t);
                    delta_route=min(abs(m.x(p)-S_temp.x(j,t))+abs(m.y(p)-S_temp.y(j,t)),1.5*abs(m.x(p)-S_temp.x(j,t))+abs(abs(m.x(p)-S_temp.x(j,t))-abs(m.y(p)-S_temp.y(j,t))));
                    Route(p)=U.v+delta_route;
%                     if(mod(p,2)==0)
%                         Route(p)=Route(p)+0.5*U.v;
%                     end
                    if (place(m.x(p),m.y(p))==0)
                        Route(p)=Route(p)+r_cost;
                    end
                    else%%出界的话使得路径长度为无限
                        Route(p)=inf;
                    end
                 
                end
                r_decision=find(Route==min(Route));%r_decision表示最小路径的方向
                %将蚂蚁移动到最小路径方向对应的点 
                for p=1:8
            m.x(p)=m.x(r_decision(1));
            m.y(p)=m.y(r_decision(1));
                end
                %当到达目标时，使得endflag置位
                if(abs(m.x(1)-S_temp.x(j,t))<(U.v-S.v)&&abs(m.y(1)-S_temp.y(j,t))<(U.v-S.v))
                endflag=1;
                end
            %计算i到j的时间损耗
            Tabu(i,j)=(t-t_ori)*U.v;
            %当所用时间超过20s或者最终位置超出边界时，置为inf意为不可达
            if((t-t_ori>dt)||S_temp.x(j,t)>a||S_temp.y(j,t)>a||S_temp.x(j,t)<0||S_temp.y(j,t)<0)
               Tabu(i,j)=inf; 
               endflag=1;
            end
            end
            write_S(S_temp);
            Tabu_t(i,j)=t;
            t=t_ori;
            endflag=0;
           end
        end
    end
    
   for i=1:n
        for j=1:n
            if(Tabu(i,j)<L_best(i,j))
                L_best(i,j)=Tabu(i,j);
                L_go_t(i,j)=Tabu_t(i,j);
            end
        end
   end
 
%end
end