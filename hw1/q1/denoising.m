function [out_img] = denoising()
    tic;
    img = imread('./data/barbara256.png');
    img = double(img);
    [m,n] = size(img);
    img_noisy = img + randn(m)*10;
    lambda = .5;
    
    rows = 1:m-7;
    cols = 1:n-7;
    
    patch_size = 8;
    A = kron(dctmtx(patch_size),dctmtx(patch_size));
    alpha = max(eig(A'*A));
    lambda_cap = lambda * 2 * 100;
    out_img = zeros(size(img_noisy));
    number_mtx = zeros(size(img_noisy));
    for r = rows
        for c = cols
            patch_img = img_noisy(r:r+7,c:c+7);
            B = dct2(patch_img);
            initial_theta = zeros(size(B(:)));
            number_mtx(r:r+7,c:c+7) = number_mtx(r:r+7,c:c+7) + 1;
            denoised_theta = ista(patch_img(:),A,lambda_cap, alpha, initial_theta, 10^-5);
            denoised_img = A * denoised_theta;
            denoised_img = reshape(denoised_img,[8,8]);
            out_img(r:r+7,c:c+7) = out_img(r:r+7,c:c+7) + denoised_img;
        end
    end
    out_img = out_img./number_mtx;
    
    diff_avg = mean(img_noisy(:)) - mean(out_img(:));
    out_img = out_img + diff_avg;
    
    figure;
    imshow(uint8(img));
    title('Original image');
    
    figure;
    imshow(uint8(img_noisy));
    title('Noisy image');
    
    figure;
    imshow(uint8(out_img));
    title('Denoised output');
    
    toc;
end