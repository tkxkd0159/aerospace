clear all
t=0;
x = 5 ;
i=1;
startSpot = 0;
interv = 10 ; % considering data size (interv/step +1 = the number of data)
step = 0.1 ; % lowering step has a number of cycles and then acquire more data
while ( t <interv )
    b(i)=sin(t(i))+5;
    plot(t,b)

      if (t(i)-50 < 0)
          startSpot = 0;
          endSpot = 50;
      else
          startSpot = (t(i))-50;
          endSpot = (t(i)+50);
      end
    
      axis([ startSpot,endSpot , 0 , 10 ]);
      grid
      t(i+1) = t(i) + step;
      i=i+1;
      drawnow;
      pause(0.05)
end

%% ¿øº»
% t = 0 ;
% x = 0 ;
% startSpot = 0;
% interv = 1000 ; % considering 1000 samples
% step = 0.1 ; % lowering step has a number of cycles and then acquire more data
% while ( t <interv )
%     b = sin(t)+5;
%     x = [ x, b ];
%     plot(x) ;
%       if ((t/step)-500 < 0)
%           startSpot = 0;
%       else
%           startSpot = (t/step)-500;
%       end
%       axis([ startSpot, (t/step+50), 0 , 10 ]);
%       grid
%       t = t + step;
%       drawnow;
%       pause(0.01)
%   end
%% 
% h = animatedline;
% axis([0 4*pi -1 1])
% x = linspace(0,4*pi,2000);
% 
% for k = 1:length(x)
%     y = sin(x(k));
%     addpoints(h,x(k),y);
%     drawnow
% end


