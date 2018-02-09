function [R_rt]=reach_t(R_best,L_t)
m=length(R_best(:,1,1));
n=length(R_best(1,:,1));
R_rt=[];
for i=1:m
R_rt(i,1)=1;
end
for i=1:m
    for j=2:n
        if(R_best(i,j)~=0)
            R_rt(i,j)=R_rt(i,j-1)+L_t(R_best(i,j-1),R_best(i,j));
        end
    end
end



end