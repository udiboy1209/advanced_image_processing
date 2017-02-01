function [variance_dist] = all_patch_variance(img)
    [m,n] = size(img);
    k = 0;
    variances = zeros(1,m/8 * n/8);
    for row = 1:8:m-7
        for col = 1:8:n-7
            k = k + 1;
            patch_img = img(row:row+7,col:col+7);
            patch_img = patch_img(:);
%             Can use nfilter also
            variances(k) = var(patch_img);
        end
    end
    variances = variances(1:k);
    figure; histogram(variances);
    variance_dist = histcounts(variances);
    %figure;plot(variance_dist);
%     v2 = histogram(variances);
%     figure;plot(v2);
%     figure; stem(variances);
%     figure; stem(variance_distribution);
    
end
