clc;
clear all;
close all;
%--------------------------------------------------------------------------
% Cl Cd Cm compare
%--------------------------------------------------------------------------
data = csvread('CFDXfoilClCdCm.csv',1,0);

aoa = data(:,1);
%% theroy data
   Cl_t=2*pi*(aoa*pi/180);
   Cm_t=(-pi/2)*(aoa*pi/180);
%% CFD data
Cl_cfd = data(:,2); 
Cd_cfd = data(:,3);

Cm_cfd = data(:,6)-Cl_cfd/4; % CFD는 AC기준 Cm이므로 LE 기준으로 변환
%% Xfoil data
Cl_xfoil = data(:,4);
Cd_xfoil = data(:,5); 
Cm_xfoil = data(:,7)-Cl_xfoil/4; %Xfoil은 AC기준 Cm이므로 LE 기준으로 변환
%% Source Panel method data
Cl_s = [0.0103   -0.0007   -0.0171   -0.0348   -0.0516   -0.0663   -0.0785   -0.0878   -0.0943];
Cd_s = [-0.0245   -0.0253   -0.0292   -0.0351   -0.0424   -0.0505   -0.0590   -0.0677   -0.0763];  
Cm_s = [0.0018    0.0383    0.0704    0.0977    0.1207    0.1399    0.1557    0.1685    0.1786];
%% Vortex Panel method data
Cl_v = [-0.0000    0.2403    0.4802    0.7195    0.9577    1.1945    1.4295    1.6625    1.8931];
Cd_v = [0.0011    0.0014    0.0022    0.0036    0.0056    0.0080    0.0110    0.0143    0.0181];
Cm_v = [0.0000   -0.0612   -0.1220   -0.1823   -0.2417   -0.2999   -0.3566   -0.4116   -0.4646];


%% Compare Cl,Cd, Cm each method
figure(1)
plot(aoa, Cl_cfd,'-o');
hold on;
plot(aoa, Cl_xfoil,'-o');
plot(aoa, Cl_s,'-o');
plot(aoa, Cl_v,'-o');
plot(aoa, Cl_t,'-o');
title('Compare C_l');
xlabel('Angle of Attack(\alpha)');
ylabel('C_l');
legend('CFD','Xfoil','Source Panel','Vortex Panel','Theroy','Location','best');
grid on

figure(2)
plot(aoa, Cd_cfd,'-o');
hold on;
plot(aoa, Cd_xfoil,'-o');
plot(aoa, Cd_s,'-o');
plot(aoa, Cd_v,'-o');
title('Compare C_d');
xlabel('Angle of Attack(\alpha)');
ylabel('C_d');
legend('CFD','Xfoil','Source Panel','Vortex Panel');
grid on;

figure(3)
plot(aoa, Cm_cfd,'-o')

hold on
plot(aoa, Cm_xfoil,'-o')
plot(aoa, Cm_s,'-o')
plot(aoa, Cm_v,'-o')

plot(aoa, Cm_t,'-o')

ylabel('C_m');
title('Compare C_m');
xlabel('Angle of Attack(\alpha)');
 legend('CFD','Xfoil','Source Panel','Vortex Panel','Theroy','Location','best');
%--------------------------------------------------------------------------