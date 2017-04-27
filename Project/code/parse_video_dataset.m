function [u1_out,u2_out,I_out] = parse_video_dataset(fileformat,start_idx,end_idx,colors,crop,patch_x, patch_y)
if (nargin == 4)
    crop = 'full';
end

img_start = double(imread(sprintf(fileformat,start_idx)));
img_end = double(imread(sprintf(fileformat,end_idx)));

[M,N,C] = size(img_start);

if(strcmp(crop,'full'))
    patch_x = 1:M;
    patch_y = 1:N;
end

selection = zeros(M,N);
selection = logical(selection ~= 0);

selection(patch_x,patch_y) = 1;
selection(img_start(:,:,1)>240 | img_start(:,:,2)>240 | img_start(:,:,3)>240) = 0;

num_elems = sum(sum(selection));

u1_out = zeros(num_elems,numel(colors));
u2_out = zeros(num_elems,numel(colors));
I_out = zeros(num_elems,numel(colors));

for cidx = 1:numel(colors)
    color = colors(cidx);
    if color == 1
        colname = '.r';
    elseif color == 2
        colname = '.g';
    else
        colname = '.b';
    end
    
    mean_img = img_start(:,:,color);
    mean_diff_img = (img_start(:,:,color)-img_end(:,:,color))./(end_idx-start_idx+1);

    prev_img = img_start(:,:,color);
    var = size(M,N);

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

    figure,scatter(mean_img(selection),mean_diff_img(selection),colname), title('\mu vs. Intensity');
    figure,scatter(mean_img(selection),var(selection),colname), title('\sigma^2 vs. Intensity');

    u1 = (mean_diff_img  + var)/2;
    u2 = (-mean_diff_img + var)/2;

    u1_out(:,color) = u1(selection);
    u2_out(:,color) = u2(selection);
    I_out(:,color) = mean_img(selection);
end