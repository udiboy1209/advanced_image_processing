function [u1_vals,u2_vals,I_vals,sigma_vals,mean_vals] = get_skp_one_img(img)
%     u1_val and u2_val are defined for each channel
    % start from upper left corner to get homogenous patches
    % and continue all the way
    color = 1;
    img = img(:,:,color);
    [m,n] = size(img);
    pixels_considered = zeros(m,n);
    pixels_considered = logical(pixels_considered ~= 0);
    u1_vals = [];
    u2_vals = [];
    I_vals = [];
    sigma_vals = [];
    mean_vals = [];
    mean_thresh = 2;
    for row = 1:m
        for col = 1:n
            if (pixels_considered(row,col) == 0)
               ps = 1;
               while (1)
                    img_patch = img(row:row+ps,col:col+ps);
                    mean_s = get_mean_s(img_patch);
                    if (mean_s < mean_thresh)
                        ps = ps + 1;
                    else
                        break;
                    end                    
               end
               ps = ps - 1;
               img_patch = img(row:row+ps,col:col+ps);
               mean_s = get_mean_s(img_patch);
               pixels_considered(row:row+ps,col:col+ps) = 1;
               
               [u1,u2,I,sigma] = get_uI(img_patch,mean_s);
               sigma_vals = [sigma_vals sigma];
               mean_vals = [mean_vals mean_s];
               u1_vals = [u1_vals u1];
               u2_vals = [u2_vals u2];
               I_vals = [I_vals I];
            end 
        end
    end
    lim_y = 10;
    lim_x = 255;
    figure;scatter(I_vals, mean_vals,'.'),title('\sigma^2 vs Intensity');
    xlim([0 lim_x]);
    ylim([0 lim_y]);
    figure;scatter(I_vals, sigma_vals,'.'),title('\mu vs Intensity');
    xlim([0 lim_x]);
    ylim([0 lim_y]);
    figure;scatter(I_vals, u1_vals,'.'),title('\mu^{(1)} vs Intensity');
    xlim([0 lim_x]);
    ylim([0 lim_y]);
    figure;scatter(I_vals, u2_vals,'.'),title('\mu^{(2)} vs Intensity');
    xlim([0 lim_x]);
    ylim([0 lim_y]);
end
