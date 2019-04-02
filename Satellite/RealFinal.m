
clc 
close all

b = 1; % Initialize Trigger

Trig= input(' 1 : Update Ephemeris , 2 : Maintain Ephemeris '); 
  check = exist ('state1','var');
if check == 1
     if Trig==1
         b= Trig&&state2;
     elseif Trig==2
         b=Trig&&state1;
     end
end
omega_earth = 7.2921151467*10^(-5) ; % rad/sec
mu = 3.986005*10^14 ; % meter^3/sec^2

%% Load data

if b==1 || check==0
    

 
load('Term_Proj_Data.mat');
load('worldmap.mat');

switch Trig

% Satellite Data(Update Ephemeris)
    case 1
a_2(1,:) = PRN7(2,:);
a_2(2,:) = PRN24(2,:);
a_2(3,:) = PRN30(2,:);
a_2(4,:) = PRN31(2,:);

M_0(1,:) = PRN7(3,:);
M_0(2,:) = PRN24(3,:);
M_0(3,:) = PRN30(3,:);
M_0(4,:) = PRN31(3,:);

SMA_sqrt(1,:) =  PRN7(4,:); % square root of Semi-major Axis
SMA_sqrt(2,:) =  PRN24(4,:);
SMA_sqrt(3,:) =  PRN30(4,:);
SMA_sqrt(4,:) =  PRN31(4,:);

del_n(1,:) = PRN7(5,:);
del_n(2,:) = PRN24(5,:);
del_n(3,:) = PRN30(5,:);
del_n(4,:) = PRN31(5,:);

e(1,:) = PRN7(6,:);
e(2,:) = PRN24(6,:);
e(3,:) = PRN30(6,:);
e(4,:) = PRN31(6,:);

w(1,:) = PRN7(7,:);
w(2,:) = PRN24(7,:);
w(3,:) = PRN30(7,:);
w(4,:) = PRN31(7,:);

C_uc(1,:) = PRN7(8,:);
C_uc(2,:) = PRN24(8,:);
C_uc(3,:) = PRN30(8,:);
C_uc(4,:) = PRN31(8,:);

C_us(1,:) = PRN7(9,:);
C_us(2,:) = PRN24(9,:);
C_us(3,:) = PRN30(9,:);
C_us(4,:) = PRN31(9,:);

C_rc(1,:) = PRN7(10,:);
C_rc(2,:) = PRN24(10,:);
C_rc(3,:) = PRN30(10,:);
C_rc(4,:) = PRN31(10,:);

C_rs(1,:) = PRN7(11,:);
C_rs(2,:) = PRN24(11,:);
C_rs(3,:) = PRN30(11,:);
C_rs(4,:) = PRN31(11,:);

i0(1,:) = PRN7(12,:);
i0(2,:) = PRN24(12,:);
i0(3,:) = PRN30(12,:);
i0(4,:) = PRN31(12,:);

IDOT(1,:) = PRN7(13,:);
IDOT(2,:) = PRN24(13,:);
IDOT(3,:) = PRN30(13,:);
IDOT(4,:) = PRN31(13,:);

C_ic(1,:) = PRN7(14,:);
C_ic(2,:) = PRN24(14,:);
C_ic(3,:) = PRN30(14,:);
C_ic(4,:) = PRN31(14,:);

C_is(1,:) = PRN7(15,:);
C_is(2,:) = PRN24(15,:);
C_is(3,:) = PRN30(15,:);
C_is(4,:) = PRN31(15,:);

omega_0(1,:) = PRN7(16,:);
omega_0(2,:) = PRN24(16,:);
omega_0(3,:) = PRN30(16,:);
omega_0(4,:) = PRN31(16,:);

omegadot(1,:) = PRN7(17,:);
omegadot(2,:) = PRN24(17,:);
omegadot(3,:) = PRN30(17,:);
omegadot(4,:) = PRN31(17,:);

t_oe(1,:) = PRN7(18,:);
t_oe(2,:) = PRN24(18,:);
t_oe(3,:) = PRN30(18,:);
t_oe(4,:) = PRN31(18,:);

state1 = 1;
state2 = 0;

% Satellite Data(Maintain Ephemeris)
    case 2
     
a_2 = zeros(4,12);        
 for i=1:12
