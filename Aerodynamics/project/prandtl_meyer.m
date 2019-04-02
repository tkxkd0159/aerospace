function [ M2,T2_T1,p2_p1 ] = prandtl_meyer(M1,gamma,theta )
%Prandtl-Meyer Function and Mach angle

if M1 <= 1
    M1=NaN;
end

theta = theta*pi/180;
v1 = sqrt((gamma+1)/(gamma-1)).*atan(sqrt((gamma-1)/(gamma+1).*(M1.^2-1)))-atan(sqrt(M1.^2-1));
mu1 = atan(1./sqrt(M1.^2-1));
v2 = v1 +theta;


f = @(M) sqrt((gamma+1)/(gamma-1)).*atan(sqrt((gamma-1)/(gamma+1).*(M.^2-1)))-atan(sqrt(M.^2-1))-v2;
    
fp = @(M) (M*((gamma + 1)/(gamma - 1))^(1/2)*(gamma - 1))/((((M^2 - 1)*(gamma - 1))/(gamma + 1) + 1)*(gamma + 1)*(((M^2 - 1)*(gamma - 1))/(gamma + 1))^(1/2)) - 1/(M*(M^2 - 1)^(1/2));


epsilon = 10^-9;
xold=M1;
xnew = M1;
err = 1;    

while(err>epsilon)
    xold = xnew;
    xnew = xold - f(xold)./fp(xold);
    err = abs((xnew-xold)/xnew);
end

M2 = xnew;

T2_T1 = (1+(gamma-1)/2*M1.^2)./(1+(gamma-1)/2*M2.^2);
p2_p1 = T2_T1.^(gamma/(gamma-1));
  


end

