function  [S,S_visited_flag]=get_visited_flag(t,S,R_rt,R_best)%(S,t)
% n=length(S.x(:,2));
% S_visited_flag=zeros(1,n);
% for i=1:n
%     if(isnan(S.x(i,t))||isnan(S.y(i,t))||isnan(S.v_d(i,t)))
%         S_visited_flag(i)=1;
%         S.x(i,t)=S.x(i,t-1);
%         S.y(i,t)=S.y(i,t-1);
%         S.v_d(i,t)=S.v_d(i,t-1);
%     end
% end
% end
 S_visited_flag=zeros(1,length(S.x(:,1)));

m=length(R_rt(:,1));
n=length(R_rt(1,:));
for i=1:m
    for j=1:n
        if(t>=R_rt(i,j)&&R_rt(i,j)~=0)
            S_visited_flag(R_best(i,j))=1
            if(R_best(i,j)~=length(S.x(:,1))+1)
            %当该点访问过之后，为了还原整个系统，保持前几个访问过的点的信息，
            %要避免访问过的点出现nan的情况，因此假设其按照之前预测的未访问的情况运动
            S.x(R_best(i,j),t)=S.x(R_best(i,j),t-1);
           S.y(R_best(i,j),t)=S.y(R_best(i,j),t-1);
           S.v_d(R_best(i,j),t)=S.v_d(R_best(i,j),t-1);
            end
        end
    end
end

end
