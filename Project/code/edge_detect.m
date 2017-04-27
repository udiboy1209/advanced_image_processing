close all;
% dataset_format = '../data/junction_dataset/image_00/data/%.10d.png';
dataset_format = 'datasets/dataset_cannon/synth_bg_sub/img%d.png';

si = 1000;
ei = 2000;
color = 1:3;

% [u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,100:200,750:1050,'full');
% [m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);

img1 = double(imread(sprintf(dataset_format,randi([450,550]))));

[m,n,c] = size(img1);
I_x = zeros(m,n);
I_y = zeros(m,n);

img1_padded_x = padarray(img1,[0,1,0],0,'pre');
img1_padded_y = padarray(img1,[1,0,0],0,'pre');

edge_img = zeros(m,n);
edge_img = logical(edge_img ~= 0);

d_x = img1_padded_x(1:m,1:n,:) - img1;
d_y = img1_padded_y(1:m,1:n,:) - img1;

for cidx = 1:numel(color)
    c = color(cidx);
    
    u1 = m1(c)*img1(:,:,c) + c1(c);
    u2 = m2(c)*img1(:,:,c) + c2(c);
    bessel = bsxfun(@besseli,abs(d_x(:,:,c)),2*sqrt(u1.*u2));

    p = exp(-u1-u2).*(u1./u2).^(d_x(:,:,c)/2).*bessel;
    edge_mask = p < 5e-10;
    
    edge_img(edge_mask) = 1;
    edge_img(circshift(edge_mask,-1,2)) = 1;
    
    u1 = m1(c)*img1(:,:,c) + c1(c);
    u2 = m2(c)*img1(:,:,c) + c2(c);
    bessel = bsxfun(@besseli,abs(d_y(:,:,c)),2*sqrt(u1.*u2));

    p = exp(-u1-u2).*(u1./u2).^(d_y(:,:,c)/2).*bessel;
    edge_mask = p < 5e-10;
    
    edge_img(edge_mask) = 1;
    edge_img(circshift(edge_mask,-1,1)) = 1;
end
% p_thresh = 0.5e-10;
% 
% for row = 2:m-1
%     for col = 2:n-1
%         d_x = img1(row,col+1) - img1(row,col);
%         d_y = img1(row+1,col) - img1(row,col);
%         
%         Ix(row,col) = d_x;
%         Iy(row,col) = d_y;
%         
%         u1 = m1*img1(row,col) + c1;
%         u2 = m2*img1(row,col) + c2;
%         
%         p_x = exp(-u1-u2)*(u1/u2)^(d_x/2)*besseli(abs(d_x),2*sqrt(u1*u2));
%         p_y = exp(-u1-u2)*(u1/u2)^(d_y/2)*besseli(abs(d_y),2*sqrt(u1*u2));        
%         
%         thresh = sqrt(u1 + u2);
%         p_thresh = exp(-u1-u2)*(u1/u2)^(thresh/2)*besseli(abs(thresh),2*sqrt(u1*u2));
%         p_thresh = p_thresh/1000;
%         if (p_x < p_thresh)
%             edge_img(row,col) = 1;
%         end
%         if (p_y < p_thresh)
%             edge_img(row,col) = 1;
%         end
%     end
% end

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
figure; imshow(edge_img);
title('Skellam Edge Image');
figure; imshow(canny_edge);
title('Canny Edge Image');