a_2(1,i) = PRN7(2,1);
a_2(2,i) = PRN24(2,1);
a_2(3,i) = PRN30(2,1);
a_2(4,i) = PRN31(2,1);
 end
 
M_0 = zeros(4,12);
for i=1:12
M_0(1,i) = PRN7(3,1);
M_0(2,i) = PRN24(3,1);
M_0(3,i) = PRN30(3,1);
M_0(4,i) = PRN31(3,1);
end

SMA_sqrt = zeros(4,12);
for i=1:12
SMA_sqrt(1,i) =  PRN7(4,1); % square root of Semi-major Axis
SMA_sqrt(2,i) =  PRN24(4,1);
SMA_sqrt(3,i) =  PRN30(4,1);
SMA_sqrt(4,i) =  PRN31(4,1);
end

del_n = zeros(4,12);
for i=1:12
del_n(1,i) = PRN7(5,1);
del_n(2,i) = PRN24(5,1);
del_n(3,i) = PRN30(5,1);
del_n(4,i) = PRN31(5,1);
end

e = zeros(4,12);
for i=1:12
e(1,i) = PRN7(6,1);
e(2,i) = PRN24(6,1);
e(3,i) = PRN30(6,1);
e(4,i) = PRN31(6,1);
end

w = zeros(4,12);
for i=1:12
w(1,i) = PRN7(7,1);
w(2,i) = PRN24(7,1);
w(3,i) = PRN30(7,1);
w(4,i) = PRN31(7,1);
end

C_uc = zeros(4,12);
for i=1:12
C_uc(1,i) = PRN7(8,1);
C_uc(2,i) = PRN24(8,1);
C_uc(3,i) = PRN30(8,1);
C_uc(4,i) = PRN31(8,1);
end
C_us = zeros(4,12);
for i=1:12
C_us(1,i) = PRN7(9,1);
C_us(2,i) = PRN24(9,1);
C_us(3,i) = PRN30(9,1);
C_us(4,i) = PRN31(9,1);
end

C_rc = zeros(4,12);
for i=1:12
C_rc(1,i) = PRN7(10,1);
C_rc(2,i) = PRN24(10,1);
C_rc(3,i) = PRN30(10,1);
C_rc(4,i) = PRN31(10,1);
end

C_rs = zeros(4,12);
for i=1:12
C_rs(1,i) = PRN7(11,1);
C_rs(2,i) = PRN24(11,1);
C_rs(3,i) = PRN30(11,1);
C_rs(4,i) = PRN31(11,1);
end

i0 = zeros(4,12);
for i=1:12
i0(1,i) = PRN7(12,1);
i0(2,i) = PRN24(12,1);
i0(3,i) = PRN30(12,1);
i0(4,i) = PRN31(12,1);
end

IDOT = zeros(4,12);
for i=1:12
IDOT(1,i) = PRN7(13,1);
IDOT(2,i) = PRN24(13,1);
IDOT(3,i) = PRN30(13,1);
IDOT(4,i) = PRN31(13,1);
end

C_ic = zeros(4,12);
for i=1:12
C_ic(1,i) = PRN7(14,1);
C_ic(2,i) = PRN24(14,1);
C_ic(3,i) = PRN30(14,1);
C_ic(4,i) = PRN31(14,1);
end

C_is = zeros(4,12);
for i=1:12
C_is(1,i) = PRN7(15,1);
C_is(2,i) = PRN24(15,1);
C_is(3,i) = PRN30(15,1);
C_is(4,i) = PRN31(15,1);
end

omega_0 = zeros(4,12);
for i=1:12
omega_0(1,i) = PRN7(16,1);
omega_0(2,i) = PRN24(16,1);
omega_0(3,i) = PRN30(16,1);
omega_0(4,i) = PRN31(16,1);
end

omegadot = zeros(4,12);
for i=1:12
omegadot(1,i) = PRN7(17,1);
omegadot(2,i) = PRN24(17,1);
omegadot(3,i) = PRN30(17,1);
omegadot(4,i) = PRN31(17,1);
end

t_oe = zeros(4,12);
for i=1:12
t_oe(1,i) = PRN7(18,1);
t_oe(2,i) = PRN24(18,1);
t_oe(3,i) = PRN30(18,1);
t_oe(4,i) = PRN31(18,1);
end
state1 = 0;
state2 = 1;
end
end

