% Code for Q.2C

[train_ims,test_ims] = read_images('BSDS300/images/train');

% learned psi
psi = learn_ksvd(train_ims);

patches = generate_from_psi(psi,2000);

test_cs_matrix(psi, patches);

test_cs_matrix(psi, test_ims);
