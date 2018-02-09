%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         蚁群算法解决航迹规划问题
%
%  输入: ss包含了蚂蚁初始位置可选点   
%        ee包含了终止位置的所有点；
%  输出：蚁群算法路径         
%  功能：蚁群算法寻找最优路径
%
%                     程序设计：郜晨  日期：2013/1/10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [L_best,R_best]=myaco_init_ori(weight,delta)
NC_max=50;                           %迭代次数

%判断是否有两列及以上的列为1000，如果是，没多一个，则增加一架虚拟无人机
count=0;
for i=1:length(weight(1,:))-1
    temp1=find(weight(:,i)==1000);
    temp2=find(weight(i,:)==1000);
    if(length(temp1)==length(weight(:,1))&&length(temp2)==length(weight(1,:)))
        count=count+1;
    end
    
end
flag=0;
for i=1:length(weight(1,:))-1
    temp1=find(weight(:,i)==1000);
    if(length(temp1)==length(weight(:,1))-1)
        flag=flag+1;
    end  
end

m=2;
if(count~=0)
    m=m+count;
end
if(flag~=0)
    m=m+flag-1;
end

%蚂蚁个数,同uav个数
%%求取weight中值全为inf的个数，
%%当大于2时说明除了一个作为起点外其他的不可驱逐，因此通过增加蚂蚁个数


%%%

Alpha=5;                          
Beta=5;
Delta=delta; %度权值
alph_Jl=1;%Jl损耗系数
alph_Jt=1;%Jt损耗系数
Rho=0.2;
Q=1;
n=size(weight,1);%行数，即目标个数


Eta=1./weight;                       %Eta为启发因子，这里设为距离的倒数
Tau=ones(n,n);                       %Tau为信息素矩阵
NC=1;                                %迭代计数器
R=zeros(m,n,NC_max);                 %各代最佳路线
L=inf.*ones(NC_max,1);               %各代路线的长度


while NC<=NC_max                     %停止条件之一：达到最大迭代次数
%%第一步：将m只蚂蚁放到度为m的起始点处
    for_visited=ones(1,n);%待访问结点
    
    Pk1=zeros(m,n);%度表的顶点维，第k只蚂蚁访问顶点的次序
    Pk2=zeros(m,n);%度表的度维，对应顶点维，第k只蚂蚁访问顶点的度
    Pk3=zeros(m,n);%度表的权重维，记录该点到下一个点的权重
   %寻找每只蚂蚁的路径 
   
   %%生成度禁忌表Degree-based tabu list
D_Tabu=zeros(1,n);
%确定第一个访问的顶点
%randnum=randperm(n+1);
for_visited(1,n)=0;
D_Tabu(n)=m;
% for i=1:n
%     if(i==randnum(1))
%         D_Tabu(i)=m;
%     end
% end
Randpos=[];%rand position随机位置
Randpos=[Randpos,randperm(n-1)];%randperm(nn)生成不大于n_s的随机序列
for i=1:m
%     if(Randpos(i)<randnum(1))
    D_Tabu(Randpos(i))=1;%randpos为随机的大于m的序列，选前m个为蚂蚁的起始位置
%     else
%         D_Tabu(Randpos(i)+1)=1;
%     end
    
end
for i=1:n
    if(D_Tabu(i)==0)
        D_Tabu(i)=2;
    end
end

% D_Tabu_Ori=D_Tabu;


for k=1:m
    
    s1=1;%第k只蚂蚁当前访问的个数
    s2=2;%第k只蚂蚁将要访问第s2个目标
    
    Pk1(k,s1)=n;%初始化，第k只蚂蚁第一个顶点是1
    Pk2(k,s1)=D_Tabu(n);%初始化，第k只蚂蚁第一个顶点的度
    flag=D_Tabu(Pk1(k,s1));
    while(flag>0)%当当前结点的度为0时停止搜索
    %找到蚂蚁k的下一个结点
    [for_visited_pos]=find(for_visited==1);
    P=[];
    %P=zeros(1,n);
    for i=1:length(for_visited_pos)
                    P(i)=(Tau(Pk1(k,s1),for_visited_pos(i))^Alpha)*(Eta(Pk1(k,s1),for_visited_pos(i))^Beta*(D_Tabu(for_visited_pos(i)))^Delta);
                    %（信息素^信息素系数）*（启发因子^启发因子系数）
                    %P(k)为第k个蚂蚁潜在的下一个节点之间的状态转移概率矩阵
    end
    P=P/(sum(P));            %归一化
    %按概率原则选取下一个点
    Select=find(P==max(P));                   %从第八个开始肯定变成1了，为何选这个数？
    next_visit=for_visited_pos(Select(1));
    
    D_Tabu(Pk1(k,s1))=D_Tabu(Pk1(k,s1))-1;%当前结点度减一
    for_visited(next_visit)=0;
    Pk1(k,s2)=next_visit;
    Pk2(k,s2)=D_Tabu(next_visit);
    Pk3(k,s1)=weight(Pk1(k,s1),Pk1(k,s2));
    D_Tabu(Pk1(k,s2))=D_Tabu(Pk1(k,s2))-1;%加入下一个节点后，此节点度减一
    s1=s2;
    s2=s2+1;  
    flag=D_Tabu(Pk1(k,s1));
    end
