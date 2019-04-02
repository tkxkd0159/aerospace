clc
clear all
close all

gamma = 1.4;
R= 287; %J/kg*K
Cp = (gamma*R)/(gamma-1);
sel = input('Isentropic Flow Properties(Enter 1), Normal Shock Properties(Enter 2)');
switch sel
%----------------------------------------------------%
case 1

mach = input('마하수를 입력하세요' );

IFP_T_ratio = 1+ ((gamma-1)/2) * mach.^2
IFP_P_ratio = IFP_T_ratio.^(gamma/(gamma-1))
IFP_d_ratio = IFP_T_ratio.^(1/(gamma-1))
IFP_A_ratio = sqrt((1./mach.^2).*(((2/(gamma+1))*IFP_T_ratio).^((gamma+1)./(gamma-1))))

%----------------------------------------------------%
case 2
    
    while 1
        mach = input('마하수를 입력하세요' );
        if mach >=1
            break
        end
        disp(' 마하수를 1이상으로 입력하세요')
    end

    
mach2= sqrt((1+((gamma-1)/2)*(mach.^2))/(gamma*(mach.^2)-(gamma-1)/2))
NSP_P_ratio = 1+(2*gamma/(gamma+1))*(mach.^2-1)
NSP_d_ratio = ((gamma+1)*mach.^2)./(2+(gamma-1)*mach.^2)
NSP_T_ratio = NSP_P_ratio./NSP_d_ratio
del_s = Cp*log(NSP_T_ratio)-R*log(NSP_P_ratio);
Total_P_ratio = exp((-del_s)./R)
Total_static_P_ratio = (((gamma+1)^2*mach.^2)./(4*gamma*(mach.^2)-2*(gamma-1))).^(gamma/(gamma-1)).*((1-gamma+2*gamma*mach.^2)./(gamma+1))

end

