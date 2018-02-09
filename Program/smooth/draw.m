clear
clc
load smooth1.dat;
% load smooth2.dat;
load x3.dat;
load y3.dat;
smoo1=[x3(4) y3(4);x3(3) y3(3);x3(2) y3(2);x3(1) y3(1)];
save smooth31.dat smoo1 -ASCII;
x=smoo1(:,1);
y=smoo1(:,2);
figure(1)
% axis([23.4 44 23.4 44])
hold on
plot(x,y,'b-')
% figure(2)
% load smooth11.dat
% load smooth12.dat
% load smooth13.dat
% smooth11(1,:)= smooth12(end-1,:);
% smooth12(end,:)= smooth11(2,:);
% smooth12(1,:)=smooth13(end-1,:);
% smooth13(end,:)=smooth12(2,:);
% % smooth14=[x1(5) y1(5);x1(6) y1(6);x_e y_e];
% axis([28 50 28 50])
% hold on
% plot(smooth12(:,1),smooth12(:,2),'b-',smooth11(:,1),smooth11(:,2),'b-',...
%     smooth13(:,1),smooth13(:,2),'b-')

