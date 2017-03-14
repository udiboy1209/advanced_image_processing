% Code for Q.2C

[train_ims,test_ims] = read_images('BSDS300/images/train');

% learned psi
%B part
psi = learn_ksvd(train_ims);
psi_images = col2im(psi,[8 8],[64 128],'distinct');
figure; imshow(psi_images); title('Psi columns as images');

%C part
patches = generate_from_psi(psi,2000);
relError1 = test_cs_matrix(psi, patches);
%D part
relError2 = test_cs_matrix(psi, test_ims);
