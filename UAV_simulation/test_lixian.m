clc;
% m=input('请输入无人机的个数');
% n=input('请输入地面目标的个数');
% x0=input('请输入起点的x坐标');
% y0=input('请输入起点的y坐标');
m=2;
n=5;
x0=40;
y0=20;
count=0;
for i=1:n
        S.x(i)=floor(unifrnd(1,40));
        S.y(i)=floor(unifrnd(1,40));
   
end
a=floor(unifrnd(1,6));
b=floor(unifrnd(1,6));
weight=inf.*ones(n+1,n+1);
% %%%%%无向图
% for i=1:n
%     for j=1:n
%         if(i~=j)
%         weight(i,j)=floor(sqrt((S.x(i)-S.x(j))^2+(S.y(i)-S.y(j))^2));
%         weight(j,i)=weight(i,j);
%         end
%         if(weight(i,j)==inf)
%             weight(i,j)=1000;
%         end
%         
%     end
% end
% for i=1:n;
%     weight(n+1,i)=floor(sqrt((S.x(i)-x0)^2+(S.y(i)-y0)^2));
%     if(weight(n+1,i)==inf)
%             weight(n+1,j)=1000;
%     end
%         if(weight(i,n+1)==inf)
%             weight(i,n+1)=1000;
%         end
% end
% %         weight(n+1,n+1)=1000;
% %         weight= [1000          17           8          28 24        1000;
% %           17        1000          20          25   8        1000;
% %            8          20        1000          36 25        1000;
% %           28          25          36        1000  31        1000;
% %           24           8          25          31 1000        1000;
% %           11          21           2          38   25        1000]
% 
%           
%          
%           
%          
%    L_best_final=inf;    
%    L_best_save=inf.*ones(1,11);
%  for i=0:10
%      delta=i;
% [L_best,R_best]=myaco_init(weight,delta);
% L_best_save(i+1)=L_best;
% if(L_best_final>L_best)
%     L_best_final=L_best;
%     R_best_final=R_best;
%     delta_final=delta;
% end
%  end
 
 %%%%有向图
%  for a=1:1000
 for i=1:n
    for j=1:n
        if(i~=j&&i~=a&&j~=a&&i~=b&&j~=b)
        weight(i,j)=floor(unifrnd(1,40));
       
        end
        
    
        if(weight(i,j)==inf)
            weight(i,j)=1000;
        end
        
    end
end
for i=1:n;
    weight(n+1,i)=floor(unifrnd(1,100));
    if(weight(n+1,i)==inf)
            weight(n+1,j)=1000;
    end
        if(weight(i,n+1)==inf)
            weight(i,n+1)=1000;
        end
end
weight(n+1,a)=1000;
weight(n+1,b)=1000;
       weight(n+1,n+1)=1000;         


   L_best_final=inf;    
   L_best_save=inf.*ones(1,11);
%  for i=0:10
     delta=2;
[L_best,R_best]=myaco_init(weight,delta);
[L_best1,R_best1]=myaco_init_ori(weight,delta);
R_best(:,:,1)
L_best
R_best1(:,:,1)
L_best1
if L_best<L_best1
    count=count+1;
end
%  end
% L_best_save(i+1)=L_best;
% if(L_best_final>L_best)
%     L_best_final=L_best;
%     R_best_final=R_best;
%     delta_final=delta;
% end
%  end

    