%% Main code

%-row 1(PRN7) row 2(PRN24)  row 3(PRN30) row 4(PRN31)-%

SMA =  SMA_sqrt.^2;

n0 = sqrt(mu./(SMA.^3)) ; % Computed mean motion (rad/sec)
 n = n0 + del_n;

iter = zeros(1,13);
for i = 1:13
   
    iter(i) = find(time_second==7200*(i-1));
end

 % Time from Ephemeris reference epoch
for i = 1:12   
         
 t_k(:,iter(i):iter(i+1))= time_second(iter(i):iter(i+1))- t_oe(:,i); 
end


 
 %Mean Anomaly 
 for i = 1:12 
     
 M_k(:,iter(i):iter(i+1)) = M_0(:,i) + n(:,i).*t_k(:,iter(i):iter(i+1));

 end
 
 %% Newton-Rahpson method (Eccentric Anomaly)
 
 if b==1 || check==0
 
 E_k = zeros(4,max(iter));    
     
  for i = 1:12
      
       options = optimset('TolX',1e-12);
      
     
      for j = iter(i) : iter(i+1)
          
      E_k01 = M_k(1,j);
      E_k02 = M_k(2,j);
      E_k03 = M_k(3,j);
      E_k04 = M_k(4,j);
      
      fun1 = @(x) x-e(1,i)*sin(x)-M_k(1,j);
      fun2 = @(x) x-e(2,i)*sin(x)-M_k(2,j);
      fun3 = @(x) x-e(3,i)*sin(x)-M_k(3,j);
      fun4 = @(x) x-e(4,i)*sin(x)-M_k(4,j);
      
       [E_k(1,j), ~, ~, ~] = newtonraphson(fun1, E_k01, options);
       [E_k(2,j), ~, ~, ~] = newtonraphson(fun2, E_k02, options);
       [E_k(3,j), ~, ~, ~] = newtonraphson(fun3, E_k03, options);
       [E_k(4,j), ~, ~, ~] = newtonraphson(fun4, E_k04, options);
      end
      
      
  end   
  
 end
  
 %% Main code continue
 
