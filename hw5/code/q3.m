addpath ./l1_ls_matlab
img1 = imread('../data/t1_icbm_normal_1mm_pn0_rf20_rawb.png');
img2 = imread('../data/t1_icbm_normal_1mm_pn3_rf20_rawb.png');
[R_1,R_2,angles_1,angles_2] = get_tom_projections(img1,img2);

%Filtered Back Projection
fil_back_rad_img1 = iradon(R_1,angles_1,'linear','Ram-Lak',1,180);
fil_back_rad_img2 = iradon(R_2,angles_2,'linear','Ram-Lak',1,180);

%CS
[sz_img1_m,sz_img1_n] = size(img1);
U = kron(dctmtx(sz_img1_m)',dctmtx(sz_img1_m)');
lambda = 1;
RU_1 = get_RU(U,size(R_1,1),angles_1);
RU_2 = get_RU(U,size(R_2,1),angles_2);
[cs_img1,cs_stat_1] = l1_ls(RU_1,R_1,lambda,0.01);
[cs_img2,cs_stat_2] = l1_l2(RU_2,R_2,lambda,0.01);