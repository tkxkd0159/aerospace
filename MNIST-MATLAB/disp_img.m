clear all; clc
load images
load labels

idx = round(59999*rand(1,10)+1);
lbl = labels([idx]);
for i=1 : 10
    I = images(:,idx(i))';
    img = reshape(I,28,28);
    
    figure
    imshow(img)
end


