clearvars
close all

import randgen.*

Totals = 10000; % The number of generated random numbers(each distribution)
NumBins = 51;

% Binomial Random Numbers
figure('Name','Binomial distribution')
n = 20;
p = 0.5;
binorm_out = mybinomial(Totals, n, p);
binorm_out2 = binornd(n, p, 1, Totals);

histogram(binorm_out, NumBins, 'Normalization', 'probability');
hold on
histogram(binorm_out2, NumBins, "Normalization", 'probability');

title(['Binomial Random Numbers / n = ', num2str(n), ', p = ', num2str(p)])
legend('manual', 'Matlab Built-in')
hold off

% Geometric Random Numbers
figure('Name','Geometric distribution')

p2 = 0.5;
geo_out = mygeometric(Totals, p2);
histogram(geo_out, NumBins, 'Normalization', 'probability');
hold on

geo_out2 = geornd(p2, 1, Totals);
histogram(geo_out2, NumBins, 'Normalization', 'probability');
title(['Geometric Random Numbers / p = ', num2str(p2)])
legend('manual', 'Matlab Built-in')
hold off

% Poisson Random Numbers
figure('Name','Poisson distribution')
lambda2 = 5;
poi_out = mypoisson(Totals, lambda2);
histogram(poi_out, NumBins, 'Normalization', 'probability');

hold on
poi_out2 = poissrnd(5, 1, Totals);
histogram(poi_out2, NumBins, 'Normalization', 'probability');

title(['Poisson Random Numbers / \lambda = ', num2str(lambda2)])
legend('manual', 'Matlab Built-in')
hold off
 
% Uniform Random Numbers
figure('Name','Uniform distribution')
a = 10;
b = 15;
uni_out = myuniform(Totals, a, b);
histogram(uni_out, NumBins, 'Normalization', 'probability');
hold on

uni_out2 = unifrnd(a, b, 1, Totals);
histogram(uni_out2, NumBins, 'Normalization', 'probability');

title(['Uniform Random Numbers / start = ',num2str(a) ,', end = ', num2str(b)])
legend('manual', 'Matlab Built-in')
hold off

% Normal Random Numbers
figure('Name','Normal distribution')
mu = 10;
sigma = 2;
norm_out = mynormal(Totals, mu, sigma);
histogram(norm_out, NumBins, 'Normalization', 'probability');

hold on
norm_out2 = normrnd(mu, sigma, 1, Totals);
histogram(norm_out2, NumBins, 'Normalization', 'probability');

title(['Normal Random Numbers / \mu = ', num2str(mu), ', \sigma = ', num2str(sigma)])
legend('manual', 'Matlab Built-in')
hold off


% Exponential Random Numbers
figure('Name','Exponential distribution')
lambda = 5;
exp_out = myexp(Totals, lambda);
histogram(exp_out, NumBins, 'Normalization', 'probability');
hold on

exp_out2 = exprnd(1/lambda, 1, Totals);
histogram(exp_out2, NumBins, 'Normalization','probability');

title(['Exponential Random Numbers / \lambda = ', num2str(lambda)])
legend('manual', 'Matlab Built-in')
hold off








