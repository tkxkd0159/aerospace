clc;
clear all
close all
%--------------------------------------------------------------------------
coordi=csvread('naca0012.csv');
X=coordi(:,1);
Y=coordi(:,2);

% load('data.mat');

n1=size(X);
n1=n1(1);
n=size(X)-1;
n=n(1);
AOA=input('구하고 싶은 받음각(degree)들 입력 : ');
iteration=length(AOA);
for k=1:iteration
     AOA(k)=2*k-2;

    AOA(k)=AOA(k)*pi/180;

for i=1:n
    x(i)=(X(i,1)+X(i+1,1))/2;
    y(i)=(Y(i,1)+Y(i+1,1))/2;
end

%theta 구하기
for i=1:n     
    dy(i)=Y(i+1)-Y(i);
    dx(i)=X(i+1)-X(i);

    tangent=dy(i)/dx(i);

    if dy(i)>0&&dx(i)>0
       pii=atand(tangent);
    elseif dy(i)>0&&dx(i)<0
        pii=atand(tangent)+180;
    elseif dy(i)<0&&dx(i)<0
       pii=atand(tangent)+180;
    elseif dy(i)<0&&dx(i)>0
        pii=atand(tangent);
    end
    angle(i)=pii*pi/180;
end

%Length
SX = X(2:n1) - X(1:n);
SY = Y(2:n1) - Y(1:n);
S = sqrt(SX.^2 + SY.^2);
SINE = sin(angle);
COSINE = cos(angle);

%적분
for I=1:n
    for J=1:n
        if I==J
            CN1(I,J) = -1;
            CN2(I,J) = 1;
            CT1(I,J) = pi / 2;
            CT2(I,J) = pi / 2;
        else
            XTEMP = x(I) - X(J);
            YTEMP = y(I) - Y(J);
            A = -XTEMP * COSINE(J) - YTEMP * SINE(J);
            B = XTEMP^2 + YTEMP^2;
            TTEMP = angle(I) - angle(J);
            C = sin(TTEMP);
            D = cos(TTEMP);
            E = XTEMP * SINE(J) - YTEMP * COSINE(J);
            F = log(1 + S(J) * (S(J) + 2 * A) / B);
            G = atan2(E * S(J), B + A * S(J));
            TTEMP = TTEMP - angle(J);
            P = XTEMP * sin(TTEMP) + YTEMP * cos(TTEMP);
            Q = XTEMP * cos(TTEMP) - YTEMP * sin(TTEMP);
            CN2(I,J) = D + Q *F / (2 * S(J)) - (A * C + D * E) * G / S(J);
            CN1(I,J) = D * F / 2 + C * G - CN2(I, J);
            CT2(I,J) = C + P *F / (2 * S(J)) + (A * D - C * E) * G / S(J);
            CT1(I,J) = C * F / 2 - D * G - CT2(I, J);
        end
    end
end
AN = [CN1(:, 1), CN1(:, 2:n) + CN2(:, 1:n-1), CN2(:, n); 1, zeros(1, n-1), 1];
AT = [CT1(:, 1), CT1(:, 2:n) + CT2(:, 1:n-1), CT2(:, n)];
RHS = [sin(angle'-AOA(k)); 0];

%감마구하기
gamma = AN \ RHS; % AN : kutta condition
V = cos(angle'-AOA(k)) + AT * gamma;

%cp구하기
for i=1:n
    cp(k,i)=1-V(i)^2;
end




end

%cp plot
for i=1:iteration
    figure(1)
    plot(x,cp(i,:))
    hold on;
    grid on;

    xlabel('x/c')
    ylabel('C_p')
    

        set(gca,'Ydir','rev')
end
legend('AOA0','AOA2','AOA4','AOA6','AOA8','AOA10','AOA12','AOA14','AOA16')
title('Cp data from Vortex Panel method')




