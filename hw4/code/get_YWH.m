function [Y,W,H,img2,img_noisy] = get_YWH()
    tic;
    img1 = imread('../data/peppers256.png');
    img1 = double(img1);
    patch_size = 7;
    n = patch_size^2;
    [m1,n1] = size(img1);
    N = (m1-patch_size+1)*(n1-patch_size+1);
%     r = floor(min(n,N)/2);
    K = 80;
%     X = zeros(n,N);
    Y = zeros(n,N);
    img2 = img1/max(max(img1));
    img2 = 100*img2;
    img_noisy = poissrnd(img2);
    Ni = 0;
    for row=1:m1 - patch_size + 1
        for col=1:n1 - patch_size + 1
           Ni = Ni+1;
           patch_i = img_noisy(row:row+patch_size - 1,col:col+patch_size - 1);
           patch_vec_i = patch_i(:);
           Y(:,Ni) = patch_vec_i;
%            X(:,Ni) = patch_vec_i; 
        end
    end
%     X = X/max(max(X));
%     X = 100*X;
%     histogram(X);
%     Y = poissrnd(X);
    W = rand(n,K);
    W(W < 0) = 0;
    W = normc(W);
    H = rand(K,N);
    H(H < 0) = 0;
    
    fprintf('get_YWH done\n');
    toc;
end
