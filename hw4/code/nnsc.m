close all;
tic;
[Y,W,H,img2,img_noisy] = get_YWH();
[W_fin,H_fin] = projected_grad_descent(Y,W,H);
[img_f] = get_final_image(img2,img_noisy,Y,W_fin,H_fin);
toc;
% figure;
% imshow(img,[]);
