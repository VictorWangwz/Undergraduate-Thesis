function [x,y]=DrawSimpleRoute(R_best,S,U,R_rt)
for i=1:length(R_rt(:,1))
    plot([U.x S.x(R_best(i,2),R_rt(i,2))],[U.y S.y(R_best(i,2),R_rt(i,2))],'-');
    hold on;
end
x=zeros(length(R_rt(:,1)),length(R_rt(1,:))-1);
y=zeros(length(R_rt(:,1)),length(R_rt(1,:))-1);
for i=1:length(R_rt(:,1))
for j=2:length(R_rt(1,:))-1
    if(R_rt(i,j)~=0)
        x1=S.x(R_best(i,j),R_rt(i,j));
        y1=S.y(R_best(i,j),R_rt(i,j));
        x(i,j)=x1;
        y(i,j)=y1;
        if(R_rt(i,j+1)~=0)
        x2=S.x(R_best(i,j+1),R_rt(i,j+1));
        y2=S.y(R_best(i,j+1),R_rt(i,j+1));
        plot([x1 x2],[y1,y2],'-');
        hold on;
        x(i,j+1)=x2;
        y(i,j+1)=y2;
        end
    end
    j=length(R_rt(1,:));
    if(R_rt(i,j)~=0)
    x1=S.x(R_best(i,j),R_rt(i,j));
    y1=S.y(R_best(i,j),R_rt(i,j));
    x(i,j)=x1;
    y(i,j)=y1;
    end
end
end

% %%====================================================================
% % scatter(A(:,1)',A(:,2)',60,'s','red');
% % hold on
% % scatter(B(:,1)',B(:,2)',60,'blue');
% % hold on
% R0=0.5;
% R1=0.5;
% Phi1=-pi/2;
% Phi0=-pi/2;
% 
%     for i=1:N
%        m=R(1,i,1);
%        n=R(1,i,2);
%        plot([A(m,1) B(n,1)],[A(m,2) B(n,2)])
%        %[a,b,c]=DubinsLR(R0,A(m,1),A(m,2),Phi0,R1,B(n,1),B(n,2),Phi1,1);
%        hold on
    end