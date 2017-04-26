% data_dir = '../data/synth_data_dark/img%d.png';
% data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_dark/img%d.png';
% data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_bright/img%d.png';
data_dir = '/media/arktheshadow/Windows/dataset_cannon/synth_10k_dark_slope_change/img%d.png';

si = 1;
ei = 1000;
color = 1;
lim_y = 40;
% 
[u1_vals,u2_vals,I_vals] = parse_video_dataset(data_dir,si,ei,color,100:200,750:1050,'full');
% [mean_img,mean_diff_img,var,M,N] = parse_video_dataset2(data_dir,si,ei,color);
% 
% u1_vals = (mean_diff_img + var)./2;
% u1_vals = u1_vals(:);
% u2_vals = (-mean_diff_img + var)./2;
% u2_vals = u2_vals(:);
% I_vals = mean_img(:);



figure;scatter(I_vals, u1_vals,'.'),title('\mu^{(1)} vs Intensity');
xlim([0 255]);
ylim([0 lim_y]);
figure;scatter(I_vals, u2_vals,'.'),title('\mu^{(2)} vs Intensity');
xlim([0 255]);
ylim([0 lim_y]);

% p = zeros(1,1000);
% for i = 1:length(p)
%     p(i) = poissrnd(10);
%     
% end
% mean = sum(p)/length(p);
% var1 = sum(p.^2)/length(p) - (sum(p)/length(p))^2;
% var2 = sum(p.^2)/length(p) - mean.^2;
% p2 = p - mean;
% var3 = sum(p2.^2)/length(p);