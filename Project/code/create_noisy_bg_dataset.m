dark_ratio = 1;
synth_img = create_synth_dataset();
synth_img = imresize(synth_img,1/4);
synth_img = synth_img/dark_ratio;

data_dir = 'datasets/dataset_cannon/synth_bg_sub/img%d.png';

a = 255/dark_ratio;
scale = 1/50;
width = 10;
height = 20;

[M,N,C] = size(synth_img);

frame_count = 20;
for iter = 1:5000
%     poisson_synth_img = poissrnd(synth_img); 
    synth_img2 = synth_img;
    
    if (iter >= 450 && iter <= 650)
        y = ((iter-450)/frame_count);
        y = floor(M*frame_count*y/200);

        x = mod((iter-450),frame_count);
        x = floor(N*x/frame_count);
        
        synth_img2(y+1:min(y+height,M),x+1:min(x+width,N),1) = y*100/M;
        synth_img2(y+1:min(y+height,M),x+1:min(x+width,N),2) = 100-y*100/M;
        synth_img2(y+1:min(y+height,M),x+1:min(x+width,N),3) = y*100/M;
    end

%     poisson_synth_img = synth_img2;
    poisson_synth_img = synth_img2 + poissrnd(scale*synth_img2) - scale*synth_img2;

    imwrite(uint8(poisson_synth_img), sprintf(data_dir,iter));
    fprintf('Iter %d\n',iter);
%     figure;
%     imshow(uint8(poisson_synth_img));
end
