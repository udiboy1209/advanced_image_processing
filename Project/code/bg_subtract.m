% dataset_format = '../data/junction_dataset/image_00/data/%.10d.png';
% dataset_format = '../data/yas_background_modelling_GroundtruthSeq/RawImages/seq00.avi%0.4d.bmp';

dataset_format = 'datasets/dataset_cannon/synth_bg_sub/img%d.png';

data_dir = 'datasets/dataset_cannon/synth_bg_sub/img%d.png';
mask_dir = 'datasets/dataset_cannon/synth_bg_sub/mask_dir/mask%d.png';

si = 1000;
ei = 2000;
color = 1:3;

%[u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,'full');
%[m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);


img_bg = double(imread(sprintf(data_dir,1)));
% img_bg = img_bg(:,:,1);

% figure;
for im = 400:400
    img1 = double(imread(sprintf(data_dir,im)));
%     img1 = img1(:,:,color);

    %p = zeros(size(img1));

    [M,N,C] = size(img1);
    fg_mask = zeros(M,N);

    for cidx = 1:numel(color)
        c = color(cidx);
        Ibg = img_bg(:,:,c);
        Ifg = img1(:,:,c);
        diff = Ifg-Ibg;
        u1 = m1(c)*Ibg + c1(c);
        u2 = m2(c)*Ibg + c2(c);
        bessel = bsxfun(@besseli,abs(diff),2*sqrt(u1.*u2));

        p = exp(-u1-u2).*(u1./u2).^(diff/2).*bessel;
        fg_mask(p<5e-10) = 1;
        
        %surf(-log10(p));
        %pause;
    end
    
    imwrite(fg_mask, sprintf(mask_dir,im));
    fprintf('Iter %d\n',im);%     figure,imshow(fg_mask);
end