clear all
close all
clc

rho = 0.002377; % slugs/ft^3 at sea level
   m = 0.2728; % slugs
   U = 65.62; %ft/sec
   S = 7.5347; %ft^2
   q = (rho*U^2)/2; % slugs/(ft*sec^2)
   I_x = 1.955*10^6; %slug*ft^2
   I_z = 4.2*10^6; %slug*ft^2
   I_xz = 0; %slug*ft^2
   C_lp = -0.38;
   C_lr = 0.086;
   b = 130; %ft , Wingspan
   C_np = -0.0228;
   C_nbeta = 0.096;
   C_nr = -0.107;
   C_ybeta = -0.6;
   C_yphi = 0.344;
   C_ypsi = 0;
   C_lbeta = -0.057;
   C_yRud = 0.171;
   C_nRud = -0.08;
   C_lRud = 0.0131;
   C_yAil = 0;
   C_nAil = -0.01;
   C_lAil = 0.6;
   Rud=pi/180*4;
   Ail=pi/180*4;

%% Lateral Transfer function for Control surface Displacement   
syms s

A_s = [(I_x*s^2)/(S*q*b)-(b*C_lp*s)/(2*U) -(I_xz*s^2)/(S*q*b)-(b*C_lr*s)/(2*U) -C_lbeta;
         -(I_xz*s^2)/(S*q*b)-(b*C_np*s)/(2*U) (I_z*s^2)/(S*q*b)-(b*C_nr*s)/(2*U) -C_nbeta;
         -C_yphi (m*U*s)/(S*q)-C_ypsi (m*U*s)/(S*q)-C_ybeta]; %A(s)
     
R_phi= [C_lRud -(I_xz*s^2)/(S*q*b)-(b*C_lr*s)/(2*U) -C_lbeta;
         C_nRud (I_z*s^2)/(S*q*b)-(b*C_nr*s)/(2*U) -C_nbeta;
         C_yRud (m*U*s)/(S*q)-C_ypsi (m*U*s)/(S*q)-C_ybeta];
     
R_psi= [(I_x*s^2)/(S*q*b)-(b*C_lp*s)/(2*U) C_lRud -C_lbeta;
         -(I_xz*s^2)/(S*q*b)-(b*C_np*s)/(2*U) C_nRud -C_nbeta;
         -C_yphi C_yRud (m*U*s)/(S*q)-C_ybeta];
     
R_beta = [(I_x*s^2)/(S*q*b)-(b*C_lp*s)/(2*U) -(I_xz*s^2)/(S*q*b)-(b*C_lr*s)/(2*U) C_lRud;
         -(I_xz*s^2)/(S*q*b)-(b*C_np*s)/(2*U) (I_z*s^2)/(S*q*b)-(b*C_nr*s)/(2*U) C_nRud;
         -C_yphi (m*U*s)/(S*q)-C_ypsi C_yRud];
     
A_phi= [C_lAil -(I_xz*s^2)/(S*q*b)-(b*C_lr*s)/(2*U) -C_lbeta;
         C_nAil (I_z*s^2)/(S*q*b)-(b*C_nr*s)/(2*U) -C_nbeta;
         C_yAil (m*U*s)/(S*q)-C_ypsi (m*U*s)/(S*q)-C_ybeta];
     
A_psi= [(I_x*s^2)/(S*q*b)-(b*C_lp*s)/(2*U) C_lAil -C_lbeta;
         -(I_xz*s^2)/(S*q*b)-(b*C_np*s)/(2*U) C_nAil -C_nbeta;
         -C_yphi C_yAil (m*U*s)/(S*q)-C_ybeta];
     
A_beta = [(I_x*s^2)/(S*q*b)-(b*C_lp*s)/(2*U) -(I_xz*s^2)/(S*q*b)-(b*C_lr*s)/(2*U) C_lAil;
         -(I_xz*s^2)/(S*q*b)-(b*C_np*s)/(2*U) (I_z*s^2)/(S*q*b)-(b*C_nr*s)/(2*U) C_nAil;
         -C_yphi (m*U*s)/(S*q)-C_ypsi C_yAil];

     
Del_s = det(A_s);
D_rphi = det(R_phi);
D_rpsi = det(R_psi);
D_rbeta = det(R_beta);
D_aphi = det(A_phi);
D_apsi = det(A_psi);
D_abeta = det(A_beta);


y1 = D_rphi/Del_s;
y2 = D_rpsi/Del_s;
y3 = D_rbeta/Del_s;
y4 = D_aphi/Del_s;
y5 = D_apsi/Del_s;
y6 = D_abeta/Del_s;

s=logspace(-3,3,1000);
news= complex(0,s);

phi_r = abs(subs(y1,news));
psi_r = abs(subs(y2,news));
beta_r = abs(subs(y3,news));

phi_a = abs(subs(y4,news));
psi_a = abs(subs(y5,news));
beta_a = abs(subs(y6,news));
 

%----------------Rudder TF plot--------------%
figure()

loglog(s,phi_r)
grid on
title('Lateral Transfer Functions for Rudder Displacement') 
xlabel('w(rad/sec)')
ylabel('$\displaystyle\frac{\phi}{\delta_{r}}$ Amplitude ratio','interpreter','latex')
xlim([0.001 100])
ylim([0.001 1000])

figure()

loglog(s,psi_r)
grid on
title('Lateral Transfer Functions for Rudder Displacement') 
xlabel('w(rad/sec)')
ylabel('$\displaystyle\frac{\psi}{\delta_{r}}$ Amplitude ratio','interpreter','latex')
xlim([0.001 100])
ylim([0.001 100000])

figure()

loglog(s,beta_r)

grid on
title('Lateral Transfer Functions for Rudder Displacement') 
xlabel('w(rad/sec)')
ylabel('$\displaystyle\frac{\beta}{\delta_{r}}$ Amplitude ratio','interpreter','latex')
xlim([0.01 1000])
ylim([0.0001 10])
%----------------Aileron TF plot--------------%
figure()

loglog(s,phi_a)
grid on
title('Lateral Transfer Functions for Aileron Displacement') 
xlabel('w(rad/sec)')
ylabel('$\displaystyle\frac{\phi}{\delta_{a}}$ Amplitude ratio','interpreter','latex')
xlim([0.01 1000])
ylim([0.001 1000])

figure()

loglog(s,psi_a)
grid on
title('Lateral Transfer Functions for Aileron Displacement') 
xlabel('w(rad/sec)')
ylabel('$\displaystyle\frac{\psi}{\delta_{a}}$ Amplitude ratio','interpreter','latex')
xlim([0.01 100])
ylim([0.001 10000])

figure()

loglog(s,beta_a)
grid on
title('Lateral Transfer Functions for Aileron Displacement') 
xlabel('w(rad/sec)')
ylabel('$\displaystyle\frac{\beta}{\delta_{a}}$ Amplitude ratio','interpreter','latex')
xlim([0.001 100])
ylim([0.0001 100])



