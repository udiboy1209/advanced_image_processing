close all;

dataset_format = 'datasets/own_dataset/canon_images_stable/005.png';
img = double(imread(sprintf(dataset_format,1)));
figure, imshow(uint8(img));
patch = img(115:150, 201:250, :);

u1r = zeros(1,6);
u1g = zeros(1,6);
u1b = zeros(1,6);

for disp = 1:6
    [mu,var,I] = get_mu_s(patch,disp,2);
    u1 = (mu+var)/2;
    u2 = (-mu+var)/2;
    
    u1r(disp) = u1(1);
    u1g(disp) = u1(2);
    u1b(disp) = u1(3);
end

figure;
plot(1:6,u1r,'-xr'); hold on;
plot(1:6,u1g,'-xg');
plot(1:6,u1b,'-xb'); hold off;
