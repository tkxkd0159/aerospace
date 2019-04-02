cl_orig=[0 0.0949 0.3005];
cl_cfd_invis=[-5.106628304566846E-004 9.118690021235341E-002 0.289194219367324];
cl_cfd_vis=[-4.110800928526365E-004 6.150279660185540E-002 0.266563688225721];
AOA=[0 5 15];

plot(AOA,cl_orig)
hold on
plot(AOA,cl_cfd_invis)
plot(AOA,cl_cfd_vis)
plot(AOA,(4*AOA*pi/180)/(sqrt(5^2-1)))

xlabel('Angle of attack(¡Æ)')
ylabel('c_{l,\alpha}')
title('Compare c_{l,\alpha} of Diamond airfoil')
legend('shock-expansion theory','CFD inviscid flow','CFD viscous flow','Linearized supersonic flow','Location','northwest')