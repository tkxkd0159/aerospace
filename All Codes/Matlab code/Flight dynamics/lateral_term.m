
close all
clear all

%% Aircraft Specification and Control Derivatives
 
   f = waitbar(0,'Start Program');
  
   tic_s = tic;
   t1_s = tic;
   t2_s = tic;
   t3_s = tic;
%% Revision data   
   %g= 32.17405 ft/s2
   rho = 0.002377; % slugs/ft^3 at sea level
 m = 0.386; % slugs ,  1 kg = 0.069 slgus
U = 65; %ft/sec ,  1 ft/s = 0.305 m/s
S = 10.22; %ft^2    1 m^2 = 10.76 ft^2
b = 6.56; %ft , Wingspan,  1 m = 3.28 ft
q = (rho*U^2)/2; % slugs/(ft*sec^2)
   I_x = 0.804; %slug*ft^2 , 1 kg*m^2 = 0.74 slug*ft^2
   I_z = 0.962; %slug*ft^2
   I_xz = 0; %slug*ft^2
   
   C_lp = -0.385;
   C_lr = 0.055;
   C_np = 0.024;
   C_nbeta = 0.071;
   C_nr = -0.053;
   C_ybeta = -0.279; 
   C_yphi = 0.049;  % mg*cos(theta)/Sq
   C_ypsi = 0;   % mg*sin(theta)/Sq
   C_lbeta = -0.0684;
   C_yRud = 0;
   C_nRud = 0;
   C_lRud = 0;
   C_yAil = -0.03;
   C_nAil = -0.011;
   C_lAil = 0.254;
%% Origin data 
rho2 = 0.002377; % slugs/ft^3 at sea level
 m2 = 0.308; % slugs ,  1 kg = 0.069 slgus
U2 = 65; %ft/sec ,  1 ft/s = 0.305 m/s
S2 = 7.86; %ft^2    1 m^2 = 10.76 ft^2
b2 = 6.56; %ft , Wingspan,  1 m = 3.28 ft
q2 = (rho2*U2^2)/2; % slugs/(ft*sec^2)
   I_x2 = 0.401; %slug*ft^2 , 1 kg*m^2 = 0.74 slug*ft^2
   I_z2 = 0.781; %slug*ft^2
   I_xz2 = 0.005; %slug*ft^2
   
   C_lp2 = -0.390;
   C_lr2 = 0.055;
   C_np2 = 0.034;
   C_nbeta2 = 0.035;
   C_nr2 = -0.027;
   C_ybeta2 = -0.141; 
   C_yphi2 = 0.049;  % mg*cos(theta)/Sq
   C_ypsi2 = 0;   % mg*sin(theta)/Sq
   C_lbeta2 = -0.036;
   C_yRud2 = 0;
   C_nRud2 = 0;
   C_lRud2 = 0;
   C_yAil2 = -0.041;
   C_nAil2 = -0.011;
   C_lAil2 = 0.254;
%% State Equation
 %--------------------------------------------------------------------------%     
   A=[C_ybeta C_yphi 0 -(m*U)/(S*q);
       0 0 1 0;
       C_lbeta 0 (b*C_lp)/(2*U) (b*C_lr)/(2*U);
       C_nbeta 0 (b*C_np)/(2*U) (b*C_nr)/(2*U)];
   
   A(1,:)=A(1,:)*(S*q)/(m*U);
   A(3,:)=A(3,:)*(S*q*b)/(I_x);
   A(4,:)=A(4,:)*(S*q*b)/(I_z);
