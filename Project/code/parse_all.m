dataset_format = '/media/arktheshadow/Windows/dataset_cannon/very_stable_img/IMG_%0.4d.CR2';
si = 931;
ei = 1174;
color = 1;

% [u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,956:1564,1148:1704,'select');

[mean_img,mean_diff_img,var,M,N] = parse_video_dataset2(dataset_format,si,ei,color);
% patch_x = 956:1564;
% patch_y = 1148:1704;
patch_x = 1666:2282;
patch_y = 1155:1708;
% patch_x = 1:M;
% patch_y = 1:N;
selection = zeros(M,N);
selection = logical(selection ~= 0);


selection(patch_x,patch_y) = 1;
selection(mean_img>240) = 0;

% axis([0 255 0 40]);

figure,scatter(mean_img(selection),mean_diff_img(selection),'.'), title('\mu vs. Intensity');
xlim([0 255]);
ylim([0 40]);
figure,scatter(mean_img(selection),var(selection),'.'), title('\sigma^2 vs. Intensity');
xlim([0 255]);
ylim([0 40]);

u1 = (mean_diff_img  + var)/2;
u2 = (-mean_diff_img + var)/2;

u1_vals = u1(selection);
u2_vals = u2(selection);
I_vals = mean_img(selection);

figure;scatter(I_vals, u1_vals,'.'),title('\mu^{(1)} vs Intensity');
xlim([0 255]);
ylim([0 40]);
figure;scatter(I_vals, u2_vals,'.'),title('\mu^{(2)} vs Intensity');
xlim([0 255]);
ylim([0 40]);
% [m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);
