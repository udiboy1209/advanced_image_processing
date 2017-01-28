function [out_img] = phi_random_reconstruction()
    tic;
    phi_mtx = randn(32,64);
    x = imread('data/barbara256.png');
    x = double(x);
    [m,n] = size(x);
    U = kron(dctmtx(8),dctmtx(8));
    A = phi_mtx * U;
    lambda = 1;
    alpha = max(eig(A'*A));
    out_img = zeros(size(x));
    number_mtx = zeros(size(x));
    
%     random_img = zeros(size(x));

    for row = 1:m-7
        for col = 1:n-7
            x_i = x(row:row+7,col:col+7);
            number_mtx(row:row+7,col:col+7) = number_mtx(row:row+7,col:col+7) + 1;
            x_i = x_i(:);
            y_i = phi_mtx * x_i;
%             y1 = reshape(y_i,8,8);
%             random_img(row:row+7,col:col+7) = y1;
            theta_i_reconstructed = ista(y_i,A,lambda,alpha, zeros(size(x_i)));
            x_i_reconstructed = U * theta_i_reconstructed;
            x_i_reconstructed = reshape(x_i_reconstructed,8,8);
            out_img(row:row+7, col:col+7) = x_i_reconstructed;
        end
    end
%     random_img = random_img./number_mtx;
    
    out_img = out_img./number_mtx;
    
%     out_img = (out_img - min(out_img(:)))/(max(out_img(:) - min(out_img(:))));
    
    figure; imshow(uint8(x));
    figure; imshow(out_img);
%     figure; imshow(uint8(random_img));
    

    toc;
end
