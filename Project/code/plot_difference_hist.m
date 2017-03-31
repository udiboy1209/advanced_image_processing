function [ ] = plot_difference_hist( filename )
%PLOT_DIFFERENCE_HIST Summary of this function goes here
%   Detailed explanation goes here
img = mat2gray(double(imread(filename)));

[M, N] = size(img);

img1 = img + randn(M,N)*0.02;

diff_img = img(:,1:N-1) - img(:,2:N);
diff_img1 = img1(:,1:N-1) - img1(:,2:N);

figure, imhist(img);
figure, imhist(img1);
figure, imhist(diff_img+0.5);
figure, imhist(diff_img1+0.5);

end

