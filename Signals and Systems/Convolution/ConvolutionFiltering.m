% 2016학년도 1학기 신호 및 시스템 
% 3x3 Convolution Filtering Example
% 2012-04-05, by Sukchang Yun
%n : Filter size
clc
clear all
close all

bar=waitbar(0, 'Data processing...');

orig_image = imread('model.jpg');   % load image

figure
image(orig_image);   % view original image
conv_image = 0;


%% emboss()
% kernel = [-2 -1  0;
%            -1  1  1;
%             0  1  2];
% n= length(kernel);
%  [conv_image] = convolve_value(orig_image, kernel, 1, 0, conv_image, n);
%% emboss5()
%  kernel = [-2 -1 -1 -1 0;
%            -1  -1 -1 0 1;
%              -1  -1  2 1 1;
%             -1 0 1 1 1;
%             0 1 1 1 1];
%  n= length(kernel);
%   [conv_image] = convolve_value(orig_image, kernel, 1, 0, conv_image, n);

%% sharpen()
%     kernel = [-1 -1 -1;
%             -1  9 -1;
%              -1 -1 -1];
%         n=length(kernel);
%   [conv_image] = convolve_value(orig_image, kernel, 1, 0, conv_image, n);
%% sharpen5()
%    kernel = [-1 -1 -1 -1 -1;
%               -1 2 2 2 -1;
%               -1 2 9 2 -1;
%               -1 2 2 2 -1;
%               -1 -1 -1 -1 -1];
%            n=length(kernel);
%    [conv_image] = convolve_value(orig_image, kernel, 9, 0, conv_image, n);
%% sobel_emboss()
  kernel = [-1 -2 -1;
            0  0  0;
             1  2  1];
 n= length(kernel);
  [conv_image] = convolve_value(orig_image, kernel, 1, 0.5, conv_image, n);
%% sobel_emboss()
%  kernel = [0 0 0 0 0;
%             0 -1 -2 -1 0;
%            0 0  0  0 0;
%            0 1  2  1 0;
%              0 0 0 0 0];
%               n= length(kernel);
%  [conv_image] = convolve_value(orig_image, kernel, 1, 0.5, conv_image, n);
% 



%% box_blur()
%   kernel = [1  1  1;
%             1  1  1;
%             1  1  1];
% n= length(kernel);
%  [conv_image] = convolve_value(orig_image, kernel, 9, 0, conv_image, n);
%% box_blur5()
%    kernel = [1 1 1 1 1;
%             1 1 1 1 1;
%              1 1 1 1 1;
%               1 1 1 1 1;
%               1 1 1 1 1];
%  n= length(kernel);
%   [conv_image] = convolve_value(orig_image, kernel, 25, 0, conv_image, n);

figure(2)
image(uint8(conv_image));
close (bar);