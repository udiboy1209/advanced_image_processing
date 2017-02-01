d5 = double(imread('data/d5.jpg'))/255;
all_patch_variance(d5);

d6 = double(imread('data/d6.png'))/255;
all_patch_variance(d6);

dt = 10^-4;
a = 0.005;
b = 0.14;
t = a:dt:b; % a -> b

dI = 10^-3;
Ivals = 0:dI:1;
PI = zeros(size(Ivals));

for i = 1:size(Ivals,2)
    I = Ivals(i);
    val = sum(exp(bsxfun(@rdivide,-I^2,(2*t)))./sqrt(t) * dt);
    PI(i) = val/sqrt(2*pi)/b;
end

PI = [fliplr(PI) PI(2:end)]; % take mirror image for extending in negative axis
Ivals = [-fliplr(Ivals) Ivals(2:end)];

g = fit(Ivals.', PI.','gauss1');
Gvals = g(Ivals);

figure;
plot(Ivals,[PI;Gvals']);
title('P(I) with Gaussian fit curve');