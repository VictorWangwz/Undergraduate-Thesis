function weight=adjWeight(weight,S_visited_flag,S_visited)
n=length(S_visited);
for i=2:n
    if(S_visited(i)~=0)
        for j=1:n-1
            weight(S_visited(i),j)= weight(S_visited(i-1),S_visited(i-1))+weight(S_visited(i),j)
        end
        
    end
end

end