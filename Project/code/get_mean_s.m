function [mean_s] = get_mean_s(img_patch)
%     dx = 1; 
%     dy = 1;
    
    mean_s = 0;
    [m,n] = size(img_patch);
    k = 0;

    if (m == 1 && n == 1)
        mean_s = 0;
    else
        for row=1:m-1
            for col =1:n-1
            k = k + 1;
            mean_s = mean_s + (img_patch(row+1,col+1) - img_patch(row,col));
            end
        end
        mean_s = mean_s/k;
    end
    
end
