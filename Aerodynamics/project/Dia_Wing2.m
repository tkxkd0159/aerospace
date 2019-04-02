function [Cl, M2, M3, M4, M5] = Dia_Wing2(theta, M1, AOA, gamma, R)

%----- Section 2-----------------------------------------------------------
M2 = M1;
p2_p1 = 1;
%----- Section 3-----------------------------------------------------------
theta3 = 2*theta;
[ M3,T3_T2,p3_p2 ] = prandtl_meyer(M2,gamma,theta3 );

p3_p1=p3_p2*p2_p1;
    
%----- Section 4-----------------------------------------------------------
theta4 = theta+AOA;

[beta4, Mn1_4] = oblique_relations(M1, theta4, gamma);

[ Mn4,p4_p1,rho4_rho1,T4_T1,p04_p01,p04_p1 ] = NSP( gamma,R,Mn1_4 );

beta4 = beta4*180/pi;
M4 = Mn4/sind(beta4-theta4);


%----- Section 5-----------------------------------------------------------
theta5 = 2*theta;
 [ M5,T5_T4,p5_p4 ] = prandtl_meyer(M4,gamma,theta5 );

 p5_p1 = p5_p4*p4_p1;

%--------------------------------------------------------------------------
%  Calculate the Lift coefficiens 
%--------------------------------------------------------------------------
l_c=1/(2*cosd(theta));

Cl = (2/(gamma*(M1^2)))*(l_c)*((p4_p1-p3_p1)*cosd(theta+AOA)+(p5_p1-p2_p1)*cosd(theta-AOA));
end
