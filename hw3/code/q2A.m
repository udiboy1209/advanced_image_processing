% Code for Q.2A

psi = randn(64,128);

% Generate 200 test patches
patches = generate_from_psi(psi, 2000);

test_cs_matrix(psi, patches);