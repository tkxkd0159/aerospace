clc
clear all
data = load('Flying_Disk_Magnetometer_X.txt');
N=length(data);
t=0:1/100:(N-1)/100;   

figure(1)
plot(t,data)
xlabel('time(sec)')
ylabel('x axis output')

%Calculate FFT of x[n]
figure(2)
Xk=fft(data(600:1100));
n=0:length(Xk)-1;
stem(n,abs(Xk(n+1)));
xlabel('k'); ylabel('|X_k|');

%Zoom graph to find out dominant cyclic frequency 
n1=50:75;
figure(3)
stem(n1,abs(Xk(51:76)));
xlabel('k'); ylabel('|X_k|')

%--- plot smoothed value using domainant cyclic component k

    k=[56 58 59 60];
    for i=1:length(k)
    for n=600:1100
       
xs (n-599,i)= Xk(1)/N+(2/N)*(real(Xk(k(i)+1))*cos(2*pi*k(i)*n/N)-imag(Xk(k(i)+1))*sin(2*pi*k(i)*n/N));
    end
    end
    xs=sum(xs,2);
    n1=600:1100;
    n=0:length(Xk)-1;
    figure(4)
      plot(n,xs,'Linewidth',2)
    
    hold on
  plot(n,data(n1+1),'--')
   xlabel('time (n)'); ylabel('x[n] and smoothed value xs[n]');
legend('smoothed value xs[n]','x[n]');