
clc
clear all
close all

% Logitude Motion Analysis
%% Data Acquision
  %g= 32.17405 ft/s2
m = 0.318; % slugs ,  1 kg = 0.069 slgus
U = 65; %ft/sec ,  1 ft/s = 0.305 m/s
S = 10.22; %ft^2    1 m^2 = 10.76 ft^2 
c=1.64; % Mean Aerodynamic Chord length, ft, 1 m = 3.28 ft
%c2=1.3579;
Iy=0.489; %slug*ft^2 , 1 kg*m^2 = 0.74 slug*ft^2
rho=0.00238; % slugs/ft^3 at sea level
q=1/2*rho*U^2;  % 5.0278


Cxu=-0.195;  %확인 필요  -2Cd-U*Cd_u
Cxa=0.1011;
Cw=-0.05;%  -mg/Sq
Czu=-1.1; %확인 필요   -2Cl-U*Cl_u
Cza=-3.756;
Czq=-4.26;
Cmq=-1.38; %확인 필요
Cmu=0;
Cma=-0.276;
Cz_Ele=-0.3294;
Cm_Ele=-0.1555;

 

 
 


 
 
 
 
 %% state Equation and Euler Intergration
 
A1 = [(S*q)/(m*U)*Cxu,(S*q)/(m*U)*Cxa,(S*q)/(m*U)*Cw,0;
    (S*q)/(m*U)*Czu,(S*q)/(m*U)*Cza,0,1+((S*q*c)/(2*m*U^2))*Czq;
      0,0,0,1;
    ((S*q*c)/Iy)*Cmu,((S*q*c)/Iy)*Cma,0,((S*q*c*c)/(Iy*2*U))*Cmq];
B1 = [0,(S*q)/(m*U)*Cz_Ele,0,((S*q*c)/Iy)*Cm_Ele]';

dt = 0.001;
t = 0:dt:100; % 0~300초 까지
X1 = [0 0 0 0]'; % 초기화

 
 
 
for i = 1: size(t,2)
    
    if t(i) <= 3 && t(i) >1 % 1초부터3초까지
        u = 3*pi/(180); % 3도를 radian으로 변화
    else
        u = 0; % 3초이후로는 변화주지 않음
    end
    dX1 = A1*X1 + B1*u;
    X1 = X1 + dX1*dt;
    result1(i, :) = X1';
end

 
a1=result1(:,1); % u/U
b1=(180/pi)*result1(:,2); % AOA variation
c=(180/pi)*result1(:,3);  % Pitch Angle
d1=(180/pi)*result1(:,4); 
 

 
gamma1=c-b1; % Flight Path angle

 
subplot(5,1,1);
plot(t, U+U*a1 ,'r')
grid on
title('Elevator Deflection')
ylabel('U');


 
 
subplot(5,1,2)

plot(t, b1,'r')
 grid on
ylabel('\alpha(deg)');
 
 
subplot(5,1,3)
plot(t, c,'r')
grid on;

ylabel('\theta(deg)');
 
 
subplot(5,1,4)
plot(t, d1,'r')
grid on

ylabel('$\dot{\theta}$ (deg/sec)','interpreter','latex') 
 
 
subplot(5,1,5)
 plot(t, gamma1,'r')
 xlabel('Time(s)')
grid on

ylabel('\gamma(deg)');
 

 