I = imread('img3.jpg');
I = I(:,:,1);
I = im2double(I);
I = imcomplement(I);

inputDigit = reshape(I,784,1);

result_classify = myNN15(inputDigit);
[val,pos] = max(result_classify);
lblDigit = pos-1
