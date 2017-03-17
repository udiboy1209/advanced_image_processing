function [ Dksvd ] = learn_ksvd( examples )
%LEARN_KSVD Summary of this function goes here
%   Detailed explanation goes here
addpath ./ksvdbox13
addpath ./ompbox10

% dictionary dimensions
n = 64;
m = 128;

% epsilon
e = 1;

% sparsity
k = 5;

params.data = examples;
% params.Edata = e;
params.Tdata = k;
params.dictsize = m;
params.iternum = 30;
params.memusage = 'low';

[Dksvd,g,err] = ksvd(params,'');

figure; plot(err); title('K-SVD error convergence');
xlabel('Iteration'); ylabel('RMSE');

fprintf('  Dictionary size: %d x %d', n, m);

rmpath ./ksvdbox13
rmpath ./ompbox10
end

