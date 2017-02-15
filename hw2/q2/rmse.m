function [err] = rmse(A,B)
    A = A(:);
    A = double(A)/255;
    B = B(:);
    B = double(B)/255;
    err = sqrt(sum((A - B).^2));
end
