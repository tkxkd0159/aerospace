
clc
clear all
close all

% Logitude Motion Analysis
%% Data Acquision
  %g= 32.17405 ft/s2

% Revision
m = 0.386; % slugs ,  1 kg = 0.069 slgus
U = 65; %ft/sec ,  1 ft/s = 0.305 m/s
S = 10.22; %ft^2    1 m^2 = 10.76 ft^2 
c=1.64; % Mean Aerodynamic Chord length, ft, 1 m = 3.28 ft
Iy=0.489; %slug*ft^2 , 1 kg*m^2 = 0.74 slug*ft^2
rho=0.00238; % slugs/ft^3 at sea level
q=1/2*rho*U^2;  % 5.0278

%----------------------------------------------------------------------%
% Before

m2 = 0.302; % slugs ,  1 kg = 0.069 slgus
U2 = 65; %ft/sec ,  1 ft/s = 0.305 m/s
S2 = 7.86; %ft^2    1 m^2 = 10.76 ft^2 
c2=1.36; % Mean Aerodynamic Chord length, ft, 1 m = 3.28 ft
Iy2=0.39; %slug*ft^2 , 1 kg*m^2 = 0.74 slug*ft^2
rho2=0.00238; % slugs/ft^3 at sea level
q2=1/2*rho2*U2^2;  % 5.0278

%% Revision
Cxu=0;  %확인 필요  -2Cd-U*Cd_u
Cxa=0.1011;
Cw=-0.05;%  -mg/Sq
Czu=-0.148; %확인 필요   -2Cl-U*Cl_u
Cza=-3.756;
Czq=-4.26;
Cmq=-1.38; %확인 필요
Cmu=0;
Cma=-0.276;
Cz_Ele=-0.329;
Cm_Ele=0.156;

%% Before
 
Cxu2=-0.0012;  %확인 필요  -2Cd-U*Cd_u
Cxa2=0.101;
Cw2=-0.05;%  -mg/Sq
Czu2=-1.51; %확인 필요   -2Cl-U*Cl_u
Cza2=-3.905;
Czq2=-4.42;
Cmq2=-1.94; %확인 필요
Cmu2=0;
Cma2=-0.578;
Cz_Ele2=-0.809;
Cm_Ele2=0.524;


 
 %% state Equation and Euler Intergration
%----------------------Revision--------------------% 
A1 = [(S*q)/(m*U)*Cxu,(S*q)/(m*U)*Cxa,(S*q)/(m*U)*Cw,0;
    (S*q)/(m*U)*Czu,(S*q)/(m*U)*Cza,0,1+((S*q*c)/(2*m*U^2))*Czq;
      0,0,0,1;
    ((S*q*c)/Iy)*Cmu,((S*q*c)/Iy)*Cma,0,((S*q*c*c)/(Iy*2*U))*Cmq];
B1 = [0,(S*q)/(m*U)*Cz_Ele,0,((S*q*c)/Iy)*Cm_Ele]';

dt = 0.001;
t = 0:dt:100; % 0~300초 까지
X1 = [0 0 0 0]'; % 초기화

%----------------------before------------------------------% 
A2 = [(S2*q2)/(m2*U2)*Cxu2,(S2*q2)/(m2*U2)*Cxa2,(S2*q2)/(m2*U2)*Cw2,0;
    (S2*q2)/(m2*U2)*Czu2,(S2*q2)/(m2*U2)*Cza2,0,1+((S2*q2*c2)/(2*m2*U2^2))*Czq2;
      0,0,0,1;
    ((S2*q2*c2)/Iy2)*Cmu2,((S2*q2*c2)/Iy2)*Cma2,0,((S2*q2*c2*c2)/(Iy2*2*U2))*Cmq2];
B2 = [0,(S2*q2)/(m2*U2)*Cz_Ele2,0,((S2*q2*c2)/Iy2)*Cm_Ele2]';

X2 = [0 0 0 0]'; % 초기화

%------------------------------------------------------%


 
for i = 1: size(t,2)
    
    if t(i) <= 2 && t(i) >1 % 1초부터3초까지
        u = 3*pi/(180); % 3도를 radian으로 변화
    else
        u = 0; % 3초이후로는 변화주지 않음
    end
    dX1 = A1*X1 + B1*u;
    X1 = X1 + dX1*dt;
    result1(i, :) = X1';
    
    dX2 = A2*X2 + B2*u;
    X2 = X2 + dX2*dt;
    result2(i, :) = X2';
end

 
a1=result1(:,1); % u/U
b1=(180/pi)*result1(:,2); % AOA variation
c=(180/pi)*result1(:,3);  % Pitch Angle
d1=(180/pi)*result1(:,4); 

a2=result2(:,1); % u/U
b2=(180/pi)*result2(:,2); % AOA variation, initial AOA =0
c2=(180/pi)*result2(:,3);  % Pitch Angle
d2=(180/pi)*result2(:,4); 
 

 
gamma1=c-b1; % Flight Path angle
gamma2=c2-b2;
 
subplot(5,1,1);
plot(t, U+U*a1 ,'r')
grid on
hold on
plot(t, U2+U2*a2 ,'b')
title('Elevator Deflection')
ylabel('U');
legend('Revision','Origin')

 
 
subplot(5,1,2)

plot(t, b1,'r')
 grid on
 hold on
plot(t, b2, 'b')
% ylabel('\alpha(deg)');
ylabel('$\alpha^{\prime}$ (deg/sec)','interpreter','latex') 
legend('Revision','Origin')
 
subplot(5,1,3)
plot(t, c,'r')
grid on
hold on
plot(t,c2,'b')

ylabel('\theta(deg)');
legend('Revision','Origin')
 
 
subplot(5,1,4)
plot(t, d1,'r')
grid on
hold on
plot(t, d2, 'b')

ylabel('$\dot{\theta}$ (deg/sec)','interpreter','latex') 
legend('Revision','Origin')
 
 
subplot(5,1,5)
 plot(t, gamma1,'r')
 xlabel('Time(s)')
grid on
hold on
 plot(t,gamma2, 'b')
ylabel('\gamma(deg)');
legend('Revision','Origin')
 

 