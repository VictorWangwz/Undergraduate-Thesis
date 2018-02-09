function [L_return,L_return_t]=mypath2(t0,L_go_t,S,B)

%m表示蚂蚁结构体包涵八个方向,代表不同方向的蚂蚁
m.x=zeros(1,8);
m.y=zeros(1,8);
n=length(S.x(:,1));
a=20;
b=20;
c=1;
grid=form_grid(a,b,c);
t=L_go_t;
t_ori=t;
r_cost=S.v;%r_cost为因为有障碍物而等待的时间所能行驶的距离
endflag=0;                            %终止标志（当到达目标点时为1）
Route=zeros(1,8);%记录每次迭代各方向的路径长度
Tabu=zeros(n,n);                     %存储并记录路径的生成
Tabu_t=zeros(n,n);
NC=1;      %迭代计数器
L_return=inf.*ones(n,n);          %各代最佳路线的长度
L_return_t=inf.*ones(n,n);
%更新S最新位置
% S=refresh_S(t0,S);

%根据最新S得到t(i,j)时刻之后20s的预测信息,S_temp用于临时保存本次的预测信息

%while NC<=NC_max                     %停止条件之一：达到最大迭代次数
    for i=1:length(S.x(:,1))
        for j=1:length(S.x(:,1))
            if(i~=j) 
                S_temp=S_information(t(i,j));
                place=refresh_place(grid,B,t(i,j));
                place=refresh_place(place,S_temp,t(i,j));
            for p=1:8
            m.x(p)=S_temp.x(i,t(i,j));
            m.y(p)=S_temp.x(i,t(i,j));
            end
            while(endflag==0)
                
                S_temp=forsee_SB(S_temp,t(i,j),1);
                t(i,j)=t(i,j)+1;
               m.x(1)=m.x(1)+S.v;
                m.x(2)=m.x(2)+S.v;m.y(2)=m.y(2)-S.v;
                m.y(3)=m.y(3)-S.v;
                m.x(4)=m.x(4)-S.v;m.y(4)=m.y(4)-S.v;
                m.x(5)=m.x(5)-S.v;
                m.x(6)=m.x(6)-S.v;m.y(6)=m.y(6)+S.v;
                m.y(7)=m.y(7)+S.v;
                m.x(8)=m.x(8)+S.v;m.y(8)=m.y(8)+S.v;
                out_flag=judge_flag(m.x,m.y);%判断是否出界
                for p=1:8
                    if (out_flag(p))
                   
                    delta_route=b-m.x(p);
                    Route(p)=S.v+delta_route;
                    if (place(m.x(p),m.y(p))==1)
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
                if(abs(b-m.x(1))<S.v)
                endflag=1;
                end
            %计算i到j的时间损耗
            Tabu(i,j)=(t(i,j)-t_ori(i,j))*S.v;
            %当所用时间超过20s或者最终位置超出边界时，置为inf意为不可达
            if(S_temp.y(j,t(i,j))>20||S_temp.y(j,t(i,j))<0||t(i,j)-t_ori(i,j)>20)
               Tabu(i,j)=inf; 
            end
            end
            Tabu_t(i,j)=t(i,j);
            t=t_ori;
            endflag=0;
        end
        end
    end
    
    
   for i=1:n
        for j=1:n
            if(Tabu(i,j)<L_return(i,j))
                L_return(i,j)=Tabu(i,j);
                L_return_t(i,j)=Tabu_t(i,j);
            end
        end
   end
 
%end
end
