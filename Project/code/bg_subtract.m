dataset_format = '../data/junction_dataset/image_00/data/%.10d.png';
si = 0;
ei = 83;
color = 1;

[u1_vals,u2_vals,I_vals] = parse_video_dataset(dataset_format,si,ei,color,100:200,750:1050);
[m1,c1,m2,c2] = linefit(u1_vals,u2_vals,I_vals);


img_bg = double(imread(sprintf(dataset_format,83)));

for im = 0:20:82
    img1 = double(imread(sprintf(dataset_format,im)));

    fg_mask = zeros(size(img1));

    [M,N,C] = size(img1);

    for i=1:M
        for j=1:N
            Ibg = img_bg(i,j,color);
            Ifg = img1(i,j,color);
            diff = Ifg-Ibg;
            u1 = m1*Ibg + c1;
            u2 = m2*Ibg + c2;

            p = exp(-u1-u2)*(u1/u2)^(diff/2)*besseli(abs(diff),2*sqrt(u1*u2));
            if p<0.00005
                fg_mask(i,j) = 1;
            end
        end
    end
    figure,imshow(fg_mask);
end