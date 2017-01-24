function [] = denoising()
    img = imread('./data/barbara256.png');
    img = imresize(img,0.25);
    img = double(img);
    [m,n] = size(img);
    img_noisy = img + randn(m)*10;
    lambda = 1;
    
    A = kron(dctmtx(m),dctmtx(n));
    
    alpha = max(eig(A'*A));
    B = dct2(img_noisy);
    initial_theta = B(:); 
    lambda_cap = lambda * 2 * 100;
    denoised_theta = ista(img_noisy(:),A,lambda_cap, alpha, initial_theta);
    denoised_img = A * denoised_theta;
    denoised_img = reshape(denoised_img,[m,n]);
    figure;
    imshow(uint8(img_noisy));
    figure;
    imshow(uint8(denoised_img));
end