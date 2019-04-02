% Signals & System : Problem 4_10
clear all; clc;
%% 4.10(a)
N = 32;
for n = 0:N-1
    if (n<=31 && n>=1)
        x(n+1) = 1/n;
    elseif (n==0)
        x(n+1) = 1;
    else
        x(n+1) = 0;
    end
end
n = 0:N-1;
Xk = dft(x);
k = n;

figure(1)
subplot(2,1,1)
stem(n,x,'filled');
title('problem 4.10 (a)');
xlabel('n'); ylabel('x[n]');
subplot(2,1,2)
stem(k,abs(Xk),'filled');
xlabel('k'); ylabel('|X_k|');

%% 4.10(b)
N = 32;
for n = 0:N-1
    if (n<=31 && n>=1)
        x(n+1) = 1/n^2;
    elseif (n==0)
        x(n+1) = 1;
    else
        x(n+1) = 0;
    end
end
n = 0:N-1;
Xk = dft(x);
k = n;

figure(2)
subplot(2,1,1)
stem(n,x,'filled');
title('problem 4.10 (b)');
xlabel('n'); ylabel('x[n]');
subplot(2,1,2)
stem(k,abs(Xk),'filled');
xlabel('k'); ylabel('|X_k|');

%% 4.10(c)
N = 32;
for n = 0:N-1
    if (n<=31 && n>=1)
        x(n+1) = 1/factorial(n);
    elseif (n==0)
        x(n+1) = 1;
    else
        x(n+1) = 0;
    end
end
n = 0:N-1;
Xk = dft(x);
k = n;

figure(3)
subplot(2,1,1)
stem(n,x,'filled');
title('problem 4.10 (c)');
xlabel('n'); ylabel('x[n]');
subplot(2,1,2)
stem(k,abs(Xk),'filled');
xlabel('k'); ylabel('|X_k|');