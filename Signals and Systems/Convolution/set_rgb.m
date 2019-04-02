function conv_image = set_rgb( x,y,conv_image,r,g,b )

    conv_image(y,x,1) = uint8(r);
    conv_image(y,x,2) = uint8(g);
    conv_image(y,x,3) = uint8(b);

end