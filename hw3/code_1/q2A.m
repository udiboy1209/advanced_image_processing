
% Code for Q.2A

psi = randn(64,128);
psi = normc(psi);

% Generate 200 test patches
patches = generate_from_psi(psi, 2000);

test_cs_matrix(psi, patches);