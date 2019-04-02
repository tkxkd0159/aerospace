
clc
clear all
close all
coordi=csvread('naca0012.csv');
    X=coordi(:,1);
    Y=coordi(:,2);
    degree=input('구하고 싶은 받음각(degree)들 입력 : ');
    a=pi/180*degree;
    position=[X Y]; 
    N=length(X)-1;
for k=1:length(a)
for i= 1:N
    phi(k,i)=atan2(position(i+1,2)-position(i,2),position(i+1,1)-position(i,1))-a(k); %패널들의 각
    control_p(i,:)=(position(i,:)+position(i+1,:))/2;     % 조정점은 두 노드위치의 중점
end
end
%--------------------------------------------------
x=control_p(:,1);
y=control_p(:,2);

for k=1:length(a)
for i=1:N
    for j=1:N
        if j~=i
            A = -(x(i)-X(j))*cos(phi(k,j)) - (y(i)-Y(j))*sin(phi(k,j));
            B = (x(i)-X(j))^2 + (y(i)-Y(j))^2;
            C = sin(phi(k,i))*cos(phi(k,j)) - cos(phi(k,i))*sin(phi(k,j));
            D = (y(i)-Y(j))*cos(phi(k,i))-(x(i)-X(j))*sin(phi(k, i));
            E = (x(i)-X(j))*sin(phi(k,j))-(y(i)-Y(j))*cos(phi(k,j));
            S = sqrt((X(i+1)-X(i))^2+(Y(i+1)-Y(i))^2);            
            In(i,j,k) = 0.5*C*log((S^2+2*A*S+B)/(B))+((D-A*C)/(E))*(atan((S+A)/E)-atan(A/E));
            Is(i,j,k)=((D-A.*C)./(2*E)).*log((S^2+2*A*S+B)./B)-C.*(atan((S+A)./E)-atan(A./E));
        else
            In(i,j,k)=pi;     % n편미분에 대한 적분
            Is(i,j,k)=0;      % s편미분에 대한 적분
        end        
    end    
end
end

for k=1:length(a)
ram_V2pi=inv(In(:,:,k))*sin(phi(k,:))';         %ram(i)/2*pi*V 
end

for k=1:length(a)
for i=1:N
    V(i,k)=cos(phi(k,i))+sum(ram_V2pi'.*Is(i,:,k));
    Cp(i,k)=1-V(i,k)^2;
end
end
Cp=Cp'
for k=1:length(a)
    plot(x,Cp(k,:));     %익형은 x/c에 따라 cp그래프
    grid on;
    hold on
    set(gca,'Ydir','rev')
    
end
legend('AOA0', 'AOA2','AOA4','AOA6','AOA8','AOA10','AOA12','AOA14','AOA16')
ylabel('C_p')
xlabel('x/c')
title('Cp data from Source Panel method')

