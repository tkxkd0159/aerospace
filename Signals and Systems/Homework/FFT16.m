clear all
clc

for l=1:16
w(l)=exp(-j*2*pi*l/16);
end

disp(' input 16 data point ');
x=input(''); 
tic
if length(x)~=16
    disp('the number of data is not 16');
    x=nan;
    ans=nan;
else
    %------stage #1
    s1=zeros(1,16);
    s1(1)=x(1)+x(9);
    s1(2)=x(1)-x(9);
    s1(3)=x(5)+x(13);
    s1(4)=x(5)-x(13);
    s1(5)=x(3)+x(11);
    s1(6)=x(3)-x(11);
    s1(7)=x(7)+x(15);
    s1(8)=x(7)-x(15);
    s1(9)=x(2)+x(10);
    s1(10)=x(2)-x(10);
    s1(11)=x(6)+x(14);
    s1(12)=x(6)-x(14);
    s1(13)=x(4)+x(12);
    s1(14)=x(4)-x(12);
    s1(15)=x(8)+x(16);
    s1(16)=x(8)-x(16);
    %--------------stage #2
    s2=zeros(1,16);
    for k=1:4:13
        s2(k)=s1(k)+s1(k+2);
    end
    for k=2:4:14
        s2(k)=s1(k)+s1(k+2)*w(4);
    end
    for k=3:4:15
        s2(k)=s1(k-2)-s1(k);
    end
    for k=4:4:16
        s2(k)=s1(k-2)-s1(k)*w(4);
    end
  %------------stage #3
  s3=zeros(1,16);
  for k=1:8:9
      s3(k)=s2(k)+s2(k+4);
  end
for k=2:8:10
    s3(k)=s2(k)+s2(k+4)*w(2);
end
for k=3:8:11
    s3(k)=s2(k)+s2(k+4)*w(4);
end
for k=4:8:12
    s3(k)=s2(k)+s2(k+4)*w(6);
end
for k=5:8:13
    s3(k)=s2(k-4)-s2(k);
end
for k=6:8:14
    s3(k)=s2(k-4)-s2(k)*w(2);
end
for k=7:8:15
    s3(k)=s2(k-4)-s2(k)*w(4);
end
for k=8:8:16
    s3(k)=s2(k-4)-s2(k)*w(6);
end
    %----------------stage #4
    s4(1)=s3(1)+s3(9);
    s4(9)=s3(1)-s3(9);
  
   for k=2:8
    s4(k)=s3(k)+s3(k+8)*w(k-1);
   end
   for k=10:16
       s4(k)=s3(k-8)-s3(k)*w(k-9);
   end

   num=1:16;
   X(num)=s4(num)
  
end
toc
