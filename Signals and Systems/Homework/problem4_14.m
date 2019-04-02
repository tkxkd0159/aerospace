% Signal & System problem 4.14

clear all; clc;

% problem 4.14(a)
spd = load('sunspot.txt');
month = 0:395;
avg_num = spd(:,4);
figure(1)
plot(month,avg_num);
grid on;
title('problem 4.14 (a)');
xlabel('Month'); ylabel('Average Number of Sunspots, spd[n]');

% problem 4.14(b)
x = avg_num-(1/396)*sum(avg_num);
Xk = fft(x);
n = 0:395;
figure(2)
stem(n,abs(Xk(n+1)));
title('problem 4.14 (b)');
xlabel('k'); ylabel('|X_k|');

% problem 4.14(c)
n = 0:24;
figure(3)
stem(n,abs(Xk(1:25)));
title('problem 4.14 (c)');
xlabel('k'); ylabel('|Xk|');

% problem 4.14(d)
X = fft(spd(:,4));
n = 0:395;
s = X(1)/396+(2/396)*(real(X(4))*cos(pi*n/66)-imag(X(4))*sin(pi*n/66))+1/396*(real(X(396/2)))*cos(pi*n);
figure(4)
plot(n,s);
grid on;
title('problem 4.14 (d)');
xlabel('Month'); ylabel('Smoothed version of spd[n]');

% problem 4.14(e)
figure(5)
plot(month,avg_num);
hold on
plot(n,s,':');
grid on
title('problem 4.14 (e)');
xlabel('Month'); ylabel('spd[n] and s[n]');
legend('spd[n]','s[n]')
figure(6)
resi=abs(s'-avg_num);
plot(month,resi);
title('error between spd[n] and s[n]')
xlabel('Month'); ylabel('Absoulte value(spd[n]-s[n])');