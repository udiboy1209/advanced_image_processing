img_start = double(imread('datasets/image_00/data/0000000069.png'));
img_end = double(imread('datasets/image_00/data/0000000119.png'));

mean_img = (img_start-img_end)./50;

prev_img = img_start;

[M,N] = size(prev_img);
var = size(M,N);

for i = 70:119
    impath = sprintf('datasets/image_00/data/0000000%.3d.png',i);
    img = double(imread(impath));
    
    var = var + (mean_img - (prev_img - img)).^2;
    prev_img = img;
end

var = var./49;

selection = zeros(M,N,'logical');
selection(:,:) = 1;

figure,scatter(img_start(selection),mean_img(selection),'.');
figure,scatter(img_start(selection),var(selection),'.');

u1 = (mean_img + var)/2;

figure,scatter(img_start(selection),u1(selection),'.');