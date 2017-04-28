function [ mu_s, var_s, I ] = get_mu_s( patch, disp, dir)
%GET_MU_S Summary of this function goes here
%   Detailed explanation goes here
if(nargin == 1)
    disp = 1;
    dir = 2;
end

[~,~,C] = size(patch);

patch_shifted_x = circshift(patch,disp,dir);

mu_s = zeros(1,C);
var_s = zeros(1,C);
I = zeros(1,C);

for c = 1:C
    d_x = patch(:,disp+1:end,c) - patch_shifted_x(:,disp+1:end,c);

    mu_s(c) = mean(d_x(:));
    var_s(c) = var(d_x(:));
    I(c) = mean(mean(patch(:,:,c)));
end

end

