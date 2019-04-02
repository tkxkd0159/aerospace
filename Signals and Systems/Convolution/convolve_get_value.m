function [r,g,b] = convolve_get_value(x,y, image, kernel,divisor, offset,n)
[ r, g, b ] = get_rgb( x,y,image );
 i=floor(n/2);
r=sum(double(image(y+i:-1:y-i,x+i:-1:x-i,1)).*(kernel));
g=sum(double(image(y+i:-1:y-i,x+i:-1:x-i,2)).*(kernel));
b=sum(double(image(y+i:-1:y-i,x+i:-1:x-i,3)).*(kernel));
r=sum(r)/divisor+offset;
g=sum(g)/divisor+offset;
b=sum(b)/divisor+offset;

end
