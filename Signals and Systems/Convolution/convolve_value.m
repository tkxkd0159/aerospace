function [conv_image] = convolve_value( image, kernel, divisor, offset, conv_image, n)
  j=round(n/2);
for y = j:size(image,1)-2
    for x = j:size(image,2)-2
        [r,g,b] = convolve_get_value(x,y, image, kernel, divisor, offset, n);
        conv_image = set_rgb(x,y,conv_image,r,g,b);        
    end
    waitbar(y/(size(image,1)-3));    
end

end