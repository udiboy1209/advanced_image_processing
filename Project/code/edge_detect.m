close all;
% dataset_format = '../data/junction_dataset/image_00/data/%.10d.png';
dataset_format = 'datasets/dataset_cannon/synth_bg_sub/img%d.png';
% dataset_format = 'datasets/own_dataset/canon_images_stable/%.3d.png';

si = 1000;
ei = 2000;
color = 1:3;

% [u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,100:200,750:1050,'full');
% [m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);

[u1_vals,u2_vals,I_vals] = get_skp_from_img(double(imread(sprintf(dataset_format,1))));
[m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);

I_all = repmat(0:255,[3,1])';
u1_all = repmat(m1,[256,1]).*I_all + repmat(c1,[256,1]);
u2_all = repmat(m2,[256,1]).*I_all + repmat(c2,[256,1]);

I_A = get_Ia(u1_all,u2_all,1e-5);

img1 = imread(sprintf(dataset_format,randi([450,650])));
img1_Ia = zeros(size(img1));

[m,n,c] = size(img1);

for i = 1:c
    img1_Ia(:,:,i) = arrayfun(@(v) I_A(v,i), img1(:,:,i));
end
img1 = double(img1);

I_x = zeros(m,n);
I_y = zeros(m,n);

img1_padded_x = padarray(img1,[0,1,0],0,'pre');
img1_padded_y = padarray(img1,[1,0,0],0,'pre');

edge_img = zeros(m,n);
edge_img = logical(edge_img ~= 0);

d_x = img1_padded_x(1:m,1:n,:) - img1;
d_y = img1_padded_y(1:m,1:n,:) - img1;

edge_mask_x = abs(d_x)>img1_Ia;
edge_mask_y = abs(d_y)>img1_Ia;
    

for cidx = 1:numel(color)
    c = color(cidx);
    
%     u1 = m1(c)*img1(:,:,c) + c1(c);
%     u2 = m2(c)*img1(:,:,c) + c2(c);
%     bessel = bsxfun(@besseli,abs(d_x(:,:,c)),2*sqrt(u1.*u2));
% 
%     p = exp(-u1-u2).*(u1./u2).^(d_x(:,:,c)/2).*bessel;
    
    edge_img(edge_mask_x(:,:,c)) = 1;
    edge_img(circshift(edge_mask_x(:,:,c),-1,2)) = 1;
    
%     u1 = m1(c)*img1(:,:,c) + c1(c);
%     u2 = m2(c)*img1(:,:,c) + c2(c);
%     bessel = bsxfun(@besseli,abs(d_y(:,:,c)),2*sqrt(u1.*u2));
% 
%     p = exp(-u1-u2).*(u1./u2).^(d_y(:,:,c)/2).*bessel;
    
    edge_img(edge_mask_y(:,:,c)) = 1;
    edge_img(circshift(edge_mask_y(:,:,c),-1,1)) = 1;
end

canny_edge = zeros(m,n);
canny_edge = logical(canny_edge ~= 0);

for cidx = 1:numel(color)
    c = color(cidx);
    canny_c = edge(img1(:,:,c),'canny');
    canny_edge = canny_edge | canny_c;
end

% edge_colored = repmat(edge_img,[1,1,3]);
edge_colored = logical(zeros(size(img1)) ~= 0);
edge_colored(:,:,1) = edge_img;

img1(edge_colored) = img1(edge_colored)+150;
figure; imshow(uint8(img1),[]);
title('Noisy Image + Highlighted Edges');
figure; imshow(edge_img);
title('Skellam Edge Image');
figure; imshow(canny_edge);
title('Canny Edge Image');

figure, scatter(I_all(:,1),I_A(:,1));

