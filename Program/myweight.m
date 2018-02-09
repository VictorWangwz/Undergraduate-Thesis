
function [weight,L_t]=myweight(U,S,B,t)
a=40;
b=40;
dt=20;
c=1;%a,b为空间长宽，c为步长，飞机与机器人运动为c的整数倍
%%构造栅格空间
[Grid]=form_grid(a,b,c);
%%基于该时间节点的信息对S，B矩阵未来20s的情况进行预测

% %根据得到的S，B信息对grid进行分别填充
% [Grid1]=fill_grid(a,b,c,S,t);
% [Grid2]=fill_grid(a,b,c,B,t);

%%对weight进行修正，加入飞机的起点位置到各的权重
n=length(S.x(:,1));
weight=zeros(n+1,n+1);
L_t=zeros(n+1,n+1);
for i=1:n;
    weight(n+1,i)=floor(sqrt((S.x(i,t)-U.x)^2+(S.y(i,t)-U.y)^2));
    weight(i,n+1)=1000;%%只能作为起点
    L_t(n+1,i)=ceil(weight(n+1,i)/U.v);
     L_t(i,n+1)=1000;
end
for i=1:n
   if(S.x(i,L_t(n+1,i))<0||S.x(i,L_t(n+1,i))>a||S.y(i,L_t(n+1,i))<0||S.y(i,L_t(n+1,i))>b) 
   weight(:,i)=1000;
   L_t(:,i)=1000;
   weight(i,:)=1000;
   L_t(i,:)=1000;
   end
end
weight(n+1,n+1)=1000;
L_t(n+1,n+1)=1000;
% %%test set
% weight=[0 26 1000;27 0 1000;27 26 0];
% %%%

%%得到在边线的各无人机到达各处目标的路径长度，L_go为n*n矩阵
% [L_go,L_go_t]=mypath1(t,S,B,U);
L_go=zeros(n+1,n+1);
L_go_t=zeros(n+1,n+1);
 for i=1:length(S.x(:,1))
        for j=1:length(S.x(:,1))
            if (L_t(n+1,i)~=1000&&L_t(n+1,j)~=1000)
            if i~=j
             %t=ceil(weight(n+1,i)/U.v);
            [L_go(i,j),L_go_t(i,j)]=new_mypath1(L_t(n+1,i),i,j,S,B,U);
            end
            end

        end
 end
[q,w,place1]=new_mypath2(L_t(n+1,5),5,2,S,B,U);

[q,w,place2]=new_mypath2(L_t(n+1,2),2,1,S,B,U);
place1=ones(40,40)-place1+ones(40,40)-place2;




% %%test set%%%
% L_go=[0 12 inf;12 0 inf;12 12 0];
% L_go_t=[0 5 inf;5 0 inf;5 5 0];
% %%%
%实现对接下来20/S.v的时间单位的预测。
value=max(max(L_go_t));
[row col]=find(value==L_go_t);
L_go_new=L_go_t;
if(value==inf) 
    for i=1:length(row(:,1))
        L_go_new(row(i),col(i))=0;
    end
end
value=max(max(L_go_new));
[row col]=find(value==L_go_new);
for i=1:a
    S=forsee_SB(S,L_go_t(row(1),col(1)),i);
end
write_S(S);
S=S_information(dt+L_go_new(row(1),col(1)));%,length(S.x(:,1)));


L_go_t=L_go_t+L_t;
L_go=L_go+weight;
%%得到各无人机运送目标到边线的路径长度，L_return为n*n矩阵
[L_return,L_return_t]=mypath3(L_go_t,S,B);

%%计算求得weight矩阵
[weight]=L_go+L_return;

L_t=L_return_t+L_t;
for i=1:length(weight(:,1))
    for j=1:length(weight(:,1))
        if(weight(i,j)==inf)
            weight(i,j)=1000;
        end
        if(L_t(i,j)==inf)
            L_t(i,j)=1000;
        end
    end
end
    

end





