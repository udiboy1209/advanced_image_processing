function [ ] = plot_off_diagonal( phi,psi )
%PLOT_OFF_DIAGONAL Summary of this function goes here
%   Detailed explanation goes here

D = phi*psi;
D_norm = normc(D);
G = D_norm'*D_norm;
I = eye(size(G));
G_offdiag = G(~I);
N = hist(abs(G_offdiag(:)),100);

figure, plot(N);
end

