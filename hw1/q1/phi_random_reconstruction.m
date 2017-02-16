function [out_img] = phi_random_reconstruction()
    tic;
    phi_mtx = randn(32,64);
    x = imread('data/barbara256.png');
    x = double(x);
    x = x/255;
    [m,n] = size(x);
    U = kron(dctmtx(8),dctmtx(8));
    A = phi_mtx * U;
    lambda = 1;
    alpha = max(eig(A'*A));
    out_img = zeros(size(x));
    number_mtx = zeros(size(x));
    for row = 1:m-7
        for col = 1:n-7
            x_i = x(row:row+7,col:col+7);
            number_mtx(row:row+7,col:col+7) = number_mtx(row:row+7,col:col+7) + 1;
            x_i = x_i(:);
            y_i = phi_mtx * x_i;
            
            theta_i_reconstructed = ista(y_i,A,lambda,alpha, zeros(size(x_i)),1);
%             
%             theta_i_reconstructed = omp_implement2(y_i,A);
            x_i_reconstructed = U * theta_i_reconstructed;
            x_i_reconstructed = reshape(x_i_reconstructed,8,8);
            out_img(row:row+7, col:col+7) =  out_img(row:row+7, col:col+7) + x_i_reconstructed;
        end
        fprintf('Row : %d \n',row);
    end
    
    out_img = out_img./number_mtx;
    min1 = min(min(out_img(7:end-7,7:end-7)));
    max1 = max(max(out_img(7:end-7,7:end-7)));

    out_img = (out_img - min1)/(max1 -min1);
    out_img = out_img * 255;
        
%     figure; imshow(uint8(x)); title('Original image');
%     figure; imshow(uint8(out_img));('Reconstructed image');
    figure; imshow(x,[]);
    figure; imshow(out_img,[]);

    toc;
end