%------- Revision Aileron Input-----------------------------------------------%  
   B1 = [C_yAil; 0; C_lAil; C_nAil];
   B1(1,:)=B1(1,:)*(S*q)/(m*U);
   B1(3,:)=B1(3,:)*(S*q*b)/(I_x);
   B1(4,:)=B1(4,:)*(S*q*b)/(I_z);
 %--------------------------------------------------------------------------%  
   A2=[C_ybeta2 C_yphi2 0 -(m2*U2)/(S2*q2);
       0 0 1 0;
       C_lbeta2 0 (b2*C_lp2)/(2*U2) (b2*C_lr2)/(2*U2);
       C_nbeta2 0 (b2*C_np2)/(2*U2) (b2*C_nr2)/(2*U2)];
   
   A2(1,:)=A2(1,:)*(S2*q2)/(m2*U2);
   A2(3,:)=A2(3,:)*(S2*q2*b2)/(I_x2);
   A2(4,:)=A2(4,:)*(S2*q2*b2)/(I_z2);
  %------- Origin Aileron Input-----------------------------------------------%
   B2 = [C_yAil2; 0; C_lAil2; C_nAil2];
   B2(1,:)=B2(1,:)*(S2*q2)/(m2*U2);
   B2(3,:)=B2(3,:)*(S2*q2*b2)/(I_x2);
   B2(4,:)=B2(4,:)*(S2*q2*b2)/(I_z2);
   
   t1_e = toc(t1_s);
%% Euler Integration
 check = exist ('toc_e','var');
 if check==1 
  waitbar(t1_e/toc_e,f,'Start Euler Integration');
 end
  
  
  
  dt = 0.001;
  t=0:dt:30; % 0초에서 60초까지
  X1 = [0; 0; 0; 0]; % Initial condition when Revision Aileron input
  X2 = [0; 0; 0; 0]; % Initial condition when Origin Rudder input
  
  %---------Aileron-------------------------------------%
  for i = 1: size(t,2)
      
      if t(i) <= 2 && t(i) >=1
          u = 2*pi/180; %rad
      else
          u = 0;
      end
      dX1 = A*X1 + B1*u;
      X1 = X1 + dX1*dt;
      
      dX2 = A2*X2 + B2*u;
      X2 = X2 + dX2*dt;
      
      result1(i,:) = X1';
      result2(i,:) = X2';
  end
  
  input_ail=zeros(1,size(t,2));
  input_ail(find(t==1):find(t==2))=2; %deg
%% Result

%--------Revision---------%
  beta1= result1(:,1)*180/pi; %deg
  phi1= result1(:,2)*180/pi; %deg
  phi_dot1 = result1(:,3)*180/pi; %deg
  psi_dot1 = result1(:,4)*180/pi; %deg
  
%--------Origin---------%  
  beta2= result2(:,1)*180/pi; %deg
  phi2= result2(:,2)*180/pi; %deg
  phi_dot2 = result2(:,3)*180/pi; %deg
  psi_dot2 = result2(:,4)*180/pi; %deg
  
 %-----Obtaining yaw with numerical integration(Aileron Input)-----------% 
   for i = 1:size(t,2)
      if i==1
      psi1(i) = 0;
      psi2(i) = 0;
      else
       psi1(i) = psi1(i-1) + psi_dot1(i)*dt;
       psi2(i) = psi2(i-1) + psi_dot2(i)*dt;
      end
  end


  
  t2_e = toc(t2_s);
%% Plot
check = exist ('toc_e','var');
if check ==1
 waitbar(t2_e/toc_e,f,'Start Plotting');
end

 
 figure(1)
 
subplot(3,1,1)
 plot(t, phi1)
 hold on
 plot(t, phi2)
 
 ylabel('\phi (deg)')
 title('Aileron Deflection(1/2)')
 grid on
 legend('Revision','Origin')
 
 subplot(3,1,2)
 plot(t, phi_dot1)
 hold on
 plot(t, phi_dot2)
 ylabel('$\dot{\phi}$ (deg/sec)','interpreter','latex')
 grid on
 legend('Revision','Origin')
 
 subplot(3,1,3)
 plot(t,psi1)
 hold on
 plot(t, psi2)
 
 legend('Revision','Origin') 
 ylabel('\psi (deg)')
 xlabel('Time(s)')
 grid on

 figure(2)
 
 subplot(3,1,1)
 plot(t, psi_dot1)
 hold on
 plot(t, psi_dot2)
 
 ylabel('$\dot{\psi}$ (deg/sec)','interpreter','latex')
 title('Aileron Deflection(2/2)')
 grid on
 legend('Revision','Origin')
 
 subplot(3,1,2)
 plot(t, beta1)
 hold on
 plot(t, beta2)
 
legend('Revision','Origin') 
 ylabel('\beta (deg)')
 grid on
 
 subplot(3,1,3)
 plot(t,input_ail)
 ylabel('\delta_{a} (deg)')
 xlabel('Time(s)')
 grid on

 
 
 
 t3_e = toc(t3_s);

