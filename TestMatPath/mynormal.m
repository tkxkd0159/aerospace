function y = mynormal(x, mu, sigma)
% Normal Random Numbers

U = rand(x, 1);
Z = sqrt(-2*sigma^2*(log(1-U)));
U2 = rand(x, 1);
X1 = mu + Z.*cos(2*pi*U2);
X2 = mu + Z.*sin(2*pi*U2);
y = [X1, X2];
end

