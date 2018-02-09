clear all;
clc;
N=10;
x=20*rand;
y=20*rand;
for i=1:N-1
    x=[x,20*rand];
    y=[y,20*rand];
end


axis([0 20 0 20]);
for i=1:N
    plot(x(i),y(i),'*');
    text(x(i),y(i),[' ' num2str(i)]);
    hold on;
end
Allow=zeros(N,1);
Weight=zeros(N,N);
for i=1:N
    for j=1:N
        if i==j
            Weight(i,j)=0;
        else
            Weight(i,j)=y(i)+sqrt((x(i)-y(i))^2+y(i)^2);
        end
    end
end
for i=1:N
    Allow=Search_Allow(i,x,y,Allow);
end
s=find(Allow==1);

%e=c{end};
Distances=[];
routes=cell(1,1);%cell
tic
for i=1:10  %1:10是啥作用，多次实验？
    [Shortest_Route,Shortest_Length]=myaco(s,Weight);%s为起始位置，e为目标点
%     Id=find(Shortest_Route==0);
%     Shortest_Route(Id)=[];
%     Distances=[Distances;Shortest_Length];
%     routes=[routes;Shortest_Route];
end
toc
        