function [ ] = plot_off_diagonal( phi,psi )
%PLOT_OFF_DIAGONAL Summary of this function goes here
%   Detailed explanation goes here

D = phi*psi;
D_norm = normc(D);
G1 = D'*D;
G = D_norm'*D_norm;
I = eye(size(G));
G_offdiag = G(~I);
G1_offdiag = G1(~I);
% N = hist(abs(G_offdiag(:)),100);
% figure;
N = histogram(abs(G_offdiag(:)),100);
% N = histogram(abs(G1(:)),100);
% N = histogram(abs(G1_offdiag(:)),100);
% N = hist(abs(G1_offdiag(:)),100);
% figure, plot(N);
end

