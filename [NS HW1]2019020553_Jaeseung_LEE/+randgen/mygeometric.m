function y = mygeometric(n, p)
% Geometric Random Numbers

u = rand(1, n);
y = floor(abs(log(u)/log(1-p)));
end

