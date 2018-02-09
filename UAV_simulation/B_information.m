function [B]=B_information(t)%B_information确定的保存每一时刻障碍物的位置信息
x=xlsread('Bx_information',strcat('A1',':C',num2str(t)));
B.x=floor(x)';
y=xlsread('By_information',strcat('A1',':C',num2str(t)));
B.y=ceil(y)';
% B.v=xlsread('Bv_information','A1:S4');
% B.v_d=xlsread('Bvd_information','A1:S4');
end