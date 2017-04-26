dark_ratio = 1;
synth_img = create_synth_dataset();
synth_img = imresize(synth_img,1/4);
synth_img = synth_img/dark_ratio;

data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_bg_sub/img%d.png';

a = 255/dark_ratio;
scale = 1/50;
width = 10;
for iter = 1:1000
%     poisson_synth_img = poissrnd(synth_img); 
    synth_img2 = synth_img;
    if (iter > 150 && iter < 168)
        synth_img2(20:40,(iter-150)*width + 1 : (iter-150 + 1)*width,:) = 5;
    end

%     poisson_synth_img = synth_img2;
    poisson_synth_img = synth_img2 + poissrnd(scale*synth_img2) - scale*synth_img2;

    imwrite(uint8(poisson_synth_img), sprintf(data_dir,iter));
    fprintf('Iter %d\n',iter);
%     figure;
%     imshow(uint8(poisson_synth_img));
end
