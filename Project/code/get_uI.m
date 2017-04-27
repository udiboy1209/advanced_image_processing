function [u1_val,u2_val,I_val,sigma_s2] = get_uI(img_patch,mean_s)
%     close all;
    
%     figure;
%     imshow(img_patch);
    I_val = mean(mean(img_patch));
    [m,n] = size(img_patch);
    sigma_s2 = 0;
    k = 0;
    for row=1:m-1
        for col=1:n-1
            k = k + 1;
            sigma_s2 = sigma_s2 + (img_patch(row+1,col+1) - img_patch(row,col) - mean_s).^2;
        end
    end
    if(k == 1)
        sigma_s2 = abs(mean_s);
    else
        sigma_s2 = sigma_s2 / (k - 1);
    end
    u1_val = (mean_s + sigma_s2)/2;
    u2_val = (-mean_s + sigma_s2)/2;
end