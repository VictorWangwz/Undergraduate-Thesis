function x=visited_all(Tabu,nn)
x=0;
num=0;
m=size(Tabu,1);
n=size(Tabu,2);
for i=1:m
    for j=1:n
        if Tabu(i,j)~=0
            num=num+1;
        end
    end
end
if num==nn+m-1
    x=1;
end

