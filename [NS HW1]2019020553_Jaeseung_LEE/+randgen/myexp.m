function y = myexp(x, lambda)
% Exponential Random Numbers

U = rand(x, 1);
y = -log(1-U)/lambda;
end