end
 %当本次目标都访问过得话，使得迭代次数加一。
    Left_forvisit_num=length(find(for_visited==1));
    if (Left_forvisit_num==0)
        %通过变异得到不同的结果
%         L_temp=Pk1;
%         po1=find(Pk1(1,:)~=0);
%     
%         po2=find(Pk2(2,:)~=0);
%       
%         L_temp(1,po1(end))=Pk1(2,po2(end));
%         L_temp(2,po2(end))=Pk1(1,po1(end));
%         Jl_temp=zeros(length(L_temp(:,1)),1);
%        for i=1:length(L_temp(:,1))
%         for j=1:length(L_temp(1,:))-1
%             if(L_temp(i,j+1)~=0)
%             Jl_temp(i)=Jl_temp(i)+weight(L_temp(i,j),L_temp(i,j+1));
%             end
%         end
%        end
%         J_temp=sum(Jl_temp)+max(Jl_temp);
        
    %%计算最佳线路
     
    %计算本次的损耗大小：
    Jl=0;%距离损耗
    for i=1:m
        for j=1:n
            Jl=Jl+Pk3(i,j);
        end
    end
    Jt=0;%时间损耗
    for i=1:m
        Jt=max(Jt,sum(Pk3(i,:)));
    end
    
    J=alph_Jl*Jl+alph_Jt*Jt;
   %存储本次迭代的损耗以及生成路径值
%    if (J<J_temp) 
   L(NC)=J;
%    else
%        L(NC)=J_temp;
%        Pk1=L_temp;
%    end
%     Left_forvisit_num=length(find(for_visited==1));
%      if (Left_forvisit_num~=0)
%          L(NC)=100;
%      end
     
    for i=1:m
        for j=1:n
            R(i,j,NC)=Pk1(i,j);
        end
    end
    
%     %判断本次迭代得到的最优路径是否满足包涵已完成路径的要求。
%     S_visited_temp=get_visited(S_visited_flag,R(:,:,NC));
%     flag=S_visited-S_visited_temp;
%     if(all(flag(:)==0))
   NC=NC+1;
   %%更新信息素  
   Delta_Tau=zeros(n,n);
    for i=1:m
        for j=1:n-1
            if Pk1(i,j+1)~=0
                Delta_Tau(Pk1(i,j),Pk1(i,j+1))=Delta_Tau(Pk1(i,j),Pk1(i,j+1))+Q/Pk3(i,j);
            %Delta_Tau(Tabu(i,j),Tabu(i,j+1))第i只蚂蚁从Tabu(i,j)处到Tabu(i,j+1)处的delta
            else break
            end
        end
    end
    Tau=(1-Rho).*Tau+Delta_Tau;      %更新后的信息素
    end
    
    end
    
    
%     else
%         Delta_Tau=zeros(n,n);
%     for i=1:m
%         for j=1:n-1
%             if Pk1(i,j+1)==0
%                 Delta_Tau(Pk1(i,j),Pk1(i,j+1))=Delta_Tau(Pk1(i,j),Pk1(i,j+1))+Q/Pk3(i,j);
%             %Delta_Tau(Tabu(i,j),Tabu(i,j+1))第i只蚂蚁从Tabu(i,j)处到Tabu(i,j+1)处的delta
%             else break
%             end
%         end
%     end
%     Tau=(1-Rho).*Tau+Delta_Tau;      %更新后的信息素
%     end
   
    
    
    
   
    %%清除各使用位
%     D_Tabu=D_Tabu_Ori;
    


L_best_NC=find(L==min(L));
L_best=L(L_best_NC(1));
R_best=R(:,:,L_best_NC);

end

