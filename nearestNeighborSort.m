clear all
def=csvread('C:\Users\JackLee\Desktop\ex.csv');

x=def(:,1);
y=def(:,2);
coord = cat(2,x,y); 
coord = unique(coord,'rows');

x = coord(:,1); 
y = coord(:,2);

N=length(x); 
x_=x(1,1); y_=y(1,1); 
C = []; 
coord_=coord;

for i=1:N-1 
id=any(coord_(:,1:2)~=[x_,y_],2); 
coord_=coord_(id,1:2); 
IDX = knnsearch(coord_,cat(2,x_,y_)); 
temp_=coord_(IDX,:); 
x_=temp_(1,1); 
y_=temp_(1,2); 
C = [C;coord_(IDX,:)]; 
end

X=C(:,1); x=cat(1,x(1,1),X); 
Y=C(:,2); y=cat(1,y(1,1),Y);
plot(x,y)