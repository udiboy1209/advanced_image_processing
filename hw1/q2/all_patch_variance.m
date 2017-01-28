function [variance_distribution] = all_patch_variance(img)
    [m,n] = size(img);
    k = 0;
    variances = zeros(m-7, n-7);
    for row = 1:m-7
        for col = 1:n-7
            k = k + 1;
            patch_img = img(row:row+7,col:col+7);
            patch_img = patch_img(:);
%             Can use nfilter also
            variances(k) = var(patch_img);
        end
    end
    variance_distribution = histogram(variances);
    figure; stem(variances);
    figure; stem(variance_distribution);
    
end