function [Y,W,H] = get_YWH()
    img1 = imread('../data/peppers256.png');
    patch_size = 7;
    n = patch_size^2;
    [m1,n1] = size(img1);
    N = (m1-patch_size)*(n1-patch_size);
%     r = floor(min(n,N)/2);
    K = 80;
    X = zeros(n,N);
    Ni = 0;
    for row=1:m1 - patch_size
        for col=1:n1 - patch_size
           Ni = Ni+1;
           patch_i = img1(row:row+patch_size - 1,col:col+patch_size - 1);
           patch_vec_i = patch_i(:);
           X(:,Ni) = patch_vec_i; 
        end
    end
    histogram(X);
    Y = poissrnd(X);
    W = rand(n,K);
    H = rand(K,N);
end
