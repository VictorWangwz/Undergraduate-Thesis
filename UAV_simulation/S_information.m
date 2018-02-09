function [S]=S_information(t)%S_information初始化t=0时所有地面机器人的位置速度信息(即各个表格的第一列)
% 
% x=xlsread('Sx_information',strcat('A1',':D',num2str(t)));
% S.x=floor(x)';%%S.x/y/v_d为n*（t/2）矩阵，行表示第i个目标，列表示第j个时间点,这里只获取第一列的数据（t=0时）
% y=xlsread('Sy_information',strcat('A1',':D',num2str(t)));
% S.y=ceil(y)';
% S.v=1;%%S.v表示每个目标的速度（恒速）
% v_d=xlsread('Svd_information',strcat('A1',':D',num2str(t)));%strcat('A1',':C',num2str(t))');
% S.v_d=v_d';
% end
if((t~=inf)&&(t~=0))
    load S.mat;
S.x=Y.x(:,1:t);
S.y=Y.y(:,1:t);
S.v_d=Y.v_d(:,1:t);
S.v=Y.v;
end
end