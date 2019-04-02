function [T0_T,p0_p,rho0_rho,A_As ] = IFP( gamma,mach)
%Isentropic Flow Properties

T0_T = 1+ ((gamma-1)/2) * mach.^2 ;
p0_p = T0_T.^(gamma/(gamma-1));
rho0_rho = T0_T.^(1/(gamma-1));
A_As = sqrt((1./mach.^2).*(((2/(gamma+1))*T0_T).^((gamma+1)./(gamma-1))));


end

