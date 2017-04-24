function [out_img] = down_sample(img)
    down_ratio = 10;
    [m,n,p] = size(img);
    out_img = img(1:down_ratio:m,1:down_ratio:n,:);
end
