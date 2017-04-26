dark_ratio = 1;
synth_img = create_synth_dataset();
% synth_img = imresize(synth_img,1/4);
synth_img = synth_img(1:4:end,1:4:end,:);
synth_img = synth_img/dark_ratio;
% data_dir = '../data/synth_data_dark/img%d.png';
% data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_bright/img%d.png';
data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_dark_slope_change/img%d.png';

a = 255/dark_ratio;
scale = 1/50;
for iter = 1:10000
%     poisson_synth_img = poissrnd(synth_img);
    poisson_synth_img = synth_img + poissrnd(scale*synth_img) - scale*synth_img;
    imwrite(uint8(poisson_synth_img), sprintf(data_dir,iter));
    fprintf('Iter %d\n',iter);
%     figure;
%     imshow(uint8(poisson_synth_img));
end
