clear all
clc
%----------------------------------------------------------------%
%-----------Calculate lift coeffcient of Diamond wing------------%
%----------------------------------------------------------------%

theta = input('Input deflected angle of Diamond-wedge (Degree)');             
M1 = input('Input upstream Mach number');                 
AOA = input('Angle of Attack');              

gamma = 1.4;    % Specific heat ratio of standard air
R = 287;  %J/(kg*k)  % Gas constant of standard air   



%-------------------------- Case 1 ---------------------------------------%
% Section 2    Oblique Shock wave        -  Forward,  Upper surface
% Section 3    Expension Wave            -  Backward, Upper surface
% Section 4    Oblique Shock wave        -  Forward, Lower surface
% Section 5    Expension Wave            -  Backward, Lower surface
%-------------------------------------------------------------------------%

if (theta-AOA>0)
    [Cl, M2, M3, M4, M5] = Dia_Wing1(theta, M1, AOA, gamma, R)
  

%-------------------------- Case 2 ---------------------------------------%
% Section 2    Freestream                -  Forward,  Upper surface
% Section 3    Expension Wave            -  Backward, Upper surface
% Section 4    Oblique Shock wave        -  Forward,  Lower surface
% Section 5    Expension Wave            -  Backward, Lower surface
%-------------------------------------------------------------------------%
elseif (theta-AOA==0)
  [Cl, M2, M3, M4, M5] = Dia_Wing2(theta, M1, AOA, gamma, R)

%-------------------------- Case 3 ----------------------------------------
% Section 2    Expension Wave            -  Forward,  Upper surface
% Section 3    Expension Wave            -  Backward, Upper surface
% Section 4    Oblique Shock wave        -  Forward,  Lower surface
% Section 5    Expension Wave            -  Backward, Lower surface
%--------------------------------------------------------------------------

elseif (theta-AOA<0)
  [Cl, M2, M3, M4, M5] = Dia_Wing3(theta, M1, AOA, gamma, R)
end