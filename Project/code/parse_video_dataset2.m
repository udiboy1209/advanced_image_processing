function [mean_img,mean_diff_img,var,M,N] = parse_video_dataset2(fileformat,start_idx,end_idx,color)



img_start = double(imread(sprintf(fileformat,start_idx)));

prev_img = img_start(:,:,color);
mean_img = img_start(:,:,color);
mean_diff_img = img_start(:,:,color);

[M,N] = size(img_start);
var = size(M,N);

pt_r = 100;
pt_c = 100;

val_at_ij = zeros(1,end_idx - start_idx + 1);
val_at_ij(1) = img_start(pt_r,pt_c);
diff_at_ij = zeros(1,end_idx - start_idx);

for i=start_idx+1:end_idx
    impath = sprintf(fileformat,i);
    curr_img = double(imread(impath));
    curr_img = curr_img(:,:,color);
    mean_diff_img = mean_diff_img + curr_img - prev_img;
    val_at_ij(i-start_idx + 1) = curr_img(pt_r,pt_c);
    diff_at_ij(i-start_idx) = curr_img(pt_r,pt_c) - prev_img(pt_r,pt_c);
    prev_img = curr_img;
    mean_img = mean_img + curr_img;
end
mean_img = mean_img./(end_idx - start_idx+1);

mean_diff_img = mean_diff_img./(end_idx - start_idx);

prev_img = img_start(:,:,color);
for i = start_idx+1:end_idx
    impath = sprintf(fileformat,i);
    curr_img = double(imread(impath));
    curr_img = curr_img(:,:,color);
    var = var + ((curr_img - prev_img) - mean_diff_img).^2;
    fprintf('Iter %d\n',i);
end
var = var./(end_idx-start_idx - 1);

end