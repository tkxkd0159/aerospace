function y = mypoisson(n,lambda)
% Poisson Random Numbers

y = zeros(1, n);
for i=1:n
    k=0; p=1;
    
    p = p*rand;
    while p >= exp(-lambda)
        k = k+1;
        p = p*rand;        
    end
        y(i)=k;
        
end
end

