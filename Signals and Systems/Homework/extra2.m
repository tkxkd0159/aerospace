% Signal & System Chapter 4 homework, Extra-2
% Find out frquencies of the signal using FFT and DFT
 
clear all 
clc
close all
 
% load data and plot -------------------------------------------------------------
data = load('IMU_data_rotor.mat');
data=data.IMU_data;
Rrate = data(:,3);
Prate = data(:,4);
Yrate = data(:,5);
Za = data(:,8);
time = 0:1/85:(length(Rrate)-1)*(1/85);
 
figure(1)
subplot(3,1,1); plot(time,Rrate);
xlabel('time (sec)'); ylabel('Rolling rate');
subplot(3,1,2); plot(time,Prate);
xlabel('time (sec)'); ylabel('Pitching rate ');
subplot(3,1,3); plot(time,Yrate);
xlabel('time (sec)'); ylabel('Yawing rate  ');
 
% calculte FFT of x[n], y[n], z[n] (n=85*t) -----------------------------------------------
%  Rolling rate =x[n]
%  Pitching rate =y[n]
%  Yawing rate=z[n]
xn = Rrate(80:32532); 
Xk = fft(xn);
N=length(xn);
n = 0:N-1;
figure(2)
stem(n,abs(Xk(n+1)));
xlabel('k'); ylabel('|X_k|');
 
yn = Prate(80:32532);
Yk = fft(yn);
n = 0:N-1;
figure(3)
stem(n,abs(Yk(n+1)));
xlabel('k'); ylabel('|Y_k|');
 
zn = Yrate(80:32532);
Zk = fft(zn);
n = 0:N-1;
figure(4)
stem(n,abs(Zk(n+1)));
xlabel('k'); ylabel('|Z_k|');
 
% Zoom graph to find out dominant cyclic frequency -------------------------
figure(5)
n1 = 8500:9500;
stem(n1,abs(Xk(8500:9500)));
xlabel('k'); ylabel('|X_k|')
[maxX,xdomk]=max(Xk(1:9500));
 xdomk=xdomk-1; %dominant cyclic component about Roll
figure(6)
n2 = 0:500;
stem(n2,abs(Yk(1:501)));
xlabel('k'); ylabel('|Y_k|');
 [maxY,ydomk]=max(Yk(1:501));
 ydomk=ydomk-1; %dominant cyclic component about Pitch
figure(7)
n3 = 0:200;
stem(n3,abs(Zk(1:201)));
xlabel('k'); ylabel('|Z_k|');
 [maxZ,zdomk]=max(Zk(1:201));
 zdomk=zdomk-1; %dominant cyclic component about Yaw
% plot smoothed value using domainant cyclic component k ------------------------

%---------------------Rolling------------------%

n = 80:32532;

    k=[141 7394 8764];
    for i=1:3
    for n=80:32532
       
xs (n,i)= Xk(1)/N+(2/N)*(real(Xk(k(i)+1))*cos(2*pi*k(i)*n/N)-imag(Xk(k(i)+1))*sin(2*pi*k(i)*n/N));
    end
    end
    xs=sum(xs,2);
figure(8)
plot(n,xs);
hold on
plot(n,xn,':');
hold off
xlabel('time (n)'); ylabel('x[n] and smoothed value xs[n]');
legend('smoothed value xs[n]','x[n]');
k=[141 7394 8764]
omegaR=2*pi*k./N
%---------------Pitching--------------------------------%
k=ydomk;
n = 80:32532;
ys = Yk(1)/N+(2/N)*(real(Yk(k+1))*cos(2*pi*k*n/N)-imag(Yk(k+1))*sin(2*pi*k*n/N));
figure(9)
plot(n,ys);
hold on
plot(n,yn,':');
hold off
xlabel('time (n)'); ylabel('y[n] and smoothed value ys[n]');
legend('smoothed value ys[n]','y[n]');
omegaP=2*pi*k/N

%-------------------------Yawing--------------%
k=zdomk;
n = 80:32532;
zs = Zk(1)/N+(2/N)*(real(Zk(k+1))*cos(2*pi*k*n/N)-imag(Zk(k+1))*sin(2*pi*k*n/N));
figure(10)
plot(n,zs);
hold on
plot(n,zn,':');
hold off
xlabel('time (n)'); ylabel('z[n] and smoothed value zs[n]');
legend('smoothed value zs[n]','z[n]');
omegaY=2*pi*k/N

%--------------Z acceleration-----------%

figure(11)
plot(time,Za)
Zan = Za(80:32532); 
Zak = fft(Zan);

n = 0:N-1;
figure(12)
stem(n,abs(Zak(n+1)));
xlabel('k'); ylabel('|Za_k|');
figure(13)
n4 = 0:100;
stem(n4,abs(Zak(1:101)));
xlabel('k'); ylabel('|Za_k|')
[maxX,zadomk]=max(Zak(1:100));
 zadomk=zadomk-1; %dominant cyclic component about Roll
 
 k=zadomk;
n = 80:32532;
Zas = Zak(1)/N+(2/N)*(real(Yk(k+1))*cos(2*pi*k*n/N)-imag(Yk(k+1))*sin(2*pi*k*n/N));
figure(14)
plot(n,Zas);
hold on
plot(n,Zan,':');
hold off
xlabel('time (n)'); ylabel('Za[n] and smoothed value Zas[n]');
legend('smoothed value Zas[n]','Za[n]');
omegaZa=2*pi*k/N