%True Anomaly
 for i = 1:12
     
 v_k(:,iter(i):iter(i+1)) = atan2((sqrt(1-e(:,i).^2).*sin(E_k(:,iter(i):iter(i+1)))),(cos(E_k(:,iter(i):iter(i+1)))-e(:,i)));
 
 end
  
 % Argument of Latitud
 for i = 1:12
     
   phi_k(:,iter(i):iter(i+1)) = v_k(:,iter(i):iter(i+1)) + w(:,i);  
     
     
 end
 
 % Second Harmonic Perturbation
 
 for i = 1:12
     
     del_u(:,iter(i):iter(i+1)) = C_us(:,i).*sin(2*phi_k(:,iter(i):iter(i+1)))+C_uc(:,i).*cos(2*phi_k(:,iter(i):iter(i+1)));
     del_r(:,iter(i):iter(i+1)) = C_rs(:,i).*sin(2*phi_k(:,iter(i):iter(i+1)))+C_rc(:,i).*cos(2*phi_k(:,iter(i):iter(i+1)));
     del_i(:,iter(i):iter(i+1)) = C_is(:,i).*sin(2*phi_k(:,iter(i):iter(i+1)))+C_ic(:,i).*cos(2*phi_k(:,iter(i):iter(i+1)));
     
 end
 
 % Corrected Argument of Latitude
 
     u_k = phi_k + del_u;
   
 % Corrected Radius
 
 for i = 1:12
     
   r_k(:,iter(i):iter(i+1)) = SMA(:,i).*(1-e(:,i).*cos(E_k(:,iter(i):iter(i+1))))+del_r(:,iter(i):iter(i+1));

 end
 
 % Corrected Inclination
 
  for i=1:12
     i_k(:,iter(i):iter(i+1)) = i0(:,i) + del_i(:,iter(i):iter(i+1)) + IDOT(:,i).*t_k(:,iter(i):iter(i+1)); 
  end
  
 % Position in orbital plane
 for i=1:12
 xk_p(:,iter(i):iter(i+1)) = r_k(:,iter(i):iter(i+1)).*cos(u_k(:,iter(i):iter(i+1)));
 yk_p(:,iter(i):iter(i+1)) = r_k(:,iter(i):iter(i+1)).*sin(u_k(:,iter(i):iter(i+1)));
 end
 
 % Corrected Logitude of ascending node
 for i=1:12
 omega_k(:,iter(i):iter(i+1)) = omega_0(:,i)+(omegadot(:,i)-omega_earth).*t_k(:,iter(i):iter(i+1)) - omega_earth*t_oe(:,i);
 end
  for i=1:12
 omega_k_eci(:,iter(i):iter(i+1)) = omega_0(:,i)+(omegadot(:,i)).*t_k(:,iter(i):iter(i+1));
 end
 %% Earth-Centered Earth-Fixed  Coordinate
 
 for i = 1:12
     
 xk(:,iter(i):iter(i+1)) = xk_p(:,iter(i):iter(i+1)).*cos(omega_k(:,iter(i):iter(i+1))) - yk_p(:,iter(i):iter(i+1)).*cos(i_k(:,iter(i):iter(i+1))).*sin(omega_k(:,iter(i):iter(i+1)));
 yk(:,iter(i):iter(i+1)) = xk_p(:,iter(i):iter(i+1)).*sin(omega_k(:,iter(i):iter(i+1))) + yk_p(:,iter(i):iter(i+1)).*cos(i_k(:,iter(i):iter(i+1))).*cos(omega_k(:,iter(i):iter(i+1)));
 zk(:,iter(i):iter(i+1)) = yk_p(:,iter(i):iter(i+1)).*sin(i_k(:,iter(i):iter(i+1)));
 
 end
 %% ECI Coordinate
 
  for i = 1:12
     
 xk_eci(:,iter(i):iter(i+1)) = xk_p(:,iter(i):iter(i+1)).*cos(omega_k_eci(:,iter(i):iter(i+1))) ...
     - yk_p(:,iter(i):iter(i+1)).*cos(i_k(:,iter(i):iter(i+1))).*sin(omega_k_eci(:,iter(i):iter(i+1)));
 yk_eci(:,iter(i):iter(i+1)) = xk_p(:,iter(i):iter(i+1)).*sin(omega_k_eci(:,iter(i):iter(i+1))) ...
     + yk_p(:,iter(i):iter(i+1)).*cos(i_k(:,iter(i):iter(i+1))).*cos(omega_k_eci(:,iter(i):iter(i+1)));
 zk_eci(:,iter(i):iter(i+1)) = yk_p(:,iter(i):iter(i+1)).*sin(i_k(:,iter(i):iter(i+1)));
 
 end
 %% LLH Coordinate
 
for k=1:4
xyz(3*k-2,:) = xk(k,:);
xyz(3*k-1,:) = yk(k,:);
xyz(3*k,:) = zk(k,:);

