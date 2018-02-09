function out_flag=judge_flag(x,y)
n=length(x);
a=40;
b=40;
out_flag=ones(1,8);
for i=1:n
    if((x(i)>a)||(x(i)<=0)||(y(i)<=0)||(y(i)>b))
        out_flag(i)=0;
    end
end
end