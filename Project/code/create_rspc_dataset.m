close all;
dark_ratio = 1;
synth_img = create_synth_dataset();
resize_ratio = 8;
synth_img = synth_img(1:resize_ratio:end,1:resize_ratio:end,:);
synth_img = synth_img/dark_ratio;

data_dir = '/media/arktheshadow/Windows/dataset_cannon/rspc/img%d.png';

[M,N,C] = size(synth_img);
synth_r = synth_img(:,:,1);
synth_g = synth_img(:,:,2);
synth_b = synth_img(:,:,3);
m = M*N/2;
n = M*N;
y1 = zeros(m,1,C);
y2 = zeros(m,1,C);
y = zeros(m,1,C);
phi_1 = randi([0 1],m,n);
phi_2 = ~phi_1;

scale = 1/50;

for iter = 1:3
    y1(:,:,1) = phi_1*synth_r(:);
    y1(:,:,2) = phi_1*synth_g(:);
    y1(:,:,3) = phi_1*synth_b(:);
    
    y1_pois = y1 + poissrnd(scale*y1) - scale*y1;

    
    y2(:,:,1) = phi_2*synth_r(:);
    y2(:,:,2) = phi_2*synth_g(:);
    y2(:,:,3) = phi_2*synth_b(:);
    
    y2_pois = y2 + poissrnd(scale*y2) - scale*y2;
    
    y(:,:,1) = mat2gray(double(y1(:,:,1) - y2(:,:,1)));
    
    y(:,:,2) = mat2gray(double(y1(:,:,2) - y2(:,:,2)));
    
    y(:,:,3) = mat2gray(double(y1(:,:,3) - y2(:,:,3)));
    
%     imwrite(mat2gray(y), sprintf(data_dir,iter));
%     fprintf('Iter %d\n',iter);
        figure; imshow(reshape(y,[M/2,N,C]),[]);
    
end
