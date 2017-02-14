function [] = test_omp()
    tic;
    img = imread('./data/barbara256.png');
    phi_mtx = randn(32,64);
    x = double(img);
    x = x/255;
    [m1,n1] = size(x);
    x = x(1:4:m1,1:4:n1);
    [m,n] = size(x);
    
    U = kron(dctmtx(8),dctmtx(8));
    A = phi_mtx * U;
    
    out_img = zeros(size(x));
    number_mtx = zeros(size(x));
    
    lambda = 1;
    alpha = max(eig(A'*A));
    
    for row=1:m-7
        for col=1:n-7
            close all;
            x_i = x(row:row+7,col:col+7);
            number_mtx(row:row+7,col:col+7) = number_mtx(row:row+7,col:col+7) + 1;
            x_i = x_i(:);
            y_i = phi_mtx * x_i;
%             theta_i_reconstructed = ista(y_i,A,lambda,alpha, zeros(size(x_i)),1);   
%             [theta_i_reconstructed,iter] = omp_implement2(y_i,A,1e-3);
            [theta_i_reconstructed] = omp(A,y_i,1e-3);
            
            x_i_reconstructed = U * theta_i_reconstructed;
            x_i_reconstructed = reshape(x_i_reconstructed,8,8);
            out_img(row:row+7, col:col+7) =  out_img(row:row+7, col:col+7) + x_i_reconstructed;

        end
        fprintf('Row : %d \n',row);
    end
    
    out_img = out_img./number_mtx;
    figure; imshow(x,[]);
    figure; imshow(out_img,[]);
    toc;
    
end
