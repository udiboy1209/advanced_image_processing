function [out_img] = measurement_matrix()
    tic;
    img = double(imread('./data/barbara256.png'));
    [m,n] = size(img);
   
    phi = randn(32,64);
    U = kron(dctmtx(8)',dctmtx(8)');
    A = phi*U;
    
    out_img = zeros(size(img));
    number_mtx = zeros(size(img));
    
    alpha = max(eig(A'*A));
    lambda = 1;
    
    for r = 1:m-7
        for c = 1:n-7
            patch_img = img(r:r+7,c:c+7);
            initial_theta = zeros(size(patch_img(:)));
            number_mtx(r:r+7,c:c+7) = number_mtx(r:r+7,c:c+7) + 1;
            
            y = A*patch_img(:);
            
            denoised_theta = ista(y,A,lambda, alpha, initial_theta);
            denoised_img = U * denoised_theta;
            denoised_img = reshape(denoised_img,[8,8]);
            out_img(r:r+7,c:c+7) = out_img(r:r+7,c:c+7) + denoised_img;
        end
    end
    out_img = out_img./number_mtx;
    
    %diff_avg = mean(img(:)) - mean(out_img(:));
    %out_img = out_img + diff_avg;
    
    figure;
    imshow(uint8(img));
    figure;
    imshow(uint8(out_img));
    toc;
end

