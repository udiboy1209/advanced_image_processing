function [radon_img1,radon_img2,angles_1,angles_2] = get_tom_projections(img1,img2)
    angles_1 = randsample(0:1:180,18);
    angles_2 = randsample(0:1:180,18);
    radon_img1 = radon(img1,angles_1);
    radon_img2 = radon(img2,angles_2);
end
