function [img_final] = get_final_image(img2,img_noisy,Y,W_f,H_f)
    X_new = W_f*H_f;
    [m1,n1] = size(img2);
    patch_size = 7;
    img_f = zeros(size(img2));
    num_matrix = zeros(size(img2));
    k1 = 1;
    for r = 1:m1 - patch_size + 1
        for c = 1:n1 - patch_size + 1
            x_vec = X_new(:,k1);
            k1 = k1 + 1;
            x_mat = reshape(x_vec,patch_size,patch_size);
            img_f(r:r+patch_size - 1,c:c+patch_size - 1) = img_f(r:r+patch_size - 1,c:c+patch_size - 1) + x_mat;
            num_matrix(r:r+patch_size - 1,c:c+patch_size - 1) = num_matrix(r:r+patch_size - 1,c:c+patch_size - 1) + 1;
        end
    end
    
    img_f = img_f./num_matrix;
    img_f = mat2gray(img_f);
    img_final = img_f;
    figure;
    imshow(img2,[]);
    title('Original');
    figure;
    imshow(img_noisy,[]);
    title('Poisson Noise');
    figure;
    imshow(img_final,[]);
    title('Final Image');
    
    p_snr_denoised = psnr(img_f,img2);
    fprintf('P_snr Denoised is %f\n',p_snr_denoised);
    p_snr_noisy = psnr(img_noisy,img2);
    fprintf('P_snr Noisy is %f\n',p_snr_noisy);
end
