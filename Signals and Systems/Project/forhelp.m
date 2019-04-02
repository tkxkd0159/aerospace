clc
close all
clear all


%%
% c[n] : closing price of a stock
%%

%%------------- Load data---------------------------------------%%
data=csvread('twit1.csv',0,0,[0 0 102 1]);


%---Data order-----------%%

n=data(:,1);   

% --stock price data---%%

c=data(:,2);  


N=length(n);    

%%----Plot Stock Price Data-----------------%%%

figure(1)
plot(c)
xlabel('n(day)')
ylabel('Stock price($)')
title('Stock price(2016/01/04 ~ 2016/05/31)')
grid on


%%--Subtract a ramp charateristic that may exist in the c[n]----%%

for i=1:N
    x(i)=c(i)-c(1)+((c(1)-c(N))/(N-1))*(i-1);   % signal x[n]
end
 
figure(2)
plot(x)
xlabel('n(day)')
ylabel('x[n]')
grid on
title('Subtract a Ramp characteristic from c[n]')

%%---Amplitude Spectrum of x[n]-------------------%%

fftstock=fft(x);   


%%--Dominant cyclic component
dcc=[1 3];
omegaf=2*pi*(dcc)./N;

%%-----frequency corresponds to a period
peri=2*pi./omegaf;

figure(3)
stem(abs(fftstock),'filled')
xlabel('k+1')
ylabel('|X_k|')
grid on
title('Amplitude Spectrum of x[n]')

%%load price data include future real data-------%%%%%
all_data=csvread('twit1.csv',0,1,[0 1 136 1]);
for i=1:N+34
    all_x(i)=all_data(i)-all_data(1)+((all_data(1)-all_data(N+34))/(N+34-1))*(i-1);  
end
%------------------------------------------------------------%%
%----------------------------------
%%---Approximation to x[n] ------------%%

for k=1:2
R(k)=real(fftstock(dcc(k)));
I(k)=imag(fftstock(dcc(k)));
end

for i=1:N
    for k=1:2
    x_hat(i,k)=2/N*(R(k)*cos(2*pi/(N*i)-I(k)*sin(2*pi/N*i)));   
    end
end
 f_x_hat=sum(x_hat,2);
figure(4)
plot(f_x_hat)
hold on
plot(x)
hold off
xlabel('n(day)')
ylabel('x[n] and the approximation to x[n]')
legend('approximation to x[n]','x[n]')
grid on


%%-- Predicted approximation of x[n] and Plot----%%

future_n=N:N+34;


for i=1:N+34
    for k=1:2
    allx_hat(i,k)=2/N*(R(k)*cos(2*pi/N*i)-I(k)*sin(2*pi/N*i));
    end
end
f_x_hat=sum(allx_hat,2);

figure(5)

plot(1:N,all_x(1:N))
hold on

plot(1:N,f_x_hat(1:N))
 plot(future_n,all_x(future_n))
plot(future_n,f_x_hat(future_n))

hold off
xlabel('n(day)')
ylabel('x[n] and the approximation to x[n]')
grid on
legend('x[n]','approximation to x[n]','Future x[n]','Predict approximation to x[n]','Location','best')

title('Predict x[n] and the Approximation to x[n] including predicted future data')

%%---- Smoothed version of c[n] -------------%%

for i=1:N
    c_hat(i)=x_hat(i)+c(1)-((c(1)-c(N))/(N-1))*(i-1); 
end
 
figure(6)

plot(c)
hold on

plot(c_hat)
hold off
xlabel('n(day)')
ylabel('c[n] and the smoothed version of c[n]')
legend('c[n]','smoothed version of c[n]')
grid on


%%----- Predicted Smoothed version of c[n] and Plot--------%%
for i=N:N+34
    c_hat(i)=x_hat(i)+c(1)-((c(1)-c(N))/(N-1))*(i-1);   
end



%--------real data include future data------------%%%%
%--------------------------------------------------------------%%
fftstock2=fft(all_x);   


%%--Dominant cyclic component
dcc2=[2];
omegaf2=2*pi*(dcc2)/(N+34);

%%-----frequency corresponds to a period
peri2=2*pi/omegaf2;
%-----------------------------------------------------------------------%
figure(7)
stem(abs(fftstock2),'filled')
xlabel('k+1')
ylabel('|X_k|')
grid on
title('Amplitude Spectrum of Extend x[n]')


R2=real(fftstock2(dcc2));
I2=imag(fftstock2(dcc2));


for i=1:N+34
    
    x_hat2(i)=2/(N+34)*(R2*cos(2*pi/(N+34)*i)-I2*sin(2*pi/(N+34)*i));    
    
end

for i=1:N+34
    c_hat2(i)=x_hat2(i)+c(1)-((c(1)-all_data(N+34))/(N+34-1))*(i-1); 
end
%-------------------------------------------------------------%
%-----------------------------------------------------------------------%
future_data=csvread('twit1.csv',102,1,[102 1 136 1]);
future_c_hat=c_hat(103:137);

%----------------------------------------------------------%
figure(8)
plot(all_data)
hold on
plot(1:N+34,c_hat2)
plot(future_n,future_c_hat)


hold off
xlabel('n(day)')
ylabel('c[n] and smoothed version of c[n]')
legend('real c[n]','smoothed version of real c[n]','predicted smoothed version of c[n]','Location','best')
title('c[n] and the smoothed version of c[n] include predicted future data')
grid on

%%--Error between real data and predicted data---%%

err=abs((future_data'-future_c_hat))./future_data'*100;

figure(9)
plot(future_n,err)
xlabel('n(day)')
ylabel('Error between real data and predicted data[%]')
grid on
title('Error between real data and predicted data')

%-----------------------------------------------------------------------%


