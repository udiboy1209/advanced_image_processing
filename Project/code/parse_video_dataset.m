function [u1_out,u2_out,I_out] = parse_video_dataset(fileformat,start_idx,end_idx,color, patch_x, patch_y,arg1)
if (nargin == 6)
    arg1 = 'patch';
end


img_start = double(imread(sprintf(fileformat,start_idx)));
img_end = double(imread(sprintf(fileformat,end_idx)));

mean_img = img_start(:,:,color);
mean_diff_img = (img_start(:,:,color)-img_end(:,:,color))./(end_idx-start_idx+1);

prev_img = img_start(:,:,color);

[M,N] = size(prev_img);
var = size(M,N);

if(strcmp(arg1,'full'))
    patch_x = 1:M;
    patch_y = 1:N;
end

for i = start_idx:end_idx
    impath = sprintf(fileformat,i);
    img = double(imread(impath));
    
    var = var + (mean_diff_img - (prev_img - img(:,:,color))).^2;
    prev_img = img(:,:,color);
    
    mean_img = mean_img+prev_img;
    fprintf('Iter %d\n',i - start_idx + 1);
end

var = var./(end_idx-start_idx);
mean_img = mean_img./(end_idx-start_idx+1);

selection = zeros(M,N);
selection = logical(selection ~= 0);
selection(patch_x,patch_y) = 1;
selection(mean_img>240) = 0;

figure,scatter(mean_img(selection),mean_diff_img(selection),'.'), title('\mu vs. Intensity');
figure,scatter(mean_img(selection),var(selection),'.'), title('\sigma^2 vs. Intensity');

u1 = (mean_diff_img  + var)/2;
u2 = (-mean_diff_img + var)/2;

u1_out = u1(selection);
u2_out = u2(selection);
I_out = mean_img(selection);

%figure,scatter(mean_img(selection),u1(selection),'.'), title('\mu^{(1)} vs. Intensity');
%figure,scatter(mean_img(selection),u2(selection),'.'), title('\mu^{(2)} vs. Intensity');

% u1_i = u1./img_start;

% figure, imshow(u1_i,[]);
end