%% Flight Mode Analysis
check = exist ('toc_e','var');
if check==1
  waitbar(t3_e/toc_e,f,'Start Flight Mode Analysis');
  
end
 syms s

%% Revision (FMA)
 A_s = [(I_x*s^2)/(S*q*b)-(b*C_lp*s)/(2*U) -(I_xz*s^2)/(S*q*b)-(b*C_lr*s)/(2*U) -C_lbeta;
         -(I_xz*s^2)/(S*q*b)-(b*C_np*s)/(2*U) (I_z*s^2)/(S*q*b)-(b*C_nr*s)/(2*U) -C_nbeta;
         -C_yphi (m*U*s)/(S*q)-C_ypsi (m*U*s)/(S*q)-C_ybeta]; %A(s)
     
     vpa(A_s,4) % Variable-precision arithmetic
     
     Del_s = det(A_s); % Determinant of A(s)
     ANS = solve(Del_s); % Solve Characteristic Equation
     ANS = double(ANS);  % Convert to Double format
     roll = ANS(2);
     spiral = ANS(3);
     dutch1 = ANS(4);
     dutch2 = ANS(5);
     
     fprintf('Roll Subsidence = %.4f%+.4fi \n',real(roll),imag(roll));
     fprintf('Spiral Divergence = %.4f%+.4fi \n',real(spiral),imag(spiral));
     fprintf('Dutch Roll Mode = %.4f%+.4fi, %.4f%+.4fi  \n',real(dutch1),imag(dutch1),real(dutch1),imag(dutch2));
%% Origin(FMA)

 A_s2 = [(I_x2*s^2)/(S2*q2*b2)-(b2*C_lp2*s)/(2*U2) -(I_xz2*s^2)/(S2*q2*b2)-(b2*C_lr2*s)/(2*U2) -C_lbeta2;
         -(I_xz2*s^2)/(S2*q2*b2)-(b2*C_np2*s)/(2*U2) (I_z2*s^2)/(S2*q2*b2)-(b2*C_nr2*s)/(2*U2) -C_nbeta2;
         -C_yphi2 (m2*U2*s)/(S2*q2)-C_ypsi2 (m2*U2*s)/(S2*q2)-C_ybeta2]; %A(s)
     
     vpa(A_s2,4) % Variable-precision arithmetic
     
     Del_s2 = det(A_s2); % Determinant of A(s)
     ANS2 = solve(Del_s2); % Solve Characteristic Equation
     ANS2 = double(ANS2);  % Convert to Double format
     roll2 = ANS2(2);
     spiral2 = ANS2(3);
     dutch3 = ANS2(4);
     dutch4 = ANS2(5);
     
     fprintf('Roll Subsidence = %.4f%+.4fi \n',real(roll2),imag(roll2));
     fprintf('Spiral Divergence = %.4f%+.4fi \n',real(spiral2),imag(spiral2));
     fprintf('Dutch Roll Mode = %.4f%+.4fi, %.4f%+.4fi  \n',real(dutch3),imag(dutch3),real(dutch4),imag(dutch4));
  toc_e = toc(tic_s);
     
waitbar(1,f,'Finishing');

close(f)
%% Flight mode plot 


figure()
plot(t(find(t==0):find(t==4)),phi_dot1(find(t==0):find(t==4)))
hold on
grid on
plot(t(find(t==0):find(t==4)),phi_dot2(find(t==0):find(t==4)))

title('Roll Subsidence Mode(Aileron Deflected)')
xlabel('Time(s)')
ylabel('$\dot{\phi}$ (deg/sec)','interpreter','latex')
legend('Revision','Origin')

figure()
plot(t,phi1)
grid on
hold on
plot(t, phi2)

xlabel('Time(s)')
ylabel('\phi(deg)')
title('Spiral mode(Aileron Deflected)')
legend('Revision','Origin')

figure()
plot(t,psi1)
hold on
grid on
plot(t,psi2)

xlabel('Time(s)')
ylabel('\psi(deg)')
title('Spiral mode(Aileron Deflected)')
legend('Revision','Origin')