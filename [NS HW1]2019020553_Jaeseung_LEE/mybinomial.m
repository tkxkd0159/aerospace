function y = mybinomial(N, n, p)
% Binomial Random Numbers

y = sum(rand([1,N,n]) <= p, 3);
end

