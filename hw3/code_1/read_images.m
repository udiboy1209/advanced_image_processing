function [ images, test_ims ] = read_images( folderpath )

D = dir(folderpath);
images = zeros(64,2400*30);
test_ims = zeros(64,2400*10);

for i = 3:32
    impath = sprintf('%s/%s',folderpath,D(i).name);
    im = imread(impath);
    im = double(rgb2gray(im));
    
    [M,N] = size(im);
    numpatches = floor(M/8)*floor(N/8);
    patch_vec = zeros(64,numpatches);
    l=1;
    
    for j = 1:8:floor(M/8)*8-8
        for k = 1:8:floor(N/8)*8-8
            patch = im(j:j+7, k:k+7);
            patch_vec(:,l) = reshape(patch,64,1);
            l = l + 1;
        end
    end
    
    images(:,2400*(i-3)+1:2400*(i-3)+2400) = patch_vec;
end

for i = 33:42
    impath = sprintf('%s/%s',folderpath,D(i).name);
    im = imread(impath);
    im = double(rgb2gray(im));
    
    [M,N] = size(im);
    numpatches = floor(M/8)*floor(N/8);
    patch_vec = zeros(64,numpatches);
    l=1;
    
    for j = 1:8:floor(M/8)*8-8
        for k = 1:8:floor(N/8)*8-8
            patch = im(j:j+7, k:k+7);
            patch_vec(:,l) = reshape(patch,64,1);
            l = l + 1;
        end
    end
    
    test_ims(:,2400*(i-33)+1:2400*(i-33)+2400) = patch_vec;
end

end

