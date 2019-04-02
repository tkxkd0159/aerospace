function [ r, g, b ] = get_rgb( x,y,image )

    r = image(y,x,1);
    g = image(y,x,2);
    b = image(y,x,3);

end