function [beta, Mn1] = oblique_relations(M1, theta, gamma)
%Oblique Shock Relations
if M1 <= 1
    M1=NaN;
end
   theta=theta*pi/180;

        f = @(b) (2*cot(b).*(M1.^2.*(sin(b)).^2-1))./(M1.^2.*(gamma + cos(2*b))+2)-tan(theta);
        fp = @(b) (4*M1^2*cos(b)*cot(b)*sin(b))/((gamma + cos(2*b))*M1^2 + 2) - (2*(cot(b)^2 + 1)*(M1^2*sin(b)^2 - 1))/((gamma + cos(2*b))*M1^2 + 2)...
               + (4*M1^2*sin(2*b)*cot(b)*(M1^2*sin(b)^2 - 1))/(M1^2*(gamma + cos(2*b)) + 2)^2;


 

        overmax = ones(size(theta));
       
          
           f1 = @(b) -1*(2*cot(b).*(M1.^2.*(sin(b)).^2-1))./(M1.^2.*(gamma + cos(2*b))+2);
           x = fminbnd(f1,0,pi/2);
           if(theta >= atan(-1*f1(x)))
               overmax = NaN;
           end
        epsilon = 10^-9;
        err=1;
        xold = theta;
        xnew = theta;
        while err > epsilon;
             xold = xnew;
            xnew = xold - f(xold)./fp(xold);
            err=abs((xnew-xold)/xnew);
            
        end
        beta = xnew;
        beta = beta.*overmax;
        Mn1=M1*sin(beta);
        
    end

      