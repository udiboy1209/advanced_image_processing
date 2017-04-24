% img3 = imread('../data/canon_images_stable/3.png');
img3 = imread('../data/yas_background_modelling_GroundtruthSeq/RawImages');
[m,n,p] = size(img3);
%%Trying for img3 to img 26
mu_s = 0;
sigma_s2 = 0;
n=0;
rows = 135:183;
cols = 115:160;
img4 = img3(rows,cols);
[m1,n1] = size(img4);
for row=1:m1-1
    for col=1:n1-1
        mu_s = mu_s + img4(row,col) - img4(row+1,col+1); 
        n = n +1;
    end
end
mu_s = mu_s/n;
for row=1:m1-1
    for col =1:n1-1
        sigma_s2 = sigma_s2 + (mu_s - (img4(row,col) - img4(row+1,col+1)))^2;
    end
end

sigma_s2 = sigma_s2/(n-1);

mu_1 = (mu_s + sigma_s2)/2;