end

 for k=1:4
     for j=1:size(xk,2)
  llh= xyz2llh(xyz(3*k-2:3*k,j));
  lat1(k,j) = llh(1);
  lon1(k,j) = llh(2);
  height1(k,j) = llh(3);
     end
 end

 llh_7(:,1) = lon1(1,:)';
 llh_7(:,2) = lat1(1,:)';
 llh_7 = sortrows(llh_7,1);
 llh_7(:,1) = llh_7(:,1) + abs(llh_7(1,1));
 
 llh_24(:,1) = lon1(2,:)';
 llh_24(:,2) = lat1(2,:)';
 llh_24 = sortrows(llh_24,1);
 llh_24(:,1) = llh_24(:,1) + abs(llh_24(1,1));
 
 llh_30(:,1) =  lon1(3,:)';
 llh_30(:,2) = lat1(3,:)';
 llh_30 = sortrows(llh_30,1);
 llh_30(:,1) = llh_30(:,1) + abs(llh_30(1,1));
  
 llh_31(:,1) = lon1(4,:)';
 llh_31(:,2) = lat1(4,:)';
 llh_31 = sortrows(llh_31,1);
 llh_31(:,1) = llh_31(:,1) + abs(llh_31(1,1));
 
 %% Select Work
 
 Trig2 = input(' 1: Plot Orginal , 2: Compare(choose only if you select Update Ephemeris) , 3: Error Rate ');
 
 switch Trig2
 
     case 1
 %% ECEF Plot

  figure()
 plot3(xk(1,:),yk(1,:),zk(1,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECEF)')
 legend('PRN7')
 
  figure()
 plot3(xk(2,:),yk(2,:),zk(2,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECEF)')
 legend('PRN24')
 
  figure()
 plot3(xk(3,:),yk(3,:),zk(3,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECEF)')
 legend('PRN30')
 
  figure()
 plot3(xk(4,:),yk(4,:),zk(4,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECEF)')
 legend('PRN31')

 %% ECI Plot

 
  figure()
 plot3(xk_eci(1,:),yk_eci(1,:),zk_eci(1,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
  xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECI)')
 legend('PRN7')
 
  figure()
 plot3(xk_eci(2,:),yk_eci(2,:),zk_eci(2,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
  xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECI)')
 legend('PRN24')
 
  figure()
 plot3(xk_eci(3,:),yk_eci(3,:),zk_eci(3,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
  xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECI)')
 legend('PRN30')
 
  figure()
 plot3(xk_eci(4,:),yk_eci(4,:),zk_eci(4,:),'Marker','square','MarkerIndices',500,'MarkerFaceColor','b')
 
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Satellite Position(ECI)')
 legend('PRN31')
%% LLH plot
 figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
 p=plot(llh_7(:,1)*180/pi,llh_7(:,2)*180/pi,'LineWidth',2,'Marker','square','MarkerIndices',500,'MarkerFaceColor','r');
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
 xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Ground Track(LLH)')
legend(p,'PRN7')
 
 figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
p= plot(llh_24(:,1)*180/pi,llh_24(:,2)*180/pi,'LineWidth',2,'Marker','square','MarkerIndices',500,'MarkerFaceColor','r');
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
  xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Ground Track(LLH)')
legend(p,'PRN24')
 
 figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
p= plot(llh_30(:,1)*180/pi,llh_30(:,2)*180/pi,'LineWidth',2,'Marker','square','MarkerIndices',500,'MarkerFaceColor','r');
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
  xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Ground Track(LLH)')
legend(p,'PRN30')

  figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
 p=plot(llh_31(:,1)*180/pi,llh_31(:,2)*180/pi,'LineWidth',2,'Marker','square','MarkerIndices',500,'MarkerFaceColor','r');
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
  xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Ground Track(LLH)')
 legend(p,'PRN31')

 %% Compare Update Ephemeris VS Maintain Ephemeris
 
   case 2
    load('NOT_Ephe.mat')
    
  figure()
 plot3(xk(1,:),yk(1,:),zk(1,:))
 hold on
 plot3(newxk(1,:),newyk(1,:),newzk(1,:),'--')
 
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN7 Position(ECEF)')
 legend('Update Ephemeris', 'Maintain Ephemeris')
 
  figure()
 plot3(xk(2,:),yk(2,:),zk(2,:))
  hold on
 plot3(newxk(2,:),newyk(2,:),newzk(2,:),'--')
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN24 Position(ECEF)')
legend('Update Ephemeris', 'Maintain Ephemeris')
 
  figure()
 plot3(xk(3,:),yk(3,:),zk(3,:))
  hold on
 plot3(newxk(3,:),newyk(3,:),newzk(3,:),'--')
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN30 Position(ECEF)')
legend('Update Ephemeris', 'Maintain Ephemeris')
 
  figure()
 plot3(xk(4,:),yk(4,:),zk(4,:))
  hold on
 plot3(newxk(4,:),newyk(4,:),newzk(4,:),'--')
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN31 Position(ECEF)')
legend('Update Ephemeris', 'Maintain Ephemeris')

 %% ECI Plot

 
  figure()
 plot3(xk_eci(1,:),yk_eci(1,:),zk_eci(1,:))
  hold on
 plot3(newxk_eci(1,:),newyk_eci(1,:),newzk_eci(1,:),'--')
  xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN7 Position(ECI)')
legend('Update Ephemeris', 'Maintain Ephemeris')
 
  figure()
 plot3(xk_eci(2,:),yk_eci(2,:),zk_eci(2,:))
  hold on
 plot3(newxk_eci(2,:),newyk_eci(2,:),newzk_eci(2,:),'--')
  xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN24 Position(ECI)')
legend('Update Ephemeris', 'Maintain Ephemeris')
 
  figure()
 plot3(xk_eci(3,:),yk_eci(3,:),zk_eci(3,:))
  hold on
 plot3(newxk_eci(3,:),newyk_eci(3,:),newzk_eci(3,:),'--')
  xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN30 Position(ECI)')
legend('Update Ephemeris', 'Maintain Ephemeris')
 
  figure()
 plot3(xk_eci(4,:),yk_eci(4,:),zk_eci(4,:))
  hold on
 plot3(newxk_eci(4,:),newyk_eci(4,:),newzk_eci(4,:),'--')
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 title('Compare PRN31 Position(ECI)')
legend('Update Ephemeris', 'Maintain Ephemeris')
%% LLH plot
 figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
 p1=plot(llh_7(:,1)*180/pi,llh_7(:,2)*180/pi,'LineWidth',2);
 p2=plot(newllh_7(:,1)*180/pi,newllh_7(:,2)*180/pi,'--','LineWidth',2);
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
 xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Compare PRN7 Ground Track(LLH)')
legend([p1 p2],'Update Ephemeris', 'Maintain Ephemeris')
 
 figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
p1=plot(llh_24(:,1)*180/pi,llh_24(:,2)*180/pi,'LineWidth',2);
p2=plot(llh_24(:,1)*180/pi,llh_24(:,2)*180/pi,'--','LineWidth',2);
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
  xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Compare PRN24 Ground Track(LLH)')
legend([p1 p2],'Update Ephemeris', 'Maintain Ephemeris')
 
 figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
p1=plot(llh_30(:,1)*180/pi,llh_30(:,2)*180/pi,'LineWidth',2);
p2=plot(newllh_30(:,1)*180/pi,newllh_30(:,2)*180/pi,'--','LineWidth',2);
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
  xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Compare PRN30 Ground Track(LLH)')
legend([p1 p2],'Update Ephemeris', 'Maintain Ephemeris')

  figure()
 plot(lon, lat)
 xlim([min(lon) 360])
 ylim([min(lat) max(lat)])
 hold on
p1=plot(llh_31(:,1)*180/pi,llh_31(:,2)*180/pi,'LineWidth',2);
p2=plot(newllh_31(:,1)*180/pi,newllh_31(:,2)*180/pi,'--','LineWidth',2);
 xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
 
  xlabel('Longitude (deg)')
 ylabel('Latitude (deg)')

 title('Compare PRN31 Ground Track(LLH)')
legend([p1 p2],'Update Ephemeris', 'Maintain Ephemeris')
 
%% Compare Coordinate data
     case 3
         
         load('NOT_Ephe.mat')
         
del_xk = mean(abs((xk-newxk)),2);
del_yk = mean(abs((yk-newyk)),2);
del_zk = mean(abs((zk-newzk)),2);
del_xk_eci = mean(abs((xk_eci-newxk_eci)),2);
del_yk_eci = mean(abs((yk_eci-newyk_eci)),2);
del_zk_eci = mean(abs((zk_eci-newzk_eci)),2); 

del_llh7 = mean(abs((llh_7-newllh_7)));
del_llh24 = mean(abs((llh_24-newllh_24)));
del_llh30 = mean(abs((llh_30-newllh_30)));
del_llh31 = mean(abs((llh_31-newllh_31)));

         
rate_xk = mean(abs(((xk-newxk)*100)./xk),2);
rate_yk = mean(abs(((yk-newyk)*100)./yk),2);
rate_zk = mean(abs(((zk-newzk)*100)./zk),2);
rate_xk_eci = mean(abs(((xk_eci-newxk_eci)*100)./xk_eci),2);
rate_yk_eci = mean(abs(((yk_eci-newyk_eci)*100)./yk_eci),2);
rate_zk_eci = mean(abs(((zk_eci-newzk_eci)*100)./zk_eci),2);


rate_llh7 = mean(abs(((llh_7-newllh_7)*100)./llh_7),'omitnan');
rate_llh24 = mean(abs(((llh_24-newllh_24)*100)./llh_24),'omitnan');
rate_llh30 = mean(abs(((llh_30-newllh_30)*100)./llh_30),'omitnan');
rate_llh31 = mean(abs(((llh_31-newllh_31)*100)./llh_31),'omitnan');

 end
 