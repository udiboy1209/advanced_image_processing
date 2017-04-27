close all;
img_spatial = imread('/media/arktheshadow/Windows/dataset_cannon/synth_10k_dark_slope_change/img1.png');
color = 1;
img_spatial = img_spatial(:,:,color);
img_spatial = double(img_spatial);
mean_vals = [];
sigma_s2_vals = [];
u1_vals = [];
u2_vals = [];
I_vals = [];
for i=0:23
    img_input = img_spatial( floor(i/6) * 30 + 1: (floor(i/6) + 1)*30, mod(i,6)*30 + 1: (mod(i,6)+1) * 30);
    [mean_s] = get_mean_s(img_input);
    [u1_val,u2_val,I_val,sigma_s2] = get_uI(img_input,mean_s);
    mean_vals = [mean_vals mean_s];
    sigma_s2_vals = [sigma_s2_vals sigma_s2];
    u1_vals = [u1_vals u1_val];
    u2_vals = [u2_vals u2_val];
    I_vals = [I_vals I_val];
end


lim_y = 10;
lim_x = 255;
figure;scatter(I_vals, mean_vals,'.'),title('\sigma^2 vs Intensity');
xlim([0 lim_x]);
ylim([0 lim_y]);
figure;scatter(I_vals, sigma_s2_vals,'.'),title('\mu vs Intensity');
xlim([0 lim_x]);
ylim([0 lim_y]);
figure;scatter(I_vals, u1_vals,'.'),title('\mu^{(1)} vs Intensity');
xlim([0 lim_x]);
ylim([0 lim_y]);
figure;scatter(I_vals, u2_vals,'.'),title('\mu^{(2)} vs Intensity');
xlim([0 lim_x]);
ylim([0 lim_y]);