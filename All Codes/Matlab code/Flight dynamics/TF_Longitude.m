close all
clear all
clc


%% Airplane Data

theta = 0 ; %rad
m = 0.2728; % slugs
U = 65.62; %ft/sec
S = 7.5347; %ft^2
c=1.148; % Chord Length, ft
Iy=2.62*10^6; % slug*ft^2
rho=0.002377; % slugs/ft^3 at sea level
q=1/2*rho*U^2;

Cxu=-0.088;
Cxa=0.392;
Cw=-0.74;
Czu=-1.48;
Cza=-4.46;
Cza_dot = -1.13;
Czq=-3.94;
Cmu=0; 
Cma=-0.619;
Cma_dot =-3.27 ;
Cmq=-11.4;
Cz_Ele=-0.246;
Cm_Ele=-0.710;


 
%% Characteristic Equation

syms s

A_s1 = [(m*U*s)/(S*q) - Cxu, -Cxa, -Cw*cos(theta) ; 
    -Czu, ((m*U)/(S*q)-(c*Cza_dot)/(2*U))*s - Cza, (-(m*U)/(S*q)-(c*Czq)/(2*U))*s-Cw*sin(theta) ; 
    0, (-(c*Cma_dot)/(2*U)*s-Cma), (Iy/(S*q*c))*s^2 - (c*Cmq*s)/(2*U) ];




del_s1 = det(A_s1); 


ANS1 = solve(del_s1); 


C1_1 = -(ANS1(1) + ANS1(2));
C2_1 = ANS1(1) * ANS1(2);
C3_1 = -(ANS1(3)+ ANS1(4));
C4_1 = ANS1(3) * ANS1(4);

C1_1 = real(C1_1);
C2_1 = real(C2_1);
C3_1 = real(C3_1);
C4_1 = real(C4_1);

C1_1 = double(C1_1);
C2_1 = double(C2_1);
C3_1 = double(C3_1);
C4_1 = double(C4_1);

