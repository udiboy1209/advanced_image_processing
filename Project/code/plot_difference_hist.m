function [mu_s, sigma_s ] = plot_difference_hist( filename )
%PLOT_DIFFERENCE_HIST Summary of this function goes here
%   Detailed explanation goes here
img = mat2gray(double(imread(filename)));

[M, N] = size(img);

img1 = img + randn(M,N)*0.02;

diff_img = img(:,1:N-1) - img(:,2:N);
diff_img1 = img1(:,1:N-1) - img1(:,2:N);

figure, histogram(img);
figure, histogram(img1);
figure, histogram(diff_img+0.5);
figure, histogram(diff_img1+0.5);


mu_s = mean(diff_img(:));
sigma_s = sqrt(sum(sum((mu_s - diff_img).^2))/(length(diff_img(:))-1));

end

