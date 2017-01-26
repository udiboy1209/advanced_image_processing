function [] = deblur()
    x = create_random_sparse_vector();
%     x = zeros(1,100);
%     x(8) = 1.4; x(28) = 1.3; x(32) = 1.5;x(68) = 2; x(88) = 1.5;
    h = [1 2 3 4 3 2 1]/16;
    mag_x = norm(x);
    y = conv(x,h) + randn(1,106) * 0.05 * mag_x;

    y = y';
    x = x';
    h = h';
%     h = [h; zeros(93,1)];
    H = convmtx(h,100);
%     H = toeplitz(h);
    lambda = 0.1;
    alpha = max(eig(H'*H));
    
%     x_deblurred = ista(y,H,lambda,alpha,zeros(size(x)));
%     [x_deblurred, J] = ista2(y,H,lambda,alpha,10000);
    [x_deblurred, J] = ista(y,H,lambda,alpha,zeros(size(x))); 
    figure; plot(J);
%     figure;stem(x);
    figure;stem(y);
    figure; 
    subplot(1,2,1);
    stem(x);
    subplot(1,2,2);
    stem(x_deblurred);
    
end