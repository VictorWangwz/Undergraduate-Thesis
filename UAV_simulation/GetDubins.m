clear all;
R0=150;
R1=150;
P=[1030 970];Phi1=pi/2;
G=[0 0];Phi0=pi/3;
[a,b,c]=DubinsRL(R0,G(1),G(2),Phi0,R1,P(1),P(2),Phi1,1);
