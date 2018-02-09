function out=start1
global count1;
x0=5;
y0=10;
out(1)=x0;
out(2)=y0;
if(count1~=1)
    out(1)=in(1);
     out(2)=in(2);
end
end