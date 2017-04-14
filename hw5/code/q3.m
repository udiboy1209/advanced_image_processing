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

%CS

% U = kron(dctmtx(patch_size)',dctmtx(patch_size)');

lambda = 0.01;
%RU_1 = get_RU(U,size(R_1,1),angles_1);
%RU_2 = get_RU(U,size(R_2,1),angles_2);
RU_1 = RU_mat(M,N,angles_1);
RU_1_t = RU_mat_t(M,N,angles_1);

RU_2 = RU_mat(M,N,angles_2);
RU_2_t = RU_mat_t(M,N,angles_2);

[cs_img1,cs_stat_1] = l1_ls(RU_1,RU_1_t,length(R_1_vec),M*N,R_1_vec,lambda,0.01);
[cs_img2,cs_stat_2] = l1_ls(RU_2,RU_2_t,length(R_2_vec),M*N,R_2_vec,lambda,0.01);

img1_r = dct2(reshape(cs_img1,M,N));
img2_r = dct2(reshape(cs_img2,M,N));

figure, imshow(img1_r);
figure, imshow(img2_r);