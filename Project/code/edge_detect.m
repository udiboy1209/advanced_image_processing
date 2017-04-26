close all;
% dataset_format = '../data/junction_dataset/image_00/data/%.10d.png';
dataset_format = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_dark_slope_change/img%d.png';

si = 1;
ei = 1000;
color = 1;

[u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,100:200,750:1050,'full');
[m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);

% img1 = double(imread(sprintf(dataset_format,83)));
img1 = double(imread(sprintf(dataset_format,3)));
if (size(img1,3) == 3)
    color = 1;
    img1 = img1(:,:,color);
end

[m,n] = size(img1);

img1_pad = padarray(img1,[1,1],'post');
I_x = zeros(size(img1));
I_y = zeros(size(img1));

edge_img = zeros(size(img1));
edge_img = logical(edge_img ~= 0);

% p_thresh = 0.5e-10;
for row = 1:m
    for col = 1:n
        d_x = img1_pad(row,col+1) - img1(row,col);
        d_y = img1_pad(row+1,col) - img1(row,col);
        
        Ix(row,col) = d_x;
        Iy(row,col) = d_y;
        
        u1 = m1*img1(row,col) + c1;
        u2 = m2*img1(row,col) + c2;
        
        p_x = exp(-u1-u2)*(u1/u2)^(d_x/2)*besseli(abs(d_x),2*sqrt(u1*u2));
        p_y = exp(-u1-u2)*(u1/u2)^(d_y/2)*besseli(abs(d_y),2*sqrt(u1*u2));        
        
        thresh = sqrt(u1 + u2);
        p_thresh = exp(-u1-u2)*(u1/u2)^(thresh/2)*besseli(abs(thresh),2*sqrt(u1*u2));
        p_thresh = p_thresh/1000;
        if (p_x < p_thresh)
            edge_img(row,col) = 1;
        end
        if (p_y < p_thresh)
            edge_img(row,col) = 1;
        end
    end
end

canny_edge = edge(img1,'canny');

figure; imshow(img1,[]);
figure; imshow(edge_img,[]);
title('Skellam Edge Image');
figure; imshow(canny_edge,[]);
title('Canny Edge Image');



