function [ mach2,p2_p1,rho2_rho1,T2_T1,p02_p01,p02_p1 ] = NSP( gamma,R,M1 )
%Normal Shock Properties

if M1 <= 1
    M1=NaN;
end

Cp = (gamma*R)/(gamma-1);
mach2= sqrt((1+((gamma-1)/2)*(M1.^2))/(gamma*(M1.^2)-(gamma-1)/2));
p2_p1 = 1+(2*gamma/(gamma+1))*(M1.^2-1);
rho2_rho1 = ((gamma+1)*M1.^2)./(2+(gamma-1)*M1.^2);
T2_T1 = p2_p1./rho2_rho1;
del_s = Cp*log(T2_T1)-R*log(p2_p1);
p02_p01 = exp((-del_s)./R);
p02_p1 = (((gamma+1)^2*M1.^2)./(4*gamma*(M1.^2)-2*(gamma-1))).^(gamma/(gamma-1)).*((1-gamma+2*gamma*M1.^2)./(gamma+1));


end

