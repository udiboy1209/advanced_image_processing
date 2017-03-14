function [ examples ] = generate_from_psi( psi, n_examples )
%GENERATE_FROM_PSI Summary of this function goes here
%   Detailed explanation goes here

[M,N] = size(psi);  

examples = zeros(M,n_examples);

for i = 1:n_examples
    rand_col_ind = randi(N,5,1);
    rand_weight = randn(5,1);
    psi_rand_cols = psi(:,rand_col_ind);
    
    examples(:,i) = psi_rand_cols * rand_weight;
end

