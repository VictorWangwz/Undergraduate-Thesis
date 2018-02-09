function  S_visited=get_visited(S_visited_flag,R_best)
S_visited=R_best;
n=length(R_best(1,:));
m=length(R_best(:,1));
for i=1:m
    for j=1:n
        temp1=S_visited(i,j);
        if(temp1~=0)
        temp2=S_visited_flag(temp1);
        if(temp2==0)
            S_visited(i,j)=0;
        end
        end
    end
end

end