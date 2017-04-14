addpath ./l1_ls_matlab
img1 = imread('../data/t1_icbm_normal_1mm_pn0_rf20_rawb.png');
img2 = imread('../data/t1_icbm_normal_1mm_pn3_rf20_rawb.png');
[R_1,R_2,angles_1,angles_2] = get_tom_projections(img1,img2);
R_1_vec = reshape(R_1, 259*18,1);
R_2_vec = reshape(R_2, 259*18,1);

[M,N] = size(img1);

%Filtered Back Projection
fil_back_rad_img1 = iradon(R_1,angles_1,'linear','Ram-Lak',1,180);
fil_back_rad_img2 = iradon(R_2,angles_2,'linear','Ram-Lak',1,180);

figure, imshow(uint8(fil_back_rad_img1));
figure, imshow(uint8(fil_back_rad_img2));

%CS part (b)

lambda = 0.01;
RU_1 = RU_mat(M,N,angles_1);
RU_1_t = RU_mat_t(M,N,angles_1);

RU_2 = RU_mat(M,N,angles_2);
RU_2_t = RU_mat_t(M,N,angles_2);

[cs_img1,cs_stat_1] = l1_ls(RU_1,RU_1_t,length(R_1_vec),M*N,R_1_vec,lambda,100);
[cs_img2,cs_stat_2] = l1_ls(RU_2,RU_2_t,length(R_2_vec),M*N,R_2_vec,lambda,100);

img1_r = dct2(reshape(cs_img1,M,N));
img2_r = dct2(reshape(cs_img2,M,N));

figure, imshow(uint8(img1_r));
figure, imshow(uint8(img2_r));

% CS part (c) multiple slices

RU2 = RU2_mat(M,N,angles_1,angles_2);
RU2_t = RU2_mat_t(M,N,angles_1,angles_2);

R_vec = [R_1_vec; R_2_vec];
[cs_img_comb,cs_stat_comb] = l1_ls(RU2,RU2_t,length(R_vec),M*N*2,R_vec,lambda,100);

img_comb_1 = cs_img_comb(1:M*N);
img_comb_2 = cs_img_comb(M*N+1:end) + img_comb_1;

img_comb1_r = dct2(reshape(img_comb_1,M,N));
img_comb2_r = dct2(reshape(img_comb_2,M,N));

figure, imshow(uint8(img_comb1_r));
figure, imshow(uint8(img_comb2_r));