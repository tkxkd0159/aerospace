
clc
clear all
close all

% Logitude Motion Analysis
%% Data Acquision
m = 0.308; % slugs
U = 65.62; %ft/sec
S = 7.836; %ft^2
c=1.194; % Chord length, ft
Iy=0.0034; %slug*ft^2
rho=0.00237; % slugs/ft^3 at sea level
q=1/2*rho*U^2;


Cxu=-0.195;
Cxa=0.1097;
Cw=-0.073;%
Czu=-1.1;
Cza=-3.905;
Czq=-4.42;
Cmq=-1.94; %
Cmu=0;
Cma=-0.578;
Cz_Ele=-0.8095;
Cm_Ele=0.5236;

 

 
 


 
 
 
 
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
 

 