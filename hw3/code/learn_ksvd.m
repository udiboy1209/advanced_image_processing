function [ Dksvd ] = learn_ksvd( examples )
%LEARN_KSVD Summary of this function goes here
%   Detailed explanation goes here
addpath ./ksvdbox13
addpath ./ompbox10

% dictionary dimensions
n = 64;
m = 128;

% sparsity of each example
k = 5;

params.data = examples;
params.Tdata = k;
params.dictsize = m;
params.iternum = 30;
params.memusage = 'high';

[Dksvd,g,err] = ksvd(params,'');

figure; plot(err); title('K-SVD error convergence');
xlabel('Iteration'); ylabel('RMSE');

printf('  Dictionary size: %d x %d', n, m);

rmpath ./ksvdbox13
rmpath ./ompbox10
end
