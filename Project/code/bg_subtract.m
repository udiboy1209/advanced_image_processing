% dataset_format = '../data/junction_dataset/image_00/data/%.10d.png';
% dataset_format = '../data/yas_background_modelling_GroundtruthSeq/RawImages/seq00.avi%0.4d.bmp';

dataset_format = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_dark_slope_change/img%d.png';

data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_bg_sub/img%d.png';
mask_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_bg_sub/mask_dir/mask%d.png';

si = 1;
ei = 10000;
color = 1;

% [u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,100:200,750:1050,'full');
% [m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);


img_bg = double(imread(sprintf(data_dir,1)));
img_bg = img_bg(:,:,1);

for im = 1:1000
% for im = 1:1000
    img1 = double(imread(sprintf(data_dir,im)));
    img1 = img1(:,:,color);

    fg_mask = zeros(size(img1));

    [M,N,C] = size(img1);

    for i=1:M
        for j=1:N
            Ibg = img_bg(i,j,color);
            Ifg = img1(i,j,color);
            diff = Ifg-Ibg;
            u1 = m1*Ibg + c1;
            u2 = m2*Ibg + c2;

            p = exp(-u1-u2)*(u1/u2)^(diff/2)*besseli(abs(diff),2*sqrt(u1*u2));
            if p<0.00005
                fg_mask(i,j) = 1;
            end
        end
    end
    
%     imwrite(fg_mask, sprintf(mask_dir,im));
    fprintf('Iter %d\n',im);%     figure,imshow(fg_mask);
end