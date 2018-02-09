function [U]=U_information(t)%U_information初始时只存U在t=0时的位置信息与速率信息，之后用于保存时时状态

U.x(:,1)=xlsread('Ux_information','A1:A3');
U.y(:,1)=xlsread('Uy_information','A1:A3');
U.v=3;
%U.v_d(:,1)=xlsread('Uvd_inforation','A1:Am');
end