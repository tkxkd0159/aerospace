%------------------실행코드--------------------------%
clearvars
clc

n=0;
M1=3;
theta= 5;
gamma=1.4;
R=287; %J/(kg*k) 
[beta, Mn1] = oblique_relations(M1, theta, gamma)